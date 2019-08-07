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
	by dcvr.yhbt.net (Postfix) with ESMTP id 069BD1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfHGLP1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 07:15:27 -0400
Received: from mout.web.de ([212.227.15.3]:45821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbfHGLP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 07:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565176520;
        bh=UrmnHZkCvNi8IBkEOSCLrVY//arqpUlRdlOZjw3LZbI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=PYv0wDr7iw9w0AeN6cxJrxuf5adIZ3BoWy7GJUq3z6I7eqhurSdQ2W9UOKJkf0CaJ
         /hP9Nj2f6ILsNLHvcMOp3WNm1eZ0onIB7o4H8n3xvpHxIjmrZ7IPAw3n/BXUEvTN6g
         ESvNI4zrDrjGg5c4Vukjv6KAJz8Ty9vsxp+aHAJU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZleQ-1hc9Oo2rMs-00LWyd; Wed, 07
 Aug 2019 13:15:20 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test-dir-iterator: use path argument directly
Message-ID: <7f428974-9218-fa7c-6f3c-3c0db30a7fec@web.de>
Date:   Wed, 7 Aug 2019 13:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fsA+W9b01nF1HheWpyB1U5jhOpXnF4+onWJakaUXwAZCzKJHG4e
 LpuCwGrk/tGvvbAMeFywveZftQRHzw35OOChN28sglnatejfAvELOCv/cJLbh8KBlpu2ETR
 uhV5/g3YMSgo6fp1CZtrbZ+Lhvj0FOr7Y/vk6Lb9He9fQ8HwEu+UyvTP6OD05z6u/kVSSc3
 GQbqdqoghVD9+mepopPQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZGATpvUL2Ew=:3puR8nIqiUix1Cj+9L/UKQ
 M4IGbZf4pnXBnp5TDaMZAL3NISeZATWiMyrfClmtoqvhs/aoydogUxjRsTpfCB6UTIsWDsqrC
 boYO2dhx4Ir410GxeCCEo6FPr4plSsG5dVEIup1phdYIreJULOg441NTt06CinwBAy3h3eYMQ
 +yaOc7exG4t23uBUIr0ySYRaw1f+FQsQoBd+5qDe4VGxV99vVTHcbOfajnnLYROwOvaK8pGgu
 Qzv3qNWou/z/wKIrmbnNdBWdU3p4Ob5oO+6l/kv+uhjT5hx3XpCLgn0K0RLRr8Gtw97iQL0Kc
 XEFKTR6zJc8cO6v5WQfVuqe2npxaiTRL0MkEvd7lx5TCQ6FGXiqhyCMTAeT1w5e+SlBin/WeD
 M2vWVupmkOwir7Zz4Ae0JG92ddI+H0uuY43FfqAPpweHhveh2jwS8Bd2q090qtwBZNXp3WriO
 uNYE6ULtwmeqxCfHflqq2V9bOIUkztGOcfUxBH46wCyimZCnNOWACRsnbwJr+47EVp/H5Y5r3
 s1BhfaB/6G0wtLQ5ZnIT6OsvJj/p/DecycATgrVZX9U/hIhTNmcbjAprFNYVX6luo60/bqopn
 WHJb0mO3/DPpcCZ27QRaTPwhotz8xSnkrtKH20Dood/CcXKAAvnhMlhwNO0e9eqwykV24CLcz
 v979FNfgh2uLXEuPdcT2QlptRL07EWfhTX/kfPANodoJAE5BBo2AugvmTULshLjOELX67EoN2
 ZA/LoC6tJBhm6wJdQVtWvgWMOkrYkfp9oCMLFA3zkC0ZxcWYcZqyhsniDrybixxY/o3Xhb1A/
 nxUsFdAkd8dUWAjDak+36r811mwD9nW6GJ8CBC8q/4Pt3A3b7UJlQmhmnFAIFUy8i2RkElZgs
 djEOUexeuyvSMwisg43ePcLdFYB+ItBDV5hPULIC64dxe0oa1soEv741YLDVxg1GU7Q+joTg2
 9GvMFnd5btprzTOGGwXm5NfbRUwd4GIR9BJhkwyaxDfChnFDRA7TPQjocA4pWVb/3riVTneMJ
 sh306begMFtwYKAlk5uOC89wtHIuwIX5a4p4zer7HtO5tsQMGO5oVND90SV9eKeTYVunxiZts
 7TGEHOAgTZ30k/IEEZ+4a9LzfiRNCFr76wZvTehzEqT+90fy4pWHvVG1x8X/PkkAyfPqfVMBD
 mbDzE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid allocating and leaking a strbuf for holding a verbatim copy of the
path argument and pass the latter directly to dir_iterator_begin()
instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This test helper was added after v2.22.0 (2019-06-07) by 150791adbf
(dir-iterator: add tests for dir-iterator API, 2019-07-10).

 t/helper/test-dir-iterator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index c7c30664da..659b6bfa81 100644
=2D-- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -19,7 +19,6 @@ static const char *error_name(int error_number)
  */
 int cmd__dir_iterator(int argc, const char **argv)
 {
-	struct strbuf path =3D STRBUF_INIT;
 	struct dir_iterator *diter;
 	unsigned int flags =3D 0;
 	int iter_status;
@@ -36,8 +35,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 	if (!*argv || argc !=3D 1)
 		die("dir-iterator needs exactly one non-option argument");

-	strbuf_add(&path, *argv, strlen(*argv));
-	diter =3D dir_iterator_begin(path.buf, flags);
+	diter =3D dir_iterator_begin(*argv, flags);

 	if (!diter) {
 		printf("dir_iterator_begin failure: %s\n", error_name(errno));
=2D-
2.22.0
