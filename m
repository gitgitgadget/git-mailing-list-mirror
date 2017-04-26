Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E29207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbdDZUU1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:51245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754285AbdDZUUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:25 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTkNU-1dTyXB0uES-00QUYj; Wed, 26
 Apr 2017 22:20:17 +0200
Date:   Wed, 26 Apr 2017 22:20:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mjfHlqaJSL+deYrPKjUJZtSiDg+XYOCjpEytKtcPKGj/NvgLqCD
 P4huqqN7RFyiJ2yXEMKTAzWqKtq/iBbRT7jJPpSHmKrKBkuq/lAoP66jmd0XYiLUCRzk5go
 Jf5HIUko7P599COH9kSlJSUIWm81RH3vHr/V1LY4pfMW7PY+hQgvnOJZdgrlNL0AnvO0aOK
 H0EebC8i/fIOh3DhzAYDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nnCB1y5MtVs=:fQVS0xrCC++KmNl7Tl+VAq
 1lfc7MwurZajBeDUi5A+rRENGV7MPD8qMOT/mmpzQ1VgQatsx86BKkPFO6Mb7IPjaJ7dfelHV
 xpQA5C1JQTJSvDGMpikDlNR+KLAJdNVUuYhH5j7rKG42iuGdmRxeOfVCD8e4BVLdGprvLdE4W
 oD6RRQ3vjnhd6SWSt5qvEYER8s68MRsxMaZi8LhhXAzGK26NKsRskXmFObXGa7+KS2n29Phe0
 dNkcDE1kfvEeP3Do3lgICjbCrs36n4X0mZCjthZ/v8ccyUiG+ibfSGV7ah9AR4+Go4I+oUd9r
 jnVWLkvoVqvSAL+SLsDM6M8lP3gFqIKcwOXdXWhp3rX2Kycvzmb64RDsehEgCYg91VFc6kthX
 cLaF2v3N+1jr/iKl9QRxb9WquLn84sl1okJBVQ9XalZbz3lBeDfgZBKHqzAcR7t9Lt0XzTx9c
 rE93mIiYXt80Yr766IMl9osBRFfy9l+gW9RtW78kenPN/vJArymyrRf/3UHYMUusAtwoVczPJ
 s5+EW5c6GoBu2laCBQVgAGbep3EmOZaBTZm4rO1qMstAk/rTV2uYHLtrkMZdv5RvuxRBxfWAc
 ixR+TRuCIbKeD92FA03jxVW1uHKR1pgD3TbjxAPcjJ97UfegeNj1MhgD/zXp0sIuNPlTsDUNI
 VhWVbxYPhcqZhskrYuDKfGpoyAQ7pysKQdqNlDNOka4Q06JjhSV9KA9mrq6ZjxMPG8ePeEhQT
 WxKY/mJHEP3S6XMNsZI2hUJXJSAcSIZAJ67O6QXTklZeFp/eHpnjP32wj47+5SB3SesV52oph
 e3kpXRB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mailsplit.c | 2 +-
 mailinfo.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30681681c13..c0d88f97512 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 
 	do {
 		peek = fgetc(f);
-	} while (isspace(peek));
+	} while (peek >= 0 && isspace(peek));
 	ungetc(peek, f);
 
 	if (strbuf_getwholeline(&buf, f, '\n')) {
diff --git a/mailinfo.c b/mailinfo.c
index 68037758f2f..60dcad7b714 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1099,7 +1099,7 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	do {
 		peek = fgetc(mi->input);
-	} while (isspace(peek));
+	} while (peek >= 0 && isspace(peek));
 	ungetc(peek, mi->input);
 
 	/* process the email header */
-- 
2.12.2.windows.2.800.gede8f145e06


