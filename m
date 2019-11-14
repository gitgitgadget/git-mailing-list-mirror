Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA181F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNNPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 08:15:45 -0500
Received: from mout.web.de ([212.227.15.14]:53877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKNNPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 08:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573737335;
        bh=QRd5yXLb2Y1oQmJdiESaatqrNlBF4fdnno+BgneeKCo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lk+w2EUa52Ioks9g6/UIWKRqg6wl+xfTp3LdGoHYglu2nq0qrVFpTAhaDHdCZ2BnC
         J/4+aKUZO3bKQjvwANR0EEOS18LRbqvuZotFIE68PN4P+DiblNx78uIGgdsgtK1iyA
         ojguYtUth4LLwrz0HnZWtvRv1GZx/guxlS5As66E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtCm3-1hlQXU1Z9v-012mAC; Thu, 14
 Nov 2019 14:15:35 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
Date:   Thu, 14 Nov 2019 14:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5kRUiV4qSr+lxzBuazxJs4QUbACNUa6fEFi8ExqAXpJUp9r6+a
 GZFARXmrv/u4KEAiO/zhk/JnmHdhiSHvWeXbNpOJggdpnTS2MTOy7IaRBmwDrmfxZwuuJ5Q
 gSWMaewOaIWSVEnrojG9nSaicCHBiYS2rib2IB2/7G6xRf8VM9t0cDqkYj3pJ47skIw6G6n
 r/StOMeXUPVlWgEppww5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VU5uELcku3c=:Kycmh3NajdEQzTrWvGPIWi
 3Tx2Dk0MhOEmd9H+nUezMod2b0LnaEKQuBO781jN2FWtHm2FJHb+JYZTUj6bTeXV7BcuSbJtq
 C9P5ixOQk4ZKfxiyvGbcNjDCNKO0vLDgoWZBGNH/kw3hg1NoiP5JV72B3ej2ZEljKJoYYlywL
 JI9o0NUPlpunEHc9MvmOeABiuYzfPhlTlH79Ue9x8wdjqs3L+WPDJ6tDQhajOxlSG+8q2zihQ
 4s4HSF1qpVSZGPqZ3F0JQ0bqcUWy0E3lpESt3Gsx/Zvf8pRf26/RPPEnd2IeSXpvwbGDQBQNz
 6I8BQBLaQ9zrVlrvSIARnCO1Sraa+ZQU1GHMaBSwQUTNIxqJhxjssgBmevKzDdmQMUnpgUZA8
 rIRU408VWHKQtcxC8Hvml6ofcpiYuzW9uV2IcnC0ygkMNdOESXaZ4ZH/JWnlPE0SpRW2jIDtB
 cu5RUqDXB5VrdT15ExcHqZFeXItvgbci0M1H+zQ9ODsrsM5oIxErRWevLUBPjbu9IyATrj8Oz
 mCnQLadyc1oFL99FEK8GhtPIb3qabMUR9vm8RvRm116AprDzv3Y7Km5DDej4UqLeqgwSqUA6j
 BgB4cWh7LCS6wf+rlDFJjk4zQqYW9hrzu9UXNGrPsP5cxC4O3wL5aFmaU/wN343QGbWdNaBx5
 /F8fSzZcX2L+4hfNnOuhSXVgF624xMJS70Vnz7KtPvCchw/VfFbSA8blyBqo/Ua13rACxGaoj
 87mqzXathHDQdZz3RyO3p7UKy/nqLTCgL2fvcKCfWaxKu+4FWIVW7+rJEh+MFN7/GR0hDLXJt
 Jt4zk3YbYQJnk6XFeVRstIojya2+CrRwALAPNz+KR7MEsDTSdmCIn0jGpyrzQbTDdZujGaGEq
 9dVAx73zuPtLovQGH/FymNgf62i8d41sbC8YBiS5+FWVP/uGGcTsje8Z9A8v74nHc/wG+cREU
 PAJCkzLMWGrWyxB9GMw1c88EGJWGFAHnKRjpDAqFR/r2RY+jMPayRb/lxmPRmZupxWNP9OrOJ
 V7JWQoBM+T8RlGCcfT1diEvVG3wHGVTTOeY6/9Zh+4L+iK7s8ywu2+upTx35XgUGhdn55rsx+
 7mZtIr0P/y220Cc9VjBcYaBgsg9p5NZGdBIBArv0cn4IGHSamUFUZk3WDRooLSYZluceWldKA
 B5d4YyDYG6fl/rA/iHGoufIg70qbiB1GHJEjyWp8E5R6LDdbNdk/Ul8EcfiyK1r5XKcGEJWsP
 UCsyYIBsAR2dKuK6ECrT7L6xYLRyd1BCTpcfJWw3f28sXsnj+66I+o9lY3rw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> I too recall that seemingly redundant entries were noticed during
>>> the review and at least back then removing the seemingly redundant
>>> ones caused failures in rewriting.
>>
>> I am curious if the redundancy can be reconsidered once more.
>>
>> Do you refer to open issues around source code reformatting
>> and pretty-printing together with the Coccinelle software here?
>
> Sorry, I do not follow.
>
> If you are asking if I am interested in following bleeding edge
> Coccinelle development and use this project as a guinea pig to do so,

I did not ask this.

You mentioned =E2=80=9Cfailures=E2=80=9D. - I became curious then if corre=
sponding software
development challenges can be clarified a bit more.


> then the answer is no.

Such feedback is reasonable.


> I'd rather see us instead staying on the trailing edge ;-)
> to make sure that we use common denominator features that are known
> to be available in all widely deployed and perhaps a bit dated versions
> that come with popular distros.

I find that I am proposing script adjustments within the basic feature set
for the semantic patch language here.
Further fine-tuning will become possible, won't it?

Regards,
Markus
