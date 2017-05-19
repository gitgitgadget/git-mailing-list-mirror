Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2992023D
	for <e@80x24.org>; Fri, 19 May 2017 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbdESSYp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 14:24:45 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33711 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754552AbdESSXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 14:23:35 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so43486536pfh.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKAirSlyYQ0h30UygUcrEpNgcdJ2epC5embUJRsL43w=;
        b=i6bvz++ecx8v836IPJ/FeXfGS27Zzo0IMKKtEQWk59iS2/KPR12lkEb0PnAo5nLxmP
         IHeaInwOGlf4aq7TFz21xwQm+m0TgLz3yCOaVBqdSttSBWLH0bcsjJePPLQ9kb8g4Cyq
         eMAZOdDXATOBAj2MqTaXW4S32Fqh17hF8HMqbbF3wt8gGLDpeS0jw+eF+qiA+aktvDs0
         v6gZx5TJc7f2ZDGLZejaEFkI/4dicsLrH78+O+qj/YsBu0Grixu/sTWiD/arTVgQ8KdX
         XPt04/7npKy6HLNeWh3DGLNZWm3qBE9Nbp9+QZ8zSanVxyLlh9wlPl01SeZ9K3g5ugCU
         SAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKAirSlyYQ0h30UygUcrEpNgcdJ2epC5embUJRsL43w=;
        b=DMoTE9oHr9eQVYfZE7d2GNxEkAAwfMTnJDd1Byrg075yuzmQYc9BzeXRXB9ix52Cve
         p7jg5orHqQJgl50yERc9y60g/d52ItTkefZFPhE535sE7QtMF2lhBpOK0fMfSI4uM6lK
         LzTYLEjMl5pbOa3Wb1MZ0vJZKSErIi0M5SKQeziX7hYf/WFI+oCijXlfdiPNQ88YEpDz
         JeMqjkbh+AWpkg3bDxhzLtFr7/5UyehJ9OPh5cagKbuZD1+wgMkv+NhFIn4QrkEQRwT0
         8KBtIm5udSrDzqvLY3NtsMnzWP+urM1O2bgQcdXcg6cYIiLHTy+ARIfDfZvNCIrAJ1fo
         6+FA==
X-Gm-Message-State: AODbwcBvyCAEAWXMaT3Skv1CvZ/WoMQ/hqpneAZAudinHzxwqTizpPKx
        JcHUC8SH4yCT/uo5
X-Received: by 10.98.64.93 with SMTP id n90mr11580590pfa.96.1495218214144;
        Fri, 19 May 2017 11:23:34 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:65fb:32fd:2997:605f])
        by smtp.gmail.com with ESMTPSA id e76sm5490943pfb.92.2017.05.19.11.23.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 11:23:33 -0700 (PDT)
Date:   Fri, 19 May 2017 11:23:30 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net
Subject: Re: [PATCHv3 20/20] diff.c: color moved lines differently
Message-ID: <20170519112330.731ecc66@twelve2.svl.corp.google.com>
In-Reply-To: <20170518193746.486-21-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
        <20170518193746.486-1-sbeller@google.com>
        <20170518193746.486-21-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 May 2017 12:37:46 -0700
Stefan Beller <sbeller@google.com> wrote:

[snip]

> Instead this provides a dynamic programming greedy algorithm that

Not sure if this is called "dynamic programming".

> finds the largest moved hunk and then switches color to the
> alternative color for the next hunk. By doing this any permutation is
> recognized and displayed. That implies that there is no dedicated
> boundary or inside-hunk color, but instead we'll have just two colors
> alternating for hunks.

[snip]

I would title this "color moved blocks differently" to emphasize that we
are treating the moves in terms of blocks, not just lines.

The first part of the commit message could probably be written more
concisely, like the following:

  When a patch consists mostly of moving blocks of code around, it can
  be quite tedious to ensure that the blocks are moved verbatim, and not
  undesirably modified in the move. To that end, color blocks that are
  moved within the same patch differently. For example (OM, del, add,
  and NM are different colors):

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OM]  -        if (!is_authorized_user())
    [OM]  -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OM]  -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NM]  +        sensitive_stuff(spanning,
    [NM]  +                        multiple,
    [NM]  +                        lines);
    [NM]  +}

  Adjacent blocks are colored differently. For example, in this
  potentially malicious patch, the swapping of blocks can be spotted:

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OMA] -        if (!is_authorized_user())
    [OMA] -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OMA] -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NMA] +        sensitive_stuff(spanning,
    [NMA] +                        multiple,
    [NMA] +                        lines);
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NMA] +}

Having said that, thanks - this version is much more like what I would
expect.

> +static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
> +					 const struct buffered_patch_line *b,
> +					 const void *keydata)
> +{
> +	int ret;
> +	struct strbuf sba = STRBUF_INIT;
> +	struct strbuf sbb = STRBUF_INIT;
> +
> +	get_ws_cleaned_string(a, &sba);
> +	get_ws_cleaned_string(b, &sbb);
> +	ret = sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
> +	strbuf_release(&sba);
> +	strbuf_release(&sbb);
> +	return ret;
> +}
> +
> +static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
> +				   const struct buffered_patch_line *b,
> +				   const void *keydata)
> +{
> +	return a->len != b->len || strncmp(a->line, b->line, a->len);
> +}

Instead of having 2 versions of all the comparison functions, could the
ws-ness be passed as the keydata?

> +static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	if (ignore_ws) {
> +		strbuf_reset(&sb);
> +		get_ws_cleaned_string(line, &sb);

Memory leak here, I think.

> +		return memhash(sb.buf, sb.len);
> +	} else {
> +		return memhash(line->line, line->len);
> +	}
> +}

[snip]

> +static void add_lines_to_move_detection(struct diff_options *o)
> +{
> +	struct moved_entry *prev_line;

gcc says (rightly) that this must be initialized.

> +
> +	int n;
> +	for (n = 0; n < o->line_buffer_nr; n++) {
> +		int sign = 0;
> +		struct hashmap *hm;
> +		struct moved_entry *key;
> +
> +		switch (o->line_buffer[n].sign) {
> +		case '+':
> +			sign = '+';
> +			hm = o->added_lines;
> +			break;
> +		case '-':
> +			sign = '-';
> +			hm = o->deleted_lines;
> +			break;
> +		case ' ':
> +		default:
> +			prev_line = NULL;
> +			continue;
> +		}
> +
> +		key = prepare_entry(o, n);
> +		if (prev_line &&
> +		    prev_line->line->sign == sign)
> +			prev_line->next_line = key;
> +
> +		hashmap_add(hm, key);
> +		prev_line = key;
> +	}
> +}
> +
> +static void mark_color_as_moved(struct diff_options *o)
> +{
> +	struct moved_entry **pmb = NULL; /* potentially moved blocks */
> +	int pmb_nr = 0, pmb_alloc = 0;
> +	int alt_flag = 0;

Probably call this "use_alt_color" or something similar.

> +	int n;
> +
> +	for (n = 0; n < o->line_buffer_nr; n++) {
> +		struct hashmap *hm = NULL;
> +		struct moved_entry *key;
> +		struct moved_entry *match = NULL;
> +		struct buffered_patch_line *l = &o->line_buffer[n];
> +		int i, lp, rp;
> +
> +		switch (l->sign) {
> +		case '+':
> +			hm = o->deleted_lines;
> +			break;
> +		case '-':
> +			hm = o->added_lines;
> +			break;
> +		default:
> +			alt_flag = 0; /* reset to standard, no-alt move color */
> +			pmb_nr = 0; /* no running sets */
> +			continue;
> +		}
> +
> +		/* Check for any match to color it as a move. */
> +		key = prepare_entry(o, n);
> +		match = hashmap_get(hm, key, o);
> +		free(key);
> +		if (!match)
> +			continue;
> +
> +		/* Check any potential block runs, advance each or nullify */
> +		for (i = 0; i < pmb_nr; i++) {
> +			struct moved_entry *p = pmb[i];
> +			struct moved_entry *pnext = (p && p->next_line) ?
> +					p->next_line : NULL;
> +			if (pnext &&
> +			    !buffered_patch_line_cmp(pnext->line, l, o)) {
> +				pmb[i] = p->next_line;
> +			} else {
> +				pmb[i] = NULL;
> +			}

Memory leak of pmb[i] somewhere here?

> +		}
> +
> +		/* Shrink the set to the remaining runs */
> +		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
> +			while (lp < pmb_nr && pmb[lp])
> +				lp ++;
> +			/* lp points at the first NULL now */
> +
> +			while (rp > -1 && !pmb[rp])
> +				rp--;
> +			/* rp points at the last non-NULL */
> +
> +			if (lp < pmb_nr && rp > -1 && lp < rp) {
> +				pmb[lp] = pmb[rp];
> +				pmb[rp] = NULL;
> +				rp--;
> +				lp++;
> +			}
> +		}
> +
> +		if (rp > -1) {
> +			/* Remember the number of running sets */
> +			pmb_nr = rp + 1;
> +		} else {
> +			/* Toggle color */
> +			alt_flag = (alt_flag + 1) % 2;
> +
> +			/* Build up a new set */
> +			pmb_nr = 0;
> +			for (; match; match = hashmap_get_next(hm, match)) {
> +				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
> +				pmb[pmb_nr++] = match;
> +			}
> +		}
> +
> +		switch (l->sign) {
> +		case '+':
> +			l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
> +			break;
> +		case '-':
> +			l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
> +			break;
> +		default:
> +			die("BUG: we should have continued earlier?");
> +		}
> +	}
> +	free(pmb);
> +}

[snip]

> @@ -4874,6 +5114,11 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  
>  	if (o->use_buffer) {
> +		if (o->color_moved) {

Can you just declare the two hashmaps here, so that we do not need to
put them in o? They don't seem to be used outside this block anyway.

> +			add_lines_to_move_detection(o);
> +			mark_color_as_moved(o);
> +		}
> +
>  		for (i = 0; i < o->line_buffer_nr; i++)
>  			emit_buffered_patch_line(o, &o->line_buffer[i]); 

[snip]

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 289806d0c7..232d9ad55e 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh

As for the tests, also add a test checking the interaction with
whitespace highlighting, and a test showing that diff errors out if we
ask for both move coloring and word-by-word diffing.
