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
	by dcvr.yhbt.net (Postfix) with ESMTP id EA18C1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 16:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfKLQzp (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 11:55:45 -0500
Received: from mout.web.de ([217.72.192.78]:36371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfKLQzo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 11:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573577741;
        bh=PAssyNBXezi9LaQ4OutewnmW85JZtKeYxsXiwVdodRI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nvoluzWlbjlsYF4I6huESL2tb5hyD6LWiNRpPf6SGrnnTw8J+C3Wl0AFXwq3PXNbW
         tTtVemsiRRhAujBXVimX8501M2oAopVTXNEpEMZUAQNtNAtNrIG270dL6zYTtyQeRN
         OvODbajoM5J6UijFKcjHNw3ODeUFfG0BBGr7xqlc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpVS-1i8xxa3cDG-00oD83; Tue, 12
 Nov 2019 17:55:40 +0100
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?G=c3=a1bor_Szeder?= <szeder.dev@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: merge eight rules from strbuf.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <31d2b9c8-31ec-4921-d38d-12712de819a7@web.de>
Date:   Tue, 12 Nov 2019 17:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DEDQDksjYFQ5B5fJSsyi358GDedw4kq3L6DodfISeSFXdyWKTR2
 KEJvBKZwgU6HuNOHvQ1dZAQdbEWmFEQuoUQBV4EITfBP6Pw50stmtvQxuGQUyB3uQOOMiL/
 iSeihAF94JxOc13X9/1YjPmm2IdrPQyrosROdviq63tshQSpj0XgcQIr0Q/eRz8OGH7WfD0
 uug0WNVeF8bbqS6sjO2dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sF0GnDrB5Dc=:LftGYLWqphJddqslUi2PGm
 jKTIpamsxagNCRvQq9y8OHeUwKh38pMGnlUN//n9Z1N6BDsRmNvG/ExfVV9AA6ZaWSt/eG/fI
 mftrXBptVlGUGaxfP5JpU5h5cEEplVowW8jlHWz6QBjP8cwg3lnYN6MOarRt5usVfBwah3EEI
 IFHfk7KgjZrn2aJTS2nGyy4YUQdgKnBpGODNV+pS6V5wqfXz4tjS1U7f9sBrg9eK/qBWfmDe/
 yPpijWHvSYp8X3zMyosK4p0mpxQyOwJZ/V6K6zi2QP5lGXwIWFdJQC3RI8YXwNAGQgEo7Yvm7
 OJtK8wIsCqAIFMG4t1RBym1jbRhwPE9dV+PcYSP/JENwYI+Df4YmrsGnfTEyet+I1VuiV4IsZ
 DQLmtTaR2n5SC71s71fs7xo1ohZEVhuzHsCLrBPDTzdWpIFhLyw7V1cHDgIyavlyLmx3HJGMx
 7MdSMze1YuRswtpXZmb2mpTokNzWFJBeOYB2Eoww63xYQid2mSjC0Bl5LsWAp4asStKq0PTC8
 x1VSKv1Uo9lLm55Zo184QuIdsYJWvFV+ZNBrK3hCgpLe7rgBJqTrR/MFz9sdXfZbC1rxiVU+q
 SKP0uugCj8ZTFrAJjYb063qJZKrxsY/hHUqNc1fmOvnqc1uG6E72w3q22TlzOtNomx9NW9Evp
 WI1Y6CZl3RnjiNGmYsbNUBfGJbmeZ4WRngoxbyS+zoeLZHHVBjeiIcdxdqgRLiIxMWrgDS4/J
 dU69CKd0ypDUV1mnku2Mhj9VbKTRqT0fiPsd77YwZFGeIKNmsEqpi29L9YfL78kxQHyaUnUiN
 tAYW6/ZtE0AhjxhYIZskd7/LUM5X6gn0eMBXI3yEq9YX76k/bxaMN2HN9zZ8rDNokHRWAZili
 U4Zf0HjtbzDBx1XcfXz1tk8SV3yz/5OCQTDmQP4J44LfquJ2vXIMNWV1kXQRB1/k9kxSHxD0j
 IWQaCWQ1WX6WQXMUAa7JwxcpiLAJu0xcxF3gfdOieguPck8nadGym/CdC0M+A0nLUvCrYcflh
 qEgaUDKDl3mTXrvXoOXDjL7wGYbElhfhitztQEHEg3611iifIKUfMDoEaqw6t6xszWUfSkr0f
 gq/TrxfOeIu3wrsXLl/BLVNtOtJ8z11PC99ssuAXU+mCqA8IZIGULTafql4mvSe3/Fs+8w4F7
 QPRKkB79QjUbs3P9dThgaSLtIgn2Eh+qAJ0muflUJZZwI8zs2AIQ7ZXa+ZMChtRDqKGBtDsHN
 PEr9ksYa08eA2YvK/4MhffjETSbrpajVmJMZEg5afpogh+fYiLfq3eoVSr3M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 17:50:13 +0100

This script contained transformation rules for the semantic patch language
which used similar code.
Combine these rules by using two SmPL disjunctions so that the run time
characteristics can be nicer because of common usage of a few metavariable=
s.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/strbuf.cocci | 49 +++++++++++----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.c=
occi
index d9ada69b43..b66c9bf8e3 100644
=2D-- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -1,7 +1,11 @@
-@ strbuf_addf_with_format_only @
+@replacement1@
 expression E;
 constant fmt !~ "%";
+struct strbuf SB;
+struct strbuf *SBP;
+format F =3D~ "s";
 @@
+(
 - strbuf_addf
 + strbuf_addstr
   (E,
@@ -11,52 +15,31 @@ constant fmt !~ "%";
   _(fmt)
 )
   );
-
-@@
-expression E;
-struct strbuf SB;
-format F =3D~ "s";
-@@
+|
 - strbuf_addf(E, "%@F@", SB.buf);
 + strbuf_addbuf(E, &SB);
-
-@@
-expression E;
-struct strbuf *SBP;
-format F =3D~ "s";
-@@
+|
 - strbuf_addf(E, "%@F@", SBP->buf);
 + strbuf_addbuf(E, SBP);
-
-@@
-expression E;
-struct strbuf SB;
-@@
+|
 - strbuf_addstr(E, SB.buf);
 + strbuf_addbuf(E, &SB);
-
-@@
-expression E;
-struct strbuf *SBP;
-@@
+|
 - strbuf_addstr(E, SBP->buf);
 + strbuf_addbuf(E, SBP);
+)

-@@
-expression E1, E2;
+@replacement2@
+expression E1, E2, E3;
 format F =3D~ "s";
 @@
+(
 - strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
-
-@@
-expression E1, E2, E3;
-@@
+|
 - strbuf_addstr(E1, find_unique_abbrev(E2, E3));
 + strbuf_add_unique_abbrev(E1, E2, E3);
-
-@@
-expression E1, E2;
-@@
+|
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+)
=2D-
2.24.0

