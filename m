Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8089FC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4815420826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QM3J1u4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgEUTta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:49:30 -0400
Received: from mout.web.de ([212.227.15.3]:41157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgEUTta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590090568;
        bh=7RKKXtMyjn2cpBTDDByh+1PQk7E5jvAlVI9S91ibe3s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QM3J1u4rCAere/xLY1GCWXNukOI5+5g7ceo8dDw1BE0muzZI6I/nTZfWsdsnLOhsy
         flbyRhbuqdCRz/lb4TU9mAI8c33VzhU0hgp2tin1cixl3jK7GkOD2fLvDQhCVhhtCZ
         hZTcbBGz+RJ+Wk7vrwwt91fS9FLwLAPRqviPFDBU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4TR-1j2nQP1SbZ-00Zg7R; Thu, 21
 May 2020 21:49:28 +0200
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
To:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <01fe37e2-6188-c148-0795-ec4a9066effd@web.de>
Date:   Thu, 21 May 2020 21:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0oe40UvGAu6T73InehnImRnbw+rI67ZCNwoTjU5wvZM1mTK5/W
 tRtwVUJ9MbfTHlUTWVbN7apYo3O9noszNyevahBduPA4NbQwA0eoGlLPWaB4llI4l7eiUFk
 n2TPPd7RE0tLQYkhLLYRgCMXXK8ddIzMxEt2XEwnEDbx0NUGHtDo0IsqJc7K1T2Di6RtpUu
 G8Hat5Y3Pu7NDwOHlRNFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p1mZMMl4j8A=:5mQ9cH3ZobIuo+G6Iz3FSB
 3toXKvdHi0JfTG3UCjOaWuYUcgTQJgJi8S84jLg48cpO8NHZndNXTUA66OT0sw9BVJnM3NmI0
 fdQNZVCv5pPvKcdHX7nx2F4O1KrWq4CTvlKsTakWApVbOIL+4awKMKIINhZXdMQD7YgfrsFMf
 wcBFhkYwuqmuBwXtdR6/1dwZ0suNcVgmC8gHlo0I8wZskYx8Ljn0GEICDKBt1iaHrLGektGMI
 uXmZXX/Rh5+rJ+3X6/qi/L9NVh6M58M0TQhJLRWGfoM3DtqosnNmk9bBaCu61YXkuiYU6fd4H
 /OUAsQVrfGl5/0TVOqke3ST2weutfz4ILw6zzlKYeCIsfOEx5I8BJ3Ic7XSoSsLOy6YHS6xXd
 f0fonqDmxihrnzk41KlAgM8Y1ZW13uh90iK6kPZfmaQshtvdZ71A33g7O2N36PNOnJdrJGLGm
 2wHnnitK6zTSmvz+AQzVwMLBoTycF7kMENmzPN5Z5cwPuKK7d4vjEuPhzA0GGspAGCZTl8Bdl
 5J4P36Ioi6RCcNNH7PVktIUwZPyIifLKxzPX8bOt9WwmTC70Svfd6W0y34gaEsH4jZWugZ1ZP
 ft6jYxd3TA/S5czJpcqXjtfulxaH0+46s7qWJ7rbppPrEIlPSIzHQtSVCzojBKcqTeiS8Dc9T
 JQjzN5zvvvxG19C1TmgAD+BLZMBuj/HnKbjSfpNJB7rOjDselU97fsXoymYZs0lw+2rbkWRgH
 BbBGm7U++6J2wkHSCRV2tq/WOwNOMURS12Uc8z4Gsl/GW0BCPCc5zK6UKQIXcpU9BZoMb4rHe
 8/bxWgJks8Avhv61AFqrv/6YVkCvK/HwphMKbnK4b2oqW24c6+0odeaLs3jUXO49WeClneTVq
 x9R80flU8QsgsBWxCQ7fnBFg3JrvXwChFKNn32yb2sRNuT2PDLksTT6fOmxbL/eeQDrJS2QqA
 toEH1o65sXmxnylYho4YZKcFbMLaEBKDUT5SY0OllPr6HCPfa1gA6LapSl9g3bl28y5d5+Ecz
 r5V5gfeCH//Lb5IUqyshhm5pdDyltTVwi+Q3Z1jJBPzT8kbgJozIyXhiLMuKeskIX5J2jxIN0
 5vJImraHLkGW/BOwTBwT3YPGGY3os6606In9JkVOIN3YnGZJdVZlleO019nqGxq6o4ET8cQnZ
 oYzBM965sPYdFPMIUNEHbZiscCFQdiN4oQgRQv4cF7WLVnfj2+iPmWAr8yZMInAet6bHJZLS3
 fw9pRSl48apOkRdaE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.20 um 21:00 schrieb Dana Dahlstrom:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
>   $ git clone https://github.com/githubtraining/hellogitworld.git
>   $ cd hellogitworld
>   $ git checkout -b work -t master HEAD
>   fatal: 'HEAD' is not a commit and a branch 'work' cannot be created fr=
om it
>   $ git show -s --oneline
>   ef7bebf (HEAD -> master, origin/master, origin/HEAD) Fix groupId [=E2=
=80=A6]
>   $ git checkout -b work -t master ef7bebf
>   fatal: 'ef7bebf' is not a commit and a branch 'work' cannot be created=
 from it
>
> What did you expect to happen? (Expected behavior)
>
>   I expected a new branch named 'work' to be created and checked out,
>   pointing to commit ef7bebf and with upstream branch set to 'master'.

The option -t/--track doesn't take an argument.  Try this:

	git checkout -b work -t master

... or perhaps this if you want to track the upstream branch instead of
the local one:

	git checkout -b work -t origin/master

These days I'd use this, though:

	git switch --create=3Dwork --track origin/master

> What happened instead? (Actual behavior)
>
>   I saw these erroneous messages (copied from above):
>
>   fatal: 'HEAD' is not a commit and a branch 'work' cannot be created fr=
om it
>   fatal: 'ef7bebf' is not a commit and a branch 'work' cannot be created=
 from it

This message is puzzling, but what it means is that the extra "HEAD" and
"ef7bebf" you gave are not being interpreted as a commit to use as the
start point of the new branch and git checkout just doesn't know what to
do with them.

The message used to read, which was a bit worse:

  fatal: Cannot update paths and switch to branch 'work' at the same time.
  Did you intend to checkout 'HEAD' which can not be resolved as commit?

If you pass extra arguments to git switch it reports, which is better:

  fatal: only one reference expected

Ren=C3=A9
