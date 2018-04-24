Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60ED61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDXSzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:55:40 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34961 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDXSzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:55:39 -0400
Received: by mail-pg0-f52.google.com with SMTP id j11so11511901pgf.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRzWPdQ9WgSXMHy2hVDierjdc0rwkWXpLnwj0bBWNAM=;
        b=gunpjx1j3Ke3I8oE3JwrjABuGjJ40iTTV4UEO9+u0q7xPSuhANnmg98jtGI1P6tqtk
         t6UYioT5F8MSQ2zG+rUlTIiFGF4HYZP9L1I4Ajq58mJdqcB2N7YJNd8xNkinnQ5Lut4/
         l/QJyVaYn/w4j5Lk4hO44AEOe+UW91HM7awEF8I3XcYXBYCGTo2hCrLl/TRt3ey3THh7
         Ne77anv6S3KDw7gk/Rwg9mKeZUmsuu2nbTP09Y9fWKxV3IUiBPjFv7THm0QC2cK9xmAO
         SF8/BtQ036GmsEHaGfTXq8K79ztjyEbe3TZ14FVsjSjew1CKdXVP55D9N85PFmgrcq2a
         X74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRzWPdQ9WgSXMHy2hVDierjdc0rwkWXpLnwj0bBWNAM=;
        b=kmpLiVCORiPzzCDBappGceoHzSU7ydtykHTvFnzoFOz/+jZF/AnE9We1zNoD3/UiAk
         OVQijXzFYrBg8jS7cqKsCo5mZJnDuxnRKjl/uQ0SoFC5BTgN+Crb3wPQC/x/77RFtmSx
         gYgjZ3Xh09LZHtjnD1sRoFgetBx32zvbff9Psk1vBjg2w3ik3u7KVG6He0+0Hxom1cnP
         4FofEUK1YRIGKZQQaSHiW004++Cy5gfBHfr+audJpEhxk28fUz7o8Vzad6oum3/WkRtM
         tayLLbdu+2y20yFqwac/unHisoRFP8lqS620cUupX5o/Hhot66YpvdcNObWfeI/tnQRV
         20RQ==
X-Gm-Message-State: ALQs6tBuFo6/INkolIac0p4ONveQlkXxVc195MtOwM4DGLddpUSgbVos
        Qhv4A9niItboKnqRQc9lvmeeTg==
X-Google-Smtp-Source: AIpwx48coDz6k37unNmHJFr87Mg0QQM0k2ZrTIn+yjw+lLO4aSG2W2h8dDzWgvPDvg1dEJesiw6Hlw==
X-Received: by 2002:a17:902:6689:: with SMTP id e9-v6mr26419498plk.176.1524596138701;
        Tue, 24 Apr 2018 11:55:38 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x84sm46251772pfi.160.2018.04.24.11.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:55:37 -0700 (PDT)
Date:   Tue, 24 Apr 2018 11:55:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] cache.h: allow sha1_object_info to handle arbitrary
 repositories
Message-Id: <20180424115536.54fe1a62541624b2dbe06619@google.com>
In-Reply-To: <20180424184233.GA90854@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
        <20180423234327.250484-10-sbeller@google.com>
        <20180424112332.38c0d04d96689f030e96825a@google.com>
        <20180424184233.GA90854@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 11:42:33 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 04/24, Jonathan Tan wrote:
> > On Mon, 23 Apr 2018 16:43:27 -0700
> > Stefan Beller <sbeller@google.com> wrote:
> > 
> > > This involves also adapting sha1_object_info_extended and a some
> > > internal functions that are used to implement these. It all has to
> > > happen in one patch, because of a single recursive chain of calls visits
> > > all these functions.
> > 
> > In packfile.c, unpack_entry() invokes get_delta_base_cache_entry(),
> > which references a global (delta_base_cache). Does delta_base_cache need
> > to be moved to the repo object (or object store object) first, or is
> > this safe?
> 
> After looking at this, I think it should be safe for now since its a
> cache that requires a packed_git pointer to access (and those would be
> per repository).  We may want to move it in to the repository at some
> point though.

Thanks for the pointer. I see that a packed_git pointer is part of the
key to that hashmap, so this is indeed safe. (Probably worth discussing
this in the commit message.)

There is another global, delta_base_cached, but it just limits the total
size of the hashmap, so it's safe to use that too.
