Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB5F1F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDHJ15 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:27:57 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42798 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeDHJ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:27:56 -0400
Received: by mail-qk0-f195.google.com with SMTP id b198so6084217qkg.9
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kVn9fXM+J8TaZkNoJwOhQsThzGSPtnC0aaax5zSI+w4=;
        b=ETahocKoJKqUROUEH0Zpw1yn2Rzu7SII46FkBOh17khLWKZfMbuR3jyiyV6td1Fr2X
         yQCP6DscMxFGWyzHDdfzeP2zjjMVynK3J6I7g1Y+9gZ6HMmF3UKV9xzgXNsA6xaafG6v
         iXyw7MfJRQ8su/vrduvioYBKpzHFvkr8WYRP1YNGFGWsNdmFjajd9yNum0Dc38/AeE1x
         u/2Xi+Rclju5OScgYaQt+1jwhof3VdrkFjjRSLdgBbCMuC0a/4GFxWYDsv50WjJCmepU
         Kt4NuaqRSik8HZ1j5/yZJ3cJTLpwA/1kVfcoCFIrDnjCZOtf3pdVlCjXM8f588d8BTky
         lo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kVn9fXM+J8TaZkNoJwOhQsThzGSPtnC0aaax5zSI+w4=;
        b=jpbGDZ9J8ct4AOlvSYdazY1Dx7bvYOUne48ZS2Ox22Frgx35oFyGNJUOYMYb5nlevB
         JX4qDuk+KrW5swpZO++w86kbOvul1t9SSg8YId27bnil+YdeXsdoSLzMcXi5dX4pTKQy
         ivbtnYIteK9iRE6y9Sj6NZw+9vUU4QxZ0r5T8Cjg3Ej/TYQPuAhqSn2Zf9fu6+DL7q6J
         cqdanucjWzcz9RCXxr4BRoeKw/4zg2K7oJPwQaO/NkdiN+WYMX8YLRVAtneAMw6BVsMs
         TDOip99dKkfJ3OFMM7TctT9Tt5GX8IrqDsmN7rakEADqv6G+UZbNix4ly1wgFuf9c1ZN
         uwLw==
X-Gm-Message-State: ALQs6tAN5YPh5EwL+qsMlZvXjQ/n5g4M0tFGNB5nI6m1Z3apBsyE9SCH
        sKkNb5KXJ+JSsfl1REiM1WoKA4EJpmH6m+apleA=
X-Google-Smtp-Source: AIpwx48MXfZkvYCE4alVMuGIM/YEVQrDleiFxnf9cHes0fOTYy+ViMOwMCU2j6PSC3J09EDlWQI+MqACPU1mBY9Zxvk=
X-Received: by 10.55.156.79 with SMTP id f76mr43596742qke.36.1523179675559;
 Sun, 08 Apr 2018 02:27:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 02:27:55 -0700 (PDT)
In-Reply-To: <20180331151804.30380-4-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-4-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 05:27:55 -0400
X-Google-Sender-Auth: 6d69xM7osU_vRFSMGqjMrMDgG7Q
Message-ID: <CAPig+cQmEHx1N1Q9in6K8n3AyUMCk1V7JyAoeXrQVNQDQdxZ0w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 11:18 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> Fix these inconsistencies, and no longer show the identifier by making
> the 'git reset --hard' call not print the "HEAD is now at ..." line
> using the newly introduced flag from the previous commit, and printing
> the message directly from the builtin command instead.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -322,12 +320,22 @@ static int add_worktree(const char *path, const char *refname,
>                 argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               argv_array_push(&cp.args, "--no-show-new-head-line");
>                 cp.env = child_env.argv;
>                 ret = run_command(&cp);
>                 if (ret)
>                         goto done;
>         }
>
> +       fprintf(stderr, _("New worktree HEAD is now at %s"),
> +               find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> +
> +       strbuf_reset(&sb);
> +       pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> +       if (sb.len > 0)
> +               fprintf(stderr, " %s", sb.buf);
> +       fputc('\n', stderr);
> +
>         is_junk = 0;
>         FREE_AND_NULL(junk_work_tree);
>         FREE_AND_NULL(junk_git_dir);

Generally speaking, code such as this probably ought to be inserted
outside of the is_junk={1,0} context in order to keep that critical
section as small as possible. However, as mentioned in my response to
the v6 cover letter[1], I think this chunk of new code can just go
away entirely if git-reset is made to print the customized message on
git-worktree's behalf.

[1]: https://public-inbox.org/git/CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com/
