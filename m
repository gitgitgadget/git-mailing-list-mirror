Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BAE1F4B7
	for <e@80x24.org>; Fri,  6 Sep 2019 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfIFRU6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:20:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40219 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfIFRU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:20:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so4928681pfb.7
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NjjmndiEQuKH9Nihezw5bmD3d9lIlwmN4DGneZL+XEU=;
        b=qo9F0yRStroajaEN9SEJ2q4oAyCU+Pw373isBeVVEGMy7TJNAeAFrWjJMLL9HYx7ns
         nvbnyDo5NWkHKKjg+gJHU5n8Vj553OfuCBMcuKuLARjamN2O+kEV0EQv68lPa5IabzmL
         O4K/pjltxQ6/rp0hrYJ/2nCBcpe05mDvWouA54ZUemnJFiFtnhErRlRJHP8jxf4pdYSm
         FNNMPMRrJ/VQ7rA4bMtl0zdsrUXmZ+xHAptYHeIlVCFrEQXjeqeMYRkoCK73o0w91LoG
         N2bjHnYcsVITnuoDKDJTHZ9fQ/7WNoVW+H93ICDQRdcpAc3d7dM/nYWikPGxWbZsoVok
         T7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NjjmndiEQuKH9Nihezw5bmD3d9lIlwmN4DGneZL+XEU=;
        b=KHOsTkbuhW8nHk8araclAwkVhStyNt1NRSJg5wv84cdIHApbpHNcA8gh4j/zMsoREr
         Dk+tIKidXvwZo8YWUf1yfNt8cQkEqGNpbdcZgC47jE59ArydujIKvbYLhX+0Av+i8j4H
         jKhcPCK/DLkMxXBlHB1YoEZ+CFR89GHdQ+jQz8J2DfVB/cOsW7O9ZQApgUlP5yJ2cqa7
         uUDFA4sLikPAKUmJ9YTTZVlugB7gq+XrrQ7f4Wn73vL9y5cq6gCcQ4rOjwwbl1Ney3f+
         EW0S/DY68RhKfiWc5LtMKSR4Cn6Qyxl8KWTXxoXF4zvZ61USnRR9dauETC82h22L6a90
         iabg==
X-Gm-Message-State: APjAAAUcDFv3+ZSje40EHVO5UuomoU4ojQUaQTP0dg0uNG3CKXytVcrl
        poSjtIQgpJd8jUhEOOOysHBvUhXU
X-Google-Smtp-Source: APXvYqyKYS0J0CZtI0IuUe8UAiZnqaWqonCsRwXDQoEUlVr6lC+DWTD5e/LXR0lRDLI7uQbwcoXC6g==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr8844377pgq.269.1567790457347;
        Fri, 06 Sep 2019 10:20:57 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id f23sm6028432pfn.22.2019.09.06.10.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:20:56 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <20190904211847.GA20904@syl.local>
 <20190905064723.GC21450@sigill.intra.peff.net>
 <36bf0064-b563-74ed-4ae5-01745ced5d2e@gmail.com>
 <20190906170417.GA23181@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a77647b-a924-fd51-f0c8-b30ef0dbc3b4@gmail.com>
Date:   Fri, 6 Sep 2019 13:20:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190906170417.GA23181@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/6/2019 1:04 PM, Jeff King wrote:
> On Fri, Sep 06, 2019 at 12:48:05PM -0400, Derrick Stolee wrote:
> 
>>> diff --git a/revision.h b/revision.h
>>> index 4134dc6029..5c0b831b37 100644
>>> --- a/revision.h
>>> +++ b/revision.h
>>> @@ -33,7 +33,7 @@
>>>  #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
>>>  
>>>  #define TOPO_WALK_EXPLORED	(1u<<27)
>>> -#define TOPO_WALK_INDEGREE	(1u<<28)
>>> +#define TOPO_WALK_INDEGREE	(1u<<24)
>>
>> As an aside, these flag bit modifications look fine, but would need to
>> be explained. I'm guessing that since you are adding a bit of data
>> to struct object you want to avoid increasing the struct size across
>> a 32-bit boundary. Are we sure that bit 24 is not used anywhere else?
>> (My search for "1u<<24" found nothing, and "1 << 24" found a bit in
>> the cache-entry flags, so this seems safe.)
> 
> Yeah, I'd definitely break this up into several commits with explanation
> (though see an alternate I posted that just uses the parsed flag without
> any new bits).
> 
> Bit 24 isn't used according to the table in objects.h, which is
> _supposed_ to be the source of truth, though of course there's no
> compiler-level checking. (One aside: is there a reason TOPO_WALK_* isn't
> part of ALL_REV_FLAGS?).
> 
> And yes, the goal was to keep things to the 32-bit boundary. But in the
> course of this, I discovered something interesting: 64-bit systems are
> now padding this up to the 8-byte boundary!
> 
> The culprit is the switch of GIT_MAX_RAWSZ for sha256. Before then, our
> object_id was 20 bytes for sha1. Adding 4 bytes of flags still left us
> at 24 bytes, which is both 4- and 8-byte aligned.
> 
> With the switch to sha256, object_id is now 32 bytes. Adding 4 bytes
> takes us to 36, and then 8-byte aligning the struct takes us to 40
> bytes, with 4 bytes of wasted padding.
> 
> I'm sorely tempted to use this as an opportunity to move commit->index
> into "struct object". That would actually shrink commit object sizes by
> 4 bytes, and would let all object types do the commit-slab trick to
> store object data with constant-time lookup. This would make it possible
> to migrate some uses of flags to per-operation bitfields (so e.g., two
> traversals would have their _own_ flag data, and wouldn't risk stomping
> on each other's bits).

This reminds me that I'm hoping to eventually get around to moving
"generation" into a commit slab. That would reduce the space for people
still working without a commit-graph, and would allow updating to
generation number v2 (which needs 64 bits of data).

-Stolee
