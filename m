Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864311FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdFGSP4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:15:56 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35879 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFGSP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:15:56 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so8329822pff.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dqcChDBD5G0ALsiawtE/rJ4TJ980zozVsOCAGA26AkU=;
        b=orbSB/uzGlmDLi3tpZPEdkkJSB1UJmp74ipOVi+RyvnVGw4ON7YiM6wO8og7BttBwJ
         5DDvwW37nHAhCC4RJKoHqS2MRC/XP+rlyKf+aKoIqgsq/10ifkOxoIo/iXpU9yLHwmDO
         OmQXgtJB2oK3ADAaS1cYARrMgxj2mGP/DRBrdms4t/7xNZkrltfMSWWlDNca/jbX35nH
         z4GXgz5N6XnTup51gPYM41z8aKQNC6C8CJj12JfRCGpGryn89oAprY9Cw4ZWRD4QiUrZ
         2z6j/dLW541t5eU7kq2hUWjMMC7nj9EGdDBFaNb9jbrQuIYXHX7ypbW6u7fAUfp1OYPG
         6cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dqcChDBD5G0ALsiawtE/rJ4TJ980zozVsOCAGA26AkU=;
        b=qMM5hO2NSnvbhTuMJEaVKULpl9j0+wTMfyTxBZp8kWvl+We8bYi3GZUrgvrv2EjUxx
         ASiHqbDXlqnXEKMAsOL8TrtSnBXBlBmxfg2uJJi5lZ5jJj8/EpW6MGvowy3C9h2yPahg
         JnXYlitS500PAJz1DI9dhPXGs27xRM7QmRp2RW+mVSL/XmMvkK3fh1GoI1cy2lHgGWjP
         oeOB55oQKje9pB/6YS5cqXhDxQn7Ob/R9qgH337q9P/D/zoz5ZEeL02IyNa3xS85aatv
         2nFOVl+eBDtxlb8OXcxhAIT575wDc5JDN3SYf8TWwka+BaZvnI4rfYc4HRkrJX/U/j2I
         9P+g==
X-Gm-Message-State: AODbwcCoQUR+j+1ISHb4JkjG7IjPceYrXS83v7ELo9oYD27D4oLH5EjZ
        lou1fEYMOWsyXHaM
X-Received: by 10.99.121.13 with SMTP id u13mr33691976pgc.147.1496859355249;
        Wed, 07 Jun 2017 11:15:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id h7sm4862285pfc.97.2017.06.07.11.15.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:15:54 -0700 (PDT)
Date:   Wed, 7 Jun 2017 11:15:53 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] t1308: relax the test verifying that empty alias
 values are disallowed
Message-ID: <20170607181553.GE110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> We are about to change the way aliases are expanded, to use the early
> config machinery.
> 
> This machinery reports errors in a slightly different manner than the
> cached config machinery.

Not a comment on the patch but just a genuine question: Is there any
reason why they complain in a different way?  Doesn't it make sense for
the errors to be reported consistently?

> 
> Let's not get hung up by the precise wording of the message mentioning
> the lin number. It is really sufficient to verify that all the relevant
> information is given to the user.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1308-config-set.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index ff50960ccae..69a0aa56d6d 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
>  		br
>  	EOF
>  	test_expect_code 128 git br 2>result &&
> -	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
> +	test_i18ngrep "missing value for .alias\.br" result &&
> +	test_i18ngrep "fatal: .*\.git/config" result &&
> +	test_i18ngrep "fatal: .*line 2" result
>  '
>  
>  test_expect_success 'error on modifying repo config without repo' '
> -- 
> 2.13.0.windows.1.460.g13f583bedb5
> 
> 

-- 
Brandon Williams
