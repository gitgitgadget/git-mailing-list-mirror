Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3351CC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 11:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63720748
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 11:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfKZLWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:22:16 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:27534 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfKZLWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 06:22:15 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iZYv6-0000YR-7G; Tue, 26 Nov 2019 11:22:12 +0000
Subject: Re: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
To:     Jonathan Gilbert <logic@deltaq.org>
Cc:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
 <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
 <20191111192526.crllpe3phitneu3p@yadavpratyush.com>
 <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
 <a1dd45d5-8dac-e86f-c964-957ff0b8dfb8@iee.email>
 <CAPSOpYsbBX3d_oWJHtKHD7b0cXcELF=t-zYNEVpU3sf8qzD4Ew@mail.gmail.com>
 <11812626-07f7-5610-cd13-ce4bdda4f674@iee.email>
 <CAPSOpYt71DGzkQxQDaMm88hR5bO8npKEY7tBPTypZ+aE1yp6gA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c3a21056-96c9-988d-2559-deb9ebedf642@iee.email>
Date:   Tue, 26 Nov 2019 11:22:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAPSOpYt71DGzkQxQDaMm88hR5bO8npKEY7tBPTypZ+aE1yp6gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 16:29, Jonathan Gilbert wrote:
> On Tue, Nov 12, 2019 at 4:45 AM Philip Oakley <philipoakley@iee.email> wrote:
>> On 12/11/2019 04:49, Jonathan Gilbert wrote:
>>> On Mon, Nov 11, 2019 at 4:59 PM Philip Oakley <philipoakley@iee.email> wrote:
>>>> sounds like "Currying" a function but with the parameters taken in any
>>>> order, though, in a sense, perhaps not generating intermediate functions...
>>> It's like currying if you could pass g(x) = f(x, y) to one block of
>>> code and h(y) = f(x, y) to another block of code, so that each of g
>>> and h are each like curried versions of f that "bake in" one of the
>>> arguments, without having to know which one will get called first. :-)
>>>
>>> Jonathan Gilbert
>> So that would be called "Chording"...
>> (Is there a 'proper' technical term for that approach?)
> Not an entirely implausible term :-) The only other implementation
> I've ever seen was Microsoft's "Polyphonic C#", which got rolled into
> C-omega. I'm pretty sure, though, that it was never referred to as
> something you _do to_ a function, but rather as a _different type_ of
> function -- as in, the function hasn't been "chorded", it "is a
> chord". Very little literature one way or the other though, and this
> is the first actual, live use case for the structure I've encountered
> in my years of programming :-)
>
A little bit of late follow up ;-)

The basic ideas that are embedded in "chording" would appear to be the 
same as those used in Data Flow Diagrams and the older attempts at data 
flow based machines such as the Transputer and it's message passing, and 
out of order execution machines. See 
https://en.wikipedia.org/wiki/Dataflow_architecture etc.

It just looks like it's now moved to the compiler, or JIT (just-in-time) 
compilation, which appears to be the same thing with different branding!

Philip
