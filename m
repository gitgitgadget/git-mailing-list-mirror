Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05D0203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 11:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbcLSLOt (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:14:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36379 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932560AbcLSLOs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 06:14:48 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so7448832pfb.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 03:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GROhIDectBco45d8aH+1mxkajW2xpMjXmQUPoHJ7Ai4=;
        b=Dg1QRdvLQyY/IfTYMpM/T9nrRvNpctdugZb16Bir6Cqvjwu1/EeaRmUuNGLi6zBV0d
         g2tHFsMOwZqZLHZK+zmjHKtewWNp4tZVbUvqJUHCOLlJjO+iILEKz8qZbxWWNgsT0f0U
         Ur8a1w6aosikDtMhu/SpSzYmVIM/13DPWjpfMPaqNe0HOxpIaDhJCh5MG7KT/Eq5CLve
         sgv0pQAfKPF4y14llkodmadlXjaaCocZgWIY8CfY7Rp7ELEYBCP7S31E47QdKuBPc4Gs
         MhKgxvKNdSLQxjiApZ8mR6C1yXHbRz3EQ04vaFoSrvirjoYuRLMrimaWQzGsZ0VHt7MA
         N5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GROhIDectBco45d8aH+1mxkajW2xpMjXmQUPoHJ7Ai4=;
        b=isUQKDIRHjEzD0VA84AgoeI99tyM1Egqo1Yd27pbst0X8iS5N3RPrUr+IsvJfnHDMk
         7KWoL9oMgbBeXc5cPJzfE6+HgahtISByKcKVBEQ/4X11BRxWsrpIJiTjQ28cxxuKYgGW
         g89Zh+e12KFiyh52Y8H4tODWzdX17Xc4Qa3Q5hlTD8VK6bQJyI2D9d9Nl7TJhIN9UvgU
         F6nzfjqnBmdLQgoM4+0e3QGV8PyIn9HrXypABYHClcnMuEtgaANmdjS8juf/GSl4wczE
         Fj6VChGirrgsbL5TuQ1xExoyM50+pvXn9esbpMzGZcMCC1OzWUrvXYWbt4NxSygTv909
         iORw==
X-Gm-Message-State: AIkVDXJA7Vigc8TX8gTQwBg8HdhDLrbyGshIwh+GO/s49fuIv3p0QBQ7vHdeqbVEXYBw2Q==
X-Received: by 10.84.209.163 with SMTP id y32mr1791671plh.180.1482146087668;
        Mon, 19 Dec 2016 03:14:47 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id x90sm30640963pfk.73.2016.12.19.03.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 03:14:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 18:14:42 +0700
Date:   Mon, 19 Dec 2016 18:14:42 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 02/21] config: add git_config_get_split_index()
Message-ID: <20161219111442.GA24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217145547.11748-3-chriscool@tuxfamily.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 03:55:28PM +0100, Christian Couder wrote:
> diff --git a/config.c b/config.c
> index 2eaf8ad77a..c1343bbb3e 100644
> --- a/config.c
> +++ b/config.c
> @@ -1709,6 +1709,16 @@ int git_config_get_untracked_cache(void)
>  	return -1; /* default value */
>  }
>  
> +int git_config_get_split_index(void)
> +{
> +	int val = -1;

Is it redundant to set default value here because it's not used
anywhere? The "return val;" will always have the new value from
git_config_. And you don't use "val" in error case.

> +
> +	if (!git_config_get_maybe_bool("core.splitindex", &val))
> +		return val;
> +
> +	return -1; /* default value */
> +}
> +
>  NORETURN
>  void git_die_config_linenr(const char *key, const char *filename, int linenr)
>  {
> -- 
> 2.11.0.49.g2414764.dirty
> 
