Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94A11F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeCWVz5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:55:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33492 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeCWVz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:55:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73so13512597wrb.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bvx5yuePkqu54YjnmpsMfKjtdsFM+JCshWAIl2kzZQk=;
        b=OnM4J5WCtkEdCVTv3zXXHzBkpRHKlyg1gMxiWVRAEy0HBjfvwOYv6+TTOvhGq6yiHx
         u+IqqSKOqgqd25wOH1dvhDZHTF34QV5UgE0SUZ1zhnCUpTePIPZaxJ6nJBscfc+EfZ0w
         Qzfhh0NfBvYhyhnwp4W+QeflILVyN2RoqOKAtaJBpjkdiO34MWQvxYsheTXaEGatGqKw
         rGD3DSV38M8LnujaYaCtgEzI9lYv8MbOwzaxiNVTCazfZkvR5UymfiSPZ20Qhba5wKLu
         m6p4K9tQXExaQ+exoI6ZmUBsvgVsE0LDOVP5A8abqbRDRdiZMDE2uciE16JxZCY6jta9
         0pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bvx5yuePkqu54YjnmpsMfKjtdsFM+JCshWAIl2kzZQk=;
        b=aDIV+a9x8onh6UyXQlsMw1JuopFZ0R8gfgg58Qj+mceDZXtRExZ/msJAFNGrRz9me1
         sYfDDSyK1KAkpKl5TpsoHedIm0l//Csw9PHKI/32BLnfy1/t5ZD0UVpwiMU+7CNiWexT
         RQHCG13ZIfCpE00qaUY8PhuNyoym/w8qzGYgu7h4LjREFeP0ifNJ76g2WnluU5Prly20
         9hKLHkN7As5ixPby3otgGmlKDljEc6lYChjP1RfTiHINiJeTnHtrnYP0oRMavH9e6ikT
         lwKqEF7+M+kl5So7Qi92Y9fGsRO7Ye3F2mHlfm4u2giROxF08PUB2+I9Z+1uKdzBlWP+
         dWCA==
X-Gm-Message-State: AElRT7FFgXMUjUydOkulFuAb4dg0iFAQQPHJbMAs9U6cJaaNDb1z3YlF
        2TN+Wnx+l6NreKizdd6HERo=
X-Google-Smtp-Source: AG47ELt2xZY0d5SUrJUCfWnOCQx8Znvzv6pLog5OAwAkn1S0n5c+CxH8dZDJAqbdTFhCYPHQcIqQlA==
X-Received: by 10.223.149.70 with SMTP id 64mr17753780wrs.223.1521842154746;
        Fri, 23 Mar 2018 14:55:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l17sm9749373wrh.58.2018.03.23.14.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 14:55:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Loganaden Velvindron <logan@hackers.mu>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
References: <20180323193435.GA21971@voidlinux>
Date:   Fri, 23 Mar 2018 14:55:53 -0700
In-Reply-To: <20180323193435.GA21971@voidlinux> (Loganaden Velvindron's
        message of "Fri, 23 Mar 2018 23:34:35 +0400")
Message-ID: <xmqqy3iih2xi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Loganaden Velvindron <logan@hackers.mu> writes:

> Subject: Re: [PATCH v2] Allow use of TLS 1.3

Let's retitle it to something like

	Subject: [PATCH v2] http: allow use of TLS 1.3

> Add a tlsv1.3 option to http.sslVersion in addition to the existing 
> tlsv1.[012] options. libcurl has supported this since 7.52.0.

Good.

>
> Done during IETF 101 Hackathon

I am on the fence wrt the value of this line, especially because I
would strongly suspect that this version is not what you wrote and
tested during your Hackathon.  Even if it were, would it give value
to future "git log" readers by supplying extra context?

> Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
> ---
>  Documentation/config.txt | 2 +-
>  http.c                   | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ce9102cea..b18cb9104 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1957,7 +1957,7 @@ http.sslVersion::
>  	- tlsv1.0
>  	- tlsv1.1
>  	- tlsv1.2
> -
> +	- tlsv1.3
>  +

Before this change, the block that shows the list of versions had
one blank line before and after it.  Now we lost the blank line
after the block.  Is it intended?  Possibilities that come to my
mind as a reviewer are:

 A. There is no difference in the rendered output if we have zero
    blank line (i.e. with the patch), or one blank line (i.e. before
    the patch applied).

    A.1) the submitter made this change on purpose, because it will
    make the source shorter without affecting the output, as a
    "clean-up while at it" change.

    A.2) this was an accidental change, which did not break the
    output merely because the submitter was lucky.

 B. The rendered output changes due to the lack of the blank line.

    B.1) And it changes in a good way.  The submitter made this
    change on purpose.

    B.2) And it changes in a bad way, but the submitter did not
    notice it.

Please do not make reviewers wonder.  Either avoid making
unnecessary changes (e.g. you could have just added a new line with
tlsv1.3 on it without touching the blank line), or make the change
and explain why you made that change that is not essential for the
purpose of adding tls1.3 which is the main focus of this patch.

>  Can be overridden by the `GIT_SSL_VERSION` environment variable.
>  To force git to use libcurl's default ssl version and ignore any
> diff --git a/http.c b/http.c
> index a5bd5d62c..25eb84c11 100644
> --- a/http.c
> +++ b/http.c
> @@ -62,6 +62,9 @@ static struct {
>  	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>  	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>  #endif
> +#ifdef CURL_SSLVERSION_TLSv1_3
> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
> +#endif
>  };

It seems to me that

    https://github.com/curl/curl/blob/master/include/curl/curl.h#L1956

tells me that this #ifdef would not work.  Did you test it with the
"test not version but feature" change you made at the last minute?

I know it is not your fault but is Ævar's, but you're responsible
for double-checking what you are told on the internet ;-)

Thanks.
