Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779241F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 23:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeDLXuF (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:50:05 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:44749 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeDLXuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:50:04 -0400
Received: by mail-yb0-f169.google.com with SMTP id m185-v6so3118765ybm.11
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SpNCNnF9QM9bh15R7N3+4r8yRQn7zQ36uZq6u7VdvkQ=;
        b=Rg0C5LcgQ5PSFLT31y4PoKZgRRU6lDEViOHKIqg3hO/U3z6nEVIXLcGE6rQlm6RTLa
         JVE4xfDUwy6bqYuH6x9maQlxFjIYBclKH6323t0yg2wqTnOhJZx3Hpiskh3hNV8ujfoT
         T/rIM46pD/r7OoE8LEi8PS1SEKDgxxP3Wtja6IryA89zIUHWwK5BJ0nsP60n2nTpHcrj
         8rmS8gzz1Xvb+xzkCtFpuZKlkgYwmRo7nUwc8a9s5N6QXz4BZ8qR6mogCBftjayKERMz
         ItLOlT3eWl7Se9cclfOTiKa3Y3TcMdvWf4GnjUaYffNFfbNAGIkb1XXFIcpVP1Nm6pek
         95QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SpNCNnF9QM9bh15R7N3+4r8yRQn7zQ36uZq6u7VdvkQ=;
        b=lZoM4XCxv4pjjy8wbkYSCb3B8mS5+V4JpnKL+jEys9wxNewWann6xiTw0mm2rfTAk1
         7eKBNuTxLtKsZ/VPWwRHMlUaUkV8CoPddmoYF1oi7HpLhotXtv6FLBA+PIuIoHn4LYBN
         yOfBYfsf+ELYRyVR2p2coiISWzFRJjwnPXXUEVuGQK/Wb6IjkUFy8dpT47Swgr9X0sNM
         cUS4ZpLkF1XHeeGTACpYZwom0aQ6HHcSL7iBSY6dj7qSVEg1m0QAIlC+zZ7bSY0xRgvt
         xSwAFY/GA/1CYIdLLpKyswiHsTnIWCphKyRMtXKra02SDQ1xdE5JTozQRvV048mtfQbh
         LOAg==
X-Gm-Message-State: ALQs6tBmiIENzdDdrD3wjXdR32YyWOlnrEkYub4aXIS7zymBVmLb8Cb7
        FmSK9P3Cps+YSV1JaemwtlwwM+zBdYGu7NT5cIbvdw==
X-Google-Smtp-Source: AIpwx49w60Tlnt/7+z+cHakZrVUQ0MrEzNX92ALvr4baInJ7Q68FJDpRBoUXBBjEdnpo7fERwErc5uff5VzIWe2Z7iY=
X-Received: by 2002:a25:a568:: with SMTP id h95-v6mr2234852ybi.515.1523577003475;
 Thu, 12 Apr 2018 16:50:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 12 Apr 2018 16:50:03
 -0700 (PDT)
In-Reply-To: <20180412222047.5716-2-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180412222047.5716-2-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Apr 2018 16:50:03 -0700
Message-ID: <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com>
Subject: Re: [RFC 01/10] submodule: add 'core.submodulesFile' to override the
 '.gitmodules' path
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> When multiple repositories with detached work-trees take turns using the
> same directory as their work-tree, and more than one of them want to use
> submodules, there will be conflicts about the '.gitmodules' file.

unlike other files which would not conflict?
There might be file names such as LICENSE, Readme.md etc,
which are common enough that they would produce conflicts as well?
I find this argument on its own rather weak. ("Just delete everything in
the working dir before using it with another repository"). I might be
missing a crucial bit here?

> git hardcodes this path so it's not possible to override its location on
> a per-repository basis to allow such repositories to coexists
> peacefully.
>
> Make the path of the "gitmodules file" customizable exposing
> a 'core.submodulesFile' configuration setting.
>
> The default value will still be '.gitmodules' when 'core.submodulesFile'
> is not set.

ok.


> --- a/cache.h
> +++ b/cache.h
> @@ -1774,6 +1774,7 @@ extern void prepare_pager_args(struct child_process *, const char *pager);
>  extern const char *editor_program;
>  extern const char *askpass_program;
>  extern const char *excludes_file;
> +extern const char *submodules_file;

Could you place this variable in repository.h in struct repository?
(Some developers currently try to move any global state to that place,
as that makes working with e.g. nested submodules easier in-process
and you would not need to spawn processes for submodules)

Once migrated to the repository struct mentioned above, you'd access
it via the_repository->submodules_file for the main repository.


> diff --git a/git-submodule.sh b/git-submodule.sh
> index 24914963c..610fd0dc5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -71,7 +71,9 @@ get_submodule_config () {
>         value=$(git config submodule."$name"."$option")
>         if test -z "$value"
>         then
> -               value=$(git config -f .gitmodules submodule."$name"."$option")
> +               gitmodules_file=$(git config core.submodulesfile)
> +               : ${gitmodules_file:=.gitmodules}
> +               value=$(git config -f "$gitmodules_file" submodule."$name"."$option")

I wonder if it would be cheaper to write a special config lookup now, e.g.
in builtin/submodule--helper.c we could have a "config-from-gitmodules"
subcommand that is looking up the modules file and then running the config
on that file.

I am surprised how little access of the .gitmodules is left in git-submodule.sh
(which is partially ported to the builtin/submodule--helper.c)

> diff --git a/submodule-config.c b/submodule-config.c
> index 3f2075764..8a3396ade 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -468,7 +468,7 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
>                 return 1;
>         }
>
> -       strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
> +       strbuf_addf(rev, "%s:%s", oid_to_hex(treeish_name), submodules_file);
>         if (get_oid(rev->buf, gitmodules_oid) >= 0)
>                 ret = 1;
>
> @@ -583,7 +583,7 @@ void repo_read_gitmodules(struct repository *repo)
>                 if (repo_read_index(repo) < 0)
>                         return;
>
> -               gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
> +               gitmodules = repo_worktree_path(repo, submodules_file);
>
>                 if (!is_gitmodules_unmerged(repo->index))
>                         git_config_from_file(gitmodules_cb, gitmodules, repo);
> diff --git a/submodule.c b/submodule.c
> index 9a50168b2..2afbdb644 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -36,13 +36,13 @@ static struct oid_array ref_tips_after_fetch;
>   */
>  int is_gitmodules_unmerged(const struct index_state *istate)
>  {
> -       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +       int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));

Ah, regarding the coverletter: This clearly assumes the modules
file is in the tree. So at least here we would make an exception
for files outside the tree to either not check for un-merged-ness or
disallow that case entirely.



There are quite a few functions in submodule.c which access the new global. :/
So moving them to the_repository should be fine, but eventually (not
in this series)
all these functions would would want to take a repository argument as well
such that they work on more than the_repository.

Thanks,
Stefan
