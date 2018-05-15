Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB0A1F42D
	for <e@80x24.org>; Tue, 15 May 2018 09:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeEOJh7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 05:37:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40358 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOJh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 05:37:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so20271846wme.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YJnaFFYiX/3GfZiALUmf2D10Q39OH46Skmol+XIlnsg=;
        b=RKMhdxzpIM3IpXKnRnnDzya5I1QHmEBq1ovht/D4ao/AO8Ud0ru9e+8re3tq8iV55N
         dK5eISWdlNQyPM3wT9wrGFWth+731HeqodfafsIarBsWimne7qVzPXrny5VQj3U4Jrze
         2H1D7a/wOPF2G69QwXg/uMP+PfHXEbnnfMn9Axg2w2skYFnZQQ1QwzgMeYDPbNeLL+hJ
         cg1k4B2q4jCtn/UvL8F//tXPhCf++FZ2oi+D6FBbNhx5i5ssS0QttZlDrv1KVlx54vdG
         Te5HcghkhVQMh9MXBUDY61L/8RCf4fn7KP0gCvmqwZ674lFRY0IcRiBxkAyT+iZjKkJ4
         ntQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YJnaFFYiX/3GfZiALUmf2D10Q39OH46Skmol+XIlnsg=;
        b=Ii6pyulmtvMk+l7qKA7fIa+8r/rZp68c9uHBd1pg1SQzALdk9rqrceIyvwUq3qhnXT
         Vj4bQ3+T4IjVOLdrxn9Li3bNAu11XuEbEvW+MjBl0cfxKoolYB5krwPq18s7mC2Q1u5n
         Vwbq5x+M3nRX7hPjryef2olZ10S7026hRDGT6e5bf7XyKfsSPnTJP3X+ZpInfZIDhvdB
         mk3em9gMFquxD+8PHtXfRnn2XJdO4UAPa6xsTdcA/RMnO/hnrccSKUfJn18k4EYHPC1B
         KI9a252LCV/scB17PYDrhT1F2SSh6V/SYn0ZcmxiQVouPFU0TweHdPNdYP0c7oA0gKsd
         anjw==
X-Gm-Message-State: ALKqPwfwpUK4aGP+0BxV104JBYGynTn5KZv6EBQxhXHxAkeP7xwYqllz
        kxxG7FEZ5DZHEqI87nzEA4PFQTS9
X-Google-Smtp-Source: AB8JxZpDCfaoFvBOGeRRJDFbhf3g1RKH2iE26slkR2W1zqy+vhkJULI+XIzdwrPFiOYFCN2tSwL24w==
X-Received: by 2002:a1c:7a0b:: with SMTP id v11-v6mr7647299wmc.58.1526377076685;
        Tue, 15 May 2018 02:37:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x65-v6sm18634314wme.31.2018.05.15.02.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 02:37:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/35] refspec: introduce struct refspec
References: <20180514215626.164960-1-bmwill@google.com>
        <20180514215626.164960-5-bmwill@google.com>
Date:   Tue, 15 May 2018 18:37:55 +0900
In-Reply-To: <20180514215626.164960-5-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 May 2018 14:55:55 -0700")
Message-ID: <xmqqefid8djg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/refspec.h b/refspec.h
> index 173cea882..f6fb251f3 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -20,4 +20,29 @@ struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
>  
>  void free_refspec(int nr_refspec, struct refspec_item *refspec);
>  
> +#define REFSPEC_FETCH 1
> +#define REFSPEC_PUSH 0

The reversed order of these two definitions looks somewhat unusual.
I guess the reason why you made FETCH true and PUSH false is
probably because quite a lot of places in the existing code we do

	if (fetch)
		do the fetch thing;
 	else
		do the push thing;

i.e. "fetch" variable is used as "is this a fetch: yes/no?"
boolean, and a caller that mysteriously passes "1" (or "0")
is harder to read than necessary.  Being able to pass REFSPEC_PUSH
instead of "0" would certainly make the caller easier to read.  But
as long as the variable is understood as "is_fetch? Yes/no", the
caller can pass Yes or No and be still descriptive enough.

I think the way to make such a code more readable would not be to
rewrite the above to

	if (fetch_or_push)
		do the fetch thing;
 	else
		do the push thing;

Rather it would be 

	if (fetch_or_push == REFSPEC_FETCH)
		do the fetch thing;
 	else
		do the push thing;

And once you have gone that far, the actual "enum" value assignment
no longer makes difference.

> +#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
> +#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
> +
> +struct refspec {
> +	struct refspec_item *items;
> +	int alloc;
> +	int nr;
> +
> +	const char **raw;
> +	int raw_alloc;
> +	int raw_nr;
> +
> +	int fetch;
> +};
> +
> +void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
> +void refspec_item_clear(struct refspec_item *item);
> +void refspec_init(struct refspec *rs, int fetch);
> +void refspec_append(struct refspec *rs, const char *refspec);
> +void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
> +void refspec_clear(struct refspec *rs);
> +
>  #endif /* REFSPEC_H */
