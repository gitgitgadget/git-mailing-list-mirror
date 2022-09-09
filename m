Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A66ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIIPHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiIIPGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA7139AC1
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so3215658wri.13
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=lcOSRYa78Rrx4p3Uz2exv6+8IceCq5u0zo3bx6EaMI8=;
        b=lht4Xs86BJe1EBxeYpkrDby7lFA8L55vZ5tiEQOgJPmF5b/qDu+Xb5DM7phO/r50k+
         U04wekDsvtuB55bwSz0B7kmGyoO3KCrDsfAeQf43DUiBRH4lFIrB6w+2ImqAAoA4oakq
         vhS8gqpSIuR8S0q0wcQOGvTQZvzqUTCzb6gcOMWZXMH2r7aftlNWKBqxAhoqLpAIq7Se
         i7LJhmEtvRI6+RUA34afneIWn+MFeE2azDA9GmoWyy0jOzZiObfVyzSU870IH91syVi1
         2FJWutz0Sy73AcBZ4N7AmEnpw8s+pMWxDCUf6YKJRhsnZb6VfQBhTPvcQ99pG+ro2/nZ
         Jxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lcOSRYa78Rrx4p3Uz2exv6+8IceCq5u0zo3bx6EaMI8=;
        b=RFB1TqkwejuTev8Y0XbUGyA9Un27uMPUFxUZ7CuN9bZ5HX89eXIlsyaIaz6kSrOupQ
         +asxyfV3uI0kfs4ghX3Q0fiDosxkDkK5g8v9061HGSVI9z7Okl5HC5oy5943g8t8mTGk
         v89XxJOBZkTqbI93ETmjsp8q9tCH+FYALtkdoOVSKnQX8/zMTDLAXjgOnrxwxtcJNtAb
         S6fg+1DF3OAqNR/nGv849hqwe8pxHO0M3UcTPNaenmQopGTbd/kc8pA0hgsqzup7zOD8
         UgraQfMIGam3MEQq5mQebVE6rEV67j5S5OO6i7TModipgLUk8exrWxtMk6WLLk8Mymcg
         hkIg==
X-Gm-Message-State: ACgBeo3tslWqkxpiQNFCDhIuktNqHS/xPTkGbnsJuj5tb4fgNEtitlVr
        ebKsfrfnhniUgt4eY9iLQli0b3rYdQA=
X-Google-Smtp-Source: AA6agR5I3DyXvRbjuqGxiQxyrafnlVsnm5LD8YS4BdYJyKZh8OlXG5W83B7FcMTY+komJSpJC8ZCvg==
X-Received: by 2002:a5d:6050:0:b0:228:6128:b0fb with SMTP id j16-20020a5d6050000000b002286128b0fbmr7926027wrt.424.1662735992291;
        Fri, 09 Sep 2022 08:06:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13-20020adfe3cd000000b00228655a5c8fsm695861wrm.28.2022.09.09.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:31 -0700 (PDT)
Message-Id: <fb135cb3bd3d4d21964c230036183f9c4dab93df.1662735985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:24 +0000
Subject: [PATCH v5 4/5] test: add test cases for hide-refs hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Add test cases for the new 'hide-refs' hook which is used to
filter the references during reference discovery phase.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Makefile                                      |   1 +
 t/helper/test-hide-refs.c                     | 107 +++++++++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 112 ++++++++++++++++++
 t/t1419/abnormal-hide-refs-hook.sh            |  82 +++++++++++++
 t/t1419/common-functions.sh                   |  74 ++++++++++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  45 +++++++
 ...st-0002-upload-pack-with-hide-refs-hook.sh |  47 ++++++++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  42 +++++++
 10 files changed, 512 insertions(+)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh

diff --git a/Makefile b/Makefile
index 924b864ae83..c6793681b41 100644
--- a/Makefile
+++ b/Makefile
@@ -794,6 +794,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_BUILTINS_OBJS += test-hide-refs.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
diff --git a/t/helper/test-hide-refs.c b/t/helper/test-hide-refs.c
new file mode 100644
index 00000000000..751fc6213f3
--- /dev/null
+++ b/t/helper/test-hide-refs.c
@@ -0,0 +1,107 @@
+#include "cache.h"
+#include "hash.h"
+#include "config.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+#include "test-tool.h"
+
+static const char *hide_refs_usage[] = {
+	"test-tool hide-refs [<options>...]",
+	NULL
+};
+
+static int die_before_read_ref;
+static int die_after_proc_ref;
+static int version = 1;
+static int hash_size = GIT_SHA1_HEXSZ;
+static struct string_list hidelist = STRING_LIST_INIT_NODUP;
+
+static void hide_refs_verison(struct packet_reader *reader) {
+	int server_version = 0;
+
+	for (;;) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+			server_version = atoi(reader->line+8);
+			if (server_version != 1)
+				die("bad protocol version: %d", server_version);
+		}
+	}
+
+	packet_write_fmt(1, "version=%d\n", version);
+	packet_flush(1);
+}
+
+static void hide_refs_proc(struct packet_reader *reader)
+{
+	const char *p;
+	struct strbuf buf = STRBUF_INIT;
+	enum packet_read_status status;
+
+	if (die_before_read_ref)
+		die("die with the --die-before-read-ref option");
+
+	for (;;) {
+		status = packet_reader_read(reader);
+		if (status == PACKET_READ_EOF)
+			exit(0);
+
+		if (status != PACKET_READ_NORMAL)
+			break;
+
+		p = reader->line;
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, reader->line);
+	}
+
+	p = strchr(buf.buf, ':');
+	if (unsorted_string_list_has_string(&hidelist, p + 1)) {
+		packet_write_fmt(1, "hide");
+	}
+
+	if (die_after_proc_ref)
+		die("die with the --die-after-proc-refs option");
+
+	packet_flush(1);
+}
+
+int cmd__hide_refs(int argc, const char **argv) {
+	int nongit_ok = 0;
+	struct packet_reader reader;
+	const char *value = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "die-before-read-ref", &die_before_read_ref,
+			 "die when reading first reference"),
+		OPT_BOOL(0, "die-after-proc-refs", &die_after_proc_ref,
+			 "die after proc ref"),
+		OPT_STRING_LIST('H', "hide", &hidelist, "refs-to-force-hidden",
+				"refs that will be force hidden"),
+		OPT_INTEGER('V', "version", &version,
+			    "use this protocol version number"),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&nongit_ok);
+
+	argc = parse_options(argc, argv, "test-tools", options, hide_refs_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", hide_refs_usage, options);
+
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
+
+	if (!git_config_get_value("extensions.objectformat", &value)) {
+		if (!strcmp(value, "sha256"))
+			hash_size = GIT_SHA256_HEXSZ;
+	}
+
+	hide_refs_verison(&reader);
+	for (;;) {
+		hide_refs_proc(&reader);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 80055886798..c5bd7f1f806 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -72,6 +72,7 @@ static struct test_cmd cmds[] = {
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
+	{ "hide-refs", cmd__hide_refs },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "serve-v2", cmd__serve_v2 },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a432cc77d92..cba8d3b093d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -61,6 +61,7 @@ int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
+int cmd__hide_refs(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
diff --git a/t/t1419-hide-refs-hook.sh b/t/t1419-hide-refs-hook.sh
new file mode 100755
index 00000000000..3b505f0fa9d
--- /dev/null
+++ b/t/t1419-hide-refs-hook.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+#
+# Copyright (c) 2022 Sun Chao
+#
+
+test_description='Test hide-refs hook'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/t1419/common-functions.sh
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+setup_test_repos () {
+	test_expect_success "setup bare_repo and work_repo" '
+		rm -rf bare_repo.git &&
+		rm -rf work_repo &&
+		git init --bare bare_repo.git &&
+		git init work_repo &&
+
+		# create new commits and references
+		create_commits_in work_repo A B C D &&
+		(
+			cd work_repo &&
+			git config --local core.abbrev 7 &&
+			git update-ref refs/heads/main $A &&
+			git update-ref refs/heads/dev $B &&
+			git update-ref refs/pull-requests/1/head $C &&
+			git tag -m "v123" v123 $D &&
+			git push ../bare_repo.git +refs/heads/*:refs/heads/* &&
+			git push ../bare_repo.git +refs/tags/*:refs/tags/* &&
+			git push ../bare_repo.git +refs/pull-requests/*:refs/pull-requests/*
+		) &&
+		TAG=$(git -C work_repo rev-parse v123) &&
+
+		# config transfer.hiderefs values with "hook:" prefix
+		(
+			git -C bare_repo.git config --local http.receivepack true &&
+			git -C bare_repo.git config --add transfer.hiderefs hook:HEAD &&
+			git -C bare_repo.git config --add transfer.hiderefs hook:refs
+		)
+	'
+}
+
+setup_httpd() {
+	ROOT_PATH="$PWD"
+	. "$TEST_DIRECTORY"/lib-gpg.sh
+	. "$TEST_DIRECTORY"/lib-httpd.sh
+	. "$TEST_DIRECTORY"/lib-terminal.sh
+
+	start_httpd
+	set_askpass user@host pass@host
+	setup_askpass_helper
+}
+
+# Run test cases when hide-refs hook exit abnormally
+run_tests_for_abnormal_hook() {
+	GIT_TEST_PROTOCOL_VERSION=$1
+	BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
+
+	for t in  "$TEST_DIRECTORY"/t1419/abnormal-*.sh
+	do
+		setup_test_repos
+
+		. "$t"
+	done
+}
+
+# Run test cases under local/HTTP protocol
+run_tests_for_normal_hook() {
+	for t in  "$TEST_DIRECTORY"/t1419/test-*.sh
+	do
+		setup_test_repos
+		case $1 in
+			http)
+				PROTOCOL="HTTP protocol"
+
+				# bare_repo.git need move to httpd sever root path
+				BAREREPO_GIT_DIR="$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
+				rm -rf "$BAREREPO_GIT_DIR"
+				mv bare_repo.git "$BAREREPO_GIT_DIR"
+
+				# setup the repository service URL address of http protocol
+				BAREREPO_PREFIX="$HTTPD_URL"/smart
+				BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
+				;;
+			local)
+				PROTOCOL="builtin protocol"
+				BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
+
+				# setup the repository service address of builtin protocol
+				BAREREPO_PREFIX="$(pwd)"
+				BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
+				;;
+		esac
+
+		GIT_TEST_PROTOCOL_VERSION=$2
+		git -C work_repo remote add origin "$BAREREPO_URL"
+
+		. "$t"
+	done
+}
+
+setup_httpd
+for protocol in 1 2
+do
+	run_tests_for_abnormal_hook $protocol
+	run_tests_for_normal_hook local $protocol
+	run_tests_for_normal_hook http $protocol
+done
+
+test_done
diff --git a/t/t1419/abnormal-hide-refs-hook.sh b/t/t1419/abnormal-hide-refs-hook.sh
new file mode 100644
index 00000000000..c615a74f3a0
--- /dev/null
+++ b/t/t1419/abnormal-hide-refs-hook.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+# Upstream repository (bare_repo.git) contains the configurations:
+#
+#	[transfer]
+#		hiderefs = hook:HEAD
+#		hiderefs = hook:refs
+#
+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it,
+# we should make sure Git works correctly in some speicail cases
+
+# If hide-refs not exists, Git should not invoke it and continue advertise all the refs
+test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook not exists" '
+	rm -f "$BAREREPO_GIT_DIR/hooks/hide-refs" &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	cat out | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> HEAD
+		<COMMIT-B> refs/heads/dev
+		<COMMIT-A> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+# If hide-refs hook run with incompatible version, Git should not invoke it and continue to advertise all the refs
+test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook run with incompatible version" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+		test-tool hide-refs --version=2
+	EOF
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	cat out | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> HEAD
+		<COMMIT-B> refs/heads/dev
+		<COMMIT-A> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+# If hide-refs hook exit before processing any refs, Git should not die and continue to advertise all the refs
+test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die before read ref" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+		test-tool hide-refs --die-before-read-ref
+	EOF
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	cat out | make_user_friendly_and_stable_output | grep -v "^error:" >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-before-read-ref option
+		<COMMIT-A> HEAD
+		<COMMIT-B> refs/heads/dev
+		<COMMIT-A> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+# If hide-refs hook exit abnormally, Git should not die and continue to advertise left refs
+test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die after proc ref" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+		test-tool hide-refs --die-after-proc-refs
+	EOF
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	cat out | make_user_friendly_and_stable_output | grep -v "^error:" >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-after-proc-refs option
+		<COMMIT-A> HEAD
+		<COMMIT-B> refs/heads/dev
+		<COMMIT-A> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/common-functions.sh b/t/t1419/common-functions.sh
new file mode 100644
index 00000000000..7841241b038
--- /dev/null
+++ b/t/t1419/common-functions.sh
@@ -0,0 +1,74 @@
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
+}
+
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
+# Format the output of git-fetch, git-ls-remote and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about changes of the commit ID (full or abbrev.)
+# of the output.  Single quotes are replaced with double quotes, because
+# it is boring to prepare unquoted single quotes in expect text.
+make_user_friendly_and_stable_output () {
+	tr '\0' '@' | sed \
+		-e "s/'/\"/g" \
+		-e "s/@.*//g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $C)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(get_abbrev_oid $TAG)[0-9a-f]*/<COMMIT-TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s#$BAREREPO_PREFIX/bare_repo.git#<URL/of/bare_repo.git>#" \
+		-e 's/^[0-9a-f]\{4\}//g'
+
+}
+
+filter_out_hide_refs_output() {
+	make_user_friendly_and_stable_output | sed 's/^[0-9a-f]\{4\}//g'
+}
+
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
+}
+
+test_cmp_refs () {
+	indir=
+	if test "$1" = "-C"
+	then
+		shift
+		indir="$1"
+		shift
+	fi
+	indir=${indir:+"$indir"/}
+	cat >show-ref.expect &&
+	git ${indir:+ -C "$indir"} show-ref >show-ref.pristine &&
+	make_user_friendly_and_stable_output <show-ref.pristine >show-ref.filtered &&
+	test_cmp show-ref.expect show-ref.filtered
+}
diff --git a/t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh b/t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
new file mode 100644
index 00000000000..9803994b6a8
--- /dev/null
+++ b/t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+# Upstream repository (bare_repo.git) contains the configurations:
+#
+#	[transfer]
+#		hiderefs = hook:HEAD
+#		hiderefs = hook:refs
+#
+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
+
+# Git will not advertise the refs that are hided by hide-refs hook
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide part of refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+	test-tool hide-refs \
+		-H "refs/pull-requests/1/head" \
+		-H "refs/tags/v123"
+	EOF
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A>	HEAD
+		<COMMIT-B>	refs/heads/dev
+		<COMMIT-A>	refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+# The hide-ref hook should not change the default effects of [transfer|uploadpack|receive].hiderefs configurations,
+# if it hide no refs, the original hiderefs rules should works
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide no refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+		test-tool hide-refs
+	EOF
+	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs refs/heads/dev &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A>	HEAD
+		<COMMIT-A>	refs/heads/main
+		<COMMIT-C>	refs/pull-requests/1/head
+		<COMMIT-TAG-v123>	refs/tags/v123
+		<COMMIT-D>	refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh b/t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
new file mode 100644
index 00000000000..d1174266fd3
--- /dev/null
+++ b/t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+# Upstream repository (bare_repo.git) contains the configurations:
+#
+#	[transfer]
+#		hiderefs = hook:HEAD
+#		hiderefs = hook:refs
+#
+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
+
+# Git client can not fetch the refs that are hided by hide-refs hook
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hide part of refs" '
+	rm -rf local.git &&
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+	test-tool hide-refs \
+		-H "HEAD" \
+		-H "refs/heads/dev" \
+		-H "refs/heads/main"
+	EOF
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -C local.git show-ref -d >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+# If a ref is hided by hide-refs hook, its private commits (tip or non-tip) will be force hidden
+# to the client, and the client can not fetch such kind of commit even the server set allowTipSHA1InWant
+# or allowReachableSHA1InWant to true
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a commit which is hided by hide-refs hook" '
+	rm -rf local.git &&
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+	test-tool hide-refs \
+		-H "refs/heads/dev" \
+		-H "refs/pull-requests/1/head" \
+		-H "refs/tags/v123"
+	EOF
+	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowTipSHA1InWant true &&
+	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true &&
+	git init local.git &&
+	git -C local.git remote add origin "$BAREREPO_URL" &&
+	test_must_fail git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $B
+'
diff --git a/t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh b/t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh
new file mode 100644
index 00000000000..0fe3c2e1389
--- /dev/null
+++ b/t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+# Upstream repository (bare_repo.git) contains the configurations:
+#
+#	[transfer]
+#		hiderefs = hook:HEAD
+#		hiderefs = hook:refs
+#
+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook does not hide it" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+		test-tool hide-refs
+	EOF
+	create_commits_in work_repo E &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		To <URL/of/bare_repo.git>
+		   <COMMIT-A>..<COMMIT-E>  HEAD -> main
+	EOF
+	test_cmp expect actual
+'
+
+# If hide-refs hook hide some ref, git push will be rejected
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide it" '
+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
+	test-tool hide-refs \
+		-H "refs/heads/main"
+	EOF
+	create_commits_in work_repo F &&
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		To <URL/of/bare_repo.git>
+		 ! [remote rejected] HEAD -> main (deny updating a hidden ref)
+		error: failed to push some refs to "<URL/of/bare_repo.git>"
+	EOF
+	test_cmp expect actual
+'
-- 
gitgitgadget

