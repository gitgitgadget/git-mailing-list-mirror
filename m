Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B201F404
	for <e@80x24.org>; Wed, 11 Apr 2018 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbeDKM5R (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 08:57:17 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:35176 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbeDKM5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 08:57:14 -0400
Received: by mail-pl0-f45.google.com with SMTP id 61-v6so1344778plb.2
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AcITTWgk1lFXD8LjlX/5FX+tFZ9o+Lkj4j9lsY9JEA0=;
        b=vKzGfCdriAEdmeyXLv8UyStF/bQmwNhxzaVZhIL5yHhIVAV57rPqWbqF/hVE78nJgW
         UUpL3k9IRaTdntJAr7o+eCkcAzHJOGcDsv6nVgt+eSLYwDS3b3xkn2IWuYMzZQycWpWP
         Xm45ZE4TjZksgWH+c3HsOGuZAPOAlKHWkEb5H50cNjk5hRiTiy+mdD3jZcvPmnUHhyHQ
         FLJrnnIzuhiZbN7JXe8sOtSdvEX4NnyamZnzg155KIyTedVw4WPTTNF76BdQmGwnGMBf
         /vJAgXlz+pcDf+uXGvg0gNfxQKplQ5hEdIqT2lVMUJdhk2mEhxhMBRNhhjD2ChDwnWMA
         86XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AcITTWgk1lFXD8LjlX/5FX+tFZ9o+Lkj4j9lsY9JEA0=;
        b=TURo4I0K/0CUd4B2tsZXh32/E0W9s1Lx2q6rDLtQ3BLJXC12sR36odr5ECm4NBPlKQ
         /RHh3VSmHty6mxXyMKugZ8eE8btLbpGR6GBygoy4HFFx5SqC0IffzPRmQvxE56bQb1Cq
         DNlqmGa1x46uqacK/+lT3ZMc1DIUCWQ6bUwZ77frvVE0Q4r9Qr03HtCVbYuCKAb/98V1
         iuIf4LSl14Zth6I6tuynP0iB0A1Nz5SDDCKebiItd4Uf7AneRfyudKQrFa5BhOujDjne
         /KTM0LYMkcODgG0Mq7XGPkYXPxpCLknWIHRTMc+npfnyYIVtBvYwgjVz0oZCTNi4V3c7
         zmxA==
X-Gm-Message-State: ALQs6tCoYlbCIvfVvc9Kys2QBDqx5UzWybetZMEoNPmt0etya5Zta2tP
        ozeifdjze4p75BtGmTwn0h4=
X-Google-Smtp-Source: AIpwx48mYkjBu5Biw+4Wely5I77bHzDSuNPLBwk/vFHs+dAA03wO+cCC9WbybQ98KYB7K5cqBB+nqw==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr5124085plp.142.1523451434155;
        Wed, 11 Apr 2018 05:57:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id z8sm3148460pgc.90.2018.04.11.05.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 05:57:13 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] commit: add generation number to struct commmit
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-4-dstolee@microsoft.com>
 <xmqqefjmzd67.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01c8d95b-e444-4b69-f083-9832023978a0@gmail.com>
Date:   Wed, 11 Apr 2018 08:57:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqefjmzd67.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 10:31 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The generation number of a commit is defined recursively as follows:
>>
>> * If a commit A has no parents, then the generation number of A is one.
>> * If a commit A has parents, then the generation number of A is one
>>    more than the maximum generation number among the parents of A.
>>
>> Add a uint32_t generation field to struct commit so we can pass this
>> information to revision walks. We use two special values to signal
>> the generation number is invalid:
>>
>> GENERATION_NUMBER_ININITY 0xFFFFFFFF
>> GENERATION_NUMBER_ZERO 0
>>
>> The first (_INFINITY) means the generation number has not been loaded or
>> computed. The second (_ZERO) means the generation number was loaded
>> from a commit graph file that was stored before generation numbers
>> were computed.
> Should it also be possible for a caller to tell if a given commit
> has too deep a history, i.e. we do not know its generation number
> exactly, but we know it is larger than 1<<30?
>
> It seems that we only have a 30-bit field in the file, so wouldn't
> we need a special value defined in (e.g. "0") so that we can tell
> that the commit has such a large generation number?  E.g.
>
>> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> 	if (!item->generation)
> 		item->generation = GENERATION_NUMBER_OVERFLOW;
>
> when we read it from the file?
>
> We obviously need to do something similar when assigning a
> generation number to a child commit, perhaps like
>
> 	#define GENERATION_NUMBER_OVERFLOW (GENERATION_NUMBER_MAX + 1)
>
> 	commit->generation = 1; /* assume no parent */
> 	for (p = commit->parents; p; p++) {
> 		uint32_t gen = p->item->generation + 1;
>
> 		if (gen >= GENERATION_NUMBER_OVERFLOW) {
> 			commit->generation = GENERATION_NUMBER_OVERFLOW;
> 			break;
> 		} else if (commit->generation < gen)
> 			commit->generation = gen;
> 	}
>          
> or something?  And then on the writing side you'd encode too large a
> generation as '0'.

You raise a very good point. How about we do a slightly different 
arrangement for these overflow commits?

Instead of storing the commits in the commit-graph file as "0" (which 
currently means "written by a version of git that did not compute 
generation numbers") we could let GENERATION_NUMBER_MAX be the maximum 
generation of a commit in the commit-graph, and if a commit would have 
larger generation, we collapse it down to that value.

It slightly complicates the diagram I made in 
Documentation/technical/commit-graph.txt, but it was already a bit of a 
simplification. Here is an updated diagram, but likely we will want to 
limit discussion of the special-case GENERATION_NUMBER_MAX to the prose, 
since it is not a practical situation at the moment.

     +-----------------------------------------+
     | GENERATION_NUMBER_INFINITY = 0xFFFFFFFF |
     +-----------------------------------------+
       |    |            |      ^
       |    |            |      |
       |    |            +------+
       |    |         [gen(A) = gen(B)]
       |    V
       |  +------------------------------------+
       |  | GENERATION_NUMBER_MAX = 0x3FFFFFFF |
       |  +------------------------------------+
       |    |            |      ^
       |    |            |      |
       |    |            +------+
       |    |         [gen(A) = gen(B)]
       V    V
     +-------------------------------------+
     | 0 < commit->generation < 0x3FFFFFFF |
     +-------------------------------------+
         |            |      ^
         |            |      |
         |            +------+
         |        [gen(A) > gen(B)]
         V
     +-------------------------------------+
     | GENERATION_NUMBER_ZERO = 0          |
     +-------------------------------------+
              |      ^
              |      |
              +------+
              [gen(A) = gen(B)]

Thanks,
-Stolee
