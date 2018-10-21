Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27A01F453
	for <e@80x24.org>; Sun, 21 Oct 2018 10:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJUSf3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 14:35:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44724 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJUSf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 14:35:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so5420842wrw.11
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=92GjzuGHcV+WDUQMG9VwRzXit46GjBJhOR8sH9iIT7M=;
        b=UOTWAZ7rRMbx/DPNvLAgeB4yVglUE9QFJCeFSypPxpmW2PXNTIRrNAKQ2PwvUlzj0V
         1asMLfSy3UYNayTXNF+7ryk0/nuUPuyjU2QXBFFz05FR8p3/RXAGv86w2lvCoD2xIY+t
         gfdOb4Bu/tjhn2WFjV7sLN4UjHmZuaSfVdq4haFjnsMociuNcqv3eZ5NXqWy6Eomfk3L
         2dYq3lxOOLwXFxneYmvixeQflhF6Cfy9GTu255N1Pv2fdkaUR+biKk/YOxNGDu3m9Qsx
         NK8/Wj1pwa1IB+WuOxNtIWqFCTbY28N5YAOaeSBmNHqcyMgmDNPXw/pcA+pKXt+43YmU
         AXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=92GjzuGHcV+WDUQMG9VwRzXit46GjBJhOR8sH9iIT7M=;
        b=StuD1putwX6MOJ5dn2yuyqezuP2geFFpYuefX9u2thvFdbHm6HrEF/ybMtAjtqZxIG
         7xQaca/tbcImM1lJnvcE/fYueFT6Bvg6deYFHuwBFLjRJX5TUeqXSxTJarEBHS0pRC2F
         sQza2Mvqqx7Qc0OXZAFVTk4T8BxNR0Lh9TmtwKSyGR7YsMSopsfdYpldEUC0UnJkUyDb
         JZcqc+E9CwIQuHUU+DvYLQ1qDpvh0YlgGetU3GEFnTzaUtHowkzQ77mNvHuOeeufUXRr
         +CG1wz36fwzK7JnUHh+zWTdYpyCaNN6qduLLCfFecfk+N7BnwAgeoH8wzRWe8e6KfOT2
         suuQ==
X-Gm-Message-State: ABuFfohP0RwwmvaYxembQzaSVIAYrG68v34gl4xrFdfUWM4kYXdXtFD7
        BiQLgIutzdU5uYEroSC4Zo2b+8tQ
X-Google-Smtp-Source: ACcGV61GVEQinnYnT3kEOjXLjZNpb5LcGpMbi29qh703grNlo8pQX7qPhtFlE2Ag1qACvU2Kfbc5hg==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr41716514wrq.0.1540117298256;
        Sun, 21 Oct 2018 03:21:38 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps207.neoplus.adsl.tpnet.pl. [83.8.60.207])
        by smtp.gmail.com with ESMTPSA id 77-v6sm17842651wmv.6.2018.10.21.03.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 03:21:37 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/7] test-reach: add rev-list tests
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <12a3f6d3670834f19b38f5e23ef83cdf80a58c33.1539729393.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Oct 2018 12:21:36 +0200
In-Reply-To: <12a3f6d3670834f19b38f5e23ef83cdf80a58c33.1539729393.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Oct 2018
        15:36:41 -0700 (PDT)")
Message-ID: <865zxvior3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The rev-list command is critical to Git's functionality. Ensure it
> works in the three commit-graph environments constructed in
> t6600-test-reach.sh. Here are a few important types of rev-list
> operations:
>
> * Basic: git rev-list --topo-order HEAD
> * Range: git rev-list --topo-order compare..HEAD
> * Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
> * Symmetric Difference: git rev-list --topo-order compare...HEAD

Could you remind us here which of those operations will be using
generation numbers after this patch series?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t6600-test-reach.sh | 84 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 9d65b8b946..288f703b7b 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -243,4 +243,88 @@ test_expect_success 'commit_contains:miss' '
>  	test_three_modes commit_contains --tag
>  '
>=20=20
> +test_expect_success 'rev-list: basic topo-order' '
> +	git rev-parse \
> +		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
> +		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
> +		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
> +		commit-6-3 commit-5-3 commit-4-3 commit-3-3 commit-2-3 commit-1-3 \
> +		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
> +		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
> +	>expect &&
> +	run_three_modes git rev-list --topo-order commit-6-6
> +'

I wonder if this test could be make easier to write and less error
prone, e.g. creating it from ASCII-art graphics.

But it is good enough.

[...]

--
Jakub Nar=C4=99bski
