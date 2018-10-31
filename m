Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0141F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJaU7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 16:59:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44282 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeJaU7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 16:59:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id b22-v6so17255267qtr.11
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GU5N9OHpdMKJ2gCAqrZOZcRg7Z19KROh+zhlpU5826U=;
        b=IDS8b9+zjjnpxxa26hlxRqvxc7X5KTsIG+Ps7qFCifP55MqqCvozFcgp5X1XSjWca7
         Ddpk/s3EmUvol49Y6uzXNK9l/mUIQ+eKTnT00VVQ/nEJlcQQLFcrwlG0EPed8GWhEQke
         ChZKWrcNvmCLVI4hb+1+Raff2EU6GyC9HnzhKBKVqhG2wTKxChlxUWTjEwn1ZIGSBY4F
         UYLB9WYNNzh/elJ4Ly5uWhfW3Z48TCZyjOOPGJk0admla3Rm2kDcve9mI1aFZcS652zB
         QDY8XCGXNXgfT8atknYH/ypjsyES15p32ZRvsKi4JIQsASEIiJCa5Bjd47FrX2D58F80
         6epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GU5N9OHpdMKJ2gCAqrZOZcRg7Z19KROh+zhlpU5826U=;
        b=JLrywT848uzWJp+E0rsgSz6lNOj3dYVCLKLSBCH1m5F3D5VynfMxYskmMg1g7RHqLC
         ZL3f26ykkAm6yTvR7b8BSxdL7xFshd4pruOoh04gjNQihZuhn3akxatleCkIW+dWf6J6
         8OuQ082mjfzITXcXbSHWmZKizyP0K+2Z2DNCYQjde7teZ22xaUv5BnWeWUb9yRTtT0Z+
         7WQz8HCSsoY4ymYJO1InI2iRjwyG2DuQjKB2VDYfIG/7DJSWVhkjN8chwi7pTAKFDwsd
         YFgxK6Pyncu0nu6nvl0QQWspE+alv+mUauOQoS6UpHjKPM4Ji2OWt2hnAxjIupRzz+P0
         eLzA==
X-Gm-Message-State: AGRZ1gKOwj+xmJ03b2c/jaVoP3CE8XrXdbK0TE9Z5ldFXEKVfxd2W9IR
        zjkRxfTs+enkDpEzsuf7XM8=
X-Google-Smtp-Source: AJdET5e+m/uSGpUzCyJt+e+C01VfSGivaMLJ3gZX+dRVJQT33WNlHw0LoPGKMgpJ7yW0y1AAfRBWFQ==
X-Received: by 2002:ac8:2bb9:: with SMTP id m54-v6mr2314904qtm.36.1540987308051;
        Wed, 31 Oct 2018 05:01:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51aa:e8f0:335f:de7c? ([2001:4898:8010:0:3ae0:e8f0:335f:de7c])
        by smtp.gmail.com with ESMTPSA id q103sm9570773qkh.64.2018.10.31.05.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:01:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] commit-reach: implement get_reachable_subset
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.60.git.gitgitgadget@gmail.com>
 <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
 <xmqqy3aeyehs.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <15ef2018-4bb1-430f-32fd-5676a1b5ac1a@gmail.com>
Date:   Wed, 31 Oct 2018 08:01:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3aeyehs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2018 11:35 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>> +					 struct commit **to, int nr_to,
>> +					 int reachable_flag)
> This is OR'ed into object.flags, and I somoehow expected to see it
> as 'unsigned int', not a signed one.

Will do. Thanks.

>
>> +{
>> +	struct commit **item;
>> +	struct commit *current;
>> +	struct commit_list *found_commits = NULL;
>> +	struct commit **to_last = to + nr_to;
>> +	struct commit **from_last = from + nr_from;
>> +	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
>> +	int num_to_find = 0;
>> +
>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>> +
>> +	for (item = to; item < to_last; item++) {
>> +		struct commit *c = *item;
>> +		
>> +		parse_commit(c);
>> +		if (c->generation < min_generation)
>> +			min_generation = c->generation;
>> +
>> +		if (!(c->object.flags & PARENT1)) {
>> +			c->object.flags |= PARENT1;
>> +			num_to_find++;
>> +		}
>> +	}
>> +
>> +	for (item = from; item < from_last; item++) {
>> +		struct commit *c = *item;
>> +		if (!(c->object.flags & PARENT2)) {
>> +			c->object.flags |= PARENT2;
>> +			parse_commit(c);
>> +
>> +			prio_queue_put(&queue, *item);
>> +		}
>> +	}
> OK, we marked "to" with PARENT1 and counted them in num_to_find
> without dups.  We also marked "from" with PARENT2 and threw them in
> the "queue" without dups.
>
> Mental note: the caller must guarantee that everybody reachable from
> "to" and "from" have PARENT1 and PARENT2 clear.  This might deserve
> to be in the comment before the function.

I'll put that in the header file.

[snip]
> OK, this all makes sense.  Unlike merge-base traversals, this does
> not have to traverse from the "to" side at all, which makes it quite
> simpler and straight-forward.
>
> I do wonder if we can now reimplement in_merge_bases_many() in terms
> of this helper, and if that gives us a better performance.  It asks
> "is 'commit', i.e. a single 'to', an ancestor of, i.e. reachable
> from, one of the 'references', i.e.  'from'"?

We could do this, but it does come with a performance hit when the following
are all true:

1. 'to' is not reachable from any 'from' commits.

2. The 'to' and 'from' commits are close in commit-date.

3. Generation numbers are not available, or the topology is skewed to have
    commits with high commit date and low generation number.

Since in_merge_bases_many() calls paint_down_to_common(), it has the same
issues with the current generation numbers. This can be fixed when we have
the next version of generation numbers available.

I'll make a note to have in_merge_bases_many() call get_reachable_subset()
conditionally (like the generation_numbers_available() trick in the 
--topo-order
series) after the generation numbers are settled and implemented.

Thanks,
-Stolee
