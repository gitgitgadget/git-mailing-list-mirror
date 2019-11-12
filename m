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
	by dcvr.yhbt.net (Postfix) with ESMTP id D07E41F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKLVA3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 16:00:29 -0500
Received: from mout.web.de ([212.227.17.12]:35661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfKLVA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 16:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573592425;
        bh=aU+S0k5zaJpqs5tAKSOaLLjgjXGpJDZs9UE4zvOs1mA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=GAE3DR7Enu23sYsxMVrDOUi2dNnORY+/ZMIKYc2HcP21YkmSxUNR97K0gHfbkj3L3
         TOTuRdMy8fgEM2HxfL2xNupRYQcZZAb+VL/8rKHotwVDmB+LxlIn/jHeEZW+bwYC4V
         YQ1NgW5Vekc0Fg5oH4ryqAVxUmE5jDnPRMyI/BfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaTaN-1i2TBO2krn-00mMdD; Tue, 12
 Nov 2019 22:00:25 +0100
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: simplify variable declaractions in rules from
 the_repository.pending.cocci
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
Message-ID: <c260ef87-21d6-8fbc-8060-d7d1c6330601@web.de>
Date:   Tue, 12 Nov 2019 22:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a+5VU0cVFHVv0UN2RJYVGmqy9tzMwkVl51NhHI74E9O7nRgaX50
 rIgLW7mKKWrzIE528ogerBXVDR4o0JgmnrXoWgIK5T0wJofkecv5or2dn36XM8l5tvqK0hr
 +DO4xAQimyR/QzsLivecEqijpJh3GhXaamFESv/EYakT4DQj64WoMyBy8NLmrCfRehjJQ2e
 q6C4KHH5Pi+FYqeRDUOyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bH844eesT6M=:JkJTPHxwynddX/hcqXVJ+3
 hWvaA9B3WmpFdEM39/3My8FSDp9SjZnBIh71huMVzeiqaGImI1/tJsJsH/mga9PY2urUeQ4LS
 Fhq/0tyXdBdns6qe6if1eqfQsVrJDgVn9dgcpLZX7t436lCJ/2lysdHRfQ0pNJC9IXqd0GQFB
 mP9PoJmreGcYrsmp5brzNewpkGR8nN9Lyop7Q4lzjJP4PtRiUCl6VA/wcDiwW6fmtjoRUJwWP
 cVHfYJvtIhNTGJsrRguPb4NmrKI4d0Uc/2yzd9ELrxF5RVqJnM5tbelXWsToQYRHXcmabhzM3
 0TatgAO5IWp4yPwkfWIhGHYgfNN6dIk8l8iH0dkJvwDpcTzgCYSzOE1N9rLaJB+j/qmM5SFx6
 Xfq0gckhKCAdCJ3gjwVDne29jgOpUQ24FjKOg4RMIvJdV+CBoWDXdeJRf2z3Rkwu6F8RMy7Vj
 MuGLPeo98uHUVyBCEpT03jiVCftSzTHtMoLJe+x0MM2XN86nIJm3smN3hX57YICswLuSTcbXY
 Jg0hF25fZnU5wXkrPqTzlXree1Y5FIg7qW7ojVyVSeRJFqHKqQiJapes1rZFMl2KZL4JDJM22
 ao4Uj0xM+efsXeWMUM0U/1xVXvGdodMXLJmfM/xKVrZiFaU5OS0uvqHlJfFj/sy1sHn5mKSHS
 H4ePm0/9OeXGhiQF4x1rzSsr3QDlLnocVTvjPY4Jopxk9SwO0ZRT5XgEOg+v707Po6NxVAN7h
 7zuCDMkVV3NjINlHDHg9dClbxKdQZPtwKHcYKWDnAvY1SNqftJmmhw8I8GNhCbyjuzSmr7Zej
 MNyPS7CMRRaMHdHvbYrc3yYHeX5XUDuCXaQwtWYMxsqGNFX8b9yabGueClXso8knZWyZGie8v
 nslXBYbTqk9Ms1MbhHGTyaXfJ2H+62bEoRAGNX3IY1ZCZvS4sHk7BvCVg6UL7McBbEeOWb1wh
 YuxZ9v76DyemXyg0Z/gBLQB4+abLDYokB7aHB8DGnz4IS6ICM5pAjoaURuKdfcN+2wGyTf8Yc
 fquhcEqdntWelOOm9xnWFq1clDqqrd+HhMxS6NrkaTb6nh85Ru/JBaIuJUxIeouTSeE5Tgcp4
 jVE+pmOJeFjPgYklCsvxZ3LNduko0PNaQVG1NjDCkhIqpCr5n2nAII8nAioDcNffgjkEBibuX
 j5mbGuKuTdqo96xsenkDRD2CBv+48EhRMaHXwCvqW4K585QVCbfEYl1B9r45DknyceRkRC5v+
 2Ne1vaGhp61AqWR2/XBfkhMoLmT7s9MyoFHnCEB33QZZYip7Hgud/CnX/cWQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 21:55:18 +0100

This script contained some transformation rules for the semantic patch lan=
guage
where a few metavariables were declared with the same type =E2=80=9Cexpres=
sion=E2=80=9D.
Reduce duplicate SmPL code just by listing the desired variable names
directly behind the type specification.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../coccinelle/the_repository.pending.cocci   | 44 +++++--------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coc=
cinelle/the_repository.pending.cocci
index 2ee702ecf7..697e8fc77b 100644
=2D-- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -3,9 +3,7 @@
 // our code base.

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - read_object_file(
 + repo_read_object_file(the_repository,
@@ -42,17 +40,14 @@ expression F;
   E)

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - parse_commit_internal(
 + repo_parse_commit_internal(the_repository,
   E, F, G)

 @@
-expression E;
-expression F;
+expression E, F;
 @@
 - parse_commit_gently(
 + repo_parse_commit_gently(the_repository,
@@ -66,78 +61,63 @@ expression E;
   E)

 @@
-expression E;
-expression F;
+expression E, F;
 @@
 - get_merge_bases(
 + repo_get_merge_bases(the_repository,
   E, F);

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - get_merge_bases_many(
 + repo_get_merge_bases_many(the_repository,
   E, F, G);

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - get_merge_bases_many_dirty(
 + repo_get_merge_bases_many_dirty(the_repository,
   E, F, G);

 @@
-expression E;
-expression F;
+expression E, F;
 @@
 - in_merge_bases(
 + repo_in_merge_bases(the_repository,
   E, F);

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - in_merge_bases_many(
 + repo_in_merge_bases_many(the_repository,
   E, F, G);

 @@
-expression E;
-expression F;
+expression E, F;
 @@
 - get_commit_buffer(
 + repo_get_commit_buffer(the_repository,
   E, F);

 @@
-expression E;
-expression F;
+expression E, F;
 @@
 - unuse_commit_buffer(
 + repo_unuse_commit_buffer(the_repository,
   E, F);

 @@
-expression E;
-expression F;
-expression G;
+expression E, F, G;
 @@
 - logmsg_reencode(
 + repo_logmsg_reencode(the_repository,
   E, F, G);

 @@
-expression E;
-expression F;
-expression G;
-expression H;
+expression E, F, G, H;
 @@
 - format_commit_message(
 + repo_format_commit_message(the_repository,
=2D-
2.24.0

