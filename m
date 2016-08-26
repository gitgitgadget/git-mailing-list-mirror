Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E142018E
	for <e@80x24.org>; Fri, 26 Aug 2016 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbcHZR6t (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:58:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34417 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbcHZR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:58:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so224087wma.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gSJah58vcMKiCi8OdSTUnKF3FHw+H97A3wv+GhjGWw0=;
        b=RCIG0RymjeTBp9oEboo3VOc789jbnDmPuhcUHfpLBwqjBE2xOMW6LIey2iG8nd20d6
         raA8X6GwqjryFhhNFd6kHkvzHC3aKsvZ7LL9cmb2bFBqZybhS25QDyiBia3zYJIzYjwA
         Ul7SUx2OOWBRduIKnGRvusAW3s3HLNmVcGkhpHuVb9saDBUVKl3Bl2qvHiAMbWWttFn0
         j3210l3UxshnfD4eIi5uves0lY/JVa3eDyqi4YrpZ7Zr9DE3MfU8NL1IxNKnBKAIIt5q
         ENIj2Z4OD81in4SPyq8EfG6SR0QQGw0QHlCK+EbIxkJvdNytxMFsvm4lnM/t2zEArRQO
         lp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gSJah58vcMKiCi8OdSTUnKF3FHw+H97A3wv+GhjGWw0=;
        b=XCIF0aSpLRK+/RS1v/3jcfuGlBcAp4akXZoLA8KNbKVGd49oWTlSpgJpf+BtL52jTB
         h2QoBX1A6xhB1SDu1iEbpSJ4AovDKBgglH96bQZyVuPK+RnlfJUZ/cT1c3Mv3VqrHDKd
         t/eFuKTYNmjAiwGNct2bLdSMZfWvuFMgeOHnlLFYs6ezpTeRONGHQLWgWH7WbfDi/ayq
         diClkBdK8wtjhZSh9+T565eqgFozBmC/hOKghltiol1FTdIX90YP1ytvzc052SLmL1V7
         oFRbLSTa54P2NO+kYlbAQrNtuQmXjfoVGPpYNGgBuWUIQ3Lu8yrUMyGhuoSXaOoUn8Ep
         84TQ==
X-Gm-Message-State: AE9vXwMPaw/y8WDnBEKa6yrZ0DB7kQZ3BjarXFcESQD+exyjmybFQhTVFbucI2v1C03n5Q==
X-Received: by 10.194.221.202 with SMTP id qg10mr5273833wjc.180.1472234326696;
        Fri, 26 Aug 2016 10:58:46 -0700 (PDT)
Received: from localhost (cable-86-56-27-135.cust.telecolumbus.net. [86.56.27.135])
        by smtp.gmail.com with ESMTPSA id a21sm141318wma.10.2016.08.26.10.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 10:58:45 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2 1/3] Revert "display HTML in default browser using Windows' shell API"
Date:   Fri, 26 Aug 2016 19:58:34 +0200
Message-Id: <20160826175836.14073-2-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160826175836.14073-1-ralf.thielow@gmail.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
 <20160826175836.14073-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 4804aab (help (Windows): Display HTML in default browser using
Windows' shell API, 2008-07-13), Git for Windows used to call
`ShellExecute()` to launch the default Windows handler for `.html`
files.

The idea was to avoid going through a shell script, for performance
reasons.

However, this change ignores the `help.browser` config setting. Together
with browsing help not being a performance-critical operation, let's
just revert that patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/help.c |  7 -------
 compat/mingw.c | 42 ------------------------------------------
 compat/mingw.h |  3 ---
 3 files changed, 52 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8848013..e8f79d7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -379,17 +379,10 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	free(to_free);
 }
 
-/*
- * If open_html is not defined in a platform-specific way (see for
- * example compat/mingw.h), we use the script web--browse to display
- * HTML.
- */
-#ifndef open_html
 static void open_html(const char *path)
 {
 	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
 }
-#endif
 
 static void show_html_page(const char *git_cmd)
 {
diff --git a/compat/mingw.c b/compat/mingw.c
index 2b5467d..3fbfda5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1930,48 +1930,6 @@ int mingw_raise(int sig)
 	}
 }
 
-
-static const char *make_backslash_path(const char *path)
-{
-	static char buf[PATH_MAX + 1];
-	char *c;
-
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die("Too long path: %.*s", 60, path);
-
-	for (c = buf; *c; c++) {
-		if (*c == '/')
-			*c = '\\';
-	}
-	return buf;
-}
-
-void mingw_open_html(const char *unixpath)
-{
-	const char *htmlpath = make_backslash_path(unixpath);
-	typedef HINSTANCE (WINAPI *T)(HWND, const char *,
-			const char *, const char *, const char *, INT);
-	T ShellExecute;
-	HMODULE shell32;
-	int r;
-
-	shell32 = LoadLibrary("shell32.dll");
-	if (!shell32)
-		die("cannot load shell32.dll");
-	ShellExecute = (T)GetProcAddress(shell32, "ShellExecuteA");
-	if (!ShellExecute)
-		die("cannot run browser");
-
-	printf("Launching default browser to display HTML ...\n");
-	r = HCAST(int, ShellExecute(NULL, "open", htmlpath,
-				NULL, "\\", SW_SHOWNORMAL));
-	FreeLibrary(shell32);
-	/* see the MSDN documentation referring to the result codes here */
-	if (r <= 32) {
-		die("failed to launch browser for %.*s", MAX_PATH, unixpath);
-	}
-}
-
 int link(const char *oldpath, const char *newpath)
 {
 	typedef BOOL (WINAPI *T)(LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
diff --git a/compat/mingw.h b/compat/mingw.h
index 95e128f..2cadb81 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -417,9 +417,6 @@ int mingw_offset_1st_component(const char *path);
 #include <inttypes.h>
 #endif
 
-void mingw_open_html(const char *path);
-#define open_html mingw_open_html
-
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
  *
-- 
2.9.2.912.gd0c0e83

