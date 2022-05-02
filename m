Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF4C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 19:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387115AbiEBTa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbiEBTaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 15:30:16 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37C108
        for <git@vger.kernel.org>; Mon,  2 May 2022 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651519595;
        bh=Wdsz8pLJcM1YdMLVvdZoOzGDUoiY37IWllIAENc45Js=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RxCbbjHpayzaawKOnTOCRwDMeLwrG7DvW1eeRqrnMNNb4WjqNl/wRfKEm5JVpg3Dh
         OvmPR6ogOX2PTOAdJy8hf4QzfEOF4biLX4ThIVPJFHZ4eQ0isnwXwCjbr3eEe9P/4k
         h60N9dBdlELcXg63TL5lygjoyjsvw73LFPJncNKU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1nO0Fl2RT8-00TFtz; Mon, 02
 May 2022 21:26:35 +0200
Date:   Mon, 2 May 2022 21:26:34 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git reset --hard can leave modified files
Message-ID: <20220502192634.bzjfvoda2wjjxs3i@tb-raspi4>
References: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220430044940.6botq23lxmpqxbel@tb-raspi4>
 <CY5PR11MB608914F7E815A8EF95441BB1C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CY5PR11MB608914F7E815A8EF95441BB1C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:W/krqEppZWlcDSevnwXGEJwZ0GND6oHSXHa3otMO1eRR8HLpg2S
 8cbJhjDNU9CwuMmIGsbpiLo5OZOcGGHyyyeYrVQEI9fpjBoXa3qK14uFp+359ljOQT4/Iud
 TJXDB2qrtqz85rGV5q/cRtAE55qTNm8DdPsKMusnOUlRkP1hWQxjuPkXzJYBE9E1yGj4bv+
 zFGoGe/VO+6IWvgD+qHGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y+BNhuuXcMM=:grBq3xDtszG13E9o3Grs/K
 NvKhTJegwEZonHmVi0rBhsA8FgU0dY/f0ajm8BP+dEZM/dmXwgo7gLywUfgiKqWowlMiEUIky
 RyxDO1QYOcVV94XniDJoWuyNCHmJOcEJhJZW8A5mcubImyNRnn0kKWIB7gWGlw1uIH3p88p5C
 fU76o7zhgRVdQBzabNS/SnCevVJjq1+dxx2Yn1smypdOoxD6VvIhPm7QczKgC5IRYMc0/e4Hv
 o3kr0nhPGpvlCLO28TQBRvcS6yWxSV3s+muhFUODR/Nr99XcBAOkGTQ5+wfdCW2HroqzenTqE
 TiRc2RZ9rwMhd8Qf6QOh6XtcPVSpdHXY6z1yVLWPGD+MrMKDIwBd97xvGZFwdxUXM5OHfXLYp
 AQzIrlZQUeTrfc1bgVouy2gNx70fsuOANxqY97O6Dx7AekXaaRfQHr+UXTc13UoI21DNifUZz
 OfOuNE+5uTXm821lhznjEslkcfwsqHD5w2OdPlkCxYf+ChZvblI4YUuuA2c2ONH5AcgB7d9fi
 z7JId7EojABKoYGZ8oPEUqjd4mZ3y5qQ7Uy4xHGhmi6c22yYrwop323zyCC55o2CoEtenPWpQ
 CobEEfEQZOTziuRH4hvBpHXXScePYCNG2s0MlXVg4nPgVL+Y/MACk8hY828YOrmyzGxvDMIIu
 HpKPEzLqglzZO6qSQLvRuE0aN9zm1nAGhuY0H8W8HHWyIOeWBKSueaoJGROz6pE90+xkOsoyf
 NWigVlSZlMPKQpIRTeAZaQIuI4PAA6LmlLKevyCQPiNLDwZ9XF0IjfCk3eZzeyv080qHl9zs5
 LXTg5h46xtWMTq7S/1vuEegxy3cgsGW+pNBcns1fAA3Ep7lIDJFGlMskzoBynd1UTfKQKYGXn
 RqXshDSZ7WINHAw3UfELtB+k5t6kI4NtXh0ZOqeIJWvjn1VzYeNReDHa21d+HIbw8iClhyxjV
 RCZYkPQ/6ltPnp6uR3LYiDPLybCRz7pryArP8QutY3zxZdUf7NBLd0TiCwL2eJ3H8E2ivS+j2
 Xq+q2/YVMyBm64Z3QCoLu2YKw2O5DRLDr7MMVN2VbFDu/0ni/JH6dGKp15W5vQHraA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2022 at 06:37:26PM +0000, Mirochnik, Oleg V wrote:
> > -----Original Message-----
> > From: Torsten B=F6gershausen <tboegi@web.de>
> > Sent: Friday, April 29, 2022 9:50 PM
> > To: Mirochnik, Oleg V <oleg.v.mirochnik@intel.com>
> > Cc: git@vger.kernel.org
> > Subject: Re: git reset --hard can leave modified files
> >
> > On Fri, Apr 29, 2022 at 03:50:59PM +0000, Mirochnik, Oleg V wrote:
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your iss=
ue.
> > >
> > > What did you do before the bug happened? (Steps to reproduce your
> > > issue) git clone https://github.com/intel/llvm cd llvm git checkout
> > > git-bug-reproducer git merge 38df0bd4fccd1067f3abe078d42e94c74074862=
8
> > > -m Merge1 --no-ff git merge b6b8d34554a4d85ec064463b54a27e073c42beeb
> > > -m Merge2 --no-ff git reset --hard HEAD~ git status --porcelain
> > >
> > > What did you expect to happen? (Expected behavior) An empty output
> > > from the last command
> > >
> > > What happened instead? (Actual behavior)  M
> > > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp
> > >  M
> > > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp=
.e
> > > xpected
> > >
> > > What's different between what you expected and what actually happene=
d?
> > > Obvious
> > >
> > > Anything else you want to add:
> > > The issue is flaky. First found for v2.29.2 Multiple executions of t=
he
> > > "git reset --hard HEAD" can help.
> > > I ran a simple script to get some numbers: 100 attempts to get and f=
ix the issue
> > with up to 100 runs of the "git reset --hard HEAD"
> > > Got max number of runs - 45. Most of the cases (63) required 5 runs.=
 5 cases
> > did not get the issue at all.
> > > V2.36.0 built from sources got similar results:
> > >
> > > The script:
> > > (set -e; for a in {0..99}; do echo ++++++++++++++++ a=3D$a; git rese=
t
> > > --hard origin/git-bug-reproducer; git merge
> > > b2d4d67d5e34c345cb6a3cf725b2e26a15a9dfe5 -m Merge1 --no-ff; git merg=
e
> > > b6b8d34554a4d85ec064463b54a27e073c42beeb -m Merge2 --no-ff; git rese=
t
> > > --hard HEAD~; for b in {1..99}; do git status --porcelain | grep . |=
|
> > > break; git reset --hard HEAD; done; echo ++++++++ b=3D$b; git status
> > > --porcelain | grep . || continue; echo FAILED $a; break; done) >
> > > ../logg 2>&1
> > >
> > > Please review the rest of the bug report below.
> > > You can delete any lines you don't wish to share.
> > >
> > >
> > > [System Info]
> > > git version:
> > > git version 2.36.0
> > > cpu: x86_64
> > > no commit associated with this build
> > > sizeof-long: 8
> > > sizeof-size_t: 8
> > > shell-path: /bin/sh
> > > uname: Linux 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC 20=
20
> > > x86_64 compiler info: gnuc: 4.4 libc info: glibc: 2.28 $SHELL
> > > (typically, interactive shell): /bin/bash
> > >
> > >
> > > [Enabled Hooks]
> > > not run from a git repository - no hooks to show
> >
> > One quesion, out of interest:
> > do you have core.autocrlf=3Dtrue ?
>
> Nope.
>
> > What does
> > git config core.autocrlf
> > give you ?
>
> Nothing:
> $ git config core.autocrlf
> $
>
> > The llvm repo itself has a lot of files commited with CRLF in the repo=
.
> >
> > You can see this by running
> > git ls-files --eol | grep "^i/crlf"
> >
> > So my recommendation would be to set up a proper .gitatributes file in=
 the root
> > of the repo, run
> >
> > git add --renormalize .
> > git add .gitattributes
> > git commit -m "Normalize the line endings"
>
> AFAIK all of them CRLF files are intentional.
> LLVM community decides on the stuff, we have to follow the decisions.
>

I somewhat suspect seriously that the problem is related to this thread:
https://reviews.llvm.org/D124563

I didn't dig into all the details (yet).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 git show c9a16e8c3d99173c7525e576d78eed571
Drop '* text=3Dauto' from .gitattributes and normalize

 Git wants to check in 'text' files with LF endings, so this changes them
     in the repository but not in the checkout, where they keep CRLF endin=
gs.

    Differential Revision: https://reviews.llvm.org/D124563
=2D-------------------
I don't know, if this was a good change or not.
If folks wants CRLF in their working tree, there are 3 ways to do so:
- Set core.autoclrf to true
- Set core.eol to CRLF
(This works on Windows and Unix)

Or, if everybody should have CRLF in the working tree,
we could (and should) still have LF in the repo.

Just set

*myfiles.cpp text=3Dauto eol=3Dcrlf

In other words
(I may be wrong due a lack of time to dig deeper into the llvm repo)
the problem seems to come from upstream.

And we could find out, what upstream really wants and needs,
and may be able to help here.

Is this maybe something you can do, contact upstream ?

