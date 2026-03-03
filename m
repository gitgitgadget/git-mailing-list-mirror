Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AC381B09
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563662; cv=pass; b=FVImTtgSu77DFeu2AgNrT+ParuyHXkyZP6O66ZkUFH/p9IcYt6cbzN7kwiiPGLhcZ+YqzjHmM9/U8jbkAuh6Kw3EMd1VfvgIQf8w/c2OohIdiJsu2/NMH+EZD/QK1IgzSwE1Dtlfa0/fv2ITwtkJ4ZzKG5KGJvDzCJ/OwvKpCIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563662; c=relaxed/simple;
	bh=YVDCLCE5T+3ef/dyooSTkVYb262iIs7TI5QbmpBaqZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWZjZTagKKaObS86NU2MbDPTYVNQg83tsh5NM+9kJHM34NmhgopUlL9s/0f/heRbxg8bY+uS7xrwrjwkrmx3GSnXqmB/dd8+5t+T2gIPeLhCRbxzJEsreyiQBjrIPv9x4PS/dCcKn1CslAcQTI+An5q7RXzC0MewqMsNg8GG0L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irSW5xE7; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irSW5xE7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2659056a91.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563660; cv=none;
        d=google.com; s=arc-20240605;
        b=WO5fzJu1GGy3aKQWfaKDMY+vc4hE2580e6BriWUlJ9HNBjZLNZsJTa5rtmmSdZKjfp
         earFy+rB0hiU7W/So5xUrrY2Q4YkYdTqaDLVEgNn8i8v2tybYgzsSrxG6PWRqImQoK0v
         ImBgjOujsoPw63PsJX+NJdbyPhpDljw5jNYQweChputs/A9SrjaqkmoGANhQZIR4qgaH
         LOFUKxNGw29xyXcaJnGxY3foCNGaTN/Pfj+ICnYeiJ8tPpodFt4DZoB/1fmiJxOZc8q+
         Jaad5WrMZbdFnvyGBbzi28+kB9B7sllj9G5J64wHE9OZUHO/b7uuqVNjLUUY8QPZwuu0
         CriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ulH6HBRduD1r6kyHpCTQKX7xHnkkYDbjw7JGBgjC7h0=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=apDZTZqFMnFJe7yetSe2AzYhcfNYZEJWxhHQIwlZxgSM39waOFnonyuG3XvO8Ii8t1
         9vwD0G9WFQQt+del/pV+MSN/6ey7QCfdm9NxNQ8UANxbC90ystRXzaqtq4SmvWUFUFyT
         evv8K3dtUMfVIQKoF90rpUaXi8UawN6Qo61SavrAUXuSF/dDEVTq5YDTkDyXwyIjG7Ck
         ybBOKflwlughnUhVJsJmS+2SN8ozQ+BOgPKmCjhI5ZXrKyiyqDnTVFtpcPmJXA9rD5JD
         smfQV21xINomIAP/M+Od8RtanWFPczHDo7OY6FyJJyWvngzxO9ld5y5PBkOIl0tAi2gO
         h7Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772563660; x=1773168460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulH6HBRduD1r6kyHpCTQKX7xHnkkYDbjw7JGBgjC7h0=;
        b=irSW5xE7wKWT+UG+HKUHmTyVtKJCviApsE8I0dZzStRwm/Lh3yftqA7lcNSj6A9NQe
         u6Vhre7YPIIxliKzQRD5vjO4ZW/DHjQwXN9LYbeR2bo0V79Zu4EIvi6N2kfblQ33cvj6
         oShd0vNg/a9u+AAmiFgtbzfJQbRaDOPadNyg4ZWIq/6BuS5fGKVJQEYSRoPCZigVp94Y
         OK2lhRH3aNybwoDGobtBDpgCxOGQkhmsCCehSVeCiolU0UXGZKprrzieqb2Iw1xLoSE2
         sE3hT0lkRV1cMCBz/e6F9rjpvfoDdjzwKiTHsY6kA8F0Um9Ow7Nv7gzqGQTu6oFe5VAw
         rfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563660; x=1773168460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulH6HBRduD1r6kyHpCTQKX7xHnkkYDbjw7JGBgjC7h0=;
        b=qFPl6CU7u5R7+CCSbOUff6H7GYvcS9XOmsejkUlB5VJXyLfCGloA4nrKySkNuLkGel
         M6KUi1f+jL2TEAMg1PfRWQNySaDBx3S9vqcy/M0G/7xnXTutep8S/Hwba2nZQcWNwKdX
         Ljw0NUrVwIHNeEOVUou3vhN53sOVIkCYK9qp5ZWh2LR/8/Hvy40VUSX/h5iwbep6RWqY
         Hrqv8WN5Yto+yEH9RT0WsyzJp2J0tODrgal0L9dU+xqjmdbIlTjKXHrPt6oENr7XZaDk
         8r2nbQcv8uRlKTjL+HyaAYcU1s5G/AgvwfxsiCFTJQ7b0HlzEp6LEfe53yQt4uiTqzhr
         6zQA==
X-Gm-Message-State: AOJu0YwXd507efDWrA/dZ+HpBZSCNX3ylXb5QFaVUdJRfx6GIwG1kFOp
	2SE4C+c9B8/eorvoLFalSYvDduk15k8rQNuzF8grMV/DraNH+oa2lBPVNdsQ6PnkzHNPlcU1INl
	GVcMB2wVul6ZG3olXmUFYrfSyFOwGZS0=
X-Gm-Gg: ATEYQzyVtkwaIvVuCxdWE3H0r0u47fg4cQR0C+hr13gVggwPpVAgFmOYyQrkHOLMa0v
	gMLHG0c3oiviaP4qak4ISvBZpekvCTeksqhwMPQzmsxDoNwzwcQTzth39vKVmE3ozRrmyCJ0NpL
	IlngSIFSkWSsCYudViisi1PeBHcxUN9yGqHjDqIvSWwK6VWJgXL2oFTnsV/EXnU2nl+RW83aSFk
	vbSG18Aoenx7a3jB4lCyNuXntPxM5/IbQ8tgK9yfLTnBrumPypAQ0H8D8XFpTTtocU1DSCKSQh/
	M1y1hXQvmXHQf2l/FCp0/F5gQh+IjJzx5V0cTq8YVUQu2SZ9pV7HgCqdtdn/kjO79xc9rkNCM1t
	/fifUtEBeT7qvnyxg9za7HmRdqTo=
X-Received: by 2002:a17:90b:3dc6:b0:359:9cb8:db5 with SMTP id
 98e67ed59e1d1-3599cb810a7mr2839548a91.26.1772563659250; Tue, 03 Mar 2026
 10:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im> <20260302-pks-history-split-v1-8-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-8-444fc987a324@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Mar 2026 13:47:27 -0500
X-Gm-Features: AaiRm512OSmABuBxUMbsk-qJFAzH0OunwaOeGkdF91fruICg9Td86cwv1NtfCJ4
Message-ID: <CALnO6CC_UMnQvcyCe37mCan8eASugknK-WbVp-KWXWptvrsJDg@mail.gmail.com>
Subject: Re: [PATCH 8/8] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> It is quite a common use case that one wants to split up one commit into
> multiple commits by moving parts of the changes of the original commit
> out into a separate commit. This is quite an involved operation though:
>
>   1. Identify the commit in question that is to be dropped.
>
>   2. Perform an interactive rebase on top of that commit's parent.
>
>   3. Modify the instruction sheet to "edit" the commit that is to be
>      split up.
>
>   4. Drop the commit via "git reset HEAD~".
>
>   5. Stage changes that should go into the first commit and commit it.
>
>   6. Stage changes that should go into the second commit and commit it.
>
>   7. Finalize the rebase.
>
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.
>
> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
> From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the original
> commit on top of it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  62 ++++
>  builtin/history.c              | 250 ++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3452-history-split.sh       | 757 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 1070 insertions(+)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index cc019de697..24dc907033 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git history reword <commit> [--dry-run] [--update-refs=3D(branches|head)=
]
> +git history split <commit> [--dry-run] [--update-refs=3D(branches|head)]=
 [--] [<pathspec>...]
>
>  DESCRIPTION
>  -----------
> @@ -57,6 +58,26 @@ The following commands are available to rewrite histor=
y in different ways:
>         details of this commit remain unchanged. This command will spawn =
an
>         editor with the current message of that commit.
>
> +`split <commit> [--] [<pathspec>...]`::
> +       Interactively split up <commit> into two commits by choosing
> +       hunks introduced by it that will be moved into the new split-out
> +       commit. These hunks will then be written into a new commit that
> +       becomes the parent of the previous commit. The original commit
> +       stays intact, except that its parent will be the newly split-out
> +       commit.
> ++
> +The commit messages of the split-up commits will be asked for by launchi=
ng
> +the configured editor. Authorship of the commit will be the same as for =
the
> +original commit.
> ++
> +If passed, _<pathspec>_ can be used to limit which changes shall be spli=
t out
> +of the original commit. Files not matching any of the pathspecs will rem=
ain
> +part of the original commit. For more details, see the 'pathspec' entry =
in
> +linkgit:gitglossary[7].

That is quite convenient when changes to 2 independent areas have
become mixed. Nice.

> +It is invalid to select either all or no hunks, as that would lead to
> +one of the commits becoming empty.

Is it easy to make this a no-op? It could be done later if that
suggestion is contentions. But I figure rather than error we can
silently do nothing, since we have performed the desired split. (Or
even use this to split an "--allow-empty" commit, but=E2=80=A6 why that's
desirable, I can't guess.)

So yeah, probably for later.

> +
>  OPTIONS
>  -------
>
> @@ -72,6 +93,47 @@ OPTIONS
>         descendants of the original commit will be rewritten. With `head`=
, only
>         the current `HEAD` reference will be rewritten. Defaults to `bran=
ches`.
>
> +EXAMPLES
> +--------
> +
> +Split a commit
> +~~~~~~~~~~~~~~
> +
> +----------
> +$ git log --stat --oneline
> +3f81232 (HEAD -> main) original
> + bar | 1 +
> + foo | 1 +
> + 2 files changed, 2 insertions(+)
> +
> +$ git history split HEAD
> +diff --git a/bar b/bar
> +new file mode 100644
> +index 0000000..5716ca5
> +--- /dev/null
> ++++ b/bar
> +@@ -0,0 +1 @@
> ++bar
> +(1/1) Stage addition [y,n,q,a,d,p,?]? y
> +
> +diff --git a/foo b/foo
> +new file mode 100644
> +index 0000000..257cc56
> +--- /dev/null
> ++++ b/foo
> +@@ -0,0 +1 @@
> ++foo
> +(1/1) Stage addition [y,n,q,a,d,p,?]? n
> +
> +$ git log --stat --oneline
> +7cebe64 (HEAD -> main) original
> + foo | 1 +
> + 1 file changed, 1 insertion(+)
> +d1582f3 split-out commit
> + bar | 1 +
> + 1 file changed, 1 insertion(+)
> +----------
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/history.c b/builtin/history.c
> index 80726ce14b..dfb9d3f180 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>
>  #include "builtin.h"
> +#include "cache-tree.h"
>  #include "commit.h"
>  #include "commit-reach.h"
>  #include "config.h"
> @@ -8,17 +9,24 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
> +#include "lockfile.h"
> +#include "oidmap.h"
>  #include "parse-options.h"
> +#include "path.h"
> +#include "read-cache.h"
>  #include "refs.h"
>  #include "replay.h"
>  #include "revision.h"
>  #include "sequencer.h"
>  #include "strvec.h"
>  #include "tree.h"
> +#include "unpack-trees.h"
>  #include "wt-status.h"
>
>  #define GIT_HISTORY_REWORD_USAGE \
>         N_("git history reword <commit> [--dry-run] [--update-refs=3D(bra=
nches|head)]")
> +#define GIT_HISTORY_SPLIT_USAGE \
> +       N_("git history split <commit> [--dry-run] [--update-refs=3D(bran=
ches|head)] [--] [<pathspec>...]")
>
>  static void change_data_free(void *util, const char *str UNUSED)
>  {
> @@ -484,6 +492,246 @@ static int cmd_history_reword(int argc,
>         return ret;
>  }
>
> +static int write_ondisk_index(struct repository *repo,
> +                             struct object_id *oid,
> +                             const char *path)
> +{
> +       struct unpack_trees_options opts =3D { 0 };
> +       struct lock_file lock =3D LOCK_INIT;
> +       struct tree_desc tree_desc;
> +       struct index_state index;
> +       struct tree *tree;
> +       int ret;
> +
> +       index_state_init(&index, repo);
> +
> +       opts.head_idx =3D -1;
> +       opts.src_index =3D &index;
> +       opts.dst_index =3D &index;
> +
> +       tree =3D repo_parse_tree_indirect(repo, oid);
> +       init_tree_desc(&tree_desc, &tree->object.oid, tree->buffer, tree-=
>size);
> +
> +       if (unpack_trees(1, &tree_desc, &opts)) {
> +               ret =3D error(_("unable to populate index with tree"));
> +               goto out;
> +       }
> +
> +       prime_cache_tree(repo, &index, tree);
> +
> +       if (hold_lock_file_for_update(&lock, path, 0) < 0) {
> +               ret =3D error_errno(_("unable to acquire index lock"));
> +               goto out;
> +       }
> +
> +       if (write_locked_index(&index, &lock, COMMIT_LOCK)) {
> +               ret =3D error(_("unable to write new index file"));
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       rollback_lock_file(&lock);
> +       release_index(&index);
> +       return ret;
> +}
> +
> +static int split_commit(struct repository *repo,
> +                       struct commit *original,
> +                       struct pathspec *pathspec,
> +                       struct commit **out)
> +{
> +       struct interactive_options interactive_opts =3D INTERACTIVE_OPTIO=
NS_INIT;
> +       struct strbuf index_file =3D STRBUF_INIT;
> +       struct index_state index =3D INDEX_STATE_INIT(repo);
> +       const struct object_id *original_commit_tree_oid;
> +       const struct object_id *old_tree_oid, *new_tree_oid;
> +       struct object_id parent_tree_oid;
> +       char original_commit_oid[GIT_MAX_HEXSZ + 1];
> +       struct commit *first_commit, *second_commit;
> +       struct commit_list *parents =3D NULL;
> +       struct tree *split_tree;
> +       int ret;
> +
> +       if (original->parents) {
> +               if (repo_parse_commit(repo, original->parents->item)) {
> +                       ret =3D error(_("unable to parse parent commit %s=
"),
> +                                   oid_to_hex(&original->parents->item->=
object.oid));
> +                       goto out;
> +               }
> +
> +               parent_tree_oid =3D *get_commit_tree_oid(original->parent=
s->item);
> +       } else {
> +               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +       }
> +       original_commit_tree_oid =3D get_commit_tree_oid(original);
> +
> +       /*
> +        * Construct the first commit. This is done by taking the origina=
l
> +        * commit parent's tree and selectively patching changes from the=
 diff
> +        * between that parent and its child.
> +        */
> +       repo_git_path_replace(repo, &index_file, "%s", "history-split.ind=
ex");
> +
> +       ret =3D write_ondisk_index(repo, &parent_tree_oid, index_file.buf=
);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret =3D read_index_from(&index, index_file.buf, repo->gitdir);
> +       if (ret < 0) {
> +               ret =3D error(_("failed reading temporary index"));
> +               goto out;
> +       }
> +
> +       oid_to_hex_r(original_commit_oid, &original->object.oid);
> +       ret =3D run_add_p_index(repo, &index, index_file.buf, &interactiv=
e_opts,
> +                             original_commit_oid, pathspec, ADD_P_DISALL=
OW_EDIT);
> +       if (ret < 0)
> +               goto out;
> +
> +       split_tree =3D write_in_core_index_as_tree(repo, &index);
> +       if (!split_tree) {
> +               ret =3D error(_("failed split tree"));
> +               goto out;
> +       }
> +
> +       unlink(index_file.buf);
> +       strbuf_release(&index_file);
> +
> +       /*
> +        * We disallow the cases where either the split-out commit or the
> +        * original commit would become empty. Consequently, if we see th=
at the
> +        * new tree ID matches either of those trees we abort.
> +        */
> +       if (oideq(&split_tree->object.oid, &parent_tree_oid)) {
> +               ret =3D error(_("split commit is empty"));
> +               goto out;
> +       } else if (oideq(&split_tree->object.oid, original_commit_tree_oi=
d)) {
> +               ret =3D error(_("split commit tree matches original commi=
t"));
> +               goto out;
> +       }
> +
> +       /*
> +        * The first commit is constructed from the split-out tree. The b=
ase
> +        * that shall be diffed against is the parent of the original com=
mit.
> +        */
> +       ret =3D commit_tree_with_edited_message_ext(repo, "split-out", or=
iginal,
> +                                                 original->parents, &par=
ent_tree_oid,
> +                                                 &split_tree->object.oid=
, &first_commit);
> +       if (ret < 0) {
> +               ret =3D error(_("failed writing first commit"));
> +               goto out;
> +       }
> +
> +       /*
> +        * The second commit is constructed from the original tree. The b=
ase to
> +        * diff against and the parent in this case is the first split-ou=
t
> +        * commit.
> +        */
> +       commit_list_append(first_commit, &parents);
> +
> +       old_tree_oid =3D &repo_get_commit_tree(repo, first_commit)->objec=
t.oid;
> +       new_tree_oid =3D &repo_get_commit_tree(repo, original)->object.oi=
d;
> +
> +       ret =3D commit_tree_with_edited_message_ext(repo, "split-out", or=
iginal,
> +                                                 parents, old_tree_oid,
> +                                                 new_tree_oid, &second_c=
ommit);
> +       if (ret < 0) {
> +               ret =3D error(_("failed writing second commit"));
> +               goto out;
> +       }
> +
> +       *out =3D second_commit;
> +       ret =3D 0;
> +
> +out:
> +       if (index_file.len)
> +               unlink(index_file.buf);
> +       strbuf_release(&index_file);
> +       free_commit_list(parents);
> +       release_index(&index);
> +       return ret;
> +}
> +
> +static int cmd_history_split(int argc,
> +                            const char **argv,
> +                            const char *prefix,
> +                            struct repository *repo)
> +{
> +       const char * const usage[] =3D {
> +               GIT_HISTORY_SPLIT_USAGE,
> +               NULL,
> +       };
> +       enum ref_action action =3D REF_ACTION_DEFAULT;
> +       int dry_run =3D 0;
> +       struct option options[] =3D {
> +               OPT_CALLBACK_F(0, "update-refs", &action, N_("<refs>"),
> +                              N_("control ref update behavior (branches|=
head|print)"),
> +                              PARSE_OPT_NONEG, parse_ref_action),
> +               OPT_BOOL('n', "dry-run", &dry_run,
> +                        N_("perform a dry-run without updating any refs"=
)),
> +               OPT_END(),
> +       };
> +       struct commit *original, *rewritten =3D NULL;
> +       struct strbuf reflog_msg =3D STRBUF_INIT;
> +       struct pathspec pathspec =3D { 0 };
> +       struct rev_info revs =3D { 0 };
> +       int ret;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc < 1) {
> +               ret =3D error(_("command expects a committish"));
> +               goto out;
> +       }
> +       repo_config(repo, git_default_config, NULL);
> +
> +       if (action =3D=3D REF_ACTION_DEFAULT)
> +               action =3D REF_ACTION_BRANCHES;
> +
> +       parse_pathspec(&pathspec, 0,
> +                      PATHSPEC_PREFER_FULL |
> +                      PATHSPEC_SYMLINK_LEADING_PATH |
> +                      PATHSPEC_PREFIX_ORIGIN,
> +                      prefix, argv + 1);
> +
> +       original =3D lookup_commit_reference_by_name(argv[0]);
> +       if (!original) {
> +               ret =3D error(_("commit cannot be found: %s"), argv[0]);
> +               goto out;
> +       }
> +
> +       ret =3D setup_revwalk(repo, action, original, &revs);
> +       if (ret < 0)
> +               goto out;
> +
> +       if (original->parents && original->parents->next) {
> +               ret =3D error(_("cannot split up merge commit"));
> +               goto out;
> +       }
> +
> +       ret =3D split_commit(repo, original, &pathspec, &rewritten);
> +       if (ret < 0)
> +               goto out;
> +
> +       strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
> +
> +       ret =3D handle_reference_updates(&revs, action, original, rewritt=
en,
> +                                      reflog_msg.buf, dry_run);
> +       if (ret < 0) {
> +               ret =3D error(_("failed replaying descendants"));
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       strbuf_release(&reflog_msg);
> +       clear_pathspec(&pathspec);
> +       release_revisions(&revs);
> +       return ret;
> +}
> +
>  int cmd_history(int argc,
>                 const char **argv,
>                 const char *prefix,
> @@ -491,11 +739,13 @@ int cmd_history(int argc,
>  {
>         const char * const usage[] =3D {
>                 GIT_HISTORY_REWORD_USAGE,
> +               GIT_HISTORY_SPLIT_USAGE,
>                 NULL,
>         };
>         parse_opt_subcommand_fn *fn =3D NULL;
>         struct option options[] =3D {
>                 OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
> +               OPT_SUBCOMMAND("split", &fn, cmd_history_split),
>                 OPT_END(),
>         };
>
> diff --git a/t/meson.build b/t/meson.build
> index 6d91470ebc..2d578ef58b 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -392,6 +392,7 @@ integration_tests =3D [
>    't3438-rebase-broken-files.sh',
>    't3450-history.sh',
>    't3451-history-reword.sh',
> +  't3452-history-split.sh',
>    't3500-cherry.sh',
>    't3501-revert-cherry-pick.sh',
>    't3502-cherry-pick-merge.sh',
> diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> new file mode 100755
> index 0000000000..8ed0cebb50
> --- /dev/null
> +++ b/t/t3452-history-split.sh
> @@ -0,0 +1,757 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history split subcommand'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-log-graph.sh"
> +
> +# The fake editor takes multiple arguments, each of which represents a c=
ommit
> +# message. Subsequent invocations of the editor will then yield those me=
ssages
> +# in order.
> +#
> +set_fake_editor () {
> +       printf "%s\n" "$@" >fake-input &&
> +       write_script fake-editor.sh <<-\EOF &&
> +       head -n1 fake-input >"$1"
> +       sed 1d fake-input >fake-input.trimmed &&
> +       mv fake-input.trimmed fake-input
> +       EOF
> +       test_set_editor "$(pwd)"/fake-editor.sh
> +}
> +
> +expect_graph () {
> +       cat >expect &&
> +       lib_test_cmp_graph --graph --format=3D%s "$@"
> +}
> +
> +expect_log () {
> +       git log --format=3D"%s" >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +expect_tree_entries () {
> +       git ls-tree --name-only "$1" >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +test_expect_success 'refuses to work with merge commits' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit ours &&
> +               git switch branch &&
> +               test_commit theirs &&
> +               git switch - &&
> +               git merge theirs &&
> +               test_must_fail git history split HEAD 2>err &&
> +               test_grep "cannot split up merge commit" err &&
> +               test_must_fail git history split HEAD~ 2>err &&
> +               test_grep "replaying merge commits is not supported yet" =
err
> +       )
> +'
> +
> +test_expect_success 'errors on missing commit argument' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history split 2>err &&
> +               test_grep "command expects a committish" err
> +       )
> +'
> +
> +test_expect_success 'errors on unknown revision' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history split does-not-exist 2>err &&
> +               test_grep "commit cannot be found" err
> +       )
> +'
> +
> +test_expect_success '--dry-run does not modify any refs' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               git refs list --include-root-refs >before &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split --dry-run HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               git refs list --include-root-refs >after &&
> +               test_cmp before after
> +       )
> +'
> +
> +test_expect_success 'can split up tip commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               git symbolic-ref HEAD >expect &&
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +               git symbolic-ref HEAD >actual &&
> +               test_cmp expect actual &&
> +
> +               expect_log <<-EOF &&
> +               second
> +               first
> +               initial
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF &&
> +               bar
> +               foo
> +               initial.t
> +               EOF
> +
> +               git reflog >reflog &&
> +               test_grep "split: updating HEAD" reflog
> +       )
> +'
> +
> +test_expect_success 'can split up root commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m root &&
> +               test_commit tip &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD~ <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               tip
> +               second
> +               first
> +               EOF
> +
> +               expect_tree_entries HEAD~2 <<-EOF &&
> +               bar
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               tip.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split up in-between commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +               test_commit tip &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD~ <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               tip
> +               second
> +               first
> +               initial
> +               EOF
> +
> +               expect_tree_entries HEAD~2 <<-EOF &&
> +               bar
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               initial.t
> +               tip.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split HEAD only' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               touch a b &&
> +               git add . &&
> +               git commit -m split-me &&
> +               git branch unrelated &&
> +
> +               set_fake_editor "ours-a" "ours-b" &&
> +               git history split --update-refs=3Dhead HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +               expect_graph --branches <<-EOF
> +               * ours-b
> +               * ours-a
> +               | * split-me
> +               |/
> +               * base
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split detached HEAD' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +               git checkout --detach HEAD &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split --update-refs=3Dhead HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               # HEAD should be detached and updated.
> +               test_must_fail git symbolic-ref HEAD &&
> +
> +               expect_log <<-EOF
> +               second
> +               first
> +               initial
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split commit in unrelated branch' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch ours &&
> +               git switch --create theirs &&
> +               touch theirs-a theirs-b &&
> +               git add . &&
> +               git commit -m theirs &&
> +               git switch ours &&
> +               test_commit ours &&
> +
> +               # With --update-refs=3Dhead it is not possible to split u=
p a
> +               # commit that is unrelated to HEAD.
> +               test_must_fail git history split --update-refs=3Dhead the=
irs 2>err &&
> +               test_grep "rewritten commit must be an ancestor of HEAD" =
err &&
> +
> +               set_fake_editor "theirs-rewritten-a" "theirs-rewritten-b"=
 &&
> +               git history split theirs <<-EOF &&
> +               y
> +               n
> +               EOF
> +               expect_graph --branches <<-EOF &&
> +               * ours
> +               | * theirs-rewritten-b
> +               | * theirs-rewritten-a
> +               |/
> +               * base
> +               EOF
> +
> +               expect_tree_entries theirs~ <<-EOF &&
> +               base.t
> +               theirs-a
> +               EOF
> +
> +               expect_tree_entries theirs <<-EOF
> +               base.t
> +               theirs-a
> +               theirs-b
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'updates multiple descendant branches' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               touch file-a file-b &&
> +               git add . &&
> +               git commit -m split-me &&
> +               git branch branch &&
> +               test_commit on-main &&
> +               git switch branch &&
> +               test_commit on-branch &&
> +               git switch main &&
> +
> +               set_fake_editor "split-a" "split-b" &&
> +               git history split HEAD~ <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               # Both branches should now descend from the split commits=
.
> +               expect_graph --branches <<-EOF
> +               * on-branch
> +               | * on-main
> +               |/
> +               * split-b
> +               * split-a
> +               * base
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can pick multiple hunks' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar baz foo qux &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               y
> +               n
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               baz
> +               foo
> +               qux
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can use only last hunk' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD <<-EOF &&
> +               n
> +               y
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               second
> +               first
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split commit with file deletions' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               echo a >a &&
> +               echo b >b &&
> +               echo c >c &&
> +               git add . &&
> +               git commit -m base &&
> +               git rm a b &&
> +               git commit -m delete-both &&
> +
> +               set_fake_editor "delete-a" "delete-b" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               delete-b
> +               delete-a
> +               base
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               b
> +               c
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               c
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'preserves original authorship' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               GIT_AUTHOR_NAME=3D"Other Author" \
> +               GIT_AUTHOR_EMAIL=3D"other@example.com" \
> +               git commit -m split-me &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               git log -1 --format=3D"%an <%ae>" HEAD~ >actual &&
> +               echo "Other Author <other@example.com>" >expect &&
> +               test_cmp expect actual &&
> +
> +               git log -1 --format=3D"%an <%ae>" HEAD >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'aborts with empty commit message' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "" &&
> +               test_must_fail git history split HEAD <<-EOF 2>err &&
> +               y
> +               n
> +               EOF
> +               test_grep "Aborting commit due to empty commit message." =
err
> +       )
> +'
> +
> +test_expect_success 'commit message editor sees split-out changes' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               write_script fake-editor.sh <<-\EOF &&
> +               cat "$1" >>MESSAGES &&
> +               echo "some commit message" >"$1"
> +               EOF
> +               test_set_editor "$(pwd)"/fake-editor.sh &&
> +
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               # Note that we expect to see the messages twice, once for=
 each
> +               # of the commits. The committed files are different thoug=
h.
> +               cat >expect <<-EOF &&
> +               split-me
> +
> +               # Please enter the commit message for the split-out chang=
es. Lines starting
> +               # with ${SQ}#${SQ} will be ignored, and an empty message =
aborts the commit.
> +               # Changes to be committed:
> +               #       new file:   bar
> +               #
> +               split-me
> +
> +               # Please enter the commit message for the split-out chang=
es. Lines starting
> +               # with ${SQ}#${SQ} will be ignored, and an empty message =
aborts the commit.
> +               # Changes to be committed:
> +               #       new file:   foo
> +               #
> +               EOF
> +               test_cmp expect MESSAGES &&
> +
> +               expect_log <<-EOF
> +               some commit message
> +               some commit message
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can use pathspec to limit what gets split' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD -- foo <<-EOF &&
> +               y
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'pathspec matching no files produces empty split err=
or' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "first" "second" &&
> +               test_must_fail git history split HEAD -- nonexistent 2>er=
r &&
> +               test_grep "split commit is empty" err
> +       )
> +'
> +
> +test_expect_success 'split with multiple pathspecs' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch a b c d &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               # Only a and c should be offered for splitting.
> +               set_fake_editor "split-ac" "remainder" &&
> +               git history split HEAD -- a c <<-EOF &&
> +               y
> +               y
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               a
> +               c
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               a
> +               b
> +               c
> +               d
> +               initial.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'split with file mode change' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               echo content >script &&
> +               git add . &&
> +               git commit -m base &&
> +               test_chmod +x script &&
> +               echo change >script &&
> +               git commit -a -m "mode and content change" &&
> +
> +               set_fake_editor "mode-change" "content-change" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF
> +               content-change
> +               mode-change
> +               base
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'refuses to create empty split-out commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               test_must_fail git history split HEAD 2>err <<-EOF &&
> +               n
> +               n
> +               EOF
> +               test_grep "split commit is empty" err
> +       )
> +'
> +
> +test_expect_success 'hooks are not executed for rewritten commits' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +               old_head=3D$(git rev-parse HEAD) &&
> +
> +               ORIG_PATH=3D"$(pwd)" &&
> +               export ORIG_PATH &&
> +               for hook in prepare-commit-msg pre-commit post-commit pos=
t-rewrite commit-msg
> +               do
> +                       write_script .git/hooks/$hook <<-\EOF || exit 1
> +                       touch "$ORIG_PATH"/hooks.log
> +                       EOF
> +               done &&
> +
> +               set_fake_editor "first" "second" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               second
> +               first
> +               EOF
> +
> +               test_path_is_missing hooks.log
> +       )
> +'
> +
> +test_expect_success 'refuses to create empty original commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               test_must_fail git history split HEAD 2>err <<-EOF &&
> +               y
> +               y
> +               EOF
> +               test_grep "split commit tree matches original commit" err
> +       )
> +'
> +
> +test_expect_success 'retains changes in the worktree and index' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               echo a >a &&
> +               echo b >b &&
> +               git add . &&
> +               git commit -m "initial commit" &&
> +               echo a-modified >a &&
> +               echo b-modified >b &&
> +               git add b &&
> +               set_fake_editor "a-only" "remainder" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               a
> +               EOF
> +               expect_tree_entries HEAD <<-EOF &&
> +               a
> +               b
> +               EOF
> +
> +               cat >expect <<-\EOF &&
> +                M a
> +               M  b
> +               ?? actual
> +               ?? expect
> +               ?? fake-editor.sh
> +               ?? fake-input
> +               EOF
> +               git status --porcelain >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_done
>
> --
> 2.53.0.697.g625c4fb2da.dirty
>
>

I didn't look particularly closely at the rest. I didn't really figure
out what "ext" meant though ;)

--=20
D. Ben Knoble
