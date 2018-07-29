Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615B5208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeG2VJy (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 17:09:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeG2VJy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 17:09:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so10439776wrs.9
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0TTjg/Zcc0BiTq6+vVZPVqzCrt44SNaAagyDinIgm0=;
        b=PFpoMk0mXO8PogCh5yrzcp0IRoCTqZJx6uIMGoNNbqXdaywj0tYxOJ2Q7ceTzW3BM5
         x8rrGA5ovzfWQ5YSlQFFSgd5g2lRWwNJ/H9eAe6E7nRmljCSs/BLYHgxzXT3iK2dqFSB
         zP7nW0QUZv6Xi5f94QE+3AChNu6WrEBYKtptW4sA3XyNNrw1dTxurC2kkQCs9exyKs78
         S47xjxTnLD/3csbOtJZqY3+FBkL+XZT5O6NT/yZX9tphDB5MSfEeWilWSoP5UQplCeAd
         AZpH9xFO8FWonKgq9mI4IrEYxNhXhh5XKGZQSEJFgHtsYuHziK5EyUT/M3pQb8jy1gcg
         9mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0TTjg/Zcc0BiTq6+vVZPVqzCrt44SNaAagyDinIgm0=;
        b=sc222h+AXN5sYYo+Xqt86vtYhMPZuexyOKsII330k/tgbDH2EfjoE03MXQuX54tuXB
         0Cn7Tn+HWy8zJhdV85ftyMXHLWgRELuZyoOPj6Fs/Mu+pYGjvQPxkZw8xARGkLwkcAF6
         V6B6zJdT2cVoX7x5B90QUSK+KCf8hpDP3pDArwuKGTl+6FDHe5Na0FR7G3bR6IUQBXao
         tCB4WT2Alk7GGqtWF1zvP4XgHFxoHRPDvQPtwOglAXI2u0sZOheJ4n0EVPzxSfpvPtwv
         uoCykil/uqSbTYbRwsmrGk+FlOT0b//MW6gi7dAS4C9trluceQRhA5yogZJArmc8a2+5
         pC9w==
X-Gm-Message-State: AOUpUlHk2nbsstGdCHiiDACYJi/aBJjBx1Ij7GPI2EZNlBITji19FBhO
        PD7BuMNET+bqvlNEGRob92GIz4lP
X-Google-Smtp-Source: AAOMgpeNtooT4+q1FBDOj9k622Q7GBxAKOs1xtEwBwf3TGD6fH1NqAtJLIVeQreqEBnTJJ6eGGAF2A==
X-Received: by 2002:adf:96c3:: with SMTP id u61-v6mr14423470wrb.72.1532893100473;
        Sun, 29 Jul 2018 12:38:20 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id w185-v6sm14471884wmw.6.2018.07.29.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 12:38:19 -0700 (PDT)
Date:   Sun, 29 Jul 2018 20:38:18 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 09/21] range-diff: adjust the output of the commit
 pairs
Message-ID: <20180729193818.GE2734@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This change brings `git range-diff` yet another step closer to
> feature parity with tbdiff: it now shows the oneline, too, and indicates
> with `=` when the commits have identical diffs.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  range-diff.c | 64 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index 1ecee2c09..8329f52e7 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -7,6 +7,8 @@
>  #include "xdiff-interface.h"
>  #include "linear-assignment.h"
>  #include "diffcore.h"
> +#include "commit.h"
> +#include "pretty.h"
>  
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -255,9 +257,54 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
>  	free(b2a);
>  }
>  
> -static const char *short_oid(struct patch_util *util)
> +static void output_pair_header(struct strbuf *buf,
> +			       struct strbuf *dashes,
> +			       struct patch_util *a_util,
> +			       struct patch_util *b_util)
>  {
> -	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> +	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> +	struct commit *commit;
> +
> +	if (!dashes->len)
> +		strbuf_addchars(dashes, '-',
> +				strlen(find_unique_abbrev(oid,
> +							  DEFAULT_ABBREV)));

We're doing this only once, which makes sense.  What's a bit
unfortunate here I guess is that if the first commit we're dealing
with in the range-diff has a longer unique abbreviation, the dashes
will be longer for all commits, even if all the others have a shorter
abbreviation.

Tbh I don't really know what the right thing to do here is, so this is
probably as good a heuristic as any.  It would probably be worse to
have different length dashes lines, than guessing based on the first
commit.

> +
> +	strbuf_reset(buf);
> +	if (!a_util)
> +		strbuf_addf(buf, "-:  %s ", dashes->buf);
> +	else
> +		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
> +			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
> +
> +	if (!a_util)
> +		strbuf_addch(buf, '>');
> +	else if (!b_util)
> +		strbuf_addch(buf, '<');
> +	else if (strcmp(a_util->patch, b_util->patch))
> +		strbuf_addch(buf, '!');
> +	else
> +		strbuf_addch(buf, '=');
> +
> +	if (!b_util)
> +		strbuf_addf(buf, " -:  %s", dashes->buf);
> +	else
> +		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
> +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
> +
> +	commit = lookup_commit_reference(oid);

This bit surprised me slightly.  May be worth mentioning that we now
also show the first line of the commit message here.

> +	if (commit) {
> +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> +		const char *subject;
> +
> +		find_commit_subject(commit_buffer, &subject);
> +		strbuf_addch(buf, ' ');
> +		format_subject(buf, subject, " ");
> +		unuse_commit_buffer(commit, commit_buffer);

I think the above could be written slightly shorter as

    strbuf_addch(buf, ' ');
    pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);

Not sure if it's worth changing this at this stage of the series
though, or if there is something in the above that I'm missing, that
would make the shorter version not workable.

> +	}
> +	strbuf_addch(buf, '\n');
> +
> +	fwrite(buf->buf, buf->len, 1, stdout);
>  }
>  
>  static struct diff_filespec *get_filespec(const char *name, const char *p)
> @@ -286,6 +333,7 @@ static void patch_diff(const char *a, const char *b,
>  static void output(struct string_list *a, struct string_list *b,
>  		   struct diff_options *diffopt)
>  {
> +	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
>  	int i = 0, j = 0;
>  
>  	/*
> @@ -307,25 +355,21 @@ static void output(struct string_list *a, struct string_list *b,
>  
>  		/* Show unmatched LHS commit whose predecessors were shown. */
>  		if (i < a->nr && a_util->matching < 0) {
> -			printf("%d: %s < -: --------\n",
> -			       i + 1, short_oid(a_util));
> +			output_pair_header(&buf, &dashes, a_util, NULL);
>  			i++;
>  			continue;
>  		}
>  
>  		/* Show unmatched RHS commits. */
>  		while (j < b->nr && b_util->matching < 0) {
> -			printf("-: -------- > %d: %s\n",
> -			       j + 1, short_oid(b_util));
> +			output_pair_header(&buf, &dashes, NULL, b_util);
>  			b_util = ++j < b->nr ? b->items[j].util : NULL;
>  		}
>  
>  		/* Show matching LHS/RHS pair. */
>  		if (j < b->nr) {
>  			a_util = a->items[b_util->matching].util;
> -			printf("%d: %s ! %d: %s\n",
> -			       b_util->matching + 1, short_oid(a_util),
> -			       j + 1, short_oid(b_util));
> +			output_pair_header(&buf, &dashes, a_util, b_util);
>  			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
>  				patch_diff(a->items[b_util->matching].string,
>  					   b->items[j].string, diffopt);
> @@ -333,6 +377,8 @@ static void output(struct string_list *a, struct string_list *b,
>  			j++;
>  		}
>  	}
> +	strbuf_release(&buf);
> +	strbuf_release(&dashes);
>  }
>  
>  int show_range_diff(const char *range1, const char *range2,
> -- 
> gitgitgadget
> 
