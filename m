Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC4220401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdFUVvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:51:09 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33125 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdFUVvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:51:07 -0400
Received: by mail-pg0-f48.google.com with SMTP id f127so5745486pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HtCwZwHIqp8EOhc66mP5mV2I9uNm0dO7aassai8jj5s=;
        b=In97z96rwTnyYcQwPl3LyRQTowb1Xrl/oy9J/Op7i3vpnPjcy3UMCFdiy026/o9yXl
         FP5KGZ69c9YDuyMknC3D4KeBm1ggqWdre4JLIXNpX7UkZun4V1tFXiuXz6/vivfyZS8P
         JYT3wbNnpItdvLUHu7PnVHn39nwZYM1CRRk/GWtn9e84YWbuQ2jehI1rl8N1A4Sw9WvB
         EECloeJtn4KOyzq46LPx1pKwpBm1NdvBY7yeKkggxvs0zKFlm43UK8s2X9fb8Evd5mOS
         MwX9pZkVgUzCT/c//44Z4wwo8+7mK8WMzcX1y9BuZpmtb3WMTJot0fLIGFRerH3qGFum
         XKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HtCwZwHIqp8EOhc66mP5mV2I9uNm0dO7aassai8jj5s=;
        b=WbG9QyAh8bV3OLOx+8nniZgdGa28yR2mg7Ac3AmSUYbcyMTqqDb08DSKBV4C3jJ5c6
         bnKRAt8CZ7rWIcQFFsBBRUpootkaseYF8jUJ7Nedr8ligzZKOP6waP6CcG5iSDy9hd3v
         1d83LZ4xw+s0zHMdAXB654Z8Ja8E7UvD+xuF5KGUXqX9Zik168cB+t0rQZ7pquCBACGI
         BHUsUOOPE4iSSLL1rNcWzLQhbchyo+vHfmBrUxBNg8GRs49H4spgZq2Yk2O3s8Ph2QXs
         uRu75JeGY+v6VAlhX2ZjqhxQ4xG16u6K+a7OIyJtFBeySfLrTqbndY+bQu2hMoTjGkMs
         atFw==
X-Gm-Message-State: AKS2vOw3wdhSocrXoXB/zzEOP6V3P8oTRfuTrs7+uT8a9zD3lgymWjw1
        hCNuQhydfZaPp5omPO1spg==
X-Received: by 10.84.225.145 with SMTP id u17mr13168003plj.255.1498081866984;
        Wed, 21 Jun 2017 14:51:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id v69sm34600638pfd.63.2017.06.21.14.51.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:51:06 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:51:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable"
 move coloring
Message-ID: <20170621215104.GF53348@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
 <20170620024816.20021-27-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170620024816.20021-27-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/19, Stefan Beller wrote:
> Ævar asked for it, this is how you would do it.
> (plus documentation, tests, CLI knobs, options)
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 15 +++++++++++----
>  diff.h |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 7756f7610c..61caa057ff 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  	static const char *nneof = " No newline at end of file\n";
>  	const char *context, *reset, *set, *meta, *fraginfo;
>  	struct strbuf sb = STRBUF_INIT;
> +	int sign;

should this be a char instead of an int?

>  
>  	enum diff_symbol s = eds->s;
>  	const char *line = eds->line;
> @@ -1058,8 +1059,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		default:
>  			set = diff_get_color_opt(o, DIFF_FILE_NEW);
>  		}
> +		sign = '+';
> +		if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
> +			sign = '*';
>  		reset = diff_get_color_opt(o, DIFF_RESET);
> -		emit_line_ws_markup(o, set, reset, line, len, '+',
> +		emit_line_ws_markup(o, set, reset, line, len, sign,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1086,8 +1090,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		default:
>  			set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
> +		sign = '-';
> +		if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
> +			sign = '_';
>  		reset = diff_get_color_opt(o, DIFF_RESET);
> -		emit_line_ws_markup(o, set, reset, line, len, '-',
> +		emit_line_ws_markup(o, set, reset, line, len, sign,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> @@ -5475,7 +5482,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
>  	struct diff_queue_struct *q = &diff_queued_diff;
>  
> -	if (o->color_moved)
> +	if (o->color_moved || o->machine_readable_moves)
>  		o->emitted_symbols = &esm;
>  
>  	for (i = 0; i < q->nr; i++) {
> @@ -5485,7 +5492,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  	}
>  
>  	if (o->emitted_symbols) {
> -		if (o->color_moved) {
> +		if (o->color_moved || o->machine_readable_moves) {
>  			struct hashmap add_lines, del_lines;
>  			unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
>  
> diff --git a/diff.h b/diff.h
> index 98abd75521..b6c4d7ab0f 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -194,6 +194,8 @@ struct diff_options {
>  		COLOR_MOVED_ZEBRA = 2,
>  		COLOR_MOVED_ZEBRA_DIM = 3,
>  	} color_moved;
> +
> +	int machine_readable_moves;
>  };
>  
>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
> -- 
> 2.12.2.575.gb14f27f917
> 

-- 
Brandon Williams
