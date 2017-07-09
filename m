Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB25202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdGINUO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 09:20:14 -0400
Received: from mout.web.de ([212.227.15.3]:51440 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdGINUN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 09:20:13 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjrU9-1e5zmf07MP-00bvuE; Sun, 09
 Jul 2017 15:19:56 +0200
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
 <87tw2ngp94.fsf@linux-m68k.org> <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
 <87o9svgia8.fsf@linux-m68k.org> <df3bd047-6ddd-c120-54dd-4165d2257bb0@web.de>
 <87lgnxpyzu.fsf@linux-m68k.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <52d0ac32-7b3d-990d-8ad9-42ef9ee8d8cf@web.de>
Date:   Sun, 9 Jul 2017 15:19:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87lgnxpyzu.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZM/IXYEIm1RFsLIZbgCw/DSUJzONUuooOZaeljGQCE1D0rTsl8a
 f+bIefNLt21Bx5Ee9Dp1Gx3ypJeGEHhSUC4W4x/D0KyFb2bAfrU1yNJr1KKw7qeDvSsJrPg
 Vw5rYlyIH2mQQnNMGOUd0x2SuusC96XZ7NTctzkY2viHK4dybFPrSfa18Y4I2X9Z7xoOxfH
 3i4Ftnx4anizer4cyRIxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jwtFRlT7sZ0=:/PLGaRDzuAym7q0RZcN0CD
 8gpqIflgZPqYsjFBC8tqdCaaFUsFdED2MTdR28AG9AgNcMvvn01hHGYaqvHKW23uqfiEydDzx
 BisiFU/NAXz174VNm9LOuqH7+hG2EM71IVTcVWS4E6L+RuwSLinwStyKAZ2GrB5werSPAlgDF
 j2pUiEzW0GIXcksyqxBIF95enzHVmzueKtWZhaAiyb0eiav9UaXeqe61WxPHAJusroSE/Jfp3
 oYeMqpljjqtjLalzxOlPiLup914eZ8LHsWCvdmzz2NDYqlfpbyvkZ1MzcKZCDPgXy4jWW3pXN
 6ZCbc9r/OXN02g/vFQJ9P53c8KbYGDozgvHW0NVKo8zKcs+FfqXxdzALXuQy77ypsIhps4FuJ
 30USDap08ghWncpDrzeGzhes0027arrvFbmJYdIaSk73Jb2f3Ots+k+DrhR0O9fKSk7CYabYu
 RcJCXtt1kvjrWSnn3zw+4QYotNOcDv59XFPHsjcovMGo+TiEXRHoRn0ZRV+bBQQMzeBrXT2at
 Fj4xH6Poq4hlVH0mv/EygI6PsKdS7vw3g+lLchA81IC0pKvquTFceC2nBV2ruJgcnrhvAuC44
 B6bvUF7558Z77fjvkv3zexy4J5WeWUz7gih3TnHf/37ZfH/9zz5zYOGI+pfFBir+QfVaEMOi5
 5k2CycfTkAv/31A8Zsp+NYreqsPYXXGKkpoFNr6DaR0odYITXI5te0q2/lpHFBuCYImuQH6sa
 GxDo8zzvAbHzobvgT86KQ75zHEBYQIKiJp+HKzJPUGTVWpj87kIHYfyvjRNeyPvF79dbSQ/rK
 YwN/3IU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.07.2017 um 14:37 schrieb Andreas Schwab:
> On Jul 09 2017, René Scharfe <l.s.r@web.de> wrote:
> 
>> [2] http://pubs.opengroup.org/onlinepubs/009695399/functions/memchr.html
> 
> You are using an old revision.

OK, the final draft of C11 [3] says "The implementation shall behave as
if it reads the characters sequentially and stops as soon as a matching
character is found."

I wonder when we can begin to target C99 in git's source, though. :)

René


[3] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
