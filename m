Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AABB20282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbdFWQXN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:23:13 -0400
Received: from mout.web.de ([212.227.15.14]:62982 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753900AbdFWQXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:23:13 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mcnuz-1d6Uy60Uqn-00Hsf3; Fri, 23
 Jun 2017 18:23:03 +0200
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20170623144603.11774-1-avarab@gmail.com>
 <a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de>
 <20170623152554.jybv2vtsnjsoedoi@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eb492fbd-5cf8-4014-acee-d9aca84dea24@web.de>
Date:   Fri, 23 Jun 2017 18:22:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170623152554.jybv2vtsnjsoedoi@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VT0fr+Rtmr8uPfAeXBn5n+5gW8RGF2rx54L3fv8mErf1koAKS/9
 FEA9GjDVt217zIn7nd3PiTa6pEokPCuuaAIJ46BXjRR1Zr2k4sR6W0Vd+VmDqRyU9ftdZPP
 j7HcMCBabhJ2ER7Lmf6lMXUntshy6Ya+Xo9S5pbze/+4wXVuHT4NgT9Jdgx5oWcAezp0SDT
 7djbHwhFdovlzwl1T2AWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4hl0IS5pRPg=:SzshfMV6AI9eygY0YHfUOn
 k8AlDb/sVXkigzU9Nmy9CyccP2oJg7N4NvnVcOqJtVKN3xaVo18gvJxkV9/R7LPUdj1QwIU/4
 1kBiXH83QIGGHQZSDMB6AQ1k/CNy4xX8BXw7vJfisQGZQ1/mYzA6yGrIEBmQxT/UC22s9E3jw
 S2n8ExA6mSGONvgQ87mcsU9YfadVJxs5DZ8/8Uu4AcEu+z/u1VYG2lNV45Q82oBF7q3phSzwK
 brxZLXweK7RLz84/gPnXOS8HLIsHL+7HhNDbS9gReeylVGhnt7GUQV6iVG8yvRCSPwHPNABr3
 12XluqrtFg1jDILHwmt31vTcUKY7YBpxBRFQWddlZfiV/NicCe/YuHSk927rOqqv+8Jqfh+RQ
 ltKA5MnIGVa50jXi6MjgoUjB4jQaqscqcXUdVh7bXL58tB2EUn4QHv+B9WYFSi1w1RCCHbYn7
 nnUHMx3nsmJoMCSEoEON1jyS4vA8UManh1xJg64ZfRvbuAgaAbmpDnDts/7pKT+mOWLHSdIXR
 D/snDV3ie7rsIEiKDgjCPuXJvwERN9I4TJJnoBcmN9QTjiyI4LYxR2FFRPJldK2P3ENI/zvpg
 4KZi2OJq3t9Jr5MK3MdDnKMvX/syr/GIR6INm3uhcTLFJiQAQv42XY2Fkvz0omAAL9NuGO5uK
 p5nok6cOTWZNuqNk8u8jHtS4L9wYTQuQX/EsS0UXSVZ4BxXNooRwhMZH1qCovCMdv0QFXQqXY
 Zim+Ouv4LXTRbZcO6VobnQ4zUEuJ1HM94aCEBt7xX7dSVBAfAPM3+AC4WAofeekH2S08NAONq
 MPCWC+k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 17:25 schrieb Jeff King:
> On Fri, Jun 23, 2017 at 05:20:19PM +0200, René Scharfe wrote:
> 
>>> diff --git a/strbuf.c b/strbuf.c
>>> index be3b9e37b1..81ff3570e2 100644
>>> --- a/strbuf.c
>>> +++ b/strbuf.c
>>> @@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
>>>    }
>>>    void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>>> -		     int tz_offset, const char *tz_name)
>>> +		     int tz_offset, const int omit_strftime_tz_name)
>>
>> Why const?  And as written above, naming the parameter local would make
>> it easier to understand instead of exposing an implementation detail in
>> the interface.
> 
> I think calling it "local" isn't right. That's a decision the _caller_
> is making about whether to pass through %Z. But the actual
> implementation is more like "should the function fill tzname based on
> tz?" So some name along those lines would make sense.
> 
> In which case the caller would then pass "!mode->local" for the flag.

We only have a single caller currently, so responsibilities can still be
shifted, and it's a bit hard to draw the line.  "Here's a format and all
time information I have, expand!" is just as viable as "here's a format
and most time information, expand, and handle %Z in this particular way
when you see it!", I think.

René
