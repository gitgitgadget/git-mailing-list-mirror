Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEAF1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeKMGIj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:08:39 -0500
Received: from mout.web.de ([212.227.17.12]:39077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeKMGIi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:08:38 -0500
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8bi-1fxVdH2Cww-00S3lj; Mon, 12
 Nov 2018 21:13:37 +0100
Subject: Re: [PATCH 9/9] fetch-pack: drop custom loose object cache
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145558.GI7400@sigill.intra.peff.net>
 <a08d8e20-ecb5-3135-f294-56dec1730b5f@web.de>
 <87efbq2isk.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <36ea6f0f-1531-70cb-57fb-8e99ea20e993@web.de>
Date:   Mon, 12 Nov 2018 21:13:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87efbq2isk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bp0LZQZmv8KZGn2f0lZ9XBSwXljeqTAIa0HISsXfhf87V5sH7uF
 2/IJjOv01rHmgSnCtsAyeSU4dUdaD+wYUS2HyJ4i+XI3JVW2mNSNtxBDca+Hrv4PSU/SyvY
 i35oDDoesOdUup/yVuWQdueACqT+xNB9dU/tjsq5I9wY4zZDPDUEEOSujVhUgJHRkmII+FK
 5gKWSsApD2eSQI/8K14yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8gMlCmipOQo=:S7hto6+xisxhzweGVfJLjw
 jT+iyVhoessHoERZCAgBfCF7yptYn3FNeBIVgpwCCR9qfKBet7+mLS7qMvG81W0qHTbdEF1wJ
 opLioAZqWq9/wn5ihFTo2GfVZoaQ/ppJ9B6LKtz6P9NFiGDCQKl/yUpQJXuNfQ+8Aom0n4clj
 l5bqUAoUWXldV0OQzrT2huZYVEbzAf/JefqsXMALrIxfTmRUeAtzXih6q0JWvkhPVyh9Z99cg
 oPs5zg2rb6kPaaJgwFnR7QA7XqMclRudohHX4Hf5Cce3OX5K5cgoH2kemgTdg0i//32GpiCx1
 SkynsY1jpE2buzmfbFFIn1nqHgVndLR8A5bvzvDSF3OwkeM+h0RgXvtYIb7FlVm2d4IHjcZSZ
 xs2625jb7SKvp2IlLPsEQDI2hf97U9aCJLIDbbMqBMFBYOj6TXPvCKRzdTFakeE8CZAaxYbr0
 fCyiku+3I5cQu1KhcQdQHBIFinU18sOON2LAMhm+3N1+wTdlFSGT0y6hhvVIevEJCdVHONhLg
 +enJ1vA+mNA29an6HmK2/nl3qK41KBx2PcqYLlBZIZIu/YUTgaAom7wsR70shi0Wegdezz6US
 L+ZePV1s2fhjhhJuhkcuVhmfOBX/NzFAMjesWbD0FT14QXBx/P+sQoBXApIxtSw/y1WM85qXP
 BBYRBvkG/GbEGfuiTPP0jOvIklGrwpqJEw9G1HMK5ilEXA7eOhkwbEjFfvfxsaGZnTAoOjR0J
 VSuX2eMXcT56Lwu3nC26ysBxmJ9FHlzRJm8yif/jRYEcJqAdXpEr1qK9zeXNeMIqOIsvdmzDe
 8lcpTe6buLQkgjsr1sS7GLpcpATnnUpTEi7l02tMqgR+kHIYyux+/viYg+73c2RvY8hmRPwai
 sJX5kGUdff/vAltkyTiCcPBi8T1iiezIDPrW/Bix5ve+Y8/dsEJO0uFnoMGkvu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.2018 um 20:32 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Mon, Nov 12 2018, René Scharfe wrote:
>> This removes the only user of OBJECT_INFO_IGNORE_LOOSE.  #leftoverbits
> 
> With this series applied there's still a use of it left in
> oid_object_info_extended()

OK, rephrasing: With that patch, OBJECT_INFO_IGNORE_LOOSE is never set
anymore, and its check in oid_object_info_extended() as well as its
definition can be removed.

René
