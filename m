Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9445720441
	for <e@80x24.org>; Wed, 28 Dec 2016 18:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbcL1SPo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 13:15:44 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33636 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1SPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 13:15:44 -0500
Received: by mail-pg0-f51.google.com with SMTP id g1so118802797pgn.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T4wpsdufe4ydFzkyT5NeJ1lkztM6bQ3brSNLzhrmFpY=;
        b=DkASKKSM5DewWs0JPYxDvRr1sldTRe7yuqBWnQAHF3oIYN55QVkXAHrdVgCBUzBCT/
         UMzXFrM9eMYt6P6L377lskCASIjBhPAqry8e9ZHIwGbOkGQJIQNpDxJPYVdxRTdSZM4B
         4NvIsZj9soLMGf7N3l7Vu8zxte+dz9S/kRlHVVb62NKQRHSQ8I8djRq5PCtEafWGLCsh
         WK5sX6PoVHQQah5RczStQmrBtuuNy95VLhZ8tULzhlAmqcPM+WJQP2z/Y3pXXv32VxNb
         N9LLKrXl4Kzu9cFA4/1BDiaOXDp8t9JIho/dnOcq1LkyIoGl4HeeAFokWC1NIaJdWvoL
         HmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4wpsdufe4ydFzkyT5NeJ1lkztM6bQ3brSNLzhrmFpY=;
        b=ZJem50Lw/mv2MelOt19TSFoQBU0mqYWo9eGrcyfdiHF2v9CFZOepOkF6Xdma4p4Dq8
         GQlJqADVBMyL2ES1G9RMM8ecIBQte/uE+lZrmCKvbBdbSKC8o1nP8e3vrc8J1mkj2nhY
         dup3mZKzhgMDMaez7sdJC0c/ZbIsBVZdIvobKOlES1lM1+1mXKYx53n4wjpvZ+PdZ10k
         XHGiLjs/o9UvFTClj0dZRBkOfrA0Sbv/tcZRsl+f4cjbgnPv0NZKkzbqpFe4P2/oUId0
         qStrHhZCo/dYnmgo8O/a40bzhM+ly5P/jy7bnGuFfwHTu19qudzwULWCH1IdTFlRITG9
         Ke5g==
X-Gm-Message-State: AIkVDXLh/3PpYDLSnJRTiQGjWyjiKzGbOT8fKn60aB0lyB3ZMGaF9+aI2Knk6mhgxbazM+eD
X-Received: by 10.99.211.21 with SMTP id b21mr70656236pgg.120.1482948920584;
        Wed, 28 Dec 2016 10:15:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5916:abad:d441:dac4])
        by smtp.gmail.com with ESMTPSA id o68sm98855612pfb.42.2016.12.28.10.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 10:15:19 -0800 (PST)
Date:   Wed, 28 Dec 2016 10:15:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCHv2] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20161228181518.GB33595@google.com>
References: <20161228055826.xu2gclwkvisbft6o@sigill.intra.peff.net>
 <20161228171746.22859-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228171746.22859-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28, Stefan Beller wrote:
> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1].
> 
> The usual response from the mailing list is link to old discussions[2],
> and acknowledging the problem stating it is known.
> 
> For now just improve the user visible error message.
> 
> [1] https://www.google.com/search?q=item-%3Enowildcard_len
> [2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
>     https://www.spinics.net/lists/git/msg249473.html
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Peff wrote:
> > Don't you need to flip the logic here? An assert() triggers when the
> > condition is not true, but an "if" does the opposite. So "assert(X)"
> > should always become "if (!X) die(...)".
> 
> Duh! and it should compile as well. 
> 
> Thanks,
> Stefan
> 
>  pathspec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..4724d522f2 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len > item->len ||
> +	    item->prefix         > item->len)
> +		die (_("Path leads inside submodule '%s', but the submodule "
> +		       "was not recognized, i.e. not initialized or deleted"),
> +		       item->original);
>  	return magic;
>  }

Turns out I should comment on the most recent version of the patch :P
This looks better to me. (It resolves the issue with using a variable
not in scope).

-- 
Brandon Williams
