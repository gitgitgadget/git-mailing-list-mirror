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
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B8A1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfHTVMS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:12:18 -0400
Received: from mout.web.de ([217.72.192.78]:43373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566335521;
        bh=AzVAKuxy2PP4CqDmu8IEhcH85ZxwoBlkkIStUB8jtB0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hhNkB5/SY1xS4rTaCzynwbVUGiyClp3y9QS3jFSOSZkxQTo/yQj8gteQexQCvMwwm
         XHud/AzHFfffx8fCizd5MhgbE3NA5ksrgIN7h7Z89/0OADBY0GLwYaZScPHeU6KQAA
         Hi8+CbRQ7SbGAwVfl/VvpO0d86O6BKLo3IZO534w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUF4Q-1hrpR52zti-00QzqG; Tue, 20
 Aug 2019 23:12:01 +0200
Subject: Re: [PATCH 02/26] patch-id: convert to use the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
 <20190818200427.870753-3-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1d3b46de-155a-6072-5e44-2622ac821230@web.de>
Date:   Tue, 20 Aug 2019 23:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818200427.870753-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FeIkMzZ04RKfg9o6wFCfqsYh0vaqda8bwnbvpUsHbxWywcbcqXg
 x9u+eAMKjE71qv2mcO5slhAfQIAJZduQbkQY0dVBUQ1pBrgtmD/gR/6PJ3I+YUpV8llcD7m
 XA4D3ik7I/t8FRkuLCTKp+Cxat233/f+NzySuBHRtVUpNke/D/IK9a19fyuT4ADNgaDtNjn
 NenXoSg4H2ZlPP3NCdAPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQ1/Slt8TWM=:a3ZHC8ceFxCSnuqRG3+X0y
 Y1bIf76ii4xpzwBKmYYIBkoMpauH2/AGJ9DQXHrI3/Dta/u7aPfGpHTpfb4IM45NiaIE6ppiI
 sBv7gbQCefT9o/F3A5CpYkkIw6Fr7n6zVQDvK78V1swwbgu8bFGX6YvpgpzkNdtDi+ig7+acN
 fDkNoe7UhyjOlf+zwQAwcDcVpP1Q5cydpo6Z8eUSrie0a2zh2JGK8qezkWjVsZ6ZNxazd7+5W
 Ijv0NPqzblc4IpTWHCHvFdGNRoQlmuJ7hErb5H5Zq+XbR25BAhqe3K6Q41q8f+ALqElT1Mjf7
 smrQ8AD90QFKf65pI5/7hr4nNnBZvcH9lc0yjxbJuehx+REkk2AVfqED3imjgcNsXHjWyZ/MO
 SeeeSSgq6rUN4e5CaTwEgr6aHUTXG1dDEbCsTb/B/19uJn4Vw3SLnSL+Qh1wOyvEDvSx2e2oL
 3pXKIt5F3HWslB8KqTFfBAKCZHCyYN3Fgam/+Hi0bosIxbQ5QrFZZq8i6m4xmb1VDOIenojvT
 jLegIsgPtGY4JW8jPgX8jJluT6AF1yQE977rHedJJWyWbbECiIqhaWGQ2dSsOWuTU458UXWNq
 hBEQ4vipawG461ThibO/b0mZQEBWYJ2akEx5W9R5RN4prqjokNWI79WxVQr4H2GZ6qhPJBIkk
 srlbhv0mrce5fnPAtR3yGp3ke/t1FM4vZF8f7DOCTxgV4i3Mm5ifFSSbzP599Vgu79Pm0PttY
 oaR68y7Z9n36I+SJWIbyKlVrlWeNfgl3WBtRsBZVrtI5R36Dm43iNh6aDB2eImZMi3r9lTQMw
 66l6U6VejNdfhdgRMmZtJW7ocRcYry8lzEx/8ZjB7mllDHy0CwbF5UEw0pn/NFov5dCjZUbmV
 2NriWh0C8Sgstir7k7Poe/TeSMx6F3/3L/Ug1UMFQeTwWG0XYoKIPHmhFABcJq5otnsu+nwPv
 Z2EN0+BIBBZMgnTe261jXWWloQeQH+ZmjoIrHKdprzJ26tTuOfkucShAlGkVLZwtfQkN4u7GX
 fj+g7oMqc4NHvlIPWfyjlJlJhZRNdAABGa3EXEl1bd3wwHYnL6TASRqGpNU5S+0RzQ2uSoUoq
 Q6yTQOSXHSxkXuClpQABlbSjHtINXcoStHaS+KkRni9j4W+Xma1poVGVxi9UWaWSQTY8pZ/vK
 dkQPk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.08.19 um 22:04 schrieb brian m. carlson:
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index bd28b80b2d..3059e525b8 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -1,15 +1,16 @@
> +#include "cache.h"
>  #include "builtin.h"
>  #include "config.h"
>  #include "diff.h"
>
>  static void flush_current_id(int patchlen, struct object_id *id, struct=
 object_id *result)
>  {
> -	char name[50];
> +	char name[GIT_MAX_HEXSZ + 1];
>
>  	if (!patchlen)
>  		return;
>
> -	memcpy(name, oid_to_hex(id), GIT_SHA1_HEXSZ + 1);
> +	memcpy(name, oid_to_hex(id), the_hash_algo->hexsz + 1);
>  	printf("%s %s\n", oid_to_hex(result), name);
>  }

OK.  But why do we need our own buffer?  oid_to_hex() provides four of
them for us, so the body could become just:

	if (patchlen)
		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));


Right?  Well, this buffer comes from f97672225b (=C2=ABAdd "git-patch-id"
program to generate patch ID's.=C2=BB, 2005-06-23), which predates the
introduction of the four-buffer feature in dcb3450fd8 (=C2=ABsha1_to_hex()
usage cleanup=C2=BB, 2006-05-03).

And with 30e12b924b (=C2=ABpatch-id: make it stable against hunk reorderin=
g=C2=BB,
2014-04-27) the function's name became a bit misleading, because it
stopped being responsible for flushing the hash calculation.

So perhaps this on top?  (Or squash it in, if you like, but it's
certainly not worth a re-roll.)

=2D- >8 --
Subject: [PATCH] patch-id: inline flush_current_id()

The function hasn't been flushing the hash calculation since 30e12b924b
("patch-id: make it stable against hunk reordering", 2014-04-27), and
there is no need for a private copy of the second hexadecimal hash value
since dcb3450fd8 ("sha1_to_hex() usage cleanup", 2006-05-03) added
support for up to four sha1_to_hex() results to be used in the same
printf(3) call, which oid_to_hex() inherited.  So print both hash values
directly and get rid of the function with the outdated name.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/patch-id.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3059e525b8..d328714af7 100644
=2D-- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -3,17 +3,6 @@
 #include "config.h"
 #include "diff.h"

-static void flush_current_id(int patchlen, struct object_id *id, struct o=
bject_id *result)
-{
-	char name[GIT_MAX_HEXSZ + 1];
-
-	if (!patchlen)
-		return;
-
-	memcpy(name, oid_to_hex(id), the_hash_algo->hexsz + 1);
-	printf("%s %s\n", oid_to_hex(result), name);
-}
-
 static int remove_space(char *line)
 {
 	char *src =3D line;
@@ -137,13 +126,12 @@ static int get_one_patchid(struct object_id *next_oi=
d, struct object_id *result,
 static void generate_id_list(int stable)
 {
 	struct object_id oid, n, result;
-	int patchlen;
 	struct strbuf line_buf =3D STRBUF_INIT;

 	oidclr(&oid);
 	while (!feof(stdin)) {
-		patchlen =3D get_one_patchid(&n, &result, &line_buf, stable);
-		flush_current_id(patchlen, &oid, &result);
+		if (get_one_patchid(&n, &result, &line_buf, stable))
+			printf("%s %s\n", oid_to_hex(&result), oid_to_hex(&oid));
 		oidcpy(&oid, &n);
 	}
 	strbuf_release(&line_buf);
=2D-
2.23.0
