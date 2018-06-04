Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888561F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeFDRgX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:36:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41575 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeFDRgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:36:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so1367243pff.8
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MIHr+17PMq+jbcL39ScxUIJkGTeKVJxeDDLcxJQ0n8g=;
        b=dYgjTzGcKpOHNXXfoCL3osz9EcvuJ5gYdLcWVYfX7vXo4IqmJnnp5AVHFjuBwNPrDA
         ocoVQu7/kpYwCQibuDmQ2+DAxeDdqoo7O5veWIzGwZTlzrRa6NmkC9IwaOD24ryaxAfU
         Uisot8nS0Zsr1ZaGocLnm6SBaYGWX+ByEM79YI/dYga3CeMOA5l4GxFouQO0gMikDq3t
         XCPe4BWGgb7UkrnrsN9Eb3+Bxqd2H8ETp3H3xMxH/1fckV8qjiljZezO5I5SK6WFJH7G
         15FKsnXrxuIS3enr/MLcFFm7qcHeKpUJWqFdi+9lxtgXc9HHR2l016hQOXZ+KjCkcty3
         DrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MIHr+17PMq+jbcL39ScxUIJkGTeKVJxeDDLcxJQ0n8g=;
        b=M2EtnUBKYsZ2GjA10oaKZHs5FUz+EdCQAM4AF3L+c+2fW321mj60dgbggIVNbZpXCD
         Dj4wc2MDSrbpDuegYBqnc6wI/GI7TMiPr51clM6AStX6/sMQILlq0Ap1AQajnsfnDLCx
         sBikZx7594K0es/mktnd57sL/XHcRl0H+ALMxhgQe+kTIeYYNNRKykywxUu736Ec4Z/E
         RXsdPsdbdtG1QnstOXJRtwrboctHMdyzOR6wrzrO12CqFSlZBggiVe7JzcbsGZYo2Wh9
         ZUvHywMXJedVOjm0kvobZED0UYoN4Kwj9Tl6fRBcj88MP52oXWaw4KD/dvD4nKqcpvsW
         reJA==
X-Gm-Message-State: ALKqPwd709ww1QCv6fEI52Qkea8mMxMvtDC8k1/BfAdO2b8SBJMtMMCt
        X8tfI9S4fObZVtkWLvAlU4xcSA==
X-Google-Smtp-Source: ADUXVKJ57ga6asd6AZps1xuoKAPJxNWifPkNol6aee2Dxnqz5v2EnhwOkhCwnyuJlVuv7uFXp7qIPg==
X-Received: by 2002:a62:9056:: with SMTP id a83-v6mr22424342pfe.186.1528133782102;
        Mon, 04 Jun 2018 10:36:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:3010:3914:d0ce:3649:b074])
        by smtp.gmail.com with ESMTPSA id s27-v6sm24425375pfk.184.2018.06.04.10.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:36:21 -0700 (PDT)
Date:   Mon, 4 Jun 2018 10:36:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refspec: initalize `refspec_item` in
 `valid_fetch_refspec()`
Message-ID: <20180604173620.GB91449@google.com>
References: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
 <20180604144305.29909-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604144305.29909-1-martin.agren@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04, Martin Ågren wrote:
> We allocate a `struct refspec_item` on the stack without initializing
> it. In particular, its `dst` and `src` members will contain some random
> data from the stack. When we later call `refspec_item_clear()`, it will
> call `free()` on those pointers. So if the call to `parse_refspec()` did
> not assign to them, we will be freeing some random "pointers". This is
> undefined behavior.
> 
> To the best of my understanding, this cannot currently be triggered by
> user-provided data. And for what it's worth, the test-suite does not
> trigger this with SANITIZE=address. It can be provoked by calling
> `valid_fetch_refspec(":*")`.
> 
> Zero the struct, as is done in other users of `struct refspec_item`.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I found some time to look into this. It does not seem to be a
> user-visible bug, so not particularly critical.

Thanks for fixing this.  I don't think I noticed this because at some
point in developing this series I had a memset call in parse_refspec.
I don't remember why I ended up removing it, but maybe it would have
been better to leave it in there.

> 
>  refspec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/refspec.c b/refspec.c
> index ada7854f7a..7dd7e361e5 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -189,7 +189,10 @@ void refspec_clear(struct refspec *rs)
>  int valid_fetch_refspec(const char *fetch_refspec_str)
>  {
>  	struct refspec_item refspec;
> -	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> +	int ret;
> +
> +	memset(&refspec, 0, sizeof(refspec));
> +	ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
>  	refspec_item_clear(&refspec);
>  	return ret;
>  }
> -- 
> 2.18.0.rc0.43.gb85e7bcbff
> 

-- 
Brandon Williams
