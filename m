Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47192082F
	for <e@80x24.org>; Sun, 25 Jun 2017 22:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdFYWUC (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 18:20:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35354 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdFYWUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 18:20:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so15739732pfs.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=clHFMNHwBuIGO3fXNPZo0YvfCqroKs4OwFYeUfd/6wo=;
        b=XiZv+OwGGSRbESUVmiJT3BgafK2UJK1YuTUIYMrzlGtKgMnTpfJ6MLEEmCVSrBp15s
         KFYh/BoUSBKXg9HNIWZxwHgcgc9VllZvn42k5y4Xk3p9KFiu3TSOwKSlc88RNbkkDfgS
         7+71ayOo1w2hAZyetxxXXBWShALblyObf8z+4gbkSeEUkl1B4rmk47qT3T/eKe4NRH3i
         cAPI6MFzmh/r9EKKfJn9KYXWi30Sbu1KRMwuRG7L6dSrdBUg0kqnyQ6MLm9DwvDKxdnU
         nBLU/gOcA6vpij7sbNZu9mGvk5eNsgIXn+mfEZ4izmOQZY9ejDQbor18dUdHh+u3NAbm
         5+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=clHFMNHwBuIGO3fXNPZo0YvfCqroKs4OwFYeUfd/6wo=;
        b=cpZvHjyOwHPucwGH6H09bWnBnr8q81JKK3r2toVyjSKSZ/y9oRUkDqm9POPqdp6tJ7
         AvAG5pvAn9seO0TR1URFQLV3SUFZTlcqyWu9HNHPTfb+9rh4Z2VGBbqPyFpffip9t3ox
         GTVl9iHdh2hzb00fzibmH+OAcTPFZxRDEN1fWWQ+XT/LZG9ISjOnDdfTOYmvXz7Y/SOo
         ILxlyS7ZjaaAY7e5HQzp03IRxDQDSXgiNwxUznqyZS73MsoDCnnWQVEWOBh+hluu5zgq
         unkIKhXR6QFah809Emdk0NTy/KZxeuw/EqeAHf5zRAOh+4JOr0L8ByFFw2ucJFHXbTR/
         7SSw==
X-Gm-Message-State: AKS2vOxVdQCXmlTHy5pq9hvZ7oIpvspp3FSzzF4lACorUSSXaSUitrpp
        OibzDO6pyh8ffA==
X-Received: by 10.84.139.67 with SMTP id 61mr20282564plq.19.1498429200457;
        Sun, 25 Jun 2017 15:20:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id v8sm21324503pfa.10.2017.06.25.15.19.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 15:19:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 4/6] convert: put the flags field before the flag itself for consistent style
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-5-larsxschneider@gmail.com>
Date:   Sun, 25 Jun 2017 15:19:59 -0700
In-Reply-To: <20170625182125.6741-5-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:23 +0200")
Message-ID: <xmqqh8z37lrk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

An obviously correct no-op.

I do not particularly see the first one making any improvement (but
it is not making things any worse, either), but turning (CONST &
var) to (var & CONST) may make it easier to read for some people so
I wouldn't complain.

Will queue.

>
> diff --git a/convert.c b/convert.c
> index f1e168bc30..9907e3b9ba 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -597,12 +597,12 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	}
>  	process = &entry->subprocess.process;
>  
> -	if (!(wanted_capability & entry->supported_capabilities))
> +	if (!(entry->supported_capabilities & wanted_capability))
>  		return 0;
>  
> -	if (CAP_CLEAN & wanted_capability)
> +	if (wanted_capability & CAP_CLEAN)
>  		filter_type = "clean";
> -	else if (CAP_SMUDGE & wanted_capability)
> +	else if (wanted_capability & CAP_SMUDGE)
>  		filter_type = "smudge";
>  	else
>  		die("unexpected filter type");
> @@ -703,9 +703,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
>  	if (!dst)
>  		return 1;
>  
> -	if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
> +	if ((wanted_capability & CAP_CLEAN) && !drv->process && drv->clean)
>  		cmd = drv->clean;
> -	else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
> +	else if ((wanted_capability & CAP_SMUDGE) && !drv->process && drv->smudge)
>  		cmd = drv->smudge;
>  
>  	if (cmd && *cmd)
