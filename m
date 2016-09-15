Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B722070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbcIOTzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:55:55 -0400
Received: from mout.web.de ([212.227.17.12]:65328 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753170AbcIOTzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:55:54 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MQNma-1babo01RKm-00TkuH; Thu, 15 Sep 2016 21:55:24
 +0200
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf, part 2
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
 <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
 <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
 <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <79f6cfb5-3b9b-2ae7-d9a3-5c1c65c7d4cf@web.de>
Date:   Thu, 15 Sep 2016 21:55:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LB2ORX463FX53LbpoiioTTYIlofhVheFwnWdNl6B7kOcUhhR511
 qnv3gMvQHwJnWPQg+KwRcFOGlG3TmH9QIcIyZpp4XhH4zj+K7JU267bXvcSI6BX5ndxfln4
 fPkHRtDdEhfJtmX0XNDRFGnBVu8AFs3pJp2pgwE+lN3cnEvvj1otKe7a9VR2cyS/xtsDBml
 M7P493w+HFeHxiUDlAxIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z9IFwuUcCbU=:xdyoalzuDxLXFP1e4bWQ1t
 CRQW593s8ITBI1tawUqoG2kqGEhXhCJgOyC5/Y/dFPOHtH/+tULz3ukxv4ae+UUI3V7GqV+9B
 c5G/9xvKVNjmbuon92vyOCzM0BZ93U2HrV9BKnXrAUIA3f9hmmuMRr9z6BMZjfBmXgU2A9Zd1
 ihFEOMuKs4VBnP+qQsMOoVhFFhN8zcACDsmIVvyzEPuO4sWJTsSZ02smcNxPhvFgknG8BfWOE
 HuvJe1c76N9au64DNFO9/Mbwg6c3IytNV0WUI159ZK8JM/mMuFj6Bn8NOgO/nRWX2WSqU5BlS
 S46guqV2Z/WmSo+Nm62Hc3NxObfo2z8IvPIoqqxkZYxRCH2dCTq51VRd5wGyn4h7WqQGdcyZI
 Y2cTB35S0zf6hhB2+crziNwdnIKPP7REbs67s2KVzhUlY1O3MOOToZJOZC0G+xgMDj0J7AbGz
 1eeQmIZYQu5DUM5oYrloqiHMyl9vyCY8l5hVvXpgfkeMe2/FGTsfu3FGcBQMPIeDMj+5SPp3g
 n15e+qmAo+XsmLyC9UmFRt0WJwi3pfHdEeXtU6MJiI0eGUsAonGb1VF56i/lZWUxwM8WiWI+6
 PCfqYVPGeBgnsWUJwonv35cjQVPWHqpWK0ie4gKAj5UjQczrvc39h7lyzYLj0R+OlmWoW7h/x
 RI9U+o0kUeNcxJWu93aprbpWhrRrob59pkT3x3ZL4fCBqkb2V2LlOE1jpvM9uAi/zntXIzEWT
 SnLuQ6ekG2gRVXs99mepBAz++dvPbNz28uK9NT5vLNHZ9J/9izwYt3liFzrDtx0YQ79bwMAKp
 hH+w123
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.2016 um 21:38 schrieb Jeff King:
> On Thu, Sep 15, 2016 at 12:25:43PM -0700, Junio C Hamano wrote:
>
>>>> Silly question: Is there a natural language that uses percent signs
>>>> as letters or e.g. instead of commas? :)
>>>
>>> I don't know, but if they do, they'd better get used to escaping them.
>>> :)
>>
>> I do not know either, but I am curious where that question comes
>> from.  I stared at this patch for a few minutes but couldn't guess.
>
> My initial thought is that the next step after picking this low-hanging
> fruit would be to find cases where the strings do not contain "%", and
> thus we do not have to care about formatting. But a case like:
>
>   strbuf_addf(&buf, "this does not have any percents!", foo);
>
> is simply broken (albeit in a way that we ignore foo, so it's just ugly
> code, not a real bug).
>
> So I dunno. I too am curious.

Take this for example:

-			strbuf_addf(&o->obuf, _("(bad commit)\n"));
+			strbuf_addstr(&o->obuf, _("(bad commit)\n"));

If there's a language that uses percent signs instead of parens or as 
regular letters, then they need to be escaped in the translated string 
before, but not after the patch.  As I wrote: silly.

René
