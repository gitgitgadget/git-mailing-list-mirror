Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8511FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbcFWQ3j (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35523 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFWQ3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id w130so18868892lfd.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3q38FPShs1CWih5zpSUiuNNjKkcFdQ/M3tjHMtQBqg=;
        b=e4Lom3GTHBjbXxFMJOQcbJ1P25V33So2cA+MxP3ksrOwxf3U8TP5jX1d2Lik6tMeJ+
         kO+VfK+nTzya1sVM11UbE1hia9xLB8J15vreHnJ84JVFLgle7jteTloeI3ig2Yv1L9h+
         8Fcrg9WR3Ra/q5o4s6Bmz+9b9gTaz7KBTGGIXQ0QBo8tRUzOL1fVkA7MS/X1xwzOdjtq
         ni0CYb34BZx5648TLRvF7Vwzid4guqhi2eOheT3RujuP4wIWhI2QKVDpjPJK3o67mxff
         R8gOy78ib+AIAbmvV5qiLtWactcEoA7Y4xz+k/5mv6WmHNIlD+6hu3cjM6OvwqJ37sSM
         ApYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3q38FPShs1CWih5zpSUiuNNjKkcFdQ/M3tjHMtQBqg=;
        b=YlsvQAeNDPOWMXRITH+TycKtM3M0K9cVcqohPhnMMI6cUX2NKBwQ95GJIJJewNROwO
         H6Otcdl8byF2qNhqnFTD2sF4YIQ+Y3zKVNVVDPcWUX/SB1CI+q2ANN4CFh4SQq75hvad
         MDNTBmOxIgNHgYxYqcQb7p2CTaCmFbbDd5o+0YdBIj4cVdkH1k5mgmkOPvTflNm1m8mQ
         AoZpi4/lOUK+sUIroMgZ+WOm0cN3ZGHDpy1nqkQzzjcBViG8huPqSkqS5QbJoGJS7szC
         BHjgefZzNyaJq6vgXkzhTpDfF0MW40IHyJ9nHmoejV/DtMj8pWqCMq/vJkxk/c5FIBw/
         ASjw==
X-Gm-Message-State: ALyK8tLX5ukSD0ZTYtpbt1V7F8aPPP8x8I3BDSxQ7Da7pHGW8C1TKEq+NDWAXVG2bJocvA==
X-Received: by 10.25.19.95 with SMTP id j92mr12457475lfi.13.1466699372341;
        Thu, 23 Jun 2016 09:29:32 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:31 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/11] test-regex: expose full regcomp() to the command line
Date:	Thu, 23 Jun 2016 18:28:59 +0200
Message-Id: <20160623162907.23295-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-regex.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 67a1a65..eff26f5 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,4 +1,21 @@
 #include "git-compat-util.h"
+#include "gettext.h"
+
+struct reg_flag {
+	const char *name;
+	int flag;
+};
+
+static struct reg_flag reg_flags[] = {
+	{ "EXTENDED",	 REG_EXTENDED	},
+	{ "NEWLINE",	 REG_NEWLINE	},
+	{ "ICASE",	 REG_ICASE	},
+	{ "NOTBOL",	 REG_NOTBOL	},
+#ifdef REG_STARTEND
+	{ "STARTEND",	 REG_STARTEND	},
+#endif
+	{ NULL, 0 }
+};
 
 static int test_regex_bug(void)
 {
@@ -21,8 +38,38 @@ static int test_regex_bug(void)
 
 int main(int argc, char **argv)
 {
+	const char *pat;
+	const char *str;
+	int flags = 0;
+	regex_t r;
+	regmatch_t m[1];
+
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
-	else
-		usage("test-regex --bug");
+	else if (argc < 3)
+		usage("test-regex --bug\n"
+		      "test-regex <pattern> <string> [<options>]");
+
+	argv++;
+	pat = *argv++;
+	str = *argv++;
+	while (*argv) {
+		struct reg_flag *rf;
+		for (rf = reg_flags; rf->name; rf++)
+			if (!strcmp(*argv, rf->name)) {
+				flags |= rf->flag;
+				break;
+			}
+		if (!rf->name)
+			die("do not recognize %s", *argv);
+		argv++;
+	}
+	git_setup_gettext();
+
+	if (regcomp(&r, pat, flags))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		return 1;
+
+	return 0;
 }
-- 
2.8.2.526.g02eed6d

