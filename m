Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4FA51F454
	for <e@80x24.org>; Mon,  4 Nov 2019 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfKDK0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 05:26:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38613 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKDK0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 05:26:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id v9so16386217wrq.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tg24Y5jLlBpZOUI1p5b3w/xLKIXooVneUJ8Kqej07to=;
        b=L+ixqSby4VaFvDUsIRlPDQwyMyXrGj6rM2U2tqtmsDCg7Kt4/V6oq7l5drtoJ40WP4
         pgf20ZsNa/5PdRJe29iuD9dN/0osoHk9DFmyZ5q4vX+s26SFKLwDJOJ4puMKnRNqqKQH
         YcZ/LhVAmEsdvQm2ZtGMZ9B87NwsUPy46Uk06dHSMH0TfJhx0EPlLtMoEb5x+GYm1xRB
         pGTlP6eHg4K4cQQsYpa9G0mFTXaH2bHHZ4WbvpHmVUmyvqnbLF/SeULg97wsCOJ1F4Vc
         B5vCX4yU7lxrHECmHULm+n5CSbXYdKLUpapPsIyqMkxiYZHDWvZDTjAnU3PIcg1xP384
         jHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tg24Y5jLlBpZOUI1p5b3w/xLKIXooVneUJ8Kqej07to=;
        b=bSWtEXWBm5Bfe4rFpKHShl7QPsFlQLMPqI1xTuZqMhtnpUdfmO7ZzfZKeJlAYIqhwG
         e4375G8YIFx1L729dpxMjiZPlwgha7m6KVLOnjvVI0JdUlIZ+n4vfC2bKvsAalRQ9M7a
         yPvQn5Tj9mWB4d9uaEVEPNELe2fHk53vNMtmx8ksCDEEdqAz4biKpZtCLZMBVIzDvQ+k
         AkN5kzTF18bVjANUVipYsokAzLXNr70z0FIXYVPINSc7evY2CZ7RHx0xCiukzMupg89/
         ntKHIa2gkFxKy3MXee5kalrGE1KfAqUYS6buYidQ1kC5PaXc3dQlxCE5nxZObVJp9muE
         mC3A==
X-Gm-Message-State: APjAAAXKmKcWKIjdcxIw8r248IeBs3OPceP8As1MPtodCYIG53GzS4jw
        sNxoM93FuH8qHw3zIj/9URlabX0u41s=
X-Google-Smtp-Source: APXvYqyGNLwJQ0p3O8S1FM/ZNpltLzfa+WS2Q9fMC/5F1whNUL75Lz+tAwIRLTxPY8elcttOTZnpxg==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr22974710wrv.289.1572863175165;
        Mon, 04 Nov 2019 02:26:15 -0800 (PST)
Received: from szeder.dev (x4db559aa.dyn.telefonica.de. [77.181.89.170])
        by smtp.gmail.com with ESMTPSA id z15sm16028153wrr.19.2019.11.04.02.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 02:26:14 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:26:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of
 the '=' operator
Message-ID: <20191104102612.GE4348@szeder.dev>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104095923.116086-1-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 09:59:21AM +0000, Elia Pinto wrote:
> Fix the LGTM warning of the rule that finds uses of the assignment

What is an "LGTM warning"?

I think including the actual compiler warning in the commit message
would be great.

> operator = in places where the equality operator == would
> make more sense.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  ident.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/ident.c b/ident.c
> index e666ee4e59..07f2f03b0a 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -172,12 +172,15 @@ const char *ident_default_email(void)
>  			strbuf_addstr(&git_default_email, email);
>  			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -		} else if ((email = query_user_email()) && email[0]) {
> -			strbuf_addstr(&git_default_email, email);
> -			free((char *)email);
> -		} else
> -			copy_email(xgetpwuid_self(&default_email_is_bogus),
> +		} else {
> +			email = query_user_email();
> +			if (email && email[0]) {
> +				strbuf_addstr(&git_default_email, email);
> +				free((char *)email);
> +			} else
> +				copy_email(xgetpwuid_self(&default_email_is_bogus),
>  				   &git_default_email, &default_email_is_bogus);
> +		}
>  		strbuf_trim(&git_default_email);
>  	}
>  	return git_default_email.buf;
> -- 
> 2.24.0.rc0.467.g566ccdd3e4.dirty
> 
