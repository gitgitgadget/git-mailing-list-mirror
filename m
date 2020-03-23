Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B820C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109892072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gBlqfnru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCWQCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:02:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:55597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgCWQCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 12:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584979337;
        bh=KGNZWZIGxSoyKsnA4u6rnEmPArUcVgsF+oV3VGxpTKU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gBlqfnruhcD/2sGbh2LayeB199pzLfrfpu5+QX9SRXMlwWRgH6JF9+vsHjTsKjZof
         5Rtlr70nLPf3CAZ9m1ScGP+CkeyclzvY4WBa2Ff2AHGEaTJ7kRGEs/QXaVPucZri3c
         mRdZj8B9jizvebcZQfKI3hTsRaXjzpQwpS5BeEyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAOJV-1j6GOI0y9D-00BpGh; Mon, 23 Mar 2020 17:02:17 +0100
Date:   Mon, 23 Mar 2020 17:02:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Sheikh hamza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sheikh hamza <sheikhhamza012@gmail.com>
Subject: Re: [PATCH] bisect: remove root directory restriction for git
 bisect
In-Reply-To: <20200322104826.GB2224@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2003231658450.46@tvgsbejvaqbjf.bet>
References: <pull.736.git.git.1584868547682.gitgitgadget@gmail.com> <20200322104826.GB2224@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1122087595-1584979338=:46"
X-Provags-ID: V03:K1:8qYdX7CoZTFep5xnXqVrmrvRgVPNRYxm6GwYCjRX6oMuqHd9s96
 jcE3v8tGlvK/2OLqI0sf66VWNKSMaZXUsuEvZQvLh+JfAooAWMn8HmF7jfIB0IoLFq3TEPG
 b3Bm00L7Aq0McRW3j5846WuJeUQMCXSXFE7OE4aRAbz+BBS33wWPN4lDqNXQzYuucSL0D1Z
 OAkwVeWIQ3Ph2ztp00iNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fe3f6Pd8xQg=:oHopeUoegvZNqYpNpvRX6Q
 QsP2RYH+Bysi11duX1DoZEb3V8RalxsqZwVj1+mK46XxQZ4Xz/pVaG75zCKHsoiaGhN1xJ5Oq
 lvQkLBcDHi0Kbvbdc8ikw0QdqHYnEH+MnZIQN+JlY8jJJYLn3b8QbvYVgRTs/ciFk/8kHeFSU
 EjH5yql8jFV0X9Zl6tafxZwlzTRp65JNM316VS0GmmyIikE1YIjqCMr3eJOktPRKt7FiZAKly
 APKC4za4b9/6lZ5esMs2Ff5aEwCHug15vwpwkULSKR/DXvGETH/15COObvZPtt8AegwBcEA6C
 wk8souCjig80SQRfTsHGJd4EQnu0LF85jspOUQoLA7fspj+12gBSwPffLL7uK2JfPTWnuxWp6
 cXAUd8mVjFs8hrBb5q0hiYwU54bLoX8lbCWKyU98D7OW5Dl1HyWj6UWW39Vr202Ya71MoRoGC
 aZaMoYOzML0ANZlNuvpnhxlDwK95F4HxzO1XoQ45bXaZopKbBZlVFIumtxUa7qmxD//NL1eo1
 7lU+5rKxblnPdvaQ7Ky3FMHtxgc4mijqNSzNCNOIs3cYvsl5VkCLcrZ6p0l3lw+7LnR1Ig9L1
 Y8ND4Sbwx6MyVqCai5CDa8jb/hYZ6LIsSAg506PicZAIhl4UKzKD24lfeI5/76wotg84S3d3k
 HeRO2WNu6JAybK23CW9xGymXoFH5OyI6f/vz4tpxH2gtglhXbCe8tsOgWcpaoaZa1WQ/kUtji
 K8l33XsKOnN9vfM68ZqNVUWGD7FpSXa4IuKS2bMikF9rVi3BGg5S5KaiWTCvXf/bIwLI4ywuL
 WXkft5TbdFJYxVc6fLr/OkWRY53TAdP9K4+JYMVoH7BybNjk53Cs/qM1XY1d56bHaxZolzR+R
 c2IwolMHA60Co1EwMSbE1WMOSBVVUFGz1u5SBCInJQJGkyYG3fRftWL3VO/leiNyUumda6Dth
 uf1Q33iKdHRIISfg9B+Qw4RAbDAhS6slMyZfdOD41WjG4AFe5Lqdl9Wwc6ay0+iOGZ1GQ6NFG
 8CYbii3QMWxrdBlhVndeVHX6yUlAHPnKFrsmgOmy+LyMukwJDTA8/k1V4yb5A95PecisYv6ud
 SQotr5V1u6g+0QAl1PEGz9TcK4ENVnnrIQqns5MXdehtrubDA6kg4JwDhaOFfyJhkh4nFsXhd
 it+2rfagt3ZvbYpfgkTDo5UO4XTDH1f9SvZx7VdnsQN5BaOwBq4JKJR9LNND4ISmS4hm8R2cc
 kfvM9bsY/MvJyQf7P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1122087595-1584979338=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sun, 22 Mar 2020, SZEDER G=C3=A1bor wrote:

> On Sun, Mar 22, 2020 at 09:15:47AM +0000, Sheikh hamza via GitGitGadget =
wrote:
> > From: sheikh hamza <sheikhhamza012@gmail.com>
> >
> > the git bisect
> >     command should be able to run from inside any
> >     subdirectory
>
> Why should 'git bisect' be able to run from inside any subdirectory
> (of the working tree, I presume)?

Because other commands also allow the user to run in a subdirectory. For
example, `git rebase`, `git checkout`, `git cherry-pick`, etc

> In particular, what happens, if someone starts 'git bisect' from within
> 'subdir/', and 'git bisect' then checks out an old commit, where said
> 'subdir/' didn't exist?  What happens, if the user runs 'git bisect run
> ./script' from within 'subdir/', and that 'subdir/' doesn't exist in
> that old commit?

The same that happens if that situation arises in `git rebase` or `git
checkout`: the directory is removed unless it is not empty (i.e. if there
are untracked files in the directory, or submodules).

> What happens, if 'subdir' does exists in that old commit, but it's a
> file, not a directory?  What happens, if all this is on Windows?

On Windows, the directory is not deletable, of course, and the same thing
happens as if an untracked file is still in that directory: it is not
deleted.

> >  git-bisect.sh            | 1 +
> >  t/perf/bisect_regression | 6 ++----
> >  2 files changed, 3 insertions(+), 4 deletions(-)

The most obvious problem with this patch is that it is not accompanied by
a regression test that documents and verifies the intended behavior.

Ciao,
Dscho

--8323328-1122087595-1584979338=:46--
