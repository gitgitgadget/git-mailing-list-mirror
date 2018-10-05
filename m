Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FE11F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJFClz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:41:55 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:33365 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFClz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:41:55 -0400
Received: by mail-qt1-f175.google.com with SMTP id q40-v6so15069347qte.0
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cpUECcM0O2ey7doCI7yXRH+1uLg7Eb5ELBGtw2x+/yY=;
        b=hIOtZpf2vYCN7bNgfrNxOByYIwVKYVMNpQZX4oPfG3w5GjBl25FWonk9hfz4Kr+GF0
         LvfEqEe/w4S2W1CI/6Py9ppmKYLjE7LLFHKD5/wfcRFvze5DRI73FO3+QD19cRXZYuEC
         2KlPs7cTKiZyItLj8Nicz8eivIwugmpH+XGgr/B2lyBVdeakqAFbAtluB+0n/nAqa7DY
         fq37I73ll8P7WZ4ocJRVN61fcyyA1MuJgf74UzAX4i/6BxUZgudcH8O3vve/ctqddqQC
         ScngRpI8aEdSPO3bnC4J82Xv+FezDtBd6Oao5XDgPm6/IVZTVrzcoaGQnMGt8zGGNe7U
         S/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cpUECcM0O2ey7doCI7yXRH+1uLg7Eb5ELBGtw2x+/yY=;
        b=FtXx01xXvlPgoUCSWCUGqvhHeDszpAY0hyt8vwyTXsQsC0j7LyQTbvtrZqUP4P9GGN
         j1KQiJ1UM8ndXk7MOaO3Sh4Fjun9UzsW3Ez6xIV2BpxQ53H0J3tyq3ENSa9ytnEiG7S1
         anH6DtylAwtw4TYGTHvrJR7ab1Adwx6sBHviMCUe3AarTZYGJiZZPvVARu6W3vPYl2+A
         bvQy4pA4ImNdtCwMuGDOb/A3w4ZTVyOhcTgigARVf37HSEYnxu/fZg76J9AgUsViwRLc
         HPNzskmD7irC/i+AsZLYr3TOmYRP0AZAvbzqwnIYaDAD1Yux14IEkypPeSpL5ZO8HFvh
         ICzg==
X-Gm-Message-State: ABuFfohJK23htV+TcABseekOs7Ur/IKe0ST4oDIm69+fJH65ejTtSrID
        qRd92KkXo5oOPiMJFvRKvqc=
X-Google-Smtp-Source: ACcGV63Rk6kiye85jtgIavpYO8kV52VvW4xt5hpRDb3JOh+b9KrGQuN8R2HkzkCrx8vlpZH5HigCpg==
X-Received: by 2002:ac8:248c:: with SMTP id s12-v6mr10582565qts.116.1538768502639;
        Fri, 05 Oct 2018 12:41:42 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t188-v6sm4213271qkc.58.2018.10.05.12.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:41:41 -0700 (PDT)
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due
 to commit graph
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
 <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
 <87ftxkh7bf.fsf@evledraar.gmail.com>
 <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
 <20181005192154.GD17482@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com>
Date:   Fri, 5 Oct 2018 15:41:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005192154.GD17482@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2018 3:21 PM, Jeff King wrote:
> On Fri, Oct 05, 2018 at 09:45:47AM -0400, Derrick Stolee wrote:
>
>> My misunderstanding was that your proposed change to gc computes the
>> commit-graph in either of these two cases:
>>
>> (1) The auto-GC threshold is met.
>>
>> (2) There is no commit-graph file.
>>
>> And what I hope to have instead of (2) is (3):
>>
>> (3) The commit-graph file is "sufficiently behind" the tip refs.
>>
>> This condition is intentionally vague at the moment. It could be that we
>> hint that (3) holds by saying "--post-fetch" (i.e. "We just downloaded a
>> pack, and it probably contains a lot of new commits") or we could create
>> some more complicated condition based on counting reachable commits with
>> infinite generation number (the number of commits not in the commit-graph
>> file).
>>
>> I like that you are moving forward to make the commit-graph be written more
>> frequently, but I'm trying to push us in a direction of writing it even more
>> often than your proposed strategy. We should avoid creating too many
>> orthogonal conditions that trigger the commit-graph write, which is why I'm
>> pushing on your design here.
>>
>> Anyone else have thoughts on this direction?
> Yes, I think measuring "sufficiently behind" is the right thing.
> Everything else is a proxy or heuristic, and will run into corner cases.
> E.g., I have some small number of objects and then do a huge fetch, and
> now my commit-graph only covers 5% of what's available.
>
> We know how many objects are in the graph already. And it's not too
> expensive to get the number of objects in the repository. We can do the
> same sampling for loose objects that "gc --auto" does, and counting
> packed objects just involves opening up the .idx files (that can be slow
> if you have a ton of packs, but you'd want to either repack or use a
> .midx in that case anyway, either of which would help here).
>
> So can we really just take (total_objects - commit_graph_objects) and
> compare it to some threshold?

The commit-graph only stores the number of _commits_, not total objects.

Azure Repos' commit-graph does store the total number of objects, and 
that is how we trigger updating the graph, so it is not unreasonable to 
use that as a heuristic.

Thanks,

-Stolee

