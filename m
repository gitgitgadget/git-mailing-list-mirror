Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1DA1F829
	for <e@80x24.org>; Sun, 30 Apr 2017 16:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422676AbdD3QkL (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 12:40:11 -0400
Received: from mout.web.de ([217.72.192.78]:61709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035511AbdD3QkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 12:40:09 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWAwH-1dcEa81xIv-00XJeT; Sun, 30
 Apr 2017 18:40:01 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
 <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
 <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
 <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
 <9f6cb421-db61-51ca-6a4b-ea7c94bd513e@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d1cea1c3-f974-c839-dbdd-5bc95756be84@web.de>
Date:   Sun, 30 Apr 2017 18:40:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <9f6cb421-db61-51ca-6a4b-ea7c94bd513e@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BlpKXz7B8AImR5KXr2kTshSSIFDzi9Y78WELVwREkhP8uPxiowf
 g85wDfOA5xUdzWDzZL0Qfj6hu/v5N/QTWlcj0Bpd7Pq6QF/1BkhC5YXPwZeQefMvMQ3s6Ry
 PN32LgcGI/0xG7U30aqUbbuSNTnovoZrXLiEccreIAJylJc1+1hMiCsjbFY5bPW/5Y6OGdA
 MX/rJjfEqvnYNwOfk2NMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yuOPS+JlC3A=:nmQudc+RpqlCzEiDo5TEb7
 bEOulLAV3OGV5KO2Xa7ayiWLD1pEyBgR+7j/A7lc71i4721ec/GI6GDYCOsD+VG/WNnJOYXdy
 xQS4umwqSbE9k2wsnlryWHt82gyyefyVDqW39zwfmj4DniQB3S+BVrBnxd8nvSVGQmyGQSXAi
 W/FYo+W1CKLJ1HClMNLKPlSZCIRTRywk4g8zHomNvyUDEMuaJvloRnM7E4DqMK4GR0l2rXL5H
 ps33qBCjjhGQ/TRtFKU7uDVp5KjnfCFsYWvQ4OAkk62daxYthW0OCl24kNiHfSlnnVEOCzNf1
 iW93gX98ypC9ugehPmxR9BkQVSM9x0qL2GcpZVm4MDsd81dHzF+FCnuRKlXMjYrLJX94jbyQ5
 SSh6hREIVBSExIzfMth5bfA7sZNedmW5BGuXpQaJMDL6Wv9dcTf+UJwVMcLMfYayvnx2KbvPH
 GNii+9PiVBGTqDHqVeWa6u/FfEL/Z3+GkgQ4+ULmAGfoDylalDvZ/wUVLteXlPYejbr77EbG/
 cv95SWtKDQw6GH3X4U5fQ73aeuFGQ4WJ9qRlQfP7PP79Vv+I+NrrQnfhY6dwNlSRvO5VmN9IU
 00w+xaO3xZC4KncWfz9bOy0A3JF9GgMbZGd8o92KsPRopGsJ2DOc09XdeIe9ZFp/YGYsFpmkj
 vndHDmtcbN9zvE3tD0svJXkVNjO4GvFq2KBGvGmHntrdR0pZU/w0vlutOlbtmoXz3ZF1gF2pB
 i8tlt+m8rI3HCx9b2zvk4qZdFDL0dZKNfvUxISxnK5sybKub8f1gbhY8RJSG3Tb1U+yrs2Y5X
 VHvj37R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2017 um 18:32 schrieb Johannes Sixt:
> Am 30.04.2017 um 09:53 schrieb René Scharfe:
>> @@ -178,7 +182,8 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive 
>> bigger than 4GB' '
>>      "$GIT_UNZIP" -t many-big.zip
>>  '
>>
>> -test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files 
>> bigger than 4GB' '
>> +test_expect_success 
>> EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
> 
> Why is LONG_IS_64BIT required?

Blob sizes are kept in variables of type unsigned long.  64 bits are
required to store file sizes bigger than 4GB, and this test is about
such a file.  A 32-bit git can't use the pack we supply the test file
in, so we have to skip this test.

>> +    'zip archive with files bigger than 4GB' '
>>      # Pack created with:
>>      #   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object 
>> -w file
>>      mkdir -p .git/objects/pack &&
>>
> 
> -- Hannes
> 
