Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE901F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfAWX7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:59:39 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52823 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAWX7j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:59:39 -0500
Received: by mail-vs1-f74.google.com with SMTP id a82so1482736vsd.19
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yFJIbwypQcl0LI42nlWlOOdlqzyepB6irP3VdBzYFYw=;
        b=DIBoIrp+Mo3pbsQBbfpwUaYpUK6tYdh/B/d34PcxYOJloqxdOtJm0O8fGcK1BRngAn
         aAsyHw70JjxfxZFJnFwq74NcvVP6FDQArk6QM1dQ8lfk05ckoQbXonpOaVnFrd6uJ5kb
         j+YvNLCzanEGfHxUOB5TPlzSEB7uPmH4jE9WQHKDnlfxoymhk2aiDbEXyFjqIBiFfRUx
         ZpIY9EM4FdL5z2j74kkA8W95Gk1YePS8Ntb8JcaTitSQx90UrKNr80h/268igH45yiWX
         9jlgrSTRT1Y5nz6dubUUp6mP+wZJFaR5OYh4AmIYn+E14IuvaU3cJKBGZ5Mx0VA5hQ/x
         ANoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yFJIbwypQcl0LI42nlWlOOdlqzyepB6irP3VdBzYFYw=;
        b=Qk8dPCw9J9Cn67zmI7kfXJcYvmqXGQHKlHYps+GRFY9cBflHpSsDsad0tg5HeYV9z7
         RAesaRPiBjuHime5Yif3BC5y4LoMgjzYLk2kCMJlOHiJOP/AI75sUA4sO5D1GlyJyj/c
         o9jccRLEaHDaLZa3HhfNxZtFY9iIHlcbav8fqAcGYUcvim5KPREfP+SNTCSgeAQXWMyf
         oMhAt+NZLNumPr84lBoMQmZFyyarrXqexFYrA6+NrOboQsa7fYxplRxVH6O/w0Le1T8v
         OzN+qx+w6k95O6kphj+sL6+yKRilPPnIHeo0WW8Mr/UMaouY2onLzm5j/9QBS/u0xQll
         tgtA==
X-Gm-Message-State: AJcUuke2G8xu0Uc2BPh4Rx8KKAyw350ZaHc2u7CZB+OolLQdnl53RWTe
        /pD1NWXxg3/fnMZ4lq0scDqqy0kR9wwAlsJm+qJZ
X-Google-Smtp-Source: ALg8bN5hCqJpNIFwaXN95UrhxcKW+zxLhei3tLzU+42zcGbhpFbF3AOBlL6BOOnNjQ47DVcxWlSZbmLGDKBcNB9WSxeB
X-Received: by 2002:a1f:3cc9:: with SMTP id j192mr3396411vka.22.1548287977707;
 Wed, 23 Jan 2019 15:59:37 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:59:33 -0800
In-Reply-To: <693900b4c5af9adb98d98549b9340ad9f9d09562.1548280754.git.gitgitgadget@gmail.com>
Message-Id: <20190123235933.185949-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <693900b4c5af9adb98d98549b9340ad9f9d09562.1548280754.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 6/6] commit-graph: test verifying a corrupt v2 header
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The commit-graph file format v2 changes the v1 data only in the
> header information. Add tests that check the 'verify' subcommand
> catches corruption in the v2 header.

Ah, I should have read this patch before I wrote [1]. I think the commit
message of that patch should contain a note that verification of the v2
file format is done in a subsequent patch.

With or without that additional note, this series looks good to me.

[1] https://public-inbox.org/git/20190123235630.183779-1-jonathantanmy@google.com/

> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t5318-commit-graph.sh | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 3ff5e3b48d..be7bbf911a 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -497,6 +497,37 @@ test_expect_success 'git fsck (checks commit-graph)' '
>  	test_must_fail git fsck
>  '
>  
> +test_expect_success 'rewrite commmit-graph with version 2' '
> +	rm -f .git/objects/info/commit-graph &&
> +	git commit-graph write --reachable --version=2 &&
> +	git commit-graph verify
> +'
> +
> +GRAPH_BYTE_CHUNK_COUNT=5
> +GRAPH_BYTE_REACH_INDEX=6
> +GRAPH_BYTE_UNUSED=7
> +GRAPH_BYTE_HASH=8
> +
> +test_expect_success 'detect low chunk count (v2)' '
> +	corrupt_graph_and_verify $GRAPH_CHUNK_COUNT "\02" \
> +		"missing the .* chunk"
> +'
> +
> +test_expect_success 'detect incorrect reachability index' '
> +	corrupt_graph_and_verify $GRAPH_REACH_INDEX "\03" \
> +		"reachability index version"
> +'
> +
> +test_expect_success 'detect non-zero unused byte' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_UNUSED "\01" \
> +		"unsupported value"
> +'
> +
> +test_expect_success 'detect bad hash version (v2)' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\00" \
> +		"hash algorithm"
> +'
> +
>  test_expect_success 'setup non-the_repository tests' '
>  	rm -rf repo &&
>  	git init repo &&
> -- 
> gitgitgadget
