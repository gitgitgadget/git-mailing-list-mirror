Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5935521847
	for <e@80x24.org>; Wed,  2 May 2018 00:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750785AbeEBAkY (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:40:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40916 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEBAkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:40:23 -0400
Received: by mail-it0-f65.google.com with SMTP id j186-v6so15038036ita.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W7YqoOFWrP0u+48twk9UIGhVr+RcLg5obKsk9Zh77fQ=;
        b=HI7XbYgFShA5HUkoBc7AGnzpOudlF8YFVs8KFKYNRnebkljhNnVfF6BXbTiWj0AwUQ
         +v0Ramj5zNkPxC4dfAsMr46mvlmEGvDZfyky99MnB2OYX4v3Sa6j6W0IiVpHJgjjvzcK
         nPYDQx4iZXslwP7g3CNIEytFDtsbpC4B79FO7V+yQEa0tVJu0QQzlkaWEdx3vjWnwGOQ
         WrK3oais9CynoMknS4VKxyZcajlG0v+M9sgeAeQ7dsy0oASClOusH6TuloWosaWgy+vq
         wrVMsVSSMbP1um3wW4ViC4Hj5oihEPbBrauH5YZ7dy60Qr1vHT/SlzgII/M39cq4lgkL
         Al0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W7YqoOFWrP0u+48twk9UIGhVr+RcLg5obKsk9Zh77fQ=;
        b=dwObtgbx63l44txaAgrLVVHHMgCHgegzwmclzqV8T68uY33GzJ2UqLi96XATL1ik1J
         jnnaZ05atROVepRToKgXCrQkYylatxt7NVPgG37iCHh5IyUPdL71qBfNNaFkTqjvEfsG
         Rs9QZCNFw65GUdTTr3ePHb3E4+pM9IMRJ+cyMDLzsCVAslX3jCPQOHAPvTAtqHNgh3QH
         vm6QqxZXaMgbxiKxBsnHuHHhgpcvJhmuO9iQDRmWJgGpfZWPJnhQo6rqObyXm0b/d0nn
         XYecP1YI1yltYIlDrI3JoYK8fzrUT43BLuxfVN1/3FFJUnZg0FaBErj7GOZqtV/irUL/
         IFUw==
X-Gm-Message-State: ALQs6tDyfk+bPaMz2UeD4HCwHAD7Iotk0a9xQpLdJwwcNZRZUhucnObq
        RPWVBitS6mQ2O4JBs9NVeotxXgF918Xt9WdC3mMFWa3W
X-Google-Smtp-Source: AB8JxZrviZIqBoDgy3bPUELi0ScBIrRH6g/giik+l5SMQvonm1/RRhQbTXDCn+tBzuW4EUfBKPSSx8539pc2C4e4x7w=
X-Received: by 2002:a24:5fca:: with SMTP id r193-v6mr16948745itb.89.1525221622892;
 Tue, 01 May 2018 17:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Tue, 1 May 2018 17:40:22 -0700 (PDT)
In-Reply-To: <20180502002759.8207-4-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502002759.8207-1-kcghost@gmail.com> <20180502002759.8207-4-kcghost@gmail.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Tue, 1 May 2018 20:40:22 -0400
Message-ID: <CAEp-SHXmWv=peu3-j3AodAhwAPgyPNVrTE4DJuFcr0mTn2M3iw@mail.gmail.com>
Subject: Re: [PATCH 3/3] submodule: add --dissociate option to add/update commands
To:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just noticed I missed the other 'test_must_fail'. Resubmitting in a few moments.

On Tue, May 1, 2018 at 8:27 PM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> Add --dissociate option to add and update commands, both clone helper commands
> that already have the --reference option --dissociate pairs with.
>
> Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
> ---
>  Documentation/git-submodule.txt | 10 +++++++++-
>  builtin/submodule--helper.c     | 16 +++++++++++++---
>  git-submodule.sh                | 10 +++++++++-
>  t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
>  4 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index d1ebe32e8..a75b95043 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -369,7 +369,15 @@ the submodule itself.
>         this option will be passed to the linkgit:git-clone[1] command.
>  +
>  *NOTE*: Do *not* use this option unless you have read the note
> -for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
> +for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissociate`
> +options carefully.
> +
> +--dissociate::
> +       This option is only valid for add and update commands.  These
> +       commands sometimes need to clone a remote repository. In this case,
> +       this option will be passed to the linkgit:git-clone[1] command.
> ++
> +*NOTE*: see the NOTE for the `--reference` option.
>
>  --recursive::
>         This option is only valid for foreach, update, status and sync commands.
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6ba8587b6..a85b30419 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1056,7 +1056,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
>  }
>
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
> -                          const char *depth, struct string_list *reference,
> +                          const char *depth, struct string_list *reference, int dissociate,
>                            int quiet, int progress)
>  {
>         struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1075,6 +1075,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>                         argv_array_pushl(&cp.args, "--reference",
>                                          item->string, NULL);
>         }
> +       if (dissociate)
> +               argv_array_push(&cp.args, "--dissociate");
>         if (gitdir && *gitdir)
>                 argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
>
> @@ -1190,6 +1192,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         char *p, *path = NULL, *sm_gitdir;
>         struct strbuf sb = STRBUF_INIT;
>         struct string_list reference = STRING_LIST_INIT_NODUP;
> +       int dissociate = 0;
>         char *sm_alternate = NULL, *error_strategy = NULL;
>
>         struct option module_clone_options[] = {
> @@ -1208,6 +1211,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>                 OPT_STRING_LIST(0, "reference", &reference,
>                            N_("repo"),
>                            N_("reference repository")),
> +               OPT_BOOL(0, "dissociate", &dissociate,
> +                          N_("use --reference only while cloning")),
>                 OPT_STRING(0, "depth", &depth,
>                            N_("string"),
>                            N_("depth for shallow clones")),
> @@ -1247,7 +1252,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>
>                 prepare_possible_alternates(name, &reference);
>
> -               if (clone_submodule(path, sm_gitdir, url, depth, &reference,
> +               if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
>                                     quiet, progress))
>                         die(_("clone of '%s' into submodule path '%s' failed"),
>                             url, path);
> @@ -1300,6 +1305,7 @@ struct submodule_update_clone {
>         int quiet;
>         int recommend_shallow;
>         struct string_list references;
> +       int dissociate;
>         const char *depth;
>         const char *recursive_prefix;
>         const char *prefix;
> @@ -1315,7 +1321,7 @@ struct submodule_update_clone {
>         int failed_clones_nr, failed_clones_alloc;
>  };
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> -       SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
> +       SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
>         NULL, NULL, NULL, \
>         STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
>
> @@ -1442,6 +1448,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>                 for_each_string_list_item(item, &suc->references)
>                         argv_array_pushl(&child->args, "--reference", item->string, NULL);
>         }
> +       if (suc->dissociate)
> +               argv_array_push(&child->args, "--dissociate");
>         if (suc->depth)
>                 argv_array_push(&child->args, suc->depth);
>
> @@ -1575,6 +1583,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>                            N_("rebase, merge, checkout or none")),
>                 OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
>                            N_("reference repository")),
> +               OPT_BOOL(0, "dissociate", &suc.dissociate,
> +                          N_("use --reference only while cloning")),
>                 OPT_STRING(0, "depth", &suc.depth, "<depth>",
>                            N_("Create a shallow clone truncated to the "
>                               "specified number of revisions")),
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 39c241a1d..1fddc098f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -42,6 +42,7 @@ prefix=
>  custom_name=
>  depth=
>  progress=
> +dissociate=
>
>  die_if_unmatched ()
>  {
> @@ -128,6 +129,9 @@ cmd_add()
>                 --reference=*)
>                         reference_path="${1#--reference=}"
>                         ;;
> +               --dissociate)
> +                       dissociate=1
> +                       ;;
>                 --name)
>                         case "$2" in '') usage ;; esac
>                         custom_name=$2
> @@ -258,7 +262,7 @@ or you are unsure what this means choose another name with the '--name' option."
>                                 eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
>                         fi
>                 fi
> -               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
> +               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
>                 (
>                         sanitize_submodule_env
>                         cd "$sm_path" &&
> @@ -493,6 +497,9 @@ cmd_update()
>                 --reference=*)
>                         reference="$1"
>                         ;;
> +               --dissociate)
> +                       dissociate=1
> +                       ;;
>                 -m|--merge)
>                         update="merge"
>                         ;;
> @@ -550,6 +557,7 @@ cmd_update()
>                 ${prefix:+--recursive-prefix "$prefix"} \
>                 ${update:+--update "$update"} \
>                 ${reference:+"$reference"} \
> +               ${dissociate:+"--dissociate"} \
>                 ${depth:+--depth "$depth"} \
>                 $recommend_shallow \
>                 $jobs \
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index e159fc503..1b3e7c2f7 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -59,6 +59,16 @@ test_expect_success 'submodule add --reference uses alternates' '
>         test_alternate_is_used super/.git/modules/sub/objects/info/alternates super/sub
>  '
>
> +test_expect_success 'submodule add --reference with --dissociate doesnt use alternates' '
> +       (
> +               cd super &&
> +               git submodule add --reference ../B --dissociate "file://$base_dir/A" sub-dissociate &&
> +               git commit -m B-super-added &&
> +               git repack -ad
> +       ) &&
> +       test_path_is_missing super/.git/modules/sub-dissociate/objects/info/alternates
> +'
> +
>  test_expect_success 'that reference gets used with add' '
>         (
>                 cd super/sub &&
> @@ -82,6 +92,13 @@ test_expect_success 'updating superproject keeps alternates' '
>         test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
>  '
>
> +test_expect_success 'updating superproject with --dissociate doesnt keep alternates' '
> +       test_when_finished "rm -rf super-clone" &&
> +       git clone super super-clone &&
> +       git -C super-clone submodule update --init --reference ../B --dissociate &&
> +       test_must_fail test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
> +'
> +
>  test_expect_success 'submodules use alternates when cloning a superproject' '
>         test_when_finished "rm -rf super-clone" &&
>         git clone --reference super --recursive super super-clone &&
> --
> 2.17.0.1.ge0414f29c.dirty
>
