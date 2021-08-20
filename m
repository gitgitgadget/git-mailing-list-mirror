Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C0C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EC861181
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 22:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhHTWJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:09:02 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55119 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 18:09:01 -0400
Received: from [10.0.2.15] ([195.213.6.54])
        by smtp with ESMTPA
        id HCgWmPk1aOQhvHCgXmZwSX; Fri, 20 Aug 2021 23:08:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1629497302; bh=J7ro1yP212T3vpmZrEhlU0Etci6gE6Odbri94BnoQgA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kUHMbmIKobd1x8FV8dQzM2aS+kJjAj/Rxqx4SzK3Vj1w7mmt14EI3hUVxhN4Qoaw6
         YAlBdiHwZsJPZlM+rcWIELdh8DQMMCYvI4p5ceR8YRIgLsT2qBVw4a+n1bNKyHqoiz
         WvvOPhd2lnaonR8f4jTQCBDGDe8OW3+frjrSBARgUg31yhB5ivWqci4OQWoMyPV8W5
         BLwmSdQ/Ca5tPSbrnnR5pmJdOBvCamRQA2MOJpT5ozXU9yphZEJme74LBOipU6zZ0y
         d3vpvySG8IjCxwouN7O1SjdrGKm4+Se2pCsL8Ho+nz5Kog7t4gCQ7flHGqXsd7O54T
         DaDd/4shcRpeA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=thHlcjYJ4SvUC+rIXd59ow==:117 a=thHlcjYJ4SvUC+rIXd59ow==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=eGMXq8pU8n6ExDZEWk8A:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: Giving priority to the reftable topic (was Re: What's cooking in
 git.git (Aug 2021, #06; Mon, 16))
To:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqv945ng61.fsf@gitster.g> <xmqqtujkwsu0.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bc387e32-321e-4726-2a02-2e6cf6ed5250@ramsayjones.plus.com>
Date:   Fri, 20 Aug 2021 23:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqtujkwsu0.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLVj2gGLm9bZx1UalQth7J6i4LjhSiP5k0NbKkRc5QQoYsQSmArOsT81ipAV6kosAwqjtVBbXAEdsH4Ycd5eCQN0M/92wulIhLido/CY69YjUBvrCduk
 k0amY/8xw+IBW6Hf/gInR9a2WrOI+jJRAeVjq98TITFRTibWPRc+WOI6n6kJu82w/U9PAAwIP1tasQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/08/2021 07:09, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> * hn/reftable (2021-08-16) 25 commits
>>  - t1404: annotate test cases with REFFILES
>>  ...
>>  - hash.h: provide constants for the hash IDs
>>
>>  The "reftable" backend for the refs API.
> 
> As discussed in the thread that leads to [*1*], this topic has been
> blocked by the "clean-up errno use in the refs subsystem" topic for
> too long.  I think it deserves to have its own chance to be looked
> at by more eyes.
> 
> I've reverted the three topics around "errno" out of 'next', while
> rebasing them into a single strand of pearls, and queued them near
> the tip of 'seen'.  The hn/reftable topic is merged into 'seen' 
> earlier then these "errno" topics.

Just a gentle reminder that this topic tickles my 'static-check.pl'
script, like so:

  $ diff nsc ssc
  ...
  88a91,98
  > reftable/generic.o	- reftable_table_seek_log
  > reftable/merged.o	- reftable_merged_table_hash_id
  > reftable/merged.o	- reftable_merged_table_min_update_index
  > reftable/merged.o	- reftable_merged_table_seek_log_at
  > reftable/publicbasics.o	- reftable_set_alloc
  > reftable/reader.o	- reader_seek
  > reftable/reader.o	- reftable_reader_seek_log_at
  > reftable/stack.o	- reftable_stack_auto_compact
  ...
  $ 

Which is to say, all of the above symbols are defined (and called) in
the '.c' file corresponding to the given object file, but not called
anywhere outside that file. I have not even looked at those functions,
but (with the possible exception of reftable_set_alloc()) they don't
strike me as 'public API functions'. So, maybe they should be marked
as 'static'?

ATB,
Ramsay Jones


