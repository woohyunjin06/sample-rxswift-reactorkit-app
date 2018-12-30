//
//  OnboardingFlow.swift
//  RxSwiftReactorKitSampleApp
//
//  Created by Clint on 30/12/2018.
//  Copyright © 2018 clintjang. All rights reserved.
//

import Foundation

final class Onboarding: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "OnBoarding"
        return viewController
    }()

    private let services: AppServices

    init(withServices services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? SampleStep else { return .none }

        switch step {
        case .intro:
            return navigationToOnboardingIntroScreen()
        default:
            return .none
        }
    }

    private func navigationToOnboardingIntroScreen() -> NextFlowItems {
        let onboardingIntroViewController = OnboardingIntroViewController.instantiate()
        onboardingIntroViewController.title = "Intro"
        self.rootViewController.pushViewController(onboardingIntroViewController, animated: false)

        return .one(flowItem: NextFlowItem(nextPresentable: onboardingIntroViewController,
                                           nextStepper: onboardingIntroViewController))
    }
}
