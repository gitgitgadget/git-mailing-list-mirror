Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75F1202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 18:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbdIVSBz (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 14:01:55 -0400
Received: from mout.web.de ([212.227.15.3]:58391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbdIVSBy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 14:01:54 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu1Be-1dD0HB34rO-011RGf; Fri, 22
 Sep 2017 20:01:27 +0200
Subject: Re: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
To:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
 <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5e21362b-7c42-37f5-73a8-907d4ad5db86@web.de>
Date:   Fri, 22 Sep 2017 20:01:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:V77dq2fGL+LXMwWdy73VqhsLYfQQsinsusq8lafWleIny3JFwJQ
 fSppGLGJ5ewboW6nWvOOVkYve88X2SC4hpUaySJok/PSH5eLDkVHo4JxJmrhWNzHlH+Z6JS
 VbTdItZWoFdgwGxAoylnWmuWwgQuOFiYkVJS1YBfmyOISIZ33mv99k5mAckKRIB6iq1BO2d
 fFBA2uQUcGFWRzTihV2xA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sl3TNOLneU8=:uOr1xj1AeWBK/jyvrw/NBa
 HtAzMeLPl4620tIb8iuUyR3dL1WTPXExnFRDARZUtsS5nojvHugG9TOE8x926FaeaAqKnXg76
 oo86dnO+EgVMarWlPxcSFeiFq++g0+Yf6UftOLQK3pSMSUCEUlNYceDU/pgMFasa4L3GBR6xZ
 0nzvoT7aEpVwzQj/gl0+sF8vVMQ/WoUFxjmbhZqiK4GO7HmNdnXriAy6DYoLSKQkWUWzVMWPr
 S+KINNKek0KHyJjvm92UbUoNb3ulQocgSiUjmMRLcmBUy755OljzfPR3anEp6Abpax4MXPBqe
 UKCNlxZOPozidPM8yYAt4ssrZys7rMuQQScaV6wDpgeJFuuFZDzwxeSaEOYMqf/T0bndGBOl9
 B50fL/aAm/7OgpiTv2dkPTZEZCrLlkTgeekLnwb2whABB52bsBZRNR+QrUvtSsD7RkDvlNgmv
 yiv9qsPhRQh57r26dgVMNDyPdMjA2SZKl1gJF5SEGx543yHsDN696FXEFS5pH67xxUThXfrBK
 BODnKhjQzynOTFiZj/5fWUw5JMJbdN3l8Y6o3W5u/CrBE2f/acQg6KLGN55tYWNjASboKDXEV
 7jb6ySG4CrPW4Nc68qjXSH2sPH7jf0rRV7X7f59FI+q6G1B3/vxpcIIkWlJH5FUoIEr4W8Xz3
 7Y+WOV8QsMMj8JQ0xO7s+Jy3EXI0RBBAW2HhZBsI6QKIB23u1P6pZahmdsU0u0NxQx0DVPBk9
 OiuqjcrSmk8eI8lSe7SkTgAS82JeDC7OfQazNlWQfJYNOGXpY7FcsflJkSjJocwblNiubfmoJ
 3U22sIBfQItEcEV9mp3goOsHYSchNlehvD+Wu7BvEbw8/kEU6k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.09.2017 um 07:47 schrieb Jeff King:
> On Thu, Sep 21, 2017 at 05:48:38PM +0100, Ramsay Jones wrote:
> 
>> diff --git a/cache.h b/cache.h
>> index a916bc79e..a0e3e362c 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1243,8 +1243,8 @@ static inline unsigned int hexval(unsigned char c)
>>    */
>>   static inline int hex2chr(const char *s)
>>   {
>> -	int val = hexval(s[0]);
>> -	return (val < 0) ? val : (val << 4) | hexval(s[1]);
>> +	unsigned int val = hexval(s[0]);
>> +	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
>>   }
> 
> Ironically, the unsigned return from hexval() comes from internally
> converting the signed char in hexval_table. And then we again return it
> as a signed int from hex2chr().
> 
> Would it make sense to return a signed int from hexval()? That would
> make hex2chr just work as it tries to above. I admit that shifting
> signed values is a little funny, but it should be fine here since we
> know they're no larger than 8 bits in the first place.

I'd say yes.  We can replace that shift with a multiplication --
compilers will nevertheless use a shift even with -O0 (if
beneficial).

> As an aside, I also see some uses of hexval() that don't appear to be
> quite as rigorous in checking for invalid characters. A few
> unconditionally shift the first nibble and assume that there will still
> be high bits set. I think that's generally true for twos-complement
> negative numbers, but isn't shifting off the left side of a signed
> integer undefined behavior?
> 
> And mailinfo's decode_q_segment() does not seem to check for errors at
> all.

It also allocates and returns a strbuf, which seems odd as well.

René
