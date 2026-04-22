Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E336680F
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884793; cv=pass; b=jPYufPJJpi2vtJpTP0ePMqk3hSucrTwYqvDALMuE0goyqtw2+I2MEpjrW2CRXRWT9ji0eqcNN2Ssu/3IOvuHtWw0DqdqDeOMgu/OMQKIO/bWLVRNr799w8LjDIg592LedQXmgI+oM6jqURKC50o2silMtTYBm0ZgyTMDNKZjg9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884793; c=relaxed/simple;
	bh=VGPd2MRO/byoSzK3IFSyRr2mno4p3vVEESaGuLiiqGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPEVdI2znClVGIFbTFxPQUcIdLztoW24ozyUxLLaxU0wSCnK6ZgDSsSXN/e+9QfU3Dgbg7zrWl1L8k2BYIYFVPmSwwFlozqMhGBdm8gftCHlj2KNVjf+Db2XpntBSy9kjA2+YIbnsQbtUURPxwu5fEMKvmHSjliaHROGc7IU2f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYCmcTNf; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYCmcTNf"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82faf871346so3103944b3a.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776884784; cv=none;
        d=google.com; s=arc-20240605;
        b=KKmY0uspRcByTGA+edEy7eKidSn4Oz2hg9q3B/HSaMQIDyhkV9XYfxRwkYvfnaOS7K
         vYe+7PtktSIdqK/qSUsdTnpw8YmcNZRUawK4W7uId6gNhpwK1+YSqYVYCncL7LbOrVbZ
         tYCLPKdb4KF+8/Ro3ZbSNtKWFXD8F4rhh2l85Jjeat5a2kghyOIQrbEttbCu183/EyF3
         /tEyMoL3m0QSOoQv/+sWIKT7IZj1e69sVOtRytDnMrI7Li5xSo2r4s60iCCp86ljs3+1
         QGIyksN2utvYwaBObNUMmCr9NF6PotFDDxhyJuEgceQWcn/wS8do4sQw8P41zfYXwJPV
         k6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCGJ2/riK6jrTEDD3VfF/99Mwqaq2IhSvLi1uHJnoqY=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=XU5NYaLKwG3FdqIouStkpAXowpkwAAd7IDop8n0mKcIzPGSiNzTw6HW7PtQR72yZE0
         elhll+rrRaAkibRw0Lnm7+yVE1F0V7J6hEOT+so4/E2bOz5LAm4eFU9jKwEyGHneqtUJ
         prq+MBQWFMCzCGHZjlafwbAlyRJP8o38kOIK5MaD+fYnHeb5Kn946/8sUdsNsWN0KUik
         1FzxHNT3lUYVnlzsozt9+hoSGJ4XJriDCijhZvUF9yDYf2rsXm2W0ScUTZK378993BS0
         yQpE5TRlIaOF1VrCLcLzu4g/Ny62H29/gS+TNhUbq3J1CMdwQeXIewAmGhguSFAWfLMs
         x6yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776884784; x=1777489584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCGJ2/riK6jrTEDD3VfF/99Mwqaq2IhSvLi1uHJnoqY=;
        b=dYCmcTNfh5/gK6xOaJmsdbojqJv+XKOAJKfV+tozSgVqyKodEdsEqFlQ751Q2RoOxc
         pZdcHwdJVLxkcUMN+H+OO8MiS3luSAZoUP7LX0dExpFEfoZthZU6VkQPtkpsoHQOkVm7
         If+6Q5cFBT7SGi/1pa/MbObC3D3YRSC4jnWc2PeIC+XubWCZ11HCKmIqNZYBX48Ir37f
         n5Y+4RGQHnhN1iV+cFs2IXcfECgKeNDkRSboI1QP8bayqlj7/VzP9xwfIrKjPw7ex+Ht
         OH+16Tm7VASOYu1DewcOpWR4lQzoVTp5pQL4LusPxIwOHczHPk7NGpiSPCiE2Q48UpG/
         8+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884784; x=1777489584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCGJ2/riK6jrTEDD3VfF/99Mwqaq2IhSvLi1uHJnoqY=;
        b=NBbJpwOhW84W551rOE5r9pQT5/hHTF7iHxeW40QAlMT5fHYDRgJtDo3C0aw8EVK2CT
         9yVmMdPhVECO0nxGufdm/HpjtuiffIwJckh/u1eVNW3i/vJyXu4wYfpfnphhCuhLFqIZ
         IDwsciRHh0XJ2BHitEKpMGVr0MKYHOlBCEFpO//+VKj/DDJJeGXBxyW0h7YvBqfLWcmF
         vsk/9viQ3cCqo0fEqnpNfn0jtwLDlkXGh7jrih60tNT9z8XbIfLfWGcXraA9SwRjxqkl
         CTYeklsjmUT1dNsOav4XQcerJgWtWhU9G3okgFTWZEFK3WdubfAxC+l1MbTwP4QyJQ39
         QvnQ==
X-Gm-Message-State: AOJu0YyTje/z/k1C+JleJzaswONC3awTOzsvp/oMSFM6pcUtOsUxi6ud
	VKNM191KwCIumDnabZWbssPxlCm3j5m2N/WEkkAAA9ncgJNCsGxK7iU5jnAeJEl21nCtbGt4THO
	piEOf3X63emQ9roB34JsSu7h8IJRecEA=
X-Gm-Gg: AeBDievpePsB6stEpwnxe4Qw1YW9rTUg77tLeTydYcLam2V/RPcRkgwDVmcipMRY2a6
	+joP4oW0rjUs9MFHVWlF3yBvd0wsjuXdWv7qkXLfpM8ptU7kmXOc4rBOT2Ub+tV40DpklQAc/23
	XL8ggQpHT3BnvrmxiwYNIXDy0sex0bwtiKph1OVZAkSIfDgSFnGczSIIvDZwgrmUM21XovnnZMc
	wyPiA7vsq82bhEVbV/Xirg6PS4XOM6eUHSPcdKtKSIyIFO6aaER0mq1HCi0R9AsYl8XcQBpHI3W
	cZ3R+yugre44f3Lw7oNGpvfyjUiIx1uWWF664PN2c/CM6TY3n2jPR01WHW+nWcX16zx5sTGqQsE
	tVbqnmtwm2yhfE4k=
X-Received: by 2002:a05:6300:210d:b0:39b:a48e:6a77 with SMTP id
 adf61e73a8af0-3a08d8e9ce8mr27015037637.37.1776884783671; Wed, 22 Apr 2026
 12:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im> <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im>
In-Reply-To: <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 22 Apr 2026 15:06:12 -0400
X-Gm-Features: AQROBzCScshM6jyuPAuBtia-vYde_km_zG8qMZv7JuTIXD8ulH3_U0dFoo5DjcY
Message-ID: <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yahoo, fixup!

On Wed, Apr 22, 2026 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The newly introduced git-history(1) command provides functionality to
> easily edit commit history while also rebasing dependent branches. The
> functionality exposed by this command is still somewhat limited though.
>
> One common use case when editing commit history that is not yet covered
> is fixing up a specific commit. Introduce a new subcommand that allows
> the user to do exactly that by performing a three-way merge into the
> target's commit tree, using HEAD's tree as the merge base. The flow is
> thus essentially:
>
>     $ echo changes >file
>     $ git add file
>     $ git history fixup HEAD~
>
> Like with the other commands, this will automatically rebase dependent
> branches, as well. Unlike the other commands though:
>
>   - The command does not work in a bare repository as it interacts with
>     the index.
>
>   - The command may run into merge conflicts. If so, the command will
>     simply abort.
>
> Especially the second item limits the usefulness of this command a bit.
> But there are plans to introduce first-class conflicts into Git, which
> will help use cases like this one.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  52 ++++-
>  builtin/history.c              | 153 +++++++++++++
>  t/meson.build                  |   1 +
>  t/t3453-history-fixup.sh       | 500 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 704 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index 24dc907033..3cdfc8ba02 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,6 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
>  SYNOPSIS
>  --------
>  [synopsis]
> +git history fixup <commit> [--dry-run] [--update-refs=3D(branches|head)]=
 [--reedit-message]
>  git history reword <commit> [--dry-run] [--update-refs=3D(branches|head)=
]
>  git history split <commit> [--dry-run] [--update-refs=3D(branches|head)]=
 [--] [<pathspec>...]
>
> @@ -22,8 +23,9 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>  This command is related to linkgit:git-rebase[1] in that both commands c=
an be
>  used to rewrite history. There are a couple of major differences though:
>
> -* linkgit:git-history[1] can work in a bare repository as it does not ne=
ed to
> -  touch either the index or the worktree.
> +* Most subcommands of linkgit:git-history[1] can work in a bare reposito=
ry as
> +  they do not need to touch either the index or the worktree. The `fixup=
`
> +  subcommand is an exception to this, as it reads staged changes from th=
e index.
>  * linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
>    current point in time. This may change in the future.
>  * linkgit:git-history[1] by default updates all branches that are descen=
dants
> @@ -53,6 +55,19 @@ COMMANDS
>
>  The following commands are available to rewrite history in different way=
s:
>
> +`fixup <commit>`::
> +       Apply the currently staged changes to the specified commit. The s=
taged
> +       changes are incorporated into the target commit's tree via a thre=
e-way
> +       merge, using HEAD's tree as the merge base, which is equivalent t=
o
> +       linkgit:git-cherry-pick[1].

I'm not quite sure what, as a user of "git history fixup," I'm
supposed to take from this. Does it make conflicts less likely when
creating the new fixup? I imagine it doesn't help with conflicts
between <commit> and HEAD that newly arise.

Anyway, I'd think the mechanics are less relevant than the end-user
behavior at this point in the doc, unless the equivalence with
cherry-pick is supposed to tell me something about that behavior.

> ++
> +The commit message and authorship of the target commit are preserved by
> +default, unless you specify `--reedit-message`.
> ++
> +If applying the staged changes would result in a conflict, the command
> +aborts with an error. All branches that are descendants of the original
> +commit are updated to point to the rewritten history.
> +
>  `reword <commit>`::
>         Rewrite the commit message of the specified commit. All the other
>         details of this commit remain unchanged. This command will spawn =
an
> @@ -87,6 +102,9 @@ OPTIONS
>         objects will be written into the repository, so applying these pr=
inted
>         ref updates is generally safe.
>
> +`--reedit-message`::
> +       Open an editor to modify the target commit's message.
> +
>  `--update-refs=3D(branches|head)`::
>         Control which references will be updated by the command, if any. =
With
>         `branches`, all local branches that point to commits which are
> @@ -96,6 +114,36 @@ OPTIONS
>  EXAMPLES
>  --------
>
> +Fixup a commit
> +~~~~~~~~~~~~~~
> +
> +----------
> +$ git log --oneline --stat
> +abc1234 (HEAD -> main) third
> + third.txt | 1 +
> +def5678 second
> + second.txt | 1 +
> +ghi9012 first
> + first.txt | 1 +
> +
> +$ echo "change" >>unrelated.txt
> +$ git add unrelated.txt
> +$ git history fixup ghi9012
> +
> +$ git log --oneline --stat
> +jkl3456 (HEAD -> main) third
> + third.txt | 1 +
> +mno7890 second
> + second.txt | 1 +
> +pqr1234 first
> + first.txt     | 1 +
> + unrelated.txt | 1 +
> +----------
> +
> +The staged addition of `unrelated.txt` has been incorporated into the `f=
irst`
> +commit. All descendant commits have been replayed on top of the rewritte=
n
> +history.
> +
>  Split a commit
>  ~~~~~~~~~~~~~~
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 549e352c74..6299f0dfa9 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -10,6 +10,7 @@
>  #include "gettext.h"
>  #include "hex.h"
>  #include "lockfile.h"
> +#include "merge-ort.h"
>  #include "oidmap.h"
>  #include "parse-options.h"
>  #include "path.h"
> @@ -23,6 +24,8 @@
>  #include "unpack-trees.h"
>  #include "wt-status.h"
>
> +#define GIT_HISTORY_FIXUP_USAGE \
> +       N_("git history fixup <commit> [--dry-run] [--update-refs=3D(bran=
ches|head)] [--reedit-message]")
>  #define GIT_HISTORY_REWORD_USAGE \
>         N_("git history reword <commit> [--dry-run] [--update-refs=3D(bra=
nches|head)]")
>  #define GIT_HISTORY_SPLIT_USAGE \
> @@ -434,6 +437,154 @@ static int handle_reference_updates(struct rev_info=
 *revs,
>         return ret;
>  }
>
> +static int cmd_history_fixup(int argc,
> +                            const char **argv,
> +                            const char *prefix,
> +                            struct repository *repo)
> +{
> +       const char * const usage[] =3D {
> +               GIT_HISTORY_FIXUP_USAGE,
> +               NULL,
> +       };
> +       enum ref_action action =3D REF_ACTION_DEFAULT;
> +       int dry_run =3D 0;
> +       enum commit_tree_flags flags =3D 0;
> +       struct option options[] =3D {
> +               OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head=
)",
> +                              N_("control which refs should be updated")=
,
> +                              PARSE_OPT_NONEG, parse_ref_action),
> +               OPT_BOOL('n', "dry-run", &dry_run,
> +                        N_("perform a dry-run without updating any refs"=
)),
> +               OPT_BIT(0, "reedit-message", &flags,
> +                       N_("open an editor to modify the commit message")=
,
> +                       COMMIT_TREE_EDIT_MESSAGE),
> +               OPT_END(),
> +       };
> +       struct merge_result merge_result =3D { 0 };
> +       struct merge_options merge_opts =3D { 0 };
> +       struct strbuf reflog_msg =3D STRBUF_INIT;
> +       struct commit *head_commit, *original, *rewritten;
> +       struct tree *head_tree, *original_tree, *index_tree;
> +       struct rev_info revs =3D { 0 };
> +       int ret;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc !=3D 1) {
> +               ret =3D error(_("command expects a single revision"));
> +               goto out;
> +       }
> +       repo_config(repo, git_default_config, NULL);
> +
> +       if (action =3D=3D REF_ACTION_DEFAULT)
> +               action =3D REF_ACTION_BRANCHES;
> +
> +       if (is_bare_repository()) {
> +               ret =3D error(_("cannot run fixup in a bare repository"))=
;
> +               goto out;
> +       }
> +
> +       /* Resolve the original commit, which is the one we want to fix u=
p. */
> +       original =3D lookup_commit_reference_by_name(argv[0]);
> +       if (!original) {
> +               ret =3D error(_("commit cannot be found: %s"), argv[0]);
> +               goto out;
> +       }
> +
> +       /*
> +        * Resolve HEAD so we can use its tree as the merge base: the sta=
ged
> +        * changes are expressed as a diff from HEAD's tree to the index =
tree.
> +        */
> +       head_commit =3D lookup_commit_reference_by_name("HEAD");
> +       if (!head_commit) {
> +               ret =3D error(_("cannot look up HEAD"));
> +               goto out;
> +       }
> +
> +       head_tree =3D repo_get_commit_tree(repo, head_commit);
> +       if (!head_tree) {
> +               ret =3D error(_("cannot get tree for HEAD"));
> +               goto out;
> +       }
> +
> +       if (repo_read_index(repo) < 0) {
> +               ret =3D error(_("unable to read index"));
> +               goto out;
> +       }
> +
> +       if (!repo_index_has_changes(repo, head_tree, NULL)) {
> +               ret =3D error(_("nothing to fixup: no staged changes"));
> +               goto out;
> +       }
> +
> +       /*
> +        * Write the index as a tree object. This is the "theirs" side of=
 the
> +        * three-way merge: it is HEAD's tree with the staged changes app=
lied.
> +        */
> +       index_tree =3D write_in_core_index_as_tree(repo, repo->index);
> +       if (!index_tree) {
> +               ret =3D error(_("unable to write index as a tree"));
> +               goto out;
> +       }
> +
> +       original_tree =3D repo_get_commit_tree(repo, original);
> +       if (!original_tree) {
> +               ret =3D error(_("cannot get tree for commit %s"), argv[0]=
);
> +               goto out;
> +       }
> +
> +       /*
> +        * Perform the three-way merge to reapply changes in the index on=
to the
> +        * target commit. This is using basically the same logic as a
> +        * cherry-pick, where the base commit is our HEAD, ours is the or=
iginal
> +        * tree and theirs is the index tree.
> +        */

OTOH, this explanation helps quite a bit here :)

> +       init_basic_merge_options(&merge_opts, repo);
> +       merge_opts.ancestor =3D "HEAD";
> +       merge_opts.branch1 =3D argv[0];
> +       merge_opts.branch2 =3D "staged";
> +       merge_incore_nonrecursive(&merge_opts, head_tree,
> +                                 original_tree, index_tree, &merge_resul=
t);
> +
> +       if (merge_result.clean < 0) {
> +               ret =3D error(_("merge failed while applying fixup"));
> +               goto out;
> +       }
> +
> +       if (!merge_result.clean) {
> +               ret =3D error(_("fixup would produce conflicts; aborting"=
));
> +               goto out;
> +       }
> +
> +       ret =3D setup_revwalk(repo, action, original, &revs);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D commit_tree_ext(repo, "fixup", original, original->parent=
s,
> +                             &original_tree->object.oid, &merge_result.t=
ree->object.oid,
> +                             &rewritten, flags);
> +       if (ret < 0) {
> +               ret =3D error(_("failed writing fixed-up commit"));
> +               goto out;
> +       }
> +
> +       strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
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
> +       merge_finalize(&merge_opts, &merge_result);
> +       strbuf_release(&reflog_msg);
> +       release_revisions(&revs);
> +       return ret;
> +}
> +
>  static int cmd_history_reword(int argc,
>                               const char **argv,
>                               const char *prefix,
> @@ -745,12 +896,14 @@ int cmd_history(int argc,
>                 struct repository *repo)
>  {
>         const char * const usage[] =3D {
> +               GIT_HISTORY_FIXUP_USAGE,
>                 GIT_HISTORY_REWORD_USAGE,
>                 GIT_HISTORY_SPLIT_USAGE,
>                 NULL,
>         };
>         parse_opt_subcommand_fn *fn =3D NULL;
>         struct option options[] =3D {
> +               OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
>                 OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
>                 OPT_SUBCOMMAND("split", &fn, cmd_history_split),
>                 OPT_END(),
> diff --git a/t/meson.build b/t/meson.build
> index 7528e5cda5..f502ad8ec9 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -397,6 +397,7 @@ integration_tests =3D [
>    't3450-history.sh',
>    't3451-history-reword.sh',
>    't3452-history-split.sh',
> +  't3453-history-fixup.sh',
>    't3500-cherry.sh',
>    't3501-revert-cherry-pick.sh',
>    't3502-cherry-pick-merge.sh',
> diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
> new file mode 100755
> index 0000000000..0012b1f052
> --- /dev/null
> +++ b/t/t3453-history-fixup.sh
> @@ -0,0 +1,500 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history fixup subcommand'
> +
> +. ./test-lib.sh
> +
> +fixup_with_message () {
> +       cat >message &&
> +       write_script fake-editor.sh <<-\EOF &&
> +       cp message "$1"
> +       EOF
> +       test_set_editor "$(pwd)"/fake-editor.sh &&
> +       git history fixup --reedit-message "$@" &&
> +       rm fake-editor.sh message
> +}
> +
> +expect_changes () {
> +       git log --format=3D"%s" --numstat "$@" >actual.raw &&
> +       sed '/^$/d' <actual.raw >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +test_expect_success 'errors on missing commit argument' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history fixup 2>err &&
> +               test_grep "command expects a single revision" err
> +       )
> +'
> +
> +test_expect_success 'errors on too many arguments' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history fixup HEAD HEAD 2>err &&
> +               test_grep "command expects a single revision" err
> +       )
> +'
> +
> +test_expect_success 'errors on unknown revision' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history fixup does-not-exist 2>err &&
> +               test_grep "commit cannot be found: does-not-exist" err
> +       )
> +'
> +
> +test_expect_success 'errors when nothing is staged' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_must_fail git history fixup HEAD 2>err &&
> +               test_grep "nothing to fixup: no staged changes" err
> +       )
> +'
> +
> +test_expect_success 'errors in a bare repository' '
> +       test_when_finished "rm -rf repo repo.git" &&
> +       git init repo &&
> +       test_commit -C repo initial &&
> +       git clone --bare repo repo.git &&
> +       test_must_fail git -C repo.git history fixup HEAD 2>err &&
> +       test_grep "cannot run fixup in a bare repository" err
> +'
> +
> +test_expect_success 'can fixup the tip commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               echo content >file.txt &&
> +               git add file.txt &&
> +               git commit -m "add file" &&
> +
> +               echo fix >>file.txt &&
> +               git add file.txt &&
> +
> +               expect_changes <<-\EOF &&
> +               add file
> +               1       0       file.txt
> +               initial
> +               1       0       initial.t
> +               EOF
> +
> +               git symbolic-ref HEAD >branch-expect &&
> +               git history fixup HEAD &&
> +               git symbolic-ref HEAD >branch-actual &&
> +               test_cmp branch-expect branch-actual &&
> +
> +               expect_changes <<-\EOF &&
> +               add file
> +               2       0       file.txt
> +               initial
> +               1       0       initial.t
> +               EOF
> +
> +               # Verify the fix is in the tip commit tree
> +               git show HEAD:file.txt >actual &&
> +               printf "content\nfix\n" >expect &&
> +               test_cmp expect actual &&
> +
> +               git reflog >reflog &&
> +               test_grep "fixup: updating HEAD" reflog
> +       )
> +'
> +
> +test_expect_success 'can fixup a commit in the middle of history' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +               echo content >file.txt &&
> +               git add file.txt &&
> +               git commit -m "add file" &&
> +               test_commit third &&
> +
> +               echo fix >>file.txt &&
> +               git add file.txt &&
> +
> +               expect_changes <<-\EOF &&
> +               third
> +               1       0       third.t
> +               add file
> +               1       0       file.txt
> +               first
> +               1       0       first.t
> +               EOF
> +
> +               git history fixup HEAD~ &&
> +
> +               expect_changes <<-\EOF &&
> +               third
> +               1       0       third.t
> +               add file
> +               2       0       file.txt
> +               first
> +               1       0       first.t
> +               EOF
> +
> +               # Verify the fix landed in the "add file" commit.
> +               git show HEAD~:file.txt >actual &&
> +               printf "content\nfix\n" >expect &&
> +               test_cmp expect actual &&
> +
> +               # And verify that the replayed commit also has the change=
.
> +               git show HEAD:file.txt >actual &&
> +               printf "content\nfix\n" >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'can fixup root commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               echo initial >root.txt &&
> +               git add root.txt &&
> +               git commit -m "root" &&
> +               test_commit second &&
> +
> +               expect_changes <<-\EOF &&
> +               second
> +               1       0       second.t
> +               root
> +               1       0       root.txt
> +               EOF
> +
> +               echo fix >>root.txt &&
> +               git add root.txt &&
> +               git history fixup HEAD~ &&
> +
> +               expect_changes <<-\EOF &&
> +               second
> +               1       0       second.t
> +               root
> +               2       0       root.txt
> +               EOF
> +
> +               git show HEAD~:root.txt >actual &&
> +               printf "initial\nfix\n" >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'preserves commit message and authorship' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               echo content >file.txt &&
> +               git add file.txt &&
> +               git commit --author=3D"Original <original@example.com>" -=
m "original message" &&
> +
> +               echo fix >>file.txt &&
> +               git add file.txt &&
> +               git history fixup HEAD &&
> +
> +               # Message preserved
> +               git log -1 --format=3D"%s" >actual &&
> +               echo "original message" >expect &&
> +               test_cmp expect actual &&
> +
> +               # Authorship preserved
> +               git log -1 --format=3D"%an <%ae>" >actual &&
> +               echo "Original <original@example.com>" >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'updates all descendant branches by default' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit ours &&
> +               git switch branch &&
> +               test_commit theirs &&
> +               git switch main &&
> +
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +               git history fixup base &&
> +
> +               expect_changes --branches <<-\EOF &&
> +               theirs
> +               1       0       theirs.t
> +               ours
> +               1       0       ours.t
> +               base
> +               1       0       base.t
> +               1       0       fix.txt
> +               EOF
> +
> +               # Both branches should have the fix in the base
> +               git show main~:fix.txt >actual &&
> +               echo fix >expect &&
> +               test_cmp expect actual &&
> +               git show branch~:fix.txt >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'can fixup commit on a different branch' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch theirs &&
> +               test_commit ours &&
> +               git switch theirs &&
> +               test_commit theirs &&
> +
> +               # Stage a change while on "theirs"
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +
> +               # Ensure that "ours" does not change, as it does not cont=
ain
> +               # the commit in question.
> +               git rev-parse ours >ours-before &&
> +               git history fixup theirs &&
> +               git rev-parse ours >ours-after &&
> +               test_cmp ours-before ours-after &&
> +
> +               git show HEAD:fix.txt >actual &&
> +               echo fix >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success '--dry-run prints ref updates without modifying repo=
' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit main-tip &&
> +               git switch branch &&
> +               test_commit branch-tip &&
> +               git switch main &&
> +
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +
> +               git refs list >refs-before &&
> +               git history fixup --dry-run base >updates &&
> +               git refs list >refs-after &&
> +               test_cmp refs-before refs-after &&
> +
> +               test_grep "update refs/heads/main" updates &&
> +               test_grep "update refs/heads/branch" updates &&
> +
> +               expect_changes --branches <<-\EOF &&
> +               branch-tip
> +               1       0       branch-tip.t
> +               main-tip
> +               1       0       main-tip.t
> +               base
> +               1       0       base.t
> +               EOF
> +
> +               git update-ref --stdin <updates &&
> +               expect_changes --branches <<-\EOF
> +               branch-tip
> +               1       0       branch-tip.t
> +               main-tip
> +               1       0       main-tip.t
> +               base
> +               1       0       base.t
> +               1       0       fix.txt
> +               EOF
> +       )
> +'
> +
> +test_expect_success '--update-refs=3Dhead updates only HEAD' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit main-tip &&
> +               git switch branch &&
> +               test_commit branch-tip &&
> +
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +
> +               # Only HEAD (branch) should be updated
> +               git history fixup --update-refs=3Dhead base &&
> +
> +               # The main branch should be unaffected.
> +               expect_changes main <<-\EOF &&
> +               main-tip
> +               1       0       main-tip.t
> +               base
> +               1       0       base.t
> +               EOF
> +
> +               # But the currently checked out branch should be modified=
.
> +               expect_changes branch <<-\EOF
> +               branch-tip
> +               1       0       branch-tip.t
> +               base
> +               1       0       base.t
> +               1       0       fix.txt
> +               EOF
> +       )
> +'
> +
> +test_expect_success '--update-refs=3Dhead refuses to rewrite commits not=
 in HEAD ancestry' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch other &&
> +               test_commit main-tip &&
> +               git switch other &&
> +               test_commit other-tip &&
> +
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +
> +               test_must_fail git history fixup --update-refs=3Dhead mai=
n-tip 2>err &&
> +               test_grep "rewritten commit must be an ancestor of HEAD" =
err
> +       )
> +'
> +
> +test_expect_success 'aborts when fixup would produce conflicts' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +
> +               echo "line one" >file.txt &&
> +               git add file.txt &&
> +               git commit -m "first" &&
> +
> +               echo "line two" >file.txt &&
> +               git add file.txt &&
> +               git commit -m "second" &&
> +
> +               echo "conflicting change" >file.txt &&
> +               git add file.txt &&
> +
> +               git refs list >refs-before &&
> +               test_must_fail git history fixup HEAD~ 2>err &&
> +               test_grep "fixup would produce conflicts" err &&
> +               git refs list >refs-after &&
> +               test_cmp refs-before refs-after
> +       )
> +'
> +
> +test_expect_success '--reedit-message opens editor for the commit messag=
e' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               echo content >file.txt &&
> +               git add file.txt &&
> +               git commit -m "add file" &&
> +
> +               echo fix >>file.txt &&
> +               git add file.txt &&
> +
> +               fixup_with_message HEAD <<-\EOF &&
> +               add file with fix
> +               EOF
> +
> +               expect_changes --branches <<-\EOF
> +               add file with fix
> +               2       0       file.txt
> +               initial
> +               1       0       initial.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'retains unstaged working tree changes after fixup' =
'
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch a b &&
> +               git add . &&
> +               git commit -m "initial commit" &&
> +               echo staged >a &&
> +               echo unstaged >b &&
> +               git add a &&
> +               git history fixup HEAD &&
> +
> +               # b is still modified in the worktree but not staged
> +               cat >expect <<-\EOF &&
> +                M b
> +               EOF
> +               git status --porcelain --untracked-files=3Dno >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'index is clean after fixup when target is HEAD' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +
> +               test_commit initial &&
> +               echo fix >fix.txt &&
> +               git add fix.txt &&
> +               git history fixup HEAD &&
> +
> +               git status --porcelain --untracked-files=3Dno >actual &&
> +               test_must_be_empty actual
> +       )
> +'
> +
> +test_expect_success 'index is unchanged on conflict' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +
> +               echo base >file.txt &&
> +               git add file.txt &&
> +               git commit -m base &&
> +               echo change >file.txt &&
> +               git add file.txt &&
> +               git commit -m change &&
> +
> +               echo conflict >file.txt &&
> +               git add file.txt &&
> +
> +               git diff --cached >index-before &&
> +               test_must_fail git history fixup HEAD~ &&
> +               git diff --cached >index-after &&
> +               test_cmp index-before index-after
> +       )
> +'
> +
> +test_done
>
> --
> 2.54.0.545.g6539524ca2.dirty
>
>

Thanks

--=20
D. Ben Knoble
