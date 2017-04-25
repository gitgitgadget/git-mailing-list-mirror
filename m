Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EC9207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980414AbdDYF2K (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:28:10 -0400
Received: from mout.web.de ([212.227.15.14]:61786 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S979307AbdDYF2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:28:07 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiaAW-1cQEsN2LDY-00cdoi; Tue, 25
 Apr 2017 07:27:59 +0200
Subject: Re: [PATCH v3 5/5] archive-zip: support files bigger than 4GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de>
 <xmqq7f29w0uj.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <10e59c7b-d8e4-e941-893a-bf4a68a54da0@web.de>
Date:   Tue, 25 Apr 2017 07:27:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqq7f29w0uj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zNwBklusi5nZptD9vRb1qn1j+sqEi/uoEnh55ylZ/EZUakLj/XD
 fNyovXeCx4TYW0VYaBS5LgFAMAGtmwgA9Sw9jqkIQcLrUh8qRsxNch1yrYqlIp0BKLraNtX
 RJogqNgMKfbuJbamSzw5YgaWRZTs/OdZ2pjB9WpwddEe6oq0dgs1gBM3ooF1rbBtNXo7YGY
 TonAmXUta9QsAkZJVAZAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JIGUH53fnrs=:sBtpqcM6Pb4px5NSzn44ra
 ERjd/5a6F1h/gF03AK9Rriqr2aTnUnAQzCfo6NrKB84N2oE0vfumhG+G3+Vv8KwPWaWEg0GXZ
 3qUiP65fIuZp2VNgRh+kR4iJu5XDtF9YgvEDy1D8mC0L1Visr6u/+vtCc7gEbvneMtXid3W2p
 wEPEK8DOn+NNmxE+uyUFjslCSBN5bFWN+NjlhhnyPsMIAjPYxeY4mwrodNuhc8g3rEiHXj8fP
 paLbLzRFTiMAAD5St/4iNct606IyLbzshVaGWQEKo4hVogwoIrBME22EL/oIZfVs89z8PsGO/
 VzSIPiST/6GTW3HwnOyYL1+6GXXcSi/EkE5gZZUv/aMuwSZMe+WwqGyPxRWzN60+A36aUX0lD
 Ff64Lja/ewqdhY17J3kfY8PiONjY54xROHoAdQAGQYpeVePY4qTWABqCrGypvtHhyvPvRJ/uj
 aCJ3ErgHgz08VROCdLbpod4MhwYdOScFtbnKxIk7Jb3qvT62U8l7DGFY+v/Jzsh/e1VoOSQOk
 gp7KCAuhO2gOYQkTCV6Ec5Tb/wcOp3HxMk3fIipSXcG3xU3ypDA1k3H6awM6Btv6Yma4r9jrh
 WZz/Ko1QIpxSGiFhHcWNFqfcpRcAJ85pelRXFfMbx1KQkbJEOXt+AwxIr5T1HXWpHvcHBFQLs
 DMMCH3/mkW6AW4Q5CFKzlB2p26oizkfsdX9b6xtquwDRBPeELuenIBQkEkMiveLkORumD7t0/
 xCllQFM9X+nIT1XCoS5Q71wiR/pCDJWpqFUhVsr8u+/Mi2nlqRsQWqIX8guj7aj3CgnCDITEm
 HXGH6XC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 06:46 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
>> index 0ac94b5cc9..a6875dfdb1 100755
>> --- a/t/t5004-archive-corner-cases.sh
>> +++ b/t/t5004-archive-corner-cases.sh
>> @@ -178,7 +178,7 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
>>   	"$GIT_UNZIP" -t many-big.zip
>>   '
>>   
>> -test_expect_failure EXPENSIVE,UNZIP 'zip archive with files bigger than 4GB' '
>> +test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '
> 
> This is a bit curious, as 1/5 adds this test that expects a failure
> with three prerequisites already.  I'll assume that this is a rebase
> glitch and the preimage actually must have ,ZIPINFO there already.

Yes, indeed -- I shouldn't try to do last minute edits.

René
