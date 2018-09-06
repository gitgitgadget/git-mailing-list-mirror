Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF871F404
	for <e@80x24.org>; Thu,  6 Sep 2018 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIFV2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 17:28:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35637 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeIFV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 17:28:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so12042418wmc.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z3630c7j0CfuyNptfDayiFvLT9Q0ibCYeSkTiJhB4Ls=;
        b=igSuzX/IC4m3pGmI/F3Y0PNfuYIp+ySlcbiP9CUNDBhLe2vwZ2VOvwos2+n41RrqSo
         Qeyr8M6pX6IEZ+uPJ2XBAbzRkr/ATSRahyWNgA9xJIoAvoeaQPw5gUQyT4S+UjPZYzVk
         Sru2m2t7fnNEfTSjqEVINIRygLY+Mc4PuM+40e7GF2xsKXKKV2pXrueEXPUhKs0OszTB
         tFAcii0/nGLjZpxdWeWqblnhSWDEdMzZkOIfLGwkTtrVkkL4sw1VHwBuRL4P1OXzynZe
         RIon2+uuEXSPr4NW+//qkLqQg1NJe6labhuFD/PYkzFgmQCdcgMAJP/tbojpftdil437
         Iv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z3630c7j0CfuyNptfDayiFvLT9Q0ibCYeSkTiJhB4Ls=;
        b=dz4b0MFEL70uVHZuIfYzeahEp6a+bbrqLEsTdj8qCqgawoz44INUPfv1S7USthrg1c
         CGmlVrU4AEKq+axMGOFdnoohqsFHI6Nx37LbfpARxjeb5cIMpQZHet8VFmFqe2Ca/txC
         m3lFGEKQWvcylVo9GJZ+yR+1+bnaJKKyPKt1CD4LssDce7pRXurlU2MN8X3eZnHzdcxG
         GZWmWEAs1SEGacMfyutPgsceVhYCN6M62DwDPtg7Uk/KOpVm4tzfYsJbUeZem9I5JCWg
         OhXSc0t/YpU+ABTqsE0UOJLo0HUSr+kJ5iD39nOqUR3AKvti7SQduYUEPmujsMbg7vGU
         Itzw==
X-Gm-Message-State: APzg51DoV9ol5j17qYAWHD8N8QhVZzrkz8gk9uhjmNmNQnBZm62j86Bu
        1AZ1YPDRFddGgBr/LZO1UV8=
X-Google-Smtp-Source: ANB0VdalCAU+yZqMh9Byg5CDWL1/Px35+ow2cwKN1rzY8+ZI3ijnNnoLRgKSFAiMweLXOk3DMbfCnA==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr2834017wma.120.1536252749880;
        Thu, 06 Sep 2018 09:52:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b2-v6sm3723901wmh.3.2018.09.06.09.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 09:52:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-2-sbeller@google.com>
Date:   Thu, 06 Sep 2018 09:52:28 -0700
In-Reply-To: <20180904230149.180332-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:39 -0700")
Message-ID: <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is a debugging aid, so it should print to the debugging channel.

... and rename it with trace_ prefix.

Use of trace_printf() is nice, as we can control its behavior at
runtime ;-)

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.c | 6 +++---
>  string-list.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index 771c4550980..1ebbe1f56ea 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -196,13 +196,13 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  }
>  
>  
> -void print_string_list(const struct string_list *p, const char *text)
> +void trace_print_string_list(const struct string_list *p, const char *text)
>  {
>  	int i;
>  	if ( text )
> -		printf("%s\n", text);
> +		trace_printf("%s\n", text);
>  	for (i = 0; i < p->nr; i++)
> -		printf("%s:%p\n", p->items[i].string, p->items[i].util);
> +		trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
>  }
>  
>  struct string_list_item *string_list_append_nodup(struct string_list *list,
> diff --git a/string-list.h b/string-list.h
> index ff8f6094a33..5b22560cf19 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -114,12 +114,12 @@ void filter_string_list(struct string_list *list, int free_util,
>  			string_list_each_func_t want, void *cb_data);
>  
>  /**
> - * Dump a string_list to stdout, useful mainly for debugging
> + * Dump a string_list using the trace_print, useful mainly for debugging
>   * purposes. It can take an optional header argument and it writes out
>   * the string-pointer pairs of the string_list, each one in its own
>   * line.
>   */
> -void print_string_list(const struct string_list *p, const char *text);
> +void trace_print_string_list(const struct string_list *p, const char *text);
>  
>  /**
>   * Free a string_list. The `string` pointer of the items will be freed
