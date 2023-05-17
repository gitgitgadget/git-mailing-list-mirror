Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48488C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEQTbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjEQTbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:31:00 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684371733
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:30:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34HJTNjg2790556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 19:29:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Christian Hesse'" <list@eworm.de>, <git@vger.kernel.org>,
        "'Christian Hesse'" <mail@eworm.de>
References: <20230517070632.71884-1-list@eworm.de>      <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>      <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>      <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>      <016701d988ea$4e4ffcd0$eaeff670$@nexbridge.com> <xmqqttwaq133.fsf@gitster.g>
In-Reply-To: <xmqqttwaq133.fsf@gitster.g>
Subject: RE: [PATCH 1/1] imap-send: include strbuf.h
Date:   Wed, 17 May 2023 15:30:32 -0400
Organization: Nexbridge Inc.
Message-ID: <017301d988f6$0fe7eb90$2fb7c2b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNCvfHGg6mwyi4A2rl62H/zgjrb8AFjxtXPAggd4roCWVvaKAEHH+70Aq+7NJYBrkdDuQH7BfrhAe06PyWsE9pMIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 17, 2023 2:12 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>Oof, yes, you are right:
>>>
>>>    diff -u \
>>>      <(gcc -I . -E imap-send.c) \
>>>      <(gcc -DNO_CURL=1 -I . -E imap-send.c)
>>>
>>>How *should* we test this?
>>
>> I hope not by using gcc, which is not currently a dependency. Using
>> the C preprocessor directly might help in a more general sense, but
>> you probably will need a knob for some compilers to work.
>
>I am not going to suggest trying all permutations of CPP macros to make
sure we
>cover all the #ifdef'ed sections, but -E to show CPP output is pretty
common feature
>not limited to "gcc", so if we were to do that, we'd very likely use the
usual $(CC)
>Makefile macro to invoke such a test.

-E would work for me, but I do recall other platforms that would not (but
can't place them at the moment). No objection from me, but it still might be
useful to have a variable, like CPPFLAGS=-E (by default), that might help
others, in config.mak.uname.


