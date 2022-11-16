Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58858C4321E
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 03:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKPDSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 22:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKPDSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 22:18:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C262DA
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 19:18:12 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so19487525ybb.6
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX63cvKP/0V42qOcB+9DWrusxx3+Sx36cO14Pun16dk=;
        b=Lcl5if/9l4FM1Nrm8NrCxZaiBWU5vv7y+oNwo7L93irbvs9e9HMVXiep4EfLZ3Raja
         K/MV900ABkhZU9u6ItFIwCmdCtfp2ev8WD50nqpxCreUdMJ7FkVljUp7cR8Pk2maFykG
         5Ccotjj1TQyp672PbeUsJ2PTunWahHf33OBEuYzVMSjrZXfGFfPqjGVodoXogGGJm1lE
         0r99D/wVSgNooBprwQbW99GC0JE1fiVmqz6NqzJV9HhIeYWLSncEEGOLkxGFdyctPigg
         0gk2X9UI821H3tZs/7M4O/8k2p7ukNM9bolIprbZtinQyXiZr3guUvRLoPHYb40/2wV1
         DU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX63cvKP/0V42qOcB+9DWrusxx3+Sx36cO14Pun16dk=;
        b=s/QuKBPFJe29+smb+SwZb7bHmcgBB2/LCzF2/7H+vA17iPgfFMbEfQJ9mi2lXDnCpv
         u/W8Vy0WsstyCA9wyMvVb4oxP0zcYOcGNkpf7psyPxfxPCLW7EgKb7SZ+8AXumtrnMyX
         Qb/N3VgSbRWSr3l8YEX0mWuB3EYuaKZ4OfJ0Xs7MbVjwYoBngcGn40VtTe5ZHMaDgcA2
         yzLJ4Z/KKjmKtZwlSChBS+yB+YXn1z0Rbwh9E9p6xJCK5W9LnNhtQ0q79rki6ZQOmTK7
         B688tGUWcl5XF8PJy9aTUTNp1U1KFrDBZjKxfGESmORsg+F3H4D5gCwnwt2hhtpy0fCE
         2Z0A==
X-Gm-Message-State: ANoB5pkoZ7br7yNpoCk+mMSZpuGh7EyV7ekUUmNmmwg7/NrtJldxhE8+
        dhdxxsCa4JEIVWnnhPFLCzZWHLdxJ6ZHZ4N/6pw=
X-Google-Smtp-Source: AA0mqf4RQPJ8MtbtyQYlauIHwCrRL6kR3rEdPes0SRnbx2m3hITpqYV/Njyqz1esOrmw0H/u+dI6aL9b62wsaHGTR3g=
X-Received: by 2002:a25:8f91:0:b0:6dd:5646:21b3 with SMTP id
 u17-20020a258f91000000b006dd564621b3mr19632704ybl.300.1668568692016; Tue, 15
 Nov 2022 19:18:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
In-Reply-To: <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 16 Nov 2022 11:18:00 +0800
Message-ID: <CAOLTT8T39Q4q5W2BaFVkm81T7mRc1UvT2MN07XHGT5qpB7ZMHQ@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C 12:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=
=B9=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > From: Elijah Newren <newren@gmail.com>
> >
> > Once upon a time, Matheus wrote some patches to make
> >    git grep [--cached | <REVISION>] ...
> > restrict its output to the sparsity specification when working in a
> > sparse checkout[1].  That effort got derailed by two things:
> >
> >   (1) The --sparse-index work just beginning which we wanted to avoid
> >       creating conflicts for
> >   (2) Never deciding on flag and config names and planned high level
> >       behavior for all commands.
> >
> > More recently, Shaoxuan implemented a more limited form of Matheus'
> > patches that only affected --cached, using a different flag name,
> > but also changing the default behavior in line with what Matheus did.
> > This again highlighted the fact that we never decided on command line
> > flag names, config option names, and the big picture path forward.
> >
> > The --sparse-index work has been mostly complete (or at least released
> > into production even if some small edges remain) for quite some time
> > now.  We have also had several discussions on flag and config names,
> > though we never came to solid conclusions.  Stolee once upon a time
> > suggested putting all these into some document in
> > Documentation/technical[3], which Victoria recently also requested[4].
> > I'm behind the times, but here's a patch attempting to finally do that.
> >
> > [1] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74=
a.1612901326.git.matheus.bernardino@usp.br/
> >     (See his second link in that email in particular)
> > [2] https://lore.kernel.org/git/20220908001854.206789-2-shaoxuan.yuan02=
@gmail.com/
> > [3] https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRC=
vYSb8akxAJgA@mail.gmail.com/
> >     (Scroll to the very end for the final few paragraphs)
> > [4] https://lore.kernel.org/git/cafcedba-96a2-cb85-d593-ef47c8c8397c@gi=
thub.com/
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     sparse-checkout.txt: new document with sparse-checkout directions
> >
> >     v2 and v3 didn't get any reviews (I know, I know, this document is
> >     really long), but it's been nearly a month and this patch is still
> >     marked as "Needs Review", so I'm hoping sending a v4 will encourage
> >     feedback. I think it's good enough to accept and start iterating, b=
ut
> >     want to be sure others agree.
> >
> >     As before, I think we're starting to converge on actual proposals;
> >     there's some areas we've agreed on, others we've compromised on, an=
d
> >     some we've just figured out what the others were saying. The discus=
sion
> >     has been very illuminating; thanks to everyone who has chimed in. I=
've
> >     tried to take my best stab at cleaning up and culling things that d=
on't
> >     need to remain as open questions, but if I've mis-represented anyon=
e or
> >     missed something, don't hesitate to speak up. Everything is still o=
pen
> >     for debate, even if not marked as a currently open question.
> >
> >     Changes since v3:
> >
> >      * A few minor wording cleanups here and there, and one paragraph m=
oved
> >        to keep similar things together.
> >
> >     Changes since v2:
> >
> >      * Compromised with Stollee on log -- Behavior A only affects
> >        patch-related operations, not revision walking
> >      * Incorporated Junio's suggestions about untracked file handling
> >      * Added new usecases, one brought up by Martin, one by Stolee
> >      * Added new sections:
> >        * Usecases of primary concern
> >        * Oversimplified mental models ("Cliff Notes" for this document!=
)
> >      * Recategorization of a few commands based on discussion
> >      * Greater details on how index operations work under Behavior A, t=
o
> >        avoid weird edge cases
> >      * Extended explanation of the sparse specification, particularly w=
hen
> >        index differs from HEAD
> >      * Switched proposed flag names to --scope=3D{sparse,all} to avoid =
binary
> >        flags that are hard to extend
> >      * Switched proposed config option name (still need good values and
> >        descriptions for it, though)
> >      * Removed questions we seemed to have agreement on. Modified/exten=
ded
> >        some existing questions.
> >      * Added Stolee's sparse-backfill ideas to the plans
> >      * Additional Known bugs
> >      * Various wording improvements
> >      * Possibly other things I've missed.
> >
> >     Changes since v1:
> >
> >      * Added new sections:
> >        * "Terminology"
> >        * "Behavior classes"
> >        * "Sparse specification vs. sparsity patterns"
> >      * Tried to shuffle commands from unknown into appropriate sections
> >        based on feedback, but I got some conflicting feedback, so...who
> >        knows if thing are in the right place
> >      * More consistency in using "sparse specification" over other term=
s
> >      * Extra comments about how add/rm/mv operate on moving files acros=
s the
> >        tracked/untracked boundary
> >      * --restrict-but-warn should have been "restrict or error", but
> >        reworded even more heavily as part of "Behavior classes" section
> >      * Added extra questions based on feedback (--no-expand, update-ind=
ex
> >        stuff, apply --index)
> >      * More details on apply/am bugs
> >      * Documented read-tree issue
> >      * A few cases of fixing line wrapping at <=3D80 chars
> >      * Added more alternate name suggestions for options instead of
> >        --[no-]restrict
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1367%=
2Fnewren%2Fsparse-checkout-directions-v4
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1367/new=
ren/sparse-checkout-directions-v4
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1367
> >
> >  Documentation/technical/sparse-checkout.txt | 1103 +++++++++++++++++++
> >  1 file changed, 1103 insertions(+)
> >  create mode 100644 Documentation/technical/sparse-checkout.txt
> >
> > diff --git a/Documentation/technical/sparse-checkout.txt b/Documentatio=
n/technical/sparse-checkout.txt
> > new file mode 100644
> > +=3D=3D=3D Terminology =3D=3D=3D
> > +
> > +sparse directory: An entry in the index corresponding to a directory, =
which
> > +       appears in the index instead of all the files under that direct=
ory
> > +       that would normally appear.  See also sparse-index.  Something =
that
> > +       can cause confusion is that the "sparse directory" does NOT mat=
ch
> > +       the sparse specification, i.e. the directory is NOT present in =
the
> > +       working tree.  May be renamed in the future (e.g. to "skipped
> > +       directory").
> > +
> > +sparse index: A special mode for sparse-checkout that also makes the
> > +       index sparse by recording a directory entry in lieu of all the
> > +       files underneath that directory (thus making that a "skipped
> > +       directory" which unfortunately has also been called a "sparse
> > +       directory"), and does this for potentially multiple
> > +       directories.  Controlled by the --[no-]sparse-index option to
> > +       init|set|reapply.
> > +
> > +sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
> > +       define the set of files of interest.  A warning: It is easy to
> > +       over-use this term (or the shortened "patterns" term), for two
> > +       reasons: (1) users in cone mode specify directories rather than
> > +       patterns (their directories are transformed into patterns, but
> > +       users may think you are talking about non-cone mode if you use =
the
> > +       word "patterns"), and (b) the sparse specification might
>
> nit: s/(b)/(2)/g
>
> > +       transiently differ in the working tree or index from the sparsi=
ty
> > +       patterns (see "Sparse specification vs. sparsity patterns").
> > +
> > +sparse specification: The set of paths in the user's area of focus.  T=
his
> > +       is typically just the tracked files that match the sparsity
> > +       patterns, but the sparse specification can temporarily differ a=
nd
> > +       include additional files.  (See also "Sparse specification
> > +       vs. sparsity patterns")
> > +
> > +       * When working with history, the sparse specification is exactl=
y
> > +         the set of files matching the sparsity patterns.
> > +       * When interacting with the working tree, the sparse specificat=
ion
> > +         is the set of tracked files with a clear SKIP_WORKTREE bit or
> > +         tracked files present in the working copy.
>

I found af6a518 (repo_read_index: clear SKIP_WORKTREE bit from files
present in worktree) which maybe a good place to learn about "sparse
specification",
it has a long commit message though.

> I'm guessing what you mean here is:
> Some files are stored with a flag bit of !SKIP_WORKTREE in its index entr=
y.
> But files are "vivifying" (restore to worktree) or new files added to
> index (tracked files),
> they also belong to the sparse specification.
>
> I think we can add some examples to describe these terms.
>
> #!/bin/sh
>
> set -x
>
> rm -rf mono-repo
> git init mono-repo -b main
> (
>   cd mono-repo &&
>   mkdir p1 p2 &&
>   echo a >p1/a &&
>   echo b >p1/b &&
>   echo a >p2/a &&
>   echo b >p2/b &&
>   git add . &&
>   git commit -m ok &&
>   git sparse-checkout set p1 &&
>   git ls-files -t &&
>   echo a >>p1/a &&
>   echo b >>p1/b &&
>   mkdir p2 p3 &&
>   echo next >>p2/a &&
>   echo next >>p3/c &&
>   git add p3/c &&
>   # p2/a and p3/c vivify
>   git ls-files -t &&
>   # compare wortree/commit
>   git --no-pager diff HEAD --name-only
> )
>
> > +       * When modifying or showing results from the index, the sparse
> > +         specification is the set of files with a clear SKIP_WORKTREE =
bit
> > +         or that differ in the index from HEAD.
>
> #!/bin/sh
>
> set -x
>
> rm -rf mono-repo
> git init mono-repo -b main
> (
>   cd mono-repo &&
>   mkdir p1 p2 &&
>   echo a >p1/a &&
>   echo b >p1/b &&
>   echo a >p2/a &&
>   echo b >p2/b &&
>   git add . &&
>   git commit -m ok &&
>   git sparse-checkout set p1 &&
>   git update-index --chmod=3D+x p2/a &&
>   # compare commit/index
>   git --no-pager diff --cached --name-only
> )
>
