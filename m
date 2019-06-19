Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CC51F462
	for <e@80x24.org>; Wed, 19 Jun 2019 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFSURt (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 16:17:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:54655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSURs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 16:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560975453;
        bh=/gwcSNFjEd6Ga/C5Qg23gfwBp+tcDOlzKxX8U2C0FLU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IeiRIeVXLlDF2MzqrgU7FNIvojlcW1C2noJHODWPExcT5pbxYp9ZSmw4T59HiYL8+
         xasLjKFp2l8NQhIa8wjU/Pvhl+FLh/1AL33/ZvIrAHXzxP1pbouNi8NnSo/6Qy/jNJ
         7jYD5DipXezEOsQrbG/JDHG8zKoQ1BxP2Da6a8LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRI2-1hzC99019W-00Mdq2; Wed, 19
 Jun 2019 22:17:33 +0200
Date:   Wed, 19 Jun 2019 22:17:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <xmqqo935o0yi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906192201200.44@tvgsbejvaqbjf.bet>
References: <pull.151.git.gitgitgadget@gmail.com> <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com> <20190609201302.GX8616@genre.crustytoothpaste.net> <xmqqo935o0yi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vbx9T1j7AaqjpMticyWJ0koOW9KUl4okRkStkNGXhP76UeCwVjp
 LiBaRMfKnHtEu9hGQ5HCmDC0Ewg7sTovFtbkPajpdu+nBHKGSHWwdK5f9SrC4aAOZ1BFF1k
 AfS4rQn66Bz3dDqUWvc51USlFxol8xoBcYTH+HyLJqKyrTuJG7AmjfY8Dy1Cn8LVN+3w2Io
 zl43eak57TXegmcLdUNVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bJvZf0/O38U=:sOGg4tj6xaCY8XsJA0ziSV
 6f11CFAAXT9h3AwxpoO8NpYbgwChue7J6I4M2sgO/+rWwV8oNqwLY0/CTavNFTa/4wpqj5cvj
 7aj8TStClGWyhjIaOnND3bKNTPxqTRM91Ivn1kTFEy/GRX/nopjqMx99prO7XdD77jB/8MonK
 UDHKAxCGd+ifiV6M0OFy2cMJR23owu9FZcJ6i9IizoSIID2NNKnQiuo8OBMF+bYeaDWL2UxDp
 PhuEaqE1ZquI/xRpa93pMEKd8r5wpfBs7ZZ+knJTsROp1sx+3OiK4FRq7y9NmoKTLVffZsh+s
 UOefcAy+c3h3E6wfpA+/jrcRSDy56XlV92GP+poaE9iU28rEtu/UKI5UXm/3C1fuwiQ8Gr45F
 O+qvptK4yOgkgzp0cO9CdojPFd7qIlsi6Dq+uE/IgzU2RAaSFK7vZnYAB2dDz3JdTG8/KzkLX
 42ah8FGXlV1fKdZCybos0KQku0ijXshnseWE5AYa4oKab8TLVUcQNCHsKrY5Jri0rQlExDfMu
 n4zOs05zkZI4ayQQS9kRHwTNhyX03Ah/3GOm29ZygiKfMn2lkhwFrXp4rP3t0uD8q585ey/vf
 sLAxbf1ul8SqBCIj4o/Vyp0ge3kVDmL9HNCbJ+X7F1IB0GMxPViykVc4g0BV4Q7x4LZQMDSeq
 0xiCQA5Q0kZfo/aJkd3d2VJr9/803jd2YEl7kzRKV0PbK56LkmHMWLdMnIn1II+m5WMNBOusu
 wNhDqo/AwXtYMpN7buStX7CwZZQKH8y3M1KkH+DJPI+PVFjZlMrzEVRYLODliF4CpJjaUiF57
 tNCq6arF4WN2FYcMEUmp3qtPpscIO7W5h636Gjr57YDoR/U0yjN4L8YG1HyvvPtaFO0Mg8uWE
 Bb0vgto9Plz5cR7zggWc03MR7uM40poFrGgshBXwjg1q7VBHt9PahlomWioXBCK0qixk2OIVv
 R/deqNe4U1IkuZUzRtCymE4OQaIa6tv++VrsXa+IAPJJaf7sURZx4
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 10 Jun 2019, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> >>  test_expect_success 'init with separate gitdir' '
> >>  	rm -rf newdir &&
> >>  	git init --separate-git-dir realgitdir newdir &&
> >>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> >> +	downcase_on_case_insensitive_fs expected newdir/.git &&
> >
> > I wonder if there's maybe a simpler way. If we canonicalize paths when
> > writing them to the gitdir file, then writing "$(pwd -P)" on the line
> > above should produce the right result.

When you execute `pwd -P` in Git for Windows' SDK's Bash (which is an
MSYS2 Bash), you get the emulated Unix path. For example, in my main Git
worktree, this results in

	$ pwd -P
	/usr/src/git

However, the actual (i.e. Windows) path seen by `git.exe` is
`C:/git-sdk-64/usr/src/git`.

> > Now, technically, POSIX doesn't require case canonicalization of the
> > path with "pwd -P", but then again, POSIX doesn't permit
> > case-insensitive file systems,

I was not sure about this statement (that POSIX does not permit
case-insensitive file systems), so I whipped up this gem in a quick web
search (https://unix.stackexchange.com/a/358407):

	According to the POSIX specification:

	    The system may provide non-standard extensions. These are
	    features not required by POSIX.1-2008 and may include, but are
	    not limited to:

	--snip--

		Non-conforming file systems (for example, legacy file
		systems for which _POSIX_NO_TRUNC is false,
		case-insensitive file systems, or network file systems)

Which means that I now know once and for all that POSIX does not dictate
whether a file system should, or should not, be case-insensitive.

> > and we know the behavior on macOS uses bash, which does the right
> > thing in this case because it calls realpath(3). I've tested that it
> > also does the right thing on Linux when the worktree containing the
> > Git checkout is in a path with symlinks.

I am honestly not a big fan of relying on testing things on the major
three platforms and then assuming that everything will work also on the
long tail of operating systems/setups.

That is exactly the kind of thinking that led me to believe that relying
on REG_STARTEND was a sane thing, and it simply wasn't. It caused quite a
bit of pain, and my original approach would have prevented that, and after
testing on the major three platforms I let myself be talked into dropping
the original approach.

> > I don't know how that works on Windows, but if it does, it might be
> > simpler.
>
> Yup, it would be a worthwhile avenue to pursue; on the negative
> side, a single-liner "no, unfortunately that would not work on
> Windows" would also be useful.

1) no, unfortunately that would not work on Windows. In a PowerShell, when
   I call `c:` followed by `cd \GIT-SDK-64`, it reports the current
   directory as `C:\GIT-SDK-64` (i.e. with the wrong case, the real name,
   on disk, is `C:\git-sdk-64`). When I then call Git's Bash to execute
   `git -PW` (the `W` stands for: gimme a Windows path), it reports
   `C:/GIT-SDK-64`. Incorrect case.

2) It might look more elegant from the design perspective, but oh my
   goodness do I not want to be a developer who has no knowledge of this
   design decision, being tasked to debug any related issue.

   It would be very "magic" that Git relies on its having written a
   normalized path, not dealing well with Git worktrees initialized by
   alternative Git implementations that did not normalize that path, or
   previous Git versions that also did not, for example.

   And normalizing the path for the sake of having this test case pass?
   Nah. I like it explicit. And that's what my patch does. No magic.

Ciao,
Dscho
