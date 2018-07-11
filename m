Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421841F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 19:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbeGKTrg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 15:47:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40650 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbeGKTrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 15:47:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so22117283qtj.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A1STG6QGHawbTp7mPXC7YaqZ/SRiy8WdTXkqNOf1mJA=;
        b=QMDTvR96et2rGL/6bBuxJ6NTTFDcEY4teDl49+wd1mC6ngxMhwrd4T/JJBl9gsXAE9
         KINFTh3zxWTo96tkfUvUmKtAXj7/1ZorD3vpecr9YAhoV4DpnnPxq69uFPuM4wxzR7Ji
         uzE2cYI3t8S+xwa+QYezqD70BBSjHqfPus3ANmqL2w+pBRlM577zCRGO6Efr7QL9UIcI
         uXdBWsNx57y4uJ2xMjIimorUK7l5KbIxrVXmbcqduBVZuds5Y08q5qH5wZ77joxT0z7w
         QJkKyLC+UzA3RS3Z7SE5f2rYGyGWhxHICsIGZwijIfch9TMtwjlzo+Je63ktISObZhjc
         Y6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A1STG6QGHawbTp7mPXC7YaqZ/SRiy8WdTXkqNOf1mJA=;
        b=K6+3QVEU4m/qFHUA3JG5uI1VGdfpWNy/qJGd9U7K1bsv5KtoXoxD7jaYMjzCdCGjrO
         6S4HcCRBJpQCMALj9OHLIVVRhgMaARipG3VfcnDRj8VKDRkdcoWpeYpvd3nhaPURcD3j
         KyD8RWwYrQdQLI/U+gY5XixYM3F8G/K6t61VybSr4s/PA4U6Zw11L5uC0l2EyZ+H/E6D
         ZBs7AoGpmh3sGozN1cYLkHuzApvRDVM5LeybiPOTCflkNNCl+XiDNGKJcGUpbhhqI28h
         IfSBQXLdLtCyeusnABmB4iHCYX6mzS3R9qSt/csEatnDv6S73PfLSJpira4JiMjHDEJ6
         UH0w==
X-Gm-Message-State: AOUpUlEDQb8uh1mX0+3h1rb0HQLL36A49pNIgIfD3Dj49jKngQMoglPy
        Tyi4hT926kSqi+djiWZ9vFMTLYZJ
X-Google-Smtp-Source: AAOMgpdRb4W0ZhUWP3BQCT7RD3Y3q2roefpLRTE24vKeazQ00/tkkq4OQ21hm+AcJj8O1X42RS622w==
X-Received: by 2002:ac8:262e:: with SMTP id u43-v6mr11474qtu.100.1531338105577;
        Wed, 11 Jul 2018 12:41:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a0c8:4b4d:ec0e:67f1? ([2001:4898:8010:0:89fe:4b4d:ec0e:67f1])
        by smtp.gmail.com with ESMTPSA id p35-v6sm11820551qtp.63.2018.07.11.12.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:41:44 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <75ef9935-342a-bbda-4ce6-e5a033f273a9@gmail.com>
 <20180710173147.104757-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1f0ab606-cf7d-e61c-1761-7a2982a2628e@gmail.com>
Date:   Wed, 11 Jul 2018 15:41:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180710173147.104757-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/10/2018 1:31 PM, Jonathan Tan wrote:
>
>>> +static void test_get_commit_tree_in_graph(const char *gitdir,
>>> +					  const char *worktree,
>>> +					  const struct object_id *commit_oid)
>>> +{
>>> +	struct repository r;
>>> +	struct commit *c;
>>> +	struct tree *tree;
>>> +
>>> +	/*
>>> +	 * Create a commit independent of any repository.
>>> +	 */
>>> +	c = lookup_commit(commit_oid);
>> Would this be more accurate to say we are creating a commit object
>> stored in the object cache of the_repository? How would you expect this
>> to work if/when lookup_commit() takes an arbitrary repository? You want
>> to provide &r, right (after initializing)?
> Yes, you're right - Stefan too mentioned that this will need to be moved
> below lookup_commit(). I'm not sure what the best way is to handle this
> - maybe move this, and add a "needswork" stating that we need to pass r
> to lookup_commit once it supports taking in a repository argument, as an
> aid to the person who performs the merge. I'll do that if a reroll is
> needed.
>
>> Also, this will conflict with sb/object-store-lookup, won't it? I'm
>> guessing this is why you didn't touch the "git commit-graph
>> [write|verify]"code paths.
> It will conflict because of the change to lookup_commit(), but the only
> new code I'm writing is in t/helper/test-repository.c, so hopefully the
> merge won't be too tedious. The main reason why I didn't touch the
> writing/verifying part is to reduce the size of this patch set, and
> because that change is not needed to update parse_commit() and others.

I guess my main complaint is that this won't be an actual "merge" 
conflict, but the result will not compile. Since Stefan already has a 
series out that changes this method, I recommend basing your series on 
it (in addition to basing it on ds/commit-graph-fsck).

Thanks,

-Stolee

