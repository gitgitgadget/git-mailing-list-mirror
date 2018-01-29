Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A511F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeA2Wiz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:55 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:56424 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeA2Wiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:54 -0500
Received: by mail-qk0-f202.google.com with SMTP id z64so5381921qka.23
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vBd/EEoddUiYmymfNtQPgAlYcxoGScwta+kOjACNHaU=;
        b=T25s2D+spVstx49SENsQ1SgZ699vOlrguKywkbWhI0Pn9+tOI6YzcwO7bamOaHiMup
         qRDgJ4X4t5cUJYNS5+7u4sTSWtghJdeehUKD+46SUg80vze4hoLMcjZl9dvGtFBs7PPl
         FvFvMKZJdMuXvfs9EbinnN/HlNaRSzy41NQZqAZTurizudG87Y/+1ix0lIDqRbnW31ou
         JUED0yTepOzaAajIJrUAwso7Zgplp11gUJIqGyoV0mR4i51tE6QwcLERIunqyvfhA6rX
         a1IxrKhZW33b+Rg3K+oPGqtws1JKNfgs1Ds8oBjRnDKjHc3LeQ76TuJguGYloVk52pXt
         jNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vBd/EEoddUiYmymfNtQPgAlYcxoGScwta+kOjACNHaU=;
        b=iYMDNCZ199lnMryHREScfnpeAQd3HRjrjZz2ToFXXanlIKCxlJx48Loj6WTfoAh9m6
         wSbIZ8LdvnekQVHin87rieA5dPze3d+sje5oHh5nADBYi1nEYSsuNDhz0fjcy2iUw98u
         teDvBUyLwS029khpfJZX50wITnHZoIZp+Eq9lJOmr6wAwIQGlexmJq5Vfoi2sVEThYr7
         dCOYY3Xo/2AdygiOLmyIxyxJrz7ZiiA+x2l2cQS8M8qI0wPawIBVVNsWSqBOYlOdDgsY
         iO/WL4snBMl98o8QZqjxe0yHdgsPdMJPoa/+gY9FiNNwO6kvzn77aSPYL9g7ts2AGyZQ
         rUzA==
X-Gm-Message-State: AKwxytdeM33rh3HaDC2bplVN0jLsUgT9A2jA1jpohxc4ZgVwrZOjQrfv
        Oa6yMz4b1ZEPr/NYQjLaWhJr21Te9Zugd7GCQCDRvTmudheaZA3MDnLuli0FH0WCDFjxPafShWS
        6cnZNnlabudQKQDDGfiNCyakj2+tgVOdsV3by95B6tFAxfGTnxadmIBCGzg==
X-Google-Smtp-Source: AH8x224QfGoI3FbMMPkaNX9pr6ujkTewm+VYD6Kl/te79jsbT+KMtcNTPz4kiFbxJoC5BJ0pIt3msFJKHp8=
MIME-Version: 1.0
X-Received: by 10.237.60.248 with SMTP id e53mr17965900qtf.38.1517265533304;
 Mon, 29 Jan 2018 14:38:53 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:22 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-32-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 31/37] environment: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       |  2 +-
 environment.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 69b5a3bf8..5b8d49377 100644
--- a/cache.h
+++ b/cache.h
@@ -1673,7 +1673,7 @@ struct pack_entry {
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-extern int odb_mkstemp(struct strbuf *template, const char *pattern);
+extern int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
 /*
  * Create a pack .keep file named "name" (which should generally be the output
diff --git a/environment.c b/environment.c
index 63ac38a46..98f77ea95 100644
--- a/environment.c
+++ b/environment.c
@@ -247,7 +247,7 @@ char *get_object_directory(void)
 	return the_repository->objectdir;
 }
 
-int odb_mkstemp(struct strbuf *template, const char *pattern)
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
 	/*
@@ -255,16 +255,16 @@ int odb_mkstemp(struct strbuf *template, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	git_path_buf(template, "objects/%s", pattern);
-	fd = git_mkstemp_mode(template->buf, mode);
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	fd = git_mkstemp_mode(temp_filename->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
-	/* some mkstemp implementations erase template on failure */
-	git_path_buf(template, "objects/%s", pattern);
-	safe_create_leading_directories(template->buf);
-	return xmkstemp_mode(template->buf, mode);
+	/* some mkstemp implementations erase temp_filename on failure */
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(temp_filename->buf);
+	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
 int odb_pack_keep(const char *name)
-- 
2.16.0.rc1.238.g530d649a79-goog

