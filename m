Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602DA1F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdLaIGL (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:06:11 -0500
Received: from mout.web.de ([217.72.192.78]:54582 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbdLaIGK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:06:10 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1eoT5i3oXN-00sKl9; Sun, 31
 Dec 2017 09:05:56 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/5] strbuf: add xstrdup_toupper()
Date:   Sun, 31 Dec 2017 09:05:54 +0100
Message-Id: <20171231080554.22301-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WE1c8qhNkA1EM7SjqaTJyeEQwCTAcgmegYUNPoe7L0HLL/uKYw+
 DuP7yvvvZ4MXBCFEZboxs5yaEOz/+B/mtKrPh3soN/YgtsTe6d4E0tWxLl3dbIBgyjS5foC
 AQ8d0df7HUwVI5OaT4txYE8BJvKCiwlFE/QEG4+1x07M4P+BuUkJAI9l0F+u2ztli9Dst95
 Foer8+6huOF1HtVE9dGxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eKzRTouMods=:+PzzPyHODQdb++sjfj/pV5
 qVQnvo7RIo616VForCsu47cHpHWdNDs4plLEevSdnBfDpBeoSRrrRuTpjPV7jwL5XKJpIiHz2
 o1HM7iNkop0HxRwcSduYCGnGWq6sKyRZ9WAoeGON6IpdIWklzIlY2eRDtILEoRRhbwqOzHrkm
 NbuF+0ohCqbDsOG2hQy9pSj1o/5Py0nMvpZOYzwrX/UXb+aDJjaTi+iMrrIc5AAfmiV+I0RcE
 ohi5xYArmsItwbcHi/blpAZB38TzpcYZ5/1EKf2pmRAYY8hddSVqVC5YQ1038z4ZCML8yQBep
 14ii+Bo8y1/fqUsSliX+u5ZiBmD7EkxhtDhdXg5DinxkVMfPVyO2DAacbEKTpXQ/Y148F+viD
 AW2AI7oU2jaTEHx2PdOSoUT/Z7sb5OV0+cnSWN9mSURj3HiHEhL/IJpjUabBj0Hmrin4s5HEZ
 HFVADOOSV0vIJ3/Gf5CLT1VkxVZkgPDvVGFL73ue2q367gW6XIVE8g29LD3ZFnfbLX89gFn+o
 puXDl7nFvQ+Z2P9fsoen1AW3HuShmLsLqsP0TqPN/xKDIRDGwja1BVzEDkOHosVC5P/mcJv4v
 c2KsSufiu3gX6qf1YWFWFrGnOmUukb4f3QjTkpgz9sb3vSiz0u1FjDjKhCXXxz+WInYM8dfmG
 e6hx7Qhe1i8nV70b0/mmmZmMI6E89WsVpn+cQ5uy+IE4YYAjHbNyTrojxbNtKqAmfPw34HxUv
 1LyRK7M0mS6wZjEnZDXDZwizJwUBlHv2qtkPumRhsBUv+bjs/f14tS1VI38XFYmyohH68itJM
 cIBMQ0cJHw/evkz6yVgs1ODBfZZGnAilqiCKmnsl/4DR05qPmE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 strbuf.c | 13 +++++++++++++
 strbuf.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 8007be8fba..ee05626dc1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -785,6 +785,19 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	result[i] = '\0';
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.0.rc0.4.ga4e00d4fa4

