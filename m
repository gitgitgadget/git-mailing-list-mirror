Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9691FD4F
	for <e@80x24.org>; Wed, 30 May 2018 18:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeE3S6g (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:58:36 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37943 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbeE3S6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:58:35 -0400
Received: by mail-yb0-f193.google.com with SMTP id q62-v6so5241476ybg.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f+2ogpMvHZnSzrnFVs7Ch8Tz92FDuT6A3oGtG/Qchk0=;
        b=b16Wy3dn36KfzTIJ3iaITgQc+lw3eTkbcD9yiRhvJfn+RcMugLRsHk6gFRs23dE1Hk
         z5ZwxgRsrAIzpWrr7+j284N3PgI3zspQXMltkWG3yq9VOGueeF7YF2Gbkvo4pD7XcVLA
         kuWC9o6X3KpgWxxpTpN5bwBYKFJUvVTxocGX1nHYFH4rZN/vbHj2hy+Cfxj/uV9nTAq4
         Mza8DFWsSYqZGhhUX3auazL0O7U/4hHt8CVz50777G1oAq/2vL2RKWsxYwCL/zk8pmyo
         2KwQZLnysk5TFgrmsG9Vrb2EHK/c7NcZW7wUgXTGL36dRELcxvqDIrdJEUZn0MitZLYI
         5+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f+2ogpMvHZnSzrnFVs7Ch8Tz92FDuT6A3oGtG/Qchk0=;
        b=GwKiTFfeKBPqFFat5HtVwN7cX4X1ntAs8S/fxv/90uEIdKimeq9tB3aadp+V2F+uY8
         aUOtWrUoo6BWW4clJ4+Qak8tH95lSnXDP1QqVYY6cKOJDSCiELDjdNLDxC9OaoUfByQQ
         j7OsVYYIlhxvRMK089NySZfSb9mEtk5Av7EgZZwZDs4yVRHEWIpuffaFr/AnGiPzP4ua
         MyMt2W7++qXyUz+Aic6o56vJ4cEjuN/IiFcj8Nwcg7iUYHr7QRmwXF7NB82XFzW1XhgF
         JaKmi0V/8tlLb3zjV4KEJvHzympIum6rAj/hhNgJOWtlMPz6S3XF/JC5smzuNVbDA/Je
         8PuQ==
X-Gm-Message-State: ALKqPweV2pQ40R1+OWbQ9ljSaxsswS76OzcDbiz+CbWmbIbuDJmT5zee
        8IObuFMq3y5l99lhcuSFYh273GfYhCeF4mZxjKtZEQ==
X-Google-Smtp-Source: ADUXVKKk4jhAAGe8B6gGI45Uv8l8m+ngMEiPHqsAO0bOPz7GEKJWyWOvRx0E/a+rME0kgUvrwI33h5Mf+4h84Br3pkI=
X-Received: by 2002:a25:dfca:: with SMTP id w193-v6mr2236768ybg.334.1527706714875;
 Wed, 30 May 2018 11:58:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 11:58:34 -0700 (PDT)
In-Reply-To: <20180530080325.37520-4-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-4-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 11:58:34 -0700
Message-ID: <CAGZ79kZSjwsk-YE1G3sGX-sfdu17NjMo-Jbrw2E5AbpbNGSGyg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] format-patch: extend --range-diff to accept
 revision range
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 1:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> When submitting a revised a patch series, the --range-diff option embeds
> a range-diff in the cover letter showing changes since the previous
> version of the patch series. The argument to --range-diff is a simple
> revision naming the tip of the previous series, which works fine if the
> previous and current versions of the patch series share a common base.
>
> However, it fails if the revision ranges of the old and new versions of
> the series are disjoint. To address this shortcoming, extend
> --range-diff to also accept an explicit revision range for the previous
> series. For example:
>
>     git format-patch --cover-letter --range-diff=v1~3..v1 -3 v2
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-format-patch.txt |  8 +++++---
>  builtin/log.c                      | 16 +++++++++++++---
>  t/t7910-branch-diff.sh             |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index f4c70e6b64..25026ae26e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -233,10 +233,12 @@ feeding the result to `git send-email`.
>         As a reviewer aid, insert a range-diff (see linkgit:git-branch-diff[1])
>         into the cover letter showing the differences between the previous
>         version of the patch series and the series currently being formatted.
> -       `previous` is a single revision naming the tip of the previous
> -       series which shares a common base with the series being formatted (for
> +       `previous` can be a single revision naming the tip of the previous
> +       series if it shares a common base with the series being formatted (for
>         example `git format-patch --cover-letter --range-diff=feature/v1 -3
> -       feature/v2`).
> +       feature/v2`), or a revision range if the two versions of the series are
> +       disjoint (for example `git format-patch --cover-letter
> +       --range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
>
>  --notes[=<ref>]::
>         Append the notes (see linkgit:git-notes[1]) for the commit
> diff --git a/builtin/log.c b/builtin/log.c
> index 460c31a293..e38cf06050 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -995,10 +995,20 @@ static char *find_branch_name(struct rev_info *rev)
>
>  static void infer_diff_ranges(struct argv_array *args,
>                               const char *prev,
> +                             struct commit *origin,
>                               struct commit *head)
>  {
> -       argv_array_pushf(args, "%s...%s", prev,
> -                        oid_to_hex(&head->object.oid));
> +       if (strstr(prev, "..")) {
> +               if (!origin)
> +                       die(_("failed to infer range-diff ranges"));


>  static int get_range_diff(struct strbuf *sb,
> @@ -1059,7 +1069,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>         /* might die from bad user input so try before creating cover letter */
>         if (range_diff) {
>                 struct argv_array ranges = ARGV_ARRAY_INIT;
> -               infer_diff_ranges(&ranges, range_diff, head);
> +               infer_diff_ranges(&ranges, range_diff, origin, head);

This is way before the check for 'if (origin) emit_diffstat' as done in
patch 1, as we want to do this early. We need to check the non-NULLness
in infer_diff_ranges as it is allowed to be NULL when the range-diff doesn't
contain "..", which means we assume the same branch point.

Would it make sense to give a better error message in:

> +               if (!origin)
> +                       die(_("failed to infer range-diff ranges"));

above? (The failure sounds like it could be anything, but the
reason for it is actually well understood: The origin was
computed and as the boundary commit of the given range,
or NULL if there is no boundary commit or multiple commits.

If we find not exactly one boundary, we cannot compute the
range to give to the range-diff tool.

Stepping back a bit:

  Consider the following DAG:

        O -
           \
    A - B - C - D

a series from B..D (or '-2' when D is HEAD) would fail
to generate both diffstat as well as the range diff as the
merge of O produces a second boundary, (but wouldn't
the creation of the patch C fail eventually anyway?)

Another DAG:

    A - B - C - D
         \    /
           E

when asking for B..D the diffstat and range diff would
compute ok, but the patch C would fail to generate again?

Stepping back to the error message, I have no good
suggestion on what to say there. Maybe we'd want to
refactor the code in cmd_format_patch, that computes the
origin:

        if (prepare_revision_walk(&rev))
                die(_("revision walk setup failed"));
        rev.boundary = 1;
        while ((commit = get_revision(&rev)) != NULL) {
                if (commit->object.flags & BOUNDARY) {
                        boundary_count++;
                        origin = (boundary_count == 1) ? commit : NULL;
                        continue;
                }

                if (ignore_if_in_upstream && has_commit_patch_id(commit, &ids))
                        continue;

                nr++;
                REALLOC_ARRAY(list, nr);
                list[nr - 1] = commit;
        }

We could prefix that with

    need_origin = (range_diff && strstr(prev, "..")  || emit_diff_stat;

and then if need_origin is about to be unset again we could issue
a warning and die early after the loop warning about bad DAG form?

I guess that can wait for a follow up patch.

Thanks,
Stefan
