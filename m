Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A4620D11
	for <e@80x24.org>; Tue, 13 Jun 2017 12:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbdFMM7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:59:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35211 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdFMM7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:59:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so18661218pgc.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CN28bYAf/Jk59K3BV177qncuKmX+hrvAIDx/kpx4Ims=;
        b=QIGmKKLenbb/k3LKWCbiJi7TJN+1QUKnlVqpQJQK5K27rlbtLQi5vohIZGxLx78J5A
         PkKZwNYPnSqjXQqEyYY7h1KhrlwRwLX5dC8AI0xjqiG64/HwOPyyv2HmbqVp04PbmsMn
         /kEa2irB4kkzS15dpYZwyQDmdo/0RAoZ8+wlN9eRGKKpqDfwIR6BkK1aTPISkEfV47pM
         tBWdJtWlHZDuujtrYDNDDf+cnrEfjhyYSkIUTcbJ0VCE5Gv1EoQYND4fHatJlrPhQ3Zp
         BPGlicJ/R6Vb1FXjBKvp6QSGwqeHBVbYKQkX8u2fEtradUNdpxIyfJ8HGRdd5zlIjhZO
         Q8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CN28bYAf/Jk59K3BV177qncuKmX+hrvAIDx/kpx4Ims=;
        b=G9Mv5Ybjt2jFcITHoX3Q5Z9o91IAVMAUlBksgPPp2chAxXBDZMu8PKpLcOXPTQIMUO
         MJhptPSdIGza+OIeihQLEQz4Ym0wGl0ShPyqFkLLJLoZpJnkzxcmj8bDuVcPUW2TWFwl
         eJcqwgSbHasZD4lOWccXNmMHbV8srZPnDivtpz1Mbr/SZpcxrpSl2tAESOtObzMUtbzV
         SgNnjQAxmaXIb8h1OBeCJQR2VFqH8kYSyeQWoTPaeQXqH13ryCAHe1nalNFuTPMMBUEx
         5iFhktneGlxaFBHrnpEETc1bDp9X6rYvVAcHT8tgAWJZQX4LDT/uokhi86QYouuf4w2O
         CCDw==
X-Gm-Message-State: AODbwcAyhGZlJIEB+TlgF2bWgT4jW4PQ5PymRv3YzEwpp97E9VfvvCGK
        itxKcArwVsSiVMYijI8=
X-Received: by 10.84.241.132 with SMTP id b4mr63345505pll.107.1497358748080;
        Tue, 13 Jun 2017 05:59:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id x30sm27418773pge.23.2017.06.13.05.59.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 05:59:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/8] t1308: relax the test verifying that empty alias values are disallowed
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
        <b9e212d508e9103037da2070cc0aaed530ea7473.1496951503.git.johannes.schindelin@gmx.de>
        <xmqq37b84g9t.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706131244150.171564@virtualbox>
Date:   Tue, 13 Jun 2017 05:59:06 -0700
In-Reply-To: <alpine.DEB.2.21.1.1706131244150.171564@virtualbox> (Johannes
        Schindelin's message of "Tue, 13 Jun 2017 12:50:16 +0200 (CEST)")
Message-ID: <xmqq8tkw9h7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sadly, I do not think so. It is just different, not better. Maybe less
> redundant... See for yourself:

Yup, I noticed and was referring to this "less redundant" as an
improvement, actually.

> The real fix would indeed be (as mentioned by Brandon elsewhere) to unify
> the code paths between the cached and the non-cached config machinery, so
> as to provide the exact same error message in this case.

Yeah, the unifying of the messages would be a good addition in the
mid term but I tend to agree that it can be done after this series
lands.

Thanks for clarification.
