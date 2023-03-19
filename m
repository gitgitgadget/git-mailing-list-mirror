Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D816CC7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCSG1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCSG1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:27:51 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A432470E
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679207266; i=tboegi@web.de;
        bh=KNdyELhzEQASO2OX2l9QS9Fl6MFX6/6BEqfX7ZtqZEk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=sinR8+2EffJyOU0ikfToOK8Yowqkl1iuInVmOVHi9VzDgHnL9IbKJVVaPGlgwieKR
         H7YssuN+1FtUFBQKxXroa9LuMnTV8olD6j05hNh/b3HfxD4bvVARmZE9UdRbJbHwzD
         7wjhEWdBBYXFZtsqOqJJ3A+zGdpn1FJGczcothlUsu8XgEXs2+kfRWUXbtqM8zxbuN
         t1Sk2S5qrUo78T2CEqu2eum2bv9JxP1DXNXzv6+ybxDoJ7wYshDlEDUr/qgNFR0Qm7
         BH3122ep3Y4Kep367sjUi1AJKKmQrwQfJDb94EfyRrn1IztwfVTzSvm5DWH/0JS2ra
         15kaHmOhDcx5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1qOTji2XtG-00x17Y; Sun, 19
 Mar 2023 07:22:40 +0100
Date:   Sun, 19 Mar 2023 07:22:40 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     dooagain <dooagain@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git pull output and case sensitivity.
Message-ID: <20230319062239.w37x64knfhfapbsn@tb-raspi4>
References: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:s7Ksh5m/0kGMoGg/GXTrK+pApBsb6tA7YSLwZ9EqDFheuv6dlQn
 +co50w4a8MPDMDgiTflCXNmT7BnjgAinztkl7zUDjWXZTQW4R64vQItPGA//8WBXnK4+K+n
 vPizVt6lnTzAI/uCogU/RxhGBCOyiuS6GGC80emxLHhITbqnsfMW6E7YMQJ7l/Mc9ENm0lK
 FGLx+0cB49OwZUXLWGudA==
UI-OutboundReport: notjunk:1;M01:P0:wh5A5X6yaA0=;QyXkH5Te5P3+bxvpF9BF82Gefyo
 v/MoXlo/4Wfz7V1Gh0lxQye4K9+Edp4rhbMjSj+qEiA51U8/wm24gLtJv5Oaq/Q3Uth4wD6oV
 HhgQCD3iyK34FPj+hqhMCxmjmBCiqSJd8yxlPtypRF6qRxlkACrRP2L+KBMTlMNOmOrrEwwsu
 GIwN+FugSE4Zgn8Zr96UIBdBTItmRttEag9hpiKJ6IbWzX9EHBtW1mWzzKcwH2cE5cZh/Vq+0
 Jb5gRU0WMtAxwnvxE6l0TSAtEwqn8M56ykR1EsOPCxJ5xXUi1qp1KdWz7doODuDS+SRGypOu0
 SW9vJnHkdlvGQhSLUE7wcng+F3cVKgNbYXmleuMRCqvM4DzI2sdJ/7gyOzqfX5aNlpu7w+ydY
 LINrZcfHolmMYJX6lRCj2S8qBv0g8hjQiipW6RwgQgm9DYbsRD47FR2AHBsTZu3kmfwZS3w0l
 zf8W1clHfGRB1eTS2zTr9l1xYJQOZNlwltcnvFPIw1aZqDAxxEWrtHdWAGu1T5a0Z+XC3Pr7h
 T68l7TI2VN5B0x5vXMEwKCz2KhhGSRcWIH8mVIuCCuEorF2/upT52pOgyjgiPONqMYzBDzoeV
 3eqvv9XY9X/ck4kpz2vvb9nWp7OCoPb2YWF2QhApK8QtpfN8BA5xs/oNY5Au62ez5DZ93VbBi
 ucoCJHg/Q+m7xrNe1C3axcuWDqLcmKcpxosslw39M7l4G0kYvQ6HTqAfT2zNi8UZ4W+O2xh91
 D1ss2mb6r/9XAQEVidbz/C0V5+FgG+dh05pWZByVm1x2xwkPGIt6j2drPsoxE3sShqFc6ridz
 GrBfVW7+ANc7ayzDblu4QS5zZm/0bTWEoMgY7oF3Sk6aHJtVz0G9vGSI8Ya2fcxTcxopCSaCw
 B+WuwbNI81uyNp0tuZ6SbSwecrLfTb1G3Oxhmcqge5Wn9+bcIa4rqhcqHuLKnx/iqo2ZGjbEb
 JH3T6Rc6UosKzVezs9SX02+Ck/0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2023 at 07:21:10PM +0000, dooagain wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I configured my git repository to ignore case by executing `git config c=
ore.ignorecase true` then I executed `git pull` multiple times.

What do you mean by "I configured my git repository" ?
The answer is already there, so let's re-rephrase it:
Are you working on a case-insensitive file system ?

What happens if you create a test directory, like this:
mkdir test-case
cd test-case
git init
git config --get  core.ignorecase

>
> What did you expect to happen? (Expected behavior)
>
> I expected the output of `git pull` to accurately tell me about new bran=
ches.
>
> What happened instead? (Actual behavior)
>
> The output from `git pull` repeatedly claims that remote branches that d=
iffer in casing only to my local ref are always considered "new" even when=
 they exist locally and are in sync with the remote branch.
>
> What's different between what you expected and what actually happened?
>
> Here is one example from the output from `git pull`:
>
> * [new branch]              bug/#30k8z31/fixing_affordable_merge_fields =
-> origin/bug/#30k8z31/fixing_affordable_merge_fields
>
> This is my local ref file:
>
> .git/refs/remotes/origin/Bug/#30k8z31/fixing_affordable_merge_fields
>
> The contents of my local ref is the same commit hash as the remote branc=
h.
>
> Anything else you want to add:
>
> To me this seems like `git pull` is working as expected, but the output =
seems incorrect.
> This is problematic, because in the current repository there are hundred=
s of branches that generate this output
> so when `git pull` actually does have a problem it is very easy to miss.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.40.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Wed Aug 10 14:28:23 P=
DT 2022; root:xnu-8020.141.5~2/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /opt/homebrew/bin/bash
>
>
> [Enabled Hooks]
