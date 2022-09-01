Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9038ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiIAJcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiIAJcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:32:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C91314D3
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662024760;
        bh=SuTYFdVT4EbH5RUe2tlrBqvPB+eOZsP5DApwle0oJfo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bCfEbcVd0t7D44eAmQjaLDPRCzMvUVhmFnF54IshdFIfzLWkn6+Ri0QzOB3sdEgqD
         N72KEPskSCSTQN11zQzg2wL0SNuPFFMkcYoX0W4tbhTVb+iIbiqJbGtVGfKcY4Yq6D
         h34TCEFxL4yeLsTv4osa/dsI+WNhq/wygErFwoCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1osaDz1yAd-00XrLl; Thu, 01
 Sep 2022 11:32:40 +0200
Date:   Thu, 1 Sep 2022 11:32:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 5/8] scalar-clone: add test coverage
In-Reply-To: <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <o429p430-sp18-rr20-p2ro-4r60qs2n83o5@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MPl8eI47VNpI/4YLUfRkaXs4II51zjBDTZscrQdz5kyrlJ6VN4B
 Jc1NnN73EKE9DEBECoRegSjYrdodasbRTrSB6Rbb74HTxcRV2fnz25L/fEu/BOv/+8D6cH6
 1ly5feWCGf6kEHbwR+79N/u98YBnYV7014fyls4RYCjqOIdz4Q7AEzKqCw/1pB+o7n9VMie
 VIzvICTojaPdt5UaIYMiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+pWlWRIJbY=:oGpkUaM6VlMUIpWfw/HVL2
 /cyVDyHAkejZf+7phnQaLTvOx0NzQd0sA/f+13Ui1SlHkQC46yQi7T11igKXUb26lxEUryCuZ
 avOedmQVGTsEFQLFn7MbxP32j5UsT2Fok2NznxjN3zE4wCRWeKsEtV+yL7ycYMvVivmTT1Qdx
 SQEzLO+pbRRaJdlwY9nQwvoPIf5nW8hzdv9rH3rSW6RddFk1jMquhunKexO05LN1QOf8egMvG
 SUaZby58GT7DEkaltPkoRFXKF38e3Z/bborLgeg1bOvz9U945bvzCtzCU1ydNOJ6eQmA7gjlv
 hOA+VMrrJANt4yJLeD7Q+EeoZDmr9yeSqo6xUmZwMhPkQ0QUHe2pI1Wj3Nq9UJRkyM4U+mlrl
 7lUMVntOsTo0FOVLdeVSc9pI6H3N6cChu17wRwuws6G0sKggWHDCXsBCKt1O2+FTpsIWpGPV8
 W+RxCIqZPrB9qhAMEIhrGuF27uIiENOvUHMJ2x75STYVGLRznI2EE30R5EJ9wiLlBdH29CcdT
 f5zOMleLB8cZxIPa4wpq7qgCEGqZKx4ZaM1q5B0wZu/8MvsGKZ1sUQN5lYcdm+0VcK6DL+jcQ
 GRBhzChBjuFinmf4KO1Ie30MdxfyY838abKNywlWhmkPighPuB1B9GuuCEsM9wbUV9lGILUu0
 kxaMMPJI1GsGV8dcNvdg5SR6gktLDRuqFn/U8A6jrBMab74illKAt0HEcr7Exsnw///giFIej
 nZb7f7bg5Dy/4OOMw4ViasQVdkLqlidinpQthY6F+ux83JL5bpXnloDCkdgHH3BQ0JJSS6WmV
 lFGdM15CkkyC5FNXR1Lz/XPSR0S6kFt0GDl7t/02uiho5jyfdRlM/c6hy3awG+m1nSKHoUwtG
 bLTkA66Ep68pnEJ5lH8xqEza6A1agFPKI/ck0Ugp3kxbaHpD4QybWcdq+t/QlbJHSO2wEOpZm
 +rn8tVMf4JCA3x9Qvd2wLq2ahXzMV7hL7Dqtwujr+sxi+kqjtZTRqDNJEoUsmjUIhkC79N7Ph
 30WdBCxe7Div2R29vsnUd22J0scuuJh4PgDejJU1Cn5gItj0xzJsY6DynueicmvzxhtzdRYg8
 eHFo8HQ65jxC8YToyLkbdCyin1G4pHgsy0donOKWKRgY7LCF0RNyy+5PFBcWaFA3Yt4h38jH0
 u9bfRSCUUSslECLX4V2zaD9b2w
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Create a new test file ('t9211-scalar-clone.sh') to exercise the options=
 and
> behavior of the 'scalar clone' command.

Great catch!

I have one suggestion, given my experience with debugging test failures:

> +test_expect_success 'creates content in enlistment root' '
> +	test_when_finished cleanup_clone cloned &&
> +
> +	scalar clone "file://$(pwd)/to-clone" cloned &&

This pattern of cloning into `cloned` and removing the directory when the
test case is done is repeated throughout this test script.

In instances where all test cases succeed, that poses no problem.

When running the test script with `-i`, also no problem.

But when we run into test failures in CI, those directories will be
removed before the workflow run can tar them up and upload them for later
inspection.

May I suggest an alternative strategy?

If we drop all those `test_when_finished cleanup_clone cloned` calls and
instead `scalar clone` into different directories (whose names reflect the
test cases' intended purpose), I could imagine having a much easier time
not only diagnosing but also reproducing and fixing test failures in the
future.

When discussing code review practices [*1*], we did not come up with any
standard terminology to describe what I am offering here, and I am unsure
how to label this in a catchy way. I want to present this suggestion for
you to consider, and I would be delighted if you take it, at the same time
I will happily let it go should you decide against it.

Ciao,
Dscho

Footnote *1*:
https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-08-29#l4=
8
