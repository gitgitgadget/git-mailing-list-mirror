Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EA2264C0
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233443; cv=none; b=OC4lDNP8MtDkIsZQnrKUGp1v6k5LE/+zEqzqK+UFv27EfD5VcLQ/gVwwdOYnOqHYW00HDhSrjv9kAYwsU1kjTQL+5M7VTCzt7C8yqgl2urmekbzdO4POhFCkktdIDOSPdoWun8buxYY/Z0tyYHViNRqOjAlh+cYVrngTRtaCUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233443; c=relaxed/simple;
	bh=edChDUJKPb8GW/cm3pQiW5bQpaU05EaYf12ZZ9lWSQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXRpB/fbtIMchW1W+KuXB6inVMpzPt+CowuX3OIOj/Mgb72BVJCofw/3HwDDt0G68ffV6D397R1kf5+QVH7jrOS4HVZto+bc50z3VvmVmGqLQkbU1XlhwSCJCugDd4hVpytuvd0Xxz4ZTMYqgKI5+xCLPVRD8fF1lRAmMtRlgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCKu78ot; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCKu78ot"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3eb6da24943so36768635ab.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756233440; x=1756838240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtgHZfNxPLO+rtUhGmlaCSu9SwfZsLJx927uDi/7rVQ=;
        b=GCKu78ot6LmGGCigiq45wdT5kcrOOaCtLhRQ8l4TywW7SeJp7/N9vITkzN9EhhfZX+
         oVaiGvRaW6LdHJLuUIkohNVr38nJKCeJMhmYMcysNggcUe2TNF9eBExwQoXJtnYznuAR
         Oj0y4II4S7izky5c2HW2W1w3h4GZ/SDmTlHuJVPWPt2fWl0CN4Lair0fvQRwH75Leba1
         Y5rgRiYfz6eDIG61E8416/tggiG53GEiXfkIQDmdgNHjCqbNZRdWBRtoxCf+ZGmCqzda
         u5zlGHvihymqKRUg8gI+4Q4fLUOR+3C8lhQ5aqlCOZtplGHxj+cT0x+zgntZ301+uMVI
         rqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233440; x=1756838240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtgHZfNxPLO+rtUhGmlaCSu9SwfZsLJx927uDi/7rVQ=;
        b=T7NLb/YWbEebvJtZn4syl1LAltkZgZ70Cd8IZiaapow5IIah+A+HuKoSd+P+75muEc
         TIl6BaWraGxhOPDK7V3dPuchFTuqBghoy9lAWG4VmQaY3/aMswPwjsedx2finWJvdI4+
         8t0EIPllCXdNWat0pPF7EE4/2MawUJk07zb/q1ejVJcl8tYAiB16IvQr8C0SZfTB+wpw
         UMI4u+fi6NwqkIrKa2Mq/zCBU5as2xe3xdB5kBvN9tbWUDgA7wcS8/Fx+lnSDfdeWD3l
         l7m8oKxgkP/Y7tdDEF7tuDvoeTXieE4Gxbt/kfrI3BWBwudaY+YNL/cyeaP1R7yWUyN5
         nxLA==
X-Gm-Message-State: AOJu0Yy9FqdZ/jR9tiGgPQ2LH1lGptBFxATWFlvuMh+Ek26lH3vxvx0P
	7XIWB0R+ctn9b3gYbZ3C8b87koyn041czw8POudx9ZRqYX9qE64DI5t7E/0WUyocPKTyTget2vr
	qw/OZxkqGNFsQqY1RwOfkaHhvp+C8yofHmA==
X-Gm-Gg: ASbGncsrLe2iWza4Bg/EKVXeyY/ODAPxem12XYnInPVSZ/3v2mJvqIv25iICT5Ugn1w
	Jxb30Nr+QzwSufxrq5bIeRN9UI3c8negrsOyqoccBpaSPCHi8F8ULnNCXPgvTfoxQQOVjgSgGJ1
	hrgfsCoEVlVHOD0etbuFOmzPvaUnEtQtRORY52prf9pIjStTjOaYaen4DAsOYzIc2cgCNuguooL
	tP16JvsXI0ik/jzjB4oaVQO5dLYJIC0OZiynBVWdx1dmv9uovg=
X-Google-Smtp-Source: AGHT+IFo/hWqOjWCt7RUiBrkNBAIIlUsP14OPpCkEwEdlrgcZXqIBJmUhHLuAuzf9gVkLjTqGUDhe84boQGvlfnWk80=
X-Received: by 2002:a05:6e02:2591:b0:3e5:3520:4a75 with SMTP id
 e9e14a558f8ab-3e922ad5276mr241992475ab.23.1756233439972; Tue, 26 Aug 2025
 11:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
In-Reply-To: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Aug 2025 11:37:08 -0700
X-Gm-Features: Ac12FXyYmlQN5yVXQVuE-fWHq3cTesmBYILH2TmmLeKcpYIUa34pdZH97RSkZgQ
Message-ID: <CABPp-BE-FrvWHiskk3t7ePG9NWmj8E5FaFfxk6JGF4ztYVQt0w@mail.gmail.com>
Subject: Re: [PATCH] ls-files: conditionally leave index sparse
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:13=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> When running 'git ls-files' with a pathspec, the index entries get
> filtered according to that pathspec before iterating over them in

When I first read this patch, I missed this part of your commit
message and figured there was no possible way your patch could
actually speed things up.  I verified with your testcase that it
worked, though, and had to step through a debugger to find out what I
was missing.  It's the prune_index() call in cmd_ls_files() that does
this -- but only when the pathspecs provided have some common prefix.
So, it's not unique to when there's a single pathspec as your commit
message claims, and the pointer to prune_index() may have helped save
me some head-scratching in review the patch.

Perhaps this could be clarified here (and made more explicit for folks
like me that gloss over it), something like

When running 'git ls-files' with pathspecs with a common prefix, the
index entries get
filtered according to that common prefix in prune_index() before
iterating over them in show_files().

> show_files().  In 78087097b8 (ls-files: add --sparse option,
> 2021-12-22), this iteration was prefixed with a check for the '--sparse'
> option which allows the command to output directory entries; this
> created a pre-loop call to ensure_full_index().
>
> However, when a user runs 'git ls-files' where the pathspec matches
> directories that are recursively matched in the sparse-checkout, there
> are not any sparse directories that match the pathspec so they would not
> be written to the output. The expansion in this case is just a
> performance drop for no behavior difference.
>
> Replace this global check to expand the index with a check inside the
> loop for a matched sparse directory. If we see one, then expand the
> index and continue from the current location. This is safe since the
> previous entries in the index did not have any sparse directories and
> thus would remain stable in this expansion.
>
> A test in t1092 confirms that this changes the behavior.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     ls-files: conditionally leave index sparse
>
>     Here's a small sparse index performance update based on a user report=
.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1955%2F=
derrickstolee%2Fls-files-sparse-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1955/derri=
ckstolee/ls-files-sparse-index-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1955
>
>  builtin/ls-files.c                       | 13 ++++++++++---
>  t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index c06a6f33e41..b148607f7a1 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -414,14 +414,21 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
>         if (!(show_cached || show_stage || show_deleted || show_modified)=
)
>                 return;
>
> -       if (!show_sparse_dirs)
> -               ensure_full_index(repo->index);
> -
>         for (i =3D 0; i < repo->index->cache_nr; i++) {
>                 const struct cache_entry *ce =3D repo->index->cache[i];
>                 struct stat st;
>                 int stat_err;
>
> +               if (S_ISSPARSEDIR(ce->ce_mode) && !show_sparse_dirs) {
> +                       /*
> +                        * This is the first time we've hit a sparse dir,
> +                        * so expansion will leave the first 'i' entries
> +                        * alone.
> +                        */
> +                       ensure_full_index(repo->index);
> +                       ce =3D repo->index->cache[i];
> +               }

I see how this is safe.  I didn't understand how it helped performance
until I figured out by stepping through that repo->indexc->cache_nr is
much less than I expected, because of the prune_index() call that
happened earlier.

>                 construct_fullname(&fullname, repo, ce);
>
>                 if ((dir->flags & DIR_SHOW_IGNORED) &&
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index d8101139b40..b0f691c151a 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1506,6 +1506,8 @@ test_expect_success 'sparse-index is not expanded' =
'
>         ensure_not_expanded reset --hard &&
>         ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 =
&&
>
> +       ensure_not_expanded ls-files deep/deeper1 &&
> +

Thanks, this testcase is exactly what I needed to figure out what I
was misunderstanding.

>         echo >>sparse-index/README.md &&
>         ensure_not_expanded add -A &&
>         echo >>sparse-index/extra.txt &&
> @@ -1607,6 +1609,17 @@ test_expect_success 'describe tested on all' '
>         test_all_match git describe --dirty
>  '
>
> +test_expect_success 'ls-files filtering and expansion' '
> +       init_repos &&
> +
> +       # This filtering will hit a sparse directory midway
> +       # through the iteration.
> +       test_all_match git ls-files deep &&
> +
> +       # This pathspec will filter the index to only a sparse
> +       # directory.
> +       test_all_match git ls-files folder1
> +'

Looks good.
