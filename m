Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC9F202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 11:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdGHLnM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 07:43:12 -0400
Received: from mout.web.de ([212.227.15.4]:52432 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdGHLnL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 07:43:11 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqWJ-1dLrvW2BfP-009jap; Sat, 08
 Jul 2017 13:43:05 +0200
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
 <87tw2ngp94.fsf@linux-m68k.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
Date:   Sat, 8 Jul 2017 13:43:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87tw2ngp94.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ex7TGthI2flxMqMGIFafnwiLW6qTWWI4QXjOtf6DccRL1GxtSV/
 7kGwaGYCUdVyZtoJXRu0t6h7kWYhODkie3zXWQLG8npS0MsvOr8h2XxkzNF16cCDyk4CUEr
 x+U/CnOfJReWtsvT5IGvFW4uxsAu3XLV0hcCEULCdHFT01RU7iu/VhGZeZYHJJfAT49nfh/
 DrZN+rneNlCAIMqzPC3qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AbYF8TltT4Y=:k2iW8RDzqux/pK3mRSpDa4
 y/qNdlUDL8/ZgtHLIV2LGj1lmW1RwLFOt92Lz5/XzRiYM0CuJsOQeyawqujAvgAG4FjWUFogb
 Gk2pbRGBV/jSv9OmIZV7jDJ51qB3xL1usoWadcoM/vA8lEL5ha6VMGfPY8+qecd0VZ33xXyqk
 8o0waZouWqjfm6YsZwRqenSSwgy82gmr7GXUgAzFL1HREpPaO4LPd0cdoCYFfLRllRhpfki21
 u1zDzF/R1xYSkXNyrQW0JrR89tpOdZRudMj89J6quB82KHE//8w9bmbAzdcZEGS/KZPw5LpmM
 bepevlqla59RuV0RQzVPcEGAtN9ROF3C9BuygdGJo8qVD7cjAqQrXFvCk123uV1gZ/bIcEEep
 //EdBLDofVDMfgxPQW42CMXOaQb1YtZ8c3+rYkp/G7VLfIkC7hQsWYthlpPQuqTD3owsBqPqd
 oGc9nqBMfMhQzbn3g7By/aYglzUSgkaxQ3gpNLauZsEJEz4IWxfIUe2YWi9BkrK9U2uPRFsHC
 YpTqZUqAZPJZ4qCrKLo6sNtUBEph0KpEMYvL2+sH9sfo4SteXolD2XO57SbKHjodZRCq6P8js
 5sfMUeRTxOcO3Rk199c0knn1snUXVUx0lzrqC5gx0NLDdllWVAO8KBjHz2iK6IkxtUt4yvoRR
 lpwFu34O5UiHWmSgMCtCALw5aojvdo7q0+NDuTf5xqMD5Re0Q7Qj1NkX9amSd9ARq/Fq6JRd2
 AdGUUrgfnaR2wje4QE0T/qFbdgHvMleAMtJbWWzwf1XStd9v0mx37qfOBdRKTfaQZF50WIhTk
 8P6/jvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.2017 um 13:08 schrieb Andreas Schwab:
> On Jul 08 2017, René Scharfe <l.s.r@web.de> wrote:
> 
>> Avoid running over the end of another -- a C string whose length we
>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>> with another C string.
> 
> That's not a good justification for the change, since memcmp never reads
> past the differing characters.

Interesting.  Where does that guarantee come from?

ASan reports an overflow with the following test program for me on
Debian testing x64:

#include <string.h>

int main(int argc, char **argv)
{
         char a[32] = "1234567890123456789012345678901";
         char b[2] = "a";
         return memcmp(a, b, 32);
}
