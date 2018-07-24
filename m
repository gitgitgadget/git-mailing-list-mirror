Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47631F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbeGXTKy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:10:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39666 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXTKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:10:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so3400742wmb.4
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PHSRp2T2MKGhYpRuDZu5pZ8u0l94fj6RdOyNp13Kylc=;
        b=oVTKxKK49rkTC5dZ8JJIvVOJ3zUyO3mOT9XEGz8LK690rFdHxwjZlFe2GB9+V0au94
         9phY9a1rkhchYahAwJtnVaY2NW3U/XJ2kyGoKTqEoyLGYc6Q3f+OHbqw2HErZ3voiUeU
         XDzmNNDk/GmMwMpPzIAh5u643Q8O8wXvlBvpU3xf49/xRQE9uIp9TYS74CJMG2+ve9OJ
         w5dTI9qU7xZ6QcepANiDZ6Qm8iIVwoxuVnFcBZIMoT8rnANvsoEJYeZgC/fNMttNSuCH
         EkPso4rOCf8CMAb0kYm8yWtb76kHI2V1VBRt6bAH/iU8xe6Uy8n8GrhOzFIhxZxJ3r8C
         0C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PHSRp2T2MKGhYpRuDZu5pZ8u0l94fj6RdOyNp13Kylc=;
        b=CPmxymVHCuBHk/QiFuRTdaGXMtpSHQwHt7DTxuQOSY3xdQVGd1vFcE9IGlTJAqgYVc
         00ZZTMG977rJojTJZQS7bfAzKLlNn13pPMD6VuF7GMQBlNPsE17S0/Ptt/FxciPneNIT
         S7OP0gVRfSFLLFV4aAAyRa4BJgpJWvzmYLHhFbvTyLDtK8ct0ObDqmAImpGHvBMJm4OC
         7EuHxHq8vHiIl7k4BRtrkLptdQBYOw+KhSAGmDJL+DlDs74S1TS2ngfHnf390xt4aLD5
         IkpNZckrWFkwP2vIWMfiAwOk9U4qDhjyKsoTlLcoCR37/4ZrMRJatfkyBKz5q8Z8d7H+
         USkg==
X-Gm-Message-State: AOUpUlEX01ngPNoacEYMaGlUb1B5W6phYjT6br3h4AMUBMZjn8Vn8XJv
        dGNuT4hcVpjnLrNPrvZHWcw=
X-Google-Smtp-Source: AAOMgpdfzn1jWQ9o1J4JXR0irUvVU4/DHsGqRb+XT2xXjxlJEd4VDp9n3f0Se3xj6AXQD4NKWNjb8g==
X-Received: by 2002:a1c:9042:: with SMTP id s63-v6mr2451324wmd.91.1532455393476;
        Tue, 24 Jul 2018 11:03:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d7-v6sm9251175wro.92.2018.07.24.11.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:03:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, larsxschneider@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] msvc: fix non-standard escape sequence in source
References: <20180724144249.2857-1-git@jeffhostetler.com>
Date:   Tue, 24 Jul 2018 11:03:12 -0700
In-Reply-To: <20180724144249.2857-1-git@jeffhostetler.com> (git's message of
        "Tue, 24 Jul 2018 14:42:49 +0000")
Message-ID: <xmqq6014zf33.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Replace non-standard "\e" escape sequence with "\x1B".
>
> In commit 7a17918c34f4e83982456ffe22d880c3cda5384f a trace message with
> several "\e" escape sequences was added.  This causes a compiler warning
> under MSVC.
>
> According to [1], the "\e" sequence is an extension supported by GCC,
> clang, and tcc.

Good spotting.  Please spell it \x1b (or \033 if you are a
traditionalist), as it seems nobody in the existing code uses
uppercase, according to

    $ git grep -e '\\x[A-F][0-9A-F]' -e '\\x[0-9A-F][A-F]' \*.c

and "\033"  is already used in many places

    $ git grep -e '\\0[0-7][0-7]' \*.c



> [1] https://en.wikipedia.org/wiki/Escape_sequences_in_C
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  convert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index 56cfe31..52092be 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -335,7 +335,7 @@ static void trace_encoding(const char *context, const char *path,
>  	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
>  	for (i = 0; i < len && buf; ++i) {
>  		strbuf_addf(
> -			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
> +			&trace,"| \x1B[2m%2i:\x1B[0m %2x \x1B[2m%c\x1B[0m%c",
>  			i,
>  			(unsigned char) buf[i],
>  			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
