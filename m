Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B70C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhK2XBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhK2XA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B5C09CD3B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:58:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so77634873eds.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTHTxKEcv5cHYozpKbGTALnhaQ9VZyVs4L9K5AXFxk4=;
        b=bzSvKlWC3zvvTrYPM3QE6mcqYMDiIZuGblJC5lKIz8R148NvshpAKBBIi4PwtilrFX
         GAiPeR9YyhadryyadcPE8xchybop92k3q8Qip7kuhl/7khRoTts67fMgpY45ZHzkGZ25
         sAUnuKq4jPcPbqjCHIhLjkVYtVCI9jE6M4Glay6cZv9Tr7lHYUMmDBgmTI3+pYc0yko+
         nWl53/fWyka9xq6gY5sBktqCZ4vSwIaMrQ/Y8puqSS2HfRDzqbEsQLOC7QG4hHGb8gbf
         LS9u2bqbzehAPHI4ZSJBzJC1o+M3hz/9cPaLzFgAoTqumtlX2PDfY6hhUTJxr7m0mWSf
         /qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTHTxKEcv5cHYozpKbGTALnhaQ9VZyVs4L9K5AXFxk4=;
        b=25beZ+43UHEQLlRN4qBMl8fHTPdmwB8sx/yEviidoq883bd78BocG1Al3YZEHO/LEM
         yxJjBd4/sUHu4KYIQlSjcIAtu8Ht60LoQrumDI8T0KI11gqqf4EMSua/wSxtF/kfWe+p
         Vsq9YmpKQLu1QfgL15WsqfUS6CTA578jhGwffwVmiwJ/JtPMi9ldex0fouDOYGJ2cXtv
         kBujQyfj8w6fLGF5JnqwdGxzCJfADxq99xlDOnEByMizsxoJzhUtZK0sIylumdd9/NMK
         Udib0JBRnJamBlt9ya8xxvGFIElvRfRX1LZvSi34P5fnIv05fJVN3dPuYjgxldCwO++F
         QuVQ==
X-Gm-Message-State: AOAM530n7pyeFVaxaLBQyyfwXFiTsu9FoiQp3E1wupIRCD14YfYOXDb3
        f8lfS0/tXgPwIYbFnJYnmODGDx35Dr28dbyiQhqRvtMqRpA=
X-Google-Smtp-Source: ABdhPJzI18TWSOBiMYS+gQuEsRw5dIf2iL4jXtU1GyCsZ7G7/HrV3X0stVS6he2HJE010avkvJk70ShQGXVWNvoHOVU=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr63993048ejc.520.1638223100133;
 Mon, 29 Nov 2021 13:58:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
 <211127.86v90dhf5g.gmgdl@evledraar.gmail.com> <CABPp-BFuKBht2yZ+tYkG+C4Rpek6dLT0gx6pZNH4rXqv0UFf3Q@mail.gmail.com>
 <211129.868rx6g0e0.gmgdl@evledraar.gmail.com>
In-Reply-To: <211129.868rx6g0e0.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 13:58:08 -0800
Message-ID: <CABPp-BFGkQHBF+zd+WRaSxN_BWm62x9Cq89b0AXxkL+8pSdRPg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 12:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Nov 27 2021, Elijah Newren wrote:
>
> > On Sat, Nov 27, 2021 at 6:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> [Just some more "I haven't really looked at this in all that much
> >> detail" commentary, so maybe it's stupid, sorry]
> >>
> >> > From: Elijah Newren <newren@gmail.com>
> >> >
> >> > Removing the current working directory causes all subsequent git
> >> > commands run from that directory to get confused and fail with a mes=
sage
> >> > about being unable to read the current working directory:
> >> >
> >> >     $ git status
> >> >     fatal: Unable to read current working directory: No such file or=
 directory
> >> >
> >> > Non-git commands likely have similar warnings or even errors, e.g.
> >> >
> >> >     $ bash -c 'echo hello'
> >> >     shell-init: error retrieving current directory: getcwd: cannot a=
ccess parent directories: No such file or directory
> >> >     hello
> >>
> >> Is that really realistic?
> >
> > I have 321 shell scripts (or symlinks thereto) in /usr/bin/ on my
> > Fedora laptop, and 951 shell scripts in /usr/bin/ on my Ubuntu
> > workstation at $DAYJOB.  That's not even considering stuff in other
> > directories.  Note that I didn't place any of those scripts in
> > /usr/bin/; they came from the distribution and/or corporate packages
> > from others.  Any invocation of bash will see the above "error"
> > message.  Granted, bash calls it an 'error' but continues anyway, but
> > I thought it showed that there were clearly programs besides git where
> > users could run into problems.
> >
> >> Any "normal" command would use "pwd" or look
> >> at $PWD, both of which "work", this error is only because we're starti=
ng
> >> a new shell.
> >
> > <grin>
> >
> > Yeah, good point.  Who would use an unusual program like git?  Or a
> > shell script?  Or a java program?  Or emacs?  Or other programs like
> > them?  Besides, git, bash, java, and emacs are all relatively young
> > commands with small development teams.  Maybe we should just rely on
> > users only using commands that get the pwd/$PWD detail right; perhaps
> > limiting to commands that are more mature and have bigger development
> > teams than those four.
> >
> > Silly users.
> >
> > ;-)
> >
> > Sorry, couldn't resist a little friendly teasing.
> >
> >
> > However, for "pwd"...by "work", do you mean "doesn't necessarily
> > work"?  On my machine:
> >
> > $ mkdir gone
> > $ cd gone
> > $ rmdir ../gone
> > $ pwd -P
> > pwd: error retrieving current directory: getcwd: cannot access parent
> > directories: No such file or directory
> > $ pwd
> > pwd: error retrieving current directory: getcwd: cannot access parent
> > directories: No such file or directory
> > $ echo $PWD
> > /home/newren/floss/git/gone
> >
> > If I do not run `pwd -P` first then a plain `pwd` works.  But your
> > advice to use `pwd` seems misguided for programs, since they'll hit
> > this problem if users have run a previous `pwd -P`.  (The $PWD trick
> > would have worked, as shown above)
> >
> >> I wonder if it was just because you ran into our bin-wrappers edge cas=
e,
> >> but that should be really obscure for any real users.
>
> For some reason I was under the misimpression that the "#!/bin/bash"
> part of the bin-wrappers and other scripts somehow immunized them from
> the $PWD/"pwd" reset, and it was only the programs they invoked (like
> git in the bin-wrappers) that didn't get the values passed along.
>
> But that's clearly incorrect as you demonstrate above, so the only thing
> that'll work OK (seemingly) is running "pwd" (but not "pwd -P"), or
> looking at $PWD in your terminal shell itself.

And further, even running a plain "pwd" seems to not work either if
something else has already run "pwd -P" already, as I pointed out
above.  I have no clue how one 'pwd -P' call can prevent future plain
'pwd' calls from working, but that's the behavior I observed.

> Invoking non-POSIX shell programs "works" in that they can use the same
> trick, after the dance of "mkdir x && cd x && rm -rf ..x" e.g. Perl
> says:
>
>     $ perl -MCwd=3Dgetcwd -wE 'say $ENV{PWD}; say getcwd'
>     /home/avar/g/git/x
>     Use of uninitialized value in say at -e line 1
>
> This "pwd -P" behavior isn't just something weird in your shell & mine,
> it semse to be mandated by POSIX:
> https://pubs.opengroup.org/onlinepubs/007904875/utilities/pwd.html
>
> All of which is to say I'm much more sympathetic to this approach
> now. I.e. it seemed like purely a way to work around fixable breakages
> in our own and other programs. Well, I guess "don't use shellscript if
> you care about this edge case" is a "fix", but not a trivial one.
>
> I do still think a better starting point would be fixing the setup.c
> dying in our own code, and see where that leaves us, but up to you
> etc. I'm not going to work on it any time soon.
>
> > Yes, I agree our bin-wrappers is a really obscure edge case not worth
> > considering.  I don't see how you jump from there to painting all
> > shell scripts combined with the same brush, though.
>
> *nod*
>
> >> > This confuses end users, particularly since the command they get the
> >> > error from is not the one that caused the problem; the problem came =
from
> >> > the side-effect of some previous command.
> >> >
> >> > We would like to avoid removing the current working directory of our
> >> > parent process; towards this end, introduce a new variable,
> >> > startup_info->original_cwd, that tracks the current working director=
y
> >> > that we inherited from our parent process.  For convenience of later
> >> > comparisons, we prefer that this new variable store a path relative =
to
> >> > the toplevel working directory (thus much like 'prefix'), except wit=
hout
> >> > the trailing slash.
> >>
> >> I'm still not clear at all on why we need a "original_cwd" at all then
> >> as opposed to just using "prefix" (or adding "the_prefix" if passing i=
t
> >> down is painful). I.e. we discover our relative path, we resolve the
> >> relative path to the root, can't we use that as the "don't remove our
> >> CWD" guard?
> >>
> >> Does our prefix change at some point, then maybe "orig_prefix" would
> >> make more sense?
> >
> > No; see the code comment in the same patch:
> >
> > +       /*
> > +        * startup_info->original_cwd points to the current working
> > +        * directory we inherited from our parent process, which is a
> > +        * directory we want to avoid removing.
> > +        *
> > +        * For convience, we would like to have the path relative to th=
e
> > +        * worktree instead of an absolute path.
> > +        *
> > +        * Yes, startup_info->original_cwd is usually the same as 'pref=
ix',
> > +        * but differs in two ways:
> > +        *   - prefix has a trailing '/'
> > +        *   - if the user passes '-C' to git, that modifies the prefix=
 but
> > +        *     not startup_info->original_cwd.
> > +        */
> >
> > It's never equal to prefix, even though it's usually semantically
> > referring to the same directory.  However, even if it weren't for the
> > trailing slash issue, the -C case means it is not appropriate to think
> > of it as "orig_prefix" either.
>
> Ah, with -C of e.g. t/helper we'll first chdir(t/helper), and then run
> the usual setup.c dance to find that we need to chdir() again to the
> (equivalent of) "../../". But our prefix stays at "t/helper".
>
> I'm a bit confused about the trailing slash case, isn't the prefix
> always going to point to a directory? Why would t/helper v.s. t/helper/
> matter?

Because when you compare two paths, you either need to canonicalize
them in some fashion or do a bunch of tricky work to see if they are
"equal".

> I think it won't matter for rmdir(2) et al, but maybe I'm wrong.

Correct, rmdir won't care, but strcmp() certainly does.  Since we call
strcmp() before deciding whether to remove, and we do that based on
paths built up from prefix + tree traversal + entry name (which won't
have the trailing '/') we want original_cmp to be canonicalized the
same way (i.e. without the trailing '/').

(In contrast, prefix is used as a starting point to build up other
paths, so having a trailing slash was more convenient for it.)

> What got me confused about the "prefix" v.s. "original_cwd" is that I
> was assuming they'd be the same. The commentary on setup_git_directory()
> says as much, i.e.:
>
>     Returns the "prefix", a path to the current working directory
>     relative to the work tree root, or NULL,
>
> But of course we know that's a white lie, it's not the $PWD/getcwd().

I don't think it is a white lie.  This code runs after the chdir()
from the parsing of the global -C option, and before the chdir() to
the worktree root (which occurs later in setup.c).  So the statement
is true, you just have to understand what "current" means in "the
current working directory".  In this context, "current" means *as of
the time the setup.c code where this comment is written starts
running*, which is a pretty logical thing for current to mean.  If you
try reading this code unaware of the other chdir() calls we make,
though, it certainly has the potential to trip you up.

> So you're only trying to save the user in cases of e.g. (in t/helper):
>
>     git rm ../helper
>
> If they actually run it while in t/helper, but would like to explicitly
> omit the case of (at the top-level):
>
>     git -C t/helper rm ../helper
>
> That's fair enough I guess. I'd just assumed those cases would be
> treated the same way.

I don't see why you'd assume that.  The whole point was preserving the
cwd of our parent process so that any subsequent commands that happen
to run in that parent process don't get confused by having their cwd
no longer exist.  In the former command you gave, the cwd of the
parent process was $WORKTREE/t/helper; in the latter, it was
$WORKTREE.  So, they should preserve different things.

> Even in that case, I can't think of a case where this "original_cwd"
> wouldn't be made redundant by some boolean flag to accompany "prefix" to
> indicate that we've chdir'd out of the prefix (or not).

I can't think of a case where a boolean would provide any useful
information.  Don't we always chdir out of the prefix whenever prefix
!=3D NULL?

Maybe I'm missing something, so let me give you a simple case where
you can explain how this boolean could help.  Let's say you started at
the worktree root and then ran these two commands:

   $ cd subdir/
   $ git -C subsubdir rm lastfile

After finishing the setup phase of the git command, the state should
be the following:
   prefix =3D subdir/subsubdir/
   original_cwd =3D subdir
   getcwd =3D subdir/../  (because setup.c chdirs to the worktree root;
the actual answer would be a more canonicalized path, though)

In this above case, how can we infer the value of original_cwd from
other data if we don't record it?
