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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4B51F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 11:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfJHLav (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 07:30:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:47813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbfJHLav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 07:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570534243;
        bh=4TjTbhwPzz007SmuWWzzLLoN6NJi38FAq/fj0l/1WkU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ir9baMSmwzW4s8fZfHT0k7Ln+UmN91sWOM6Sg0ueqAHbHB6dDvyhLWkf84+7YDbBS
         MK+uopD+GefeQZcThfupEikKkDHIZg6IA/qx2uMNaCtcydf7zX3mUOrRHkNcaQGmx7
         dlv6+vIVVQ46hsfoCCpbu/5BP6iyeYd9Pu6oTxvI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1i2hYY2mgT-016jTr; Tue, 08
 Oct 2019 13:30:43 +0200
Date:   Tue, 8 Oct 2019 13:30:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Fix gitdir e.g. to respect core.hooksPath
In-Reply-To: <20191008002902.n4b3bhlvwzsxodsc@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910081303360.46@tvgsbejvaqbjf.bet>
References: <pull.361.v2.git.gitgitgadget@gmail.com> <pull.361.v3.git.gitgitgadget@gmail.com> <65c2fa33e1aeec03930921ee0ef562d3f9dc5ccf.1570225311.git.gitgitgadget@gmail.com> <20191008002902.n4b3bhlvwzsxodsc@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vBMUebTY09cJXQodKJVnfIdpp5GnTiSXdJmUtKdnah7igysIyBA
 CR5bxymL7QWyBPbnWk9VmImFPsqwR3pLMMyXBgZHiDC+WiT8ZUqBbVCna1M9usJz/rGSx1a
 laZg/A1zDwKO/sfFpfVHLcPR2Bzpek+gbqq+0NoAaSDtTkEq0KF3gGBILm9yu21/frLkmKX
 qLu41lfEK4o34IssYg58w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iKiVSwN20LE=:AVd2//5+cLSDvtoLsneHQC
 ij4KS5JDbszj9gHNL+fbQUcrPTutGjECZkcxZAlsgAcs4BNq1cQx/m5XCErMgILYv5l0ObbC1
 EoSAk9uZ0sHCxZeV6Dt1g3VCJVAZHMoRmuIH54hNpB7ydZYa3F8CkdCpppPanxDAK+42fA10T
 9Jg7G0WUlJOE2R9qVWpPyj16NyZ4IBPWLU1cTY1GpoDC6Cvp2xwxV7F6mhb3P45Io1jfT5Psx
 b11ZuZpZ5m3zBiIgw+Wrf7f5sFFoVajAJWV9MFvBxNuhhWfQQQEIJw/beLRJpqhXDvvPN466j
 YKDlqGIdmKueLftG6DCsbaR6b+PTab81P+lhbR9p52blhJrm5F/fc3VX4yjHAkxCGaoFndkCw
 GF9Brldu9aH/WUVC58MBc45KJ/3F0rwOqEPFGhYZDta5jpZkBbQZyj426X3iNyehtfRQu0RzE
 wlnsSgV5HkAVTs3kLGr7B3z/Dptl9f5e11Hg0vzwP59/uj083FA0BSGeOzNcvHcG1raFnk4uC
 nKPHTBkNAinI0v1QtkU/1DRMPHTyFUxEY57/YZ4Y3OAVHYr9DPTOMkwcypDG0Zoro7ISarhIp
 Dt7GMG7J2BGjVwKRZsgxDGMzxLzDsWYohi31MLANwHoWkEkXawplI1qZmtCw8oeS+oJ78WsF1
 sktFuPdxWymgJaKMB8+hnrK6QwgerYoScH8NbLEmz5YnXb/NffXgVO3mG0O21hG3n/X/G91gB
 qW8wVUD+LlIDeeQdVEHfPwywOCoJdere/w9ArlEjcqqTUUkrwFmtlbNhOkoGIE04PNu0CUlkp
 K31+rTsBTMZfXEtoi65VS7PYYaqLMXwySMGuPjn4A22u9baQgLEF+AhGQPEv/VS8Xc0IF+t2j
 mNZXMuHVd6bUMXzxTMk90ABbJhUH2E4Nm4eMxeSe7YwgqOfPEaxCH5ntR3DFWW4VMXisf3kQY
 6ReKpoQ+KTY6vzyoXQycHw8162Y39D8VKL+OfM/30hzD8nHhTOr2uebCSpdxTm4rg8Xjqn3LG
 Gq4si9c4bxO4cYeAfmwegJlfjNBtwCCeGmg4lcrsrX7/sC2n+LCvGJV4CEGdkHw7dQSPiKD09
 IkcaYUFW/x27I54F7MUvP4w8VHTgsOke9mUdq710/2/utNEMYovBDDcs8v4EJohq0sW7Sj5K4
 9ic25f90IfMSVW9rCdWmPLVbdW8C8D0qgh4Ws+yZ6U3QXTgG5oOVVH7BNBpSYii+GjF88e3Vh
 VypxYIZIN6GJzsY8oJ4QaSap6ULkzBS2C2PLo+m/cXi9bFeX4+8WG/nb2dVk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Tue, 8 Oct 2019, Pratyush Yadav wrote:

> Could you please change the commit subject to more clearly state that we
> are caching all paths. This is not something just related to hooks any
> more.

It is related, but not exclusively so. Changed accordingly.

> On 04/10/19 02:41PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >
> > Since v2.9.0, Git knows about the config variable core.hookspath
> > that allows overriding the path to the directory containing the
> > Git hooks.
> >
> > Since v2.10.0, the `--git-path` option respects that config
> > variable, too, so we may just as well use that command.
> >
> > For Git versions older than v2.5.0 (which was the first version to
> > support the `--git-path` option for the `rev-parse` command), we
> > simply fall back to the previous code.
> >
> > An original patch handled only the hooksPath setting, however, during
> > the code submission it was deemed better to fix all call to the `gitdi=
r`
> > function.
> >
> > To avoid spawning a gazillion `git rev-parse --git-path` instances, we
> > cache the returned paths, priming the cache upon startup in a single
> > `git rev-parse invocation` with the known entries.
>
> I think it would also be a good idea to mention that we are fixing
> worktree paths not being correct.

Done.

> > This fixes https://github.com/git-for-windows/git/issues/1755
> >
> > Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-gui.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 49 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index fd476b6999..8b72e59cd0 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
> >
> >  set _appname {Git Gui}
> >  set _gitdir {}
> > +array set _gitdir_cache {}
> >  set _gitworktree {}
> >  set _isbare {}
> >  set _gitexec {}
> > @@ -197,12 +198,57 @@ proc appname {} {
> >  	return $_appname
> >  }
> >
> > +proc prime_gitdir_cache {} {
> > +	global _gitdir _gitdir_cache
> > +
> > +	set gitdir_cmd [list git rev-parse --git-dir]
> > +
> > +	# `--git-path` is only supported since Git v2.5.0
> > +	if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
>
> I think we should mention the source of the list of "magic" keys. A
> comment mentioning this list came from looking at the common calls to
> `gitdir` in the rest of the git-gui code would explain this function to
> a future reader better.

Makes sense.

> > +		set gitdir_keys [list \
> > +			CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
> > +			GITGUI_MSG HEAD hooks hooks/prepare-commit-msg \
> > +			index.lock info info/exclude logs MERGE_HEAD MERGE_MSG \
> > +			MERGE_RR objects "objects/4\[0-1\]/*" \
> > +			"objects/4\[0-3\]/*" objects/info \
> > +			objects/info/alternates objects/pack packed-refs \
> > +			PREPARE_COMMIT_MSG rebase-merge/head-name remotes \
> > +			rr-cache rr-cache/MERGE_RR SQUASH_MSG \
> > +		]
> > +
> > +		foreach key $gitdir_keys {
> > +			lappend gitdir_cmd --git-path $key
> > +		}
> > +	}
> > +
> > +	set i -1
> > +	foreach path [split [eval $gitdir_cmd] "\n"] {
>
> A call to the procedure 'git' is wrapped in a 'catch' in a lot of
> places. But it is also not wrapped in 'catch' in a lot of other places.
>
> I'm not sure how something like this would fail, so I'm not sure if
> wrapping this call in a catch is a good idea. But it is something to
> consider.

If that call fails, we lack a `gitdir`, which is a rather fundamental
prerequisite to running Git GUI. I'd rather show an (ugly, but also
highly unexpected) exception.

In other words, I think the patch should stay "catch-less".

> > +		if {$i eq -1} {
> > +			set _gitdir $path
> > +		} else {
> > +			set _gitdir_cache([lindex $gitdir_keys $i]) $path
> > +		}
> > +		incr i
> > +	}
> > +}
> > +
> >  proc gitdir {args} {
> > -	global _gitdir
> > +	global _gitdir _gitdir_cache
> > +
> >  	if {$args eq {}} {
> >  		return $_gitdir
> >  	}
> > -	return [eval [list file join $_gitdir] $args]
> > +
> > +	set args [eval [list file join] $args]
> > +	if {![info exists _gitdir_cache($args)]} {
> > +		if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
> > +			set _gitdir_cache($args) [git rev-parse --git-path $args]
> > +		} else {
> > +			set _gitdir_cache($args) [file join $_gitdir $args]
> > +		}
> > +	}
> > +
> > +	return $_gitdir_cache($args)
> >  }
> >
> >  proc gitexec {args} {
> > @@ -1242,7 +1288,7 @@ if {[catch {
> >  	&& [catch {
> >  		# beware that from the .git dir this sets _gitdir to .
> >  		# and _prefix to the empty string
> > -		set _gitdir [git rev-parse --git-dir]
> > +		prime_gitdir_cache
> >  		set _prefix [git rev-parse --show-prefix]
> >  	} err]} {
> >  	load_config 1
>
> Can these paths we cache change while git-gui is running, say by a
> command run by the user in the terminal? In that case, we should refresh
> the list when the user rescans.

I guess it can. A user could configure `core.hooksPath` while Git GUI is
open, after all. Or rewrite the `.git` file of a worktree.

I won't touch the `.git` file part, but I changed the `rescan` code to
re-prime the gitdir cache.

Thanks for the review,
Johannes

>
> Other than some minor comments, looks good. Thanks.
>
> --
> Regards,
> Pratyush Yadav
>
