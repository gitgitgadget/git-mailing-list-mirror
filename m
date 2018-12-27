Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4C3211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeL0GcJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 01:32:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeL0GcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 01:32:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so16701810wml.3
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 22:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9M34Qon4PxLUGraSmB6ctwElVkQkipwNzTb+rL/1wTY=;
        b=SSVbi+q/X3h132WqWSm+lUJuCrdd/uUsgNpvDM8gJNN4QbwT1gfvzcVUIyUJrJb9kF
         FczFgE2ttB4wP0yigLdlAGikpQ49+sUOVvUemYLEVAhriPVu2P2BBonHWQwU0eoClG77
         bwRS39+/z5GgXO/WXUsWOtKxSw45uON8v0/V4ipARBjKXcLmdqIra1C0na+FfXpjs+8B
         wSP1JRw8JoqzZlWcY/FTATkL3Uhv3MdtEoWYAEuIeVTyk+3b0Q4OU5lPH035zw2uLF85
         mwoJa6CBIrhhgKCw31LWkNB71QOoQroErUp3a1QUKJlj935JVXTv49gAcjBjZmA/lvU/
         uVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9M34Qon4PxLUGraSmB6ctwElVkQkipwNzTb+rL/1wTY=;
        b=CCvVYJrlLkCX/r4gEZBXkSJSKwdAELlXZ5E3fCNZMoaKVdWhiA9vEDIpLN4yR46O2a
         CBXyD3l4K+dMOJvC8AVRD/gk3KEfAlNAbGFgJCV1N7IUMxUWZ2h6awDZdAnb5+J709q2
         /hH5/Bcwd3of7+OQuQPdj0e7GZcHrtk2aFz9Nbc6n7wusIlcdSVV7IBnhVaWHSPeFdrL
         WYDhvK4L1Q18/61a216MeNuDsxmnYzrx4Z0q2KIHFzYT1eodlNySfSiZsbgR/6HMt/gg
         nbY7csKV6WDU/EyvzyTfSdj3JJnCSLNbbPAgGVk1e4T600bBlwMXjZS0mIyx3AQSGvdj
         Uq4g==
X-Gm-Message-State: AA+aEWYZUNXVmY7gFkScNNXnCLbPYU7IX7+gY9vKlBZLm20gqX/uW+7g
        bfHdAaCR157ys6DPyz2nJ0w=
X-Google-Smtp-Source: AFSGD/UCZ4HBahOPkJNye3Ts/wT32nOA3lpCKqnoGD0yaNz/xxQhNxY73FuERUvxeYnthvrtER3BHQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr20400651wmc.68.1545892326497;
        Wed, 26 Dec 2018 22:32:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w80sm30258093wme.38.2018.12.26.22.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 22:32:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] imap-send: Fix compilation without deprecated OpenSSL APIs
References: <20181227023548.396-1-rosenp@gmail.com>
Date:   Wed, 26 Dec 2018 22:32:05 -0800
In-Reply-To: <20181227023548.396-1-rosenp@gmail.com> (Rosen Penev's message of
        "Wed, 26 Dec 2018 18:35:48 -0800")
Message-ID: <xmqqwonvpjiy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rosen Penev <rosenp@gmail.com> writes:

> Initialization in OpenSSL has been deprecated in version 1.1.

https://www.openssl.org/docs/man1.0.2/ssl/SSL_library_init.html says 

	SSL_library_init() must be called before any other action takes
	place.

https://www.openssl.org/docs/man1.1.0/ssl/SSL_library_init.html says
the same.

Which makes it necessary for us to defend the following claim

> This makes
> compilation fail when deprecated APIs for OpenSSL are compile-time
> disabled.

as a valid problem description more rigorously.  To me, the cursory
web-serfing I did above makes me suspect that an OpenSSL
implementation with such a compile-time disabling _is_ buggy, as it
forbids the API users to call an API function they are told to call
before doing anything else.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  imap-send.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index b4eb886e2..21f741c8c 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>  	int ret;
>  	X509 *cert;
>  
> +#if (OPENSSL_VERSION_NUMBER < 0x10000000L)

https://www.openssl.org/docs/man1.1.0/crypto/OPENSSL_VERSION_NUMBER.html

says that OPENSSL_VERSION_NUMBER is of form 0xMNNFFPPS where M is
major, NN is minor, FF is fix, PP is patch and S is status, and
gives an example that 0x00906023 stands for 0.9.6.b beta 3 (M=0,
NN=09, FF=06, PP=02 and S=3).  So "< 0x10000000L" means "anything
with M smaller than 1".  IOW, we would no longer call _init() for
e.g. "version 1.0.0 beta 0".  That contradicts with the first claim
of the proposed log message ("deprecated in 1.1" implying that it is
not yet deprecated in say 1.0.2).



>  	SSL_library_init();
>  	SSL_load_error_strings();
> +#endif
>  
>  	meth = SSLv23_method();
>  	if (!meth) {
