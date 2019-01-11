Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FC4211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfAKWSr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:47 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53257 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:46 -0500
Received: by mail-pl1-f201.google.com with SMTP id ay11so9077864plb.20
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fQrZtSR2ysfXRBWArswhh+utOdeCl3lzeOx/B9vvsCk=;
        b=UWQYoRZ3IA0YzuosgCdYv37CpNl8Up3Pl8sgTaXrOrVkNtTXF8hM8sD4geik1qgHJH
         4Nh9xMsHOXGVuoxbCpTxnKQrKLm9DlpRp6Rs0iEhSNl03QhiFeJRvymy8AS+54brsQnF
         ngtBO8OMvd87cqWLkmRfn0IIwwfsroz+6GHtGLSOWoA29kvNY7sMpGg0XKbWxyQEWCtC
         gJKUpgQSoYuWfaJz7c9coGTrYFeHAnr7VByBiZgdItxBhamLf0A4kSdOO1mZNWFGpGUA
         Q67RvdNkZzBoKEy2Sl/wmZ4eSVBPoZDlS7ccS2NTCKXxgNaoSdG8q8NMJAN2129Lt/OL
         Pr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fQrZtSR2ysfXRBWArswhh+utOdeCl3lzeOx/B9vvsCk=;
        b=abwUr2FUsA4UdbyU+qJO7Kd1k7/QH8RE0Pg1ZjhmDdWH6YxtzpTL4bT/1JsK2AnzmB
         kB/HviMKx85/D8SZTV9LMVuqYW0Hj3VkDQZuxIK9RUvJGLDgFTBuuXd9xuFtU+iO2RjV
         MdFOhh/5bLjyHJOAAJOhT0Bf/nqk1GYupn5BspCofBW+nOgSVc2dx7RBNlZvKzmuUT3H
         7SdzXGKuAQcKVVkHHKIGzqjogdDq7TgpOzQ/0Sj4DFDiIZBA7UR/tCBm/d8lFMq+b85R
         JUQA1PkzqJ9jAAIiS4yGqLDeGzs9unc7iriPUhBKe3dJPO6wue/f1TsCVhAwIuxmzAck
         y+OA==
X-Gm-Message-State: AJcUukfvQBn/SXgkB14iDyNcyxkb1RazHW4CfdNKyr8KeAyYULs6/+Io
        wgBqa0frkmBVpJU9CKVNN9bJswQ+w951EO1WOMhhkgqrn4MMpgUpjJ9JzOVhT6Wzk/tQf616tiW
        6COL5SPGnbM42xEcX3DOKJwbEHKEY/7iGgFRcFx0dQB/kJrXOO+EvMkDGpmH/aveJzN9D0JhgYF
        v6
X-Google-Smtp-Source: ALg8bN4XHS55iypf9aqiSPGqAedzrkkVLIIPaWl6wP+rSWVfM9rLkA7gacTMNGF6MO2Ave2Jn9JM3kAno+b7NYEC8Dx+
X-Received: by 2002:a17:902:8e88:: with SMTP id bg8mr843896plb.110.1547245125643;
 Fri, 11 Jan 2019 14:18:45 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:17 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <e91db1276b5e838faa7060ba9f3fe23acbb5e3a7.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 4/4] tests: define GIT_TEST_SIDEBAND_ALL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a GIT_TEST_SIDEBAND_ALL environment variable meant to be used
from tests. When set to true, this overrides uploadpack.allowsidebandall
to true, allowing the entire test suite to be run as if this
configuration is in place for all repositories.

As of this patch, all tests pass whether GIT_TEST_SIDEBAND_ALL is unset
or set to 1.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             |  3 ++-
 t/README                 |  5 +++++
 t/lib-httpd/apache.conf  |  1 +
 t/t5537-fetch-shallow.sh |  3 ++-
 t/t5701-git-serve.sh     |  2 +-
 t/t5702-protocol-v2.sh   |  4 ++--
 upload-pack.c            | 13 ++++++++-----
 7 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b89199891d..4618568fee 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1362,7 +1362,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
-	if (server_supports_feature("fetch", "sideband-all", 0)) {
+	if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 1) &&
+	    server_supports_feature("fetch", "sideband-all", 0)) {
 		reader.use_sideband = 1;
 		reader.me = "fetch-pack";
 	}
diff --git a/t/README b/t/README
index 28711cc508..b275c883b8 100644
--- a/t/README
+++ b/t/README
@@ -358,6 +358,11 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
+'uploadpack.allowSidebandAll' setting to true, and when false, forces
+fetch-pack to not request sideband-all (even if the server advertises
+sideband-all).
+
 Naming Tests
 ------------
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..9a6d368247 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -78,6 +78,7 @@ PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
+PassEnv GIT_TEST_SIDEBAND_ALL
 
 SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6faf17e17a..6caf628efa 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -243,7 +243,8 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
-	test_must_fail git -C client fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
+	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
+		fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
 		master:a_branch &&
 
 	# Ensure that the one-time-sed script was used.
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ae79c6bbc0..fe45bf828d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -14,7 +14,7 @@ test_expect_success 'test capability advertisement' '
 	0000
 	EOF
 
-	git serve --advertise-capabilities >out &&
+	GIT_TEST_SIDEBAND_ALL=0 git serve --advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..b491c62e3e 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -583,8 +583,8 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
 		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
-	grep "fetch< acknowledgments" log &&
-	! grep "fetch< ready" log &&
+	grep "fetch< .*acknowledgments" log &&
+	! grep "fetch< .*ready" log &&
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
diff --git a/upload-pack.c b/upload-pack.c
index 765b7695d2..0c1feccaab 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1288,7 +1288,9 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (allow_sideband_all && !strcmp(arg, "sideband-all")) {
+		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
+		     allow_sideband_all) &&
+		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
 		}
@@ -1521,10 +1523,11 @@ int upload_pack_advertise(struct repository *r,
 		    allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
 
-		if (!repo_config_get_bool(the_repository,
-					 "uploadpack.allowsidebandall",
-					 &allow_sideband_all_value) &&
-		    allow_sideband_all_value)
+		if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
+		    (!repo_config_get_bool(the_repository,
+					   "uploadpack.allowsidebandall",
+					   &allow_sideband_all_value) &&
+		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
 	}
 
-- 
2.19.0.271.gfe8321ec05.dirty

