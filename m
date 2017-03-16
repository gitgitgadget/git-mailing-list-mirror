Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFBC202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 04:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbdCPEtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 00:49:12 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33702 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdCPEtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 00:49:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id n190so19198290pga.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 21:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I509VBJnmPsiqktnp6jv1PZyg3lL23wj2U0VclXZPJ4=;
        b=M6Z9NxW8TRksFwcy7X8nHLXbqLFlgAEdFqA+VuevwhfYlTdbc4Qe+VL4kiEaHzaTjs
         w0eF/sJq84LQl2mVEs0vywYcvDoTdPSKovTsiVE1m+VskPbXiUBZH6eNVW6PM/4B/6oD
         pyc4seOL9BPwV7UhEEgX7KLxB+KfLxA2zjPVwblAnCCqWkIDbs3e+ToZ+qA++Ed643Qo
         o24Rgr93Gp45Y51MbLNbTP+AFR7XkmySAX5vP2yx0Eb1WrDupM2V1KHqsyWNagwVSLCV
         77/Qjm3rGxh82jsIh8qpYb6bQpkUsyKWf795YqFBIT37l7SMhzkSdvl1Xk5aHAz40Z0n
         Qldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I509VBJnmPsiqktnp6jv1PZyg3lL23wj2U0VclXZPJ4=;
        b=I+KYybYXCD5bvPqs4YKrLYsyh1MuLvPMzrEbulmjIZmOvw2hpmm57vNCPgBY2DoLjG
         Upbrf6EHb4ToQf0EMLoALvz3Har3ZQF7KozA1VEYj8TcxZr8YU6+SC/Rbvk77jXvDwKi
         pdylQ8gFpvyiPog6Sx93xZyVrImkEfxPjUZqmhGsef/J/eLLjBpf4SEJxdvXrP2IqAGQ
         Hph9N+YrLL/0A4bRRsRfZK11G/R3i0T5n/hHBHYakEDl+Q1Kb5sGtSG86nFoawIiTqJp
         vWb/Bdzl/s7RCQ+jCkRKcV+03M4VOZyWmUi9FwmT0mSCIiOSDT4LdUe5baFN+PgTuQz/
         0j7g==
X-Gm-Message-State: AFeK/H1depXT0O5CO1mKLyVSCfVAS1gIl4XBFDBWwYp8uIOfe8Wp26/B6SycKYYRSdY7cOui
X-Received: by 10.99.47.199 with SMTP id v190mr7679711pgv.26.1489639750344;
        Wed, 15 Mar 2017 21:49:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id d68sm7129441pfj.92.2017.03.15.21.49.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 21:49:08 -0700 (PDT)
Date:   Wed, 15 Mar 2017 21:49:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] submodule.c: fix an 'using integer as NULL pointer'
 warning
Message-ID: <20170316044907.GI159137@google.com>
References: <2134ffee-f144-1fb3-7e0e-325fd2873ba9@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2134ffee-f144-1fb3-7e0e-325fd2873ba9@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brandon,
> 
> If you need to re-roll your 'bw/submodule-is-active' branch, could
> you please squash this into the relevant patch (commit 20d59ab335,
> "submodule: decouple url and submodule existence", 13-03-2017).

Thanks for catching this, I've squashed it into my local branch and I'm
planning on sending out a reroll in a day or so.

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  submodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 800283154..a77d11cc4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -245,7 +245,7 @@ int is_submodule_initialized(const char *path)
>  			argv_array_push(&args, item->string);
>  		}
>  
> -		parse_pathspec(&ps, 0, 0, 0, args.argv);
> +		parse_pathspec(&ps, 0, 0, NULL, args.argv);
>  		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
>  
>  		argv_array_clear(&args);
> -- 
> 2.12.0

-- 
Brandon Williams
