Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66421F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeDXWfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:35:17 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36866 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDXWfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:16 -0400
Received: by mail-pf0-f182.google.com with SMTP id p6so13449891pfn.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9rdBnJ6uNeSscJh7bwODwyrtAg2kKq3Ogv/CCtvS5Y=;
        b=TmCGN5YLIhquuqhRKunV2rWt5mTjtdpfV+xqRa/GFKd+xLB7k49XerbIDFtwAttdLc
         hfA8skB2H3cCgW0MUe3EOJLM+sDnDJKFA9Z9r16eCOapc0IS5qgu66JYwp2SZK7wJJh0
         1pVKtDm/4ihxn96w5uJwB8G1/FLYforvUhn+D/Lo/xOv6721lVuPLviAk/JQNhXe6nqV
         o49mPxU5XqJbxRKZ/QUwAGrcQqfAjJW83g+55ZJcbsLV9Zs4I8ebyGISBvs+hEedRzBL
         jDo9dRGzI8MoApLtDfD9jAviyHnh0UPFbjxEBPOQXJ7WsrI9dL5O6vCdjMOR9TlHoED8
         vnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9rdBnJ6uNeSscJh7bwODwyrtAg2kKq3Ogv/CCtvS5Y=;
        b=GGMcUDw8dhMqNvaZS+Wl0u4c4/mW3Gp1iN/ZceSsbmV/bInSshTdV5Ri6WaDSQYxFu
         DXwk/yfFYXtn53O1zCXqaiaHWpzFFthSTSxyO4H+XE025pr75uhBdgLaP56/BeYF8yV9
         RGYw6Ow1BiimaJxgZG9ncEN1gyRrqXb6B8y1DoVIy9uFY0mL0/3MhCMiOORR/G8LBG2z
         JINL4vBIUAPpbVmZrx7lmWd9pzQ1fmNuCtIkyKZLmuyAAO337gzbAA1UvpY2NiTr8mHc
         rWkaNVu3OzFRrDV/CZAKqJDUpYp3atP0Ps2lihFJbKkGuAIX0Df6SP5YqlOgNFfpob9T
         Lkug==
X-Gm-Message-State: ALQs6tBixjPUkhR3TnwYd/PFcmMt4lwgCpc1p3RJocbg0MiAA2kDWKk0
        PBDT98VgOSbc0LUQ1uBT824JBH+K9Jw=
X-Google-Smtp-Source: AIpwx4/OUVgy+boerTT20Bs/im7SdzWeaxNMzrnSqG2EzDMKdGTgYA4wAaOY3HUqQlaap/v8ZpqLLQ==
X-Received: by 10.99.115.69 with SMTP id d5mr21380585pgn.289.1524609315515;
        Tue, 24 Apr 2018 15:35:15 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 65sm23468818pft.74.2018.04.24.15.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 15:35:14 -0700 (PDT)
Date:   Tue, 24 Apr 2018 15:35:13 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Message-Id: <20180424153513.dc2404cd111c44ac78bd8ed8@google.com>
In-Reply-To: <20180424210330.87861-8-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
        <20180424210330.87861-8-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 14:03:30 -0700
Stefan Beller <sbeller@google.com> wrote:

> +--color-moved-[no-]ignore-space-prefix-delta::
> +	Ignores whitespace when comparing lines when performing the move
> +	detection for --color-moved. This ignores uniform differences
> +	of white space at the beginning lines in moved blocks.

Setting this option means that moved lines may be indented or dedented,
and if they have been indented or dedented by the same amount, they are
still considered to be the same block. Maybe call this
--color-moved-allow-indentation-change.

> +struct ws_delta {
> +	char *string; /* The prefix delta, which is the same in the block */

Probably better described as "the difference between the '-' line and
the '+' line". This may be the empty string if there is no difference.

> +	int direction; /* adding or removing the line? */

What is the value when "added" and what when "removed"? Also, it is not
truly "added" or "removed", so a better way might be: 1 if the '-' line
is longer than the '+' line, and 0 otherwise. (And make sure that the
documentation is correct with respect to equal lines.)

> +	int missmatch; /* in the remainder */

s/missmatch/mismatch/
Also, what is this used for?

> +	if (diffopt->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES)
> +		/*
> +		 * As there is not specific white space config given,
> +		 * we'd need to check for a new block, so ignore all
> +		 * white space. The setup of the white space
> +		 * configuration for the next block is done else where
> +		 */
> +		flags |= XDF_IGNORE_WHITESPACE;
> +
>  	return !xdiff_compare_lines(a->es->line, a->es->len,
>  				    b->es->line, b->es->len,
>  				    flags);

I wrote in [1]:

  I think we should just prohibit combining this with any of the
  whitespace ignoring flags except for the space-at-eol one. They seem
  to contradict anyway.

To elaborate, adding a specific flag that may interfere with other
user-provided flags sounds like we're unnecessarily adding combinations
that we must keep track of, and that it's both logical (from a user's
point of view) and clearer (as for the code) to just forbid such
combinations.

[1] https://public-inbox.org/git/20180402174118.d204ec0d4b9d2fa7ebd77739@google.com/

>  	struct moved_entry **pmb = NULL; /* potentially moved blocks */
>  	int pmb_nr = 0, pmb_alloc = 0;
> -	int n, flipped_block = 1, block_length = 0;
>  
> +	struct ws_delta *wsd = NULL; /* white space deltas between pmb */
> +	int wsd_alloc = 0;
> +
> +	int n, flipped_block = 1, block_length = 0;

It seems like pmb and wsd are parallel arrays - could each wsd be
embedded into the corresponding entry of pmb instead?

> --- a/diff.h
> +++ b/diff.h
> @@ -214,6 +214,8 @@ struct diff_options {
>  	} color_moved;
>  	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>  	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
> +	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
> +	#define COLOR_MOVED_DELTA_WHITESPACES	(1 << 22)
>  	int color_moved_ws_handling;
>  };

Setting of DELTA_WHITESPACES should be a separate field, not as part of
ws_handling. It's fine for the ws_handling to be a bitset, since that's
how it's passed to xdiff_compare_lines(), but we don't need to do the
same for DELTA_WHITESPACES.

> +test_expect_success 'compare whitespace delta across moved blocks' '
> +
> +	git reset --hard &&
> +	q_to_tab <<-\EOF >text.txt &&
> +	QIndented
> +	QText across
> +	Qthree lines
> +	QBut! <- this stands out
> +	Qthis one
> +	QQline did
> +	Qnot adjust
> +	EOF
> +
> +	git add text.txt &&
> +	git commit -m "add text.txt" &&
> +
> +	q_to_tab <<-\EOF >text.txt &&
> +	QQIndented
> +	QQText across
> +	QQthree lines
> +	QQQBut! <- this stands out
> +	this one
> +	Qline did
> +	not adjust
> +	EOF
> +
> +	git diff --color --color-moved-ignore-space-prefix-delta |
> +		grep -v "index" |
> +		test_decode_color >actual &&
> +
> +	q_to_tab <<-\EOF >expected &&
> +		<BOLD>diff --git a/text.txt b/text.txt<RESET>
> +		<BOLD>--- a/text.txt<RESET>
> +		<BOLD>+++ b/text.txt<RESET>
> +		<CYAN>@@ -1,7 +1,7 @@<RESET>
> +		<RED>-QIndented<RESET>
> +		<RED>-QText across<RESET>
> +		<RED>-Qthree lines<RESET>
> +		<RED>-QBut! <- this stands out<RESET>
> +		<RED>-Qthis one<RESET>
> +		<RED>-QQline did<RESET>
> +		<RED>-Qnot adjust<RESET>
> +		<GREEN>+<RESET>QQ<GREEN>Indented<RESET>
> +		<GREEN>+<RESET>QQ<GREEN>Text across<RESET>
> +		<GREEN>+<RESET>QQ<GREEN>three lines<RESET>
> +		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
> +		<GREEN>+<RESET><GREEN>this one<RESET>
> +		<GREEN>+<RESET>Q<GREEN>line did<RESET>
> +		<GREEN>+<RESET><GREEN>not adjust<RESET>
> +	EOF
> +
> +	test_cmp expected actual
> +'

I would have expected every line except the "this stands out" line to be
colored differently than the usual RED and GREEN. Is this test output
expected?
