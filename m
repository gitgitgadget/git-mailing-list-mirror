Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB6D1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeHOTlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:41:12 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39516 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbeHOTlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:41:12 -0400
Received: by mail-ua1-f67.google.com with SMTP id g18-v6so1923825uam.6
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PNbEvCq+PUXdndTSVUU8KfigOWnc7fuF+xoqIpCJVVM=;
        b=hdq/3mLwAUgHx4eUrRlxaq2Nyx4kdakU6veRp9yot5n18wF6H2Cmz9lDp3AsxWVj8m
         FYpkmSDuNQI+sC4RWe5HtAJLsTGx5EsI2gIala8DfN7eg8xWfCzwWGPD9OhvCqBDu63S
         aKKGWA8FXZxnxlZN4XrNk8R4WPbonbIYWQFu60KBWtBUKzFh48OZ34WTlRSKKuNUd2MR
         e8mpe0GiSsb+8zDr5QNa+VpuC8csWk0d2k679+FsxK9xD346JyKtQBdFaO7LHzNpyoMv
         iV8tTxlVhe4F4jTzjddX/sObqghaBGZkvKTIHDDywIFtDvLI/H2xqlwv9YV3IiJMPfpD
         cPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PNbEvCq+PUXdndTSVUU8KfigOWnc7fuF+xoqIpCJVVM=;
        b=HvQw4r6y0EvppPPMHIN7Sa7oZu9sjXIkzD6aM92QoXDY+nzI712y8ZrkG1+MU/jtO8
         5miMFO+2WY6gU5fRJb8G0hlXTX9Cs9TbkMQ4zET/uprh+BOyMzVOubgusvNqSxsEHHLy
         Fpq+8D1lr1dP2BM3AUPVTiYKTATbI5rNeDN9WdUlyfFb0m18x0OCtV9ikdRJjRCFlBto
         tOHfT/yEOBAAmejjgLZaC6zwUOowMyjfwq4rvccW+x4oWscX1AU/8pXQBB0xapGJOH4F
         QJLUDwkBZqQyowRKOf//rFE2WTXvLZf2LIQGtpP8zAA9VbIDD80cJDiWACI+bNUBTgUL
         Eaew==
X-Gm-Message-State: AOUpUlEY668D64m2IL/n7hkiM553RNsaaXLm5PkHYxn2p4lOygVG9KEe
        z9/qvGqtXq8WmB3oljtBMdziuO8P7WSUFpUwhQA=
X-Google-Smtp-Source: AA+uWPwSt4kfo9nP9iHRl2I5Byp+2+/RDLtll8TuSusRDHpgyqVYB6ZkvwrE6+QZncZi4ClJyBkSg2P+dlTS+DlqPEo=
X-Received: by 2002:ab0:66d4:: with SMTP id d20-v6mr17563391uaq.112.1534351697113;
 Wed, 15 Aug 2018 09:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com>
In-Reply-To: <20180815162308.17747-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Aug 2018 09:48:05 -0700
Message-ID: <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:24 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:

The patch looks good, but since this touches multiple .c files, I
think I'd s/branch.c/branch/ in the subject line.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  branch.c           | 22 ++++++++++++----------
>  branch.h           |  7 +++++--
>  builtin/am.c       |  2 +-
>  builtin/branch.c   |  6 ++++--
>  builtin/checkout.c |  5 +++--
>  builtin/reset.c    |  2 +-
>  6 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index ecd710d730..0baa1f6877 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -244,7 +244,8 @@ N_("\n"
>  "will track its remote counterpart, you may want to use\n"
>  "\"git push -u\" to set the upstream config as you push.");
>
> -void create_branch(const char *name, const char *start_name,
> +void create_branch(struct repository *repo,
> +                  const char *name, const char *start_name,
>                    int force, int clobber_head_ok, int reflog,
>                    int quiet, enum branch_track track)
>  {
> @@ -302,7 +303,8 @@ void create_branch(const char *name, const char *star=
t_name,
>                 break;
>         }
>
> -       if ((commit =3D lookup_commit_reference(the_repository, &oid)) =
=3D=3D NULL)
> +       commit =3D lookup_commit_reference(repo, &oid);
> +       if (!commit)
>                 die(_("Not a valid branch point: '%s'."), start_name);
>         oidcpy(&oid, &commit->object.oid);
>
> @@ -338,15 +340,15 @@ void create_branch(const char *name, const char *st=
art_name,
>         free(real_ref);
>  }
>
> -void remove_branch_state(void)
> +void remove_branch_state(struct repository *repo)
>  {
> -       unlink(git_path_cherry_pick_head(the_repository));
> -       unlink(git_path_revert_head(the_repository));
> -       unlink(git_path_merge_head(the_repository));
> -       unlink(git_path_merge_rr(the_repository));
> -       unlink(git_path_merge_msg(the_repository));
> -       unlink(git_path_merge_mode(the_repository));
> -       unlink(git_path_squash_msg(the_repository));
> +       unlink(git_path_cherry_pick_head(repo));
> +       unlink(git_path_revert_head(repo));
> +       unlink(git_path_merge_head(repo));
> +       unlink(git_path_merge_rr(repo));
> +       unlink(git_path_merge_msg(repo));
> +       unlink(git_path_merge_mode(repo));
> +       unlink(git_path_squash_msg(repo));
>  }
>
>  void die_if_checked_out(const char *branch, int ignore_current_worktree)
> diff --git a/branch.h b/branch.h
> index 473d0a93e9..14d8282927 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -3,6 +3,8 @@
>
>  /* Functions for acting on the information about branches. */
>
> +struct repository;
> +
>  /*
>   * Creates a new branch, where:
>   *
> @@ -24,7 +26,8 @@
>   *     that start_name is a tracking branch for (if any).
>   *
>   */
> -void create_branch(const char *name, const char *start_name,
> +void create_branch(struct repository *repo,
> +                  const char *name, const char *start_name,
>                    int force, int clobber_head_ok,
>                    int reflog, int quiet, enum branch_track track);
>
> @@ -47,7 +50,7 @@ extern int validate_new_branchname(const char *name, st=
ruct strbuf *ref, int for
>   * Remove information about the state of working on the current
>   * branch. (E.g., MERGE_HEAD)
>   */
> -void remove_branch_state(void);
> +void remove_branch_state(struct repository *);
>
>  /*
>   * Configure local branch "local" as downstream to branch "remote"
> diff --git a/builtin/am.c b/builtin/am.c
> index 2c19e69f58..7abe39939e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2017,7 +2017,7 @@ static int clean_index(const struct object_id *head=
, const struct object_id *rem
>         if (merge_tree(remote_tree))
>                 return -1;
>
> -       remove_branch_state();
> +       remove_branch_state(the_repository);
>
>         return 0;
>  }
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4fc55c3508..e04d528ce1 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -795,7 +795,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                  * create_branch takes care of setting up the tracking
>                  * info and making sure new_upstream is correct
>                  */
> -               create_branch(branch->name, new_upstream, 0, 0, 0, quiet,=
 BRANCH_TRACK_OVERRIDE);
> +               create_branch(the_repository, branch->name, new_upstream,
> +                             0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
>         } else if (unset_upstream) {
>                 struct branch *branch =3D branch_get(argv[0]);
>                 struct strbuf buf =3D STRBUF_INIT;
> @@ -831,7 +832,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                 if (track =3D=3D BRANCH_TRACK_OVERRIDE)
>                         die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead."));
>
> -               create_branch(argv[0], (argc =3D=3D 2) ? argv[1] : head,
> +               create_branch(the_repository,
> +                             argv[0], (argc =3D=3D 2) ? argv[1] : head,
>                               force, 0, reflog, quiet, track);
>
>         } else
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 516136a23a..4756018272 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -653,7 +653,8 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
>                         free(refname);
>                 }
>                 else
> -                       create_branch(opts->new_branch, new_branch_info->=
name,
> +                       create_branch(the_repository,
> +                                     opts->new_branch, new_branch_info->=
name,
>                                       opts->new_branch_force ? 1 : 0,
>                                       opts->new_branch_force ? 1 : 0,
>                                       opts->new_branch_log,
> @@ -711,7 +712,7 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
>                                 delete_reflog(old_branch_info->path);
>                 }
>         }
> -       remove_branch_state();
> +       remove_branch_state(the_repository);
>         strbuf_release(&msg);
>         if (!opts->quiet &&
>             (new_branch_info->path || (!opts->force_detach && !strcmp(new=
_branch_info->name, "HEAD"))))
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 11cd0dcb8c..d90ccdb839 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -399,7 +399,7 @@ int cmd_reset(int argc, const char **argv, const char=
 *prefix)
>                         print_new_head_line(lookup_commit_reference(the_r=
epository, &oid));
>         }
>         if (!pathspec.nr)
> -               remove_branch_state();
> +               remove_branch_state(the_repository);
>
>         return update_ref_status;
>  }
> --
> 2.18.0.1004.g6639190530
>
