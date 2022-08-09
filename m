Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59785C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiHINLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiHINLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:11:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCF108D
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:11:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so14297190wrr.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=acdCRj0MaKKG5SLy1KyeFYDmc9lgpHivA8g86H8W2Bc=;
        b=Sr3JYEznMy++BMZBfPvy/XWHnKujuyAH1tAvwfKYcsf92L+fVLzlKv4b1iYgo3VkwY
         vcacSRPX88B+aQ+Y3fCTgaS5igaaxcpPi3KQX/imtVW3Vi5tZXblHAeV/KujJ3a6yGQB
         jEUrCs0EmgSH2qBlO73kA8dFdB35kSEG2wZmPdzyaCJH5Jx5+f1l7rrPQmU+IihTC0fa
         KkglUfMk1yWqWtI98FgYRhq/wsIfAg+mCy2gWaf49nw9My95AZ4k10mwYJEUeNLA93+G
         5tdE/5RlVd8Tl3b4NgyYrzYxgTX6ZpW46rEpK93qz4HeJRVdO+Fyj7mamj9zHgf/Tz02
         v1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=acdCRj0MaKKG5SLy1KyeFYDmc9lgpHivA8g86H8W2Bc=;
        b=y3RBuEnBjQ2IKt+pu538PPGIknJPDDugf+GEMP1/SiVgLl5OJF1ZuDCaxdyBICRr/4
         Fy1agQDkKnoIeh5lQTsn7EI5f1VqbvrOgzl9WqG4tDYaCXoUCgL3GV6S7/E1VBsQq76W
         aCWyaLjvFYEIafD5oSSZ64VA7tMUSJfIyOiiZ9oH5SLuCXcr47TaVkuqNvy/nL54cLnu
         QCWSpCpKE+dMxargfVjM3n5ZhJId5yZu8joOsueZiqeueerZSDZA6RTAFF/0H57O/Tlg
         72rsJ2FoYRYHRl2rqMI5rr7BWJrLRZY0GGwuTtesANTS70ZwfIDM3KN2q/zx6yZcy3ob
         R8yw==
X-Gm-Message-State: ACgBeo2xV8gTk985WoFsuTUADXfHW+CygXPJHDdyPl9eqGm9LUWYgAK/
        6gF3WCbrOQ/CAuewI0KGkn3RoYmrrBs=
X-Google-Smtp-Source: AA6agR6KPjXwljAP1OVGNHxVIBy5d2Odeeec7g3Qx9MWpr7J+TThvgdW0ztbc18dJw3apzsbrY68Ig==
X-Received: by 2002:adf:dd88:0:b0:21e:f3c1:eea with SMTP id x8-20020adfdd88000000b0021ef3c10eeamr14000727wrl.23.1660050708034;
        Tue, 09 Aug 2022 06:11:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b002205b786ab3sm13610587wrt.14.2022.08.09.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:11:47 -0700 (PDT)
Message-Id: <4df4a1d679a1003ccd3a4dd049bc05141831970c.1660050703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:11:39 +0000
Subject: [PATCH v3 1/5] remote-curl: add 'get' capability
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

