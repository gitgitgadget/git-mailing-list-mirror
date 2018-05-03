Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714A92023F
	for <e@80x24.org>; Thu,  3 May 2018 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeECWp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 18:45:59 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41860 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeECWp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 18:45:58 -0400
Received: by mail-yb0-f193.google.com with SMTP id l9-v6so7074358ybm.8
        for <git@vger.kernel.org>; Thu, 03 May 2018 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R1qiw8qQdiRNNq1ccVtCGd0HoEKZn/BCadGhm+JZBDg=;
        b=r66u3Aebt75OPNqPD5ZMVB4avPQDelUMdRT1s9BNhhTnMXzfhVItUEduBYe2Bxc6nj
         AEdW4XFhh+F4lgUCgf6z8ggZ7SgB7AyLV4kttq0l7Bxgc8VQ0I+lz3CMibpXEUOb/6tT
         mtprNdXdNeXlxga8SoIge5pf0KUuSDOMPq4aqedYWWK29qZb7ow6lSQOahRuHd7y3wcz
         Tc1QA4HZfiA3E6bL3aKw2OIdCl0SFejJtqCJctBzzuy8HSOBidw1OnR1D8aQ7k6UJY49
         nP3mM3oR7GeC7eq3kiSqRGI2URogpKUmYP9yydJLCeiqDsESf/TdWVgtPeaB4wUA4GaE
         3LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R1qiw8qQdiRNNq1ccVtCGd0HoEKZn/BCadGhm+JZBDg=;
        b=hJQ+pAYjhGTELVZJtovLa9KXGxuixTYAJmJTxjLafeH5DfHWT6b23/oYv0XY2l9PG8
         pRuiMflJs+Kc90fdEF9DchYR9CYa8vo4RKGLwEKM+7tt3s1Irq0THCakpQ/p4och/H46
         dUsYUWx65S15vpep9MYyBsAiSebE9stTJfqMHcMODuJbpOGN0c25yRGUh8UTfsZFKQ0f
         yWLdp0U9OI7b9gKRCBlXLYgtq95bOoRZfI5BkZImFVsdesmedCeNQSm+3V1ZZOb1cXXB
         k+QxFAy/gAb5Qo1SZ/9OIRrmNNCbfGFaymMGIcUpAtEpTvIcXGVZie6c9IaBAV+VyzmW
         Keqw==
X-Gm-Message-State: ALQs6tD3rCrwxWK4Pk26xGgY3Ak+JYae7Z0uou01U2MPtDwJ/CKCYjWc
        o4rVtg9wkzHqB7DVeoR1jMFatYO8UV1RZKeukzzENQ==
X-Google-Smtp-Source: AB8JxZodsHkkDMMBg5SsSb3S3g8d6KRRZMCc6tGS4/jeYYOzStWXXnCoR2ytarP0ON/sexIaZnHtRrNFjnC6St9vHPc=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr15943490ybb.334.1525387557740;
 Thu, 03 May 2018 15:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 15:45:57 -0700 (PDT)
In-Reply-To: <CACsJy8CR1RYYdsc5=8hz2Sx9_bOY9eb_-vwEqDo62Hex1FxBmw@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
 <BL0PR2101MB1106C07DEE184F8DA2C7CA62CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
 <CACsJy8CR1RYYdsc5=8hz2Sx9_bOY9eb_-vwEqDo62Hex1FxBmw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 15:45:57 -0700
Message-ID: <CAGZ79kYUdQ8G8jZYi=iYuzSwfsZua2TbCFX_1B_MBU-sENNmKw@mail.gmail.com>
Subject: Re: [PATCH 00/13] object store: alloc
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 11:22 AM, Duy Nguyen <pclouds@gmail.com> wrote:

> I think the two have quite different characteristics. alloc.c code is
> driven by overhead. struct blob is only 24 bytes each and about 1/3
> the repo is blobs, and each malloc has 16 bytes overhead or so if I
> remember correctly. struct cache_entry at minimum in 88 bytes so
> relative overhead is not that a big deal (but sure reducing it is
> still very nice).
>
> mem-pool is about allocation speed,

I don't think so, given that we do a linear search in each block allocation.

> but I think that's not a concern
> for alloc.c because when we do full rev walk, I think I/O is always
> the bottleneck (maybe object lookup as well). I don't see a good way
> to have the one memory allocator that satisfyies both to be honest.

By changing the allocation size of a block to be larger than 1024 entries
in alloc. we should lessen the impact of management overhead, and then
the mem pool can be more than feasible.
