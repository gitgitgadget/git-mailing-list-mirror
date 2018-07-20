Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738781F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeGTSh6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:37:58 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42804 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbeGTSh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:37:57 -0400
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so7964085uan.9
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GI2YyWybYyLBXFQ1wsSV9C8AXYEyLatILbR3sjhJJUM=;
        b=RLEE2TWjoFmOqVXBBxuCl6fq1DjydV4kW2PUf2yPRBOWp2+4XdE2d2DtP8KSD/vRE+
         +irRy95TSCCiMjNi0dNzEPb6QivRAH1LIknFiF+jSpukhKSyznSKieOnBGb/qK5pTZAp
         Y9pT7sE8Axhn40ZmJ06F7fYfF5ulaQhyTVPczGIY5FneIojFNACSl/rcQ3dUzn2VYqzH
         genWtZ+I51QZVqpGsfUQDGJ+lcXD8FIW2xN8PfdKBNy+yCps8U4WvGmegdEOYwgLQKB+
         AN64v9FQyxiNBwhlCWL3ZWPOKzk9lHw9uAPw6HlGRvzrBgwYIVCGJl64ViJ/ncPi11OG
         yxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GI2YyWybYyLBXFQ1wsSV9C8AXYEyLatILbR3sjhJJUM=;
        b=NRLqq7JbymeAvigmOmRqA4Hs4QpU9Tzu8KubDH5lRKaFOKgw7QPsK+M6VM8XKz9HA8
         CBGxiXYYN/oaQY6sU/XMkG8GXG2tX3mD6aSixFy0FvWWeUL4V3G/cIvFtQwhuvYX04GQ
         xy1OxuR3C83UrRragFcUEJuurGla8CsZ85BLbrnVRAeJOCgkkr5gwdimhB7qictD79Uw
         7pFAlRIHB/Mi3/RVy2o/CFNshld5Pb5yDWMvVLPiCAS1K83C0U11LDoZ6LfB8m8n6oLw
         a+k2+XfCNWydKjzGcQynXjdRAF9wDOL4o6tQLQ9VnQxTl2k0y7S7szuXVW19+wkJlNr0
         f8hg==
X-Gm-Message-State: AOUpUlHuIQVhq+c0NVt6Go7ms8+1MP+d8nVTHpsCch1PEnKotjgGCOOc
        VapYJDErP92QFVSuOHRw2yI0b9RXM1skk5JaeEA=
X-Google-Smtp-Source: AAOMgpcq1f3hOHQRKofpyZzXBkoQ3rPB9fstj8JNG+nDx2/TH7JtJB/IIYBNAgAmw/j37Frtk3J4j3BDgMWLmd4REj0=
X-Received: by 2002:ab0:66d4:: with SMTP id d20-v6mr2070625uaq.112.1532108917671;
 Fri, 20 Jul 2018 10:48:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:48:37
 -0700 (PDT)
In-Reply-To: <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
 <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 10:48:37 -0700
Message-ID: <CABPp-BGt2EEW4aFt8TYyy1fATPRW2rnNxpMuGcS0YR_gqs3=ig@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 7:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 10:40 PM Jeff King <peff@peff.net> wrote:
>>
>> There are a few standard C functions (like strcpy) which are
>> easy to misuse. We generally discourage these in reviews,
>> but we haven't put advice in CodingGuidelines, nor provided
>> any automated enforcement. The latter is especially
>> important because it's more consistent, and it can often
>> save a round-trip of review.
>>
>> Let's start by banning strcpy() and sprintf(). It's not
>> impossible to use these correctly, but it's easy to do so
>> incorrectly, and there's always a better option.
>
> Is it possible to extend this to ban variables as well? I'm still
> going to delete the_index from library code. Once that work is done I

Or perhaps constants, such as PATH_MAX to avoid problems like this one
from 2.18.0 timeframe:
https://public-inbox.org/git/7d1237c7-5a83-d766-7d93-5f0d59166067@web.de/
