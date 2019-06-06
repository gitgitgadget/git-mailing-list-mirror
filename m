Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B321F462
	for <e@80x24.org>; Thu,  6 Jun 2019 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfFFV7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 17:59:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:5885 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFFV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 17:59:01 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Z0PShFaekgI7iZ0PShM3Yr; Thu, 06 Jun 2019 22:58:59 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=Xk8D0aEXdlPqIRnpGWYA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH v3 01/14] commit-graph: document commit-graph chains
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
 <pull.184.v3.git.gitgitgadget@gmail.com>
 <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
 <6a6a0b72-e503-1fdd-e67e-2a84d825f89b@iee.org>
 <909f355c-4c44-1556-71c7-168b28abddfc@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <504867ac-557e-7c9c-3d0f-076c1a7f0e58@iee.org>
Date:   Thu, 6 Jun 2019 22:59:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <909f355c-4c44-1556-71c7-168b28abddfc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKU2RgtsSGhIjLkcT9l6GzcBYczhHM2ONYdwHWhQb6VAHrNdnSrBTnKr1+ID1+3il8uzjnplvuVgzuOsK6OTLK/u7RQHINRz8/ZaerFNpN1Jk3uwUgn2
 9XNlMgt5J8/EZjkqzX9p1iQzrPbZCHCHKk3HbYbZGLe4IKZzFxS2FS+PgQN09orlmXFkqQPVkDI0WKb5xpHZpecZmLPSxbifvnBsEicl4b7pj+ikotKstpdt
 /npMaOUXZED6IyErijrgr4NALL3y8i98M4yO26LldIA0R7an7qW+o5IMBOyZy/UIJctRsRZh6vIsgA41L58co708+qFGRFetTNECL4BXNF/i8ojFucVFATRl
 qMcnsjgvguOXj9iihUhz9ekyb1ET4mbpO+HMYdy5EevdH1UPw34iA2lZWMzNLZbyZWmK6yzc8ZrOjb9GaJ0G1ZlVIgvQ0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

We may be talking at cross-purposes.
On 06/06/2019 18:09, Derrick Stolee wrote:
> On 6/6/2019 8:10 AM, Philip Oakley wrote:
>> Hi Derrick ,
>>
>> On 03/06/2019 17:03, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> Add a basic description of commit-graph chains.
>> Not really your problem, but I did notice that we don't actually explain what we mean here by a commit graph (before we start chaining them), and the distinction between the generic concept and the specific implementation.
The purpose of my comment is here. We have/had not explained why we need 
(another) commit graph, either within the man page, or the technical 
docs. It's an understanding gap.
>>
>> If I understand it correctly, the regular DAG (directed acyclic graph) already inherently contains the commit graph, showing the parent(s) of each commit. Hence, why do we need another? (which then needs explaining the what/why/how)
>>
>> So, in one sense, another commit chain is potentially duplicated redundant data. What hasn't been surfaced (for the reader coming later) is probably that accessing the DAG commit graph can be (a) slow, (b) one way (no child relationships), and (c) accesses large amounts of other data that isn't relevant to the task at hand.
>>
>> So the commit graph (implementation) is [I think] a fast, compact, sorted(?), list of commit oids that provides two way linkage through the commit graph (?) to allow fast queries within the Git codebase.
>>
>> The commit graph is normally considered immutable,
> _Commits_ are immutable. The graph grows as commits are added.
I was aware that individual commits are immutable. However the tips, 
grafts and replacements can change the topology of the graph (especially 
the grafts and replacements, hence the desire to have something that 
acts as a guide as to what, generally, is trying to be achieved).
>
> This may be the crux of your confusion, since the commit-graph
> file can become stale as commits are added by 'git commit' or
> 'git fetch'. The point of the incremental file format is to
> update the commit-graph data without rewriting the entire thing
> every time.
>
> Does this help clarify what's going on?
Only slightly, see below.
>
>> however the DAG commit graph can be extended by new commits, trimmed by branch deletion, rebasing, forced push, etc, or even reorganised via 'replace' or grafts commits, which must then be reflected in the commit graph (implementation).
> These things create new commit objects, which would not be in
> the commit-graph file until it is rewritten.
>
>> It just felt that there is a gap between the high level DAG, explained in the glossary, and the commit-graph That perhaps the technical/commit-graph.txt ought to summarise.
> I do think that technical/commit-graph.txt does summarize a lot
> about the commit-graph _file_ and how that accelerates walks on
> the high-level DAG. The added content in this patch does assume
> a full understanding of the previous contents of that file.
The current (prior) documentation is a bit Catch 22 with regard to that 
assumed full understanding, hence my comment, including the "Not really 
your problem," bit.
>
> Thanks,
> -Stolee
>
Philip
