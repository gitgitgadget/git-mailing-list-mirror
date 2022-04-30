Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B3C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiD3ExJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbiD3ExJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:53:09 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779DBAB84
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651294181;
        bh=MlrUaHm8y8Io4nMxfi8mnbThTz6S9kHXUid/zPtpFog=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fdQmSYCAgvqFyPJsVdYXR9mhJVyUyxpUMcLDUVXk/DbybLnoQ6KFvgaMrR2+nKwJh
         vyweIHaKveFt6MfJhqIsZmwRMzvKQBOU1v/ZeNLjxAZpdbLjGWYzWDsRHbEdBnaq+y
         m7MsW1JNnCMiN4b8nG0lrXIgfoI9QF2kw2QO9M5g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwjS-1nVIxp2IwK-00OKsx; Sat, 30
 Apr 2022 06:49:41 +0200
Date:   Sat, 30 Apr 2022 06:49:40 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git reset --hard can leave modified files
Message-ID: <20220430044940.6botq23lxmpqxbel@tb-raspi4>
References: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:A/5FUNDbqNA4M/3yi3c65fC32PAxFpqK+VRuLhc7Z5GigC11kE3
 YasUnA3y9LHxgs49Wu70PvdIjU1mPzZY/p5kuHOXmKvG5W0Lu2MFS1+Hpxm5FqAwKMlsF7F
 Pr/L2y1RV26TVP1ryIFKMEfvUPVBLqOlPTryevF9f0kXQzS2dx+LrGdSH12gS0OoZAfxGkK
 HmRdGuNSGXO//EXagX/Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc1sXdvK9oQ=:ticTuGrKWyIks+lFazkLpS
 U5YK1AsR5g8AGYsJ/Gh1l5zZntQZdedngJowLwNymYYAle+jsA5Uhe2l8qvCGN03lnFUBSh50
 VzDtah892eJUidRUJJn8/Cc5AfL8W7fZsQUNfz9Mk9s/YCP2mYQ1RndW2ym6sQEu1kpBYH/pp
 PYfRgH3ZTNYfH2hAU/2Ls454NX7jaa6iMqKMgE2BoUYhVlEsdPLA+KoEz6Y9qmfHKugZwSw9e
 /AeOfvS55QzzgZdS4asZptQ3FY16/ZhKRkKT4ZVJvTSUzFbegoJXktvu+jcC+XJSokTtwynsK
 cgmGVCd5jr0j1fhy3yuSq/MzxCdcz/HAwGGxitwF0iYyhV4OS8IIA1qXBCvreSoQtxHvtDnnl
 lXixGWDtthqaWNKK83GjTRaq7vp/6v79XxIV0yc8KMT9q87Ozb4SpwX1yjbopegVk3qdARVCP
 KuzYWmDkD56fKWHgjzM5hbNFuw3IiBelUvf9qcrPdnbISZbMqa7VW08G+wzYCFr6UfI7ockCU
 mrP157iubuL8DuB0E7vfcfJpbtoQNHA8RW4iJIkgMBWIXxYLBd/qds6KJLvol11W2MR5V1z2d
 DSKchscLPmt3+u0DY1SRyVbBNibu9H0RL2v0xcjPOWMWmSwMRCXupSJD86Rk+qVjUmnRDN19Z
 Rl7IQgLrc30lCdu8f21/PbFu45WJYXHKPoZNZbXefLcI4JMlmRsIp1aFmiSPXQtMdr+JmMej6
 iVrB1cOatQIwOZELbCiViOYjBTj8DqMbj0rTfY8QJMtWf8vT8o32MP5Zg8eV0gJVZbMtEdIeg
 byd545ZAE0J44EYpIMNTamMUEWj52u6ODAMy7wJw5ZNamxckSZOsr0u9GiAfnqWKk8KLC3HmR
 hhWApyROg5NA02yxKY6h7yTcOZSXbur03OgzlxbQYo28/v2169e1+8pv/3jT6Bul1S6Zz9iVm
 SkEGEqssCJXI57oNadqUIcBIRMzYspNWGV9FLltpoZv6ohjiINvLO8zvCYbKgpiPsOEEz1VpN
 YUP6QdAvfHi27PNhqZsJROPwSjRYAGs9FfIf9TdOZmjc47ha93nLJHm5RSLy9pmHroSAs4iil
 4D1ec+d5/AfAkU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:59PM +0000, Mirochnik, Oleg V wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git clone https://github.com/intel/llvm
> cd llvm
> git checkout git-bug-reproducer
> git merge 38df0bd4fccd1067f3abe078d42e94c740748628 -m Merge1 --no-ff
> git merge b6b8d34554a4d85ec064463b54a27e073c42beeb -m Merge2 --no-ff
> git reset --hard HEAD~
> git status --porcelain
>
> What did you expect to happen? (Expected behavior)
> An empty output from the last command
>
> What happened instead? (Actual behavior)
>  M clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp
>  M clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp.=
expected
>
> What's different between what you expected and what actually happened?
> Obvious
>
> Anything else you want to add:
> The issue is flaky. First found for v2.29.2
> Multiple executions of the "git reset --hard HEAD" can help.
> I ran a simple script to get some numbers: 100 attempts to get and fix t=
he issue with up to 100 runs of the "git reset --hard HEAD"
> Got max number of runs - 45. Most of the cases (63) required 5 runs. 5 c=
ases did not get the issue at all.
> V2.36.0 built from sources got similar results:
>
> The script:
> (set -e; for a in {0..99}; do echo ++++++++++++++++ a=3D$a; git reset --=
hard origin/git-bug-reproducer; git merge b2d4d67d5e34c345cb6a3cf725b2e26a=
15a9dfe5 -m Merge1 --no-ff; git merge b6b8d34554a4d85ec064463b54a27e073c42=
beeb -m Merge2 --no-ff; git reset --hard HEAD~; for b in {1..99}; do git s=
tatus --porcelain | grep . || break; git reset --hard HEAD; done; echo +++=
+++++ b=3D$b; git status --porcelain | grep . || continue; echo FAILED $a;=
 break; done) > ../logg 2>&1
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.36.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC 2020 x=
86_64
> compiler info: gnuc: 4.4
> libc info: glibc: 2.28
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show

One quesion, out of interest:
do you have core.autocrlf=3Dtrue ?
What does
git config core.autocrlf
give you ?



The llvm repo itself has a lot of files commited with CRLF in the repo.

You can see this by running
git ls-files --eol | grep "^i/crlf"

So my recommendation would be to set up a proper
.gitatributes file in the root of the repo, run

git add --renormalize .
git add .gitattributes
git commit -m "Normalize the line endings"


