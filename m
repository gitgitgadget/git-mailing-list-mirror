Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A9C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0139F20706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXRVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:21:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29912 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgDXRVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:21:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4981Dc3dWMz5tl9;
        Fri, 24 Apr 2020 19:21:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B6A5441B5;
        Fri, 24 Apr 2020 19:21:34 +0200 (CEST)
Subject: Re: [PATCH] userdiff: support Markdown
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
References: <C28ZH8NBU8BS.1WKC7DSJANUIM@what>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <91ff4bdb-9b53-8fd1-6282-ac19a9caf1d8@kdbg.org>
Date:   Fri, 24 Apr 2020 19:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <C28ZH8NBU8BS.1WKC7DSJANUIM@what>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.20 um 01:42 schrieb Ash Holland:
> On Thu Apr 23, 2020 at 9:17 PM PST, Johannes Sixt wrote:
>> Am 21.04.20 um 03:00 schrieb Ash Holland:
>>> diff --git a/userdiff.c b/userdiff.c
>>> index efbe05e5a..f79adb3a3 100644
>>> --- a/userdiff.c
>>> +++ b/userdiff.c
>>> @@ -79,6 +79,9 @@ PATTERNS("java",
>>>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>>>  	 "|[-+*/<>%&^|=!]="
>>>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>>> +PATTERNS("markdown",
>>> +	 "^ {0,3}#{1,6}( .*)?$",
>>
>> What is the purpose of making the heading text optional? Why would you
>> want to match a sequence of hash marks without any text following it?
> 
> Strictly speaking, a markdown heading is allowed to be empty -- see for
> example https://spec.commonmark.org/0.29/#example-49. I'm happy to
> change it if you think it's more useful to show a previous heading which
> contains text than an empty one, though.

I don't know what makes sense, I don't write markdown regularly. A quick
check shows that the sequence of hashmarks appears in the hunk header.
Is that useful? (A genuine question!)

-- Hannes
