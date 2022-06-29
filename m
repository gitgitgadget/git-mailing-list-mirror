Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F08C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiF2Uk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiF2Ukx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A48014027
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n185so10048093wmn.4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=roYviVZ8WQy8VHN136fWD/I4C5Ve+n/NlfvpptSSn5w=;
        b=PBqv6ITjYAZx2feyI4anTnpvzCrHb8qEQf8He9re2E5+GU8ClyGCOUPGRKFNQcQO9x
         mgBRVS6gCNtLKeJfTmJpZOh3o+T+Tgmj7U7GtB6IDeSDB0rY+5arPLoRGmgFdIXTw43v
         f1Z53cINjj9KeQNQ+4FuZjcU3kiQq/Mhykkrt7Gnl5utylBHArdAa9cqRMoPCTRgUHpv
         M2p9ARmmBdgtJC+KjtKPe8CNqEGfyvj2qOB0NvBTWxfKedBRCOp8Psuo0nrAVil4F9CQ
         v9hcGAASs5B8sHqOeJW5njDW+JiM6noaeQhAkhc/KP/qbgQzv4u4w6+enFb+j9kl9yR/
         RVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=roYviVZ8WQy8VHN136fWD/I4C5Ve+n/NlfvpptSSn5w=;
        b=KPPvfw7ZcYcIJ9uyMtQZyC84Zqrtkr+EwGmqZZldtG3BMab5HykOb+8/YmpCwxb3wv
         KO/bAFQOPyBm1yR7R1CfOIVHNg7owc/o1bGaOP9vrVEmrQUQid3roW4BTPdauz0j7vxw
         fkFm3IzGYtKWxkG4q6Tkh8sjT9z7l1ON/DbuTd6N31IDCgVISUHtOf0xFTikwuywdLS6
         50pgMB7F/ehNpKdMU2NIqxCL0NJs4Gw9SOVj8LiwPU8V8SAKjP/BmP0lrdcciUKfKVxl
         K+seD45aTn3PmMpF1isecoyOrvIOS9dq7EXEQtfhcaGAr8jtgSGQ9TxDFaSK+KGpaeEo
         pMDw==
X-Gm-Message-State: AJIora+EF29/kQ1yiFQflBSrkATtsprwi5RaO8blxNJxM5FJ6pauiDOL
        bmBEMeApXIsRi8rc38YZuKr59938Op+78A==
X-Google-Smtp-Source: AGRyM1suLRNWEJi8eefXrwR9AbXmZinQfCvVh0Rm8J6UIPUlvn9v5mjKbljPaIKT4ucGhhxVC+BxnQ==
X-Received: by 2002:a7b:c106:0:b0:3a0:3e42:5751 with SMTP id w6-20020a7bc106000000b003a03e425751mr5877500wmi.9.1656535249533;
        Wed, 29 Jun 2022 13:40:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b0021b8c554196sm18061510wrv.29.2022.06.29.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:48 -0700 (PDT)
Message-Id: <0a2cf60437f781588ae8dd77963901e4e9014959.1656535245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:41 +0000
Subject: [PATCH v2 2/6] remote-curl: add 'get' capability
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

A future change will want a way to download a file over HTTP(S) using
the simplest of download mechanisms. We do not want to assume that the
server on the other side understands anything about the Git protocol but
could be a simple static web server.

Create the new 'get' capability for the remote helpers which advertises
that the 'get' command is avalable. A caller can send a line containing
'get <url> <path>' to download the file at <url> into the file at
<path>.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitremote-helpers.txt |  9 +++++++
 remote-curl.c                       | 33 +++++++++++++++++++++++++
 t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
 transport-helper.c                  |  5 +++-
 4 files changed, 83 insertions(+), 1 deletion(-)
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
index 67f178b1120..f005419f872 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,6 +1276,34 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static void parse_get(struct strbuf *buf)
+{
+	struct http_get_options opts = { 0 };
+	struct strbuf url = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	const char *p, *space;
+
+	if (!skip_prefix(buf->buf, "get ", &p))
+		die(_("http transport does not support %s"), buf->buf);
+
+	space = strchr(p, ' ');
+
+	if (!space)
+		die(_("protocol error: expected '<url> <path>', missing space"));
+
+	strbuf_add(&url, p, space - p);
+	strbuf_addstr(&path, space + 1);
+
+	if (http_get_file(url.buf, path.buf, &opts))
+		die(_("failed to download file at URL '%s'"), url.buf);
+
+	strbuf_release(&url);
+	strbuf_release(&path);
+	printf("\n");
+	fflush(stdout);
+	strbuf_reset(buf);
+}
+
 static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1549,9 +1577,14 @@ int cmd_main(int argc, const char **argv)
 				printf("unsupported\n");
 			fflush(stdout);
 
+		} else if (skip_prefix(buf.buf, "get ", &arg)) {
+			parse_get(&buf);
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
index 00000000000..1fd4ded3eb1
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
+	url="$HTTPD_URL/none.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	get $url file1
+	EOF
+
+	test_must_fail git remote-http $url $url <input 2>err &&
+	test_path_is_missing file1 &&
+	grep "failed to download file at URL" err &&
+	rm file1.temp
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
+	GIT_TRACE2_PERF=1 git remote-http $url $url <input &&
+	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
+'
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index b4dbbabb0c2..dfbeaebe40c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -33,7 +33,8 @@ struct helper_data {
 		check_connectivity : 1,
 		no_disconnect_req : 1,
 		no_private_update : 1,
-		object_format : 1;
+		object_format : 1,
+		get : 1;
 
 	/*
 	 * As an optimization, the transport code may invoke fetch before
@@ -210,6 +211,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->no_private_update = 1;
 		} else if (starts_with(capname, "object-format")) {
 			data->object_format = 1;
+		} else if (!strcmp(capname, "get")) {
+			data->get = 1;
 		} else if (mandatory) {
 			die(_("unknown mandatory capability %s; this remote "
 			      "helper probably needs newer version of Git"),
-- 
gitgitgadget

