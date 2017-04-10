Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FAA20960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdDJXKX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:10:23 -0400
Received: from mout.web.de ([212.227.15.4]:50794 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdDJXKW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:10:22 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtFAh-1bwzqt2ZIJ-012odL; Tue, 11
 Apr 2017 01:10:00 +0200
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
 <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
 <ea0aa4ea-1c28-c1dd-db92-d4758b9dca88@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <001f55c6-a694-7dde-b14b-9d1dcc9c9a09@web.de>
Date:   Tue, 11 Apr 2017 01:09:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <ea0aa4ea-1c28-c1dd-db92-d4758b9dca88@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:g2mKBF9gWAl4PcQXOO+QzmTrRhRKbUSsWA8TM/aRg1pO1wkzdhx
 F82MDSMZnZ0edaGx8nTqfaDpnXEv+lW5HDaGRofMGomov5F/Rdzi+kRnuVm1i83aUeln9Wk
 o+1nCf1pkvakIjHVf+7QScoeUAVdVemVmrM3L0EcisndNc8HrSccvV4MN1T8EmNjy/+Mzk4
 SI9AcTPV4HRSQ+3F2Rf0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+atz2fQqvzY=:98fE4QKkyCwi13kWvOJKyU
 sENuZbzwpLd5BVnFvhwzRRQCPYAiJR5QRQ5FOgzrEZwaUt5Rp10OII7lFR1auZ/Ed58MVZgDS
 7EUwxvbxCtH7wtUXW5Et9SREf0Q8+lo8ZucbOUw+QaU1KUYQZp/W+oMzCBtAz9dkt/7vs3ZtN
 fX4qHQKKuipTZWS9Op0xab3A8Om6NKtDp7k/Acz/2cLFEC+5qdnML8tgj2ulH0OX9hZIKBMZ5
 eLVCFA7XiVyLWGOk51iHnfv2jew+5H+ymnfzIyXmFAeu4ZB8fCapM1xCQNoQxUo2ttvVgkAcX
 pJFupAZRE2nCAcDO5ufwKPffbJDQ2OE33jCyochoyzLZ+ILAmPlFPy+SkJPi818U6c/R9x+XP
 4kclusq6gajCAlOPH0ULLNQlmLMI4kfSC9xLtjGHsNC50isKP74hACh38+1ywKc2vRJdmJnNo
 YWod8rH59O5wyx8tU4h74sBsvfFu7x3ji4km6+/oFWqpqqCV7FRHNq+zwNMT5Lvc65rWQuT0Q
 7Xl7Lm8OmA6kfg2hjMs0/UlTrmollGs1BE28IqOGBj8+tq2sIsSjfZ8loAK4wJKbEjXskoYEl
 0UlrWIU8YxIfK2ndDyCCfOr/b4vGKQlWYZ7yvEsR1Jd618RuDPloHXnADgK9+rJf3flQphG/i
 YOuu3BMaqM7Tpd7vw5QQEk0r1JYPiAtkWCfdSaFOGNjdJEGYO9qe6l79CdtjnQqRpzHPhuFMs
 XapMdfoTnt5uUOMauhpWj3JlIi9hXnz4R6wI/M1UvlLGOpx2/bf7Ck44yd9IefMEfZ/mnqDg3
 fA0N8xa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2017 um 23:26 schrieb Jeff Hostetler:
 > On 4/8/2017 10:06 AM, René Scharfe wrote:
 >> Am 07.04.2017 um 17:53 schrieb git@jeffhostetler.com:
 >>> +            /* implicitly borrow buf[i-1] inside tree_desc[i] */
 >>> +            memcpy(&t[i], &t[i-1], sizeof(struct tree_desc));
 >>
 >> An assignment would be simpler:
 >>
 >>             t[i] = t[i - 1];
 >
 > True, but this might be a coin toss.  Maybe we should
 > see what the generated assembly looks like for each ??

Clang, GCC and ICC inline that memcpy call; the assembly output is the
same for both variants: https://godbolt.org/g/1q0YwK.  I guess you worry
about compilers that are just bad at struct assignments (i.e. worse than
calling memcpy)?  Do you have examples (just curious)?

Assignments are easier on the eye of human readers in any case, and
there is no way to silently get the size wrong.

 > I tried to hit the common cases.  This loop runs a lot
 > and I didn't want to put an O(n^2) thing in there to
 > look for any matching peer.  Most of the time we are
 > in a simple 2 or 3 way effort.  I didn't want to pay
 > for the looping/branching overhead for the obscure [4..8]
 > efforts.

Makes sense, and it's a nice heuristic.  Perhaps it would be a good idea
to document these choices in a comment?

René
