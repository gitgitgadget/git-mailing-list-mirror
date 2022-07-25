Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB264C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiGYUe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiGYUey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694D22B16
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so10135668wmb.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C61v+GzyIPI4XXR/NeNceaeEZ7oq7/iPOtUzMcXWCvI=;
        b=W0M4fed7ph1fnOik/t08EzccrcPtKCm7MoYZTpF0qXgvr5zJr3LT70lazW/tQLivfQ
         fYxAv8B26gxqiE6pq1Bw4ZLuYTklTeiMflBDXMGrzNQFZJiCpOQlZPWnbnGys60gTxO3
         99Lm5C1ehE/cPoM3eAB6D7FlK0Tn3fOCfFJCsYxnub9gCMnmRWEySBK2Sfzke4a3ZqKV
         SI20Nt1CNqZB0j1fzCHt6Eug/m9z7x0HOwT2Ndre9etKXlZkx5aaRhtmb5rFxRk9Oe9Q
         O7cIHGJQ0ES6yglCPLXgCRO8c4Fhw6jNBxEJSyrqPHCzL5fuUljOIwaNqCyJrNERcTg6
         9hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C61v+GzyIPI4XXR/NeNceaeEZ7oq7/iPOtUzMcXWCvI=;
        b=FPB5qY13K36vjTmtFgLh9cMWW3P+uSFzbsRxi/bQ0a5YnijbDuTNgBlr/HzRkC0fPQ
         HdeceN5dccPFkx3+N78HSaborAyESmcGJPlpHcVFkcnPEKvG6SolR9KSbU4bZZssi+Oz
         BBgiNSRr/EP3D7BRpLiYGX7Q3EYiayPopAxn+qqP++If9yLRbU/0uW//N/UZfj/rnEDk
         Uox9+/s2ZTlnUZUjglJWojJcfWRsCCZFhCjLn/f0xyGsLbhz1cK+kMktwqppmRaBWLja
         JvhpZFdTkYk+PYiCM5wJ6IAIIBRu/oTdvjjFgMXGyQmzo3xBUO6QvqP3CBXOyN/JAtbA
         t8yA==
X-Gm-Message-State: AJIora8ir2Q9IPoRtCYv5Z/CwH6WI2ky39LEUf/zhDwm3UmC6rJxR48I
        9kAEwDSgon83+t0zX/VDvPjVJXd5ObA=
X-Google-Smtp-Source: AGRyM1tArN4Cqfzxs+C2HSwvygZkFH3YNmLLGoo3Bjs/P+KCPhyTjkt43DQ6XNLcF1JI2yKtGMSzAQ==
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id m19-20020a7bce13000000b003a3102c23d3mr9423835wmc.67.1658781283134;
        Mon, 25 Jul 2022 13:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b003a32251c3f0sm16149738wmi.33.2022.07.25.13.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:42 -0700 (PDT)
Message-Id: <f6bc3177332e8608d0ba300669853bbad01c3266.1658781277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:36 +0000
Subject: [PATCH 4/5] bundle-uri: add support for http(s):// and file://
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change created the 'git clone --bundle-uri=<uri>' option.
Currently, <uri> must be a filename.

Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
and use git-remote-https as the way to download the data at that URI.
Otherwise, check to see if file:// is present and modify the prefix
accordingly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 70 +++++++++++++++++++++++++++++++++++--
 t/t5558-clone-bundle-uri.sh | 45 ++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index b35babc36aa..7086382b186 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -23,10 +23,74 @@ static int find_temp_filename(struct strbuf *name)
 	return 0;
 }
 
-static int copy_uri_to_file(const char *file, const char *uri)
+static int download_https_uri_to_file(const char *file, const char *uri)
 {
-	/* File-based URIs only for now. */
-	return copy_file(file, uri, 0);
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
+static int copy_uri_to_file(const char *filename, const char *uri)
+{
+	const char *out;
+
+	if (skip_prefix(uri, "https:", &out) ||
+	    skip_prefix(uri, "http:", &out))
+		return download_https_uri_to_file(filename, uri);
+
+	if (!skip_prefix(uri, "file://", &out))
+		out = uri;
+
+	/* Copy as a file */
+	return copy_file(filename, out, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index f709bcb729c..ad666a2d28a 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -33,4 +33,49 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone with file:// bundle' '
+	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
+		clone-from clone-file &&
+	git -C clone-file rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
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
+	test_when_finished rm -rf test &&
+	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
+	grep "failed to download bundle from URI" err
+'
+
+test_expect_success 'fail to fetch from non-bundle HTTP URL' '
+	test_when_finished rm -rf test &&
+	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
+	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
+	grep "is not a bundle" err
+'
+
+test_expect_success 'clone HTTP bundle' '
+	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
+
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&
+
+	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
+		"$HTTPD_URL/smart/fetch.git" clone-http &&
+	git -C clone-http rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual &&
+
+	test_config -C clone-http log.excludedecoration refs/bundle/
+'
+
+# Do not add tests here unless they use the HTTP server, as they will
+# not run unless the HTTP dependencies exist.
+
 test_done
-- 
gitgitgadget

