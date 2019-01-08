Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D601F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAHCsL (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:48:11 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:52305 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfAHCsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:48:10 -0500
Received: by mail-io1-f73.google.com with SMTP id h7so2083399iof.19
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=il3+uivG+vJ9y6BdcZtTQmgkQA325QFRMf7WaVuyBis=;
        b=MQ0Sc6UDgquTWHFFlvwIwuNUdq6wFyQzRm+RKdBoLV6C/X0G18tYJtM51OHX8eRhBh
         2kadcZZo+/Mc5GiEhQOuTubXbyFVWzJ+qfW75pgcscZj/wWZZyMZHnWmSUG/bE4+nF0R
         KDrKwDqOoxekDFDTdawoFVvOjh/t2gyO/n9dghN4dDiQt/aVs3dF6RXziOd3OM5JGhtq
         /FaF/fbv/EE13LpJn/g/HTh+NVbUK5b1eJy67ygparbe4QhHT/TA2vIoUgqZtb3b51PX
         T1ltLHWXnEVlmV0GEBiH/s/QkUTPM2xou/4PmBajjlyYj3qjcXsV1CFPfGYe3LUdO+BT
         XlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=il3+uivG+vJ9y6BdcZtTQmgkQA325QFRMf7WaVuyBis=;
        b=hlk2+UabjFSfBSia1pApGlmM7HMvZ1N3EvikPc+PIqU899MC5Zb0ZwPv69Lf/In6hZ
         d6aHKO8j/AZd4KsLoi4tp7BbrNRRqZ4ejLwcG7wYvwLxBzCgvA6snosHdSlsXuXhWGzc
         Y0SuNutT8IDaWonMKrh7zBNdbQIi2pK/Z3vxGSnVkB9bSTEnJ8sotQGiN9VJvLc9VZy4
         I3rSa5O+UiV2Z26gCzQdB6JrR3es8O4UGRJTRqhW20dzEqgo3XijzLlJrkH9xWR15Obf
         M5y1fZL0qKoWjQEekV9vdEU8q3R/lmDdxeqrFYoRLs/hz/WKlQLfAd4NFaDSr2qkYKUT
         ucOQ==
X-Gm-Message-State: AJcUukc9VVY/gR/N3lSNwkoOgl3MLXUkPgzamkV/l5guHHLzpEh10L1Q
        GzIn5k9Q5HrN9ug2M3T9CSp5vnVzdPRFNFrSaRM=
X-Google-Smtp-Source: ALg8bN5ihh0icCIza9Nt7rD0YkWd/XZKwZvjAx0l/TZK7kCPK3w+ZmwjJ1waOz+CqF54YzyVtZA1Ol79nFmrFShMnPI=
X-Received: by 2002:a24:15:: with SMTP id 21mr213312ita.27.1546915689151; Mon,
 07 Jan 2019 18:48:09 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:41 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-6-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com> <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 5/5] test: test GIT_CURL_VERBOSE=1 shows an error
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tests GIT_CURL_VERBOSE shows an error when an URL returns 500. This
exercises the code in remote_curl.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 t/lib-httpd/apache.conf      |  1 +
 t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 t/t5581-http-curl-verbose.sh

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..cc4b87507e 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -115,6 +115,7 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
new file mode 100755
index 0000000000..cd9283eeec
--- /dev/null
+++ b/t/t5581-http-curl-verbose.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='test GIT_CURL_VERBOSE'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" --bare init &&
+	git config push.default matching &&
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'failure in git-upload-pack is shown' '
+	test_might_fail env GIT_CURL_VERBOSE=1 \
+		git clone "$HTTPD_URL/error_git_upload_pack/smart/repo.git" \
+		2>curl_log &&
+	grep "< HTTP/1.1 500 Intentional Breakage" curl_log
+'
+
+stop_httpd
+
+test_done
-- 
2.20.1.97.g81188d93c3-goog

