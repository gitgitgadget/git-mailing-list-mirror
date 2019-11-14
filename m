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
	by dcvr.yhbt.net (Postfix) with ESMTP id 506911F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 12:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfKNMKn (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 07:10:43 -0500
Received: from mout.web.de ([212.227.15.3]:38425 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfKNMKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 07:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573733428;
        bh=G4UsFknJddkVrcnNc9kS2XjvbUL/Ya+VKG3eMyNJOFA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=WlJKjdVWrvEqRI5Led1jpkUGlIsXNWUFANGs80tfgXkPMDvaf4TLFeQM4dmiZ9DSa
         WQj9TcO5EJS8PlilYf0HL3QD4hwwW/H2z7KMROQS9lQBBDGkK5xoHEtUagcMAX3EBO
         Enj1zvcRcskopVUKt13mcB1s1E90dwv4Oz4DFIDI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbZpT-1i35Kh04J1-00lEvt; Thu, 14
 Nov 2019 13:10:28 +0100
To:     git@vger.kernel.org
Cc:     "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?G=c3=a1bor_Szeder?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge twelve rules from object_id.cocci
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
Message-ID: <6c9962c0-67c1-e700-c145-793ce6498099@web.de>
Date:   Thu, 14 Nov 2019 13:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mbJwUbKdROFQFBRBFgNmhjmej7Op4FnYgUggOkf2YWRJ0mTyNsd
 u1HD9/Uc2DjNcV1mwYrUoVMrBnf5MsmOmU9x0clRjCUswtVZo7wZY7uMRIVKkHhlxpbFVeP
 pan8Sh2udkxhX2mZFm7qjylHsJCDg/tAU17/XfFHdeOpmWjVi5Oaq65+Uvs/OUHqJdMyVmb
 ze5PL2i+m/fGe2KgE6IBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:McU/aWCXHWo=:9+jwQsiUnyJ9CO8N2J5QaF
 4PDtSiMqedYeAhkhDNRg3/vxTwUGFs4D7Gt2u1gp6QCPnP6Dn3LVJbLB0FIVGaV1Qz04wEvjF
 5oVK8mRUH3E3c4dmS/cnlSaSK8CNYflz8FUrFu1mWH6Bo8PyLxLJ2B2WoVMVMJw/RW0ABmyVB
 fsvr5x9ET0YYDnu4B1B1oV/W34bDel6MdF0mQcR6uZnijlIeE/6eArh7rupsbbMc0AhQfnnPk
 wMqxYpD+6eJTuacirTGPHzxqmhdGP96j5MwhqjrY0viwaI37DQ3lSlJpVD8sjeCPz+RLmrWnP
 LgM+oWPbfvZ3TEHP9ZTWDE7zSW8fysXcR1DXKUzxgJxWAolaGKPVQJrGj36Uyr6RcCHkuG0Jq
 YvdxA5ND8CKJAjzCCu0q6O0E4eB4pK7wlqtZX6xIHrHlf/w1ovjas+M5fCkiKp94JCyyWYfUb
 VAJSA8fpwJ5pRNJjHf8L8c2qaGrIdTq4Wri4TH/sjrgfuhv2cqUmpxQ/hzAiczUUXwcMcHOck
 c+UPUV8AX2e8/ja1se9ZDXjL/05V2X+in7Km8K4cjIKBi1lalqNhnImmqMOC8a3E7b7cvEEGO
 biJP+l+3py8PdnzutrVrOB/xOyvcq11IbuNiRqHvc1Yqyo8RKXyzvmEYrCVP0t7ELv0dCLG1n
 kwL39TYXHe3FyKLQ+K0siv9JMantBDo7LUX5FjRtzIJleSGpXtwhVDl2RpyZXZG7ak+LP5vAT
 v/M4hecm1Kd8n7pLmzSbu0YFPbRvS7yedHENli2FA4LbGs7XrxB+unCvSnWeqzGKtxfDUdhBI
 9Nvrr4vD/TE78cD0t+XngBmV0Y4kH/lNm89z+uhKMx9UbOFk+xXJFkseUWL7PWZeM08aRBiZI
 txS0AkuE9O3IJEpE9RpzsLBIVufIGoplhJZdTMrJr+nvgW6SeTJhsB30qiXvqmFECcuv/Zixg
 UdXL6bpXLr/UZY+45VKXd3js0gfenkDFDA9fPURMOcftrM8IPeV0EnbrKj7FHHI4PqudTT6j9
 FJprV5/XfTZT3MEWT5xjjlp5ptHqmlk7KzkVcfwrPZRM1m5Icjl+4u8QDcrmYsd8T2Sya4TQF
 Ds0cES2M8TUzO3Px0UyVPbCndAZ88BpV7TrRzEe2wK/Q65/xrjUBad72DGyhdYqyeklk9R4jf
 J+IyX3R8gLO1Ny0OZoAU2mMOirF0PnnnIQ4eIMUcqNbGPkcR5SVPqofxeFInyK/uuyEvOsU2T
 VNIc1z4xFyWyskjwwZzAli2yqb2+k3dlwDzB9nM6ZqQG2F014XgAyZ186s08=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 14 Nov 2019 12:48:27 +0100

This script contained transformation rules for the semantic patch language
which used similar code.
Combine these rules by using five SmPL disjunctions so that the run time
characteristics can be nicer because of common usage of a few metavariable=
s.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/object_id.cocci | 89 +++++++++++++-----------------
 1 file changed, 37 insertions(+), 52 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/objec=
t_id.cocci
index 3e536a9834..5e8fc4659a 100644
=2D-- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -1,20 +1,33 @@
 @@
-struct object_id OID;
-@@
=2D- is_null_sha1(OID.hash)
-+ is_null_oid(&OID)
-
-@@
+expression E;
+struct object_id OID, OID2;
 struct object_id *OIDPTR;
 @@
=2D- is_null_sha1(OIDPTR->hash)
-+ is_null_oid(OIDPTR)
-
-@@
-struct object_id OID;
-@@
+(
+- is_null_sha1
++ is_null_oid
+             (
+(
+-             OID.hash
++             &OID
+|
+              OIDPTR
+-                   ->hash
+)
+             )
+|
 - sha1_to_hex(OID.hash)
 + oid_to_hex(&OID)
+|
+- sha1_to_hex_r(E, OID.hash)
++ oid_to_hex_r(E, &OID)
+|
+- hashclr(OID.hash)
++ oidclr(&OID)
+|
+- hashcmp(OID.hash, OID2.hash)
++ oidcmp(&OID, &OID2)
+)

 @@
 identifier f !=3D oid_to_hex;
@@ -25,13 +38,6 @@ struct object_id *OIDPTR;
 + oid_to_hex(OIDPTR)
   ...>}

-@@
-expression E;
-struct object_id OID;
-@@
=2D- sha1_to_hex_r(E, OID.hash)
-+ oid_to_hex_r(E, &OID)
-
 @@
 identifier f !=3D oid_to_hex_r;
 expression E;
@@ -42,12 +48,6 @@ struct object_id *OIDPTR;
 + oid_to_hex_r(E, OIDPTR)
   ...>}

-@@
-struct object_id OID;
-@@
=2D- hashclr(OID.hash)
-+ oidclr(&OID)
-
 @@
 identifier f !=3D oidclr;
 struct object_id *OIDPTR;
@@ -57,12 +57,6 @@ struct object_id *OIDPTR;
 + oidclr(OIDPTR)
   ...>}

-@@
-struct object_id OID1, OID2;
-@@
=2D- hashcmp(OID1.hash, OID2.hash)
-+ oidcmp(&OID1, &OID2)
-
 @@
 identifier f !=3D oidcmp;
 struct object_id *OIDPTR1, OIDPTR2;
@@ -76,44 +70,35 @@ struct object_id *OIDPTR1, OIDPTR2;
 struct object_id *OIDPTR;
 struct object_id OID;
 @@
+(
 - hashcmp(OIDPTR->hash, OID.hash)
 + oidcmp(OIDPTR, &OID)
-
-@@
-struct object_id *OIDPTR;
-struct object_id OID;
-@@
+|
 - hashcmp(OID.hash, OIDPTR->hash)
 + oidcmp(&OID, OIDPTR)
+)

 @@
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
+struct object_id * OIDPTR1, OIDPTR2;
 @@
+(
 - oidcmp(OIDPTR1, OIDPTR2) =3D=3D 0
 + oideq(OIDPTR1, OIDPTR2)
-
-@@
-identifier f !=3D hasheq;
-expression E1, E2;
-@@
-  f(...) {<...
=2D- hashcmp(E1, E2) =3D=3D 0
-+ hasheq(E1, E2)
-  ...>}
-
-@@
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
-@@
+|
 - oidcmp(OIDPTR1, OIDPTR2) !=3D 0
 + !oideq(OIDPTR1, OIDPTR2)
+)

 @@
 identifier f !=3D hasheq;
 expression E1, E2;
 @@
   f(...) {<...
+(
+- hashcmp(E1, E2) =3D=3D 0
++ hasheq(E1, E2)
+|
 - hashcmp(E1, E2) !=3D 0
 + !hasheq(E1, E2)
+)
   ...>}
=2D-
2.24.0

