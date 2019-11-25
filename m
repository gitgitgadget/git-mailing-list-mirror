Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09EC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2520718
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DiqepkMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKYCYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:24:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54125 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKYCYM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 21:24:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81A858A741;
        Sun, 24 Nov 2019 21:24:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hf8UNcijNtBTPYV9NxvA4S+0C7s=; b=Diqepk
        Mwi8yNTqkYwQfUGmAe9N2ZDGhXWtUmOTJUg1DLn6zzBBcjyNrcskpHjtV37WMpA/
        outcaok9AToiap1qiurqJ06gxSgbJGsU/YIx+XlfBQP2V7U+OQ6jfC7ezec/ZyQp
        A0iYAV3R9Vp0J1IG7SP4YDKLPcqLL0BhTmEjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CbllVdYeWHDQs0t965rJTKJLIlRtJ0et
        y/+fg3fbjWEK2uoNDqBCHq9X2lUhcgMOkAyzhMh0Xed6SP3IcqZkELKS6PBuQFN3
        uy8lqblrUoJ70M0NN+0qO8pAnthaEushVm3SXiVxut4ILBlN6Uqd4sCPTLYTkCkJ
        IdEJhnhGryA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79B138A73E;
        Sun, 24 Nov 2019 21:24:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF1718A73D;
        Sun, 24 Nov 2019 21:24:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
        <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
        <20191124170643.GA16907@sigill.intra.peff.net>
Date:   Mon, 25 Nov 2019 11:24:02 +0900
In-Reply-To: <20191124170643.GA16907@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 24 Nov 2019 12:06:43 -0500")
Message-ID: <xmqq1rtwzoal.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6BC8538-0F2A-11EA-A6B3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Nov 24, 2019 at 01:09:23PM +0000, Hariom Verma via GitGitGadget wrote:
>
>> From: Hariom Verma <hariom18599@gmail.com>
>> 
>> Git's code base already seems to be using `PRIdMAX` without any such
>> fallback definition for quite a while (75459410edd (json_writer: new
>> routines to create JSON data, 2018-07-13), to be precise, and the
>> first Git version to include that commit was v2.19.0).
>> 
>> Therefore it should be safe to drop the fallback definition for
>> `PRIuMAX` in `git-compat-util.h`.
>
> I noticed this recently, too, and wondered if it was time for a cleanup.

While I agree with the conclusion, I do not think I agree with the
above "Therefore (implying that the lack of need for fallback
PRIdMAX means the same for PRIuMAX) it should be safe" as a good
justification.  That reasoning assumes that the outside world is
much saner than us.  We thought PRIuMAX fallback necessary while a
counterpart for PRIdMAX unneeded---the outside world could have made
a similar mistake and in the opposite way (i.e. only defined PRIdMAX
while leaving PRIuMAX undefined).

But I do agree with the alternative justification in the following
two paragraphs you have given, which are ...

> We do sometimes get portability reports more than a year after the
> problem was introduced. But I think this one is pretty safe. PRIuMAX is
> in C99, and we've been picking up other C99-isms without complaint.
>
> I was curious what system originally spurred this. The PRIuMAX
> definition was originally added in 3efb1f343a (Check for PRIuMAX rather
> than NO_C99_FORMAT in fast-import.c., 2007-02-20). But it was replacing
> a construct that was introduced in 579d1fbfaf (Add NO_C99_FORMAT to
> support older compilers., 2006-07-30), which talks about gcc 2.95.
> That's pretty ancient at this point.

... these.

> This part of the patch looks obviously correct. :) But...
>
>>  #ifndef SCNuMAX
>>  #define SCNuMAX PRIuMAX
>>  #endif
>
> Can we likewise ditch the fallback definition for SCNuMAX? And PRIu32,
> etc? It seems likely any platform would either have all of them or none.

I guess that's also a C99-ism that we can use?

Thanks, both.
