Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E8620281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdJBNHO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:07:14 -0400
Received: from mout.web.de ([212.227.15.14]:50285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdJBNHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:07:12 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHp7t-1e2Zjy1m1N-003fPL; Mon, 02
 Oct 2017 15:06:59 +0200
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
 <20171002050810.ryj4nv3nwqp7gb7p@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <32a8b949-638a-1784-7fba-948ae32206fc@web.de>
Date:   Mon, 2 Oct 2017 15:06:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171002050810.ryj4nv3nwqp7gb7p@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PTbWDxsoUrMH4Yr1m3sBiU8ozSKnyNK2GDDU/doQdHI5rsS9jNQ
 6aA1cFQkgqtBR9n883XOTPPVfINtWYv/dvdz821r+xSjj1Q2Ihzy/+OveB1SadwhO3QEHlq
 zSjfw+727H5xSPee0OlKVzIK1AFLAex8hwdbd9grtSbZZ06hOYTlLlfNlsm9H+OgCvIIO0i
 0TXEoXQZeikp6EN6jWSkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ub6lJt05SY8=:0u/GmERj8ptcNMF4M/CrsI
 FjCrFyva5SQXcuxz4M49oNofQu+H2vPfknYfyxPqsEDjukb3IG1CcKe/s7tqzT0d4piGgQSG5
 VihHd3ddY7HChptTeDxLL6xAiGzNKzlOPQSpklVOnKfxqVx6BwXjWmAtQruVHiRUu5t4UokQn
 KHIxhWVCmWvb/hRopa7Zidu3ifSD1BJKOq++PEO5yY2CEhGttdL0xl1msJf/vsb25MmuoIBaz
 wVfGE/JTGXGMkxrqvOVWrqD1OHFfQ8CkMu024rzQtHTpHWuTV2YmDDudCqgEZHZFCWJ+q+r8H
 bCeHmwhm5SXA+VJHwpYXJI6MBBHoip0GbAGl+u/yQn9X2Ad9+aBqKi/3+wkXzs43yO6lOupWc
 f9Zo/SurhuW21eWLoaHet8KjvDDkHXhr0EtXxR0SjN2oppuqB2NcrYJkiyk9mi5KBVqJI8NM1
 LaBMrqOrNXiyke/tii+4FEpC5fBHndB9Cwrf71J2YgU3ov0CTIxYORiPLeKohWOI6Q3RvOJWM
 0JmeKlzv01gjRq3WwG6GXoCTuGmi8HrQRUAJzo7wu6qWFvmQSwP7+r+E45YIETWUj6udA/oeH
 HlbfQUW7tSCj6LBhmi7zSF6D8LSGmfltTd/O1bAFHY+uK+z2c+6owriyiKic6XTdlzqc+nubL
 EkGIroXkyt1UX6vUfDvmYFv8miL/Ivv9VXIfiZlM0vaKWvTD9GgK5n940318h34Iim/MRTPfZ
 AAJ7nD0f7A/dSBWXxQyrEuniGV+h60ZaKsQrUmkqgdDvs0vFXkNY2nTz8/um3NuWUMchMGH68
 V4sCDveiRn0eWAmpqdCeLfT/VL81qahAUyvudV6LnpV3snCaSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.10.2017 um 07:08 schrieb Jeff King:
> On Sun, Oct 01, 2017 at 04:45:13PM +0200, René Scharfe wrote:
> 
>> lookup_blob() etc. can return NULL if the referenced object isn't of the
>> expected type.  In theory it's wrong to reference the object member in
>> that case.  In practice it's OK because it's located at offset 0 for all
>> types, so the pointer arithmetic (NULL + 0) is optimized out by the
>> compiler.  The issue is reported by Clang's AddressSanitizer, though.
>>
>> Avoid the ASan error by casting the results of the lookup functions to
>> struct object pointers.  That works fine with NULL pointers as well.  We
>> already rely on the object member being first in all object types in
>> other places in the code.
> 
> Out of curiosity, did you have to do anything to coax this out of ASan
> (e.g., a specific version)?  I've been running it pretty regularly and
> didn't see this one (I did switch from clang to gcc a month or two ago,
> but this code is pretty old, I think).

I did "make -j4 SANITIZE=undefined,address BLK_SHA1=1 test" with
clang version 4.0.1-1 (tags/RELEASE_401/final), and t1450-fsck.sh failed.

René


