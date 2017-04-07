Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B2920966
	for <e@80x24.org>; Fri,  7 Apr 2017 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbdDGPZT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:25:19 -0400
Received: from mout.web.de ([212.227.15.3]:49931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdDGPZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:25:17 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuuC9-1bwXJs3XA9-0103aM; Fri, 07
 Apr 2017 17:25:09 +0200
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
 <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
 <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
 <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <425176fe-090e-6edf-b6ba-fa77e35b3dd1@web.de>
Date:   Fri, 7 Apr 2017 17:25:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:458pBc1HJU59aYMEwo/GNTXoPHucR1J5yuWZE8XN4cS1HN2x1vh
 b0FdktFBPT5I+YVfltI/8CgstuzcWOGL2uO5bR3Fp14xiY2RbCpY9Bc9RPAMn5z8L6u+KXY
 vwpOIMT7aSeRif1oItN6Imq6xeH5ybsfdbIWG5CP+hasNJ3wFX4j8bS3flHQVR1wwc4Fmy0
 QeXlKIg/pjAtWLIjjDZOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cZEcsOTMBf4=:L8GIyNJE8OAqmAdyOMxnv8
 g8+pM0M6EhEFh9KV/+ys9hjjmE8SlOIP1F2UssHXEUB4P3p+iazMYoDFWs3FP3oCZ4rL3ePP0
 SGQUoToxxhGU6Dr5LOFwIF1qeml52Tj9IligZd1V+QjdaDXZUt3sMQ4CyFk+qv5o7r/f0jf/u
 DSxRK9PFHohbY69CLNMhnCspFg2cISTu+IJLhy9i3RVG1Wpr1cgN6vnrigivW3CLILU3R0Nzy
 cBIT6dzVW1UQJYlkdhC6HhZgTycX0bPrJj7wC80PtZ9f+8bBHIzgilgD+/LKwWLe5IcH7U7jv
 Kd2KstuWxRmPuhIo32m/gM0gMyAT4lJcBsfPL20QW1Om8zeOOzhYzTzKxHsRoOegeZGVLKIVR
 /rjV8DlZ+rx6cHXhUJI3/g+7fZoXKPq/ujWryhoY0szOcOgSnP+eh5+RvVlyb2L5gbCTkwINn
 cDNaLIGgiRXhcXgcNtq4rQ3FB4ts5vdgF4RjSjn6499Z5lTMrOEJKXJZdEo/XcTTSEvBEwpBk
 Aaq1CtjzYwmCrdmX2IVOFA1rRo3sStjwc1aGlMQiY78rCPnvGTmJoTYiIppov3z4XQ2MiwSa2
 dT2EqqW2MbNyEzevnmu1CthdADlAW9DN9K2UF0T8WZgNrTfARMeUCjnEsPEOohVn3wvasx+cK
 KFiW4gdBvV028NVrqfoQ3AsitouwTtxU7qacOGGGKEcYLRej1J0rvTPSR+DG1PCDF6KBO3c/n
 Zqoj4ojoXd7ZIBJRxpge9Uu9GOZFa09IDKUTXQni4Tp8h7Fyu1tt8gqrmUS5L3xj4hf/ulq/p
 lW9OSLU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.2017 um 16:23 schrieb Martin Liška:
> On 04/06/2017 10:49 PM, Johannes Sixt wrote:
>> Am 06.04.2017 um 19:31 schrieb René Scharfe:
>>> Am 06.04.2017 um 18:33 schrieb Johannes Sixt:
>>>> Am 06.04.2017 um 17:42 schrieb Martin Liška:
>>>>> +static inline void *sane_memmove(void *dest, const void *src, size_t n)
>>>>> +{
>>>>> +    if (n > 0)
>>>>> +        return memmove(dest, src, n);
>>>>> +    else
>>>>> +        return dest;
>>>>> +}
>>>>
>>>> Huh? memmove with n == 0 is well-defined. This wrapper is pointless.
>>>
>>> memmove(3) with NULL pointers is undefined.
>>
>> Then don't hide this helper behind a macro with a suspiciously similar name. Using the name sane_mmemove at the call site is preferable. memmove_or_null or something similar perhaps even more so.
>>
>> -- Hannes
>>
> 
> Good. There's tested v4.

Thank you!  I'd *still* prefer MOVE_ARRAY, though.  Patches to follow.

René

