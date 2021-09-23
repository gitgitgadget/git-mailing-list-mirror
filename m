Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF66C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED1B60F43
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbhIWXaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:30:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56166 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbhIWXaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 19:30:02 -0400
Received: from [10.0.2.15] ([195.213.6.53])
        by smtp with ESMTPA
        id TY8bmWY1odY2STY8cm1dtA; Fri, 24 Sep 2021 00:28:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632439709; bh=XiMwEEQyA2wTh0XvaJo+v0eIue7nZ0e28Wc1JtG18EA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=COcFQFap5m3GQpAQIwcuDQbyo6NRVS7Am9ObFGc6I/lp5/Ps9Y2SlP1qL7eb61h4c
         Gm63X+nYD21mfioGeXJUW+qQguuu4dTB9BWmPAEf0VkJxQm+OAdCOgbKjJNftM53SY
         ZX5PbGM7gOUZ0wU235HguT/ah7Jz+XpVX3DvmbxgDWwA0zF7EWApAAABYLUbBVlm96
         fx35m4Ggr4BQrNaaMDRtLW3gUDvV85jRXzXZux7NRel0taDKg4cayTQzChSybSo//D
         pTS0+c0lug2psxoj6vbZc4UOlU78Gn3CbYGo2y3OIz9eTwWdBndGZIzvSaoP216b6y
         ZbBNOPpJTZM6w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NP5OB3yg c=1 sm=1 tr=0
 a=UGFa5auBAZnIINSkMC8Ivw==:117 a=UGFa5auBAZnIINSkMC8Ivw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=VwQbUJbxAAAA:8 a=4WXrhSjFgJJyLNo4TQkA:9
 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
 <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net> <xmqqtuib199x.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com>
Date:   Fri, 24 Sep 2021 00:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuib199x.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfO4kVlMGoNTBO0DmjKwd9AvkvPYUs+ea34MDD3HREYnZyy+XH/56ZaJZehS8barbFdyDFoBS47DUHxmWc8dbILTtiWcOfUKHRjytFUZ1Lnp/LGomC9Jp
 RXdyoUW7S+S2MKp226HmujjHTjzvDnZe5AWZBM8+gonybyFTa4Ny5X9U2Yexb2nRfHMbG3dun8WAzQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/09/2021 18:39, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Sep 23, 2021 at 02:07:16AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> We ensure that the recursive dependencies are correct by depending on
>>> the *.o file, which in turn will have correct dependencies by either
>>> depending on all header files, or under
>>> "COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.
>>>
>>> This means that a plain "make sparse" is much slower, as we'll now
>>> need to make the *.o files just to create the *.sp files, but
>>> incrementally creating the *.sp files is *much* faster and less
>>> verbose, it thus becomes viable to run "sparse" along with "all" as
>>> e.g. "git rebase --exec 'make all sparse'".
>>
>> OK. I think this solves the dependency issues sufficiently. It is a
>> tradeoff that you must do the normal build in order to do the sparse
>> check now. That is certainly fine for my workflow (I am building Git all
>> the time, and only occasionally run "make sparse"). I don't know if
>> others would like it less (e.g., if Ramsay is frequently running sparse
>> checks without having just built).
>>
>> (I'd say "I do not care that much either way", but then I do not care
>> all that much either way about incremental sparse checks either, so I'm
>> not sure my opinion really matters).
> 
> My build procedure runs "make sparse" before the primary build,
> simply because the former tends to be much faster to fail when there
> is an issue in the code.  I can understand that depending on .o is a
> cheap way to piggyback on the dependencies it has, but my latency
> will get much slower if this goes in _and_ I keep trying to pick up
> potentially problematic patches from the list.


I always run 'make sparse -k >sp-out 2>&1' after having done the main
build, so that is not an issue for me. Note that I always send all
output from each build step (for master, next and seen) to a series of
(branch keyed) files, so that I can easily diff from branch to branch.
Also, as above, I use '-k' on the 'sparse' and 'hdr-check' targets to
collect all errors/warnings in one go.

So, this evening, with the v2 version of Ævar's patch having landed in
the 'seen' branch, we see this (abridged) diff between next and seen:

  $ diff nsp-out ssp-out
  77a78
  >     SP hook.c
  289a291
  >     SP builtin/hook.c
  417a420
  >     SP t/helper/test-reftable.c
  449a453,478
  >     SP reftable/basics.c
...
  >     SP reftable/tree_test.c
  452a482,483
  >     CC contrib/scalar/scalar.o
  >     SP contrib/scalar/scalar.c
  $ 

So, this almost looks normal, except for the 'CC' line! Having discovered
some leftover cruft from old builds yesterday:

  $ git ls-files | grep contrib/scalar
  contrib/scalar/.gitignore
  contrib/scalar/Makefile
  contrib/scalar/scalar.c
  contrib/scalar/scalar.txt
  contrib/scalar/t/Makefile
  contrib/scalar/t/t9099-scalar.sh
  $ ls contrib/scalar
  Makefile  scalar.c  scalar.o  scalar.sp  scalar.txt  t/
  $ rm contrib/scalar/scalar.{o,sp}
  $ make
      SUBDIR git-gui
      SUBDIR gitk-git
      SUBDIR templates
  $ make sparse
      CC contrib/scalar/scalar.o
      SP contrib/scalar/scalar.c
  $ 

Hmm, interesting, but not relevant here. So, lets play a bit:

  $ make sparse  
  $ make git.sp
  $ make git.sp
  $ touch git.sp
  $ make git.sp
  $ touch git.c
  $ make git.sp
      CC git.o
      SP git.c
  $ touch git.o
  $ make git.sp
      SP git.c
  $ 

Hmm, so I think it is working as designed. However, I find it to be
more than a little irritating (curmudgeon alert!).

Note there are currently no sparse warnings in any of the branches
I build (mainly because Junio patches them up before they hit the
git.kernel.org repo - I am not complaining! ;) ). However, should
any warnings/errors appear (from my own development, say), then I
would make extensive use of 'make <file>.sp' while fixing the
problem. Prior to this patch series, 'make <file>.sp' would _always_
run sparse over the file - it would not depend on the 'mtime' or
existence of any other file, or run the compiler (and wouldn't leave
any 'droppings' either). I liked that! :D

So, I still don't quite get where the 'savings' come from - maybe it
is just me, but I don't think this improves any workflow (well not
mine anyway). I just don't get it. :(

ATB,
Ramsay Jones

