Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A198F1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 12:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeIEQhq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 12:37:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38454 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIEQhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 12:37:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so7687062qtk.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bexVgiVvMNxXM/HPfUm2EVwTA6siEsg0OLQtx/v3P/8=;
        b=NF48VHfFgw+gGFQ5VQBuYHjy9jreVn1/d8D//zU69u129nVEyQyqDLA7DAfEZYRAws
         axdpHGFnBCPBrDfSaRdaDQXt9Tl89d+dixhX3tvBhHjFVyMafBFg7lr2RszRtljI4F6K
         RINO3jiAaoYF+e5PVlqBRW6rrgTQLgiya9w/AdW2qa7xzzot1Nfa7wWBOQy5CAVhC3SQ
         LXdl8eSAKOjEkSpYC0YOTfibnG/KQtjjKrTp8TkzxjZRcm5bx2NU0iwcivzSE9yIkPiK
         dyIviPS/M4zA2xpzcbdAu1Qt51BW+zE4T+Czp57iHCYg1yPofl1BJhZjrHU9AXsTYSI7
         H3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bexVgiVvMNxXM/HPfUm2EVwTA6siEsg0OLQtx/v3P/8=;
        b=g3LBBpwY+awUZddQo/N9XTttFm7FWJ91t5yJSmeH2/HzDDonpPHXhLhk+hvMWCbVOF
         9mCpotqgHs7OrBN8htXBNesCz3oMUIJ6lJxsQXy18S6V1QEmbhbO6X6Fn6gzKyCJ4mKM
         I/FyTBrxrKm8zOBqCQD3Za1yOVGm69EZObF0F5vF0jjdVodPqvxR4wxiVtLTTzZ5yqV8
         6PmtHt268dwbLN1YDs5e+WmPpJk02LObxPryhOkNEEFgPybSO1Rcs4ZRxy87h3Os+LnW
         KHqlwRVbC/DRl7po46h01vS8wppCe/IM8nIooOFjoqHkBfILzqXGhwMb+hULekaXyBBu
         oupg==
X-Gm-Message-State: APzg51CE/kJK5OeqHuFwUBOTowYerVkb2HwAlPJfdUCe6wjfsLNaldAw
        2CDzrCtTF868Rd8vX5r85UE=
X-Google-Smtp-Source: ANB0VdY4Z7mJhJaHLtONzkP+69eTWXQPB0UsM5fMuShRmTJ4Nuf+4TqPBkp/zTNGud/fFv9ro0vEkA==
X-Received: by 2002:ac8:5191:: with SMTP id c17-v6mr4180870qtn.35.1536149267643;
        Wed, 05 Sep 2018 05:07:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:846:acea:77a8:94b8? ([2001:4898:8010:0:f17b:acea:77a8:94b8])
        by smtp.gmail.com with ESMTPSA id 127-v6sm837087qke.94.2018.09.05.05.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:07:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] commit-graph: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180904202729.13900-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5cf4d777-2536-cd6d-cc61-4671757306c1@gmail.com>
Date:   Wed, 5 Sep 2018 08:07:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180904202729.13900-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2018 4:27 PM, Ævar Arnfjörð Bjarmason wrote:
> This series adds progress output to the commit-graph command, so that
> when it's called by "git gc" or "git fsck" we can see what's going on
> with it.
>
> Ævar Arnfjörð Bjarmason (2):
>    commit-graph write: add progress output
>    commit-graph verify: add progress output
>
>   commit-graph.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 43 insertions(+), 1 deletion(-)

Thanks for writing this, Ævar. I appreciate that you took the time to 
fill in an important UX gap.

I had a couple of comments, but generally this is a good change.

-Stolee

