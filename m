Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D772E1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeCFKgE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:36:04 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:29299 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:36:03 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9wuelzXdlYtpt9wvexFcW; Tue, 06 Mar 2018 10:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520332562;
        bh=48CMf2+up7iYlMS0rBsxqBiafY7Va3nwlw6ZFRvRjag=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZwkLQbA3PcRk90yISSI2dlzMBlMTBlrpXQCiuLoCL2nz8Wpy0SO3otrtOzZdU55C5
         h4QTdmgBx/MlO8cdmdNAxq59hD/Yks9g6JFTEvOd2DZwidXNL0BNbuFwV8UoGyhdrw
         iD9eAwhpU46cdnZA5Od59kwi5pd+An6ZQQ8UO0iI=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=61VgBTjE2_26F9_T0SkA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
Date:   Tue, 6 Mar 2018 10:36:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKLnFbLAv+3eU4keqnf+Q0JAAloLW4yE2jV8/u1rEVgdkNAJV6MW3DHypKlIS0SpkO2Zs2qgjHN+rbmSXpp7m0NlAlhwWoxMumGjGbtP3sS8fklZ4c3O
 DN0LDp0EC3VUHSZOtT37E9bFDP7sp6uN1XBOodpsq86EBlY34N5CsQpz8qVtfX/bZ4PGH+aSelLBwzzCELLaExknBnBViusBNr24T9dgnAzmRxwU+yK3vd3f
 BL3X9o72syhV8WQc3xqOtQYjj3bYcI2TuVko9cCPWUGmkmRIPxuH88KsW5oJXFdNb73Y+rQIZ5eRb9j2dHyAQQeiJ2RdSp6Xq35GxK/99TP2gEFXiP6t/pDK
 H3oZZPfQ8JyQh4lM6rVKzJTUwT1BMPjXiKy4d2OEtkXCg72N6E+Y91K8tXUmwpI35CzCnA1D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/18 23:33, Igor Djordjevic wrote:
> Hi Phillip,
> 
>> On Fri, Mar 2, 2018 at 4:36 AM, Phillip Wood wrote:
>>>
>>>> It is interesting to think what it means to faithfully rebase a '-s
>>>> ours' merge.
>>>
>>> I should have explained that I mean is a faithful rebase one that
>>> adheres to the semantics of '-s ours' (i.e. ignores any changes in the
>>> side branch) or one that merges new changes from the side branch into
>>> the content of the original merge? In your example you add B4 to B. If
>>> M' preserves the semantics of '-s ours' then it will not contain the
>>> changes in B4. I think your result does (correct me if I'm wrong) so it
>>> is preserving the content of the original merge rather than the
>>> semantics of it.
> 
> Yeah, I understood what you mean, and I see you noticed that B4 
> commit, for which I did anticipate possibly bringing up a discussion 
> like this ;)
> 
> I agree with Jake here, my thoughts exactly (what I wrote in that 
> other subthread[1], too):
> 
> On 02/03/2018 17:02, Jacob Keller wrote:
>>
>> We only have the content, and we don't know the semantics (nor, I
>> think, should we attempt to understand or figure out the semantics).
> 
> Hmm, I wanted to elaborate a bit here, but that sentence seems to 
> summarize the pure essence of it, and whatever I write looks like 
> just repeating the same stuff again...
> 
> That`s just it. And stopping to give the user a chance to 
> review/amend the result, where he might decide he actually did want 
> something else - so all good.
> 
> Otherwise, I would be interested to learn how context/semantics 
> guessing could provide a better default action (without introducing 
> more complexity for might not be much benefit, if any).

I don't think its possible to guess the semantics of the original merge
as users can use custom merge strategies and amend the result. It would
be possible to detect and unamended '-s ours' merge but special casing
that may end up causing users more confusion rather than helping them.

> But in the end, I guess we can just discuss the "most sane default" 
> to present to the user (introduce or obsolete that new commit B4, in 
> the discussed example[2]), as we should definitely stop for amending 
> anyway, not proceeding automatically whenever U1' != U2'.

I can see the reason for that but I'm concerned that it might get
annoying with an interactive rebase as it would stop whenever one of the
commits on a topic branch that is a parent of a merge gets amended.
(squashing and reordering existing commits on a topic branch would be OK
though)

> Oh, and what about situations where we introduce new or drop existing 
> branches (which should be possible with new `--recreate-merges`)...? 
> "Preserving old branch semantics" may have even less sense here - the 
> (possibly heavily reorganized) content is the only thing we have, 
> where context will (and should) be provided by the user.

In this scheme there is now way to change the parents of a merge so
preserving the old branch sementics is well defined. If the user wants
to change the parents of the merge then this scheme wont help them.

> And I guess being consistent is pretty important, too - if you add 
> new content during merge rebase, it should always show up in the 
> merge, period. 

Yes, that should make it easy for the user to know what to expect from
rebase.

> It seems pretty confusing to find out one of the 
> branches "declared special" (even more if it`s based on uncertain 
> guess-work), so when you add something to it it`s just "swallowed", 
> as the whole branch is always obsoleted, for now and ever.
> 
> I might even see a value in such behavior, but only as a conscious 
> user action, not something done automatically... I guess? :)
> 
> Regards, Buga
> 
> [1] https://public-inbox.org/git/f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com/
> [2] https://public-inbox.org/git/f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com/
> 

