Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CEC20248
	for <e@80x24.org>; Thu,  4 Apr 2019 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDDQhN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 12:37:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDQhN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 12:37:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so4598759wrx.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gctnOSRVD9TXf75QVXyI0BnpQTDus2IXKO0IKepSsBw=;
        b=adRE9jCbstj7fUMThma6Mm/Opag/D1aMrOfXYVPFDP5nf8VGjQ0zuC02nwAYKiuoth
         M/04hipvNk17bap4MjMYx6dw2uuI9SA2mdDYndDblaMZB44wGtIMx5BAyhkSwOuOTHB8
         6wCeYzSMaFhOdkV2C+s3tadZ2EN2t3S+fbqCunOtKlWUDA/k6R0MGDtqB9YIBwMQNq/z
         pImGi+MAVIst14b4046JdZ1BOyZK33kvIoUa17x5HC2aimMFIOx7RuQ74cl2ciSMzQ9b
         t3pmMzt+SsB99WP7ZAjDmScpLXX81J9s0LrQ0JA53iZE650A+2I0zog/zs1T4OJb6J8P
         sF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gctnOSRVD9TXf75QVXyI0BnpQTDus2IXKO0IKepSsBw=;
        b=WEyjCpVXUlRHNa2aO1AkG2i+9tB68svjJtYlDvBne0+5aj0mtoZOPlr81Aby6y1+um
         so/Y5rhc/VvFOfHDJtGD0GTqf5grv/wwLEtVS9uQBNSMnqBVp/MYup1VzkoPJiLtZyjt
         WsT/f1kUU2o4bcj10weJbtqhZmAIb/pxQgiaBNfusCNbmkzWL/0Dteeu1uXxMQMI3x9B
         NVwWWnT7dBYsugarPLqoba72fNcj3rCwkheFa6KkXfYmKlSKVPEbpB9ZQTrgafh6XZXN
         /U7arE8Xk6TIBDXkVqgptgGTimTQy64tl1QMEQdX2XLRfiQl3mDIF9EqFU/zXdK2JbAr
         kvcg==
X-Gm-Message-State: APjAAAWbBjlQER+W98nTEvvbSJ3BskJExx1Q4asKOjIDLXn9650bohLF
        iYMp83WB8GdpcYmSHkbrIPo=
X-Google-Smtp-Source: APXvYqzZlEogkEzuFX6xVg7j1DMt8i8KD+FUyfY1shsjW0oCQ6lgDmWhyRz7k2hFRN8e4cQgbNpKUQ==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr5007447wrv.10.1554395831103;
        Thu, 04 Apr 2019 09:37:11 -0700 (PDT)
Received: from szeder.dev (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id w18sm29642049wru.24.2019.04.04.09.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 09:37:10 -0700 (PDT)
Date:   Thu, 4 Apr 2019 18:37:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
Message-ID: <20190404163707.GP32732@szeder.dev>
References: <20190403160207.149174-1-brho@google.com>
 <20190403160207.149174-7-brho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403160207.149174-7-brho@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 12:02:07PM -0400, Barret Rhoden wrote:
> diff --git a/blame.c b/blame.c
> index c06cbd906658..50511a300059 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -915,27 +915,109 @@ static int are_lines_adjacent(struct blame_line_tracker *first,
>  	       first->s_lno + 1 == second->s_lno;
>  }
>  
> -/*
> - * This cheap heuristic assigns lines in the chunk to their relative location in
> - * the parent's chunk.  Any additional lines are left with the target.
> +/* https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel */
> +static int bitcount(uint32_t v)
> +{
> +	v = v - ((v >> 1) & 0x55555555u);
> +	v = (v & 0x33333333u) + ((v >> 2) & 0x33333333u);
> +	return (((v + (v >> 4)) & 0xf0f0f0fu) * 0x1010101u) >> 24;
> +}
> +
> +#define FINGERPRINT_LENGTH (8 * 256)
> +#define FINGERPRINT_THRESHOLD 1
> +/* This is just a bitset indicating which byte pairs are present.
> + * e.g. the string "good goo" has pairs "go", "oo", "od", "d ", " g"
> + * String similarity is calculated as a bitwise or and counting the set bits.
> + *
> + * TODO for the string lengths we typically deal with, this would probably be
> + * implemented more efficiently with a set data structure.
>   */
> +struct fingerprint {
> +	uint32_t bits[FINGERPRINT_LENGTH];
> +};
> +
> +static void get_fingerprint(struct fingerprint *result, const char *line_begin,
> +			    const char *line_end)
> +{
> +	for (const char *p = line_begin; p + 1 < line_end; ++p) {

We still stick to C89, which doesn't support for loop initial
declarations yet.  Please declare the loop variable as a regular local
variable.  This also applies to the several 'for (int i = 0; ...)'
loops in the functions below.

> +		unsigned int c = tolower(*p) | (tolower(*(p + 1)) << 8);
> +
> +		result->bits[c >> 5] |= 1u << (c & 0x1f);
> +	}
> +}
> +
> +static int fingerprint_similarity(const struct fingerprint *a,
> +				  const struct fingerprint *b)
> +{
> +	int intersection = 0;
> +
> +	for (int i = 0; i < FINGERPRINT_LENGTH; ++i)
> +		intersection += bitcount(a->bits[i] & b->bits[i]);
> +	return intersection;
> +}
> +
> +static void get_chunk_fingerprints(struct fingerprint *fingerprints,
> +				   const char *content,
> +				   const int *line_starts,
> +				   long chunk_start,
> +				   long chunk_length)
> +{
> +	line_starts += chunk_start;
> +	for (int i = 0; i != chunk_length; ++i) {
> +		const char *linestart = content + line_starts[i];
> +		const char *lineend = content + line_starts[i + 1];
> +
> +		get_fingerprint(fingerprints + i, linestart, lineend);
> +	}
> +}
> +
>  static void guess_line_blames(struct blame_entry *e,
>  			      struct blame_origin *parent,
>  			      struct blame_origin *target,
>  			      int offset, int delta,
>  			      struct blame_line_tracker *line_blames)
>  {
> +	struct fingerprint *fp_parent, *fp_target;
>  	int nr_parent_lines = e->num_lines - delta;
>  
> +	fp_parent = xcalloc(sizeof(struct fingerprint), nr_parent_lines);
> +	fp_target = xcalloc(sizeof(struct fingerprint), e->num_lines);
> +
> +	get_chunk_fingerprints(fp_parent, parent->file.ptr,
> +			       parent->line_starts,
> +			       e->s_lno + offset, nr_parent_lines);
> +	get_chunk_fingerprints(fp_target, target->file.ptr,
> +			       target->line_starts,
> +			       e->s_lno, e->num_lines);
> +
>  	for (int i = 0; i < e->num_lines; i++) {
> -		if (i < nr_parent_lines) {
> +		int best_sim_val = FINGERPRINT_THRESHOLD;
> +		int best_sim_idx = -1;
> +		int sim;
> +
> +		for (int j = 0; j < nr_parent_lines; j++) {
> +			sim = fingerprint_similarity(&fp_target[i],
> +						     &fp_parent[j]);
> +			if (sim < best_sim_val)
> +				continue;
> +			/* Break ties with the closest-to-target line number */
> +			if (sim == best_sim_val && best_sim_idx != -1 &&
> +			    abs(best_sim_idx - i) < abs(j - i))
> +				continue;
> +			best_sim_val = sim;
> +			best_sim_idx = j;
> +		}
> +		if (best_sim_idx >= 0) {
>  			line_blames[i].is_parent = 1;
> -			line_blames[i].s_lno = e->s_lno + i + offset;
> +			line_blames[i].s_lno = e->s_lno + offset + best_sim_idx;
>  		} else {
>  			line_blames[i].is_parent = 0;
>  			line_blames[i].s_lno = e->s_lno + i;
>  		}
>  	}
> +
> +	free(fp_parent);
> +	free(fp_target);
>  }
>  
>  /*
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
