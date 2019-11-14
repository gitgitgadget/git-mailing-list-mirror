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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0321F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNQl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:41:27 -0500
Received: from mout.web.de ([212.227.17.12]:33171 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573749682;
        bh=IgfQUQTeq0MnL6wQDOflC+BGxKgS7dPd5dlwG7HSjK8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UgWugcRz8YYzoJ6IYw0nLyG3fy+TVLAPVWdheon3SoCCKDIyOjBdamh3R+soUk1OU
         nx7rNTBw6eRauCle5wGTGkix62TTNil+IUyeb4xkVlnM6SEqOu89kQUtYifEd1RJN8
         qV4mT96Ze+k9oQH/lxSuLjNjZEFwRwHmFJaV4jYs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJH1-1hswQg42Zj-00dWpx; Thu, 14
 Nov 2019 17:41:22 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
Date:   Thu, 14 Nov 2019 17:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h3JaV5yZyeLLS9ctVoo/5gdZJiTc8U+lRNcA4I9d7VhjWrHXXoF
 UNhfRY3zwVszSNRo4fDvuTxVB/1nkdifSKuLWdEmBPCXmCsdrdQ7eYv7AtC47YKT2B9itf3
 NVUR4ZRCpnAOjQafMgeqB8eEz3rekSvvUbP2VHhJWIWdU8opOrYcTfN4VTV10LmR6znnwuF
 Ty0oRfonTTL1kibxyTB3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bmfHC/zVB18=:vxYMX0dak1sPomLYA+o9Es
 8TgZQtWwkFCoxcpWUfCRJRy2eoiQmKbWiuH4GFnMFgQjY+eXiD4RL7VvPJoPyV5P/L9QaL1rd
 5NMdJI/DxF0XE58mmYdkGBuczfNjt62cajaVTGdw0jPLJKUqswAlrsGn5ohZMEkjT1bbPcIEl
 S7HzZIdlxVVkFreCJ1FPJ4Bo0u0/q8ZuWNQCi6P/tBOdpJFKMAYVXc8xl36b0YSjh6ofFF8yC
 9f6+BZ95JvPTA95VzVWOc/jQ/rinXb9KyMux5XpIsbzo143JUH0GJDqlRxlLPOQu5e2fuDQyH
 LeMzX7bfGGg5aON2OS8F6+M5WRfINTs6UukewUXf0scXWyA0vJ/ebt8V3X/AvbGEs1ZomY3Dh
 acDbiuUMPMnyJti8MkAVvK3VrcbLjCUdRAaAeXKncDfSk2MzlNpWLYq70HEbBy19ueT9TPGC5
 KRU7Vb9PgRy0FnFUrIq8ay2Yceedp638Fm3oVpbHyJnSv80D+3Ahduhv37MA/apCY2NMehxT3
 EclKK0fN16qqz2nUZID1pE23PQ3UVA/lwW40RKmKqa74eAFsGgBnx5cyVlQGYU68GGO0OhY9p
 qNS4V9HkXaaPvlTUGOJsuv5CAWuv1b/chTFpylVxLHgqfoXRq6AH9VpqDr427MBBQm+ipMY4L
 O3TSeu5mqC6fTy/cWAjhzAgA0y+CzAJLu2dlC+Ui7+7z8PPDURENz41fPuAjuJ0nz9+rewt93
 eXFpwWTYtsuHt6H7j1RUPixCTZz6JM2SB6KJX6/nsbfC3NJrlSqy4uDSqLrRhAiur4SriwQZd
 Og2rZTCfDzpCtBaCxaBK9EalLCbPa4oXq+uGtPTW849RchJCPujzKSgF7ziTXovR2xUrnkKFj
 aBKZR+4rroF7vEaWhNaTlE3KMvM9Tq3g2wOnf3GXrgrRRsdB4XnLpO8sc6Em8l5AzcHNwPxYH
 sf1iqzEblh0e6ecwQIiHky5JlCzDP2K51Q7NKlNvkACofCELAu2pd0QWvsssAWSpyEudD++B8
 F+oXT+1NCM8RpWhNCm/71f25QivJYsolp/WF18X6GoY3cmC34+dqaBhPNg5PQBFPsDUbd9sef
 wfiL6tEYMtl41k4F4GzWs/EiSTNGa18EwY0XZnvX8NVQyYm1wJHXH1kYU9jUwK7pNsqO8Q9cu
 /QZE3KCS3zbi9yH2rX93Nx5gdFTGSBrXgjKYjUyM1fjtLDviqJRF4Kzmud5dJNf6OXILxIczq
 NUZJcQdmk9eZEXMDuV0mSW2f1TvpVrXCpJS/dZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.19 um 14:15 schrieb Markus Elfring:
> You mentioned =E2=80=9Cfailures=E2=80=9D. - I became curious then if cor=
responding software
> development challenges can be clarified a bit more.

Let's try to restore/repeat the pertinent paragraph, with context and
attribution:

Am 13.11.19 um 03:11 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>> Am 12.11.19 um 16:08 schrieb Markus Elfring:
>>>
>>> Do you find the following code variant (for the semantic patch languag=
e) also useful?
>>>
>>>  memcpy(
>>> (       ptr, E, n *
>>> -       sizeof(*(ptr))
>>> +       sizeof(T)
>>> |       arr, E, n *
>>> -       sizeof(*(arr))
>>> +       sizeof(T)
>>> |       E, ptr, n *
>>> -       sizeof(*(ptr))
>>> +       sizeof(T)
>>> |       E, arr, n *
>>> -       sizeof(*(arr))
>>> +       sizeof(T)
>>> )
>>>        )
>
>> This reduces duplication in the semantic patch, which is nice.  I think
>> I tried something like that at the time, but found that it failed to
>> produce some of the cases in 921d49be86 ("use COPY_ARRAY for copying
>> arrays", 2019-06-15) for some reason.
> Thanks for mentioning.
>
> I too recall that seemingly redundant entries were noticed during
> the review and at least back then removing the seemingly redundant
> ones caused failures in rewriting.

You can see for yourself by:

 1. applying the patch at the bottom to implement your suggested change,
 2. running "git show 921d49be86 | patch -p1 -R" to undo 921d49be86,
 3. running "make contrib/coccinelle/array.cocci.patch",
 4. running "patch -p1 <contrib/coccinelle/array.cocci.patch",
 5. running "git diff".

If the new version of array.cocci is equivalent to the current one then
that last step should show no difference.  For me, "git diff --stat"
reports, however:

 contrib/coccinelle/array.cocci | 30 ++++++++++++++----------------
 fast-import.c                  |  2 +-
 packfile.c                     |  4 ++--
 pretty.c                       |  4 ++--
 4 files changed, 19 insertions(+), 21 deletions(-)

The changes in array.cocci are expected of course, but the others
indicate that the new version missed transformations that the current
version generated.

Ren=C3=A9


=2D- >8 --
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 46b8d2ee11..e7bcbefcc1 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -12,27 +12,25 @@ T *ptr;
 T[] arr;
 expression E, n;
 @@
+  memcpy(
 (
-  memcpy(ptr, E,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
+  ptr, E, n *
+- sizeof(*(ptr))
++ sizeof(T)
 |
-  memcpy(arr, E,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
+  arr, E, n *
+- sizeof(*(arr))
++ sizeof(T)
 |
-  memcpy(E, ptr,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
+  E, ptr, n *
+- sizeof(*(ptr))
++ sizeof(T)
 |
-  memcpy(E, arr,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
+  E, arr, n *
+- sizeof(*(arr))
++ sizeof(T)
 )
+  )

 @@
 type T;
