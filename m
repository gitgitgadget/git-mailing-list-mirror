Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CCC77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEFXk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFXk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 19:40:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C51FDE
        for <git@vger.kernel.org>; Sat,  6 May 2023 16:40:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso3602101e87.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683416422; x=1686008422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbkeTiw10k7Q3g9uhykA9pLoVoukF4rUPrmIgj0Myos=;
        b=OXdj6tZ2O/U+QLHsgs4NYVrTcOK3Huii6QMrHuVBMNYC1dGLzukyI7FtsgFNhf41jJ
         kDWYRZSNXEESLnFhfR/TLSWIp1rO+5bnXRdZc6cWF278Mn7F0phTsLCrqAkv22CmFAmA
         etZ+jY54eNJ+HPzwCbGAihMlK3S/nENwji7O3XNoSmsk7gFo4WFfdlXifCuQXhlMuByN
         1tCMdBXygZCGs4/dK7JHoteutUg4P5u56+sR/stH/DUIZK/UQUcSfXBzJVE8PgqJE46J
         eid0tJwnPkDE7fOcHAoV/P4MYtsar2iooQ3Cka4SROWDvB9AVY0rfHR4uTOJzvW1DXaq
         WThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683416422; x=1686008422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbkeTiw10k7Q3g9uhykA9pLoVoukF4rUPrmIgj0Myos=;
        b=gsrZlBBENcVgwMAxVOERQLDyGebyvKVplqroZb8Jj3kFY9PEkxt3MMn6CeFFoTkBm4
         OWnBufVFAXcdNTqt6yWA8+Su5nIKpA5LJX0m+DfGoBPObE3QZSYfUvsgPqib4xNBfFu9
         dqPxxmsjNltovCO1MrDkW2/0ywIJ3Rmc7Kvr5Ym+rh9+8+1bjtUNGCbbmhF0fce4c4vB
         BijTd4+hWTiq4VWdBwa02OjQybkPuxcw2y/PLBuLAXYeagJh+5BA5EFUlooMaqHLXHM6
         PhQVlyzOib1kP+KZfD5s65GbZGVMcE+Cttdyu6yL70QH8eBuwktUEATXlAfA8vAPgHGJ
         gn1A==
X-Gm-Message-State: AC+VfDxXIJX90Hn1oTbAumuUaeCOKrg0wgwojDeo0qiFq68mPJtu1Mrp
        xU1tzLzdLtcYUL9uWuTntYZECfdVev1RAe+zmwM=
X-Google-Smtp-Source: ACHHUZ4XZFXmJJPIo6ioYNBcsqwdiAyxj/cqMLsAHRy4BzhM/8W8LmUtKhy8/v7Fxo7zw1i19/+mxTmic7z7VNWqLAg=
X-Received: by 2002:a19:ac42:0:b0:4f1:3ca4:9263 with SMTP id
 r2-20020a19ac42000000b004f13ca49263mr1579443lfc.63.1683416421400; Sat, 06 May
 2023 16:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 16:40:09 -0700
Message-ID: <CABPp-BE50neqaQbE2tTq_=fEM9j_8-cxgj7xKcSfAunoWjsigw@mail.gmail.com>
Subject: Re: [PATCH] doc: merge: improve conflict presentation docs
To:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2023 at 6:58=E2=80=AFAM Adam Johnson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Adam Johnson <me@adamj.eu>
>
> Improvements:
>
> 1. Remove the sexist example ("Barbie... wants to go shopping")
> 2. Show real merge marker contents, rather than e.g. "yours:sample.txt".
> 3. Swap yours/theirs terms for source/target.
> 4. General wordsmithing.
>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---
>     doc: merge: improve conflict presentation docs
>
>     Improvements:
>
>      1. Remove the sexist example ("Barbie... wants to go shopping")
>      2. Show real merge marker contents, rather than e.g.
>         "yours:sample.txt".
>      3. Swap yours/theirs terms for source/target.
>      4. General wordsmithing.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-150=
5%2Fadamchainz%2Faj%2Fmerge-conflict-docs-improvements-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1505/a=
damchainz/aj/merge-conflict-docs-improvements-v1
> Pull-Request: https://github.com/git/git/pull/1505
>
>  Documentation/git-merge.txt | 75 ++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 0aeff572a59..b4523362e48 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -233,11 +233,11 @@ HOW CONFLICTS ARE PRESENTED
>
>  During a merge, the working tree files are updated to reflect the result
>  of the merge.  Among the changes made to the common ancestor's version,
> -non-overlapping ones (that is, you changed an area of the file while the
> -other side left that area intact, or vice versa) are incorporated in the
> -final result verbatim.  When both sides made changes to the same area,
> +non-overlapping ones, where only one side changed an area, are incorpora=
ted
> +in the final result as-is.  When both sides made changes to the same are=
a,
>  however, Git cannot randomly pick one side over the other, and asks you =
to
> -resolve it by leaving what both sides did to that area.
> +resolve it.  Git adds changes from both sides, and optionally the
> +original content from the common ancestor, surrounded by merge markers.

Everywhere else in the manual we have referred to these as "conflict
markers", not "merge markers".  (Even if you spread out to the whole
codebase, there are only two places in the code (xdiff-interface.h and
t6402) that refers to "merge markers", while there are 94 places that
use "conflict markers".  We should fix those two to be like the other
94.)

Other than that, this rewrite seems good.

>  By default, Git uses the same style as the one used by the "merge" progr=
am
>  from the RCS suite to present such a conflicted hunk, like this:

If we're updating this documentation, perhaps it's time to drop the
mention of RCS?  15 years ago, the reference made sense to bring up --
there were numerous folks who were new to Git that were familiar with
RCS (even if only via CVS).  The number of folks left who are still
aware of RCS but are not aware of Git, is probably very tiny, while
there are many folks new to Git who haven't heard of RCS.

Maybe it still makes sense and doesn't hurt, but I'm not sure what
it's buying us anymore.

> @@ -245,71 +245,70 @@ from the RCS suite to present such a conflicted hun=
k, like this:
>  ------------
>  Here are lines that are either unchanged from the common
>  ancestor, or cleanly resolved because only one side changed,
> -or cleanly resolved because both sides changed the same way.
> -<<<<<<< yours:sample.txt
> -Conflict resolution is hard;
> -let's go shopping.
> +or cleanly resolved because both sides changed identically.
> +<<<<<<< HEAD
> +Git makes conflict resolution straightforward.
>  =3D=3D=3D=3D=3D=3D=3D
>  Git makes conflict resolution easy.
> ->>>>>>> theirs:sample.txt
> +>>>>>>> main
>  And here is another line that is cleanly resolved or unmodified.
>  ------------

Three items here about the modifications to the conflict marker annotations=
:

(1) The use of "HEAD": For a decade and a half, merges always involved
modifying the worktree as well, which somewhat forced merges to always
be done with HEAD.  With a new merge backend, that is not necessary
anymore, and conflicts can be generated (e.g. by `git log
--remerge-diff` or `git replay` or `git merge-tree`) which do not
involve HEAD.  The use of "HEAD" and "main" might both be considered
suboptimal in the world we are moving into.  For example, perhaps:

    <<<<<<< current_branch ("summary of commit msg that current_branch
points to")
    ...
    >>>>>>> main ("summary of commit main points to")

would be better, especially in cases where the user specified to merge
a hash rather than a branch name.  (Note that this is similar to how
--remerge-diff behaves.)  Of course, I've started to turn this into a
question of what we should change the implementation to, whereas you
were trying to document existing behavior, but sometimes documentation
highlights these subtle things...

(2) Conflict markers carry an extra annotation of the form :FILENAME
whenever the filename differs on the two sides of history, so these
could be e.g. HEAD:sample.txt and main:renamed.txt in a real example.
Granted, most conflicts probably don't involve renamed files, but
would it be more useful from a documentation standpoint to make users
aware of what might be seen?

(3) The use of "real" conflict markers instead of sample ones, meant
that for the diff3 case below you used "81821ce" as the annotation.
The odds of a user having that particular hash is pretty slim, and
feels like much more of a distraction than using some synthetic hash
or label.  More on that below where it comes up.

(All that said, I'm not sure what's best to use for the documentation
right now, but thought these were relevant items to bring up.)

>  The area where a pair of conflicting changes happened is marked with mar=
kers
>  `<<<<<<<`, `=3D=3D=3D=3D=3D=3D=3D`, and `>>>>>>>`.  The part before the =
`=3D=3D=3D=3D=3D=3D=3D`
> -is typically your side, and the part afterwards is typically their side.
> +is typically from the target (where you=E2=80=99re merging into), and th=
e part
> +afterwards is typically from the source (where you=E2=80=99re merging fr=
om).

I dislike the whole "yours" & "theirs" thing.  It would have been fine
as originally designed, but in the UI at some point the terms were
hardcoded and documented to stages 2 & 3 and rebase came along where
those meanings were exactly backwards.  But, it's unfixable now, so
the best we can do is just to avoid these terms.  I'm happy to see
them used one less place here.

> +The default format does not show what the original version contained in =
the
> +conflicting area.  You cannot tell how many lines have been deleted and
> +replaced on either side. The only thing you can tell is that the target =
side
> +says "straightforward", while the source side says "easy".
>
> -The default format does not show what the original said in the conflicti=
ng
> -area.  You cannot tell how many lines are deleted and replaced with
> -Barbie's remark on your side.  The only thing you can tell is that your
> -side wants to say it is hard and you'd prefer to go shopping, while the
> -other side wants to claim it is easy.
> +You can use an alternative conflict marker style by setting the
> +`merge.conflictStyle` configuration variable to either "diff3" or "zdiff=
3".
> +Both of these styles show the original version of the conflicted area, w=
hich
> +may help you find a better resolution.
>
> -An alternative style can be used by setting the "merge.conflictStyle"
> -configuration variable to either "diff3" or "zdiff3".  In "diff3"
> -style, the above conflict may look like this:
> +In the "diff3" style, the above conflict looks like this:
>
>  ------------
>  Here are lines that are either unchanged from the common
>  ancestor, or cleanly resolved because only one side changed,
> -<<<<<<< yours:sample.txt
> -or cleanly resolved because both sides changed the same way.
> -Conflict resolution is hard;
> -let's go shopping.
> -||||||| base:sample.txt
> +<<<<<<< HEAD
>  or cleanly resolved because both sides changed identically.
> +Git makes conflict resolution straightforward.
> +||||||| 81821ce

Here's what I was referring to above.  "Using real values" ends up
causing us to use a value (81821ce) that a user would basically never
see, and thus seems more likely to confuse them than using a
descriptive term or even a fake hash (such as "aaaaaaa").

> +or cleanly resolved because both sides changed the same way.
>  Conflict resolution is hard.
>  =3D=3D=3D=3D=3D=3D=3D
> -or cleanly resolved because both sides changed the same way.
> +or cleanly resolved because both sides changed identically.
>  Git makes conflict resolution easy.
> ->>>>>>> theirs:sample.txt
> +>>>>>>> main
>  And here is another line that is cleanly resolved or unmodified.
>  ------------
>
> -while in "zdiff3" style, it may look like this:
> +while in the "zdiff3" style, it looks like this:

The insertion of "the" surprises me.  It reads better without it to
me, but I don't know if I'm just used to some grammar rule being
violated or something.  Why is "the" necessary here?

>  ------------
>  Here are lines that are either unchanged from the common
>  ancestor, or cleanly resolved because only one side changed,
> -or cleanly resolved because both sides changed the same way.
> -<<<<<<< yours:sample.txt
> -Conflict resolution is hard;
> -let's go shopping.
> -||||||| base:sample.txt
>  or cleanly resolved because both sides changed identically.
> +<<<<<<< HEAD
> +Git makes conflict resolution straightforward.
> +||||||| 81821ce
> +or cleanly resolved because both sides changed the same way.
>  Conflict resolution is hard.
>  =3D=3D=3D=3D=3D=3D=3D
>  Git makes conflict resolution easy.
> ->>>>>>> theirs:sample.txt
> +>>>>>>> main
>  And here is another line that is cleanly resolved or unmodified.
>  ------------
>
> -In addition to the `<<<<<<<`, `=3D=3D=3D=3D=3D=3D=3D`, and `>>>>>>>` mar=
kers, it uses
> -another `|||||||` marker that is followed by the original text.  You can
> -tell that the original just stated a fact, and your side simply gave in =
to
> -that statement and gave up, while the other side tried to have a more
> -positive attitude.  You can sometimes come up with a better resolution b=
y
> -viewing the original.
> +The original commit SHA and text are shown after another marker, `||||||=
|`.
> +This region lets you now see that both sides made the edit from "the sam=
e
> +way" to "identically", as well as editing the following line.  The "diff=
3"
> +style keeps all changed lines within the markers, whilst the "zdiff3" st=
yle
> +moves the commonly edited line before the marker.

The comment you added here about zdiff3 is correct in context, but
feels misleading in general.  commonly edited lines at the beginning
of the two sides are moved before the conflict markers, commonly
edited lines at the ending of the two sides are moved after the
markers, and commonly edited lines anywhere else are left where they
are.
