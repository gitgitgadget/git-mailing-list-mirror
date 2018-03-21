Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226971F404
	for <e@80x24.org>; Wed, 21 Mar 2018 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeCUUUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 16:20:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34820 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeCUUUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 16:20:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id r82so12229030wme.0
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i2Yb4o4Q7dujQCbSX5LyrXeZeVqYUI6UnhoDQd3i348=;
        b=prr90spalhZkKpF7cYUJXeszn4nSVsmMwT/Ag7jFwDN+UYJuH4lvsa0C5yds7D1Qq8
         nvGtXEccAKU5Pze2rTwia9krcQ7UQ+i3zMwz6q0wXNAydp8GbWxeVc0ocOArQ+fBxmrz
         IDg1qbDeuJfwEg/APNljgudQSOoC2sbhuNueoH6aJrD3xXjXj8jdxInksYnlDycuSSjj
         B0lofJuWKAQqaPSTCIA5Uo1uagp++tj8M0pbIRdslFkpuWQN6Pz8FHyIZVLhNnjScG/9
         Yr4AmycWYq2YnAJt+b6Ej007R/pMM64QtPmYutoxNmzLbkYafFhmDoCn5WjsIJu6GPY3
         ll0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i2Yb4o4Q7dujQCbSX5LyrXeZeVqYUI6UnhoDQd3i348=;
        b=Y6h1cK/aqbyo0ljfeDn3UWrqVBeDcZfA7oXsuNVVF3Q5P9d+Y3Y0yzrIyGWSa4AYFN
         ZnjaCemH8bhipoDKRXCFMDxVQKYvBYz10soKX5c4W2YAUwu4HDAn5eo/ETF/PCyfLcN1
         c17ZXgxJRN/EJFD4APTRDQ+swHAF5pZsf7BBat8zgI1X2jMGwcoL/ExlI6gr1MQQ9wrF
         szirjF8UNiNvMp4Th1poqY+7K6+yp+OxhErNCIj0PDOdlrOopNwKz1T+46sxt/TkSg7F
         RcxN9y/Ji15w7XX+XhHe25wh5crDTDtJBOeTJxGgLg7NbTjcXY7m/2TraOk01gSFIahU
         Z7sw==
X-Gm-Message-State: AElRT7G4bTIlSCpLCBcmlhZ+chX+J6ET8kAV4hjRjTfyUrzvaMdXqynv
        mXFIggZgxuXQ5+I9Zx9y/VA=
X-Google-Smtp-Source: AG47ELtM16mhZv9xwq078a323UX613u499EpklSMTRmTkNcvs/t4PVdFzkqvO1B1eEoBn/7/QEC4aQ==
X-Received: by 10.28.171.131 with SMTP id u125mr3500296wme.19.1521663647678;
        Wed, 21 Mar 2018 13:20:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k17sm4290651wrh.18.2018.03.21.13.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 13:20:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/6] strbuf: add shortcut to work with error messages
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
        <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
Date:   Wed, 21 Mar 2018 13:20:46 -0700
In-Reply-To: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Wed, 21 Mar 2018 18:28:49 +0000")
Message-ID: <xmqqlgelnpsx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Add function strbuf_error() that helps to save few lines of code.
> Function expands fmt with placeholders, append resulting error message
> to strbuf *err, and return error code ret.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  strbuf.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/strbuf.h b/strbuf.h
> index e6cae5f4398c8..fa66d4835f1a7 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -620,4 +620,17 @@ char *xstrvfmt(const char *fmt, va_list ap);
>  __attribute__((format (printf, 1, 2)))
>  char *xstrfmt(const char *fmt, ...);
>  
> +/*
> + * Expand error message, append it to strbuf *err, then return error code ret.
> + * Allow to save few lines of code.
> + */
> +static inline int strbuf_error(struct strbuf *err, int ret, const char *fmt, ...)
> +{

With this function, err does not have to be an error message, and
ret does not have to be negative.  Hence strbuf_error() is a wrong
name for the wrapper.

It somewhat is bothersome to see that this is inlined; if it is
meant for error codepath, it probably shouldn't have to be.

> +	va_list ap;
> +	va_start(ap, fmt);
> +	strbuf_vaddf(err, fmt, ap);
> +	va_end(ap);
> +	return ret;
> +}
> +
>  #endif /* STRBUF_H */

Quite honestly, I am not sure if it is worth to be in strbuf.h; it
feels a bit too specific to the immediate need for these five
patches and nowhere else.  Are there many existing calls to
strbuf_addf() immediately followed by an "return" of an integer,
that can be simplified by using this helper?  I see quite a many
instances of addf() soon followed by "return -1" in
refs/files-backend.c, but they are not immediately adjacent to each
other, and won't be helped.
