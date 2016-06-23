Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E9A1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcFWQ3f (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34232 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbcFWQ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:32 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so18868448lfl.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEnt+3D/n68T6V8UTjtIg6ll8nlT1SIPw/yPiHMmAVg=;
        b=SfT5brUERJgvWGaEJDA2YlkOtGXTQ3DiFCzeUQkmOYt3Ku32Pql1pZLRmDWLHtrQge
         NIZMVDnWe6/dpSVI9i+9bljC56i6p/PF81h3/F8AadxfUYtkmZ4HRJiPLuu5WcLV+vsg
         z4mWEzYUNUMVEj8QXyG+zyl8TSPvFU87Zm7BTH/Ru/4tHB6icJSG4HNEuJfiABguxG4V
         ehYssWY00g0FvV/lFF+JwlVTjUyucu9Ptg4XEGTRbcr2Du8OGABsdpfvmoqzW4aLsTsf
         vyf5f1a/SAPpYbw8ycu61AxEx3RC+XPhLQagNsXnfxHwWnd/oWYSheo5bAuMI7InrW3N
         3tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEnt+3D/n68T6V8UTjtIg6ll8nlT1SIPw/yPiHMmAVg=;
        b=IQwkRzih70+pjGx8S8UqCvddKVZXqv0xz6EZKtG+wgHRqh3aL/CFobE99HWp/tQyZE
         OEVJ6wHLmrMnY9sea69fjy0IWmuGrq/dikF0nY6zfhLbrYcCE37+ipFkOrRhUvEXE+nt
         ZPenudhNgSiTWFWhS1a21dEGBxjpyv5E/2CLLVCb6KNk8ykJklJ4m50IBsATfO9HOswu
         4/ZzOc8CJdfFK7LdAVfLIRgQZ6x3WKKfIrJKxwHRnXdXSCNOKGgOOmN3Wy8PvPWJ7sIm
         isQXDkBsLWLtUDNJmQguFSPzHuD0XyF6mUqAaKyYOBebVygtfJhq0qBDb4nUZBvF6YF6
         ab9g==
X-Gm-Message-State: ALyK8tJ+F44Q8l4d3mcZOdsebdIGNk+yoHRSRb6QSijo5Yql+mhphq0erhNfWWe2/1oxQg==
X-Received: by 10.25.158.204 with SMTP id h195mr13263237lfe.63.1466699371134;
        Thu, 23 Jun 2016 09:29:31 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:30 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/11] test-regex: isolate the bug test code
Date:	Thu, 23 Jun 2016 18:28:58 +0200
Message-Id: <20160623162907.23295-3-pclouds@gmail.com>
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

This is in preparation to turn test-regex into some generic regex
testing command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0070-fundamental.sh |  2 +-
 test-regex.c           | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..991ed2a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
 
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
-	test-regex
+	test-regex --bug
 '
 
 test_done
diff --git a/test-regex.c b/test-regex.c
index 0dc598e..67a1a65 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 
-int main(int argc, char **argv)
+static int test_regex_bug(void)
 {
 	char *pat = "[^={} \t]+";
 	char *str = "={}\nfred";
@@ -16,5 +16,13 @@ int main(int argc, char **argv)
 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=1");
 
-	exit(0);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], "--bug"))
+		return test_regex_bug();
+	else
+		usage("test-regex --bug");
 }
-- 
2.8.2.526.g02eed6d

