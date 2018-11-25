Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A403D1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeKZIgB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 03:36:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKZIgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 03:36:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so16446383wmh.1
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fg339UYfD+XLlGbYEzX1udQ8WwvL5qiu0TrQwmvBBdE=;
        b=KJvsV6udHvTwq08ewrG9QZ7Bjq3nAxETvZMxDNGcrclL6fTOlG+Q2tFz8oF1XJ+b2/
         QlYGNHz9eJKr9Dx6nE814osb0DROi3kt1T8B3MTbuFJFqR5SGcmjL6KIV9u9L+PrtKyT
         X3py7XJGK+2XLeUPnz9st/TL2RKTCi8t05lTgPffeoauOKF7OcL8AQ9V9wQCzGSYOvwI
         SIQjsvUtYCIXDyHUDuU7ZxrgiITuZnmJDBxvqDazfOs/TXjyL6UOhYIAphCclJVk1jjh
         MmzgBOq3jhxmHLlzntnMnA1iWeFX+gsJVA5YT3mdhfR8Znph5Qi4W9ie2jz4cflCVKbz
         tpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fg339UYfD+XLlGbYEzX1udQ8WwvL5qiu0TrQwmvBBdE=;
        b=k8WJZajjxM0iEnKalJMMWucJspd3dDGh0JUxr7ruE4HdIcsf724KaI/X2uv0sUDFUH
         8w85BAvQlJFY3BPSJI7P87kHSxFvDHYw+rcZtJxqyoe9Ju2kh/tatnVFFpOas09vUiiZ
         N9XXD8subR2YD7I1Jy/ipJI/vYWQdEety4P7i5wC5katCxhs6At9ELWwd1m3PUTynU0w
         FNAtdgmsyzreedp+PQMLuuJRQ28dCUkHANM1ldSqSfpCNcHE3OJHEOp7VRO38Koq5eaG
         GMI9WK2Zwe7p0pAMWA+9wWfKQ63m2nbj7XGe2lAFC7it+NtoCm4KZOp00TyQiiMuSNJh
         OM1w==
X-Gm-Message-State: AA+aEWYzaQ165Ogsj5ZIFxudg6H9zsjyZ8v6q3jMOIrQldSPV58QEbgy
        O5ISmONDWIWlIbERd8qjWIGft7Jx
X-Google-Smtp-Source: AFSGD/VY8//K4nbjs0exXj75sndJCqJZLPmIytqn+HOu35jp6JOOCP8tCZBJ8lJ0WOcnVmCeXQVfZw==
X-Received: by 2002:a1c:bb85:: with SMTP id l127mr20904408wmf.98.1543182235810;
        Sun, 25 Nov 2018 13:43:55 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id i9sm28667574wrs.34.2018.11.25.13.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:43:54 -0800 (PST)
Date:   Sun, 25 Nov 2018 21:43:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v11 03/22] strbuf.c: add `strbuf_insertf()` and
 `strbuf_vinsertf()`
Message-ID: <20181125214353.GI4883@hank.intra.tgummerer.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
 <e8d86fae660a79eabcf4764dfa9986282c097242.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d86fae660a79eabcf4764dfa9986282c097242.1542925164.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23, Paul-Sebastian Ungureanu wrote:
> Implement `strbuf_insertf()` and `strbuf_vinsertf()` to
> insert data using a printf format string.
> 
> Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  strbuf.c | 36 ++++++++++++++++++++++++++++++++++++
>  strbuf.h |  9 +++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 82e90f1dfe..bfbbdadbf3 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -249,6 +249,42 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
>  	strbuf_splice(sb, pos, 0, data, len);
>  }
>  
> +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
> +{
> +	int len, len2;
> +	char save;
> +	va_list cp;
> +
> +	if (pos > sb->len)
> +		die("`pos' is too far after the end of the buffer");

I was going to ask about translation of this and other messages in
'die()' calls, but I see other messages in strbuf.c are not marked for
translation either.  It may make sense to mark them all for
translation at some point in the future, but having them all
untranslated for now makes sense.

In the long run it may even be better to return an error here rather
than 'die()'ing, but again this is consistent with the rest of the
API, so this wouldn't be a good time to take that on.

> +	va_copy(cp, ap);
> +	len = vsnprintf(sb->buf + sb->len, 0, fmt, cp);

Here we're just getting the length of what we're trying to format
(excluding the final NUL).  As the second argument is 0, we do not
modify the strbuf at this point...

> +	va_end(cp);
> +	if (len < 0)
> +		BUG("your vsnprintf is broken (returned %d)", len);
> +	if (!len)
> +		return; /* nothing to do */
> +	if (unsigned_add_overflows(sb->len, len))
> +		die("you want to use way too much memory");
> +	strbuf_grow(sb, len);

... and then we grow the strbuf by the length we previously, which
excludes the NUL character, plus one extra character, so even if pos
== len we are sure to have enough space in the strbuf ...

> +	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
> +	/* vsnprintf() will append a NUL, overwriting one of our characters */
> +	save = sb->buf[pos + len];
> +	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);

... and we use vsnprintf to write the formatted string to the
beginning of the buffer.  sb->alloc - sb->len can be larger than
'len', which is fine as vsnprintf doesn't write anything after the NUL
character.  And as 'strbuf_grow' adds len + 1 bytes to the strbuf
we'll always have enough space for adding the formatted string ...

> +	sb->buf[pos + len] = save;
> +	if (len2 != len)
> +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> +	strbuf_setlen(sb, sb->len + len);

And finally we set the strbuf to the new length.  So all this is just
a very roundabout way to say that this function does the right thing
according to my reading (and tests).

> +}
> +
> +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...)
> +{
> +	va_list ap;
> +	va_start(ap, fmt);
> +	strbuf_vinsertf(sb, pos, fmt, ap);
> +	va_end(ap);
> +}
> +
>  void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
>  {
>  	strbuf_splice(sb, pos, len, "", 0);
> diff --git a/strbuf.h b/strbuf.h
> index be02150df3..8f8fe01e68 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -244,6 +244,15 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t n);
>   */
>  void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
>  
> +/**
> + * Insert data to the given position of the buffer giving a printf format
> + * string. The contents will be shifted, not overwritten.
> + */
> +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
> +		     va_list ap);
> +
> +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
> +
>  /**
>   * Remove given amount of data from a given position of the buffer.
>   */
> -- 
> 2.19.1.878.g0482332a22
> 
