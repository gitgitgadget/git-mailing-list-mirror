Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FA2C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDFB2481F
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgJMO0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:26:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgJMO0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:26:03 -0400
Received: from [192.168.100.176] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhDN4-1jxwNK12Is-00ePje; Tue, 13 Oct 2020 16:25:56 +0200
Subject: Re: [PATCH] gitk: to run in a bare repository
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
 <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
 <20200123192707.GA110440@coredump.intra.peff.net>
 <8be28321-3108-4846-ac6a-d5c7977774dc@onlinehome.de>
 <CAPig+cT1drHWic4bm=NPMd4RnGuLe-WwUJ-82nHkze_ZOoYerg@mail.gmail.com>
From:   ch <cr@onlinehome.de>
Message-ID: <96216301-e831-3fd0-8bd8-8d0d752c580c@onlinehome.de>
Date:   Tue, 13 Oct 2020 16:25:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cT1drHWic4bm=NPMd4RnGuLe-WwUJ-82nHkze_ZOoYerg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m6l9KtNcNVTJQ/losg6wO+qRdVGONTLDrS95U70TG0JumK/RzCx
 XKuih2BSPsGHAymIwc/q6J8jMkcWUYNdEz1IDowI2YuYdS9WtmltaDyy2KWprncajCpj0yF
 CGKUBl68uqmw383ocshRYkCiOo0gHFD+BC4/LwfBzuasbelXdASJYWy8wClcb+VZS/YdUmZ
 lVOp8jt1WPC1clsxMc2gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9+R5ZSQQ0U=:FPSYnVkzpYlqZliHa9azVR
 1FX0DmWQBZt2MRua9bcp89CIaujawzzHDbi5ElgdF+e3wuUJR7UCrYMI19U2BZsXZDK1gN97P
 HGO9eWk9GZsjMe6kLZQlVrczc8i4MG8WzJ/vOB88ofInU32rbEru7/XsPBsGXmbHGqVqAdTIb
 DigyIQZCEY/z5nQbnKHUNpVOu2vx3bXFhHyEFzjp+ZcJeADoTLuG58Ox0tr4aGFuGi8ME0YKH
 h9EfE6+MTsqHMy8scCxda7P78h3JnaRFRd/JFVgfJoVcZWdU+sqr7vvGJ7ghAQIxj7Rv+f74d
 gqDD48Gmc/ZoAjr8f1343+qmNAGDEuwE0Tzg1uBxZ+lZxKE1kJXfYlkGUeG5Rb7f0KwK9YcI1
 FsDU/eQABVaHxSGbpBwSANNNW0tT7UkPw4hJcQXoclJFMPyH5BChTajHA7+8rctcUxU4svBj0
 kRkbHsjvOMoZW9aq7qyc1N1o8mcZ3Zg5pHOCP+tE3/TPvBw4fl2oc1OK8/wPjByiLEfETp00R
 CrXbNUX9fEtUp0GfDVHgdMsPJQR8vGhvDXcRBVM5ym+0sTRdoGfwQ/XqQyGnXn9IZ8XErUaVf
 w8Om7+1T1jB/z1dLr4rlituH4zzZsFBUnXpxUTTKr3tBSow3tFkp2E5nuoA89Nd4KbTk4IPHo
 IM9BqcQnej/w3rlLlrKvSO1fBmXbCVcmb74IaDbbnjC8/Yu2zViBKHNSOwwnv5DXocNwYwTOZ
 Qg2ugA6wjEZlGI1mYi+XAzPg64LK0OLe0JxBVO2QOHe4/hknNEnI3CpP+aM2SBAGjdC4XuZHl
 UjlymybUICmjzAueL36ILbIvBc58T8iWNHtNm/kJUXMikElAecfsdN9RgNUOl4/eadR8SmY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sounds good. Thanks for the heads-up!

Will the release also include a fix for git-gui (which exhibits
similar behavior as gitk; see [0])?

-ch

[0] https://lore.kernel.org/git/3c1a3e23-cf52-48cc-e9b6-f80642ca67ac@onlinehome.de/

On 11.10.2020 07:08, Eric Sunshine wrote:
> On Mon, Mar 30, 2020 at 11:21 AM ch <cr@onlinehome.de> wrote:
>> On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:
>>   > Subject: [PATCH] gitk: be prepared to be run in a bare repository
>>
>> Sorry for bumping this thread but what's the integration status of the patch?
>> The issue still seems to be present in v2.26.0.windows.1.
> 
> Junio just recently pulled commits into git.git from Paul's gitk
> repository which contain this fix, and it looks like it will make it
> into the Git 2.29.0 release.
> 
