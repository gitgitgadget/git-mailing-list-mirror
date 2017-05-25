Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FB520209
	for <e@80x24.org>; Thu, 25 May 2017 02:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbdEYC1Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 22:27:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33507 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbdEYC1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 22:27:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so35942138pfe.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d32UC/LXskRsSEjDQfh8uoUr3BICj9f6t5Rq/E1Mdio=;
        b=Scc4YVP9tBYd+Y2U++Diu4IpUAj0ALx4UnMHBtMBpCPzBguJoYXradnM+fyOjx+0wo
         akuAdLzrLITBGYiGHPrYRF2cdEaJ0waHWcSy7xC9TYqPi0CzSezIns/Dkpfma3TagpjO
         BHAaBGRld9W6+anZMP2qRLZ7FF1C6Ddq2u/SyRmxIhW599U1E5fnHBw/ZBSzr3x5CLeb
         vIVfSUIeC+jT1pWH9zDIIRRQFpNqFrilud5Apozrp/RsZwIGB98G1nTJ1hDwbkN/DyYA
         ZIMZH8bpgpOnVVLL4U1tc3zN7ZVpODTy3kFKmcy2vUIzrBjTfLionMWf5jykcFi7RQ38
         pHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d32UC/LXskRsSEjDQfh8uoUr3BICj9f6t5Rq/E1Mdio=;
        b=n92+PZ5lKhmglseoI/oaw+9aVsdWZM1c2x92W0SwTPLRMcchTo4aUXK1EnQWop76K6
         Inb4K21W0mEAAlrebxsgZ0ePSgLsrzFjOn2hGiwmAiNOZiamiafkL3e7l5Y5hJuuXIIw
         SkKTaLlekZmv0S/weqcTpSYzrovZZHfTELhnN08YcOKA4OBFyoXVWg7imPraeIyMApYz
         BxFPkewK73UvXN7fxzuhZhklGTIB1wvRWlCqG3vAbwgmfYyvj1zYrHjCbSj9keieWjV9
         Sd0IYNVGOFywzbczSLIGedYdhzi2LzVjd6Bt6V2VhuNCihd0rZr7hoPPZ07vO99fDCg9
         Xi0Q==
X-Gm-Message-State: AODbwcD9zu79PPEs7N84peZSRk93yihEsxHNXAs1v1wgCElT0uRO9kfY
        49dZS6Muwb5/Yg==
X-Received: by 10.98.69.193 with SMTP id n62mr42692271pfi.216.1495679241371;
        Wed, 24 May 2017 19:27:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id s18sm9954550pfi.16.2017.05.24.19.27.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 19:27:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv5 17/17] diff.c: color moved lines differently
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-18-sbeller@google.com>
Date:   Thu, 25 May 2017 11:27:20 +0900
In-Reply-To: <20170524214036.29623-18-sbeller@google.com> (Stefan Beller's
        message of "Wed, 24 May 2017 14:40:36 -0700")
Message-ID: <xmqqk255fz7b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a patch consists mostly of moving blocks of code around, it can
> be quite tedious to ensure that the blocks are moved verbatim, and not
> ...
> cases. This leads to another thought: We could pass on '--color-moved' to
> submodules such that they color up moved lines for themselves. If we'd do
> so only line moves within a repository boundary are marked up.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> # Conflicts:
> #	diff.c
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Hmph, what are these final lines about?
