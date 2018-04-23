Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067CB1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755333AbeDWNzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:55:00 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:44313 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbeDWNy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:54:58 -0400
Received: by mail-qk0-f177.google.com with SMTP id z8so486039qki.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dysHiGoyBm+vIN8DxrVyrisjIaGTyH9eqcl2gbF3Z74=;
        b=Un1E/qa0Rm6rOfgnUG18RpqnptS5PdFf66TnFOQFWzQjhsjqKsyxIDb5jl4Osk+BZ+
         KwiP0Gu17/A4d9AFH/xWfLetTEo8Ci4GKhKCZH0FSC9Z3nPoy/FZkANdyZdcLZpv9bDI
         /h6k5wdzmpRlg6ahEVqKrJaGiCQ6wQzbGTsHXyHJkqqkvQjSuq2btboC2RRmLXs9C05U
         aig3byuJplJFqydQBcTOqenTlRUGQcmaLHiFrVInQZihc5urb4+9CBR4HDhwTRUKfN5b
         qLIulxBUU5ISho8YXsCJ9nTzkmogRzW4nrmSTV2mNkoEs8/B82J0Dl/fBs6WADTKHlae
         9Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dysHiGoyBm+vIN8DxrVyrisjIaGTyH9eqcl2gbF3Z74=;
        b=APUu7ICqcV4wl3CA5kucq4YpwU08n1eGj5dwKMwAW0RLASSQShzcIPxu005vqoAwFU
         aIDeNzFIO5KDl6wtedyAXmWxqfuCa0Wp5eULBdzsDikAnv4j6er/ZIU2dE9BeCMNKkvT
         FuGYBoh/XXyeFWqwCiSP/R5Pg9F9eg/m6eYFxUO71VJYZSd4cbWK4PKVEA7mcMbwS4Uq
         96XHpPHwlQ9j6CacfPkZ/t6nFfWkEc5vFrpHy51Ddh2bjpgW6unKJ43Jd4J5Wa8Rq6C+
         uviTnvKbRvI83PX94txDx734+HMunn5SPCdzBfs/O3I1qGYcdO0fu31JyLiO6mM+z5Bz
         2ARw==
X-Gm-Message-State: ALQs6tC5ht+tNNBCG2ej1NNDcAP0ezxA03TTW8FuWj9OpmERBFz1qzi3
        ziG2KX2DPgS7TrJdIsHYfcw=
X-Google-Smtp-Source: AB8JxZqwoMVrVMTQFEs3H4qTOmi5zbOGYLdRamJK8kx9QRGUMod3AUykCymbGp9Vxz6B5sfD/cQtcw==
X-Received: by 10.55.23.94 with SMTP id i91mr21253441qkh.308.1524491697728;
        Mon, 23 Apr 2018 06:54:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id t82sm9866217qke.52.2018.04.23.06.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 06:54:56 -0700 (PDT)
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <867epjez1n.fsf@gmail.com> <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
 <868t9t5yjz.fsf@gmail.com> <45320265-9fec-cee1-e82c-3ff719bb0435@gmail.com>
 <86lgdplogn.fsf@gmail.com> <86d0yscmra.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <68cadcfc-5fed-9c2c-8f5c-034ec64a347e@gmail.com>
Date:   Mon, 23 Apr 2018 09:54:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86d0yscmra.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2018 4:44 PM, Jakub Narebski wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> On 4/11/2018 3:32 PM, Jakub Narebski wrote:
>>>> What would you suggest as a good test that could imply performance? The
>>>> Google Colab notebook linked to above includes a function to count
>>>> number of commits (nodes / vertices in the commit graph) walked,
>>>> currently in the worst case scenario.
>>> The two main questions to consider are:
>>>
>>> 1. Can X reach Y?
>> That is easy to do.  The function generic_is_reachable() does
>> that... though using direct translation of the pseudocode for
>> "Algorithm 3: Reachable" from FELINE paper, which is recursive and
>> doesn't check if vertex was already visited was not good idea for large
>> graphs such as Linux kernel commit graph, oops.  That is why
>> generic_is_reachable_large() was created.
> [...]
>
>>> And the thing to measure is a commit count. If possible, it would be
>>> good to count commits walked (commits whose parent list is enumerated)
>>> and commits inspected (commits that were listed as a parent of some
>>> walked commit). Walked commits require a commit parse -- albeit from
>>> the commit-graph instead of the ODB now -- while inspected commits
>>> only check the in-memory cache.
> [...]
>>> For git.git and Linux, I like to use the release tags as tests. They
>>> provide a realistic view of the linear history, and maintenance
>>> releases have their own history from the major releases.
>> Hmmm... testing for v4.9-rc5..v4.9 in Linux kernel commit graphs, the
>> FELINE index does not bring any improvements over using just level
>> (generation number) filter.  But that may be caused by narrowing od
>> commit DAG around releases.
>>
>> I try do do the same between commits in wide part, with many commits
>> with the same level (same generation number) both for source and for
>> target commit.  Though this may be unfair to level filter, though...
>>
>>
>> Note however that FELINE index is not unabiguous, like generation
>> numbers are (modulo decision whether to start at 0 or at 1); it depends
>> on the topological ordering chosen for the X elements.
> One can now test reachability on git.git repository; there is a form
> where one can plug source and destination revisions at
> https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg#scrollTo=svNUnSA9O_NK&line=2&uniqifier=1
>
> I have tried the case that is quite unfair to the generation numbers
> filter, namely the check between one of recent tags, and one commit that
> shares generation number among largest number of other commits.
>
> Here level = generation number-1 (as it starts at 0 for root commit, not
> 1).
>
> The results are:
>   * src = 468165c1d = v2.17.0
>   * dst = 66d2e04ec = v2.0.5-5-g66d2e04ec
>
>   * 468165c1d has level 18418 which it shares with 6 commits
>   * 66d2e04ec has level 14776 which it shares with 93 commits
>   * gen(468165c1d) - gen(66d2e04ec) = 3642
>
>   algorithm  | access  | walk   | maxdepth | visited | level-f  | FELINE-f  |
>   -----------+---------+--------+----------+---------+----------+-----------+
>   naive      | 48865   | 39599  | 244      | 9200    |          |           |
>   level      |  3086   |  2492  | 113      |  528    | 285      |           |
>   FELINE     |   283   |   216  |  68      |    0    |          |  25       |
>   lev+FELINE |   282   |   215  |  68      |    0    |   5      |  24       |
>   -----------+---------+--------+----------+---------+----------+-----------+
>   lev+FEL+mpi|    79   |    59  |  21      |    0    |   0      |   0       |
>
> Here we have:
> * 'naive' implementation means simple DFS walk, without any filters (cut-offs)
> * 'level' means using levels / generation numbers based negative-cut filter
> * 'FELINE' means using FELINE index based negative-cut filter
> * 'lev+FELINE' means combining generation numbers filter with FELINE filter
> * 'mpi' means min-post [smanning-tree] intervals for positive-cut filter;
>    note that the code does not walk the path after cut, but it is easy to do
>
> The stats have the following meaning:
> * 'access' means accessing the node
> * 'walk' is actual walking the node
> * 'maxdepth' is maximum depth of the stack used for DFS
> * 'level-f' and 'FELINE-f' is number of times levels filter or FELINE filter
>    were used for negative-cut; note that those are not disjoint; node can
>    be rejected by both level filter and FELINE filter
>
> For v2.17.0 and v2.17.0-rc2 the numbers are much less in FELINE favor:
> the results are the same, with 5 commits accessed and 6 walked compared
> to 61574 accessed in naive algorithm.
>
> The git.git commit graph has 53128 nodes and 66124 edges, 4 tips / heads
> (different child-less commits) and 9 roots, and has average clustering
> coefficient 0.000409217.

Thanks for these results. Now, write a patch. I'm sticking to generation 
numbers for my patch because of the simplified computation, but you can 
contribute a FELINE implementation.

> P.S. Would it be better to move the discussion about possible extensions
> to the commit-graph in the form of new chunks (topological order, FELINE
> index, min-post intervals, bloom filter for changed files, etc.) be
> moved into separate thread?

Yes. I think we've exhausted this thought experiment and future 
discussion should revolve around actual implementations in Git with 
end-to-end performance times. The computation time for computing the 
FELINE index should be included in that discussion.

Thanks,
-Stolee
