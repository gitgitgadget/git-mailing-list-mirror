Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD4C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE84A610C7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbhIXQk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:40:27 -0400
Received: from avasout03.plus.net ([84.93.230.244]:57572 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhIXQk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:40:26 -0400
Received: from [10.0.2.15] ([195.213.6.53])
        by smtp with ESMTPA
        id ToDommg5G8PBwToDqmbkq3; Fri, 24 Sep 2021 17:38:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632501532; bh=NgfBw+cbYv8WLN8/4UN1R7BYUjz+0mbdG9QS7Ijpw9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Kt2Oe8xhR4hpQ0h5K1Wjni2QTH2n7QOpsRjP8Nm4Q9axRhpoYq1xtnvXKopV2j7zt
         EaReglVOvJCQLnTPhDQ0Yz1n35DTEz0L2KQ/0n5Zbyow7pFgYl+YFU2OytCQSt9a0/
         tZ0Pu34fJc3elaA9x7PezAcurVIuNJRBe2xRo7aS0YVqKN26kdmmd2DUY+g5W8jjhK
         h+Hw7bqUhYmgLJtnF/peBA8J5xzDETw4yCjLhyE/FAu3EiHJxzBQvuN6JNp231aU75
         pqwpz6yRxs+yxsvdt/Xk/pTQUvsWuSybQcXFZqzg5vAVnlLD3M+EH8puYduZd4hsGQ
         Vf0pJzRQsMCCQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=YfImGzZf c=1 sm=1 tr=0
 a=UGFa5auBAZnIINSkMC8Ivw==:117 a=UGFa5auBAZnIINSkMC8Ivw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=4WXrhSjFgJJyLNo4TQkA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
 <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net> <xmqqtuib199x.fsf@gitster.g>
 <457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com>
 <87a6k24vdc.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7673e7aa-9737-a9eb-74ff-e11f071356e2@ramsayjones.plus.com>
Date:   Fri, 24 Sep 2021 17:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87a6k24vdc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEyd+H7H4zTFG15TDlgnNZEsJxtLZKvZebZ5WGVPX8MXJCwczJ5aQERldgsKvNYDQ6fYTaEII2zWfqe1DBYpxTbn0w3+2A+5v/GLrwqinetvKqQxh8Dn
 SRuKrRYNw6X7p6vdTHlEwWnuZ2oOMMIQgvZrJhb3Evev0SUWFkGEHWb1xphT4pkt3wnMbrbN14l0iw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/09/2021 02:16, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Sep 24 2021, Ramsay Jones wrote:
> 
>> On 23/09/2021 18:39, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> On Thu, Sep 23, 2021 at 02:07:16AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>>> We ensure that the recursive dependencies are correct by depending on
>>>>> the *.o file, which in turn will have correct dependencies by either
>>>>> depending on all header files, or under
>>>>> "COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.
>>>>>
>>>>> This means that a plain "make sparse" is much slower, as we'll now
>>>>> need to make the *.o files just to create the *.sp files, but
>>>>> incrementally creating the *.sp files is *much* faster and less
>>>>> verbose, it thus becomes viable to run "sparse" along with "all" as
>>>>> e.g. "git rebase --exec 'make all sparse'".
>>>>
>>>> OK. I think this solves the dependency issues sufficiently. It is a
>>>> tradeoff that you must do the normal build in order to do the sparse
>>>> check now. That is certainly fine for my workflow (I am building Git all
>>>> the time, and only occasionally run "make sparse"). I don't know if
>>>> others would like it less (e.g., if Ramsay is frequently running sparse
>>>> checks without having just built).
>>>>
>>>> (I'd say "I do not care that much either way", but then I do not care
>>>> all that much either way about incremental sparse checks either, so I'm
>>>> not sure my opinion really matters).
>>>
>>> My build procedure runs "make sparse" before the primary build,
>>> simply because the former tends to be much faster to fail when there
>>> is an issue in the code.  I can understand that depending on .o is a
>>> cheap way to piggyback on the dependencies it has, but my latency
>>> will get much slower if this goes in _and_ I keep trying to pick up
>>> potentially problematic patches from the list.
>>
>>
>> I always run 'make sparse -k >sp-out 2>&1' after having done the main
>> build, so that is not an issue for me. Note that I always send all
>> output from each build step (for master, next and seen) to a series of
>> (branch keyed) files, so that I can easily diff from branch to branch.
>> Also, as above, I use '-k' on the 'sparse' and 'hdr-check' targets to
>> collect all errors/warnings in one go.
>>
>> So, this evening, with the v2 version of Ævar's patch having landed in
>> the 'seen' branch, we see this (abridged) diff between next and seen:
>>
>>   $ diff nsp-out ssp-out
>>   77a78
>>   >     SP hook.c
>>   289a291
>>   >     SP builtin/hook.c
>>   417a420
>>   >     SP t/helper/test-reftable.c
>>   449a453,478
>>   >     SP reftable/basics.c
>> ...
>>   >     SP reftable/tree_test.c
>>   452a482,483
>>   >     CC contrib/scalar/scalar.o
>>   >     SP contrib/scalar/scalar.c
>>   $ 
>>
>> So, this almost looks normal, except for the 'CC' line! Having discovered
>> some leftover cruft from old builds yesterday:
>>
>>   $ git ls-files | grep contrib/scalar
>>   contrib/scalar/.gitignore
>>   contrib/scalar/Makefile
>>   contrib/scalar/scalar.c
>>   contrib/scalar/scalar.txt
>>   contrib/scalar/t/Makefile
>>   contrib/scalar/t/t9099-scalar.sh
>>   $ ls contrib/scalar
>>   Makefile  scalar.c  scalar.o  scalar.sp  scalar.txt  t/
>>   $ rm contrib/scalar/scalar.{o,sp}
>>   $ make
>>       SUBDIR git-gui
>>       SUBDIR gitk-git
>>       SUBDIR templates
>>   $ make sparse
>>       CC contrib/scalar/scalar.o
>>       SP contrib/scalar/scalar.c
>>   $ 
>>
>> Hmm, interesting, but not relevant here. So, lets play a bit:
>>
>>   $ make sparse  
>>   $ make git.sp
>>   $ make git.sp
>>   $ touch git.sp
>>   $ make git.sp
>>   $ touch git.c
>>   $ make git.sp
>>       CC git.o
>>       SP git.c
>>   $ touch git.o
>>   $ make git.sp
>>       SP git.c
>>   $ 
>>
>> Hmm, so I think it is working as designed. However, I find it to be
>> more than a little irritating (curmudgeon alert!).
> 
> Specifically that there's now "SP" lines in the output, that *.sp files
> are created at all, that they're created where they are, or some
> combination of those thigs?

Heh, just ignore me.

Although I haven't done much testing, I believe your patch correctly
implements what you intended.

ATB,
Ramsay Jones

