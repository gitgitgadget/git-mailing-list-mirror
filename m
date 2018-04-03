Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B8A1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCSDk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:03:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35526 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbeDCSDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:03:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id 61-v6so7951495plb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fcPI2JG5GZc43h0fYA9YUSCchqeP3HCiy7au5CyAi3o=;
        b=Mg/JecUjujcx3StO6UWYeYXC/Al40pdedOzevbNl9DDMFyHOYXrpv4tEbYhFkYxdTi
         0kF7J+LpvSyO1W6MbpBEoxlFmELTd0gSNE5iqxsXggVKfJB4bYD4F+/4z1u0SU8TzfFG
         oy/L+EkVcToX4g4mw8shSulWstxQBC76+np0Ivza012Aa9W1JNAqL0KUVr1GGO2DH73T
         CttQ5y+tOwck5mh+pHsNIxt1h/BecK3Cb28rjxHeHws9riiybbqgFf9czv2jW/NRxPUC
         i4ft2eElDknNI+DObiaimTrCn05pjqhd+3bFy/g/9tRIzkIa4IGXuO17ybfAgQ0dgriq
         jEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fcPI2JG5GZc43h0fYA9YUSCchqeP3HCiy7au5CyAi3o=;
        b=PVwwER2XJfT68n81eYWfyM/P2f7hJc7vs0IjmuYtzCOU5HeRVfJcWOxgoLFyYIi35E
         yXyWHjMg8yxTGJkTVKGeMF7TiWNouzNjmNWHwlUjEvyl8HA4TesaD7hggS4ju2G0/7Do
         yqmnZLJzlUqDdwowPxA2PeIqcmtzw6WpIQc0t5Iiz87RZbr5tca4yUPC3S99ufMnt5J3
         8ue+ItNbuKMOgSkD8dxbsytFrA03Mc7ijihJR1pUl51zOUXop/F2OGZNQq8815CwmmQs
         0ERL0zMS9g4sYJIp/hnFSUaQGeAZd3UmPY3chzV6PlaPhMTpshivtUSF65sl2qrt11II
         8kZQ==
X-Gm-Message-State: AElRT7FzkD5qtxNHk/qTxN4oc3y62QjsgDV2WUV6UfsQh/Fyy+jiSQUy
        qrQ+6hlwc7a5wAK1B8UPmBa+SA==
X-Google-Smtp-Source: AIpwx4/1KlzVraQRR/vAhckNNDrHMn6HUrLSSRbxQrhZu3pn1de8uAvCR2dbOBjVmif5Le/38pPV/Q==
X-Received: by 2002:a17:902:71cc:: with SMTP id t12-v6mr8296846plm.247.1522778618868;
        Tue, 03 Apr 2018 11:03:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m1sm7287883pfi.80.2018.04.03.11.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:03:37 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:03:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
Message-ID: <20180403180336.GA100220@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03, Derrick Stolee wrote:
> This is the first of several "small" patches that follow the serialized
> Git commit graph patch (ds/commit-graph).
> 
> As described in Documentation/technical/commit-graph.txt, the generation
> number of a commit is one more than the maximum generation number among
> its parents (trivially, a commit with no parents has generation number
> one).

Thanks for ensuring that this is defined and documented somewhere :)

> 
> This series makes the computation of generation numbers part of the
> commit-graph write process.
> 
> Finally, generation numbers are used to order commits in the priority
> queue in paint_down_to_common(). This allows a constant-time check in
> queue_has_nonstale() instead of the previous linear-time check.
> 
> This does not have a significant performance benefit in repositories
> of normal size, but in the Windows repository, some merge-base
> calculations improve from 3.1s to 2.9s. A modest speedup, but provides
> an actual consumer of generation numbers as a starting point.
> 
> A more substantial refactoring of revision.c is required before making
> 'git log --graph' use generation numbers effectively.

log --graph should benefit a lot more from this correct?  I know we've
talked a bit about negotiation and I wonder if these generation numbers
should be able to help out a little bit with that some day.

> 
> This patch series depends on v7 of ds/commit-graph.
> 
> Derrick Stolee (6):
>   object.c: parse commit in graph first
>   commit: add generation number to struct commmit
>   commit-graph: compute generation numbers
>   commit: sort by generation number in paint_down_to_common()
>   commit.c: use generation number to stop merge-base walks
>   commit-graph.txt: update design doc with generation numbers
> 
>  Documentation/technical/commit-graph.txt |  7 +---
>  alloc.c                                  |  1 +
>  commit-graph.c                           | 48 +++++++++++++++++++++
>  commit.c                                 | 53 ++++++++++++++++++++----
>  commit.h                                 |  7 +++-
>  object.c                                 |  4 +-
>  6 files changed, 104 insertions(+), 16 deletions(-)
> 
> -- 
> 2.17.0.20.g9f30ba16e1
> 

-- 
Brandon Williams
