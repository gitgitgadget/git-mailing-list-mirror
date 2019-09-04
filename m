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
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C501F461
	for <e@80x24.org>; Wed,  4 Sep 2019 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbfIDSZ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 14:25:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41845 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfIDSZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 14:25:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id o11so1155106qkg.8
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oijwF0A36hKhSvBu2wEAPSlwQdDd8OruU3DXhH9cVl0=;
        b=Zl/J7OBVAgan49G5l3YTXqyiCkoLtkvRB5g8sglcwgxrszHkXFv37Mynk+KJ++IUoV
         LqwmevKEwe9ObSwBcK3FYpBccWlBeBWqzcOMTfKsQaSCIuIFlQ5kiDaeOLAGO5OTRXwa
         t3mNIUOZVq3HiNLo1tiEp2u3242KqZd2iPgHlVzobrQ43HzHmSD8XI9sk4OFiijH+ffb
         rXevImfPsyTCc7LaYTBoVXCvKBBn3/hrNrfD2Pzl5vZgTBMB7N76lM+N6qivKFQcrP7S
         Rk5vNuwZfyf4SNfRI1axqkSstLXDaasgdCbbJP0XkXtpTay14WY+eNegXGbmQdNx2Q/D
         7c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oijwF0A36hKhSvBu2wEAPSlwQdDd8OruU3DXhH9cVl0=;
        b=Avr3P++ZclNbsgDm4LTzjzCP61J4eeYWBGfGkVa51aDCK/amG2dmACY0zKsOsyZYSM
         1tsWRFm7iHLlZdipWqGKT79vhtogrb3hd2iTBSSM188h7+xXWmBCBsoJswZs9eQyf/ii
         avHrpLg+F6BHcJ2pD678hGqlRCB/hlayZe1UrfEqlaa+7aMTwz1yu2TFasVEC1MID00m
         rLugvCfrxBoOPxsxbxXbeWfjv2mGOmmvSMBHi7nWW25Z1gUgKN1opM09iNgfvZ+rJgkF
         djSEfyjbWOll5FKaj6055Qbd8IebgqhuNxRUKbrIm4a5pLu3kOkyfl0uAUP7BYyj3gT7
         T5+Q==
X-Gm-Message-State: APjAAAXV8SDCe/6PxxHaN7ktGFZrgIFNZKhdIsdl1/yiOkocKBuDmh03
        WlMF55xY+AP5e2NiSev3y/c=
X-Google-Smtp-Source: APXvYqwfPKAVRcuAZxQC0+/GPdXlL4ya09nHl8RpNzaO0bRzKkqz0IDFmi5Mb3ylOj3+Y89WDvvyig==
X-Received: by 2002:ae9:ec06:: with SMTP id h6mr37918858qkg.221.1567621556472;
        Wed, 04 Sep 2019 11:25:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b1c2:c22:8b00:c17a? ([2001:4898:a800:1012:62f6:c22:8b00:c17a])
        by smtp.gmail.com with ESMTPSA id u132sm2141874qka.50.2019.09.04.11.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 11:25:55 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] commit-graph.c: handle corrupt commit trees
To:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
References: <cover.1567563244.git.me@ttaylorr.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <c5ba4eaa-f995-5f2e-4f0f-a8f59ba65fd3@gmail.com>
Date:   Wed, 4 Sep 2019 14:25:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1567563244.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/3/2019 10:22 PM, Taylor Blau wrote:
> Hi,
> 
> I was running some of the new 'git commit-graph' commands, and noticed
> that I could consistently get 'git commit-graph write --reachable' to
> segfault when a commit's root tree is corrupt.
> 
> I have an extremely-unfinished fix attached as an RFC PATCH below, but I
> wanted to get a few thoughts on this before sending it out as a non-RFC.
> 
> In my patch, I simply 'die()' when a commit isn't able to be parsed
> (i.e., when 'parse_commit_no_graph' returns a non-zero code), but I
> wanted to see if others thought that this was an OK approach. Some
> thoughts:

I like the idea of completely bailing if the commit can't be parsed too.
Only question: Is there a reason you chose to die() instead of BUG() 
like the other two places in that function? What is the criteria of 
choosing one over the other?

> 
>    * It seems like we could write a commit-graph by placing a "filler"
>      entry where the broken commit would have gone. I don't see any place
>      where this is implemented currently, but this seems like a viable
>      alternative to not writing _any_ commits into the commit-graph.

I would rather we didn't do this cause it will probably kick open the 
can of always watching for that filler when we are working with the 
commit-graph. Or do we already do that today? Maybe @stolee can chime in 
on what we do in cases of shallow clones and other potential gaps in the 
walk

-Garima
