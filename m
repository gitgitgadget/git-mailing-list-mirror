Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC3C43219
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 02:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKFCLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKFCLR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 22:11:17 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02E65ED
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 19:11:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-37063f855e5so75808797b3.3
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOLi8oYmdeE/2LqjFLbd3ZPlhb3Ws3uEqSkmz7RXPRo=;
        b=dYrGy8n7PQKhQfdyBKG+aGJNNUMzWBP8+eWq//CgjYA290OTpBJpcNzQfLIIjNiB96
         AybrPYvNvUaTjxsKnVLEsVLNH+4KSSBVAl4YBDmLKJctzH8z0vi6leMAwq0sE8u8EVBI
         EMDX5khsTmwolpvQLIeQUpsmLzHKlBUY6X2s9+ZwmvyGm5BAwdJvuOj0kpjR6cNcD4sq
         U33CcZDAE41FeGg4n1u4MP2kbF64vwtTPjj0IzP0aFLY1Rn1O36BsMM+40wil0lxbYnc
         nFZx/lYJzag5GWERyDeOOZRdfHtYP3cUO1PiU/Hz64+uUrElCS/Mobb13IUj43OhoQ2A
         GgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOLi8oYmdeE/2LqjFLbd3ZPlhb3Ws3uEqSkmz7RXPRo=;
        b=4RR57pxDWAbsASkG8r+AYjHzPJ0DovmxcQ7xCjkSuGYzk3mfcuwGxk6UZW4gTrMVds
         qQe4QiKfdZoECppkLKLTqiAB+P816gUBUQhPM3xiywoBZPjxRkXmZmmh0P3+vfEUU88F
         Ezz8TCZ0uYI8tK3vECaVgO7KBNfMxnUMz/g4u3jnHFjM7eR/GmGGdAWnausJZA/yXTP6
         ZogeSJi32rDnLP/vMVzwr4F3AtOJxe7Xng0GYIYCGsm+aEcGeaW70mFoeytHeqkjDJbv
         y1j1fskF8tWBgvVKoS3YXgf/4JQnoipej/VjiOLQ7TH/LzYW/FClqNz3tYBqkeyWo/Tg
         mFmA==
X-Gm-Message-State: ACrzQf1YrcOTkSPlc+AVHzmd+MjH60QGutkVynRn3TKioLNl8PWISEWW
        Ms2lwjfhbK4i4Af8aF5U+Vxsg0IHLnYkqn/QkHg=
X-Google-Smtp-Source: AMsMyM6jD1RkPUBg8Y1mMd22aNcrS6qCKCjLvPaUN/WBmKfsLkv0uI907RjLnazUxqBBWxX9CubLOiOJa/tyxIVEmiE=
X-Received: by 2002:a81:8c9:0:b0:36d:3e4f:330e with SMTP id
 192-20020a8108c9000000b0036d3e4f330emr40158854ywi.49.1667700674530; Sat, 05
 Nov 2022 19:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com> <CABPp-BGUXKk-LSJtHP2jSDSVYNpQgzOeferx6xJ36ntDgrBNCw@mail.gmail.com>
In-Reply-To: <CABPp-BGUXKk-LSJtHP2jSDSVYNpQgzOeferx6xJ36ntDgrBNCw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 6 Nov 2022 10:11:02 +0800
Message-ID: <CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

   inHi,

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C 13:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sun, Oct 30, 2022 at 9:11 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use sparse-checkout, we often want the set of files
> > that some commands operate on to be restricted to the
> > sparse-checkout specification.
>
> It seems a bit premature to send this, when the guideline document[*]
> detailing how these options should work is still in the "Needs Review"
> state.  I know, it's been waiting for a while, but it's a _long_
> document.
>
> [*] https://lore.kernel.org/git/pull.1367.v3.git.1665269538608.gitgitgadg=
et@gmail.com/
>

Fine, I just want to start trying to experiment with this feature in
git-diff earlier,
and I can wait for the sparse-checkout.txt documentation to finish
first if needed :)

> > So introduce the `--scope` option to git diff, which have two
> > value: "sparse" and "all". "sparse" mean that diff is performed
> > restrict to paths which matching sparse-checkout specification,
> > "all" mean that diff is performed regardless of whether the path
> > meets the sparse-checkout specification.
>
> The wording probably needs some care to reflect the fact that it only
> affects cases where either --cached or revisions are passed.  In
> particular, your wording for "all" suggests behavior very different
> from today, whereas "all" is probably best thought of as today's
> current behavior.  For example, a plain `git diff` without --cached or
> revisions, should be unaffected by either of these flags.
>

Yes, after re-reading your sparse-checkout.txt patch, I realized that I
misinterpreted "--scope=3Dsparse" as sparse patterns instead of sparse
specification, and misinterpreted "-scope=3Dall" as diff on all files.

> > `--no-scope` is the default
> > option for now.
>
> What does --no-scope even mean?  You didn't explain it, and I don't
> see how it could make sense.  We explicitly avoided a `--no-` prefix
> by allowing the --scope option to take a value.  I don't think there
> should be a --no-scope option.
>

I think the =E2=80=9C--no-scope=E2=80=9D here does nothing, as if it were u=
naffected by scope
(just like correctly "--scope=3Dall", right?)

> > Add `diff.scope=3D{sparse, all}` config, which can also have the same
> > capabilities as `--scope`, and it will be covered by `--scope` option.
>
> This is not what we want.  The high level usecases should not need to
> be configured per-command.  There should be a config option which
> reflects the high level use cases (e.g. sparse.scope) and then all
> relevant commands (diff, log, grep, etc.) can key off it.
>

Ok, using a global config should indeed be more useful.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [RFC] diff: introduce scope option
> >
> >     In [1], we discovered that users working on different sparse-checko=
ut
> >     specification may download unnecessary blobs from each other's
> >     specification in collaboration. In [2] Junio suggested that maybe w=
e can
> >     restrict some git command's filespec in sparse-checkout specificati=
on to
> >     elegantly solve this problem above. In [3]: Newren and Derrick Stol=
ee
> >     prefer to name the option --scope=3D{sparse, all}.
> >
> >     So this patch is attempt to do this thing on git diff:
> >
> >     v1:
> >
> >      1. add --restrict option to git diff, which restrict diff filespec=
 in
> >         sparse-checkout specification. [4] v2.
> >      2. rename --restrict to --scope=3D{sparse, all}, support --no-scop=
e.
> >      3. add config: diff.scope=3D{sparse,all}.
> >
> >     Unresolved work:
> >
> >      1. how to properly pass this --scope=3D{sparse, all} to other comm=
ands
> >         like git log, git format-patch, etc.
>
> log & grep should accept a similar flag.  format-patch should not, and
> should ignore any config in this area.
>
> >      2. how to set the default value of scope for different diff comman=
ds.
>
> I don't understand this.
>

Oh, I was just curious if the config defaults for scope needed to be config=
ured
separately for the different diff commands  git diff-files, git diff-index,
git diff-no-index, git diff-tree, since sparse-checkout.txt mentions
the different
behavior of scope for them. Now I think this just needs to be handled in co=
mmand
code logic and no additional command level configuration is needed.

> >     [1]:
> >     https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=3D+LQ9UVd1NHgqGGEYK2=
qq6=3D=3DQgRCgLZqQ@mail.gmail.com/
> >     [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/ [3]:
> >     https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@gi=
thub.com/
> >     [4]:
> >     https://lore.kernel.org/git/pull.1368.git.1664036052741.gitgitgadge=
t@gmail.com/
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1398%=
2Fadlternative%2Fzh%2Fdiff-scope-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1398/adl=
ternative/zh/diff-scope-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1398
> >
> >  Documentation/config/diff.txt         |  12 +
> >  Documentation/diff-options.txt        |  18 +
> >  builtin/diff.c                        |   4 +
> >  diff-lib.c                            |  36 +-
> >  diff-no-index.c                       |   4 +
> >  diff.c                                |  39 +++
> >  diff.h                                |  11 +
> >  t/t4070-diff-sparse-checkout-scope.sh | 469 ++++++++++++++++++++++++++
> >  tree-diff.c                           |   5 +
> >  9 files changed, 597 insertions(+), 1 deletion(-)
> >  create mode 100644 t/t4070-diff-sparse-checkout-scope.sh
> >
> > diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.=
txt
> > index 35a7bf86d77..52707e1b2d6 100644
> > --- a/Documentation/config/diff.txt
> > +++ b/Documentation/config/diff.txt
> > @@ -201,6 +201,18 @@ diff.algorithm::
> >  --
> >  +
> >
> > +diff.scope::
> > +       Choose diff scope. The variants are as follows:
> > ++
> > +--
> > +`sparse`;;
> > +       Restrict diff paths to those matching sparse-checkout specifica=
tion.
> > +`all`;;
> > +       Without restriction, diff is performed regardless of whether th=
e path
> > +       meets the sparse-checkout specification.
>
> As noted above, this is the wrong level to specify things.  The
> description for "all" is misleading as well and suggests something
> other than "behavior B" from the direction document.
>

So do we need to make "--scope=3Dall" correspond to the "behavior B",
The correct description of it should be: "worktree-sparse-history-dense"...

> >  diff.wsErrorHighlight::
> >         Highlight whitespace errors in the `context`, `old` or `new`
> >         lines of the diff.  Multiple values are separated by comma,
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> > index 3674ac48e92..04bf83e8be1 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -195,6 +195,24 @@ For instance, if you configured the `diff.algorith=
m` variable to a
> >  non-default value and want to use the default one, then you
> >  have to use `--diff-algorithm=3Ddefault` option.
> >
> > +ifndef::git-format-patch[]
> > +ifndef::git-log[]
> > +
> > +--scope=3D{sparse|all}::
> > +       Choose diff scope. The variants are as follows:
> > ++
> > +--
> > +`--sparse`;;
> > +       Restrict diff paths to those matching sparse-checkout specifica=
tion.
> > +`--all`;;
> > +       Without restriction, diff is performed regardless of whether th=
e path
> > +       meets the sparse-checkout specification.
> > +--
> > ++
> > +
> > +endif::git-log[]
> > +endif::git-format-patch[]
>
> What about diff-files, diff-index, diff-tree, and show?
>

diff-options.txt included in their documents, and git-format-patch.txt,
git-log.txt, but should not in git-format-patch.txt. I don't know if it
should be included in git-diff-files.txt, because git diff-files compare
the files in the working tree and the index (so it's the same as
"simple" git-diff, which should not be affected by scope?)

> > +
> >  --stat[=3D<width>[,<name-width>[,<count>]]]::
> >         Generate a diffstat. By default, as much space as necessary
> >         will be used for the filename part, and the rest for the graph
> > diff --git a/builtin/diff.c b/builtin/diff.c
> > index 854d2c5a5c4..6b450f7184c 100644
> > --- a/builtin/diff.c
> > +++ b/builtin/diff.c
> > @@ -54,6 +54,10 @@ static void stuff_change(struct diff_options *opt,
> >             oideq(old_oid, new_oid) && (old_mode =3D=3D new_mode))
> >                 return;
> >
> > +       if (opt->scope =3D=3D DIFF_SCOPE_SPARSE &&
> > +           !diff_paths_in_sparse_checkout(old_path, new_path))
> > +               return;
>
> This can't be right.
>    git diff c231e0f26fe9b2ea9ec46aa68ff95ba984ce592e
> 72d42bd856228c15f702fa3c353432f4f1defe03
> (to directly diff two known blobs) will go through this function, with
> old_path =3D=3D c231e0f26fe9b2ea9ec46aa68ff95ba984ce592e and new_path =3D=
=3D
> 72d42bd856228c15f702fa3c353432f4f1defe03.  But those aren't real
> paths, and sparse-checkout should not restrict what is shown in those
> cases.
>

Yeah, it's buggy that I forget to check two blobs without paths.

> > +
> >         if (opt->flags.reverse_diff) {
> >                 SWAP(old_mode, new_mode);
> >                 SWAP(old_oid, new_oid);
> > diff --git a/diff-lib.c b/diff-lib.c
> > index 2edea41a234..a3381f2e0ff 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -88,6 +88,22 @@ static int match_stat_with_submodule(struct diff_opt=
ions *diffopt,
> >         return changed;
> >  }
> >
> > +int diff_path_in_sparse_checkout(const char *path) {
> > +       if (core_sparse_checkout_cone)
> > +               return path_in_cone_mode_sparse_checkout(path, the_repo=
sitory->index);
> > +       else
> > +               return path_in_sparse_checkout(path, the_repository->in=
dex);
> > +}
>
> This says we are including the path if it matches the sparsity
> patterns.  Thus, we have to be careful when we use this function,
> because the relevant paths are ones that match the sparsity
> specification.  The sparsity specification will always match the
> sparsity patterns when diffing two commits, but when either the index
> or the working tree is part of the diff, the sparsity specification
> *might* be temporarily expanded.
>

Yes, I may have to look at more code to better understand how and when the
"sparsity specification" is extended. Any recommendations for places to rea=
d?

> > +int diff_paths_in_sparse_checkout(const char *one, const char*two) {
> > +       if (one =3D=3D two || !strcmp(one, two))
> > +               return diff_path_in_sparse_checkout(one);
> > +       else
> > +               return diff_path_in_sparse_checkout(one) &&
> > +                      diff_path_in_sparse_checkout(two);
>
> Why && rather than || ?
>

Agree, we do need to use || here, because the one diff side in the sparse
specification, we should diff the two files.

> > +}
> > +
> > +
> >  int run_diff_files(struct rev_info *revs, unsigned int option)
> >  {
> >         int entries, i;
> > @@ -113,6 +129,9 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
> >
> >                 if (diff_can_quit_early(&revs->diffopt))
> >                         break;
> > +               if (revs->diffopt.scope =3D=3D DIFF_SCOPE_SPARSE &&
> > +                   !diff_path_in_sparse_checkout(ce->name))
> > +                       continue;
>
> Here you've cut off the possibility of showing diffs for anything
> outside the sparsity patterns, which is a mistake.  We need to handle
> a temporarily expanded sparse specification too.
>

Agree.

> >                 if (!ce_path_match(istate, ce, &revs->prune_data, NULL)=
)
> >                         continue;
> > @@ -202,7 +221,8 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
> >                                 continue;
> >                 }
> >
> > -               if (ce_uptodate(ce) || ce_skip_worktree(ce))
> > +               if (ce_uptodate(ce) ||
> > +                   (revs->diffopt.scope !=3D DIFF_SCOPE_ALL && ce_skip=
_worktree(ce)))
> >                         continue;
>
> Here you make --scope=3Dall show files even if they are skip-worktree,
> making them appear to have been deleted.  I called out your
> description earlier as potentially misleading, because it could imply
> this behavior.  It looks like you were consistent with the description
> and implementation, it just doesn't match what we want.
>

Agree too. So we should not do anything in run_diff_files.

> >                 /*
> > @@ -439,6 +459,20 @@ static void do_oneway_diff(struct unpack_trees_opt=
ions *o,
>
> do_oneway_diff is for cases where we are diffing against the index...
>
> >                         return; /* nothing to diff.. */
> >         }
> >
> > +       if (revs->diffopt.scope =3D=3D DIFF_SCOPE_SPARSE) {
> > +               if (idx && tree) {
> > +                       if (!diff_paths_in_sparse_checkout(idx->name, t=
ree->name))
> > +                               return;
> > +               } else if (idx) {
> > +                       if (!diff_path_in_sparse_checkout(idx->name))
> > +                               return;
> > +               } else if (tree) {
> > +                       if (!diff_path_in_sparse_checkout(tree->name))
> > +                               return;
> > +               } else
> > +                       return;
> > +       }
>
> ...and you again mistakenly only compare to the sparsity patterns
> instead of the sparse specification.
>

So here we should use ce_skip_worktree(idx) to check if this index entry ma=
tches
sparse specification.

> > +
> >         /* if the entry is not checked out, don't examine work tree */
> >         cached =3D o->index_only ||
> >                 (idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree=
(idx)));
>
>
>
> > diff --git a/diff-no-index.c b/diff-no-index.c
> > index 18edbdf4b59..ea94a104ea4 100644
> > --- a/diff-no-index.c
> > +++ b/diff-no-index.c
> > @@ -281,6 +281,10 @@ int diff_no_index(struct rev_info *revs,
> >
> >         fixup_paths(paths, &replacement);
> >
> > +       if (revs->diffopt.scope =3D=3D DIFF_SCOPE_SPARSE &&
> > +           !diff_paths_in_sparse_checkout(paths[0], paths[1]))
> > +               goto out;
>
> --no-index means we're diffing two files that are not tracked, or at
> least treating them as not tracked.  sparse-checkout should not affect
> such files.
>

Yeah, we should care about untracked files sparse-checkout only when
we are using git add/rm/update-index...

> > +
> >         revs->diffopt.skip_stat_unmatch =3D 1;
> >         if (!revs->diffopt.output_format)
> >                 revs->diffopt.output_format =3D DIFF_FORMAT_PATCH;
> > diff --git a/diff.c b/diff.c
> > index 285d6e2d575..9de4044ae05 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -48,6 +48,7 @@ static int diff_interhunk_context_default;
> >  static const char *diff_word_regex_cfg;
> >  static const char *external_diff_cmd_cfg;
> >  static const char *diff_order_file_cfg;
> > +static const char *external_diff_scope_cfg;
> >  int diff_auto_refresh_index =3D 1;
> >  static int diff_mnemonic_prefix;
> >  static int diff_no_prefix;
> > @@ -57,6 +58,7 @@ static int diff_dirstat_permille_default =3D 30;
> >  static struct diff_options default_diff_options;
> >  static long diff_algorithm;
> >  static unsigned ws_error_highlight_default =3D WSEH_NEW;
> > +static enum diff_scope external_diff_scope;
>
> Why is this called "external"?
>

Learn from external_diff_cmd_cfg, I should remove it.

> >  static char diff_colors[][COLOR_MAXLEN] =3D {
> >         GIT_COLOR_RESET,
> > @@ -423,6 +425,16 @@ int git_diff_ui_config(const char *var, const char=
 *value, void *cb)
> >                 return 0;
> >         }
> >
> > +       if (!strcmp(var, "diff.scope")) {
> > +               git_config_string(&external_diff_scope_cfg, var, value)=
;
> > +               if (!strcmp(value, "all"))
> > +                       external_diff_scope =3D DIFF_SCOPE_ALL;
> > +               else if (!strcmp(value, "sparse"))
> > +                       external_diff_scope =3D DIFF_SCOPE_SPARSE;
> > +               else
> > +                       return -1;
> > +       }
> > +
> >         if (git_color_config(var, value, cb) < 0)
> >                 return -1;
> >
> > @@ -4663,6 +4675,7 @@ void repo_diff_setup(struct repository *r, struct=
 diff_options *options)
> >
> >         options->color_moved =3D diff_color_moved_default;
> >         options->color_moved_ws_handling =3D diff_color_moved_ws_defaul=
t;
> > +       options->scope =3D external_diff_scope;
> >
> >         prep_parse_options(options);
> >  }
> > @@ -4914,6 +4927,29 @@ static int parse_dirstat_opt(struct diff_options=
 *options, const char *params)
> >         return 1;
> >  }
> >
> > +static int diff_opt_diff_scope(const struct option *option,
> > +                               const char *optarg, int unset)
> > +{
> > +       struct diff_options *opt =3D option->value;
> > +
> > +       if (unset) {
> > +               opt->scope =3D DIFF_SCOPE_NONE;
>
> I think we should instead have a
>     BUG_ON_OPT_NEG(unset)
> or, even better, a
>     BUG_ON_OPT_NEG_NOARG(unset, optarg)
> at the beginning of this function...
>
> > +       } else if (optarg) {
>
> ...which would also allow you to drop this if and dedent the rest of
> the function.
>

Agree.

> > +               if (!strcmp(optarg, "all")) {
> > +                       if (core_apply_sparse_checkout) {
> > +                               opt->scope =3D DIFF_SCOPE_ALL;
> > +                       }
> > +               } else if (!strcmp(optarg, "sparse")) {
> > +                       if (core_apply_sparse_checkout) {
> > +                               opt->scope =3D DIFF_SCOPE_SPARSE;
> > +                       }
>
> If core_apply_sparse_checkout is false, should we perhaps throw an
> error instead of just silently ignoring the option the user passed?
>

Agree.

> > +               } else
> > +                       return error(_("invalid --scope value: %s"), op=
targ);
> > +       }
>
> As written with no follow-on else clause here, wouldn't this silently
> accept "--scope" without an "=3D<something>" argument without an error
> and without properly initializing opt->scope?
>

Because opt will be initializing with default_diff_options in repo_diff_set=
up(),
and opt->scope should respect config value first. So I don't think there's =
a
mistake here.

> > +
> > +       return 0;
> > +}
> > +
> >  static int diff_opt_diff_filter(const struct option *option,
> >                                 const char *optarg, int unset)
> >  {
> > @@ -5683,6 +5719,9 @@ static void prep_parse_options(struct diff_option=
s *options)
> >                 OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M=
|R|T|U|X|B)...[*]]"),
> >                                N_("select files by diff type"),
> >                                PARSE_OPT_NONEG, diff_opt_diff_filter),
> > +               OPT_CALLBACK_F(0, "scope", options, N_("[sparse|all]"),
> > +                              N_("choose diff scope"),
>
> maybe "choose diff scope in sparse checkouts"?
>

OK.

> > +                              PARSE_OPT_OPTARG, diff_opt_diff_scope),
> >                 { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
> >                   N_("output to a specific file"),
> >                   PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> > diff --git a/diff.h b/diff.h
> > index 8ae18e5ab1e..90f7512034c 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -230,6 +230,12 @@ enum diff_submodule_format {
> >         DIFF_SUBMODULE_INLINE_DIFF
> >  };
> >
> > +enum diff_scope {
> > +       DIFF_SCOPE_NONE =3D 0,
> > +       DIFF_SCOPE_ALL,
> > +       DIFF_SCOPE_SPARSE,
> > +};
> > +
> >  /**
> >   * the set of options the calling program wants to affect the operatio=
n of
> >   * diffcore library with.
> > @@ -285,6 +291,9 @@ struct diff_options {
> >         /* diff-filter bits */
> >         unsigned int filter, filter_not;
> >
> > +       /* diff sparse-checkout scope */
> > +       enum diff_scope scope;
> > +
> >         int use_color;
> >
> >         /* Number of context lines to generate in patch output. */
> > @@ -696,4 +705,6 @@ void print_stat_summary(FILE *fp, int files,
> >                         int insertions, int deletions);
> >  void setup_diff_pager(struct diff_options *);
> >
> > +int diff_path_in_sparse_checkout(const char *path);
> > +int diff_paths_in_sparse_checkout(const char *one, const char *two);
> >  #endif /* DIFF_H */
> > diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-spars=
e-checkout-scope.sh
> > new file mode 100644
>
> This needs to be fixed.
>
> > index 00000000000..dca75a3308b
> > --- /dev/null
> > +++ b/t/t4070-diff-sparse-checkout-scope.sh
> > @@ -0,0 +1,469 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'diff sparse-checkout scope'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +
> > +test_expect_success 'setup' '
> > +       git init temp &&
> > +       (
> > +               cd temp &&
> > +               mkdir sub1 &&
> > +               mkdir sub2 &&
> > +               echo sub1/file1 >sub1/file1 &&
> > +               echo sub2/file2 >sub2/file2 &&
> > +               echo file1 >file1 &&
> > +               echo file2 >file2 &&
> > +               git add --all &&
> > +               git commit -m init &&
> > +               echo sub1/file1 >>sub1/file1 &&
> > +               echo sub1/file2 >>sub1/file2 &&
> > +               echo sub2/file1 >>sub2/file1 &&
> > +               echo sub2/file2 >>sub2/file2 &&
> > +               echo file1 >>file1 &&
> > +               echo file2 >>file2 &&
> > +               git add --all &&
> > +               git commit -m change1 &&
> > +               echo sub1/file1 >>sub1/file1 &&
> > +               echo sub1/file2 >>sub1/file2 &&
> > +               echo sub2/file1 >>sub2/file1 &&
> > +               echo sub2/file2 >>sub2/file2 &&
> > +               echo file1 >>file1 &&
> > +               echo file2 >>file2 &&
> > +               git add --all &&
> > +               git commit -m change2
> > +       )
> > +'
> > +
> > +reset_repo () {
> > +       rm -rf repo &&
> > +       git clone --no-checkout temp repo
>
> Why --no-checkout rather than say --sparse?
>

This is because I accidentally associated it with a
partial clone. I often use "git clone -filter=3Dblob:none -no-checkout"
to do a partial clone, then "git sparse- checkout set <pattern>"
to set sparse-checkout patterns, and "git checkout" to download
the missing blobs and checkout to a branch. But in this
test file, we only need sparse-checkout, so it's true that I should
not do such strange no-checkout thing.

> > +}
> > +
> > +reset_with_sparse_checkout() {
> > +       reset_repo &&
> > +       git -C repo sparse-checkout set $1 sub1 &&
> > +       git -C repo checkout
>
> Fixing the above would let us get rid of this really weird extra
> checkout command too.
>
> > +}
> > +
> > +change_worktree_and_index() {
> > +       (
> > +               cd repo &&
> > +               mkdir sub2 sub3 &&
> > +               echo sub1/file3 >sub1/file3 &&
> > +               echo sub2/file3 >sub2/file3 &&
> > +               echo sub3/file3 >sub3/file3 &&
> > +               echo file3 >file3 &&
> > +               git add --all --sparse &&
> > +               echo sub1/file3 >>sub1/file3 &&
> > +               echo sub2/file3 >>sub2/file3 &&
> > +               echo sub3/file3 >>sub3/file3 &&
> > +               echo file3 >>file3
> > +       )
> > +}
>
> It would be nice to modify different paths in the working tree and
> index, to see if we can handle cases where the sparse specification
> does not match the sparsity patterns better.  (So, modify files inside
> and outside the sparsity patterns, stage those changes, and then do a
> `git sparse-checkout reapply` to make the files outside the sparsity
> patterns disappear from the working tree...then modify different files
> in the working tree both inside and outside the sparsity patterns.
> And also remove some file that matches the sparsity patterns and
> manually mark it as SKIP_WORKTREE.)  That'd give us much better
> coverage.
>

Nice addition. So I should use git update-index --skip-worktree to set
skip_worktree bit for index entries.

> > +
> > +diff_scope() {
> > +       title=3D$1
> > +       need_change_worktree_and_index=3D$2
> > +       sparse_checkout_option=3D$3
> > +       scope_option=3D$4
> > +       expect=3D$5
> > +       shift 5
> > +       args=3D("$@")
> > +
> > +       test_expect_success "$title $sparse_checkout_option $scope_opti=
on" "
> > +               reset_with_sparse_checkout $sparse_checkout_option &&
> > +               if test \"$need_change_worktree_and_index\" =3D \"true\=
" ; then
> > +                       change_worktree_and_index
> > +               fi &&
> > +               git -C repo diff $scope_option ${args[*]} >actual &&
> > +               if test -z \"$expect\" ; then
> > +                       >expect
> > +               else
> > +                       cat > expect <<-EOF
> > +$expect
> > +                       EOF
> > +               fi &&
> > +               test_cmp expect actual
> > +       "
> > +}
> > +
> > +args=3D("--name-only" "HEAD" "HEAD~")
> > +diff_scope builtin_diff_tree false "--no-cone" "--scope=3Dsparse" \
> > +"sub1/file1
> > +sub1/file2" "${args[@]}"
> > +
> > +diff_scope builtin_diff_tree false "--no-cone" "--scope=3Dall" \
> > +"file1
> > +file2
> > +sub1/file1
> > +sub1/file2
> > +sub2/file1
> > +sub2/file2" "${args[@]}"
> > +
> > +diff_scope builtin_diff_tree false "--no-cone" "--no-scope" \
> > +"file1
> > +file2
> > +sub1/file1
> > +sub1/file2
> > +sub2/file1
> > +sub2/file2" "${args[@]}"
> > +
> > +diff_scope builtin_diff_tree false "--cone" "--scope=3Dsparse" \
> > +"file1
> > +file2
> > +sub1/file1
> > +sub1/file2" "${args[@]}"
> > +
> > +diff_scope builtin_diff_tree false "--cone" "--scope=3Dall" \
> > +"file1
> > +file2
> > +sub1/file1
> > +sub1/file2
> > +sub2/file1
> > +sub2/file2" "${args[@]}"
> > +
> > +diff_scope builtin_diff_tree false "--cone" "--no-scope" \
> > +"file1
> > +file2
> > +sub1/file1
> > +sub1/file2
> > +sub2/file1
> > +sub2/file2" "${args[@]}"
> > +
> > +args=3D("--name-only" "HEAD~")
> > +diff_scope builtin_diff_index true "--no-cone" "--scope=3Dsparse" \
> > +"sub1/file1
> > +sub1/file2
> > +sub1/file3" "${args[@]}"
>
> Here's a good example where the testcase is doing the wrong thing.
> The expected answer here would also include file3, sub2/file3, and
> sub3/file3.
>

Yeah. Files that are not part of the sparse-checkout patterns are temporari=
ly
extended into the sparse specification.

> > +
> > +diff_scope builtin_diff_index true "--no-cone" "--scope=3Dall" \
> > +"file1
> > +file2
> > +file3
> > +sub1/file1
> > +sub1/file2
> > +sub1/file3
> > +sub2/file1
> > +sub2/file2
> > +sub2/file3
> > +sub3/file3" "${args[@]}"
> > +
> > +diff_scope builtin_diff_index true "--no-cone" "--no-scope" \
> > +"file1
> > +file2
> > +file3
> > +sub1/file1
> > +sub1/file2
> > +sub1/file3
> > +sub2/file1
> > +sub2/file2
> > +sub2/file3
> > +sub3/file3" "${args[@]}"
> > +
> > +diff_scope builtin_diff_index true "--cone" "--scope=3Dsparse" \
> > +"file1
> > +file2
> > +file3
> > +sub1/file1
> > +sub1/file2
> > +sub1/file3" "${args[@]}"
>
> This is also wrong; it's missing sub2/file3 and sub3/file3.
>
> > +
> > +diff_scope builtin_diff_index true "--cone" "--scope=3Dall" \
> > +"file1
> > +file2
> > +file3
> > +sub1/file1
> > +sub1/file2
> > +sub1/file3
> > +sub2/file1
> > +sub2/file2
> > +sub2/file3
> > +sub3/file3" "${args[@]}"
> > +
> > +diff_scope builtin_diff_index true "--cone" "--no-scope" \
> > +"file1
> > +file2
> > +file3
> > +sub1/file1
> > +sub1/file2
> > +sub1/file3
> > +sub2/file1
> > +sub2/file2
> > +sub2/file3
> > +sub3/file3" "${args[@]}"
> > +
> > +args=3D("--name-only" "file3" "sub1/" "sub2/")
> > +
> > +diff_scope builtin_diff_files true "--no-cone" "--scope=3Dsparse" \
> > +"sub1/file3" "${args[@]}"
>
> This should also include file3, sub2/file3, and sub3/file3.
> `--scope=3D` should not affect diff output at all if neither --cached
> nor revision arguments are supplied.
>

Agree.

> > +
> > +diff_scope builtin_diff_files true "--no-cone" "--scope=3Dall" \
> > +"file3
> > +sub1/file3
> > +sub2/file1
> > +sub2/file2
> > +sub2/file3" "${args[@]}"
>
> This is wrong due to including too much; it should not include
> sub2/file1 or sub2/file2 (it is only including those because it is
> showing them as deleted, when they are not deleted but are
> SKIP_WORKTREE).
>

Agree.

> I think I'm going to stop reviewing here.  I'm probably just going to
> keep repeating the same issues I identified earlier if I continue.

Thank you very much for your review, you have pointed out very many
problems with this patch :)

--
ZheNing Hu
