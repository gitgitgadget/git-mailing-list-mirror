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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8301F5A1
	for <e@80x24.org>; Wed, 13 Nov 2019 08:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfKMIuA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 03:50:00 -0500
Received: from mout.web.de ([212.227.15.4]:55729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfKMIuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 03:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573634994;
        bh=hUlEyv9XMVCCWw3WTo6q53LFWehpfb0TFd6OOkoR1c4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DfqUdbNg9GlX2cbFsKViIRoDcsHzE+9kc6gXUM0IkI2zVTsSiLba6MmYGRVCPrhOj
         h5jLtdSsmtlpqACXv8UDTAwW9WkaiyeYnJpLKwCGSqX7EE9mpCacLM1evt8c2oCo4w
         Gs0IfSjRX+tVoMzMa7iOifwOf/bHQ7YnScKoXSDE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.127.42]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLac-1huvIZ49pa-00a05j; Wed, 13
 Nov 2019 09:49:54 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
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
Message-ID: <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
Date:   Wed, 13 Nov 2019 09:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:prTPUxdt4o5w/8geGyJ4j5QUbMuA7IrTrxAXzJ6lOIwpwCxwOd4
 xJ9u+VrB6rive5kyYny5ysE02yCorWHpjX4CgYsvLjPxHlm7wievCxiYqO79Fs8fhCY1hUs
 m6y37r+A8uIrtClJP0p3xsD86RFpzgRbq1rWayb7p89Ol+Z1T8daYNYLr+lB9+khaEJk1E4
 NGH2UCfvWhgAsphEF6GTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZUb2YZzT/pk=:zZUcXdjE78IfPxt9d9+gBY
 7IZGwdiZUd5lbH2/8bg7JUJ/PD+1G7wxweAtYO8kp0yaXbX47bSQKeDAE79vFMx6tYcFTVMf7
 DWYVQuyWAjbCpyEZX6mu27d0oPwOkBBVntZQ1MBW+dmskoG+Eewe+StgLyI/ZUVfjnTtHNtPx
 EZs/j3/wfa4m2eqSzChAtLy401wLiwLp039KIOnXQoU9NDfjIpSrw2glspgdlPoAdpMHl51lA
 Ou3KmsUQmjMauXSIXTm71oFspmj8KtpqGqTOlHfQfGCK3YTfRMfGxB9eMJUdIoAX2KEYi8CJ1
 dbvA/WE1nRA4JfahrjrhERyP7+sr3pxJBOjLnS34bPwIn68Wy0jTXley6RXBAPiBL8gjEn2oP
 7rsE3cN/GKCsA1Nies4UxmLUUXzqrqCL6Zmok1z/Ghp+IUPmaRxDl3HW4pu4DLz0f15gZr6Ia
 eCjY8hk24E1ZejSMk7h1SCtEJPNq/L7VDYH+JR9noEbQqbN5FIJFt7cGTfy505UYfXVeHLOIR
 HJCQ+TgG9JcB8fnU0+RswIMfvCMQXA40WGR8QPmiThHZ3gXyQylqd//Xu9MvHIDonaGWFcZzU
 EkpwVkU7UBkldnecfpVKzP5+OlbTV4BX0TyvbnWrlk5mS/gmgMY5V0OuR0jP5Cthqq0V7dgqL
 M/Duhss4LojvcdbImiuXPJ8xzgcs3vse+J+MJesmWoi/y/tlf0Vxy/yon0VOjmGiKdeywI5gP
 jTUa6w8sd9u6HH77lmNCxXUjzvDbaZivi1oxJrlTvoEvCEpI6iq5ouIVCX0BGIjhwb8luIH/I
 cAs8YfF1Gu0wnMG+C20f+s76XyY8Vyx3qL1ftg0cBJkeNq319ECcHvBzhZATbns1xqjQeCV2B
 Dw4qsUkVTItWw3e+SAsdtd4EfXp3WZQpZ6BnrUU5JnmPWTP4utNP05zgRb1tksfGzc1kIoyWI
 iRmDcZxt6moy5Zr6RfHV1gIGNjIzePdvqsnbUvw+oog1Sn++mo1b5wnhI+ScfqaU+fSGC1i0V
 qDq/xJ7Z2wtljaHe035DBhJayhqvzoDcyAY91u6WlUtSq/GZ/4fHoCBeKjG4AMOCEvNPNuefc
 5Lj1XLptigFqykfXTMH0YS69FwMxDNlNwA07Uhh8Lon0qRkPpD0ToSzULHi2PnSfxR5gZju9N
 nW7Ac+AzaMLgiOjQLjbRAZ+QQsOa5WClcfxho8Shr7X6w2soimL+EIjbVHgdCjyYkrx5/1yfj
 LaI0OttiOFHj2luYwFp/DDEBbBMgfuW9icqzWCM6j9dxddEp/77AIQ19PfEw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I too recall that seemingly redundant entries were noticed during
> the review and at least back then removing the seemingly redundant
> ones caused failures in rewriting.

I am curious if the redundancy can be reconsidered once more.

Do you refer to open issues around source code reformatting
and pretty-printing together with the Coccinelle software here?

Would you like to achieve any further improvements also in this area?

Regards,
Markus
