Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C20ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiH3Odr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiH3Odo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:33:44 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ADFB5317
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:33:43 -0700 (PDT)
Received: from host-92-14-211-167.as13285.net ([92.14.211.167] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oT2JB-0005aJ-C2;
        Tue, 30 Aug 2022 15:33:42 +0100
Message-ID: <70706e55-07b5-5fec-df06-9953e0013a8e@iee.email>
Date:   Tue, 30 Aug 2022 15:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] glossary: add commit graph description
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <32777cae24de91b0fb873ea04a802630ab85aafe.1657385781.git.gitgitgadget@gmail.com>
 <xmqqedyut22w.fsf@gitster.g> <5551bd33-cf95-3201-0a00-23e02ef41de3@iee.email>
In-Reply-To: <5551bd33-cf95-3201-0a00-23e02ef41de3@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2022 22:37, Philip Oakley wrote:
> Hi Junio,
>
> On 09/07/2022 22:20, Junio C Hamano wrote:
>> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +[[def_commit_graph]]commit graph::
>>> +	The commit-graph file is a supplemental data structure that
>>> +	accelerates commit graph walks. The existing Object Data Base (ODB)
>>> +	is the definitive commit graph. The "commit-graph" file is stored
>>> +	either in the .git/objects/info directory or in the info directory
>>> +	of an alternate object database.
>> While it says nothing technically incorrect, I suspect "The existing
>> object data base is the definitive commit graph" may invite unneeded
>> confusion.
> I probably over-shortened the original text I was summarising
> (technical/commit-graph.txt intro).

I was looking to outline the concept and how, therefore, it is different
from the reachability bitmaps, and also from the 'canonical' DAG of
Git's commit objects.

I hope to have another go in a couple of weeks time.

>> I think you wanted to say that the DAG formed by traversing the
>> pointers recorded in the objects is the authoritative source of
>> truth and the commit-graph file is merely a precomputed cache
> .. of that graph. *nod*
>>  and
>> can be safely lost, 
> I wasn't particularly thinking of that aspect .. Perhaps more that it
> accelerates commit graph walks..
>> but I am not sure the above description conveys
>> that to anybody who does not already know it.
>>
>>     The commits in the object data base form a directed acyclic
>>     graph (DAG) by commits referring to their parent commits.
>>     Pieces of information from individual commit objects that are
>>     needed to traverse the DAG are pre-computed in the commit-graph
>>     file and stored in ...
>>
>> is my attempt---I am not very happy or proud about it, but it may be
>> easier to follow.
> I wanted to keepseparate from the graph file definition, the rather
> fuzzy relationship between the overall ODB (staging area, and loads of
> other stuff), and the way the DAG is generated, which also needs the
> selected refs to start the traverse..
>
> In a wider context, it's not clear to me just how the commit graph file
> content is chosen relative to the full depth DAG from all local refs.
> The reachability bit maps have a similar info gap.
>
> --
> Philip
>
> [sorry for erratic responses - currently isolating with covid]
>

