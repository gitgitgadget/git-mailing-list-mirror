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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8691F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLTX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:23:56 -0500
Received: from mout.web.de ([212.227.17.12]:36301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLTXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573586634;
        bh=vEFW1EkTUWR0QvOFlbeP4h/QKYr03kkzKIJ7zU2sXCo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nz33gT6oeuS4uiVH9zmZw6qHEhX+jgxjK43Coc0JYLM/4IDrHafd207Rng/33iNx5
         naT0EyaxnoXdIUejMA90VNdfC1vteUIjHXz1092bJny6q0HU0j2xzzRWcKj7Dasfis
         YHsZsahXxfnbxEUkwW9TfRuFRwIEQpf+CrQHTtYs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgO8g-1iI2Qx37Di-00NiUF; Tue, 12
 Nov 2019 20:23:53 +0100
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: combine two rules from qsort.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c19a6e52-3c13-1ff1-a313-d0d951328e29@web.de>
Date:   Tue, 12 Nov 2019 20:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oWrT+94c5oVSZkwyyz5niuOf4WDdH7Vd1/ASXWFxeAQWH4YibfZ
 Y67hG7Od1nSSG9X5wB29KrhCVpFqcvVBmfDfxybdXs9tK2QSmVg46FAaYmCOolx1woCA78j
 J/IuV7JxBjaqvHdNgBeH8uHkjiWQo2wzU0rlQUCkCjumyKhFyzyMSnzVfBwsVmNI4FQ2sNI
 Pb+Nouw7UVMQM+ZngfoVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKqJbRRFs/c=:te87yWyi9O0Ymhuspil1uf
 ngVLYeeq8fHuff/A6yod7mpit0+t5e+3EJnYQvOoZYR4Z/iaoU7GAAmJwnQlFz94u187QcwoJ
 aYKdYXRbXK/qQPVg8NT7OyU4QrV7+uKXE2qQaRcl4cucQyOrc3rNzFa2deC99pJ+sS1W2AKYc
 JzD4MMoUcuqU2P5xCuAYoNfObUyU/+y5HUqP+GtbEiyghKPRSprYSLAx2cIzY8SZDm0wRqw1G
 9qh6Z6rn8Ih0zDKfxruvB4zi5H70AJllNKapNv2kOAVEHVTpShggUNWVRYgZykb8h1rXX8aj0
 zLp7LjWN7I+UNTt9bF5yPBGLrN9Hd/uIaeseTeSyEGRzLI1PR5D6FkbvWUpMQureLeo/8QX2F
 rK5bhGYnAzPJlCdF5NK0I+yZ3bSRaAZj0qUBbiPDPhQqfdFSk9ssYf8RSdqD92VjOih9wief7
 CtJj9QD+b9z15Im/A5TtfKiRZUQd1ZPecRHErzFf9QLNEevF9j1c+mpZrtiIUEdfaaGL+xGUh
 DtUrwKE4NdYl0jCyg5/ePFwgmuLeTcVOZ7WPSmJkQebVGFlA75g5SAyedKX3qmbP/8cVZT3/z
 7O4X+e66s7KFM2YSmI2PD7MXcZ9HgoSskORuZsJEa+Ll0+rQMf5lZZKIhAEObSLQ7jwfNwvyQ
 WRjISJ/BMGOpBJrfHyZzVP2WiXs1CIwBuBuhZkjmQoZWY7jAMUErst+PxxNE2Y6Cu8Q35138w
 IGI49ndcVxGa/Xd0aIgUViMDLaRyrX0zBCjL64Pg5UsE8KyZv9E+Gk/MzjITC5KGE2KcWzERs
 MS6qLslbUaD4uHpge+Ry87BIx3amQRamknR4dLkq+CNLOS54zB5tTx/0xmg33oJksmAThxiXJ
 wl4Ou7Xv7X92gVGd1C2+l6BSMfsK0e2Mo7TPJIW07n92fF+qo1T4BYTxbhfvz4V4E5YNyPjOX
 +J9F8e1Ve9QXrDNc0IQXOo6wFS1sjaM5ZP9JJcamebXdGMPQ12A5J9tjUbgqJL7JsL2aQm3wE
 F6LJYIhUWjyeoXrS/KTnOEp6KWTXri7RkQaQjqmUvcA79LTP5Un22fiE/Vi6TlojJ/XSKB1Oo
 kGpxqkxG0VQRwKmnMP4H4nkJM9PAwfwYwPBdZqCIeVuCQAR1Y9tcbNy0559rqEk3fal62kZpF
 9TaPYSTyaB6+ngarJMKnwpW39+ZQ4tXj68C8JOWl3/M0IWFzlcwKnBIZCqtNeXN16ftS4Cvyl
 sg+C+J1jMT/Jr1OkfIuMe7Zfk2qtzJ1IoQSyI2wb4MlLxDlYn3oM5YE8NO3A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 20:20:13 +0100

This script contained two transformation rules for the semantic patch lang=
uage
which used duplicate code.

* Reduce duplication by merging common code from these rules.

* Use a SmPL disjunction for the pointer determination according to
  a sizeof operator.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/qsort.cocci | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/contrib/coccinelle/qsort.cocci b/contrib/coccinelle/qsort.coc=
ci
index 22b93a9966..1c9a12c7c0 100644
=2D-- a/contrib/coccinelle/qsort.cocci
+++ b/contrib/coccinelle/qsort.cocci
@@ -1,14 +1,11 @@
 @@
 expression base, nmemb, compar;
 @@
=2D- qsort(base, nmemb, sizeof(*base), compar);
-+ QSORT(base, nmemb, compar);
-
-@@
-expression base, nmemb, compar;
-@@
=2D- qsort(base, nmemb, sizeof(base[0]), compar);
-+ QSORT(base, nmemb, compar);
+-qsort
++QSORT
+      (base, nmemb,
+-      sizeof( \( *base \| base[0] \) ),
+       compar);

 @@
 type T;
=2D-
2.24.0

