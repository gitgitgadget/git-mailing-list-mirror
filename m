Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23775C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 07:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiBPHno (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:43:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBPHnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 02:43:43 -0500
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858F27FF0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:43:23 -0800 (PST)
Received: from bsmtp.bon.at (unknown [192.168.181.102])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4Jz84T17BWz5vHh
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:00:57 +0100 (CET)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Jz83s0rbvz5tl9;
        Wed, 16 Feb 2022 08:00:24 +0100 (CET)
Message-ID: <9ce63b16-cf75-3404-88cf-0623194db07b@kdbg.org>
Date:   Wed, 16 Feb 2022 08:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g> <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g> <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
 <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.22 um 23:46 schrieb brian m. carlson:
> On 2022-02-15 at 07:05:44, Johannes Sixt wrote:
>> Sorry, I don't find this description clear at all due to the many 'or's
>> and 'and's and no indication which parts belong together. The original
>> text was clear (but, of course, not helpful if it was wrong).
>>
>> I suggest to rewrite the paragraph into format with bullet points:
>>
>>    ... only if one of the following is true:
>>
>>   - is set and foo or bar
>>   - is unspecified and either
>>       - this
>>       - or that
>>   - is set to auto but not...
>>
>> or something along the lines. I can't propose actual text because I have
>> no clue what the truth is.
> 
> Unfortunately, the fact is that this behaviour is complicated.  I can
> try a reroll with a bulleted list, though.

Just so you know where my confusion arises from: Your updated text has
the structure (as I read it)

   if ... set or unspecified or if auto then ... detected ... and LF

It is unclear whether the 'then' conditions apply only to 'if auto'.
Even if the additional 'if' in the middle makes me think that the
'then's apply only to the 'auto' case, it is sufficently vage because in
my mental model there is not much difference between an 'unset' and a
set-to-'auto' attribute, and I wonder why the 'then's should not apply
to the 'unset' case as well.

Moreover, after re-reading the text, I notice that text may be read as
"this attribute has an effect only if <conditions>" where <conditions>
basically means "always except for when the 'if auto' case is not met",
right? Would it perhaps be better to write "has no effect if <very
specific condition>"?

-- Hannes
