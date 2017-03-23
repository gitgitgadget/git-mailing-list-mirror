Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0016B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbdCWUG2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:06:28 -0400
Received: from mout.web.de ([212.227.15.14]:49723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbdCWUG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:06:27 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIUL-1d0BXO16bR-009D6W; Thu, 23
 Mar 2017 21:06:11 +0100
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20170323155012.6148-1-szeder.dev@gmail.com>
 <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
 <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
 <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
 <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <83a38f4d-a80e-e41c-a563-05585377ac13@web.de>
Date:   Thu, 23 Mar 2017 21:06:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8zxfh8ClC6sDBXGnOJdtdyt5Yr2dHnWxoBQ/np0/fNCczQ0ma8q
 +1a/1cE0S3tkRmm4BBTq7Uxvq78q6vBX5Z9J3uLD13xbYVHaInLdbh/gn60UZD7kRKIoZCG
 jzY8U/lb2qd2/N7cFiT8993DRw8YNzWj2m9pJfk6GYaO9nyYCOdoKZkVUElZPAFNOFgl8LT
 W1VKLRscX07xssndzmSKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xh725t/sOmI=:mkjo8iBZIbGoTyZnbJ7IIe
 BFGKn96YNXjAnoAl5uNB+YXEif9bihM0o4XYUtlJTQ0t28xd9kIAD061ATojS7nWUQfoNLsFs
 MVWZIwISWNuQdIUIXEQDuN+TOqgQIGqfvuNIIzizm8Ze/OZZ3HiT1UBg53lyy1FpXv1MLhTJd
 lmy1KU8aKC9NsUuKSFGFbL8O8Ad32JIW8vV+3LbD4GLn43Wj8RcYsNwHQBrr3i1pLTAc16/xI
 ATnIDEuwadZTM1+aQ2w+1+dmCgiNnlyEjZSe/c83W7Q1rojqW3FHRBh3WR+iY0vv3JYYe0MRw
 fCDNyLUtu70LSRcn+ZsITtzFJZ149Xxmq6sd5zFLQtYWW8oyU8RRuOidpQZfIlCDYOxIURlrY
 XnUaTMg/Wk8ByEKNOOnLy4rm9rmsJu62v9hE9WGeidmMzVB2kFRNkRrO55NiNtyQEAeMKP7dl
 K048kTvSJEDGrhi9VG9Om74ZDIQvZ/YbqZoA2U3eKB/TE52NA0LIG+29oyikVrhD5vSvK7R/l
 vILQDJ8N0diMpy0ad73d54LpxIFb8r8h5Mo6uDt0Kh9Y9RIchdM4XjtnMafxtfy4AXZg5qrdE
 bOfl5pUeqkd6ebQZhNIyAdoOyTJ9G3HT8yOD6ocl/u5kq2lZW4WMORt/Q5g3Re3CXLVHXA9RN
 GjeT7ine8XmM45h1p5+TFl9FiEyvQX40VKpF5DazPiFwQDQ+9DzKx5ug1VtLIRTD1KtlcEqQ9
 ww6NGkyzz7Jrp6JxQ/Fhw408mtoKrIAEQmOzGnGuyTKAKVU4bVTF8rhNxfZelxwnXJXrg5+kF
 ENNDaex
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.2017 um 20:39 schrieb Jeff King:
> On Thu, Mar 23, 2017 at 12:33:06PM -0700, Junio C Hamano wrote:
>
>>>> Nice, but why add the "if" when it's doing nothing?
>>>
>>> It's short-circuiting in the conditional.
>>
>> I think René meant this:
>>
>>      /* just for side effects */
>>      skip_prefix(name, "refs/heads/", &name) ||
>>      skip_prefix(name, "refs/tags/", &name) ||
>>      skip_prefix(name, "refs/remotes/", &name);
>>
>>      return name;
>>
>> which still short-sircuits, even though I do think it looks
>> strange; "correct but strange".
>
> And it causes the compiler to complain that the value is not used.

Ah, that explains it, thanks.  The "if" is strange, but wrapping the 
expression in (void)(...) isn't better.

Clang doesn't warn about the code above by the way.

René
