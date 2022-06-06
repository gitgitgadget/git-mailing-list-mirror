Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3380CCA473
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiFFTzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiFFTzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5C6898C
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso2573869wms.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hIYGdJt4f8CNfq862K1JDKESeUt40SEBwGrg50HJfWc=;
        b=iM5oFo6qDxaz7zuGDw9T9TMWZdJF/PWZOjUyOCk24yPwcUdfjT0zP4i7xs38Y9axdk
         JvvtZ/cm6vOdl1Qs3IHUHYrUv0x5SXfwZir0HoxFLoMzhv5Kg4rQnZckqiARy97tis+A
         USBye8mMbbbEzMMKIrplJSYwiPOiN8TqTKwih8dhEVlCH2NdWEr7+x2rKOrLHk9nHIK1
         qiV0nZWh+jZakP5zq1IARY2c5gsDY4t12dyl/KISUmX6NZz7xqFWY7W+KYS0a5wE15R6
         5vIHuR29MvYwRkm+cjEnf2wsdQA1Ocv1dSu/b7w1r0PktpQK/ttzxgg2Ke8jy7A3BbXa
         U6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hIYGdJt4f8CNfq862K1JDKESeUt40SEBwGrg50HJfWc=;
        b=IDyuxZasXqtD5wD1NNi03Im9/6lHHTiHlRqCjsabIADEgqVFl/f1yCqPOWZ0WUY9zO
         37FUUjuBQ8fm2ZrpPxmnTV5XtleWI+11zgXZbDsFCEGQPWHmvLHe6TdtN8lH6f8S4Xlj
         gQklv9FBGJO0r716XIpoau7I0A7Rz9WlJXmgnjBaVwVoie1tr5J7PuvrZV7gkgrKoU43
         eCqZ67QvELvjuneWGY6C6p1h6ELsovmSvKwiHrdYP30EawaGzQNLyIxGzGMnXabdWVZA
         OLF1RLvggeOKHp22/G2Wry/oSLdp2LYyGXHvtquTsLwYHxiBFOB2CK+TRPSP26DzPzwe
         oCZw==
X-Gm-Message-State: AOAM533I0DC9h3zfJkkKhRpXS3htxVAgo+mgOmmF+RcBqwhrA7GD/sJF
        nasIQYbLgLLGsVslAS/gXSmDIBZF9seLBnfa
X-Google-Smtp-Source: ABdhPJwY4lA7ai7mRRQu7yot5d733zfT0kYY4nza4vMmOs/w3CAbCK5X0OyUwroQMP85tGM+mU161w==
X-Received: by 2002:a05:600c:34d2:b0:397:7209:c1f0 with SMTP id d18-20020a05600c34d200b003977209c1f0mr25106128wmq.132.1654545332224;
        Mon, 06 Jun 2022 12:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b0039c25ee5dbcsm16652103wms.14.2022.06.06.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:31 -0700 (PDT)
Message-Id: <923feef84e4aac03a5d451e4b7759cfa291ac747.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:24 +0000
Subject: [PATCH 5/6] bundle-uri: add support for http(s):// and file://
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

The previous change created the logic for copying a file by name. Now,
first inspect the URI for an HTTP(S) prefix and use git-remote-https as
the way to download the data at that URI. Otherwise, check to see if
file:// is present and modify the prefix accordingly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 65 ++++++++++++++++++++++++++++++++++++-
 t/t5558-fetch-bundle-uri.sh | 37 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 095779352e7..576ced271cb 100644
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

