Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D5B1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 15:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKLPei (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 10:34:38 -0500
Received: from mout.web.de ([212.227.17.12]:57271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLPeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 10:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573572875;
        bh=KPO6m/6w0EMdLBeJD6MVM5xnEJA608DycPqpClcuIYs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=VkUAbmIbe6IVQiZgEf1D0XdrW88YZruXJ7Ns3oP2sRBhLlDLZYTMvGc7bfroyYLUk
         oYDN67l/821uy0dxhkOjUZiCYiQGSQVrITgkflUxQXKu9H/tmn16nFoWPBMhvR09Cy
         +5uPYrUpO7/lyHVY79eumwjE19qjKBQBgdKZ8RI0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5if-1ibT0t3Cw5-00BHNb; Tue, 12
 Nov 2019 16:34:34 +0100
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge two rules from flex_alloc.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
Date:   Tue, 12 Nov 2019 16:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d7JoDfAkHSkEqHKEViaLybrg2gK7UgLPek2EY+HuduVhqgbceGR
 PD+93bTL7EtzFEpMNt4QF0NiTUFGaYMTI/Zrz743pedHCzilOFW+zxphvIgmbAUDdze2N1n
 KjDt7ITr5tDZrzAS5haxwV2eY5MBP6uFTLzbRBqR9Ik0TUnKuMxjtToJQPf04riyblzhJwE
 0LbXHmBmeizbybxNxnHZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S+RJSKMcjWk=:c53IQunU7uL8Dcweq7x0dr
 3yGGm8Vo2+07UOaLGZreUCu8dd3idzLyc3dBtq1IDAWVPOPGjrSrDeDfiCtTClcGf3lydUuSf
 teRxrCZfHQyzf8SYUlr2Sg98+0c9/TelGXjJmspsevvuuD7pKPn3wd7PMA6bOEibQ1kyga8fi
 HvTrUutbF6lXgqN3zVQwdMwHUavtC6N5wM0lQtOt5HBnO5iwxqvwvgfzH62EtawTS3xpoFN/Y
 /mQ7fJzPJq64N/uQDQrri7MKCmuJssYB1hGeE5UGn4DIANyFEZhbs0Xri3bu4kYEuCWPcj7B/
 D2kKo7uLu7tH/MXyXX5ODeC3492KLjXsgN7s/50S4LVdl2NU/9X6nRonBAzwFp9pWgHD6lliN
 a68/Fy/J6eCWmNO8gUCYzN4PgfiSNbcVRy7ugMV73Rkm7LzHeqf8ulT3bYehAZAK+o9/e7/JU
 9BhCe9xpWAjF3kGIkbdQQHmxt6tegSrYS2xvMxLbB8mzDRZ+ztV8jM9jg3OoIDHkz0nks/KEo
 rziEm312RiS8ZDf/cxBNd5gZKJRGIpUMF3R5BRBrVsIboEUfwNBN5Y50lvGTT9NqDZICHCM5c
 07auBXIOMCKoO/H7OHoRkmfmx9cB55UDt6ZcQ7aqaulzPTe0Vx94HBN9BR5yHIfHNYXSCKseV
 7tR9h0LRdoitgmPudUMMZlM8El5tgB6ZRSidT2/sMidyNAnqM/NoANfP3hXDEpv4KreynXA0Q
 e+9H00ncnMsYNDDtDE/ly1rSTZwQf/jS6I2PKmqPlFGszuiQVRWqVD6k5M2aKVUSJ8FItQG0r
 opbjlZ2nUbciQrKPUEiClMvGoOJGcgNZfH0pfZv4pbUIi39szTx0faIDFqBhWPLJjsOIiPyL9
 PSnfYSKg23hKfjbVFYGBk/7xGhB/8zl8/5T1eNQD4HOoTFPKcO/p1jrcXbJsF4xVmUO6gMsqd
 ozRyteTHv4JaYjxJk2feuKTn0ckliE8qKXpHQ4+DNT+Lr6Z4m7O2dqW54AF1DvQz27or4dZL2
 8zMjNPfAoDdyb5sxXm9nYMgpCTmHDr93o44J16R3/tcaSP7Ni77i+p6g6j/qmdGTVDdCBsGdg
 77yjE0GKU/NeLDh60CtqKxZsc+ODySdSgOZJBci0vZvFpDH8mRKJA6MpC7aQlOE6+nKbRJUus
 c34X4HyblTSK9aGcsIbpyM2nerwYBua+z+IXt/SlOEW+9A5Rx1ErHeflIMKvgLmUF+zeF9Kj7
 xJCR+qNB5grfWZ/AQ4mNZLE3C/pcXXMXVg1cHWdTkQCXI5njclL/5FPHTwws=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 16:30:14 +0100

This script contained two transformation rules for the semantic patch lang=
uage
which used duplicate code.
Thus combine these rules by using a SmPL disjunction for the replacement
of two identifiers.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/flex_alloc.cocci | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/contrib/coccinelle/flex_alloc.cocci b/contrib/coccinelle/flex=
_alloc.cocci
index e9f7f6d861..1b4fa8f801 100644
=2D-- a/contrib/coccinelle/flex_alloc.cocci
+++ b/contrib/coccinelle/flex_alloc.cocci
@@ -1,13 +1,14 @@
-@@
+@adjustment@
 expression str;
-identifier x, flexname;
-@@
=2D- FLEX_ALLOC_MEM(x, flexname, str, strlen(str));
-+ FLEX_ALLOC_STR(x, flexname, str);
-
-@@
-expression str;
-identifier x, ptrname;
-@@
=2D- FLEXPTR_ALLOC_MEM(x, ptrname, str, strlen(str));
-+ FLEXPTR_ALLOC_STR(x, ptrname, str);
+identifier x, name;
+@@
+(
+-FLEX_ALLOC_MEM
++FLEX_ALLOC_STR
+|
+-FLEXPTR_ALLOC_MEM
++FLEXPTR_ALLOC_STR
+)
+               (x, name, str
+-                           , strlen(str)
+               );
=2D-
2.24.0

