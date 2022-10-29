Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D64C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2Qcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ2Qcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:32:52 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917276429
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:32:50 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ooolM-0009cS-DC;
        Sat, 29 Oct 2022 17:32:48 +0100
Message-ID: <d7c818c8-201d-e7d3-f0b9-6d01ab51043c@iee.email>
Date:   Sat, 29 Oct 2022 17:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/3] glossary: add "commit graph" description
Content-Language: en-GB
To:     Derrick Stolee <derrickstolee@github.com>,
        GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
 <20221022222539.2333-3-philipoakley@iee.email>
 <3a7f43bd-2c48-6a37-7602-f4c938f7f58e@github.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <3a7f43bd-2c48-6a37-7602-f4c938f7f58e@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/2022 13:31, Derrick Stolee wrote:
> On 10/22/2022 6:25 PM, Philip Oakley wrote:
>> Git has an additional "commit graph" capability that supplements the
>> normal commit object's directed acylic graph (DAG). The supplemental
>> commit graph file is designed for speed of access.
>>
>> Describe the commit graph both from the normative DAG view point and
>> from the commit graph file perspective.
> One way to help keep the general term and the file separate is to use
> different notation. "commit graph" (with a space, no formatting) is the
> DAG. "`commit-graph`" (with a dash, code formatting) is the file (and
> its format).
I did want to have separate entries to make clear the distinction at
this level.

The use of the hyphenation is good, and there are only a few places
where that isn't followed, so I'll specifically call out the use of
hyphenation, and add a patch to update the few places that used the
generic term inappropriately.
Using the code formatting for commit-graph would have been extensive.,

>> +[[def_commit_graph_general]]commit graph concept, representations and usage::
>> +	A synonym for the <<def_DAG,DAG>> structure formed by
>> +	the commits in the object database, <<def_ref,referenced>> by branch tips,
>> +	using their <<def_chain,chain>> of linked commits.
>> +	This structure is the definitive commit graph. The
>> +	graph can be represented in other ways, e.g. the
>> +	<<def_commit_graph_file,commit graph file>>.
>> +
>> +[[def_commit_graph_file]]commit graph file::
>> +	The commit-graph file is a supplemental representation of
>> +	the <<def_commit_graph_general,commit graph>> which accelerates
>> +	commit graph walks. The "commit-graph" file is stored
>> +	either in the .git/objects/info directory or in the info directory
>> +	of an alternate object database.
>> +
> So this would become:
>
> [[def_commit_graph_file]]`commit-graph` file::
> 	The `commit-graph` file is a supplemental representation of
> 	the <<def_commit_graph_general,commit graph>> which accelerates
> 	commit graph walks. The `commit-graph` file is stored either in
> 	the `.git/objects/info` directory or in the `info` directory of
> 	an alternate object database.
>
> (I did some extra style and word-wrapping changes, too.)

I've used some of that. Thanks.

Philip
>
> Other than these nits, I find this to be a clear description.
>
> Thanks,
> -Stolee

