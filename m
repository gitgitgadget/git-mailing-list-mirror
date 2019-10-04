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
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DA71F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfJDT5K (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 15:57:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:48529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730836AbfJDT5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570219022;
        bh=GWiBLK42/Ut60p7DISZxR33YPpVoc9sHkdiM3Gb+W18=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SmQYb5HrIlXMaPVzroVEXoAfmZIjM74MIchMybsRrvthP5cBHiZLsxM+E34kxgDNu
         NJm98KtPr8FTunJwj+EopnArd1AIg/x5/nTtBPQshRLXlVehn9Kw9o9a1KMKV7ImjP
         Any3utdybZB+dCNRBnyAyWWRirxpDUXzoZROpeoc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1hxzPJ1xel-00rmcr; Fri, 04
 Oct 2019 21:57:02 +0200
Date:   Fri, 4 Oct 2019 21:56:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
In-Reply-To: <20191004164809.txdiwf7fandxsbmq@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910042141430.46@tvgsbejvaqbjf.bet>
References: <pull.361.git.gitgitgadget@gmail.com> <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com> <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com> <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
 <20190927130539.52oir56byuedqmm3@yadavpratyush.com> <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet> <20191001133112.3qh4aeoctkoz2wxy@yadavpratyush.com> <nycvar.QRO.7.76.6.1910011638580.46@tvgsbejvaqbjf.bet>
 <20191004164809.txdiwf7fandxsbmq@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ffYEGwtx0U2pIFvcBzaoE8nssjoL2tJhfsTMdkmBd3R9pEl/gSr
 3scs0zTXCFT4TJyGis0JUdnumjJgRTj4iPxiH+FBDAQu+2PLtbcZMnikyP38TIQlQNW3u+0
 lnppqfYSzHIO9LhLmgEfXNUgY4tZs9lZH01RmZHEhiqyDEL0sMqfIWifOwuAHbUyGoUo5JI
 j5HaKIhIq7UphULPKV+4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l4/WbLc9uX0=:HOfhsiPtp2R0DZ2ZxRtD/k
 FnTgMUtfRu4wEX7fPJhwq58bhFPHUVowtKKU/zIh/aYDBK3MnH3em8a8pVN/Wu1yYnxnWcGLr
 JlD1szGpUretkgPJPzEGvBKrwqL3zWMoMrEayIu1BPXTeXrVAorCe7QVAq8jPGlvkZ0O46fvM
 6MY1LOVOPl8QdtKmIiNcKKtYQL4YxuZPy6l544hdEsMBG56hQ2Ueom3009sffIoKE9R7G3ExY
 cUb0Q6Gq14rqa7PyJKU85EwtVwzNqQB29wd1QxFx+osigRVIa8jRruX8DvKeUMDelZ7bcnKT9
 ERAheKwOnSkAdvPJIKYq24/nnYfEMHwT+mT+iB8IpLxcnCCuBeK6i5RwfiW7IIvFmqYmbaF/s
 rNqZW/LFBEyPo6Wgfberlyhk3ktA/fMq+cJRnR4Jzvu5TiuamsaTPlTU9Y6qX8e5llG1/wHVe
 1oD7TYHAQQG/HZWtJupEPGTV9XklsPHkaWw5bwnVAPQsrz1TQ7Zgm+DkgMCV4SanloWWezO/8
 Uy2WYQped1ZaYDC7GeyDGzzU+Qc2Qu4ZWpyAfiENH5qBe1U2BnJXCwuSZyawS4f0O2iuGvmsH
 87zuB7dJg2bP0te+/sdL84YvI8k1fML+sN1B1Vv4Qt9SlOw1RzeXr5E/zFxYaM+F4WEiyDUdf
 xIAY+nvDZaM033gncqrDy1NL3zDOSZQsWWp13nORIlqucfPmQ7zEJK0kVeJovAia3EB7WzZwn
 g+PS59+oJOHa8nOHozNdYClqTGHGWq+ylnbTyWZeFy0l7U93R6qvp1XcOUT6tq0timqcjyzLt
 zDHhXfUZmFXGY1GfaNJI9c2CVmdvfZd5voawSsmCcgNkAjfFkV5HL6uBgmEIlMXcXv3PAExFs
 iE/BstGd+PFY3q8C+IbNqALw2FecKWKwK2pHiMp/ladcuS29qiMkr0NVAsEQJSp/d8Xr6P/xW
 iyRzHXvj2l8jWIRcdqq+KtCRhL46RDlarLEjQ1xgXvg1pKFKWWIl8vYFx+gHLY6FZRAWdW+7U
 0pufv2toHBHsQfbtCCBgubqrZZoH9eGLvlJxfolOvP+FrkP/DQhiTflpoQyDgglj7fv0Uo0lC
 l8rXrRYPk6QYvufe3eAg4a+ZohoWhFmHDMXxk9wvGS5ioKhNQ9of18Wi3FOZoh4duL6zx3nWD
 pbSRUkoPBYNFLtUP4vFUiweQmJ+zoMHnYEBE+Blzw3Sr3TZ8T/SJwbFxg7xvUV+FDDKX+fyc9
 1N4cESs1VcKy0H41xvKTaEvR6lhV+IRBXBYpqDI+i7fo7cHgoJs75ZRG1aAw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Fri, 4 Oct 2019, Pratyush Yadav wrote:

> On 01/10/19 07:38PM, Johannes Schindelin wrote:
> >
> > On Tue, 1 Oct 2019, Pratyush Yadav wrote:
> >
> > > On 30/09/19 11:42AM, Johannes Schindelin wrote:
> > > > On Fri, 27 Sep 2019, Pratyush Yadav wrote:
> > > > > On 27/09/19 08:10AM, Bert Wesarg wrote:
> > > > > > On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpraty=
ush.com> wrote:
> > > > > > > gitdir is used in a lot of places, and I think all those wou=
ld
> > > > > > > also
> > > > > > > benefit from using --git-path. So I think it is a better ide=
a to move
> > > > > > > this to the procedure gitdir. It would have to be refactored=
 to take any
> > > > > > > number of arguments, instead of the two it takes here.
> > > >
> > > > The `gitdir` function is called 13 times during startup alone, and=
 who
> > > > knows how many more times later.
> > > >
> > > > So I am quite convinced that the original intention was to save on
> > > > spawning processes left and right.
> > > >
> > > > But since you are the Git GUI maintainer, and this was your sugges=
tion,
> > > > I made it so.
> > >
> > > Yes, I am the maintainer, but I am not an all-knowing, all-seeing
> > > entity. Your, and every other contributors, suggestions are very
> > > valuable. And my suggestions aren't gospel. I would hate to see some=
one
> > > send in a patch they weren't sure was the best thing to do just beca=
use
> > > I suggested it. Please feel free to object my suggestions.
> > >
> > > In this case, I didn't expect gitdir to be called this many times.
> > >
> > > While I don't notice much of a performance difference on my system
> > > (Linux), a quick measurement tells me that the time spent in gitdir =
is
> > > about 16 ms. In contrast, the same measurement without the v2 patch
> > > gives out 0 ms (IOW, very fast). 16 ms sounds a bit much for somethi=
ng
> > > so simple. It might not be the same for everyone else. AFAIK, spawni=
ng a
> > > process is much slower on Windows.
> > >
> > > So now I'm not so sure my suggestion was a good one. My original aim=
 was
> > > to be sure everything was correct, and no incorrect directories were
> > > being used. But the current solution comes at a performance hit.
> > >
> > > > > > We could either maintain a blacklist, for what we cache the re=
sult
> > > > > > too, or always call "git rev-parse --git-dir".
> > > > > >
> > > > > > This blacklist would need to be in sync with the one in Git's
> > > > > > path.c::adjust_git_path() than.
> > >
> > > Bert's suggestion seems like a decent compromise. We run `git rev-pa=
rse
> > > --git-path` for the paths in the blacklist, and for the rest we use =
the
> > > cached value. This does run the risk of getting out of sync with
> > > git.git's list, but it might be better than spawing a process every
> > > time, and is very likely better than just doing it for hooks.
> >
> > But what about this part of that function?
> >
> > -- snip --
> > else if (repo->different_commondir)
> > 	update_common_dir(buf, git_dir_len, repo->commondir);
> > -- snap --
>
> I'm afraid I'm a bit out of my depth on this. I have no idea what a
> "common directory" is, and how is it different from the "git directory".
> I can't find anything useful on Google about it. My guess is that it is
> something related to separate worktrees.

It is indeed related to worktrees. If you create a secondary worktree
via `git worktree add [...]`, that work tree will get its own git
directory under `.git/worktrees/<name>` in the main worktree. That git
directory will not, however, contain all contents of a regular git
directory. Most refs, for example, are stored in the main worktree's git
directory. That is what the "common dir" is.

> > It might well turn out that this blacklist is neither easy to implemen=
t
> > nor will it help much.
>
> Am I correct in assuming that for other cases like "info", "grafts",
> "index", "objects", and "hooks" the blacklist would be simple to
> implement, and it is the "common directory" case that is problematic?

Indeed, for the other, simple cases, the list would be unproblematic to
implement. Problematic to maintain, though, especially given that Git
GUI is _supposed_ to support even very old Git versions.

And those simple cases don't include _all_ interesting cases. Take
`logs/` for example. The git directory will contain the reflogs for
`HEAD`, but unless you're on an unnamed branch (AKA "detached HEAD"),
the reflogs for the current branch are _in the commondir_.

> > So let's look at all the call sites:
> >
> > -- snip --
> > $ git grep -w gitdir | sed -ne 's|\].*||' -e 's|.*\[gitdir ||p' | sort=
 | uniq
> > $file
> > $name
> > CHERRY_PICK_HEAD
> > FETCH_HEAD
> > GITGUI_BCK
> > GITGUI_EDITMSG
> > GITGUI_MSG
> > HEAD
> > hooks $hook_name
> > index.lock
> > info exclude
> > logs $name
> > MERGE_HEAD
> > MERGE_MSG
> > MERGE_RR
> > objects 4\[0-[expr {$ndirs-1}
> > objects info
> > objects info alternates
> > objects pack
> > packed-refs
> > PREPARE_COMMIT_MSG
> > rebase-merge head-name
> > remotes
> > remotes $r
> > rr-cache
> > rr-cache MERGE_RR
> > SQUASH_MSG
> > -- snap --
> >
> > The `$file` call looks for messages (probably commit, merge, tag
> > messages and the likes), the `$name` one looks for refs.
>
> So they should always be inside the '.git' or GIT_DIR, correct?

They should be inside the git directory. Note that `.git` in worktrees
is just a file that contains `gitdir: <path>`. The indicated path is the
actual git directory. Inside that git directory, the file `commondir`
contains the path to the main worktree's git directory.

> > Some of those arguments strike me as very good candidates to require t=
he
> > common directory while others require the real gitdir (remember,
> > commondir !=3D gitdir in worktrees other than the main worktree).
> >
> > What _could_ be done (but we're certainly threatening to enter the rea=
lm
> > of the ridiculous here) is to call `git rev-parse --git-dir --git-path
> > CHERRY_PICK_HEAD --git-path FETCH_HEAD [...]`, which will output one
> > path per line, and then store the result in an associative array
> > (https://tcl.tk/man/tcl8.5/tutorial/Tcl22.html), and use that to look =
up
> > paths based on their first component, caching as we go.
>
> Ah yes! That is certainly threatening to enter the realm of ridiculous.
> I'm not sure what benefit this will have. Right now, I don't think
> git-gui handles these cases. Have people complained? Is this a common
> problem?

Well, we know that people complained about the hooks directory. And that
did not even involve worktrees.

I see that e.g. `packed-refs` is queried by Git GUI. And that file lives
in the main worktree's git directory, i.e. in the commondir.

So either users don't use Git GUI in secondary worktrees, or they did
not even notice the bug.

> I want to evaluate how much benefit we get doing something like this
> has over just using your original patch that works with hooks only.

Since I already have that ridiculous approach essentially implemented,
and since it fixes very real bugs in Git GUI ever since `git worktree`
was introduced, I'd say that you'd be better off taking the ridiculous
patch than not.

> > Something like this:
> >
> > -- snipsnap --
> > diff --git a/git-gui.sh b/git-gui.sh
> > index fd476b6..9295c75 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
> >
> >  set _appname {Git Gui}
> >  set _gitdir {}
> > +array set _gitdir_cached {}
> >  set _gitworktree {}
> >  set _isbare {}
> >  set _gitexec {}
> > @@ -197,12 +198,50 @@ proc appname {} {
> >  	return $_appname
> >  }
> >
> > +proc init_gitdir_cached {} {
> > +	global _gitdir _gitdir_cached
> > +
> > +	set gitdir_keys [list \
> > +		CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
> > +		GITGUI_MSG HEAD hooks index.lock info logs MERGE_HEAD \
> > +		MERGE_MSG MERGE_RR objects packed-refs PREPARE_COMMIT_MSG \
> > +		rebase-merge head-name remotes rr-cache SQUASH_MSG \
> > +		]
> > +
> > +	set gitdir_cmd [list git rev-parse --git-dir]
> > +	foreach key $gitdir_keys {
> > +		lappend gitdir_cmd --git-path $key
> > +	}
> > +
> > +	set i -1
> > +	foreach path [split [eval $gitdir_cmd] "\n"] {
> > +		if {$i eq -1} {
> > +			set _gitdir $path
> > +		} else {
> > +			set _gitdir_cached([lindex $gitdir_keys $i]) $path
> > +		}
> > +		incr i
> > +	}
> > +}
> > +
> >  proc gitdir {args} {
> > -	global _gitdir
> > +	global _gitdir _gitdir_cached
> > +
> >  	if {$args eq {}} {
> >  		return $_gitdir
> >  	}
> > -	return [eval [list file join $_gitdir] $args]
> > +
> > +	set arg0 [lindex $args 0]
> > +	set args [lrange $args 1 end]
> > +	if {![info exists _gitdir_cached($arg0)]} {
> > +		if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
> > +			set _gitdir_cached($arg0) [git rev-parse --git-path $arg0]
> > +		} else {
> > +			set _gitdir_cached($arg0) [file join $_gitdir $arg0]
> > +		}
> > +	}
> > +
> > +	return [eval [concat [list file join $_gitdir_cached($arg0)] $args]]
> >  }
> >
> >  proc gitexec {args} {
> > @@ -1242,7 +1281,7 @@ if {[catch {
> >  	&& [catch {
> >  		# beware that from the .git dir this sets _gitdir to .
> >  		# and _prefix to the empty string
> > -		set _gitdir [git rev-parse --git-dir]
> > +		init_gitdir_cached
> >  		set _prefix [git rev-parse --show-prefix]
> >  	} err]} {
> >  	load_config 1
>
> A nice way of tackling this problem overall considering the challenges,
> but I'm worried about whether all this is _actually_ needed for real use
> cases, and what breaks if we don't.

Why don't you try using Git GUI in a worktree for a while? I am sure
you will encounter the issues sooner or later.

> Honestly, I'm not too sure how to tackle this problem. That is also the
> reason I took so long in writing this response. What would your
> suggestion be?

I would actually go for the ridiculous patch, as it provides the safest
bet we have on fixing the `gitdir`-related bugs.

> Also, if some other people interested in git-gui could chime in, it
> would be great.

Sure.

Ciao,
Johannes
