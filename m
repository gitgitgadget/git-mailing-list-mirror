Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BBBC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiHBM3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiHBM3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03155073D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so6888702wmj.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=acdCRj0MaKKG5SLy1KyeFYDmc9lgpHivA8g86H8W2Bc=;
        b=bv3Nvf+lxgHkJbMS9bG+m7PMHAQ9GT8iFTGBtSpqDVcolwEpQl23pcuvWMnxgu0NJF
         uMBTOS0YbHOq4cMBF9SNYZapSIPIdss4oFz4r6yDIgSH9+TBx65W/0iLIYrb9Qtrzk2S
         Z03nTJEzY6JCx/YiYNBBc8GDxKydaWkKiI0zIFILmxHelMpFg9fpU13GqocnTEiDRJFf
         +SKJZG87xkEuesDHJqenoNDI7xGF30yShxRf+m2UqDWS3j3B/B1hIvvQ/jhTiQf1+ZwF
         S3sTBHYBYu1ePu2tIAUstgsbJcN538hRjT1BnGwL1Jk6w9GTcD6pYImXbXnU9Qssg5jZ
         7WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=acdCRj0MaKKG5SLy1KyeFYDmc9lgpHivA8g86H8W2Bc=;
        b=QMEGLNteioLfHa79wtxwYP90wgr1UViGMbGrLBeC91CeE33GkyQE96NqMp7o6E/5er
         4T8eIEPRy/JdHwzirtNHy+nGF/hewWezALh4EO168BujH9xaeUtz3YGdkTgtMAdBxtBu
         84dJbWyVcShv75kN9sgElT0vQ66tgjASe2f/kMu3k8Xe1T0gmGCWr/pDOhUKdkH+T+BR
         Ds566FavvHGBhUJQzdplVk3EQfNXkgX7SR5FZ31oF5d2cD+JU6U75Zc5K54Sikw7lb3l
         /hNSxHIBdv+G+WUwGrafnKTAeTBPOjBc9SmEx3L4A+zHiRzSFl+OXZTk3XqNsqNBA2ht
         gLhA==
X-Gm-Message-State: AJIora9wB8fGPZIwOggobsr3gX53XjE9uz9ohDxYV+Trapp6M0RL862Y
        cXUb4Eb9v9EzYw8aAtfTgK/EuuhMi/s=
X-Google-Smtp-Source: AGRyM1sO8jXAq2v8C1eHafUzQCgCcKtdrvguiBfOBw/v21GZCmocdO8rp3J99LSoiXmtn9TO60hqDA==
X-Received: by 2002:a05:600c:501e:b0:3a3:4a04:fdb5 with SMTP id n30-20020a05600c501e00b003a34a04fdb5mr14601863wmr.168.1659443387135;
        Tue, 02 Aug 2022 05:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003a2f96935c0sm27351614wmi.9.2022.08.02.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:45 -0700 (PDT)
Message-Id: <4df4a1d679a1003ccd3a4dd049bc05141831970c.1659443384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:40 +0000
Subject: [PATCH v2 1/5] remote-curl: add 'get' capability
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

A future change will want a way to download a file over HTTP(S) using
the simplest of download mechanisms. We do not want to assume that the
server on the other side understands anything about the Git protocol but
could be a simple static web server.

Create the new 'get' capability for the remote helpers which advertises
that the 'get' command is avalable. A caller can send a line containing
'get <url> <path>' to download the file at <url> into the file at
<path>.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitremote-helpers.txt |  9 +++++++
 remote-curl.c                       | 28 ++++++++++++++++++++++
 t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100755 t/t5557-http-get.sh

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6f1e269ae43..ed8da428c98 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -168,6 +168,9 @@ Supported commands: 'list', 'import'.
 	Can guarantee that when a clone is requested, the received
 	pack is self contained and is connected.
 
+'get'::
+	Can use the 'get' command to download a file from a given URI.
+
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
@@ -418,6 +421,12 @@ Supported if the helper has the "connect" capability.
 +
 Supported if the helper has the "stateless-connect" capability.
 
+'get' <uri> <path>::
+	Downloads the file from the given `<uri>` to the given `<path>`. If
+	`<path>.temp` exists, then Git assumes that the `.temp` file is a
+	partial download from a previous attempt and will resume the
+	download from that position.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
diff --git a/remote-curl.c b/remote-curl.c
index b8758757ece..72dfb8fb86a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1286,6 +1286,29 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static void parse_get(const char *arg)
+{
+	struct strbuf url = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	const char *space;
+
+	space = strchr(arg, ' ');
+
+	if (!space)
+		die(_("protocol error: expected '<url> <path>', missing space"));
+
+	strbuf_add(&url, arg, space - arg);
+	strbuf_addstr(&path, space + 1);
+
+	if (http_get_file(url.buf, path.buf, NULL))
+		die(_("failed to download file at URL '%s'"), url.buf);
+
+	strbuf_release(&url);
+	strbuf_release(&path);
+	printf("\n");
+	fflush(stdout);
+}
+
 static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1564,9 +1587,14 @@ int cmd_main(int argc, const char **argv)
 				printf("unsupported\n");
 			fflush(stdout);
 
+		} else if (skip_prefix(buf.buf, "get ", &arg)) {
+			parse_get(arg);
+			fflush(stdout);
+
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("stateless-connect\n");
 			printf("fetch\n");
+			printf("get\n");
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
new file mode 100755
index 00000000000..09fb0bd9a8a
--- /dev/null
+++ b/t/t5557-http-get.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test downloading a file by URL'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'get by URL: 404' '
+	test_when_finished "rm -f file.temp" &&
+	url="$HTTPD_URL/none.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	get $url file1
+	EOF
+
+	test_must_fail git remote-http $url <input 2>err &&
+	test_path_is_missing file1 &&
+	grep "failed to download file at URL" err
+'
+
+test_expect_success 'get by URL: 200' '
+	echo data >"$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" &&
+
+	url="$HTTPD_URL/exists.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	get $url file2
+
+	EOF
+
+	git remote-http $url <input &&
+	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
+'
+
+test_done
-- 
gitgitgadget

