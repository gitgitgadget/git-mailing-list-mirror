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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2111F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395164AbfIFRT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:19:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36281 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391459AbfIFRT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:19:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so3854224pgm.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q1nHVYw2/gw+ZjPKYLrFKTzWOEShow7VqpSw4hTzjRY=;
        b=vd8LHMkJbUPS0aVO/i3yG8MbQl3AWDWZbrVQ1lcMPC6Vfs1F5GW1j7AlKnpyigcY86
         DAer5kWNP7Ivo4LM0jtHu4JLZkkZkZXYy+nFpgPxpuz0nLovVaNBQwVxEt/3MAeoOOhM
         aWkYBP1jwzuRSeceNBswQRQMHbyJ7ohzcxqF6LKoxH887AFS9mtQ5zloFV6VvHaZhxAs
         F9TIb2I3EnLJcphr59mQF6xxakRNDrxd6zJkfDVa5rH1UHwlFZZB+hrBk8dQLu5I0eT0
         uFULQYKiyu9fm2e5AuU4XQ8pw1EXgU1RNPWhD3ypBUo0MOGLDnpNsQM+kECN0Mis3cZp
         /W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q1nHVYw2/gw+ZjPKYLrFKTzWOEShow7VqpSw4hTzjRY=;
        b=ITcon6DH2rkBL0e7kf1BqjbZo32ZTtEw0La974cXg89+QxC7/fOz6ek6KACqIUoA9y
         aphrGafClsh4XYAqCLgRh8MFZBZQXzTFUPOaTdL65UcLbFsrn5KVU0NMTYsl+xCVLPFE
         9JWBA9+6guUG2Xm4ktx4fEGOFawuKSzh4sO3hOCJxC5DAxceR6CvBSsY9YIBAs5x6hRz
         A6By7LxMgKmLR98SWqONOuKJu7miuAOwJOqQHDy9LHsn+Koy4fum7iFrn/rOy+QE8gul
         HVWPFyQsUNX6Sg+Kv1olvzhMS8nQPQJEFsEr1nPkQbwNumKeZjodV0JfVDkhYDiPexpt
         Au0w==
X-Gm-Message-State: APjAAAXxTaLsl3xxaBbuqjX4Z+JZHxwx2LCQOd5OehcHcW4X7dT3PuCy
        ai7CDsS98QyJcdpr6XKfon3HRWsL
X-Google-Smtp-Source: APXvYqyKC+L1d0+l85abjpU0wmmimtCghSpXED4+BK+SnS8bOYZg01jdgGaDk5E8tYyLCLLH4s5XOg==
X-Received: by 2002:a17:90a:d795:: with SMTP id z21mr7293778pju.12.1567790367051;
        Fri, 06 Sep 2019 10:19:27 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id e24sm6937119pgk.21.2019.09.06.10.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:19:26 -0700 (PDT)
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
Message-ID: <b1121a33-691a-e3ff-a212-48c0d7deae1b@gmail.com>
Date:   Fri, 6 Sep 2019 13:19:21 -0400
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

This was an oversight on my part. Sorry.

-Stolee
