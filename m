Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4BD1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967666AbeCSRMO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:12:14 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42484 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966726AbeCSRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:12:10 -0400
Received: by mail-ot0-f195.google.com with SMTP id v23-v6so2885962oth.9
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pOM5cnshK9PXu9YXcW6ZgfT/gBcKpjAprdrG4xOUDYg=;
        b=DI/0qduVsEkYRi4RR5dL6E5TSK7sbG6lZU8rYdRcN3RbT4tC0h8iagzy4BsabynzGX
         VXP6NWMNKVcfu21x80m/8fJN+4NH6cepAoso3BXBJm4MyQZeD111ESqlXyJPGC5/W5lS
         T6KLR2AqT49U+Ooe0xVTIpjvrvpJassB76I5STOB37eDKsDW8x8B9DCWoM/cdq0/6lop
         3vCLvmwlesmVt77d1bctSLfWVx88QOk6zJ7CqwWSjHddznR3vjo45MuFzSm+PkKx/Wlo
         j5xHgVhPBVkkWPJRMEpiLL3Uzk5c2XKwtfpQxPqAjW/Gdv1GyROrVsjk/QuhHXE8RQ2m
         GlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pOM5cnshK9PXu9YXcW6ZgfT/gBcKpjAprdrG4xOUDYg=;
        b=rG0PCMSP1e0AELYQzMNHNUoTU4Gczjdz0Mhugfn/vz8oOswUR5J5zgUnOUYd5X1hYL
         QIrfNYsA26QFAcrFMMvZiJT5sDwV9GMjp+0Ae1wb+qij5F0yr3sNus84SxELhCNOuvzm
         +Q+HOzazFiUYYiIftTZz4+96cTa0vjAJKU3jKPGploPtLy0emIr/tj1rl4TWg+gdh11h
         SYvbT1DJe992M7pwC7epHTy57+QX9pTY3KyRZ6u4I3pr87mHUaQJ/A2jvp2B3/pqLptb
         AVsRbfWR7MZIYYG/UzjHtASGWkYIEvDkYEczP5tDr8s6m1Z35O+FUCV1uHbSZL6I/XGz
         TH4Q==
X-Gm-Message-State: AElRT7HVD1s6UXywj4idxPo6sEYCvLOvit9bOLYzcXBCVZu9mPoGWU9j
        AM3qgxSHzQkDe9OZS3qVGwav6MqBIkwk3z7VZYY=
X-Google-Smtp-Source: AG47ELszDd8tIuRH7gKlFI8W1ZM/C8+g+ZLydf85kLjx25uoxBpX5f7fDAWNrBLT3HNc2CE4AVfCsuMNwyEtpfcC4qM=
X-Received: by 2002:a9d:182a:: with SMTP id b39-v6mr8815153ote.356.1521479530100;
 Mon, 19 Mar 2018 10:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 10:11:39 -0700 (PDT)
In-Reply-To: <20180317222219.4940-2-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-2-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 18:11:39 +0100
Message-ID: <CACsJy8DvUB7Sv6m384ccgDPnMnFfD80W5EZ=Pbkj8cyhFO_OqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 11:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add' produces output like the following, when
> '--no-checkout' is not given:
>
>     Preparing foo (identifier foo)
>     HEAD is now at 26da330922 <title>
>
> where the first line is written to stderr, and the second line coming
> from 'git reset --hard' is written to stdout, even though both lines are
> supposed to tell the user what has happened.  In addition to someone not
> familiar with 'git worktree', this might seem as if the current HEAD was
> modified, not the HEAD in the new working tree.
>
> If the '--no-checkout' flag is given, the output of 'git worktree add'
> is just:
>
>     Preparing foo (identifier foo)
>
> even though the HEAD is set to a commit, which is just not checked out.
>
> The identifier is also not particularly relevant for the user at the
> moment, as it's only used internally to distinguish between different
> worktrees that have the same $(basename <path>).
>
> Fix these inconsistencies, and no longer show the identifier by making
> the 'git reset --hard' call quiet, and printing the message directly
> from the builtin command instead.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/worktree.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..e5d04f0b4b 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -303,8 +303,6 @@ static int add_worktree(const char *path, const char *refname,
>         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>         write_file(sb.buf, "../..");
>
> -       fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
> -
>         argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
>         argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>         cp.git_cmd = 1;
> @@ -320,10 +318,19 @@ static int add_worktree(const char *path, const char *refname,
>         if (ret)
>                 goto done;
>
> +       fprintf(stderr, _("worktree HEAD is now at %s"),

We use the term "working tree" for UI and documents. "worktree" is
only used in code comments and stuff.

> +               find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> +
> +       strbuf_reset(&sb);
> +       pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> +       if (sb.len > 0)
> +               fprintf(stderr, " %s", sb.buf);
> +       fputc('\n', stderr);
> +
>         if (opts->checkout) {
>                 cp.argv = NULL;
>                 argv_array_clear(&cp.args);
> -               argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
>                 cp.env = child_env.argv;
>                 ret = run_command(&cp);
>                 if (ret)
> --
> 2.17.0.rc0.231.g781580f06
>
-- 
Duy
