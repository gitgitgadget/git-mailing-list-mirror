Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E2E1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMVK7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:10:59 -0500
Received: from mout.web.de ([212.227.17.12]:37667 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMVK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573679457;
        bh=69Tohf/cnogxDTHWOtisIM6fYeDtuS7gC2Nkyq61pnw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sqQt5EToSgHNOqQ9/u5rSO6+W2KfYcleK+k+GRTIkvevQib1Ijnnr88wm0t+Yf5dw
         WCcO+8vX/0SaM6OgJ6NHPBB9Y7igdtoks5ckuDC/PdQEYpHv7uPAVZrzf/F2ZYtNpq
         TNVfyFqlk9X6fgZvNekVyy/SFTpz397H5iJo2Ijw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.127.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilNJ-1hsvPR3DA5-00cwCC; Wed, 13
 Nov 2019 22:10:56 +0100
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
 <20191112175926.GA41101@generichostname>
 <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
Date:   Wed, 13 Nov 2019 22:10:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qYqzbEfCKex0HpEsnaX7JWGkEOJnxfOJ9lpg2qwdetA2059bSju
 o8XME+YnHgmZXQkK9SaSbKwIinu8rOLJmPJcws97i7L4L1fDZuMDUJ3sJhXfJlUA8QaZbP+
 knzmYpVxGrrRiukjBC9IzAFKWFn8mpDrajhjnCPQJUkswyC6lDtry5e8si9IR996NT4/Kv5
 ZlGpdn6QNVhuwE0YxAcOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zOQXGU0MCwQ=:ChxFi8CMR0zJG5WO2RxUpU
 REXqfR3xVajsxXCm0JNwZgROYIKkIofbS+PNqVAAaXqK32cEnE6rzoL58ykwyUXOBHBxc7v9k
 CtuJFqb/m2mcP9T3GHvIpMIX4ghH+Nvj1G3ST2p+V2gJhO3VMGkX0BV4AcX6Y0kZglpuKtjPb
 jtA2ncy7aP6XdImWoLxM1qWdn9XojxsNF022W/c5CgcJLgFbY+oiyINiC5pKAj1X6ILp9zN0d
 2E9DIHhGKn+BdUeI/MndklW0hHNhd7hnjNceNnH+M6P8bidTi+S0hnmqloZOAKWsjKA5e7mHU
 SpjY0yu8lyPcXPuLD2v7CYO1ODRIFybyE7tmgYbhpnW99wTIstionk1Di9czcptbyAtPgeaaE
 z66Xw7+5jp3l0lgikh1F+eUcO1bzQbez+Uil+ggN7Ngwmr6NbkYf9fr04nycG0NnOblmQqRMI
 i6BjTnbAyEuh6qdDL8xO7zGY2iKrL31K32XzPEDoqh/V3wFi/5Ou04rFYA/1CcgRSzH6tg+FP
 xhCVUWFVRyKpIMpbS11+1ZQW6YQbobkb3Hff8hqBkeaDmYrTt/gUgOMwPlMOT1WHzs60xuPzt
 8bjII506dxiZ2e+8W6YrkhPh+8oTEbXOKhKGFpIG4ub8Dq3MoSfmRL9ta4FXRGO2IoBkSJEud
 lhwGl4/+Led8LrNkWmgMIFW7pGrEyJUzjQgM3hBLP698xo/f88jG/LTpW6xILSoPFM/Xwi1FV
 lw7gpvizHWZgKYB8GX+9nMtDmpNRCEg7PK2hgIV/4Zz1Nm3YI8pBiwM3B3LVtYuRaIrbHH08b
 /0BLkliZ3nFl1vx/6y3sxHegiBvbQjbKKIKIgUJEiqaRgxLNoUc8E6BWDkRT3epjzqSKKuEvl
 bFmqyjKNfjr8w8uxyGQ6u5pasNc45EK6aaGQairxCN6N1LrbahLSbYVqhPCjjJjFq2dHt+eOz
 /q7K/MU5xpkxVQEpySVSwbv+4WmzQdEYJ1TFs3IFqtWaYQWNFy2MOcQlsigju6aP8LoRcquna
 ObuCTEPh0EsoDU+up7TZWpa2t8oE61Lts2d/5djTh6Y6NTWIgXgrtizCiqLErilCSXa4mcQ0p
 lCN/T8cqS68XKnL54/v4GsPc1P3tcTz1TXqvXLUV7I+af24xYgMFmm62tuuy9JIaCwU3WLAII
 hgxj+iNuHzE/q2gIKLl8QdDeHx5kp0Boe/iGPHmKQj9BJ7R5kItQUccOa2KBGPMBXzRWskbsb
 e0PiCw4mji5HmI6HG3+WcV/5kxLu/gX2PUV1EiI5jBQeZAAd7arF4f2FpklE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> This script contained two transformation rules for the semantic patch =
language
>>> which used duplicate code.
>>> Thus combine these rules by using a SmPL disjunction for the replaceme=
nt
>>> of two identifiers.
>
> My knowledge of coccinelle and cocci rules is basically zero,

Would you like to change this situation eventually?


> but my impression from this list is that running "make coccicheck"
> can be expensive, both in terms of time and memory.

The desired source code analysis to detect possible software transformatio=
ns
needs additional data processing resources.
It is usually hoped that corresponding efforts will help with development
approaches at other places.


> Do these patches help there in any way?

I hope so to some degree.

How much do you care to avoid code duplication?


> Or could they hurt?

I assume that you ask according to the presented change possibilities
for Git's SmPL scripts (and not only for =E2=80=9Cflex_alloc.cocci=E2=80=
=9D).

Some changes usually contain the risk for undesirable effects.
Would you like to clarify each of them in more detail?

Regards,
Markus
