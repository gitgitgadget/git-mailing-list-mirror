Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C6C20281
	for <e@80x24.org>; Tue, 23 May 2017 21:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161900AbdEWVSM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 17:18:12 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34488 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161870AbdEWVSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 17:18:08 -0400
Received: by mail-pf0-f175.google.com with SMTP id 9so126007276pfj.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=znom3mYgkpLf0Iy0c3B1SKPEXbzy5mKaELMoZc1l3sk=;
        b=nBcbkYYLhcI15/PXHRw4AQVYKzmZoNqF0XACXdIbbR52YDhBzymt3bXrIdVKJcwtIK
         xCQb5VRn0Nns0OnX3JH4GbXp+bkXjFWbfM6WYDCnUJb5vETQAyco2bFtd9xtxJgaJkyM
         aEjc1rTKmaPHIQ/kyM/x2eJopJ60E9Q5iH2TdnMgD2NwDRHoanGBvphpCV9J2zsEAm2a
         9r+2yCDhAKi46DkaesQIuE9HLp3Tb22EiV1nQd5GCD2zvwidySb+PhDUJXF3lkg2fZEq
         vXi1loDf+iNLSKD3AAdYo2xwo8yhCySwWA0oHheCKpEz/VMS6PAXyuW3hj5s3umUeJwM
         8qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=znom3mYgkpLf0Iy0c3B1SKPEXbzy5mKaELMoZc1l3sk=;
        b=MPZQYRw3emBMDCPFYPgaFTwlaP/rQ8V7Zp1jyiMScd+x3/lgrGiUoBdB4x/W5iZW29
         9Pfee5TGgnmZfVxCjieUzPtBFwJ+mv5e7LzURVbTOfx/YXRcl71da4AXT4ib6hUL3ScQ
         Zm9caWoT/yzXtIng0oNn87RgCGeJUa3GHGuCyz2VW9fzRqNWu1sMjwtMxfzmqInRXMbA
         H0NJTrFLBfo0ZSHDEkwBjKU1FE8a3xwC99nAfCXkF6ydBta1MwfXlMQQ2omJvNMV1bDV
         BRUcz9UC97RZRjWoiNt9JWZe2CqJ+czpKfVWsXY9pYUowUEEzIdQJ9/KxPiN6YSGOpsY
         l3Ng==
X-Gm-Message-State: AODbwcCpkjlZ5xDl0dBolGmMb+LctxFWx1EgvknXgFcmEZnBff+o3NgZ
        7MuHwyvTHnA4iMXp
X-Received: by 10.84.198.3 with SMTP id o3mr39198492pld.60.1495574277106;
        Tue, 23 May 2017 14:17:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id n23sm3910388pfh.44.2017.05.23.14.17.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 14:17:55 -0700 (PDT)
Date:   Tue, 23 May 2017 14:17:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v3 22/30] grep: factor test for \0 in grep patterns into
 a function
Message-ID: <20170523211754.GI115919@google.com>
References: <20170520214233.7183-1-avarab@gmail.com>
 <20170520214233.7183-23-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170520214233.7183-23-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/20, Ævar Arnfjörð Bjarmason wrote:
> Factor the test for \0 in grep patterns into a function. Since commit
> 9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
> \0 is considered fixed as regcomp() can't handle it.
> 
> This change makes later changes that make use of either has_null() or
> is_fixed() (but not both) smaller.
> 
> While I'm at it make the comment conform to the style guide, i.e. add
> an opening "/*\n".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index bf6c2494fd..79eb681c6e 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
>  	die("%s'%s': %s", where, p->pattern, error);
>  }
>  
> +static int has_null(const char *s, size_t len)
> +{
> +	/*
> +	 * regcomp cannot accept patterns with NULs so when using it
> +	 * we consider any pattern containing a NUL fixed.
> +	 */
> +	if (memchr(s, 0, len))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  #ifdef USE_LIBPCRE
>  static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  {
> @@ -394,12 +406,6 @@ static int is_fixed(const char *s, size_t len)
>  {
>  	size_t i;
>  
> -	/* regcomp cannot accept patterns with NULs so we
> -	 * consider any pattern containing a NUL fixed.
> -	 */
> -	if (memchr(s, 0, len))
> -		return 1;
> -
>  	for (i = 0; i < len; i++) {
>  		if (is_regex_special(s[i]))
>  			return 0;
> @@ -451,7 +457,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  	 * simple string match using kws.  p->fixed tells us if we
>  	 * want to use kws.
>  	 */
> -	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
> +	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen))

small nit: longer than 80 char

>  		p->fixed = !icase || ascii_only;
>  	else
>  		p->fixed = 0;
> -- 
> 2.13.0.303.g4ebf302169
> 

-- 
Brandon Williams
