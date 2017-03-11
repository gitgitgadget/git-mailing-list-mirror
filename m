Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D5F9201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 20:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934077AbdCKUCC (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 15:02:02 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:34997 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbdCKUBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 15:01:52 -0500
Received: by mail-it0-f48.google.com with SMTP id m27so12483912iti.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 12:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ytYyERK3Ki9MLagrdI0MGEwNpXIOss6GlIcxRNrGwLM=;
        b=MptCBGvZgSxRQNKhf7mj4S9mIEN8kekutOVetOfbsMl7DDw1Qn+jhAWmymcoqIL+I4
         F7V6EnuxS/GriJDqLV5ULnEaO4EdoicIOr6fLzrNkOPaiPiGyBLxVM4xskgKiDkuBZkD
         0I1TmF1gb+uxpv5StE11t/7LFWcM1e0g5n6nHxWT7/CICIK+LFhpuzdnVSKSAIjZwsMP
         eivNnmZobz8lUnenc2xINbzJs9Lc7D2CUHhuc2DNKsqsKifMvvgy4seKC+RePy4BOaSz
         WPYXP3KglsUhUVv3aKxIj2Rul/zuLtrb8o9iaUvjyauOnCVpgk507UR6mVLFo1ip0lhk
         ixPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ytYyERK3Ki9MLagrdI0MGEwNpXIOss6GlIcxRNrGwLM=;
        b=fR0EPI9iQYQ2sgg747qwpfrWhw/aDpq+KU1TEqu/F/r5rmPH+UMx2d4uI1lOr7+Vfw
         fr1le0Kt8HG8KYajoJ+XC2xzOC2Dk+d4N8FVxVgYW5l5dXrZpKQD1vs9R1ik5WG0bJb7
         dc59bkQCtTqIW8pZcnBIw3KougzVnP8fsZnEN0+GkkSKAuAimT9GrcLmoSe2qouHhstO
         H7nuzAnxfBaSCzBXMZYJtI4k/BatccichnqO+0sVkqoZthFYegWnwgFHjoeTMeIEhlJx
         6BgobEzM2IY3T5TdH/D/QnzXzgs4MW7Tb49C4SaYSyhkaaneYrMS2i+w73yTL1k5iRbf
         mMVw==
X-Gm-Message-State: AFeK/H30QKuZqOuRuQ6to98aqbmez6pbCtW+g/D1wz4wwX4Zw2XERXCp0GRz77njTpyggiLXSO261Csvuqkfrw==
X-Received: by 10.36.93.213 with SMTP id w204mr5038093ita.60.1489262505798;
 Sat, 11 Mar 2017 12:01:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 12:01:25 -0800 (PST)
In-Reply-To: <20170309132949.shyc4gmdrhazykev@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net> <20170309132949.shyc4gmdrhazykev@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 21:01:25 +0100
Message-ID: <CACBZZX5A46-ua9y_HxqrqycQviR0uGnStnaPwH9jukzPVak6ug@mail.gmail.com>
Subject: Re: [PATCH 4/4] ref-filter: use separate cache for contains_tag_algo
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 2:29 PM, Jeff King <peff@peff.net> wrote:
> [...]
> @@ -1874,6 +1886,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>                 broken = 1;
>         filter->kind = type & FILTER_REFS_KIND_MASK;
>
> +       init_contains_cache(&ref_cbdata.contains_cache);
> +
>         /*  Simple per-ref filtering */
> [...]
>
> +       clear_contains_cache(&ref_cbdata.contains_cache);
>
>         /*  Filters that need revision walking */
>         if (filter->merge_commit)

Shouldn't both of those be guarded by a "if (filter->with_commit)" test?

That init/clear codepath is rather light, but it seems to me that we
can avoid it entirely if filter->with_commit isn't defined. I've
tested this locally and it still passes all tests.
