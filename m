Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2C91F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeC3TDr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:03:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43479 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC3TDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:03:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id j2so5905950pff.10
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Geaox+bsTEdKRmFyvkGj6RsPzdKAO92hbIbGzpmyAWg=;
        b=lug8Ssb+6nkvYSuoa5R4hIxpiQuZ7T1M4b0XW2lj86y+Bul3hUPTsXiMh/Agrz9Urp
         vEHtblaMHRRj6F5H/34S9ptIRXS1jrqsODn3E6jL1kh7qYOjtG3XaC0N1AFgdXac1UEI
         hZk47Bh/7uqpmAZbuw05TgQzDUv3HuOm8k33/fYzwGl/hAo6OE8BKmHUvrpZRlDNRw0n
         MNMbuSWVHlkRGfZacK6aAKoap18jHSujosAxlB5oDXuN5f+tDj+DPStf1Lbahxx3pgfu
         oHjjULbMi5Yfh+StVWUPZ6UkoMkZpqa5GJUk5NCWo0uQXgQtIvF6m5dUeA3CK+dfvD3W
         NIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Geaox+bsTEdKRmFyvkGj6RsPzdKAO92hbIbGzpmyAWg=;
        b=eh8OTV+GMttBd0sEcmvaFkp1eW8IGx+XH/kyDNqDqh9P5U0fXGSDnDFriStjLlcjPC
         m82/4Cij5UvZZP5h/ZMHMOw/79HD6WRVBggfHd2jvyMkkojUV5vrMFtd5LB3NOn93YRj
         UFpGvRYvCV5czjyhTeQYshvLS5qYOnCnAIR3nqfVf45mANVKo0cYr206nQQJRs1LzGqu
         DKOWSsMKZFctTJ66X/x9oTS7Emv5ATzpYFnkgx3jCjuu7j9DijfVbAZoHhJ5nhcAQdY/
         kKNs+etXuyBu2nxrjmS0vPFP30v0TFuUhCOG/4xtEBf4jKp8ZAZS5DvIRHGhZ2bo2CIA
         zy5A==
X-Gm-Message-State: AElRT7FHUfQckpWGni3ykV/rAdkkaTfXFL9GhuMJ7U+lCxrs7fUE8ABB
        wUEylJV4fg3ncILP74ObkhaBLw==
X-Google-Smtp-Source: AIpwx48/Lt5jlPSD5NeJR2CPPKgVUUy7yiEQsnn1iqTWxFSYJn9F4LMeu8s4ZwmmD7NVJAe7oHwrXw==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr166797plc.403.1522436625496;
        Fri, 30 Mar 2018 12:03:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c62sm19753466pfk.179.2018.03.30.12.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 12:03:44 -0700 (PDT)
Date:   Fri, 30 Mar 2018 12:03:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] {fetch,upload}-pack: clearly mark unreachable v2 code
Message-ID: <20180330190343.GB171603@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180330092907.611-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330092907.611-1-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Ævar Arnfjörð Bjarmason wrote:
> Change the switch statement driving upload_pack_v2() and
> do_fetch_pack_v2() to clearly indicate that the FETCH_DONE case is
> being handled implicitly by other code, instead of giving the reader
> the impression that the "continue" statement is needed.
> 
> This issue was flagged as DEADCODE by Coverity[1]. Simply removing the
> "case FETCH_DONE" would make -Wswitch warn. Instead implement the same
> solution discussed for my "[PATCH v2 18/29] grep: catch a missing enum
> in switch statement" patch[2] (which never made it into git.git).
> 
> 1. https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com/
> 2. https://public-inbox.org/git/20170513231509.7834-19-avarab@gmail.com/

I understand why you want this change, but I dislike it because it
removes the ability to have the compiler tell you that your switch
statements are exhaustive.  Of course it should be noticed rather
quickly by the addition of those BUG statements :)

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  fetch-pack.c  | 4 ++--
>  upload-pack.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 216d1368be..3a16b4bc1a 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1393,8 +1393,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  
>  			state = FETCH_DONE;
>  			break;
> -		case FETCH_DONE:
> -			continue;
> +		default:
> +			BUG("Added a new fetch_state without updating switch");
>  		}
>  	}
>  
> diff --git a/upload-pack.c b/upload-pack.c
> index 87b4d32a6e..b7a7601c83 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1416,8 +1416,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>  			create_pack_file();
>  			state = FETCH_DONE;
>  			break;
> -		case FETCH_DONE:
> -			continue;
> +		default:
> +			BUG("Added a new fetch_state without updating switch");
>  		}
>  	}
>  
> -- 
> 2.16.2.804.g6dcf76e118
> 

-- 
Brandon Williams
