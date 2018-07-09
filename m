Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141641F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGIVhF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:37:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39974 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933294AbeGIVhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:37:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so22194054wma.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ge1r4eTW4QZL/nmnfUIisEXlYZrXM+c4+D4r1jvy7ZQ=;
        b=NkkxMxUU2HVz0FEWl5MUR7VFNSkky0wSy2T3Rykr9mNe/fjpZ6R98k1TBX16FNKHt1
         4GK4Mo5q5TpU5kiA0XVfwxUFVGX7ieYOP9YO8gVOKeSCb470ukIf87Z3iLXnTNd7yndf
         o2EHoqReTSIgm1orEvY/vJdHTxw7GTKIJglR1wCslBZTYY5pWHrz607VMWOdHSX/ZzyN
         OiJvbmSrBmXzZblsNoageOtUYK8EuPHLm9GmPU9WBkJQaM8j3P1xURs0ZCC8h9celZVX
         98rduWG4NL2O/G6s3NnycvN0coG9iyEpDhvEBfMTjEUUMJ4URD+i9k5oj+P9+eW6PRUp
         OOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ge1r4eTW4QZL/nmnfUIisEXlYZrXM+c4+D4r1jvy7ZQ=;
        b=NvpwVrYaSujx7QNFfYCB9YCbKLywiDYr+mlcfL4ggrZcjiad+6y1snjA5j08ea4O7p
         rC9Q75hh7Fvq3wSr0z5WvxRG20zlJgSsuPN9werWgUk1mus1LHSnNR8zZ2fDXHBQO5EU
         oGt3Jw/SxcWUdV0fd1kCEopH9AqmLewCk/A9abQsL3rx4MbAI02kP7aGHcrUeiBbeQaY
         pYhDeSbibUtCZFtTT6pc5zgOUy1dCczwLIfJVhEW38+/Q+cf/t98ogvIuKS5VEjuWYkf
         vmdlDApB6CKA1BCx7Kko6FzHzKh6YAYNkXJddmMKufpTxiwMA0s17TErMwwCVrZ0y/bB
         9vIA==
X-Gm-Message-State: APt69E1DXFursjuBdJs5dBAP1cFsarvDwANCUgON082CKc+J5DcIvvB/
        fkCu+Ze0qzPeKsD7fUY7gx8=
X-Google-Smtp-Source: AAOMgpcF7Mvmh7HKh23uAfI/bXNQdpAM/5ZQTPtmVIJAX9mtjzdJMScd3fHp/2LD6L8F6zADaCK67Q==
X-Received: by 2002:a1c:c40a:: with SMTP id u10-v6mr12467484wmf.10.1531172222051;
        Mon, 09 Jul 2018 14:37:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l6-v6sm12446726wmh.41.2018.07.09.14.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:37:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] sequencer.c: avoid empty statements at top level
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180709192537.18564-5-dev+git@drbeat.li>
Date:   Mon, 09 Jul 2018 14:37:00 -0700
In-Reply-To: <20180709192537.18564-5-dev+git@drbeat.li> (Beat Bolli's message
        of "Mon, 9 Jul 2018 21:25:35 +0200")
Message-ID: <xmqqk1q4ay6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> The macro GIT_PATH_FUNC expands to a function definition that ends with
> a closing brace. Remove two extra semicolons.

Good.  Thanks.

>
> While at it, fix the example in path.h.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  path.h      | 2 +-
>  sequencer.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/path.h b/path.h
> index 1ccd0373c9..fc9d3487a0 100644
> --- a/path.h
> +++ b/path.h
> @@ -147,7 +147,7 @@ extern void report_linked_checkout_garbage(void);
>  /*
>   * You can define a static memoized git path like:
>   *
> - *    static GIT_PATH_FUNC(git_path_foo, "FOO");
> + *    static GIT_PATH_FUNC(git_path_foo, "FOO")
>   *
>   * or use one of the global ones below.
>   */
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..66e7073995 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -62,12 +62,12 @@ static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
>   * The file to keep track of how many commands were already processed (e.g.
>   * for the prompt).
>   */
> -static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
> +static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum")
>  /*
>   * The file to keep track of how many commands are to be processed in total
>   * (e.g. for the prompt).
>   */
> -static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
> +static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end")
>  /*
>   * The commit message that is planned to be used for any changes that
>   * need to be committed following a user interaction.
