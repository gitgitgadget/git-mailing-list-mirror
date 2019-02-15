Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3231F453
	for <e@80x24.org>; Fri, 15 Feb 2019 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfBOK6g (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 05:58:36 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23443 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388545AbfBOK6g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 05:58:36 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id ubCQg5JjFj87fubCQgFDuJ; Fri, 15 Feb 2019 10:58:33 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=NrWvjPVJ c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=5rxgeBVgAAAA:8 a=mLKua8RHAAAA:8 a=PpF-6VckHHuDRBiebi8A:9 a=QEXdDO2ut3YA:10
 a=_xDNj3R8C6EA:10 a=PwKx63F5tFurRwaNxrlG:22 a=ewTM_9iNE6a0vsrYD_ou:22
Subject: Re: How to get next commit that just after a specified commit
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
References: <87mun0j9vv.fsf@evledraar.gmail.com>
 <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <fbf09f23-6f9c-2353-2416-8c2a12f9cf48@iee.org>
Date:   Fri, 15 Feb 2019 10:58:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfBtQWxIb4Iy0ZDTdWBMxR74kj5n79DzQ8jGgy1NvUs63yPcBKKKcRwCjCW/qA6fJ9pYDKx6L6fo6KI4c9MZMH+vKg/urdKgCpU/IePUqzjuc7y4oO7w2
 nfNmSOznAkVlVSjID00luR7jyTHQqRXFG3ywtRRgaVyXgSKHLZCIeNz4ZPB9X0vCXjDsD4OpWKND7L92oUNBb7FbczMyeDf2i4PlIPArHJpKATHWCD6eng/L
 3VKDPoCfFLsrPjbm0yVbBvO+q7MDZFDxUrXrGwlkhJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/02/2019 21:12, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> (Replying to
>> https://public-inbox.org/git/383c14cc.9289.168e61d39e8.Coremail.wuzhouhui14@mails.ucas.ac.cn/
>> which curiously I can see there, but not in my inbox (or spam))
>>
>> Git's data format doesn't make it easy to find "C" given "B" in a commit
>> chain like A->B->C (also there could be any number of "C"
>> successors). We need to walk the graph. This shows how to do it:
>>
>> https://sqlite.org/whynotgit.html#git_makes_it_difficult_to_find_successors_descendents_of_a_check_in
> Of course, the history is not necessarily linear.  Even though you
> *MUST* know all your parents before having a commit (which means
> that when you ask "what came before this commit", there is a
> definitive answer that everybody in the world would agree on), you
> by definition cannot know all the commits that are children of a
> commit (simply because somebody else may be creating a new one), so
> the question "what's the next commit" does not make any sense from
> that point of view ;-)

It will also depend on which heads (branches) one wishes to trace back 
from, or even know about. I'd expect that the default would just be the 
current branch (head) which would definitely limit the potential commit 
list.

--

Philip

