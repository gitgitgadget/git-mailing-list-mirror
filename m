Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519D320380
	for <e@80x24.org>; Thu, 23 May 2019 23:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfEWXsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 19:48:38 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:46419 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbfEWXsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 19:48:38 -0400
Received: by mail-qt1-f172.google.com with SMTP id z19so6059205qtz.13
        for <git@vger.kernel.org>; Thu, 23 May 2019 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6uxDlK9MgvjDIRzeCf23ckqFR20r5CK0ZEMA/qqWJOg=;
        b=QbXxcjYlgshP6+VRbI9iinoemqh0yooNjT9xFaJ3wSVhD+ec8XJ1lrMhZbYGxZ563P
         QhL3KH95EdWaO6tQOYfch4R6nAsS6/m0DV54ASEcYU1dMXAD4mn/4nGty5jeKIYkT4KP
         E0CMhXq1dka/PvRfpx+BZDSHErpQynU9O/8UzUzRQMBseN0ZPehuUofV2kupG+c7VjOL
         02CVsTQ0X5gVn2/6AF3b4Rsq2ZheC658eTpfZ9JMCJn2VQqTHjRvlkXbnTSk7GuwDD13
         g99AFhn9hxJ2efM1b1T7ayTVvc8UFwntLRs/aZMw0B6YzKUbSjKYkVsp4/Z8JoqfP02R
         qIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6uxDlK9MgvjDIRzeCf23ckqFR20r5CK0ZEMA/qqWJOg=;
        b=d+mVmmco6pYv8WmeNRfj2dNV5Mhy852iF1S0efUcjEmBBrLlO8CV1anLgE1ZHSRfKS
         TPLyHDMQ/7/TKv2+NU90+zfYtIYeQEBnJ+0TcTnNKiGx6JBSswn2lzMOxF1aglMiKkhb
         tbljfSG1vyWNqduAmlQrlGjLde9ZWb49u7v3KI1AxEQZ7jqtNOFDIjqSu8Mh5yksp/xi
         IHTJEIjNtjK1cMG0rAM/K8En0sn0Nx5j/bJSKVtDC98d8SB/Zwg/SYmxb+kNNg4yKvqQ
         rq1atnSMd4OXXROas/rNGdJ42KaOvjfhfJEv3o0QeZVjqMsn0NyeX+8Xws+Z5R9LetAA
         A17A==
X-Gm-Message-State: APjAAAXm8jAmfcZBq0+7UCsfXaxTh3h00lC1dlldmJVfwkdChL+JDjvP
        xEsJkz9ofIYMngJJdqGHCTsCTno7rIs=
X-Google-Smtp-Source: APXvYqyilMjSbEsP8gl1dbvEm9+yG2Hy/ncQfNGTXX0FAZX7zghc/RixXG7JDAYXEQtdHfWGblOfwg==
X-Received: by 2002:ac8:65c1:: with SMTP id t1mr84607005qto.13.1558655317054;
        Thu, 23 May 2019 16:48:37 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id g20sm510738qtc.53.2019.05.23.16.48.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 16:48:36 -0700 (PDT)
Subject: Re: standalone library/tool to query commit-graph?
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, Karl Ostmo <kostmo@gmail.com>,
        git@vger.kernel.org
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
 <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com> <86blztq8ap.fsf@gmail.com>
 <87tvdkg7ld.fsf@evledraar.gmail.com> <20190523222031.GC951@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
Date:   Thu, 23 May 2019 19:48:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190523222031.GC951@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2019 6:20 PM, SZEDER Gábor wrote:
> On Thu, May 23, 2019 at 11:54:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Thu, May 23 2019, Jakub Narebski wrote:
>>
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>> On 5/22/2019 2:49 PM, Karl Ostmo wrote:
>>>
>>>>> After producing the file ".git/objects/info/commit-graph" with the
>>>>> command "git commit-graph write", is there a way to answer queries
>>>>> like "git merge-base --is-ancestor" without having a .git directory?
>>>>> E.g. is there a library that will operate on the "commit-graph" file
>>>>> all by itself?
>>>>
>>>> You could certainly build such a tool, assuming your merge-base parameters are
>>>> full-length commit ids. If you try to start at ref names, you'll need the .git
>>>> directory.
>>>>
>>>> I would not expect such a tool to ever exist in the Git codebase. Instead, you
>>>> would need a new project, say "graph-analyzer --graph=<path> --is-ancestor <id1> <id2>"
>>>
>>> It would be nice if such tool could convert commit-graph into other
>>> commonly used augmented graph storage formats, like GEXF (Graph Exchange
>>> XML Format), GraphML, GML (Graph Modelling Language), Pajek format or
>>> Graphviz .dot format.
>>
>> Wouldn't that make more sense as a hypothetical output format for "log
>> --graph" rather than something you'd want to emit from the commit-graph?
>> Presumably you'd want to export in such a format to see the shape of the
>> repo, and since the commit graph doesn't include any commits outside of
>> packs you'd miss any loose commits.
> 
> No, the commit-graph includes loose commits as well.

Depends on how you build the commit-graph.

	git commit-graph write
	git commit-graph write --stdin-packs

These options build based on commits in packs (and closes under reachability).

	git commit-graph write --reachable
	git commit-graph write --stdin-commits

These options build based on a set of starting commits. Either the refs (--reachable)
or the input commit ids (--stdin-commits).

But I do like the flexibility of `git log --graph` as you could export the graph
after reparenting (with options like `--simplify-merges -- <path>`). You also would 
not include commits from random topic branches you have sitting around.

-Stolee
