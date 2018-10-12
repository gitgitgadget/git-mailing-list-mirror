Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365941F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJLRas (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 13:30:48 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:13262 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJLRar (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 13:30:47 -0400
Received: from [192.168.2.201] ([92.22.37.149])
        by smtp.talktalk.net with SMTP
        id AuDrgpIMwwhzSAuDrgocHD; Fri, 12 Oct 2018 10:59:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539338347;
        bh=xurej/XEV3kEnL5sqZ4pAfGDj9iF+GnbWCDPkdZDrew=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YunEUOOL18DyJyNTgSqN0ubAqFG5o+LJsr79M+RNSDhtUVorRuqBT1Vr7EHkG0W/m
         j92eywE6aWcSlg2wOCWLXc1R3p4xtuwLDnK0x7w8emsahAmMisW9/mqVH1x/99jqZD
         bk9vBafb/nuMZWat86I+Ghxfd27CEN27KXfEHbXQ=
X-Originating-IP: [92.22.37.149]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=nqOWhaM9XRsRdUafe8zwgQ==:117
 a=nqOWhaM9XRsRdUafe8zwgQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=KYP4rkyYNurjfVH_Y6wA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
 <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
 <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ca3b162d-d1c6-1ed1-cb20-4232d91f7b51@talktalk.net>
Date:   Fri, 12 Oct 2018 10:59:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJUZjSa/Tnq+aWT05r7zgSW/erkAp1Y6JGVVwG4YzOhKKm5Lle8UiIaH2NlpR7gZ4H65BbmAukXkrBCX2KPh/NlmLucFrRNFouE4m4y94/ZerBDUEyJ1
 NU76D1zgaAsE2JH8kFHxOEtXNKEXmdsKgXT/qUPdMzBJkNX/ElJvxbIrHiRuhVdxJRrPLRGScQFsibGe2bBnKvXXBKL7cYf6PjaTnQGftq3QY3IKC/VJc2/J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2018 23:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 10/10/2018 06:43, Junio C Hamano wrote:
>>> Here are the topics that have been cooking.  Commits prefixed with
>>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>>> the integration branches, but I am still holding onto them.
>>>
>>> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
>>>   - diff --color-moved: fix a memory leak
>>>   - diff --color-moved-ws: fix another memory leak
>>>   - diff --color-moved-ws: fix a memory leak
>>>   - diff --color-moved-ws: fix out of bounds string access
>>>   - diff --color-moved-ws: fix double free crash
>>>
>>>   Various fixes to "diff --color-moved-ws".
>>>
>>>   What's the status of this topic?
>>
>> I think it is ready for next - Stefan was happy with the last iteration.
> 
> This is not about your fixes, but I was skimming the color-moved
> support in general as a final sanity check to move this forward and
> noticed that
> 
> 	$ git diff --color-moved-ws=ignore-any master...
> 
> does not do anything interesting, which is broken at at least two
> points.
> 
>  * There is no "ignore-any" supported by the feature---I think that
>    the parser for the option should have noticed and barfed, but it
>    did not.  It merely emitted a message to the standard output and
>    let it scroll away with the huge diff before the reader noticed
>    it.

It would be nice if the parsing used starts_with(option_name, user_text)
rather than strcmp() as well. Also I think --color-moved=no is valid as
a synonym of --no-color-moved but --color-moved-ws=no is not supported.

>  * After fixing ignore-any to one of the supported option
>    (e.g. "ignore-all-spaces"), the color-moved feature still did not
>    trigger.  I think the presence of --color-moved-ws by itself is a
>    hint that the user wants --color-moved to be used.  If it turns
>    out that there are some valid use cases where --color-moved-ws
>    may have to be set but the color-moved feature should not be
>    enabled, then
> 
> 	diff --color-moved-ws=ignore-all-space --no-color-moved
> 
>    can be used to countermand this, of course.
> 
> Am I missing something or are these mere small sloppiness in the
> current code?
> 
> 
> 

