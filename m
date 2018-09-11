Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D201F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeILA2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:28:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39050 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeILA2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:28:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so2168890wmq.4
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1RqGSHiMo/dbWlQwRAZJy1BRq5chouQDbFalDwu9T2o=;
        b=IQGf1qVjlBU5qNimn2rNN8ar389eUMWd8sewcotYUAUi9ffsiP8Jo63tqJUKutKn7X
         CdcLbwBQJ9tI3gVJdZMEPe8wS2gCZzsthaSsHuYeFEey9vG7hcQBMuDb/tux4SBRT+rQ
         XlojPeN5QaGpLPCDD/SjdwguhaMluv62wxTsUtWopjcdOpAMEzIr0kghfGbKhYGDjj0/
         M8DdQDkBN7bGOk28KdqeN94bAG6ufW26q7MQUpQc/X0NrI/aFtjriYKCNxeFydi0JdRQ
         Ido4pN3+iTqQC693Ywdlm/JdtYljkc9nHjBUh+3PqqvrdqpqIcB/YEJWnofriGpciTLY
         hYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1RqGSHiMo/dbWlQwRAZJy1BRq5chouQDbFalDwu9T2o=;
        b=f3v18Wmz6Z5ptWcS7PBr7Y+O4UZRqrmqg3oV3B1NNbwtouNZjJyfYIhaccPwbvTP8m
         Vbj7WllEMFzC930QJOofRhdO8O6u1Cv/jPiGshx76YZs7O0uWAjlV3PHwbEL61URDEld
         Ux0/xzg1cW9XyQq2Yw3jEyiDr75qLsAYrDbzlUS0frPsH7XjRtT1JZcv8V4EN4dbxYZN
         XCVXDyotfRowxO3G/+wbNUa8maoyeYEF9PDfPCPXOm+s+9jG2dte4/ZwO6l8YeO6wVvL
         /V4Hyw7pyK7+IZJHg1uM3VTEW+odVe5Oc6K7+R7X7VSslBrUlZNslLSd9HVlEEAB5xzo
         l03Q==
X-Gm-Message-State: APzg51DV9JaS9M3A7cq8BClmb13i52ykjSdvnnekLpPt32n3MncPTc5H
        pqiblWYToo7IZdjFzlrkISQ=
X-Google-Smtp-Source: ANB0VdYQawXGZNGGpqVWAixF5/Vd2TWuIVcTy3PKkkJrqHezBLZA3DM9EDQmfSOMDKZVFMxrXn0SOQ==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr2444845wmc.24.1536694042079;
        Tue, 11 Sep 2018 12:27:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u7-v6sm2612323wmd.46.2018.09.11.12.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:27:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] string-list: remove unused function print_string_list
References: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
        <20180911184850.24891-1-sbeller@google.com>
Date:   Tue, 11 Sep 2018 12:27:21 -0700
In-Reply-To: <20180911184850.24891-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 11:48:50 -0700")
Message-ID: <xmqq1s9zq1gm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The helper function stayed unused for 3 years. A removal of that function

I think it stayed unused for more than that before the previous
proposal to remove it was written (I do not bother going back to my
earlier message that identified which exact commit this was
introduced at).  It has stayed that way for 3 more years since then.

> was proposed before[1], but now time has proven we really do not need the
> function.
>
> [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
> Signed-off-by: Stefan Beller <sbeller@google.com>

I'll add a blank line before the sign-off.  Is this an example that
our "where is the existing trailer?" code misbehaving?

> ---
>  string-list.c | 10 ----------
>  string-list.h |  8 --------
>  2 files changed, 18 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index 771c4550980..1f6063f2a27 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -195,16 +195,6 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  	list->nr = list->alloc = 0;
>  }
>  
> -
> -void print_string_list(const struct string_list *p, const char *text)
> -{
> -	int i;
> -	if ( text )
> -		printf("%s\n", text);
> -	for (i = 0; i < p->nr; i++)
> -		printf("%s:%p\n", p->items[i].string, p->items[i].util);
> -}
> -
>  struct string_list_item *string_list_append_nodup(struct string_list *list,
>  						  char *string)
>  {
> diff --git a/string-list.h b/string-list.h
> index ff8f6094a33..18c718c12ce 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -113,14 +113,6 @@ typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
>  void filter_string_list(struct string_list *list, int free_util,
>  			string_list_each_func_t want, void *cb_data);
>  
> -/**
> - * Dump a string_list to stdout, useful mainly for debugging
> - * purposes. It can take an optional header argument and it writes out
> - * the string-pointer pairs of the string_list, each one in its own
> - * line.
> - */
> -void print_string_list(const struct string_list *p, const char *text);
> -
>  /**
>   * Free a string_list. The `string` pointer of the items will be freed
>   * in case the `strdup_strings` member of the string_list is set. The
