Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3EDC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiAKSgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:36:18 -0500
Received: from mout.web.de ([212.227.15.3]:58327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345406AbiAKSgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641926170;
        bh=fm+Z/40d4Fh/MIIMWzpPwEAnZThpQtmtly13kzY1xtg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Pm3M/nXyjGqr3KHCWr6U6hrG4BfwmWVpFm9gO3LpbNcaSG45C3gL3ebL2e54DbqEt
         nW4vh9ytARwBgz1rbXltGNrPqBbz70RHcioxRKF26JkDnh5x9sNN8AqT9fnoOw18NY
         zUMV+RslRLy7ANorwIWOdZcnAD40phJ60ZQiMesc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuKH-1mm6Fw3XBt-00L4Ju; Tue, 11
 Jan 2022 19:36:09 +0100
Message-ID: <c3228d53-5997-d86c-87a5-5861dacde518@web.de>
Date:   Tue, 11 Jan 2022 19:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] Fix SunCC compiler complaints new in v2.35.0-rc0
Content-Language: en-US
To:     Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <CAFQ2z_M1skVCFYQ-kM5dMVXcUxV-uR+Zf89dKxgc2v1c1tre=A@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAFQ2z_M1skVCFYQ-kM5dMVXcUxV-uR+Zf89dKxgc2v1c1tre=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Lbetd+WcBg8enF1/rftlqM8us7++kctSG0RFBKjybZhaytYWvu
 X5l4ZhCoSk79SbiFAGEAPSezcoTvUkElm5zbYRgp92WV7por8G6q+auZrrtf9TmjlUF/slo
 tALNabFHrsR95s8Sbs9utpQORZub4ZkKBhD0uOXC38o0bL4EACkQ1q6xx3ulSiDtCEXRhxf
 YWW0PNeWJ7jdqFvHCqhhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:or8VTXDhhgE=:IIor3sebBaxbndlsxkSfjt
 TsMHdV6/4AzqmNJ0ou0dUsR/gxFTHqS+xJo6lauZhiix+ImVcFdUvTlc5olsnJRMJuQ2zTpl5
 3F1vam9uDYmj04QZdrS8wCDR9EU+Ovo1wYHnpDUXLFQiwLWbdvvKjVBJVpwoIBF90AXXodEE3
 RYi+1RRHnqvpC4FeaQh9GnCT7idn6lT5l+otbPVvmGGPzEvIv0iY4nvc4O4CHObakt1qejLZT
 355OQELeoAOj7FAaftxznak71yufFA0KH/83fVPycXqRQuHj/FmBGgIOfYsjiW/WWNbaH1Av2
 84QbJ+0JxXeNMANNQyfXu/hfa/pwBLWny8CF/P8ZdzCQjK/M+Wgy6lQ0odGy0tFQ35hQIlQj8
 mGFVZGJooWFfKVAQfq8tbWlOCUOY3gEAgWKgikrXhfs0zZFXuQKkEIkZtdA1jE4mfAIVT2tze
 4FBb8Y5OXlrmXjtQU6qJ3yUXwlz+OTN6GH/5V2Gc6toPSe6Pbwsk0/Q0TgjKJubPBPqVe9Mmw
 eidG+aUeK//xASt/n1AKqzLoU6WLq26vi4uAVPqyD6CHDffXQZXbwwu/LZSSUQ8kdwfrLcVPC
 FGJML0ps7SPigxBYEWEgCkIM+ltWUfOr65lh479y4HRccEqfok8BdK3iqNVag9BH9+DDt6zRt
 HBurwYKgqkjU5jlYq46P5UDAl1RlBbnVAPNJXqTMrvDl7yxxa6C3d4x/ZkcnHvmAZfSHjQKrd
 Yx4bePaPalyh9lBB+7JBK+mgIrgO85SL3ahRXcxg1Ba2B5J/yo5zodZzKKhRs95yB/Od/ZOTq
 V73F3pkrn+nRSvMJoG7eVJEOfgBeAqLXwTI/DVBfsp0T5f20r+Il0+eM7kXpnRByxwVWNE5Vp
 3M6MNuwz2ta7I8wTLbjds92Ctx1BMz638bCSaZi3Rbk0D/gaNiDkL7iI+e160XaFoh6wDO7pO
 /V4qS3HWkbfQPCwv7GLsRm2yJfBKtUoWAMUbyeAh0lMZhEV4tG4BMDSJb3SQJ0TzQguY+wrNX
 tx3GMc+Qv4ieqpOTolQsczuEfU6HcWFs+So/e/27Afb4+/F0s/fHL5QhV3iQ7ieacQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.22 um 18:06 schrieb Han-Wen Nienhuys:
> On Tue, Jan 11, 2022 at 5:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> This trivial set of patches fixes compiler complaints from SunCC on
>> Solaris that are new in v2.35.0-rc0.
>
> Thanks, looks fine in principle.
>
> For the switch, maybe the block types should be an enum. Is there
> tooling that would detect a missing case in that case, so we could
> drop the abort() ?
>
> For the 0xffffffff constant, there is probably a better symbolic
> constant somewhere. Or could we say (1<<64) -1 without causing
> overflow?

How about -1?

Or you could initialize min and max to the actual value of the first
item instead of to the absolute limits of the data type.

Ren=C3=A9
