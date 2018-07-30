Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5DA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeG3T1A (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:27:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46067 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3T1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:27:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so7637820pgq.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhUHkhz3yTwsROxtSHqWxM4dK+t/fuoUZ1OcuFRolgU=;
        b=c2D/LexSbQTY6GI3Rmt3G07bjtLLo7h1cds/+2fGJv9oeqzsj54eD5RciaWp2JYaeg
         WcMTksBZc5J1xQWXCBPYs+0LZskCTrNm/+5z+cXn5fuSqJKSjPQ9g1uDfMCgJsDUyjAX
         ZT4ioOho/bmOFEn+flcAEPWlTbx57nq4GILortv08XuWH26clB6PHbV1dlVfL/wb9L4V
         l5lZOMwnq+vUlRqWjKeWxvmdKQKqlGVwyT4CdP1wFaMaS/ukkKXG9ZAo0Tq3pzif2mbN
         +0eqpzFbc2rG1VlM14UhA8xYGE/HUSYR73AXPQRAK4DhqafvZ3nL8GLsia2tQEmIs5cR
         hZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhUHkhz3yTwsROxtSHqWxM4dK+t/fuoUZ1OcuFRolgU=;
        b=stTiWzvzNhpHgUs27+31bgdvZSgvS35Tk0IVruaSZnc/bZStDbMLg5kJcIhe36Uwh4
         ZnmlPJcgjvYfcZr95f0QGleNcSxkrEHkYIq62JjpbVU7Set4ZwxPt6zegSaOdSUUzkj3
         xW/SDQAanqZeI0Ez4Wz/YCnI6MAR6LzrAtnfMhgNoHCoUC+H2GauhDxdfk9C8V3WjGks
         jd7pD2TmfskFnJf+n4SepfuZwBMNmrJLPR6TG4zrcr8F0wW9X69nmnjNNILpzfa3715/
         rcENdb2vl4DunlrZlldc7d+HjPkaKbK9eFDsldxdheYdL8BN9xJSqsnyNu5Lpi1RLTY+
         h+Og==
X-Gm-Message-State: AOUpUlE6Ss0JATz/3qz20KVbyeNPKcdZO53wZEe+KR8/IvMb9oV3VK1G
        DSGaRXYdXC/Kwy+fvFVjSPE2VA==
X-Google-Smtp-Source: AAOMgpfYufop34PSDFxhV3MiujJ8rYQjHPmSGWbN0aaITLS9RDB8H2e4CksU4nCHPudJOTLHG/H41A==
X-Received: by 2002:a63:7f16:: with SMTP id a22-v6mr17275733pgd.255.1532973053736;
        Mon, 30 Jul 2018 10:50:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 75-v6sm21136884pfr.115.2018.07.30.10.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:50:52 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:50:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] refspec: allow @ on the left-hand side of refspecs
Message-ID: <20180730175051.GA154732@google.com>
References: <20180729192803.1047050-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729192803.1047050-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/29, brian m. carlson wrote:
> The object ID parsing machinery is aware of "@" as a synonym for "HEAD"
> and this is documented accordingly in gitrevisions(7).  The push
> documentation describes the source portion of a refspec as "any
> arbitrary 'SHA-1 expression'"; however, "@" is not allowed on the
> left-hand side of a refspec, since we attempt to check for it being a
> valid ref name and fail (since it is not).
> 
> Teach the refspec machinery about this alias and silently substitute
> "HEAD" when we see "@".  This handles the fact that HEAD is a symref and
> preserves its special behavior.  We need not handle other arbitrary
> object ID expressions (such as "@^") when pushing because the revision
> machinery already handles that for us.

So this claims that using "@^" should work despite not accounting for it
explicitly or am I misreading?  Unless I'm mistaken, it looks like we
don't really support arbitrary rev syntax in refspecs since "HEAD^"
doesn't work either.

> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I probably type "git push upstream HEAD" from five to thirty times a
> day, many of those where I typo "HEAD", so I decided to implement the
> shorter form.  This design handles @ as HEAD in both fetch and push,
> whereas alternate solutions would not.

I'm always a fan of finding shortcuts and reducing how much I type, so
thank you :)

> 
> check_refname_format explicitly rejects "@"; I tried at first to simply
> ignore that with a flag, but we end up calling that from several other
> places in the codebase and rejecting it and all of those places would
> have needed updating.
> 
> I thought about putting the if/else logic in a function, but since it's
> just four lines, I decided not to.  However, if people think it would be
> tidier, I can do so.
> 
> Note that the test portion of the patch is best read with git diff -w;
> the current version is very noisy.
> 
>  refspec.c             |   6 ++-
>  t/t5516-fetch-push.sh | 104 +++++++++++++++++++++---------------------
>  2 files changed, 58 insertions(+), 52 deletions(-)
> 
> diff --git a/refspec.c b/refspec.c
> index e8010dce0c..57c2f65104 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -62,8 +62,12 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  		return 0;
>  	}
>  
> +	if (llen == 1 && lhs[0] == '@')
> +		item->src = xstrdup("HEAD");
> +	else
> +		item->src = xstrndup(lhs, llen);
> +

This is probably the easiest place to put the aliasing logic so I don't
have any issue with including it here.

-- 
Brandon Williams
