Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC206481CD
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274860; cv=none; b=LfuMSr3PNRUxrLChu/Mqf5GkBMf/i3L2biL4W2abYWKXZJQgRxTddR4MOqUJlQWqV0POOhvM+K/oIg3YblnfrmtnF7V3fLC6Vr6M3IcmjxRBBtW39JyilMEn84bhN5IYCmU1sOwRcyKbUEuVz7Jb/s/2Nu5YYa4wGZNpDXdJfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274860; c=relaxed/simple;
	bh=9FEQ6HAUzUHvkuyswlUIVaNeiAk6l4eHgs1UoxKkp7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwLZu3N9mK6cLifYiSm9YqfmASCDoGtu/Je+jvw2P9+et0SRpwPiQBz9a/xWRbSbkn+Z1Tkn/xXWzwcpTShH+ZYCKPyzCIylBnquy4yliTrQ44hRmNO1YHtsBlxNbpr7Gxg8WOKq0I8jHObqFip68SoZvYQzD8fDLe19aciDVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU3bXoOl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU3bXoOl"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85add67e9c1so30259039f.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741274858; x=1741879658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjRhizDdf2QSXO4SrN62PWO9uVFf/YwA+QY2MQ2HEYE=;
        b=dU3bXoOlLFDPdlX6ZU5gCfELfboQxorOp+bhgiiU9PxQHSP0uQtbByvDWdTBXgSuKC
         6l6+51MYhMh5zjZIqrC9Givi6ZlppVpzmZCO8YEEvOnzuPyIyNd0kcBSu7nTCa1uvFSG
         DagnCfDaveIqhQy0dXADj21PGvm6g9abbk4y4mJI85LTGdYjIBo8Potrxt4Fs4nbnvBN
         h5WdKwaEfBHeYZJaHRz78a4aWucAwVClFmgY1ltlZIsxQ7gI3r0Dd7miQtzcMo37TSMm
         1uCTUDLaDOaQycn+vkNM7d6T8ziAJoJrdmXSeDJJlvsqYZbJ4cx+gmANr2VjpDobxrZE
         k/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741274858; x=1741879658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjRhizDdf2QSXO4SrN62PWO9uVFf/YwA+QY2MQ2HEYE=;
        b=mi/A14H8ZrLp4MhKtd/8xo66HPrtl3wx9wM8Idz2AjBUMbn7Cms/3+BDFAeaqnrSOD
         DY3ZV3ypzoQawVPpLKkFVX8TkCetS9Ft3x2DhBLOqXGnuFBwgdlA/50C5hcq9r51/Gp1
         XmRR4ug0nqcCB+79hZEvdH6LZQS2Vgmy8876pvCp86Z3gV+AHjWsiA2y7qw/UUMLbVMm
         g8ITiTfNLMmIMk/qIQqpT4ehNT9mzB/mOrLJM1xgF7Be0Qdy54HzpBOUCknVxTW+g1hQ
         wroX0CTfhUZTag3rCrdNzmBvdewpBgX3tJp07wveFUdhjEZHiQPpP6v+BEDm+2OymhDP
         pFGA==
X-Gm-Message-State: AOJu0YxRB5Whpp7WKp2wtSt28EoOrvd9v+32Pl/kbXLfK1kswL4AuKxe
	Z4ckcp5pWUVi1xjRhmtn8If6NRHZz8hybc6C/MLf8/V8ZYIYDkysnxrI9/BZ2hvUyVdZiURB+W2
	3yLcs7DMNFbICc/ymz6jsnaosMaM=
X-Gm-Gg: ASbGnctqDGNDD0s27rXvd+D+KCYXGUtVtuzB1z7qPf8aG33gMl+stjoR8XLOxlg19dV
	sc3shXkf5PGobCtNdHN2EZEjvyorxG+YapEiGxkcDIYUy5Ci/CZjPZKcgTRoVNkR4RykPu/AA6q
	ABWRoMajbwnpZGfM6HeNBd2cVzpgcH
X-Google-Smtp-Source: AGHT+IGdfxSrChQFeSsgnBn7jRIlz9ZWu7sdh+kk2ZVw5D8yMDoqGGBR5fGcK4BoTQZTmQ1w1yrg8Q4Gc5Hd4lFHruw=
X-Received: by 2002:a05:6602:80b:b0:855:a287:12d0 with SMTP id
 ca18e2360f4ac-85b0e9b7c70mr342820539f.0.1741274857669; Thu, 06 Mar 2025
 07:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921024533.15249-1-dgoncharov@users.sf.net> <20240921024533.15249-2-dgoncharov@users.sf.net>
In-Reply-To: <20240921024533.15249-2-dgoncharov@users.sf.net>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Mar 2025 07:27:25 -0800
X-Gm-Features: AQ5f1JrJyh3cbmaxsvWBXfQVvr91LcFB0-x93A0gwfun_6ivgPcjidwVuR_s8os
Message-ID: <CABPp-BFX-HewJWXMRNVMasGOUAuhSn7Pwx9Ls4Virz7fnOqxEA@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix a crash in process_renames
To: dgoncharov@users.sf.net
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I apologize for the very delayed response...

On Fri, Sep 20, 2024 at 7:46=E2=80=AFPM <dgoncharov@users.sf.net> wrote:
>
> From: Dmitry Goncharov <dgoncharov@users.sf.net>
>
> cherry-pick --strategy=3Dort (the default at the moment) crashes in the f=
ollowing
> scenario

Good job, you found a testcase that caused both `ort` and `recursive`
to fail.  :-)

For other readers, I'll note that this isn't special to cherry-pick; I
can also reproduce using merge for example.

> $ ls -a
> .  ..
> $ mkdir tools
> $ git init -q -b side2
> $ echo hello>tools/hello
> $ git add  tools/hello
> $ git commit -q tools/hello -m'Add tools/hello.'
> $ git branch side1
> $ echo world>world
> $ git add world
> $ git commit -q world -m'Add world.'
> $ git mv  world tools/world
> $ git commit -q -m'mv world tools/world.'
> $ git checkout -q side1
> $ git mv tools/hello hello
> $ git commit -q -m'mv tools/hello hello.'
> $ git cherry-pick --strategy=3Dort side2
> git: merge-ort.c:3006: process_renames: Assertion `source_deleted || oldi=
nfo->filemask & old_sidemask' failed.
> Aborted (core dumped)

Thanks for putting together a testcase; very helpful.  And you even
provided it in the form of a patch, and provided an attempted fix;
very nice!

> While cherry picking the top commit from side2 to side1 collect_renames i=
s
> confused by the preceding move from "tools/hello" to "hello" that took pl=
ace on
> side1. This move from "tools/hello" to "hello" causes the logic in
> check_for_directory_rename to incorrectly conclude that "tools/world" sho=
uld be
> renamed to "world".  detect_and_process_renames proceeds with "world" ins=
tead
> of "tools/world" and ends up tripping on an assertion in process_renames.
>
> In the same scenario cherry-pick --strategy=3Drecursive detects a merge c=
onflict.
>
> $ rm .git/index.lock
> $ git reset -q --hard
> $ git cherry-pick --strategy=3Drecursive side2
> CONFLICT (file location): world renamed to tools/world in fead592 (mv wor=
ld tools/world.), inside a directory that was renamed in HEAD, suggesting i=
t should perhaps be moved to world.
> CONFLICT (content): Merge conflict in world

Yes, this is the correct resolution...

> error: cache entry has null sha1: world
> error: cherry-pick: Unable to write new index file
> fatal: cherry-pick failed

...but it looks like the recursive backend still trips up on it, just
not until after it prints the conflict message.  It shouldn't fail to
write out a new index file; while it got further than ort, that's
still pretty bad.

> There really is a merge conflict and the goal of this commit is to have
> cherry-pick --strategy=3Dort detect the conflict.  This commit modifies
> collect_renames to ignore an implicit directory rename that suggests movi=
ng a
> file to itself.
>
> Also, see test t3515-cherry-pick-move.sh.
>
> Signed-off-by: Dmitry Goncharov <dgoncharov@users.sf.net>
> ---
>  merge-ort.c                 |  9 +++++++
>  t/t3515-cherry-pick-move.sh | 48 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100755 t/t3515-cherry-pick-move.sh
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 691db9050e..e58fb7a7fa 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3369,6 +3369,15 @@ static int collect_renames(struct merge_options *o=
pt,
>                                                       collisions,
>                                                       &clean);
>
> +               if (new_path && !strcmp(new_path, p->one->path)) {
> +                       /* Ignore an implicit directory rename that sugge=
sts replacing a move
> +                        * from one->path to two->path with a move
> +                        * from one->path to one->path.
> +                        */
> +                       free(new_path);
> +                       new_path =3D NULL;
> +               }

Unfortunately, this solution makes it display the wrong conflict
message, which I think could be quite confusing for the user:

CONFLICT (rename/delete): world renamed to tools/world in dac8a10
(Move world into tools/), but deleted in HEAD.

The file was not deleted in HEAD.  HEAD moved `tools/hello` to
`hello`, so the only thing it could have been said to delete was
`tools/hello`, not `world`.  So I appreciate the attempt to fix, but I
don't think this solution is quite right.

> +
>                 possibly_cache_new_pair(renames, p, side_index, new_path)=
;
>                 if (p->status !=3D 'R' && !new_path) {
>                         pool_diff_free_filepair(&opt->priv->pool, p);
> diff --git a/t/t3515-cherry-pick-move.sh b/t/t3515-cherry-pick-move.sh
> new file mode 100755
> index 0000000000..20af478d4e
> --- /dev/null
> +++ b/t/t3515-cherry-pick-move.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description=3D'Test cherry-picking a move commit.'
> +
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dside2
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       mkdir tools &&
> +
> +       echo hello >tools/hello &&
> +
> +       git add tools/hello &&
> +       git commit -m"Add tools/hello." tools/hello &&
> +
> +       git branch side1 &&
> +
> +       # This commit is the base of the fatal cherry-pick merge.
> +       echo world >world &&
> +       git add world &&
> +       git commit -m"Add world." &&
> +
> +       # Cherry picking this commit crashes git.
> +       # This commit is side 2 of the fatal cherry-pick merge.
> +       git mv -v world tools/world &&
> +       git commit -m"mv world tools/world." &&
> +
> +       git checkout side1 &&
> +       # This commit is side 1 of the fatal cherry-pick merge.
> +       git mv -v tools/hello hello &&
> +       git commit -m"mv tools/hello hello"
> +'

Thanks for including this.  I have a slight preference to include this
in a related testsuite rather than introducing a new testsuite file
just for it.

> +
> +test_expect_success 'recursive cherry-pick of a move commit' '
> +       test_must_fail git cherry-pick --strategy=3Drecursive side2
> +'

Yes, but this doesn't really test that the `recursive` strategy fails
appropriately.  In particular, the error messages you showed above
pointed out that the recursive backend failed to write a new index
file, leaving the working tree and index out of sync.

However, since I have some patches to delete the recursive backend
(and remap it to ort), I think it makes sense to just drop this and
not worry about recursive.

> +
> +test_expect_success 'ort cherry-pick of a move commit' '
> +       rm -f world &&
> +       git reset --hard &&
> +       test_must_fail git cherry-pick --strategy=3Dort side2
> +'

Thanks for sending this in and even for pinging on it.  I kept it in
my notes, even though I didn't have time back then to respond.  I did
forget about it for a while, but came back after re-checking my notes.

Anyway, I've got a couple patches, the first with your testcase moved
and adjusted slightly to fit into the existing t6423 with you as the
author, and a second patch with an alternate fix.  I'll submit them
shortly.
