Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F5ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiIBJSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiIBJSA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:18:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C91CC305
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662110238;
        bh=yl70vyOh9mm34qK9ZVmFLmVj+Nu8mQMseRqk5QYL9Vw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aYWsoBsPHmP8qBI8gLQ8gIM2BEDPSnAslFNe4m+2bQcDYptIHL6fQJiucxF23QmJf
         kmsliGVq/6y5SpQpPsZuZDap/JdcdyMd/2crAmAGZnmewfqBG79JQ3mbISv48+GgbK
         YbekFDf8QENuf7IRQIaF9YgDsQoxGaSEwi/pd97E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1ouxLw0giI-00R05p; Fri, 02
 Sep 2022 11:17:18 +0200
Date:   Fri, 2 Sep 2022 11:17:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye <vdye@github.com>
cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 7/8] t/perf: add 'GIT_PERF_USE_SCALAR' run option
In-Reply-To: <72f6661d-be02-dbb8-7110-b8de6bac77f6@github.com>
Message-ID: <p78rqo9o-o1p2-qq6q-6oo4-94828so928nq@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <96e08a95265ea66839b439ce8abc50b34395aaa3.1661961746.git.gitgitgadget@gmail.com> <60p9nos4-n576-qqq2-p8n9-969sro247141@tzk.qr> <72f6661d-be02-dbb8-7110-b8de6bac77f6@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eYv6V8qye2WzK/aqM5fCUIqT6mxcUZihCOZU8zP6OTJ5dLmtKW5
 F20Gi8e4SplJB6TwHxYWUDLst07+YvovYx8j5GsPAlAAyNrZm1MaBx5HVjOkeEjBuY1v5nD
 pgA/XTS6U8gSS/aac+07B4pRp8DROiDP5SgPIMAbpCrE+yvOhxkcY6wmBvPef8N2VK1Dpit
 bE7BG+qhGeoFIKROq9b+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tcyMIADc5jw=:OWiRDBSQerlj02QqWQBCB/
 B/DODkv8YJb9WUb1ZF11kfnM8/w1oELPAGlYf1AaE1FU0ovaiAw0XlT31OG/LB6vrhbboOnZ+
 6uIsaMkF1oJoP+qr/afYPxQK2oCkQSbu+uDXPXAHcOMh34FBWyIx9i6Kt5yY3QtLHL4tnJWHC
 DOrcirc42F4fG79uStdPggE1tAm8bMzdF+cR7d9dFdhL1PTWCnRCyBpPMxQCHbYL8BDpmxpjI
 Gw+XFsjKQKFhkJ0tDYQ2Pe49sxFywark4gG7lHE+V/YiCm41EHX5Z4CEmu2tLr4jA5e7PwCmA
 hjpgMY6n2SLyNhEluL6LtRMwT+SO6YnFcq0BIBvvfRXytMZ22dD7BQqZQ58RQ5d3kncg5BPdD
 yMHVkvkvMeQjuORuO96pH/56WO4xTtiECI68LaltC2/+8fQiQ+dVCNCGICJbluXixdfOqAuGv
 DMGfmrLuo5xl8AP3+at2sgFBGqmnXrEs4wEDjLoMm91N3zDPMQdSkCZtM5XQzw77DSPSDlwHv
 QKtxz0PPT+twc9baAlUmlEfmCyWrFJspYC9GFnm1HAD8QEKcj4XYiKRhyUwjJp7VKp0lg3hiD
 fS3ii7FXif3c0GbYU6N+Z8p66nYAT+9cVJcXoakl/2pVttDk3QSiOBzFroB/W9wOb9Dzrw/LY
 wcYOPYlVayVpvZO2fJmFde3xGJxeLOTMnoqDnn684bGI6PALMvxDj9fTDqcXkNPCKIhrYvJWu
 05qigO0ZA5vttoY8kxb8d/OSqs6Cm5oPluK0rkUjLvZpp9W9Xvdt/wv+Vw3ruTsoSdjOj4cKS
 8F6lLOGrfPFB8vt9LAXLEU4ZuIbsey9IbXourjG6yDFoDhr7YiK517uHqzwgWiQjo+wUjn58S
 jNf9U/EfwWZcQE6DcYpR/ZZA5oq+ly9rWW/gY0oQUsIwE8ifnY53iuS9etMTrGtYA4mZUppVY
 04wm4QSbe4Wm/ekRqt4CPHcBQuoDzcmuD4277SNsnZPNaMHDvWGQanxURmfBgpApQht7HysSV
 kBrwd8OiCudFFiM7XRgu3P4/aM/0zjmyN6nV+qfgJh+UmAveAMNJEMx3jlsBD4zqz2DyAskOq
 dA6HQB4oPA01iMyMyxX0vP15CHzQm8EwZm8vPgsos1G2Qnf2dOXYpDGrATigpKw04DtdywT/8
 apTyS5/2iBedafJ/xYpYIAZQ4m
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Thu, 1 Sep 2022, Victoria Dye wrote:

> Johannes Schindelin wrote:
> >
> > On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> >
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Add a 'GIT_PERF_USE_SCALAR' environment variable (and corresponding p=
erf
> >> config 'useScalar') to register a repository created with any of:
> >>
> >> * test_perf_fresh_repo
> >> * test_perf_default_repo
> >> * test_perf_large_repo
> >>
> >> as a Scalar enlistment. This is intended to allow a developer to test=
 the
> >> impact of Scalar on already-defined performance scenarios.
> >
> > Great idea!
> >
> >> [...]
> >> @@ -130,7 +137,11 @@ test_perf_fresh_repo () {
> >>  	"$MODERN_GIT" init -q "$repo" &&
> >>  	(
> >>  		cd "$repo" &&
> >> -		test_perf_do_repo_symlink_config_
> >> +		test_perf_do_repo_symlink_config_ &&
> >> +		if test_bool_env "$GIT_PERF_USE_SCALAR" false
> >> +		then
> >> +			"$MODERN_SCALAR" register
> >
> > Do we need to unregister anything here? My guess is that no, the "glob=
al"
> > config we're using in tests is "$TRASH_DIRECTORY/.gitconfig", and the =
side
> > effect of scheduling the maintenance task won't matter in practice. Bu=
t I
> > might have missed something and we may want to have an explicit
> > `unregister` step.
> >
> > What's your take on this?
>
> As you guessed, a '.gitconfig' is created in the trash directory of each
> test containing the Scalar registration and I haven't seen any issues
> arising from the scheduled maintenance, so I don't think an 'unregister'=
 is
> necessary.

Thank you for checking!

> However, while verifying that, I noticed that the registration wasn't
> happening *at all* because 'test_bool_env' is currently being used
> incorrectly. The fix is straightforward - I'll make sure to correct it
> in the next version.

Oh, great, then my feedback was at least _somewhat_ helpful... ;-)

Ciao,
Dscho
