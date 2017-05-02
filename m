Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABBC207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750775AbdEBBeh (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:34:37 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35175 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdEBBeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:34:36 -0400
Received: by mail-pg0-f47.google.com with SMTP id o3so47329758pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+GLKbUXF9qLpwGD+XcckfP7RQi2Jg0LhbDOikaEftz4=;
        b=Lqv59o4zpcqYX/M2gwDBSkM/VxXM+rM2uKb2mJlZmD1uySahyxsi/wa3GgCnoYty1M
         9DQ1a4IZwvTiV9iuPGzyhgM9BJDjdAZuspFPWEFf42ppuBLPq8VgGNVOBZ5UU4dzf66a
         5vhoo9exrHsOA7UkHu35bCEXleyayEAig6Njf8KozpdozAZvdzYaVDIZClBr3TuvIj62
         0s1TnQguli7aptrKtFDJ5D+xF4l9H5iIXIf9aQ8Rf5Kt8JsbOmYf1edfXvrMtUgdl0If
         vWxbWDWh+jocIldd1nr1fsMMIi/i2GzGCRWa7mkyh0FZn3GVxyRN24/WMd1YDjXB+Gw9
         UinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+GLKbUXF9qLpwGD+XcckfP7RQi2Jg0LhbDOikaEftz4=;
        b=FO5/8c2oYmWs3HxU7oL9+gj7/ELdpR647LdM0u+hE1ZQiE68n3ukJG4CfesFSq5pd+
         maAaAoeBaSz5aFM37YcYZ5+v7XxPy3pYt8ZFOjZMpT2+YJW8UVmM/O5tgqAtaOiBHJJ0
         YQNzThlk19anRiPMfAqrLiJ07I7/PBiY/oP6meBOnY1Nvm1dmgho3hqgyUGBwKhbRQAM
         L2mEi/ts6gMBmq/VlmwHcfFdqVV7VVOKjIV/D9xpkG9SkFVlDeR+r9mpUqbuufEmIZnJ
         Xok/H8tF+LLtnmCiBbrH6kcSOVgDpo6Z/kpyktqMKK0m0JZXbazfcpKk6sF9j+r/0lXe
         j8WA==
X-Gm-Message-State: AN3rC/6HtVAqNqNDt4pDCsG+q+UW0PNJaHUoGeWEuLXHSFWza5KBQa+K
        wfqq4ttsDxWc5+U9OoR8QMecoIyvzN83yvgeLQ==
X-Received: by 10.99.56.66 with SMTP id h2mr30490472pgn.40.1493688876003; Mon,
 01 May 2017 18:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 18:34:35 -0700 (PDT)
In-Reply-To: <20170502010239.179369-6-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 18:34:35 -0700
Message-ID: <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] submodule: improve submodule_has_commits
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach 'submodule_has_commits()' to ensure that if a commit exists in a
> submodule, that it is also reachable from a ref.
>
> This is a preparatory step prior to merging the logic which checks for
> changed submodules when fetching or pushing.
>
> Change-Id: I4fed2acfa7e69a5fbbca534df165671e77a90f22
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 3bcf44521..057695e64 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -644,10 +644,44 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
>  {
>         int has_commit = 1;
>
> +       /*
> +        * Perform a cheap, but incorrect check for the existance of 'commits'.
> +        * This is done by adding the submodule's object store to the in-core
> +        * object store, and then querying for each commit's existance.  If we
> +        * do not have the commit object anywhere, there is no chance we have
> +        * it in the object store of the correct submodule and have it
> +        * reachable from a ref, so we can fail early without spawning rev-list
> +        * which is expensive.
> +        */
>         if (add_submodule_odb(path))
>                 return 0;

Thanks for the comment!

>
>         oid_array_for_each_unique(commits, check_has_commit, &has_commit);
> +
> +       if (has_commit) {
> +               /*
> +                * Even if the submodule is checked out and the commit is
> +                * present, make sure it exists in the submodule's object store
> +                * and that it is reachable from a ref.
> +                */
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               struct strbuf out = STRBUF_INIT;
> +
> +               argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
> +               oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
> +               argv_array_pushl(&cp.args, "--not", "--all", NULL);
> +
> +               prepare_submodule_repo_env(&cp.env_array);
> +               cp.git_cmd = 1;
> +               cp.no_stdin = 1;
> +               cp.dir = path;
> +
> +               if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)

eh, I gave too much and self-contradicting feedback here earlier,
ideally I'd like to review this to be similar as:

    if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1)
        die("cannot capture git-rev-list in submodule '%s', sub->path);

    if (out.len)
        has_commit = 0;

instead as that does not have a silent error. (though it errs
on the safe side, so maybe it is not to bad.)

I could understand if the callers do not want to have
`submodule_has_commits` die()-ing on them, so maybe

    if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) {
        warning("cannot capture git-rev-list in submodule '%s', sub->path);
        has_commit = -1;
        /* this would require auditing all callers and handling -1 though */
    }

    if (out.len)
        has_commit = 0;

As the comment eludes, we'd then have
 0 -> has no commits
 1 -> has commits
-1 -> error

So to group (error || has_no_commits), we could write

    if (submodule_has_commits(..) <= 0)

which is awkward. So maybe we can rename the function
to misses_submodule_commits instead, as then we could
flip the return value as well and have

 0 -> has commits
 1 -> has no commits
-1 -> error

and the lazy invoker could just go with

    if (!misses_submodule_commits(..))
        proceed();
    else
        die("missing submodule commits or errors; I don't care");

whereas the careful invoker could go with

    switch (misses_submodule_commits(..)) {
    case 0:
        proceed(); break;
    case 1:
        pull_magic_trick(); break;
    case -1:
        make_errors_go_away_and_retry(); break;
    }



---
On the longer term plan:
As you wrote about costs. Maybe instead of invoking rev-list,
we could try to have this in-core as a first try-out for
"classified-repos", looking at refs.h there is e.g.

    int for_each_ref_submodule(const char *submodule_path,
          each_ref_fn fn, void *cb_data);

which we could use to obtain all submodule refs and then
use the revision walking machinery to find out ourselves if
we have or do not have the commits. (As we loaded the
odb of the submodule, this would *just work*, building one
kludgy hack upon the next.)

Thanks,
Stefan
