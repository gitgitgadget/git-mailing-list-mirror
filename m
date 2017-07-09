Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE499202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 12:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdGIMUj (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 08:20:39 -0400
Received: from mout.web.de ([212.227.15.14]:59585 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdGIMUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 08:20:38 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNtP9-1daTWc40Tr-007XQJ; Sun, 09
 Jul 2017 14:20:34 +0200
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
 <87tw2ngp94.fsf@linux-m68k.org> <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
 <87o9svgia8.fsf@linux-m68k.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <df3bd047-6ddd-c120-54dd-4165d2257bb0@web.de>
Date:   Sun, 9 Jul 2017 14:20:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87o9svgia8.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BAHymA8bRZUxhao/yMZEBz9SLJteX7zbuzUTqsGD6F3We62Iq1y
 Qv9qMTaMdOkv4L1qJoBUP1TBCoaTfJzbuFvj/94fG5ijbFgZrKuf/oj7k8CBsCg5VvGqb9Z
 jy9lvOqXbprD7JGOHRBC71ldTxzUKP5mACxSsfuKM1pqzvzANPt2o2v39FzYNdEal1q0MIP
 4iHLYW+LRulkV1a2Njy7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XvhR0+HAom8=:0x3VM2MFoL8zCwwDaDODa3
 A/uYBYZvSiKty81aPGwK70xj+UU6iHEFM4flmu8xoaOyzib922hGWayy5qxKhMfjkXS9H09/P
 pUZ8FlkPkBgpPKt3yGe8YQxjC9zQVeVkM8OxuzY+1ei4ar8eBu71O7tuc21ceQypWLO1NGdcx
 iSm0vVFV31e43ZaE2eeS1jnhHJ7HyXOlCA5yosXCPYli0P4gZbsSWV0g9fQiVAjgkKluxYqJf
 Bwyoevh2i0fD76DbDo3eGOJprbHbt54BK42ECFaJ3G4YKt3yuuJlJZ0FUWiiPcqz6A/TusZvi
 47N1fBcNOGtr43DVmfpPSl7NdV7dfEMqNj1du9adfHmNceMLasP4dg9vFzZday0ZPunP0ktIA
 gMw6e6VBp/qXIuZtrkZ/T7w59DOXq4yFgnK3b4ipVhwriwkYHHyahtNHW/SJl3dNoJ547qJSF
 90US0olQMWtAZ4pVophpnrsS56P/8yO+dpYdkilDsr8lKJ9J4xO50h0TILemREg6BX3zyXEfO
 v4yy5mxRIiVbO04XPs7JWTTp4hoO86Y/9T7WHexF1ylKgR6B3qBZph3/0Q6REC+YUamw2QtL/
 IYyjFY6dy3qmqK219VaCzA6vRyRKtOqRfHz+N0xLJ1p52Fmmgz1WTAgAUXcygCjvVD5Myljg7
 H8CgAKCqyswFF9Fc9nwnlqe/7GCGMIK0qZ+UVzYuqjyLtbea9oUAJdxv8Xb1ep8sqKZQFPAc0
 3LoCcFedyflSm4VVAMIUcxpIqBns9b+E4uE4fCONHYF4r3f7HHBSlaS/Eg0pCuRLpB137zGO7
 O4/diRf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.2017 um 15:38 schrieb Andreas Schwab:
> On Jul 08 2017, René Scharfe <l.s.r@web.de> wrote:
> 
>> Am 08.07.2017 um 13:08 schrieb Andreas Schwab:
>>> On Jul 08 2017, René Scharfe <l.s.r@web.de> wrote:
>>>
>>>> Avoid running over the end of another -- a C string whose length we
>>>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>>>> with another C string.
>>>
>>> That's not a good justification for the change, since memcmp never reads
>>> past the differing characters.
>>
>> Interesting.  Where does that guarantee come from?
> 
> Sorry, I misremembered.  It's only memchr that has this restriction.

Hmm, I can't get ASan to complain about memchr reading beyond the end of
a C string, but I don't know why.  Glibc reads full words [1], and I
don't see how the standard [2] forbids reading past the found byte.

René


[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=string/memchr.c
[2] http://pubs.opengroup.org/onlinepubs/009695399/functions/memchr.html
