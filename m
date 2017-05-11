Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A7B201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbdEKUPV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:15:21 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33653 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755324AbdEKUPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:15:20 -0400
Received: by mail-pg0-f53.google.com with SMTP id u187so19688838pgb.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hg+crhsxAEDfH+s1wjnby58GqsNqgxsZJTJ1dC8VmBE=;
        b=s+xoZgJAx+s59l6g7OpYM32UNN8ZsfDzNvZr1WtCe1UMXe1kH0i4kFqs4RDJwU5PK4
         YziEmnzWXhVEA2w+P6wyzuxloZEduGF/74t6v7WbiYBrc2BHNwHGOXWaAEQQ3hn4QDEy
         jh4qFzumFkq5MED4re9965bsJBtPirNBYe1XHEGGIbZTvwo2IqZn+xDkKL3qI6dPi0bi
         ROaZMJoHSBnRShlt2EYgIoc9wgbXLlhuO0wtzGrqzOR0L5yobPM4zeW1ZJlytDVmW0kk
         xmXp7FJPBfEPnP9FeQqLWGWdaMvVjpwlUpm/UkJxPYae3LJ8Dsvq+4ENITRrMflPZni8
         xa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hg+crhsxAEDfH+s1wjnby58GqsNqgxsZJTJ1dC8VmBE=;
        b=kOoytiy4kJ3FOa5Q2iQBLDBp7XrigBmiKnIQwnNf0V2khdQoDsPto0Rb+K4LvYwyaP
         rwwkw/b4MCHMkkGJBVRX0kmEjw3lRhAwl7DsTkqt0z05sazW9qjfRgJC2isEn90VjSDS
         c1j9ejSKmWvVO9t8kKLmbsyIwzIWN9PbNPI+fnU2ruUdbxyPqxGXQomM7afZM8gygt1z
         3euR5XmPU2aDkpjx6ngK/PswRsqjD4pSXGhSlG3gdG/4+5h80rjrCSLUf7a2w5FAgX2U
         lD7sbilwmPzimEso4Do4yd2vgoL9EL4HOyI0zoAwSnI4Kyyh9T+f7PnX9BIyIPirJoyc
         zQjA==
X-Gm-Message-State: AODbwcALLV00mF+Zk2CHUpkTyFmTAo9/ITvbb7MP7w8cm6MU+4Ir96rM
        6O9xb4ASUPWTgARBhbPqIg==
X-Received: by 10.98.192.143 with SMTP id g15mr294303pfk.219.1494533719486;
        Thu, 11 May 2017 13:15:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id p84sm1695830pfi.25.2017.05.11.13.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:15:18 -0700 (PDT)
Date:   Thu, 11 May 2017 13:15:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 21/29] grep: factor test for \0 in grep patterns into a
 function
Message-ID: <20170511201517.GI83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-22-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-22-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Factor the test for \0 in grep patterns into a function. Since commit
> 9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
> \0 is considered fixed as regcomp() can't handle it.
> 
> This limitation was never documented, and other some regular
> expression engines are capable of compiling a pattern containing a
> \0. Factoring this out makes a subsequent change which does that
> smaller.
> 
> See a previous commit in this series ("grep: add tests to fix blind
> spots with \0 patterns", 2017-04-21) for further details & rationale.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index bf6c2494fd..27de615209 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -394,12 +394,6 @@ static int is_fixed(const char *s, size_t len)
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
> @@ -408,6 +402,17 @@ static int is_fixed(const char *s, size_t len)
>  	return 1;
>  }
>  
> +static int has_null(const char *s, size_t len)
> +{
> +	/* regcomp cannot accept patterns with NULs so when using it
> +	 * we consider any pattern containing a NUL fixed.
> +	 */

I commented on a later patch but really the comment should be fixed
here.  And why not simply move this to where you intend it to be at the
end of the series now?

> +	if (memchr(s, 0, len))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> @@ -451,7 +456,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  	 * simple string match using kws.  p->fixed tells us if we
>  	 * want to use kws.
>  	 */
> -	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
> +	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen))
>  		p->fixed = !icase || ascii_only;
>  	else
>  		p->fixed = 0;
> -- 
> 2.11.0
> 

-- 
Brandon Williams
