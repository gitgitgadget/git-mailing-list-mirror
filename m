Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC24C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353022AbiETSmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353019AbiETSlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929833EA7
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u27so11807740wru.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WD+ZuMC5e0h+ITqwsZQZuyHZ7Z+8n4b882PrVYoujLE=;
        b=A/lrYYao8BN+dRfRDKqyHaRETLFSnFKt4Wx5Fm21w+1X84i8+4QgNFiJSUR56MkCs9
         DgJP9glZ43a82BncCsrN2ecZ/juWce+aWDEFNoi3YOUHuwz9P9ExPW5lPUq4JE446t0p
         +Glcou5ULgfn20efDx0A8dHEzZVWoepluLxITkgV5PdTbLeX6JHDYW2bZtp1RP/Epbny
         WpTB/VkTS/V1i4SZqv44vYvrcKAC4SfPU1BU4KIlTbMJpWVFcF23fRV/NWx7Jn3DfpLt
         19d70jDBFZGKfxl3oGlfGUAXhbvcZDggRdriyF9JCCkwdp57jT+kXGVJlsbm/nZmbrt5
         pUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WD+ZuMC5e0h+ITqwsZQZuyHZ7Z+8n4b882PrVYoujLE=;
        b=ewqpdcoVEBHpyYgoZjGIoY4HmEYr0U+uWcLRJT62YNPi+ddEZtUbA760E+7qRve+DM
         oyXSPq6axT5/jG/CzJqSJD8fhlnc51VxiHTyVXU2JFuCb0Kd/X3BXqsyoYMRjPk0KYpz
         SbL81gYxoavVarf4H442zrx0CBYiytsBIpjv8EsV3FI5DpjDOFwl19SUx+ZY+A0eQSAB
         vHz8wtnh+firMlQ4PqN8ipHxMyhkVVaQRUAifeV64Ml3AgLUo0PvPyRpXvGywTp5YaYX
         m/FjbcEG5isdgXvkhJyZiWvdLaFe62smD/bJNexpNw3nLNJ/8mKwM37E+gX3npcz6EQ3
         rwJg==
X-Gm-Message-State: AOAM532cuRpSVPCUYSWs1Ui8urCVABNCWSoH9K+F2zdxmC2/nDri1lJS
        A3k7/FdFblCVUhCGbTxFawYx0DuBoFI=
X-Google-Smtp-Source: ABdhPJweyRUFn7cft7S5/OHK3DpkfMrWgxVq6j0SvU2+OX0gTYBaYx8yYlXO7bUZ7gTcPrYSiWrwKw==
X-Received: by 2002:a05:6000:1869:b0:20f:c1a4:111 with SMTP id d9-20020a056000186900b0020fc1a40111mr2282213wri.261.1653072063522;
        Fri, 20 May 2022 11:41:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020adfbb04000000b0020fbf62db96sm2405147wrg.36.2022.05.20.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:03 -0700 (PDT)
Message-Id: <1830d193b116b00dd1b484852385062ac92a451c.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:35 +0000
Subject: [PATCH 17/24] bundle-uri client: add minimal NOOP client
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Set up all the needed client parts of the "bundle-uri" protocol
extension, without actually doing anything with the bundle URIs.

I.e. if the server says it supports "bundle-uri" we'll issue a
command=bundle-uri after command=ls-refs when we're cloning. We'll
parse the returned output using the code already tested for in
t5750-bundle-uri-parse.sh.

What we aren't doing is actually acting on that data, i.e. downloading
the bundle(s) before we get to doing the command=fetch, and adjusting
our negotiation dialog appropriately. I'll do that in subsequent
commits.

There's a question of what level of encapsulation we should use here,
I've opted to use connect.h in clone.c, but we could also e.g. make
transport_get_remote_refs() invoke this, i.e. make it implicitly get
the bundle-uri list for later steps.

This approach means that we don't "support" this in "git fetch" for
now. I'm starting with the case of initial clones, although as noted
in preceding commits to the protocol documentation nothing about this
approach precludes getting bundles on incremental fetches.

For the t5732-protocol-v2-bundle-uri-http.sh it's not easy to set
environment variables for git-upload-pack (it's started by Apache), so
let's skip the test under T5730_HTTP, and add unused T5730_{FILE,GIT}
prerequisites for consistency and future use.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c                        |   7 ++
 bundle-uri.c                           |   4 +
 connect.c                              |  47 ++++++++
 remote.h                               |   5 +
 t/lib-t5730-protocol-v2-bundle-uri.sh  | 148 +++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh |  36 ++++++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 +++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 +++
 transport-helper.c                     |  13 +++
 transport-internal.h                   |   7 ++
 transport.c                            |  55 +++++++++
 transport.h                            |  19 ++++
 12 files changed, 375 insertions(+)
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index a9caa5dfed6..7bedd9eb29e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -27,6 +27,7 @@
 #include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
+#include "connect.h"
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
@@ -1262,6 +1263,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
+	/*
+	 * Populate transport->got_remote_bundle_uri and
+	 * transport->bundle_uri. We might get nothing.
+	 */
+	transport_get_remote_bundle_uri(transport);
+
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 79a6b7ed8b8..fed508cd51a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -565,6 +565,10 @@ static int advertise_bundle_uri = -1;
 
 int bundle_uri_advertise(struct repository *r, struct strbuf *value)
 {
+	if (value &&
+	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
+		strbuf_addstr(value, "test-unknown-capability-value");
+
 	if (advertise_bundle_uri != -1)
 		goto cached;
 
diff --git a/connect.c b/connect.c
index e6d0b1d34bd..00dd00cfa44 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "protocol.h"
 #include "alias.h"
+#include "bundle-uri.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
@@ -491,6 +492,52 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	}
 }
 
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct bundle_list *bundles, int stateless_rpc)
+{
+	int line_nr = 1;
+
+	/* Assert bundle-uri support */
+	server_supports_v2("bundle-uri", 1);
+
+	/* (Re-)send capabilities */
+	send_capabilities(fd_out, reader);
+
+	/* Send command */
+	packet_write_fmt(fd_out, "command=bundle-uri\n");
+	packet_delim(fd_out);
+
+	/* Send options */
+	if (git_env_bool("GIT_TEST_PROTOCOL_BAD_BUNDLE_URI", 0))
+		packet_write_fmt(fd_out, "test-bad-client\n");
+	packet_flush(fd_out);
+
+	/* Process response from server */
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *line = reader->line;
+		line_nr++;
+
+		if (!bundle_uri_parse_line(bundles, line))
+			continue;
+
+		return error(_("error on bundle-uri response line %d: %s"),
+			     line_nr, line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		return error(_("expected flush after bundle-uri listing"));
+
+	/*
+	 * Might die(), but obscure enough that that's OK, e.g. in
+	 * serve.c we'll call BUG() on its equivalent (the
+	 * PACKET_READ_RESPONSE_END check).
+	 */
+	check_stateless_delimiter(stateless_rpc, reader,
+				  _("expected response end packet after ref listing"));
+
+	return 0;
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
diff --git a/remote.h b/remote.h
index dd4402436f1..5f743438cd4 100644
--- a/remote.h
+++ b/remote.h
@@ -236,6 +236,11 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
+/* Used for protocol v2 in order to retrieve refs from a remote */
+struct bundle_list;
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct bundle_list *bundles, int stateless_rpc);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
 /*
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
new file mode 100644
index 00000000000..27294e9c976
--- /dev/null
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -0,0 +1,148 @@
+# Included from t573*-protocol-v2-bundle-uri-*.sh
+
+T5730_PARENT=
+T5730_URI=
+T5730_BUNDLE_URI=
+case "$T5730_PROTOCOL" in
+file)
+	T5730_PARENT=file_parent
+	T5730_URI="file://$PWD/file_parent"
+	T5730_BUNDLE_URI="$T5730_URI/fake.bdl"
+	test_set_prereq T5730_FILE
+	;;
+git)
+	. "$TEST_DIRECTORY"/lib-git-daemon.sh
+	start_git_daemon --export-all --enable=receive-pack
+	T5730_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
+	T5730_URI="$GIT_DAEMON_URL/parent"
+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq T5730_GIT
+	;;
+http)
+	. "$TEST_DIRECTORY"/lib-httpd.sh
+	start_httpd
+	T5730_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
+	T5730_URI="$HTTPD_URL/smart/http_parent"
+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq T5730_HTTP
+	;;
+*)
+	BUG "Need to pass valid T5730_PROTOCOL (was $T5730_PROTOCOL)"
+	;;
+esac
+
+test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
+	git init "$T5730_PARENT" &&
+	test_commit -C "$T5730_PARENT" one &&
+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
+'
+
+# Poor man's URI escaping. Good enough for the test suite whose trash
+# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
+# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
+test_uri_escape() {
+	sed 's/ /%20/g'
+}
+
+case "$T5730_PROTOCOL" in
+http)
+	test_expect_success "setup config for $T5730_PROTOCOL:// tests" '
+		git -C "$T5730_PARENT" config http.receivepack true
+	'
+	;;
+*)
+	;;
+esac
+T5730_BUNDLE_URI_ESCAPED=$(echo "$T5730_BUNDLE_URI" | test_uri_escape)
+
+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: no bundle-uri" '
+	test_when_finished "rm -f log" &&
+	test_when_finished "git -C \"$T5730_PARENT\" config uploadpack.advertiseBundleURIs true" &&
+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs false &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	! grep bundle-uri log
+'
+
+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bundle-uri" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep bundle-uri log
+'
+
+test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	cat >err.expect <<-\EOF &&
+	Cloning into '"'"'child'"'"'...
+	EOF
+	case "$T5730_PROTOCOL" in
+	file)
+		cat >fatal-bundle-uri.expect <<-\EOF
+		fatal: bundle-uri: unexpected argument: '"'"'test-bad-client'"'"'
+		EOF
+		;;
+	*)
+		cat >fatal.expect <<-\EOF
+		fatal: read error: Connection reset by peer
+		EOF
+		;;
+	esac &&
+
+	test_when_finished "rm -rf child" &&
+	test_must_fail ok=sigpipe env \
+		GIT_TRACE_PACKET="$PWD/log" \
+		GIT_TEST_PROTOCOL_BAD_BUNDLE_URI=true \
+		git -c protocol.version=2 \
+		clone "$T5730_URI" child \
+		>out 2>err &&
+	test_must_be_empty out &&
+
+	grep -v -e ^fatal: -e ^error: err >err.actual &&
+	test_cmp err.expect err.actual &&
+
+	case "$T5730_PROTOCOL" in
+	file)
+		# Due to general race conditions with client/server replies we
+		# may or may not get "fatal: the remote end hung up
+		# expectedly" here
+		grep "^fatal: bundle-uri:" err >fatal-bundle-uri.actual &&
+		test_cmp fatal-bundle-uri.expect fatal-bundle-uri.actual
+		;;
+	*)
+		grep "^fatal:" err >fatal.actual &&
+		# Due to the same race conditions this might be
+		# "fatal: read error: Connection reset by peer", "fatal: the remote end
+		# hung up unexpectedly" etc.
+		cat fatal.actual &&
+		test_file_not_empty fatal.actual
+		;;
+	esac &&
+
+	grep "clone> test-bad-client$" log >sent-bad-request &&
+	test_file_not_empty sent-bad-request
+'
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
new file mode 100755
index 00000000000..89203d3a23c
--- /dev/null
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'file://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'file://' transport
+#
+T5730_PROTOCOL=file
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_expect_success "unknown capability value with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE=true \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	grep "> bundle-uri=test-unknown-capability-value" log
+'
+
+test_done
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
new file mode 100755
index 00000000000..282847b311f
--- /dev/null
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+T5730_PROTOCOL=git
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_done
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
new file mode 100755
index 00000000000..fcc1cf3faef
--- /dev/null
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+T5730_PROTOCOL=http
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index dfbeaebe40c..ee7d0b09a24 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1270,9 +1270,22 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	return ret;
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->get_bundle_uri(transport);
+	}
+
+	return -1;
+}
+
 static struct transport_vtable vtable = {
 	.set_option	= set_helper_option,
 	.get_refs_list	= get_refs_list,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
 	.push_refs	= push_refs,
 	.connect	= connect_helper,
diff --git a/transport-internal.h b/transport-internal.h
index c4ca0b733ac..90ea749e5cf 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -26,6 +26,13 @@ struct transport_vtable {
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
 				     struct transport_ls_refs_options *transport_options);
 
+	/**
+	 * Populates the remote side's bundle-uri under protocol v2,
+	 * if the "bundle-uri" capability was advertised. Returns 0 if
+	 * OK, negative values on error.
+	 */
+	int (*get_bundle_uri)(struct transport *transport);
+
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
diff --git a/transport.c b/transport.c
index 3d64a43ab39..106bb8c5577 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "bundle-uri.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -359,6 +360,25 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	return handshake(transport, for_push, options, 1);
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	int stateless_rpc = transport->stateless_rpc;
+
+	if (!transport->bundles) {
+		CALLOC_ARRAY(transport->bundles, 1);
+		init_bundle_list(transport->bundles);
+	}
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	return get_remote_bundle_uri(data->fd[1], &reader,
+				     transport->bundles, stateless_rpc);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -899,6 +919,7 @@ static int disconnect_git(struct transport *transport)
 
 static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
@@ -1052,6 +1073,7 @@ static struct transport_vtable bundle_vtable = {
 
 static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
@@ -1066,6 +1088,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->progress = isatty(2);
 	string_list_init_dup(&ret->pack_lockfiles);
 
+	CALLOC_ARRAY(ret->bundles, 1);
+	init_bundle_list(ret->bundles);
+
 	if (!remote)
 		BUG("No remote provided to transport_get()");
 
@@ -1473,6 +1498,34 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+int transport_get_remote_bundle_uri(struct transport *transport)
+{
+	const struct transport_vtable *vtable = transport->vtable;
+
+	/* Check config only once. */
+	if (transport->got_remote_bundle_uri++)
+		return 0;
+
+	/*
+	 * "Support" protocol v0 and v2 without bundle-uri support by
+	 * silently degrading to a NOOP.
+	 */
+	if (!server_supports_v2("bundle-uri", 0))
+		return 0;
+
+	/*
+	 * This is intentionally below the transport.injectBundleURI,
+	 * we want to be able to inject into protocol v0, or into the
+	 * dialog of a server who doesn't support this.
+	 */
+	if (!vtable->get_bundle_uri)
+		return error(_("bundle-uri operation not supported by protocol"));
+
+	if (vtable->get_bundle_uri(transport) < 0)
+		return error(_("could not retrieve server-advertised bundle-uri list"));
+	return 0;
+}
+
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
@@ -1503,6 +1556,8 @@ int transport_disconnect(struct transport *transport)
 		ret = transport->vtable->disconnect(transport);
 	if (transport->got_remote_refs)
 		free_refs((void *)transport->remote_refs);
+	clear_bundle_list(transport->bundles);
+	free(transport->bundles);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index 12bc08fc339..015375e083d 100644
--- a/transport.h
+++ b/transport.h
@@ -62,6 +62,7 @@ enum transport_family {
 	TRANSPORT_FAMILY_IPV6
 };
 
+struct bundle_list;
 struct transport {
 	const struct transport_vtable *vtable;
 
@@ -76,6 +77,18 @@ struct transport {
 	 */
 	unsigned got_remote_refs : 1;
 
+	/**
+	 * Indicates whether we already called get_bundle_uri_list(); set by
+	 * transport.c::transport_get_remote_bundle_uri().
+	 */
+	unsigned got_remote_bundle_uri : 1;
+
+	/*
+	 * The results of "command=bundle-uri", if both sides support
+	 * the "bundle-uri" capability.
+	 */
+	struct bundle_list *bundles;
+
 	/*
 	 * Transports that call take-over destroys the data specific to
 	 * the transport type while doing so, and cannot be reused.
@@ -280,6 +293,12 @@ void transport_ls_refs_options_release(struct transport_ls_refs_options *opts);
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    struct transport_ls_refs_options *transport_options);
 
+/**
+ * Retrieve bundle URI(s) from a remote. Populates "struct
+ * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ */
+int transport_get_remote_bundle_uri(struct transport *transport);
+
 /*
  * Fetch the hash algorithm used by a remote.
  *
-- 
gitgitgadget

