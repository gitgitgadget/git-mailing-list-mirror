Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AD9201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932588AbdEKUOI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:14:08 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33788 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755324AbdEKUOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:14:07 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so18975975pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ASRmhtuDNbxR3/aqiQ9kYaCIAaBUJ3DiWPKR9Z07aM0=;
        b=g8+QdjrAa9rnk8Kx0shEDgtTB+T3kmTxJb20ZXp3GkKUUP6r7+7U3rJJAMa6EPxnRR
         nMwpyFWEGyvyJoCBpVMP+Qon7FPt55GxZk3jWiqUhOto2257iRj//z/BxMktzwpH0Cvb
         /RIFAfFe0+S/43Fd+u9r99shjKwCeHRh07IC3Z5FW79ZoqdHeJwahvYMP306h/rV0Zhg
         jPl9xPz+DzgR8xbVGJq59AMDT27U6qIYkZLPlpLC/sRqF7CFRppNSanGIkctL10pvRDZ
         8n+/GKwffEiKqb8Fd/tobhM5l7dWqUcyLhMFWs5cBOGy1L5Ex+M62UwmVmMCl7DAMUqK
         jmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ASRmhtuDNbxR3/aqiQ9kYaCIAaBUJ3DiWPKR9Z07aM0=;
        b=toCxvR3ofFFoJZfnHNiIKPhFx5wJLwC0UKGyi3nPRW7EVYNg0XPqFb8sPyoOqmhVJC
         j2vh9qyxaZ4uwZ+99rXnsjCBfCOUTqdX5ZfjwyrRRDaNJm8NZyFgjgCVYxCEF00wjfNK
         Tmr5+kpkvRQkzWaVXMu0FaBP+AK3bIOHEFjRsI2+eF1GkZzbD5bMVEUYJhCQgbf1wKoB
         5rWAmAanZU7YeksXg2I2Pl2Ym96stBEYzN2J6kTymZ69SXAHFYFLYTi3nUB8RU8tEczX
         /9WpPGFWau7YYwATpcU1GKDrLjIKvVVriV0bABU/19LIugG7t1vvc3ojyC8gUSaPBDsw
         t9Kw==
X-Gm-Message-State: AODbwcCmKHgBjPQVB4Y3YXPKSdPVdhpfVJul641fZilEc3LI/PgG8tvv
        qQ4N2ozBekt7wF5kfYzElQ==
X-Received: by 10.84.232.76 with SMTP id f12mr384227pln.101.1494533646544;
        Thu, 11 May 2017 13:14:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id d83sm1907914pfe.40.2017.05.11.13.14.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:14:05 -0700 (PDT)
Date:   Thu, 11 May 2017 13:14:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 24/29] grep: move two functions to avoid forward
 declaration
Message-ID: <20170511201404.GH83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-25-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-25-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Move the is_fixed() and has_null() functions which are currently only
> used in compile_regexp() earlier so they can be used in the PCRE
> family of functions in a later change.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index 4507765811..5c808f8971 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -321,6 +321,29 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
>  	die("%s'%s': %s", where, p->pattern, error);
>  }
>  
> +static int is_fixed(const char *s, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; i++) {
> +		if (is_regex_special(s[i]))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int has_null(const char *s, size_t len)
> +{
> +	/* regcomp cannot accept patterns with NULs so when using it
> +	 * we consider any pattern containing a NUL fixed.
> +	 */

Since you're already moving these functions, mind cleaning up the
comment to conform to our style guide?

> +	if (memchr(s, 0, len))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  #ifdef USE_LIBPCRE1
>  static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  {
> @@ -390,29 +413,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  }
>  #endif /* !USE_LIBPCRE1 */
>  
> -static int is_fixed(const char *s, size_t len)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < len; i++) {
> -		if (is_regex_special(s[i]))
> -			return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static int has_null(const char *s, size_t len)
> -{
> -	/* regcomp cannot accept patterns with NULs so when using it
> -	 * we consider any pattern containing a NUL fixed.
> -	 */
> -	if (memchr(s, 0, len))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -- 
> 2.11.0
> 

-- 
Brandon Williams
