Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9835B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 14:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfKEOUm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 09:20:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbfKEOUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 09:20:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id q13so21588886wrs.12
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 06:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d9szdUQ9/3Vmi5e5smEh5aN6lgyIw3wy0lou6PPA8RM=;
        b=rXA9MEHtlTDGkMBXbSPHgkdgVS6xchKVQaxQNgp646KpaNxXRKYOnFwgDoJLt/eVUD
         9g0KYdaPDyOPpaun1zesDdL7tpUQ0hVaVuSVtJc/qysTkqyPInGZZ7uYq/93N3+bAy1v
         GU+78qgBerpFlIMLG7NWSNR4w19ZDsEJPnlJK2qwx8GaC26c/O+MFuj5I2R4rJiYc4GP
         5dIjeQ7gTZB9NEwP016YW+PikW7xtKUXXHBU0fdLCF16bWDCBfMQQlx4vCoZLJGdDr6n
         Ze/p/mTAH+3uwv/+Jy8tHwPDLvwHaYxMxwURT4mDtRxrhSFGWbJWxpgi+4y6U8tfynI2
         OCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d9szdUQ9/3Vmi5e5smEh5aN6lgyIw3wy0lou6PPA8RM=;
        b=V8qGtMcXgUYPM3tNR/gn9fc8B+oLgT+mO+2powElclNDPdDcFZyQIN9OZb7Rhcfwud
         LpI9DeWLcDbUrPnZ4gNSu1tbo/nqb0vpokx27X1SkueBLjAHMFJNKzzp898QLvL7wtSb
         E5Zmo0wyenTSTb0n7qkTY4d898fqp9HcApTioAvxuUC85Mi+04MkOSJCPB/zsKPu+/Wz
         BAg1LKksRhbqpFejUVl8FufUa43dypPvbIHjnC5/d1KubOSUDRyshlytd72thAPRLn9g
         P7kxdpU/mwwraJpSEJ7U3mrde/kbXjQ/lzPlVmwwxE60fwmS7v8T9CcnXTLenzUigtvh
         Ratw==
X-Gm-Message-State: APjAAAWxlTSUViHiKGqHHsS6hUPMLGi7Rpt3ibroNLPIcOonycwefisz
        ryJGDCQNxWKhct4QdGxb+xo=
X-Google-Smtp-Source: APXvYqyu2rKAF/I3gXKuGRlTfavTR1NWveTtiJ1VRdBnabDRppGPA7FQUhjDFJUhIQqWZkgzVpu+FA==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr28610855wru.142.1572963639582;
        Tue, 05 Nov 2019 06:20:39 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-224.as13285.net. [92.22.7.224])
        by smtp.gmail.com with ESMTPSA id u187sm20592261wme.15.2019.11.05.06.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 06:20:38 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 2/2] rebase-interactive: warn if commit is dropped
 with --edit-todo
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191104095449.9964-3-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7ca0f5c7-9c6c-34fe-215a-c57946f18f2c@gmail.com>
Date:   Tue, 5 Nov 2019 14:20:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191104095449.9964-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

Thanks for working on this. I've got a couple of specific comments 
below. On a more general level I'd be tempted to squash the two patches 
together rather than adding the tests as a separate commit. Also I think 
before we discussed having `rebase --continue` refuse to continue if 
`rebase --edit-todo` had dropped commits when rebase.missingCommitsCheck 
was set to error. I think that would be useful but could always come 
later. --edit-todo could write a file to .git/rebase-merge to prevent 
--continue from continuing in case of errors.

On 04/11/2019 09:54, Alban Gruin wrote:
> This adds the ability for --edit-todo to check if commits were dropped
> by the user.  As both edit_todo_list() and complete_action() parse the
> todo list and check for dropped commits, the code doing so in the latter
> is removed to reduce duplication.
> 
> Tests added previously should work now.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   rebase-interactive.c          | 7 +++----
>   sequencer.c                   | 5 +----
>   t/t3404-rebase-interactive.sh | 4 ++--
>   3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index aa18ae82b7..1b8d7f25bf 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -115,10 +115,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>   	if (initial && new_todo->buf.len == 0)
>   		return -3;
>   
> -	/* For the initial edit, the todo list gets parsed in
> -	 * complete_action(). */
> -	if (!initial)
> -		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
> +	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo) ||
> +	    todo_list_check(todo_list, new_todo))
> +		return -4;
>   
>   	return 0;
>   }
> diff --git a/sequencer.c b/sequencer.c
> index 9d5964fd81..92f2e6f6a0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5062,10 +5062,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		todo_list_release(&new_todo);
>   
>   		return error(_("nothing to do"));
> -	}
> -
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
> -	    todo_list_check(todo_list, &new_todo)) {
> +	} else if (res == -4) {
>   		fprintf(stderr, _(edit_todo_list_advice));

Do we want to print this advice when `rebase --edit-todo` detects 
dropped commits as well? I'm not clear what error messages are printed 
it that case. If we always want this printed then it could be moved into 
edit_todo_list()

Thanks again for working on this, it's a really useful addition to rebase

Best Wishes

Phillip

>   		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
>   		todo_list_release(&new_todo);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index be8badf7b3..040ec616f3 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1366,7 +1366,7 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ig
>   		actual
>   '
>   
> -test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
>   	cat >expect <<-EOF &&
>   	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
>   	Warning: some commits may have been dropped accidentally.
> @@ -1395,7 +1395,7 @@ test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
>   		actual
>   '
>   
> -test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
>   	cat >expect <<-EOF &&
>   	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
>   	Warning: some commits may have been dropped accidentally.
> 
