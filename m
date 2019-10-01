Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931F71F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 17:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfJARip (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 13:38:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:35549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfJARip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 13:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569951516;
        bh=PSKRzjdq6E5AXqiWIN/O4yW7pS/bdjLeOq08jidHmPw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VoO4tqMfepjVei+88HJFIwLyNQFsDOAyYc1L18MnSahn2OK6Tmyn5RanlPjhyrJmj
         aw6CcfwM0MSi+xn/05UfyAkJn8J4MBTJ2fdXJRPjLZ4JlKbTZkwOKtZgOaMqJi+vpL
         qHKh/qzj5fgD9S9+3Lt6Q6NMLk5NPS1+uxc3LH6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1hzbVN1MYz-00tU6S; Tue, 01
 Oct 2019 19:38:36 +0200
Date:   Tue, 1 Oct 2019 19:38:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
In-Reply-To: <20191001133112.3qh4aeoctkoz2wxy@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910011638580.46@tvgsbejvaqbjf.bet>
References: <pull.361.git.gitgitgadget@gmail.com> <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com> <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com> <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
 <20190927130539.52oir56byuedqmm3@yadavpratyush.com> <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet> <20191001133112.3qh4aeoctkoz2wxy@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cUIFXIAruoSaJ/QQkF3jXx/ydgZs/A8QSQ1WToWO6e2HEua46P0
 xD06DigOQrtiQsRzJLEqz1H2sqA/WFVCpxAaLdfyxBVaxxr5M83ot1jxkztMR3mtpQYO2Tl
 rJDrPGk14+AHX4litESVaDsftgPMEzQZHo4qHIlI3+SgWUPFGef3mYbV9S8sZsC24u82gv/
 4Yulw28l9p1ilQtXvSSlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7hayzauwTiA=:lqQcsVW35QhBV8UoFcu8lb
 7uNUMJ4q0/PAgerdrgP31OVCSsQcCT7A26B6UaQghhB+5tpfY59+0BGEryfIgsf/YFOh9fSAd
 NTguFagHVfDXDb6CeEKuw+hVeexU1ngxTtJSDVW1cdr2v6EMbkPmUbRT9yDHGZDfWJwP2y+6J
 RU+nMFJJrt95r3+AuWaZj7OGnDFGfiowjpCTxdWRYeEDLcT/LGoH/yVp4/U8VU0eVW3xMrS5b
 A+F5/H9MLkYLwOYtNfVOQUW/9oBcYgOz7dbEsoYArdJDSEZOHnbAOqE2aF4GdwagcGXRD/jE4
 +crEHHtqAwVBDN1IIALSsqESuA0Bb6hDPt38tWOibQzT+78aBqmG41zXnTyp3sUi77XOlelj9
 fYyNKG/Nhqd75ZKUev/jXtLH7lMYRcABJBQszSd+71HLvCHknhVGbfPPck15lr25r0r5U7dua
 MD8FGZ5c9ci7SMm2jA++1d1Z8F8PXc9Em1EHCKeE8PfeAHojmtQ6UxEI+GqoZ4y+893UaVSiu
 nSN1vAv9jdZLfHhM3EVJTrPHeF0gvDSKgS3/300CXJJK0MVxITfgwhZJNCrUz9QvsFisbiYQU
 35U73+qM6GIC/Q9Mt+6z5qOHAUK52T1WtGriiMsCX+ToiURKpoiFQnX+DyBC2AA/RPTlaTz2v
 ixfb1sFEKydWSj9+3d1BdSMYWp81UuDn40I0qJ+01zBoe+QaAlckw+URDUYzd9YBKucDTDwHd
 pW4ewN2k9fSiSgnHKXv+3YglyvXeyAGqPWY7HUO+bb3qM/3iRwF5zYWmjDVQwUG2sAcoW21W6
 LCE/6PkkNFspfCHYEXRef4w43MbA/1o9LlAl+rTjYTJX0x1C5ihBARrzyAUku3L2Rq7zQ8/+9
 /b68JEoDVslUuBjlxYhC3/BSgvzHfYeu4d621tE6/RiJ/SO6+GLSOZnLm4txZK0Hfd09k4d6C
 GFnJ0z4e9qY3tKI1phpMoiCwMlPn1f2sex7iQwVWmhbzPgb7VxZ7qkD4JQYFYXtfJ8cmYtLkK
 J5jjxTOQLc5ouR6J9vu4fB3cxoPxuM6RWu7Htgv3zqOcI0MU/+sYmhp1tG8XOIA0LThvLC3l5
 5QmC0ahEhdBSjhDkXDKKwXxONO3WvpbufuP1hBCZohdFUAPMx93Gi43ZYmW5xwQXA3xEgFTtZ
 eZtvE1yvau/fwYcbWgvTTQt6NzQg4qkEH2jQkCkwVxIgMNa+7v8zsfG/ZJ1WI976sN1rhcxIh
 yozFVptMTkumyF1rLgGlMbRl3XlwjOzLeQbShAzZB5QVJSenT/lGSUcNPHjc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 1 Oct 2019, Pratyush Yadav wrote:

> On 30/09/19 11:42AM, Johannes Schindelin wrote:
> > On Fri, 27 Sep 2019, Pratyush Yadav wrote:
> > > On 27/09/19 08:10AM, Bert Wesarg wrote:
> > > > On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.=
com> wrote:
> > > > > gitdir is used in a lot of places, and I think all those would
> > > > > also
> > > > > benefit from using --git-path. So I think it is a better idea to=
 move
> > > > > this to the procedure gitdir. It would have to be refactored to =
take any
> > > > > number of arguments, instead of the two it takes here.
> >
> > The `gitdir` function is called 13 times during startup alone, and who
> > knows how many more times later.
> >
> > So I am quite convinced that the original intention was to save on
> > spawning processes left and right.
> >
> > But since you are the Git GUI maintainer, and this was your suggestion=
,
> > I made it so.
>
> Yes, I am the maintainer, but I am not an all-knowing, all-seeing
> entity. Your, and every other contributors, suggestions are very
> valuable. And my suggestions aren't gospel. I would hate to see someone
> send in a patch they weren't sure was the best thing to do just because
> I suggested it. Please feel free to object my suggestions.
>
> In this case, I didn't expect gitdir to be called this many times.
>
> While I don't notice much of a performance difference on my system
> (Linux), a quick measurement tells me that the time spent in gitdir is
> about 16 ms. In contrast, the same measurement without the v2 patch
> gives out 0 ms (IOW, very fast). 16 ms sounds a bit much for something
> so simple. It might not be the same for everyone else. AFAIK, spawning a
> process is much slower on Windows.
>
> So now I'm not so sure my suggestion was a good one. My original aim was
> to be sure everything was correct, and no incorrect directories were
> being used. But the current solution comes at a performance hit.
>
> > > > We could either maintain a blacklist, for what we cache the result
> > > > too, or always call "git rev-parse --git-dir".
> > > >
> > > > This blacklist would need to be in sync with the one in Git's
> > > > path.c::adjust_git_path() than.
>
> Bert's suggestion seems like a decent compromise. We run `git rev-parse
> --git-path` for the paths in the blacklist, and for the rest we use the
> cached value. This does run the risk of getting out of sync with
> git.git's list, but it might be better than spawing a process every
> time, and is very likely better than just doing it for hooks.

But what about this part of that function?

=2D- snip --
else if (repo->different_commondir)
	update_common_dir(buf, git_dir_len, repo->commondir);
=2D- snap --

It might well turn out that this blacklist is neither easy to implement
nor will it help much.

So let's look at all the call sites:

=2D- snip --
$ git grep -w gitdir | sed -ne 's|\].*||' -e 's|.*\[gitdir ||p' | sort | u=
niq
$file
$name
CHERRY_PICK_HEAD
FETCH_HEAD
GITGUI_BCK
GITGUI_EDITMSG
GITGUI_MSG
HEAD
hooks $hook_name
index.lock
info exclude
logs $name
MERGE_HEAD
MERGE_MSG
MERGE_RR
objects 4\[0-[expr {$ndirs-1}
objects info
objects info alternates
objects pack
packed-refs
PREPARE_COMMIT_MSG
rebase-merge head-name
remotes
remotes $r
rr-cache
rr-cache MERGE_RR
SQUASH_MSG
=2D- snap --

The `$file` call looks for messages (probably commit, merge, tag
messages and the likes), the `$name` one looks for refs.

Some of those arguments strike me as very good candidates to require the
common directory while others require the real gitdir (remember,
commondir !=3D gitdir in worktrees other than the main worktree).

What _could_ be done (but we're certainly threatening to enter the realm
of the ridiculous here) is to call `git rev-parse --git-dir --git-path
CHERRY_PICK_HEAD --git-path FETCH_HEAD [...]`, which will output one
path per line, and then store the result in an associative array
(https://tcl.tk/man/tcl8.5/tutorial/Tcl22.html), and use that to look up
paths based on their first component, caching as we go.

Something like this:

=2D- snipsnap --
diff --git a/git-gui.sh b/git-gui.sh
index fd476b6..9295c75 100755
=2D-- a/git-gui.sh
+++ b/git-gui.sh
@@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {

 set _appname {Git Gui}
 set _gitdir {}
+array set _gitdir_cached {}
 set _gitworktree {}
 set _isbare {}
 set _gitexec {}
@@ -197,12 +198,50 @@ proc appname {} {
 	return $_appname
 }

+proc init_gitdir_cached {} {
+	global _gitdir _gitdir_cached
+
+	set gitdir_keys [list \
+		CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
+		GITGUI_MSG HEAD hooks index.lock info logs MERGE_HEAD \
+		MERGE_MSG MERGE_RR objects packed-refs PREPARE_COMMIT_MSG \
+		rebase-merge head-name remotes rr-cache SQUASH_MSG \
+		]
+
+	set gitdir_cmd [list git rev-parse --git-dir]
+	foreach key $gitdir_keys {
+		lappend gitdir_cmd --git-path $key
+	}
+
+	set i -1
+	foreach path [split [eval $gitdir_cmd] "\n"] {
+		if {$i eq -1} {
+			set _gitdir $path
+		} else {
+			set _gitdir_cached([lindex $gitdir_keys $i]) $path
+		}
+		incr i
+	}
+}
+
 proc gitdir {args} {
-	global _gitdir
+	global _gitdir _gitdir_cached
+
 	if {$args eq {}} {
 		return $_gitdir
 	}
-	return [eval [list file join $_gitdir] $args]
+
+	set arg0 [lindex $args 0]
+	set args [lrange $args 1 end]
+	if {![info exists _gitdir_cached($arg0)]} {
+		if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
+			set _gitdir_cached($arg0) [git rev-parse --git-path $arg0]
+		} else {
+			set _gitdir_cached($arg0) [file join $_gitdir $arg0]
+		}
+	}
+
+	return [eval [concat [list file join $_gitdir_cached($arg0)] $args]]
 }

 proc gitexec {args} {
@@ -1242,7 +1281,7 @@ if {[catch {
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
 		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		init_gitdir_cached
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	load_config 1
