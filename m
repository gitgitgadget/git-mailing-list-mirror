Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9698E1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 12:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405812AbfJQMam (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:30:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40471 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfJQMam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:30:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so3254284qte.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJ8Oe01eRYbcsfWzZmyZLdt4XCgtD14eDiiJ45tf5GI=;
        b=V66ewJr78x8Snsaq6r2XCQEnP2nWRtaiiViqYhK8J2Il1Dp9xmTA0N4ndZV9m6++jm
         7OFJ9QUdYgBi9F11HIOAAQQRwH2hHUlSyHoeyrOstzEqTo/7Tt6kNIJs1N732L813YoT
         TT4B6hrFfT43FRHAN7PTxP+8hU7U2aAb+wt4EU8hTKJsjQo/Y0gWYqzoLTfP5lAWwuDL
         ZicppoAEpg6F+vU1cvqYDFo7GF6C13my65ZJitSa4JrBiORmLCRerNDhD3//ytC+PRDa
         BCvjRrFcFTWhrnMBE5bmwQ8wE0fIt/bHj0X7YYIGPzm5DlMzcsoERwjmMz8EDbZnQ4Nd
         c8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJ8Oe01eRYbcsfWzZmyZLdt4XCgtD14eDiiJ45tf5GI=;
        b=WhuMEjZWx3/zjbO2fJwHOZL/kfhwk1y2dW6qCJJs5s2RO3weAavoph0GKqfuHgteAP
         3MosF7mdC3NuH+ZiZ63ATtmGb0AnuIbJpaXPCUpruWV/+wioEqcpJYLyR8Sxg1jrpjAp
         3LJ8Jh2IM3tS5mQ6f7BIwhs6bLJC7VAh9cSbAGJQyJQP5+s4rCYU7GCEVadABTts2yJJ
         GTusFc1mA4ixyRciezovNBWa8YzgGZzeSOsFK2AFDWD4E9mQatPKl1+IIN669PQiK1ju
         Ba2Px/FOVW6ypnqYEvtkVPe41MXvbcGisOlQOm/7rFBlnjh2Z3zS22JpsVplH7FpbZjK
         U7og==
X-Gm-Message-State: APjAAAXuwqpLcHMKkBcPPv6dTNSjwXXGWw9bF7nwjVIJ8f+4/grJqMCL
        etE3CH24rUyB5BRQPbkZPis=
X-Google-Smtp-Source: APXvYqzO7nPZ1htrIFeOiGFI26rH6ZnwUVciK+xqIxcX2QUSmOK0EM1gQg6YWVRuHvzjKnJje/DnSg==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr3434829qtr.169.1571315441468;
        Thu, 17 Oct 2019 05:30:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bc90:dbe5:6d1f:a2b3? ([2001:4898:a800:1010:6dc6:dbe5:6d1f:a2b3])
        by smtp.gmail.com with ESMTPSA id p3sm882078qkm.52.2019.10.17.05.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:30:40 -0700 (PDT)
Subject: Re: [PATCH v3 07/13] graph: example of graph output that can be
 simplified
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
 <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
 <631ee3cecb68d9f776d4a8fb30c1bca70797ba14.1571183279.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3dfddde2-05e9-01ca-2ce8-d504f49b72bc@gmail.com>
Date:   Thu, 17 Oct 2019 08:30:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <631ee3cecb68d9f776d4a8fb30c1bca70797ba14.1571183279.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2019 7:47 PM, James Coglan via GitGitGadget wrote:
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> new file mode 100755
> index 0000000000..4582ba066a
> --- /dev/null
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +
> +test_description='git log --graph of skewed merges'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
> +	cat >expect <<-\EOF &&
> +	*   H
> +	|\
> +	| *   G
> +	| |\
> +	| | * F
> +	| | |
> +	| |  \
> +	| *-. \   E
> +	| |\ \ \
> +	|/ / / /
> +	| | | /
> +	| | |/
> +	| | * D
> +	| * | C
> +	| |/
> +	* | B
> +	|/
> +	* A
> +	EOF

Thanks for adding this test! I really think it helps show some
of your improvements later as this test is mutated.

-Stolee

> +
> +	git checkout --orphan _p &&
> +	test_commit A &&
> +	test_commit B &&
> +	git checkout -b _q @^ && test_commit C &&
> +	git checkout -b _r @^ && test_commit D &&
> +	git checkout _p && git merge --no-ff _q _r -m E &&
> +	git checkout _r && test_commit F &&
> +	git checkout _p && git merge --no-ff _r -m G &&
> +	git checkout @^^ && git merge --no-ff _p -m H &&
> +
> +	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> 

