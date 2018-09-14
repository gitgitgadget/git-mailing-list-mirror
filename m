Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B9F1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 17:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeINWzS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 18:55:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeINWzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 18:55:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so11399741wre.10
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6K6j4PRNeh8Zdk6+98mA1rP6FzdjovEmLFeOJByeg0k=;
        b=n+wR0BKm5h2CMYbrQo/v7qW6vSM4dii70/nM/VQcAcWSOv94f//QqC25JPaX/Xsj80
         /78P9tPXTvOmOm0x73hnXofRF8qxm1YH1rUwNafZbkHGcehg1d+KIV6fvU/g33Gi/uXf
         1/dS+8PlCnZg7ACtDazkDeC8EtYXnQFtOkMtIhQCPMgXluhUAZLfuyGTypEzs3lL+jY7
         GUtnomoMDNFyphXw6W3IK2vcWCV+UxsElFW4Ozjmvn/U18TtaY+YLxi9f3eL+fQT7Bs/
         wYk6WSQ5EQ9Dp0D78cKvuqTlUTM4uU9bugo2BXkjRz1Ms2ljLzquf6bEiqQNMswUEb+z
         sGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6K6j4PRNeh8Zdk6+98mA1rP6FzdjovEmLFeOJByeg0k=;
        b=CBCeej/DwKIXZxQfxnMe9fffYhwMwtK9/0hiMfjxJoMeOivNF0dRcLjQPxFgY7SxM3
         jOh0zz8PIVG4IryhKyVPeyYtzareuAmS+/UD/RXpQ55vQXuDAa4mR4BU/OTT8XD9CmEF
         IanYi2kSJHxp8ntG9lu0etqsSX8tALUVjCrF3aZUOp1mDPwGC6dgRD7CTagfd7D17Vs1
         nmv20vD81YIesr2/qN3awPT5K/qrfd6btb4qUCyJtxSgUD7tqbkFB4EJm6SfokSCWG0Z
         6VO16vBbednz+dSgNx8xIrkUVmzWPHuvK2HA9HspemtkL1+dtQCF4kCZQSb0bX4ga6Re
         ls4A==
X-Gm-Message-State: APzg51C+Hbb+SzvGKBF06Sgc5ptBhRo2X7+9Nvd7IFmXBo2L/B4Nf9Ae
        LABpIpaItP07Bxl5is2Gy7p0A4hA
X-Google-Smtp-Source: ANB0VdYttm9+XiQwyEsKl6O5QfmahEoDZNt/EUOCe84c1ypHP8sgZB5DliDL7lXKhqDplqpzhBf65g==
X-Received: by 2002:adf:9503:: with SMTP id 3-v6mr1509343wrs.251.1536946785543;
        Fri, 14 Sep 2018 10:39:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm16392871wrd.71.2018.09.14.10.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:39:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v8 7/7] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536885967.git.matvore@google.com>
        <edba3791caf8bacc2f722f7874369f6776ecffe0.1536885967.git.matvore@google.com>
Date:   Fri, 14 Sep 2018 10:39:44 -0700
In-Reply-To: <edba3791caf8bacc2f722f7874369f6776ecffe0.1536885967.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 13 Sep 2018 17:55:27 -0700")
Message-ID: <xmqqr2hwasgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index c0e2bd6a0..14f251de4 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -50,6 +50,20 @@ static int gently_parse_list_objects_filter(
>  			return 0;
>  		}
>  
> +	} else if (skip_prefix(arg, "tree:", &v0)) {
> +		unsigned long depth;
> +		if (!git_parse_ulong(v0, &depth) || depth != 0) {
> +			if (errbuf) {
> +				strbuf_init(errbuf, 0);
> +				strbuf_addstr(
> +					errbuf,
> +					_("only 'tree:0' is supported"));

This is not a new issue with this patch, but I think strbuf_init()
at the location of filling done like this is a bad idea.  If the
caller gave you an errbuf that is pre-filled with something, we'd
leak memory and lose information.  It only makes sense to _init() if
the caller gave us an uninitialized garbage (or a strbuf that has
just been initialized and is empty).  

The existing callers seem to do STRBUF_INIT before passing it to
this function, so we probably should not do strbuf_init() here (and
other two places in this function) and simply add to it.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index bbbe7537d..8eeb85fbc 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -154,6 +154,44 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
>  	grep "git index-pack.*--fsck-objects" trace
>  '
>  
> +test_expect_success 'use fsck before and after manually fetching a missing subtree' '
> +	# push new commit so server has a subtree
> +	mkdir src/dir &&
> +	echo "in dir" >src/dir/file.txt &&
> +	git -C src add dir/file.txt &&
> +	git -C src commit -m "file in dir" &&
> +	git -C src push -u srv master &&
> +	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
> +
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
> +	git -C dst fsck &&
> +
> +	# Make sure we only have commits, and all trees and blobs are missing.
> +	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> +	awk -f print_1.awk fetched_objects \
> +		| xargs -n1 git -C dst cat-file -t >fetched_types &&

Break line after pipe "|", not before, and lose the backslash.  You
do not need to over-indent the command on the downstream of the
pipe, i.e.

	awk ... |
	xargs -n1 git -C ... &&

Same comment applies elsewhere in this patch, not limited to this file.

> +	sort fetched_types -u >unique_types.observed &&

Make it a habit not to add dashed options after real arguments, i.e.

	sort -u fetched_types

> +	echo commit >unique_types.expected &&
> +	test_cmp unique_types.observed unique_types.expected &&

Always compare "expect" with "actual", not in the reverse order, i.e.

	test_cmp expect actual

not

	test_cmp actual expect

This is important because test_cmp reports failures by showing you
an output of "diff expect actual" and from "sh t5616-part*.sh -v"
you can see what additional/excess things were produced by the test
over what is expected, prefixed with "+", and what your code failed
to produce are shown prefixed with "-".

Thanks.

