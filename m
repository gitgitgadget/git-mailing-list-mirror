Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D9C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 23:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B96260EFF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhJ3XRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhJ3XRv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 19:17:51 -0400
Received: from outpost.hi.is (outpost.hi.is [IPv6:2a00:c88:4000:1650::165:166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB53C061746
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 16:15:20 -0700 (PDT)
Received: from krafla.rhi.hi.is (krafla.rhi.hi.is [IPv6:2a00:c88:4000:1480::148:57])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id 19UNFEIt001507
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 30 Oct 2021 23:15:15 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is 19UNFEIt001507
Received: from krafla.rhi.hi.is (localhost [127.0.0.1])
        by krafla.rhi.hi.is (8.15.2/8.15.2) with ESMTPS id 19UNFEbd1086715
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 30 Oct 2021 23:15:14 GMT
Received: (from bjarniig@localhost)
        by krafla.rhi.hi.is (8.15.2/8.15.2/Submit) id 19UNFEbN1086714;
        Sat, 30 Oct 2021 23:15:14 GMT
Date:   Sat, 30 Oct 2021 23:15:14 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git describe --debug" does not show the latest tag for "groff"
Message-ID: <20211030231514.GA1086559@rhi.hi.is>
References: <20211027233101.GA762862@rhi.hi.is>
 <211028.86wnlxwnqt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211028.86wnlxwnqt.gmgdl@evledraar.gmail.com>
Sender: bjarniig@hi.is
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 10:26:21AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 27 2021, Bjarni Ingi Gislason wrote:
> 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> >   I do not know, it could have happened anytime after the latest tag
> > was committed (11th Nov. 2020).
> >
> > What did you expect to happen? (Expected behavior)
> >
> >   Seeing the latest tag "1.23.0.rc1" in the version string of "groff"
> > (and in the output of "git describe --debug")
> >
> > What happened instead? (Actual behavior)
> >
> >   "groff --version" shows for example "1.22.4.3317-8f8c8-dirty"
> >
> >   "git describe --debug" shows:
> >
> > describe HEAD
> > No exact match on refs or tags, searching to describe
> > finished search at 2ac1f9ba5578cad27dc547d5be3c91753db436ea
> >  annotated       3318 1.22.4
> >  annotated       3319 1.22.4.rc5
> >  annotated       3352 1.22.4.rc4
> >  annotated       3464 1.22.4.rc3
> >  annotated       3485 1.23.0.rc1
> >  annotated       3572 1.22.4.rc2
> >  annotated       3619 1.22.3.rc1
> > traversed 3833 commits
> > 1.22.4-3318-g3a1e750d
> >
> > What's different between what you expected and what actually happened?
> >
> >   The latest tag is not shown for the groff version.
> >
> > Anything else you want to add:
> >
> >
> >   The latest tag in "git log" is 1.23.0.rc1 in my branch.
> >   It is 1.23.0.rc1 in branch master.
> >
> >   Search for "tag:" in "git log" in my branch shows:
> >
> > commit c05b538c504106d55b81caa6400ea80797f03775 (tag: 1.23.0.rc1)
> > Author: Bertrand Garrigues <...>
> > Date:   Wed Nov 11 01:58:55 2020 +0100
> >
> >   "git show-ref 1.23.0.rc1" in my branch shows:
> >
> > faa3dff8d011e61721e763c71b6ccbf20a4675bc refs/tags/1.23.0.rc1
> >
> > ####
> >
> >   "git-version-gen" (gnulib) does not get the latest tag.
> >
> >   The call in configure.am is:
> >
> > AC_INIT([GNU Troff],[m4_esyscmd(build-aux/git-version-gen --prefix ""
> > .tarball-version)],[http://savannah.gnu.org/bugs/?group=g$
> >
> >   The files ".git/packed-refs" and ".git/info/refs" are the same in both
> > branches.
> >
> > #####
> >
> > [System Info]
> > git version 2.33.0 (Debian/testing Version: 1:2.33.0-1)
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > uname: Linux 5.14.9-2 #1 SMP Sun Oct 10 01:53:44 UTC 2021 x86_64
> > compiler info: gnuc: 10.2
> > libc info: glibc: 2.32
> > $SHELL (typically, interactive shell): /bin/bash
> 
> Daginn.
> 
> The "git describe" command won't just return the latest tag name, but if
> you're not on such an exact tag name find the "closest", and then add a
> suffix indicating the distance and HEAD commit.
> 
> Reading between the lines I think you know that, but you're suprised
> that it's finding 1.22.4 instead of 1.23.0.rc1, which newer.
> 
> I tried to reproduce this and cloned
> https://git.savannah.gnu.org/git/groff.git; If you run e.g. this
> command:
>     
>     $ for c in $(git log --oneline 1.22.4..1.23.0.rc1 | awk '{print $1}'); do git describe $c; done
>     1.23.0.rc1
>     1.22.4-765-g10cd0b66
>     1.22.4-764-ge3b774ad
>     1.22.4-763-gfb52df3b
>     1.22.4-762-g0f42ca27
>     1.22.4-761-gdf73fc2b
>     1.22.4-760-g3afeb883
>     1.22.4-759-gcb1a9dc5
>     [...]
> 
> You'll see us describing all commits between 1.22.4..1.23.0-rc0, ending with:
>     
>     [...]
>     1.22.4-7-g72b4440e
>     1.22.4-6-g81908bc0
>     1.22.4-5-g9da68905
>     1.22.4-4-g2212cba0
>     1.22.4-3-ga3068bfd
>     1.22.4-2-g607236cc
>     1.22.4-1-gde9f9bfd
> 
> But as your tag "1.22.4.3317-8f8c8-dirty" shows we're at a distance of
> 3317 from 1.22.4. Are you able to share whatever your 8f8c8 is
> somewhere? I wonder if you're on some commit based off an older version.
> 
> Aside from what ref "describe" picked it's weird that a new version of
> git would choose to show a 5-character hex abbreviation of the commit,
> the minimum we show these days is 7, unless you have something setting
> e.g. this in config:
> 
>     core.abbrev=5
> 
> Or maybe that AC_INIT() macro does that somehow...

  The latest tagged version (1.23.0.rc1) is actually in the output of
"git describe --debug", but at the wrong place.

  "git log" on the console shows the tag "1.23.0.rc1" to be the first
one.

  "git log" directed to a file does not show any 'tag' in the commit
lines!

  "git describe" gets the sorting wrong.

  Part of output from "git log | grep '^commit [0-9a-f]' | cat -n":

     1	commit 3a1e750d2e03ed67eff01155ace01a0657c23ad7
     2	commit 8f8c8ab812093554ebdf3a3218c8944302c9eb94 <--
     3	commit 86b12aaaf5b7ceac78df11c53d3f45e1de0d8522
...
  1939	commit 2e52c43497d6078d1be3edf12aec962a91cb54e2
  1940	commit 2ca9c70def2b83cb5ad4cb5da0c0e2533a21b133
  1941	commit ab3e18c27ea1890bb98812a80d1e36c1c03f5db3
  1942	commit c05b538c504106d55b81caa6400ea80797f03775 <-- 1.23.0.rc1
  1943	commit 10cd0b662256d6fd2b6ed204f0ce891c8fc1175d
  1944	commit a4584886ce3391d85b6d1e2c774bf919cdd94451
...
  3004  commit a3068bfda2e25584e4d07781162179cb79829f56
  3005  commit 607236cc2ba834f326d01db189026f3dc28e118b
  3006  commit de9f9bfdf63245967bdbe56c503d587fcf0b279b
  3007  commit cc292790528abb8985c8b743ac3887f7f393cd7a <-- 1.22.4
  3008  commit 39cade0f09d9531d15abe7873101694cf0140ba4
  3009  commit 743c23c7f9d2a4e8f6e7cd555703487521dd012d
  3010  commit b78b8ba1a973421ad00770fc10bcd894fc7fc717
...
  6712	commit a48ab7b6db26b1d98f77f59f22896fe02a700c40
  6713	commit bd5385e4ea12522ba7e852fa3a628f3be854f674
  6714	commit 351da0dcdf702cf243d26ffa998961bce2aa8653

In ".git/info/refs" commit 1.23.0.rc1 is listed with an affix "^{}".

  Without an affix the commit is "faa3dff8...", which is not in the
output of "git log".

  The used expression of "git describe" uses "--abbrev=4" (in
git-version-gen) for generating version strings for "groff".

-- 
Bjarni I. Gislason
