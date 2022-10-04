Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8975C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJDMe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJDMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056B32A99
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o5so8804508wms.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=kupYi6/9WqhsRJJ6y13cbKlv+k6oHa28SwGeWIpevR+RAT0V7aHAIjgZ6uWM8i82yJ
         WGJnv6fWCVvkR3ab4nWPt7wvBhhi49QoBm1XRVp41iDowMz9wwtSSc5RhluKXGZXvnDg
         SyePIfJ9E2uJXF+J658tKOeZTk243GeJMEc/cYN74xLp5DlD2uo7f9GKycSQjohb7qmE
         aGpFB5wpHzEL96EZnrukvcpxJI4tA0YX32iOkfb1ehj/AKkLjEkoHwZMiSjsPxlY53ra
         3BEU2Ki/v1WBo5m6XWzgfJ6CZJR0OAHnE5/crFDO6IzS+fi0/m4zV54QcCVhYicuguD3
         Uh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=jTsmy4izjdAJObiqoB7wiTDdTnXSW0hrOPWTOgDaxTPzathZPGRBUxMV/XN9Tfwnhi
         CoYnwbewiKr/7du1APpQ3egHkr36nRBK6vmeO1P6Kan6BwP1OWC3Gwnsd0XdYtdRNFp9
         ASNmCjad7zwuyQB0gH6tpofcUiW+bE3w12SqZUO358FPGX7zXLtPgtKvdZpbLR33v/Z2
         CbZwWxkPAx6Lxj7whruZStLY6fig12Q0EQa5FVLKR1/mRnoJnt2ZTEM2dODjFC+62KF1
         zPpol4Ighd+dukmsPgLQsbyR+/qEWGiZJJ/0vO3DHpdKvpxzYorkhNS/veG3V1IgiKal
         OXWw==
X-Gm-Message-State: ACrzQf0FDqv6qyvLqsD1leZuBqYwuuju2ic4SYozrr+o7aY1OUwMVswv
        DI++nGx9MZyetuYY7N5ZLzz6WyCuFCA=
X-Google-Smtp-Source: AMsMyM68UIBYYECvYENken3yhRUeYcefq0BP6PX8kh9AIiVENxhTeZ5/ELyoxAcFRSswSL/0K+mlcA==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr9740949wmb.20.1664886863942;
        Tue, 04 Oct 2022 05:34:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00228d52b935asm12828055wrv.71.2022.10.04.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:23 -0700 (PDT)
Message-Id: <48beccb0f5efe6f9247968cd0d4c455c23a24c53.1664886860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:12 +0000
Subject: [PATCH v3 1/9] bundle-uri: use plain string in find_temp_filename()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The find_temp_filename() method was created in 53a50892be2 (bundle-uri:
create basic file-copy logic, 2022-08-09) and uses odb_mkstemp() to
create a temporary filename. The odb_mkstemp() method uses a strbuf in
its interface, but we do not need to continue carrying a strbuf
throughout the bundle URI code.

Convert the find_temp_filename() method to use a 'char *' and modify its
only caller. This makes sense that we don't actually need to modify this
filename directly later, so using a strbuf is overkill.

This change will simplify the data structure for tracking a bundle list
to use plain strings instead of strbufs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4a8cc74ed05..8b2f4e08c9c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -5,22 +5,23 @@
 #include "refs.h"
 #include "run-command.h"
 
-static int find_temp_filename(struct strbuf *name)
+static char *find_temp_filename(void)
 {
 	int fd;
+	struct strbuf name = STRBUF_INIT;
 	/*
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	fd = odb_mkstemp(&name, "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
-		return -1;
+		return NULL;
 	}
 
 	close(fd);
-	unlink(name->buf);
-	return 0;
+	unlink(name.buf);
+	return strbuf_detach(&name, NULL);
 }
 
 static int download_https_uri_to_file(const char *file, const char *uri)
@@ -141,28 +142,31 @@ static int unbundle_from_file(struct repository *r, const char *file)
 int fetch_bundle_uri(struct repository *r, const char *uri)
 {
 	int result = 0;
-	struct strbuf filename = STRBUF_INIT;
+	char *filename;
 
-	if ((result = find_temp_filename(&filename)))
+	if (!(filename = find_temp_filename())) {
+		result = -1;
 		goto cleanup;
+	}
 
-	if ((result = copy_uri_to_file(filename.buf, uri))) {
+	if ((result = copy_uri_to_file(filename, uri))) {
 		warning(_("failed to download bundle from URI '%s'"), uri);
 		goto cleanup;
 	}
 
-	if ((result = !is_bundle(filename.buf, 0))) {
+	if ((result = !is_bundle(filename, 0))) {
 		warning(_("file at URI '%s' is not a bundle"), uri);
 		goto cleanup;
 	}
 
-	if ((result = unbundle_from_file(r, filename.buf))) {
+	if ((result = unbundle_from_file(r, filename))) {
 		warning(_("failed to unbundle bundle from URI '%s'"), uri);
 		goto cleanup;
 	}
 
 cleanup:
-	unlink(filename.buf);
-	strbuf_release(&filename);
+	if (filename)
+		unlink(filename);
+	free(filename);
 	return result;
 }
-- 
gitgitgadget

