Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07533EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 06:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGUG6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGUG6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 02:58:38 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB7270B
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689922714; x=1690527514; i=tboegi@web.de;
 bh=ocuIn4U+sT9190zQOUDAmF8kpPogKrEHppe+v5oHe3A=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EzFxUllUJJQdLEOHDA4f4K4KEJ4suU9uuV9njrWUBK1GzqDv3fd5ahRN5+IUJmLOhCHhxNZ
 bF0GQwx1bGHhNv8N6+lOcZuS64AgCpDkowzYfPnMiXcNbeGv7K9DPr5n2+7vrYinYQhKcWI4W
 l9q7mU6ZSyATZWW3SLMf/WMUJvU3w4nlDN6BvBMPBGX5n0uZfgIcliWIsN/g3Tbk3YJTT//k+
 hg48JXtbi1xwuujD0EcLFrXFdh4QkAcl8zYS788Y3pHwo+wkHNUSvt/XFhBc9Zlg3Wz0ftpkZ
 qL5alAOPtk/RtNn+GxHT2CL48mNcBU+kZVbcLCR4NidK1GE8+jwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1pzr1C0srk-00z0wc; Fri, 21
 Jul 2023 08:58:34 +0200
Date:   Fri, 21 Jul 2023 08:58:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Radu Dan <radu@fullthrottle.ro>
Cc:     git@vger.kernel.org
Subject: Re: [bug] lots of changes including .gitignore, many rebases, can't
 legally share the repo
Message-ID: <20230721065833.q2zshssu4clbzxq6@tb-raspi4>
References: <CAH3jj7fS3wziLfnAfKz49W+aZVPvF8Nm9UVBMWyeHLvYov7A-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3jj7fS3wziLfnAfKz49W+aZVPvF8Nm9UVBMWyeHLvYov7A-w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:X/9uHH257R7QcHBJW3xSanOMUB0VvQrNjqNVFV3Lt/4XvKeq2/l
 u6V2GKV/4juVyWo0VcSrW3nd690bUv9J61B/A2BqO25eJIwiC6lWIASAKM2OejlDjDXj4JC
 GxNeAZ5uz1QmdsMuJTMbT/HC/0yEwJihzOkpspuymbCN3NmMmyNai7jare6DwcZJv+utZFx
 i4/Gt1kKggE0nY6kcjmpw==
UI-OutboundReport: notjunk:1;M01:P0:fljPnSrvIHs=;fBQUpRqxDslLJb0Rw4fopZ/VUeU
 1K5X0bJ4R+K9ISrCJ19+CAg8az8sXhXWJ3LiNCTMrQodjO3J5qSoNv18MC3U4cHoR1/8JGXB+
 vYLO4KmDkHjVp7zOLj6CCNA5z1eG7ZkcW/rn9qAjro5h6z5Us0WuSwLJJF6q3fdaB69qocNj2
 +8MuM3QqgPjbTvV1OcVGOzxgnxwVpLq2zPZN9xOpz3hVVdYLFHogBST8tkpunIb2vYthqAKyA
 wFwGPNbbWWaDQSQLUXndmyl8uS9yz8aswN/wIJRaDpdvNaMwkDVM/0g5BUJmThlqhUUmf8gV0
 7LhnKrPv3JkNjmzrqokGvIUYB62xACtqkxsE9NDXiAqV/Cp9HwWOXbj/kWe5zeg/iHVw3ICsP
 Lu2zutECEzo6aDY/WzwzsTSAFrQTw5fr7jeZ+4rnxHahI+5NysbQLsh5PS+Pr979rkpb9QFij
 IInXEnko+PoN0CnnLNsNZqk79TimH3rEt1rAVdMcobrIr9pLjQosC43PzXl5CO140PagtqWMr
 JU9o2O52ey6tvf/3dBpCFCf3qCvx85K61a6lvqadnVLmX4P+ZjIQc77dxjGC5j840eZPVIFhz
 57AGrapPrSaS0DwywHYIlxzCepBfNwvw6BgjGq+x1bRsXonVCoIr+/jDSo1yoYou2CPRriCRq
 YttCP1yJnQlUBWuq+Z7yFrkfScB4koNves21n/G0nQhJBmUHc9216+yfuQluToJ51iXnSC/BB
 XuXc7QG3Cw7ELPuHzY9537InKgSkoXX0JMYihN+3hGQqcoyJVn0cBsKD4TwuKm3T3euFafQvr
 ywDHcFDwpb6QnJLy8jpgF6f2WCwfPIP0/1+DmRzftD5rJ551U644t3ybSZ6Lpe5dx5KSPZx/O
 dBFYGI54WP+P3F9NpfyRxb0L/JyvOuvDZb2qrQ4z3qVnMAlro8DzZhR31gpcLg8XgTiwMvEoo
 KJtkOw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 12:52:30AM +0300, Radu Dan wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
>
> % git stash
> No local changes to save
>
> % git commit -m wtf
> On branch test
> Your branch is up to date with 'origin/test'.
>
> nothing to commit, working tree clean
>
> % git checkout main
> error: Your local changes to the following files would be overwritten
> by checkout:
> settings/local.py
> Please commit your changes or stash them before you switch branches.
> Aborting

First of all: thanks for your feedback.
However, the situation on your local disk is hard to debug from remote.
Which could be frustrating on both sides, so to say.

So we may come further by asking some questions:
- Is the repo you are talking about public ?
Does settings/local.py exist is both branches, origin/test and main ?
- What does
  git ls-files --eol setings/local.py
  give you ?

- Is there a .gitignore, which is different on both branches ?
- What does
  git ls-files | grep -i local.py
  give you ?



>
> > What did you expect to happen? (Expected behavior)
>
> Switch to `main`
>
> > What happened instead? (Actual behavior)
>
> Still on current branch
>
> > What's different between what you expected and what actually happened?
>
> Better error message

The error message as such is probably the best information that Git has,
the question is, which changes does Git see ?

Another question :
what does
git add --renormalize .
give you ? (Please do not omit the '.')



>
> > Anything else you want to add:
>
> First bug in 10 years of usage, great work!
>
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
>
> [System Info]
> git version:
> git version 2.39.2 (Apple Git-143)
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Thu Jun  8 22:22:22
> PDT 2023; root:xnu-8796.121.3~7/RELEASE_X86_64 x86_64
> compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
