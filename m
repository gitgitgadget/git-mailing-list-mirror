Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D80C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC0A61251
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbhIXRaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbhIXRaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:30:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44024C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:28:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so43307944lfr.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ohd0zJ3VTll5BgbR3PrB7Oy4C8y0tKEb3ZJ7txzu1Mc=;
        b=gLMTvMOtRYDakDgW1WOxpVeyjlBHT9OqNVJyl6mDjexXcsaNO0vCDL5cT5U+EwYivF
         ZAQSXDy5YbISwrRyUnCJIrwX17MSA1mSdb4pioIzK6LrgVzLQScVEzXxqwNUi8a8lYtS
         SlF+Tqw4uE/S5Y7DaOyg57+FTg1D9wwR2IpjObMFC1v49EZF+GZX+FoT7TfxQsxh+n2f
         Jz/v7VEL5YTuTGokawC7b/s+D/QH0X+HG1YCmc+of+ijd5PhwAKCtg4cBQzCsDG0K5Qn
         qoombUlO5Mc1IKru23Owm6yCC74Z/Yn5RuVzIviYzF/Mi5vcwbkD4na9UajnhIlGBwNE
         dP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ohd0zJ3VTll5BgbR3PrB7Oy4C8y0tKEb3ZJ7txzu1Mc=;
        b=kxpO8NJYQqfJBGteqfLVOagIWTmZxTATtK6wwJPquPsNcZDxViQzX9HBcx3q6kVI+q
         YbceZcW6rSjplGHU3PpTByUfiw+rZ3EPKS/LN+1oQvLSF9evDo2O3GAwiAf9JmQ42HER
         dSeJl4BPx/MzoTtvICYi1QGZf77NdwydVddUHbWVpYssdqLo+D0t0D1aHtKl5ENbaieJ
         JHz9XkNVVWjad5ZgdckyoInugA18A3jaIFPuU1mrCAFr9VAofx7+86Bfml0IsbRc3YV6
         PQv/w4Mci4S5mfJBMVIHwc1srbgcyq+JQWG9TuSNp96W8sR4i8lo0cRmiE0PhhlpEofP
         4krw==
X-Gm-Message-State: AOAM530vqg2JtTQccdmf18+NY9qNNrRHtvAIujx9nzTDpXeoHakJqwQ9
        e+dmq8alNLsc5/DEMSU3T9q25KwRaOxMpdpdsQwtLw==
X-Google-Smtp-Source: ABdhPJw5trLKTnHBWdxPfj0sI/AO6mB6TRM4Rj96i1PwjVNo9+I9X2kmixgTCbqP+kyNHABz0fsUh/8qgUR3XTjM5PU=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr10621965lfu.240.1632504525367;
 Fri, 24 Sep 2021 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
In-Reply-To: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 24 Sep 2021 10:28:34 -0700
Message-ID: <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
Subject: Re: pull failed - why should I receive this message.
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 10:08 AM Russell, Scott <Scott.Russell2@ncr.com> wrote:
>
> Files not previously in git were added to git.   Why should I have to manually delete them?
> Why can git put not replace them?  They were untracked files that are now tracked  and so the git copy is desired.
> We can't always know ahead of time what files may have been added elsewhere.

To turn it around on you, you can't always know ahead of time what
files may have been added elsewhere, so you can't be sure that your
newly added untracked file locally will be safe from being overwritten
during a pull. How upsetting if you sink 30 hours into newlib.cpp and
then your teammate checks in their own newlib.cpp, and yours is
overwritten without asking when you run 'git pull'.

You might have some luck with the '--autostash' option, which would at
least prompt you whether to get rid of things when trying to merge
them back together during the automatic 'git stash pop' at the end. Or
you could run 'git clean --force' to automatically delete any
untracked files you might have - you could even alias yourself a
command like 'git dangerous-pull' which runs 'git clean -f && git
pull'.

>
>
> We need the pull to work automatically.
>
> error: The following untracked working tree files would be overwritten by merge:
>         Staging/CADDApps/CADDUIHelper/Source/Release/CADDUIHelper.exe
>         Staging/CADDApps/CADDUIHelper/Source/Release_Unicode/CADDUIHelper.exe
>         Staging/CADDApps/InstallDriversPackage/Release/InstallDriversPackage.exe
>         Staging/Common/NCRCommonCCLib/Source/Release/NCRCommonCCLibMsg.dll
>         Staging/Devices/NFC/Elatec_RFIDReader/Bin/Director.exe
>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/AppBlaster.exe
>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/flash.exe
>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DIFxAPI.dll
>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DriverForge.v4.5.4.exe
>         Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriverInstaller.exe
>         Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriverInstallerMsg.dll
>         Staging/Utilities64/SSPSWTaskMgr/Source/Release/SSPSWTaskMgr.exe

Or better yet, you could avoid checking in compiled binaries like
these and instead add them to your .gitignore, unless you really mean
to update them every time someone makes some change. When checking in
binaries, you should be aware of the additional disk overhead needed
to do so and take a look at some options Git has to mitigate that
overhead, like partial clone. However, in many cases the easiest way
to mitigate that overhead is to simply not check in binaries unless
you absolutely need them to be version controlled.

- Emily
