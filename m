Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848871F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeKMFgI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:36:08 -0500
Received: from avasout04.plus.net ([212.159.14.19]:47244 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:36:08 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id MI5Ngud3PYyh2MI5OgRerT; Mon, 12 Nov 2018 19:41:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MoN8FVSe c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=fG13hfXLm8Bugjm2HM0A:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/9] rename "alternate_object_database" to
 "object_directory"
To:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144846.GC7400@sigill.intra.peff.net>
 <315c0fd5-e7a6-2c85-ba3c-861522c703bb@gmail.com>
 <20181112153600.GA12232@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <42e24eff-11f8-ca6d-0633-7acd4590923d@ramsayjones.plus.com>
Date:   Mon, 12 Nov 2018 19:41:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112153600.GA12232@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJtW2JyU5AGJgWtLRZvXpi6ezqK9BnT4YCMYru/IUNdI4XKDN04g3/1zZmzBgrydw/P/8/Z0O4z+pBtgkbCJ7RLidxt1JY4VWZ346qTQVLGHtfJgCBor
 Jgq/6GUfO9EmC+SxVNaJ3tz+ZDBM43qcdpMqIyTtOYldG/nG3kOp/pTR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/11/2018 15:36, Jeff King wrote:
> On Mon, Nov 12, 2018 at 10:30:55AM -0500, Derrick Stolee wrote:
> 
>> On 11/12/2018 9:48 AM, Jeff King wrote:
>>> In preparation for unifying the handling of alt odb's and the normal
>>> repo object directory, let's use a more neutral name. This patch is
>>> purely mechanical, swapping the type name, and converting any variables
>>> named "alt" to "odb". There should be no functional change, but it will
>>> reduce the noise in subsequent diffs.
>>>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>> I waffled on calling this object_database instead of object_directory.
>>> But really, it is very specifically about the directory (packed
>>> storage, including packs from alternates, is handled elsewhere).
>>
>> That makes sense. Each alternate makes its own object directory, but is part
>> of a larger object database. It also helps clarify a difference from the
>> object_store.
>>
>> My only complaint is that you have a lot of variable names with "odb" which
>> are now object_directory pointers. Perhaps "odb" -> "objdir"? Or is that
>> just too much change?
> 
> Yeah, that was part of my waffling. ;)
> 
>>From my conversions, usually "objdir" is a string holding the pathname,
> though that's not set in stone. I also like that "odb" is the same short
> length as "alt", which helps with conversion.

While reading the patch, I keep thinking it should be 'obd' for
OBject Directory. ;-)

[Given my track record in naming things, please take with a _huge_
pinch of salt!]

ATB,
Ramsay Jones

