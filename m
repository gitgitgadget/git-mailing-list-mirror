Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4DCC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiF2UlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiF2Ukz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E514027
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i1so19688277wrb.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LlS/R0TUCygicnqPOeo69vntyf/4E59CAGedT3e4REQ=;
        b=XQ5o7GAe/SD3RvDLRl/jxzDBxixfQMAYHmS9NQY2P5PAVNvE+Fcc6wGFoxgKO1Nbpx
         Y85nOj7XId710peaO1XWr8DverLd2WnFp8uKC1cd8uY1x7qYKoEv4Lv4+epRYKbE5CBg
         0ERal4ATNFsUsLv8bL85zFyI7M3aGngKpxDErOb3v0TjMgcNAO/PLKEPxY9ZDI7uNEzg
         iw7HsSrwVGaka+cYSgKDsU5y1KBTv6ELEoxkU/z44+PFCENxpsy5JImK6/P1KJTHK6bW
         DXycccFx3sC8hYPQm+E1mcPNHn3U+pb9D13sA/Yel/iCjp4BgL1RuFLAWk5NFx+0TI3F
         c5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LlS/R0TUCygicnqPOeo69vntyf/4E59CAGedT3e4REQ=;
        b=A0A9kTFOuMZfL+G9J0ES16+4Ozgig/eriiGp+yG3rG7sAj0dvbMbfW5s1Z338/xQi9
         1xPTtH+4yd51hqZbiV4KsotCAbvgx153Yatyhn5ukleR5eps3t3lJPFdIL1dLqHzHtE2
         lHgclbbZK6zSaTX32ImM4T+U0uFtdPHKsMvvGg6Ct5JONaUkp6Rxap8N11Fy9MeX04PT
         TKc7vHxX91xBYnBb/WrmgPT2A+tMPYUmNZOxQ+mH40r0X4FGPF9d6lG27UHIsgPrkJzN
         JRhOb7secTpCM/+RGdbfdlsFU2zuF+FGjsQQX9x5FunpJoi+R3So8mQFYro0p4keaRB7
         OExQ==
X-Gm-Message-State: AJIora87OyveiG0rdQgpQES7bm8o6FHdlaZ/DOfzVe5RWq/FTGm+f96Z
        SnpLMnL9KdtHyicDL2SwqGVO7c7BkuIuwA==
X-Google-Smtp-Source: AGRyM1vjSvaklvU24n1/Tf4opeoOE5JsC6Ou74O1CIvX8N8M8TkTGcHI2YP8dp2ET9GSThfzw6gmmg==
X-Received: by 2002:adf:f052:0:b0:21b:c381:d609 with SMTP id t18-20020adff052000000b0021bc381d609mr5118834wro.453.1656535253055;
        Wed, 29 Jun 2022 13:40:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003a047f64496sm4299873wme.7.2022.06.29.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:52 -0700 (PDT)
Message-Id: <bfbd11b48bf1bcd2449dcb5cfe8c27266d511bb0.1656535245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:44 +0000
Subject: [PATCH v2 5/6] bundle-uri: add support for http(s):// and file://
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change created the 'git fetch --bundle-uri=<uri>' option.
Currently, <uri> must be a filename.

Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
and use git-remote-https as the way to download the data at that URI.
Otherwise, check to see if file:// is present and modify the prefix
accordingly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 65 ++++++++++++++++++++++++++++++++++++-
 t/t5558-fetch-bundle-uri.sh | 37 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index f80a3b14103..4c793843a2a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -19,10 +19,73 @@ static void find_temp_filename(struct strbuf *name)
 	unlink(name->buf);
 }
 
+static int download_https_uri_to_file(const char *uri, const char *file)
+{
+	int result = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *child_in = NULL, *child_out = NULL;
+	struct strbuf line = STRBUF_INIT;
+	int found_get = 0;
+
+	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
+	cp.in = -1;
+	cp.out = -1;
+
+	if (start_command(&cp))
+		return 1;
+
+	child_in = fdopen(cp.in, "w");
+	if (!child_in) {
+		result = 1;
+		goto cleanup;
+	}
+
+	child_out = fdopen(cp.out, "r");
+	if (!child_out) {
+		result = 1;
+		goto cleanup;
+	}
+
+	fprintf(child_in, "capabilities\n");
+	fflush(child_in);
+
+	while (!strbuf_getline(&line, child_out)) {
+		if (!line.len)
+			break;
+		if (!strcmp(line.buf, "get"))
+			found_get = 1;
+	}
+	strbuf_release(&line);
+
+	if (!found_get) {
+		result = error(_("insufficient capabilities"));
+		goto cleanup;
+	}
+
+	fprintf(child_in, "get %s %s\n\n", uri, file);
+
+cleanup:
+	if (child_in)
+		fclose(child_in);
+	if (finish_command(&cp))
+		return 1;
+	if (child_out)
+		fclose(child_out);
+	return result;
+}
+
 static int copy_uri_to_file(const char *uri, const char *file)
 {
+	const char *out;
+	if (skip_prefix(uri, "https:", &out) ||
+	    skip_prefix(uri, "http:", &out))
+		return download_https_uri_to_file(uri, file);
+
+	if (!skip_prefix(uri, "file://", &out))
+		out = uri;
+
 	/* Copy as a file */
-	return copy_file(file, uri, 0444);
+	return !!copy_file(file, out, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
diff --git a/t/t5558-fetch-bundle-uri.sh b/t/t5558-fetch-bundle-uri.sh
index 381e56cac20..919db6f4551 100755
--- a/t/t5558-fetch-bundle-uri.sh
+++ b/t/t5558-fetch-bundle-uri.sh
@@ -31,4 +31,41 @@ test_expect_success 'fetch file bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'fetch file:// bundle' '
+	git init fetch-file &&
+	git -C fetch-file fetch --bundle-uri="file://$(pwd)/fetch-from/B.bundle" &&
+	git -C fetch-file rev-parse refs/bundles/topic >actual &&
+	git -C fetch-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
+#########################################################################
+# HTTP tests begin here
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fail to fetch from non-existent HTTP URL' '
+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/does-not-exist" 2>err &&
+	grep "failed to download bundle from URI" err
+'
+
+test_expect_success 'fail to fetch from non-bundle HTTP URL' '
+	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/bogus" 2>err &&
+	grep "is not a bundle" err
+'
+
+test_expect_success 'fetch HTTP bundle' '
+	cp fetch-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
+	git init fetch-http &&
+	git -C fetch-http fetch --bundle-uri="$HTTPD_URL/B.bundle" &&
+	git -C fetch-http rev-parse refs/bundles/topic >actual &&
+	git -C fetch-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
+# Do not add tests here unless they use the HTTP server, as they will
+# not run unless the HTTP dependencies exist.
+
 test_done
-- 
gitgitgadget

