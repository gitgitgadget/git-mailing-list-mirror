Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130DA1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 22:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfJGWgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 18:36:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47067 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 18:36:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so7525209plr.13
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b44mWzxP1XgaPxRC8JZfp78rDNCJw7B5/KgQ+79cy1s=;
        b=L4IS3WqL1mnOnsNGggbZQMO559DzpsooCbtr2k2m13mNn1LSOB7LTtXl+fv2C90gAe
         YGxRpsoTkmVcTLsLzqzmfSEPDFyPKL5pQDdZHhnU8D1y2hfUW9UKYfFoASmzkta8c2Gf
         QDzeudSCOzwQR+yK/XGqHAT95rhFwUgX5ezc+hVWA48md1yxh7ZILiMs2DgHGxL1fhud
         EdSfc9LZaqT1PDRcoIdmfP9tQsgM3V1+pHeQMY1m7fXf58YRSwCXGxQwlkLKyfwBSVjf
         w+IRgvOJuSZmbjBqt6A3oFD3kd7C9cE1xPpxla1gHt6VTEDkWsRH16m5HDC3Rog4AKSM
         OCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=b44mWzxP1XgaPxRC8JZfp78rDNCJw7B5/KgQ+79cy1s=;
        b=GiqrPB8KZAwlyEwZi1/RiLpBJyRMvNK+Z6uA7efcgxTLsJZNzRq4aCEmV+RhMa20z/
         HwUV8bs5Y2CndJNQLYQLKfvdB1IbMJxXu4vK4/koex92mlyT/+vqWF1ZjibG7hQ0yWLN
         kp1G7dACKuLg2epC7uQxbCPcoOi+liXvpfX6w3sGkjUhIQ3BeftrJSWg9GHlopMWT0CG
         dkwzezmrjL5j5BXBtpiKtMp4r7qdIO3+qv40oybH4MKxqx5h/o3g5bzJIJqjk5G8QC0r
         CN/kEB3RXsAXgIth4VI8DjZLKi8A4oBqgtLt8IKpEZhNzHUFu6eR0Crk3pdiw5lhnRAC
         WOrQ==
X-Gm-Message-State: APjAAAWe8vx+hYqd826qbvcGUeStWmv7ZZ3YZZrUdZvPDv56EPM7Q5n/
        tLZC7pdTh4z5Y58u4G+qN8pMPHsTCJfM4w==
X-Google-Smtp-Source: APXvYqwzZkqBzNXdQNFREVvByqEYpWAGyR1klGto9mcHZG28eub2QWkVFyS8a6yGce9xZ4C/vL+KXA==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr32580853pll.238.1570487810826;
        Mon, 07 Oct 2019 15:36:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id w189sm16362844pfw.101.2019.10.07.15.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 15:36:50 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:36:44 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] add trace2 regions to fetch & push
Message-ID: <20191007223644.GA8397@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1570059953.git.steadmon@google.com>
 <20191007214644.236055-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007214644.236055-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.07 14:46, Jonathan Tan wrote:
> > We'd like to collect better statistics about where the time is spent in
> > fetches and pushes so that we can hopefully identify some areas for
> > future optimization. So let's add some trace2 regions around some of the
> > fetch/push phases so we can break down their timing.
> 
> Thanks.
> 
> Patch 1 looks good to me - different regions at the same level
> (builtin/fetch.c, so it will be just for "git fetch") and one specific
> one just for negotiation, which has to be in fetch-pack.c because only
> that file operates at that level.
> 
> Patch 2 mostly looks good to me too - unlike fetch, a lot happens in
> transport.c, so it's reasonable to put most of the regions there. One
> comment: in transport_push(), should trace2_region_{enter,leave} take
> "r" instead of "the_repository"?

Ah yeah, thanks for the catch. Fixed in V2.
