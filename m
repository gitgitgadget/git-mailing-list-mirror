Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4878A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfAPT2c (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:28:32 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45085 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbfAPT2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:28:31 -0500
Received: by mail-pl1-f201.google.com with SMTP id h10so4415087plk.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V3vxRzDnCRitF8AAV8x+8Xaxh6NQUSoxEQAcFW2sY/Q=;
        b=D3cSI6mcxWuZrYRK5VS9zArMHGamCiKp6kVYA2XgJbDEnf1bvqU94t2OT1ZVI/qpQ6
         Qe28kgUdLSyciDzZfjnbPRgTmLLlQ7VX/K6HHXFYfWR6u7Uv7ygccJIunHNK50JhMUd8
         VDx8V6XdoueXJU5GUhVo1CKbTGO37KFQPv8HOohkllVGrHbrKv6Fj/yC9fzkStu6dJaU
         P6FVvhtp/OtjfRaNUQhq/q5WRuB9+O+ecsF5ySehFui2LYqXyfhIpHvfO39lm6IyF0BQ
         tS1KpAPzrQR+MwDpxN8MaRYnMqZ26Y5RbriVPFpXBKvZfQE+xZhyL7Cf5C3TyUF4eqQT
         Sxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V3vxRzDnCRitF8AAV8x+8Xaxh6NQUSoxEQAcFW2sY/Q=;
        b=Zoqr2WLAuWsGKnGxef3rMvqqJTkDJ0H7C38rEmfwHJUpu4mC2GtjAt9bljUi10UxEl
         byp/ZqYkdloAYeWLRFSKdakP7GM6kjVf7/I5A1mmLsd+gIz1fbNStLENDvMW+m7dr6DG
         NCf1UA6Li3SC1wt8STFUot9y9a4B8AcN9YSU9xBzKpiqwl5KV+GN2X92ZGf1/VpESkuR
         C3vIO5lXrWjwudeYGxBRNy5CiVfr6MyYCRh0Sr7Np2G7rX/3pZ76BMcHi/DR9i5PS6MR
         74ViFVVOICyCCwOIhUJ5l32Kc2YgSmJAZmLd6CTbp93N03Fa/kcQg0lYyPwLOK8xjxK7
         SoJg==
X-Gm-Message-State: AJcUukeKJRVTqQWc9jk9uykiYFmhMFD8fWFyZlqLlEtV6Hz64NcoYFCA
        SYb+8GcQhK7b54KKxSzGEhetEB3n1KFFP05fWs8g9R+rRgpajc1rfS28cAiORXjqkjhLYi41zSZ
        DwL5Z3Atq0eUJExg3qT5xpx6zp7ncwGDwttKG8GtOCK9fAcyBsmlZNPFZnRBDx6EZm5GedugBkK
        dD
X-Google-Smtp-Source: ALg8bN5t0jIzpGhdGmRgrxSrl2ylSh1I66DjnDVTZYwVqIRu+lMEZbLIqpD32EJ+DmtSiY5Q/4o1CVMAdpqTzytgCOYB
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr3280946plb.67.1547666910430;
 Wed, 16 Jan 2019 11:28:30 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:28:15 -0800
In-Reply-To: <cover.1547666330.git.jonathantanmy@google.com>
Message-Id: <47a98b67113869aa6a887ced52560c8306e55bc0.1547666330.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547666330.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v3 4/4] tests: define GIT_TEST_SIDEBAND_ALL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        szeder.dev@gmail.com
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 86e9e18901..e98294d918 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1327,7 +1327,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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

