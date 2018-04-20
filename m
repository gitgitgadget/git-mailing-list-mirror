Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16301F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeDTWVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:21:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:52931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbeDTWVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:21:07 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCOdh-1fIgpA0xwf-0099p3; Sat, 21
 Apr 2018 00:21:01 +0200
Date:   Sat, 21 Apr 2018 00:20:44 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 01/11] argv_array: offer to split a string by whitespace
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <8171fd3920846e37c9f1cab6f1ac658dbfb01bfe.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HPpZLSfLDhsmCYETxAehq4ud+jFRJY1EPFuxEfaOjHLCGIIe9M+
 MkrNuP6gMSlDb5AEb1R9LtTA7af49lb+XbLojc7DdS6gsD/gjsUAETyQoYMKFI5qUEtL3PG
 CFfx8KuFRJMedW/h1OUBPOBg/G9RfoyTnHpOkiqFMCrBBYTUIEoQ8Yr8hBMFexlP4GZmdTR
 ulKR9hvrSxXOL4u08ZS2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z0bd39pHduY=:rfC1AFYzcST28UBNuqmtGP
 vmWxKolEnw5kBN/Us+iqhDAeqbw6GXSugBlCqTVvRjCcKVfSHcTo0VHcOF/1D9Y4tcF/KqPh6
 u2HuTs6COzlO8/npML/omb0Mu0d4rt8rrMB32GrbMjieWbq8tWiUq/F8f1rRNIMANDHIHz0ce
 w4WlrxjnE69wFAQdIEzoHAcb5VWDl5T7EnQiDMFJx919ibk9bTLf9PBkXHxhQbM86hv7XqHHF
 4sZ+LmGOKzyLE3L0vCXgB/aaXs2U/XsHFg9vhF1aaUlZrPyPEFE05pV0JCk2uZ9rWmLM8Y2pg
 jV0+nDrJkNujXVKFpgc9awVIGvSfejjUltGNMgMF0ZpCDZ47AIdGPktVhl1+wEFyasdfbqFlI
 7CcM1JKM3E1ic4JaMXJeBbbDkS56hsYMrbom+kz9CdQ5uk8vands7DDb3xB91j3gS+hewAAaP
 NrqxQtx0fBHOLxxuoLi6oBACN7BmMqtmWKyBoWBheLdHhdvk/Eisjfb1wq0RLoyyunYvTx3iV
 wjXAlO1u/1Yo+oj5nA3o9RzB6vUKYttpzFE/7epCKI6OGVPVoV8CjhdbzU8TU4bSpmKlqAj9r
 K0LD9ICEmQD1mksDs502pW+7NPUz2wDLGz7i7z7qJSnBsHrWRGvg8GdTxGqMCzTQCh1MejLeM
 cFREVtvfa+pnOhQCEmhf/H8Wqc1KhBW41iUfKEYQLU27qo5FpX7nfLs8PTq/V27jYrzmeqVP2
 f2PsDGJvT/ZEg1UwtIOeTijahG1czNA0jQ74lZJ2bZxTV40Cwpi3Trtdah4FljfXyaOq82phq
 OezjsH80QaIrT1gtjnP2gh7JN2W9cj1UMuVQlJ7mw7KI9ZxOUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple function that will interpret a string as a whitespace
delimited list of values, and add those values into the array.

Note: this function does not (yet) offer to split by arbitrary delimiters,
or keep empty values in case of runs of whitespace, or de-quote Unix shell
style. All fo this functionality can be added later, when and if needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 argv-array.c | 20 ++++++++++++++++++++
 argv-array.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa3366..cb5bcd2c064 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
 	array->argc--;
 }
 
+void argv_array_split(struct argv_array *array, const char *to_split)
+{
+	while (isspace(*to_split))
+		to_split++;
+	for (;;) {
+		const char *p = to_split;
+
+		if (!*p)
+			break;
+
+		while (*p && !isspace(*p))
+			p++;
+		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
+
+		while (isspace(*p))
+			p++;
+		to_split = p;
+	}
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index 29056e49a12..c7c397695df 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,6 +19,7 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
+void argv_array_split(struct argv_array *, const char *);
 void argv_array_clear(struct argv_array *);
 const char **argv_array_detach(struct argv_array *);
 
-- 
2.17.0.windows.1.15.gaa56ade3205


