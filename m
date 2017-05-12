Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3442201A7
	for <e@80x24.org>; Fri, 12 May 2017 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbdELXcS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 19:32:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35924 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdELXcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 19:32:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id h64so4479222pge.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hXNAGaIFr2WRsSGL3BEVsfdydHIy60ah0xxY4C1Ujus=;
        b=PMrObZgh1g7EDSqzMPgKLVDdFw5ACtDib2ZjSicqtBF7sHDhre/6l3LLEU1PkWMuKV
         YU0qafoT6tmnhfZcOhbMOmCWgxP2w3oyKhbgkGlUwtB1udgtCDFf5ixnh36TH5PdnyF4
         n0kQDEjGqFpYlh8ElKgqQnHkCvjoTanRT2lV81XVhWkj+UH4752uMdS/fHeLFwTb6aGh
         wfnGC1JWFEj1iSpT40mAQBTCK97nfrXXs2xcdqqywQ85lpBMqk18JV6TYc1On9t/9lDM
         WRIdCwr0FE3oz1zr/YWhHE6W4+zsdZZh7Esa9cE2Mj2aPe9aiIFg/iQ2m+9w7UWJPaIF
         nfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hXNAGaIFr2WRsSGL3BEVsfdydHIy60ah0xxY4C1Ujus=;
        b=oQYXGEttTM1u20F2ybnIrIlFSGRupRbO6Q0wkGO4XejaIyUxBhRbYUc9t9kA8grTxA
         4/EbQUQT4+yWvsQNq6tWdpZ9oRW6mn2FBeHBn4QyFoVZvlXjAbqqyolNE1sM6fZsEXpM
         TfCYVNJTQnCnoVh8BWbPwCR/5vFsrMSdh70hp36lM5dY2kc1VQEqb4CqlIRKiFN9NO1G
         YureHk+VCxgJ1o6Y1STEhc96lY2rtKuPVbdpRwRURcZbWV/C+hlDziiTlQwLUnuKvfLw
         VKyQVsigMy2BbYqjWPHT7TuMgM7iBh4HpXpd9UyZ+/9NIrW/SXqWFKepM+7KN7nNtaxh
         zetA==
X-Gm-Message-State: AODbwcDRhq5Zk62ERJohcuDVYOErPlwe9NlrDHKgskAHA22+D88tHlEi
        LNGUkbpahVls0g==
X-Received: by 10.99.109.9 with SMTP id i9mr6772536pgc.56.1494631936645;
        Fri, 12 May 2017 16:32:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id i15sm10141135pfj.51.2017.05.12.16.32.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 16:32:16 -0700 (PDT)
Date:   Fri, 12 May 2017 16:32:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
Message-ID: <20170512233214.GE27400@aiede.svl.corp.google.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512221221.406645-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> The recent change that introduced autodecorating of refs accidentally
> broke the ability of users to set log.decorate = false to override it.

Yikes.  It sounds to me like we need a test to ensure we don't regress
it again later.

> When the git_log_config was traversed a second time with an option other
> than log.decorate, the decoration style would be set to the automatic
> style, even if the user had already overridden it.  Instead of setting
> the option in config parsing, set it in init_log_defaults instead.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1e..ec3258368 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -110,6 +110,8 @@ static void init_log_defaults(void)
>  {
>  	init_grep_defaults();
>  	init_diff_ui_defaults();
> +
> +	decoration_style = auto_decoration_style();
>  }
>  
>  static void cmd_log_init_defaults(struct rev_info *rev)
> @@ -410,8 +412,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		if (decoration_style < 0)
>  			decoration_style = 0; /* maybe warn? */
>  		return 0;
> -	} else {
> -		decoration_style = auto_decoration_style();
>  	}

Makese sense.

Thanks,
Jonathan
