Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5761F453
	for <e@80x24.org>; Sun, 30 Sep 2018 16:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeI3XW5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 19:22:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33478 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeI3XW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 19:22:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so898320wmd.0
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EF/j0kc2czadvqrK419JZK7lgKm2fIQRTH/IP6UWC4=;
        b=XWh1oTLWlnJeWoTh5wxvjH8Zf17AUwdmMYcUUktJVyGNej4YxVr4UhTlMAaQBNrCGA
         FkRrXvV4A9LxfCtRHgEO96Jn0UsTPYpJCxgd4Wem3s9SLzK5V5u8Uvlq5hZk6RlUIY4u
         hp2rmvyvjc2LANAX1SnVlGEdoGf1Vx/ycvQDfgmgHIB1Zjtoi+fQN4kL4yAwJKI+gS9p
         2ZRO9Hx+0vsjsJrSBNrc+pXrf6IyZesLIwh5M8K0pPPv3hB71ZF9ASKXVPHiMH7cX6M1
         A6HLCzTZKKm9QUWuxW9RzRNe41flqyTlDmVq53VxSGa+5dRNRvZoVAxdFRauTCeAnxgU
         cRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EF/j0kc2czadvqrK419JZK7lgKm2fIQRTH/IP6UWC4=;
        b=WPpGMdisnwWjDc+ugPzMiBRLgTs167Bv9ylg6viQW5tHqpRAjarT/tg2kN5SQZkyhN
         eLOEo3zPpjWqM2tXtqRSkl6Q0ch19mkvauTdmLAMk1/+v3o7ybOCE6AGvC++7dpYEP7U
         t/OrpdkgZZQi2LjRg+Bi0T6DVaqBLiMcDiShtFm6fIDrvndaaw1eWZ9zBmQFh/JyfZXb
         vT41lB0XH4smM6KUfPrLSK9ndddvUHmsclImfobuIhFqeuqZ2dfN/a/h0Cx2cuVG5yIi
         1afGct3dp0elHHtPJ9fCo7pgEQCahVKWhRBaERyQg7wfE0D5sbQSE7gWY+m/0lZoXeYp
         1ytg==
X-Gm-Message-State: ABuFfohtPPA89oj6SmfmFbTEltbm7wM/2CchV2ItGG3BON0T+ejDHr1Q
        6deYig0v9xA97ytqeHCZt5k=
X-Google-Smtp-Source: ACcGV61yDSnxjVDVJlilqP1qGX2LyK9jt5Dp/jXKeXrwL1kUCFt/dWk4RWROpZX6UpBa9k8ZytXhKA==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr6996342wmc.80.1538326150398;
        Sun, 30 Sep 2018 09:49:10 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id l11-v6sm1748842wrn.61.2018.09.30.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 09:49:08 -0700 (PDT)
Date:   Sun, 30 Sep 2018 17:49:07 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 02/21] strbuf.c: add `strbuf_join_argv()`
Message-ID: <20180930164907.GC2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <1fb6d7a72c067fb594b04944dea4a5d223229d69.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb6d7a72c067fb594b04944dea4a5d223229d69.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Paul-Sebastian Ungureanu wrote:
> Implement `strbuf_join_argv()` to join arguments
> into a strbuf.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  strbuf.c | 15 +++++++++++++++
>  strbuf.h |  7 +++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 64041c3c24..3eb431b2b0 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -259,6 +259,21 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
>  	strbuf_setlen(sb, sb->len + sb2->len);
>  }
>  
> +const char *strbuf_join_argv(struct strbuf *buf,
> +			     int argc, const char **argv, char delim)
> +{
> +	if (!argc)
> +		return buf->buf;
> +
> +	strbuf_addstr(buf, *argv);
> +	while (--argc) {
> +		strbuf_addch(buf, delim);
> +		strbuf_addstr(buf, *(++argv));
> +	}
> +
> +	return buf->buf;

Why are we returning buf-buf here?  The strbuf is modified by the
function, so the caller can just use buf->buf directly if they want
to.  Is there something I'm missing?

> +}
> +
>  void strbuf_addchars(struct strbuf *sb, int c, size_t n)
>  {
>  	strbuf_grow(sb, n);
> diff --git a/strbuf.h b/strbuf.h
> index 60a35aef16..7ed859bb8a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -284,6 +284,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
>   */
>  extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
>  
> +

stray newline? We usually only have one blank line between functions.

> +/**
> + *
> + */

Forgot to write some documentation here? :)

> +extern const char *strbuf_join_argv(struct strbuf *buf, int argc,
> +				    const char **argv, char delim);
> +
>  /**
>   * This function can be used to expand a format string containing
>   * placeholders. To that end, it parses the string and calls the specified
> -- 
> 2.19.0.rc0.23.g1fb9f40d88
> 
