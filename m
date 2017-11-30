Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A2620C11
	for <e@80x24.org>; Thu, 30 Nov 2017 15:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdK3Psu (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 10:48:50 -0500
Received: from siwi.pair.com ([209.68.5.199]:60022 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdK3Pst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 10:48:49 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 025FD8450E;
        Thu, 30 Nov 2017 10:48:49 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BB4188450D;
        Thu, 30 Nov 2017 10:48:48 -0500 (EST)
Subject: Re: [git-users] How hard would it be to implement sparse
 fetching/pulling?
To:     Konstantin Khomoutov <kostix@bswap.ru>,
        vit via Git for human beings <git-users@googlegroups.com>
Cc:     git@vger.kernel.org, Vitaly Arbuzov <vit@uber.com>
References: <bb89278c-9e79-489d-a19d-681b4e231d10@googlegroups.com>
 <20171130081232.7hk73s5d62gmpqdz@tigra>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <11be7135-29a4-5f4a-2d61-ffe16a965cd5@jeffhostetler.com>
Date:   Thu, 30 Nov 2017 10:48:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130081232.7hk73s5d62gmpqdz@tigra>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/2017 3:12 AM, Konstantin Khomoutov wrote:
> On Wed, Nov 29, 2017 at 06:42:54PM -0800, vit via Git for human beings wrote:
> 
>> I'm looking for ways to improve fetch/pull/clone time for large git
>> (mono)repositories with unrelated source trees (that span across multiple
>> services).
>> I've found sparse checkout approach appealing and helpful for most of
>> client-side operations (e.g. status, reset, commit, add etc)
>> The problem is that there is no feature like sparse fetch/pull in git, this
>> means that ALL objects in unrelated trees are always fetched.
>> It takes a lot of time for large repositories and results in some practical
>> scalability limits for git.
>> This forced some large companies like Facebook and Google to move to
>> Mercurial as they were unable to improve client-side experience with git
>> and Microsoft has developed GVFS which seems to be a step back to CVCS
>> world.
> [...]
> 
> (To anyone interested, there's a cross-post to the main Git list which
> Vitaly failed to mention: [1]. I think it could spark some interesting
> discussion.)
> 
> As to the essence of the question, I think you blame GVFS for no real
> reason. While Microsoft is being Microsoft — their implementation of
> GVFS is written in .NET and *requires* Windows 10 (this one is beyond
> me), it's based on an open protocol [2] which basically assumes the
> presence of a RESTful HTTP endpoint at the "Git server side" and
> apparently designed to work well with the repository format the current
> stock Git uses which makes it implementable on both sides by anyone
> interested.
> 
> The second hint I have is that the idea of fetching data lazily
> is being circulated among the Git developers for some time already, and
> something is really being done in this venue so you could check and see
> what's there [3, 4] and maybe trial it and help out those who works on this
> stuff.
> 
> 1. https://public-inbox.org/git/CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com/
> 2. https://github.com/Microsoft/GVFS/blob/master/Protocol.md
> 3. https://public-inbox.org/git/?q=lazy+fetch
> 4. https://public-inbox.org/git/?q=partial+clone
> 

For completeness with the git-users mailing list.
Here is info on the work-in-progress for this feature.

https://public-inbox.org/git/e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com/

Jeff

