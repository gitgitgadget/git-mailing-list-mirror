Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058881F404
	for <e@80x24.org>; Thu, 29 Mar 2018 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeC2UkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 16:40:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38701 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbeC2UkY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 16:40:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id l16so13830786wmh.3
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dbo1zvy5ypkOEJtSXTIdUPv8h74ShcTCbkFc7zf6PD4=;
        b=tYlnbGc4Pk8BByv2kt63fHvEFB5G8xJ2+QL/negs/DCp+PHse6iJgHjsERSj6cT9Ii
         Kpj0Ejgyhr17LnOSc7KK81bl9RRN/bVPHu1qh9RyKxEI/EOSKnqVFMldo5/JFtKzQ322
         XhlaJNKK+UXNJB6HGg/0D7PrkELzBcP7NzrBD0oEXX+OGiHONFuQAWjvA7UdzC4B/VSI
         rMPDpuM45h02aS62cygxXePOXzvizPpwpECLmishVnsFuv+DfWz9nVn80ueShgysAcMi
         oDSgAZ6xO0JhliseneEV9yJ5bnqwy0FEvcaREmrUi0TN6jCA2iTyEG1PyOrPuY6p1KA+
         mlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dbo1zvy5ypkOEJtSXTIdUPv8h74ShcTCbkFc7zf6PD4=;
        b=aZgu52PPfOnMmEc9sy9p9IKGHm1wgyKZR1+mTWgZKoNwxgvA+JyuoX91erf/n2vyF/
         lV5NNY0Y2cbJQuZMk2aCL95VZbhLZnzsq/lwcSRE6fj3AzVpL2OQ3PeBnw1VHn1KKaQQ
         rbLWVR+VdWh0YAy32S7s6Tyt5ILORBj6oMsl+/BEvigNE1GvCQXZ7p62UIbWLLP1apiz
         hqVuwiq3rR3bN34RpLvx5bPa4qK7UnQrbQyqJyo+5euWfWCTxwq946XRUBqMXFsvbaq6
         nOJ50mj2wGHX3j+X4Jt/y1NjWcE6Wg7jNGvjc+Ub03oqq6em8W7E+gT7CIYG99xWXEXH
         Ex7w==
X-Gm-Message-State: AElRT7El/x45CoQGQhTYYfr5LYuPOJcMi4jo8Jx5kWNDTrcTnwN0mRLv
        Z1xb3SXF4u2nBYGypC6pjXB3yYKa
X-Google-Smtp-Source: AIpwx4+72q1KXB6r8ywdCbuUh3vYIeH4P8KTbP3JCot9yJqfIwmv8Y+cdiCzVnjX8S21f7LQ536+IA==
X-Received: by 10.28.198.77 with SMTP id w74mr366098wmf.36.1522356022740;
        Thu, 29 Mar 2018 13:40:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l131sm5545668wmb.36.2018.03.29.13.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 13:40:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Loganaden Velvindron <logan@hackers.mu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] Allow use of TLS 1.3
References: <20180329101418.GA7736@voidlinux>
Date:   Thu, 29 Mar 2018 13:40:19 -0700
In-Reply-To: <20180329101418.GA7736@voidlinux> (Loganaden Velvindron's message
        of "Thu, 29 Mar 2018 14:14:18 +0400")
Message-ID: <xmqqd0zm62fg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Loganaden Velvindron <logan@hackers.mu> writes:

> diff --git a/http.c b/http.c
> index a5bd5d62c..f84b18551 100644
> --- a/http.c
> +++ b/http.c
> @@ -62,6 +62,9 @@ static struct {
>  	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>  	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>  #endif
> +#if LIBCURL_VERSION_NUM >= 0x073400
> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }

Looks OK to me, except one minor nit.

I'll add a trailing comma for this entry while queuing, so that a
future patch to add tlsv1.4 or whatever won't have to worry about
it.

Thanks.

> +#endif
>  };
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
