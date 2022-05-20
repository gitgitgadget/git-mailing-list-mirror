Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C9C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353074AbiETSmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353022AbiETSlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E63237FD
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n6so4996539wms.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=x+TY/9N2d674JRCaLR7HnPUQUg+jdft8S9Jv0um4vuM=;
        b=fytmzWb9EmP95sAl6OQBcfQuWeHO7Fwd66LNb+29JrWw12OknjgM46zqDF4qmaj5iT
         9xcvLA1MD1a0KbLG7F04sC2KZ0nzGDoOH5ZkcoNngKzrt77IlPKlEjaLcGbSrz+lz+R1
         nI9uDN/7v3CgoK1TDfFBbWU6/kDIGy4duny8Fh/Hzq/2i+GEsGbZi0yuBQ9yT+AvsO8d
         J7zuElTFohpz8e98DrGQLYJ5qpY5a1USf9bHCith2VdbTQpshXTxFe7r0DM9J7sWQC2+
         D0C+CtqexK2TKOFpVHK+njzwl4sDV4wgnrdkVlLjHKcCjcIepSwtcdv1YFkLKhRMwAkI
         FEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=x+TY/9N2d674JRCaLR7HnPUQUg+jdft8S9Jv0um4vuM=;
        b=kQYGeFxlukubLE5FUT+ZjvX3mqWeoiGUhUMcxJSpaUPGHUqWMuBtsQV1OQpRwpBGiw
         MqyE30Q2VFGidAYKV9vEFLc5LyDpdBRqBMO1yLwEKJr+hDQ/dZyJ5hbV1qs0DfUBOqtd
         dfGYT0DFPitfU9OrJCOM3CIPEYm8JhXb5O/VquMdZF5V5lFq3HRMvHG9oHTLKK7V86mM
         /Y/2PRTbBIaXv9zPPeV5vxz6FK3gTy/zbbHiBJ4nv8sPG2vmphZv58YvoKOKJQtOk9wk
         OfhSlRR8uGG2fojtA73IwKe3Gp5jCR54As4W8ioFJhGLjfLDD2eZFLlS/4RCxtHTbhvI
         O2vw==
X-Gm-Message-State: AOAM533dfIaxh/Ijj6rRw3ImHcm24F9kUDQC+EYeTp8BiM1X0OOCHEjN
        gU3ZLMFiIaANroln6EDwLAjXaRjws6U=
X-Google-Smtp-Source: ABdhPJx8sX+Z4w2ZYu3ykaTzYCX+kIQtiFl49wN47YFGWSAFA7OxMg4q9eYcaz5yZaHl4vv29TCw2A==
X-Received: by 2002:a05:600c:4f95:b0:394:8919:7557 with SMTP id n21-20020a05600c4f9500b0039489197557mr9583277wmq.166.1653072064693;
        Fri, 20 May 2022 11:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020adfa3c6000000b0020fc4cd81f6sm279895wrb.60.2022.05.20.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:04 -0700 (PDT)
Message-Id: <f14144ffada7bc426ca33d07b810b3ebfbde9fb2.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:36 +0000
Subject: [PATCH 18/24] bundle-uri client: add "git ls-remote-bundle-uri"
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

TODO: make this a test-helper instead of its own builtin?

Add a git-ls-remote-bundle-uri command, this is a thin wrapper for
issuing protocol v2 "bundle-uri" commands to a server, and to the
parsing routines in bundle-uri.c.

Since in the "git clone" case we'll have already done the handshake(),
but not here, introduce a "got_advertisement" state along with
"got_remote_heads". It seems to me that the "got_remote_heads" is
badly named in the first place, and the whole logic of eagerly getting
ls-refs on handshake() or not could be refactored somewhat, but let's
not do that now, and instead just add another self-documenting state
variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 .gitignore                                 |   1 +
 Documentation/git-ls-remote-bundle-uri.txt |  62 +++++++++
 Documentation/git-ls-remote.txt            |   1 +
 Makefile                                   |   1 +
 builtin.h                                  |   1 +
 builtin/clone.c                            |   2 +-
 builtin/ls-remote-bundle-uri.c             |  71 ++++++++++
 command-list.txt                           |   1 +
 git.c                                      |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 147 ++++++++++++++++++++-
 transport.c                                |  43 ++++--
 transport.h                                |   6 +-
 12 files changed, 324 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c

diff --git a/.gitignore b/.gitignore
index e81de1063a4..e1312b2795c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -91,6 +91,7 @@
 /git-log
 /git-ls-files
 /git-ls-remote
+/git-ls-remote-bundle-uri
 /git-ls-tree
 /git-mailinfo
 /git-mailsplit
diff --git a/Documentation/git-ls-remote-bundle-uri.txt b/Documentation/git-ls-remote-bundle-uri.txt
new file mode 100644
index 00000000000..793d7677f2f
--- /dev/null
+++ b/Documentation/git-ls-remote-bundle-uri.txt
@@ -0,0 +1,62 @@
+git-ls-remote-bundle-uri(1)
+===========================
+
+NAME
+----
+git-ls-remote-bundle-uri - List 'bundle-uri' in a remote repository
+
+SYNOPSIS
+--------
+[verse]
+'git ls-remote-bundle-uri' [-q |--quiet] [--uri] [--upload-pack=<exec>]
+			 [[-o | --server-option=]<option>] <repository>
+
+
+DESCRIPTION
+-----------
+
+Displays the `bundle-uri`s advertised by a remote repository. See
+`bundle-uri` in link:technical/protocol-v2.html[the Git Wire Protocol,
+Version 2] documentation for what the output format looks like.
+
+OPTIONS
+-------
+
+-q::
+--quiet::
+	Do not print remote URL to stderr in cases where the remote
+	name is inferred from config.
++
+When the remote name is not inferred (e.g. `git ls-remote-bundle-uri
+origin`, or `git ls-remote-bundle-uri https://[...]`) the remote URL
+is not printed in any case.
+
+--uri::
+	Print only the URIs, and not any of their optional attributes.
+
+--upload-pack=<exec>::
+	Specify the full path of 'git-upload-pack' on the remote
+	host. This allows listing references from repositories accessed via
+	SSH and where the SSH daemon does not use the PATH configured by the
+	user.
+
+-o <option>::
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
+<repository>::
+	The "remote" repository to query.  This parameter can be
+	either a URL or the name of a remote (see the GIT URLS and
+	REMOTES sections of linkgit:git-fetch[1]).
+
+SEE ALSO
+--------
+linkgit:git-ls-remote[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 492e573856f..86c07eff832 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -114,6 +114,7 @@ c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 
 SEE ALSO
 --------
+linkgit:git-ls-remote-bundle-uri[1].
 linkgit:git-check-ref-format[1].
 
 GIT
diff --git a/Makefile b/Makefile
index c8a14793005..badb87bed78 100644
--- a/Makefile
+++ b/Makefile
@@ -1161,6 +1161,7 @@ BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
+BUILTIN_OBJS += builtin/ls-remote-bundle-uri.o
 BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
 BUILTIN_OBJS += builtin/mailinfo.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..c80bec94abe 100644
--- a/builtin.h
+++ b/builtin.h
@@ -173,6 +173,7 @@ int cmd_log(int argc, const char **argv, const char *prefix);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 int cmd_ls_files(int argc, const char **argv, const char *prefix);
 int cmd_ls_tree(int argc, const char **argv, const char *prefix);
+int cmd_ls_remote_bundle_uri(int argc, const char **argv, const char *prefix);
 int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 int cmd_mailsplit(int argc, const char **argv, const char *prefix);
diff --git a/builtin/clone.c b/builtin/clone.c
index 7bedd9eb29e..ca2291552f7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1267,7 +1267,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 * Populate transport->got_remote_bundle_uri and
 	 * transport->bundle_uri. We might get nothing.
 	 */
-	transport_get_remote_bundle_uri(transport);
+	transport_get_remote_bundle_uri(transport, 1);
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/builtin/ls-remote-bundle-uri.c b/builtin/ls-remote-bundle-uri.c
new file mode 100644
index 00000000000..dbd499d369e
--- /dev/null
+++ b/builtin/ls-remote-bundle-uri.c
@@ -0,0 +1,71 @@
+#include "builtin.h"
+#include "cache.h"
+#include "bundle-uri.h"
+#include "transport.h"
+#include "ref-filter.h"
+#include "remote.h"
+#include "refs.h"
+
+static const char * const ls_remote_bundle_uri_usage[] = {
+	N_("git ls-remote-bundle-uri <repository>"),
+	NULL
+};
+
+int cmd_ls_remote_bundle_uri(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	int uri = 0;
+	const char *uploadpack = NULL;
+	struct string_list server_options = STRING_LIST_INIT_DUP;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("do not print remote URL")),
+		OPT_BOOL(0, "uri", &uri, N_("limit to showing uri field")),
+		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host")),
+		OPT_STRING_LIST('o', "server-option", &server_options,
+				N_("server-specific"),
+				N_("option to transmit")),
+		OPT_END()
+	};
+	const char *dest = NULL;
+	struct remote *remote;
+	struct transport *transport;
+	int status = 0;
+
+	argc = parse_options(argc, argv, prefix, options, ls_remote_bundle_uri_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	dest = argv[0];
+
+	packet_trace_identity("ls-remote-bundle-uri");
+
+	remote = remote_get(dest);
+	if (!remote) {
+		if (dest)
+			die(_("bad repository '%s'"), dest);
+		die(_("no remote configured to get bundle URIs from"));
+	}
+	if (!remote->url_nr)
+		die(_("remote '%s' has no configured URL"), dest);
+
+	transport = transport_get(remote, NULL);
+	if (uploadpack)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
+	if (!dest && !quiet)
+		fprintf(stderr, "From %s\n", *remote->url);
+
+	if (transport_get_remote_bundle_uri(transport, 0) < 0) {
+		error(_("could not get the bundle-uri list"));
+		status = 1;
+		goto cleanup;
+	}
+
+	print_bundle_list(stdout, transport->bundles);
+
+cleanup:
+	if (transport_disconnect(transport))
+		return 1;
+	return status;
+}
diff --git a/command-list.txt b/command-list.txt
index 9bd6f3c48f4..a50eebd4aa2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -115,6 +115,7 @@ git-interpret-trailers                  purehelpers
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
+git-ls-remote-bundle-uri                plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
diff --git a/git.c b/git.c
index 3d8e48cf555..352e76cedaf 100644
--- a/git.c
+++ b/git.c
@@ -551,6 +551,7 @@ static struct cmd_struct commands[] = {
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
+	{ "ls-remote-bundle-uri", cmd_ls_remote_bundle_uri, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index 27294e9c976..23f2de0d9d7 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -34,7 +34,9 @@ esac
 test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
 	git init "$T5730_PARENT" &&
 	test_commit -C "$T5730_PARENT" one &&
-	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true &&
+	git -C "$T5730_PARENT" config bundle.list.version 1 &&
+	git -C "$T5730_PARENT" config bundle.list.mode all
 '
 
 # Poor man's URI escaping. Good enough for the test suite whose trash
@@ -94,7 +96,7 @@ test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bun
 test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protocol v2" '
 	test_when_finished "rm -f log" &&
 
-	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+	test_config -C "$T5730_PARENT" bundle.only.uri \
 		"$T5730_BUNDLE_URI_ESCAPED" &&
 
 	cat >err.expect <<-\EOF &&
@@ -146,3 +148,144 @@ test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protoc
 	grep "clone> test-bad-client$" log >sent-bad-request &&
 	test_file_not_empty sent-bad-request
 '
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" bundle.only.uri \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp_config_output expect actual &&
+
+	# Only the URIs
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri --uri \
+		"$T5730_URI" \
+		>actual2 &&
+	test_cmp actual actual2
+'
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" bundle.only.uri \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# Extra data should be ignored
+	test_config -C "$T5730_PARENT" bundle.only.extra bogus &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2: --uri" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" bundle.only.uri \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf child" &&
+	env GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		 clone "$T5730_URI" child &&
+
+	test_config -C "$T5730_PARENT" bundle.only.uri \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# Without --[no-]quiet
+	cat >out.expect <<-EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	cat >err.expect <<-EOF &&
+	From $T5730_URI
+	EOF
+	git \
+		-C child \
+		 -c protocol.version=2 \
+		ls-remote-bundle-uri \
+		>out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp_config_output out.expect out.actual &&
+
+	# --no-quiet is the default
+	git \
+		-C child \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--no-quiet \
+		>out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp_config_output out.expect out.actual &&
+
+	# --quiet quiets the "From" line
+	git \
+		-C child \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--quiet \
+		>out.actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output out.expect out.actual &&
+
+	# --quiet is implicit if the remote is not implicit
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>out.actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output out.expect out.actual
+'
diff --git a/transport.c b/transport.c
index 106bb8c5577..c9d2e1804eb 100644
--- a/transport.c
+++ b/transport.c
@@ -198,6 +198,7 @@ struct git_transport_data {
 	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
+	unsigned got_advertisement : 1;
 	unsigned got_remote_heads : 1;
 	enum protocol_version version;
 	struct oid_array extra_have;
@@ -346,6 +347,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		BUG("unknown protocol version");
 	}
 	data->got_remote_heads = 1;
+	data->got_advertisement = 1;
 	transport->hash_algo = reader.hash_algo;
 
 	if (reader.line_peeked)
@@ -371,6 +373,33 @@ static int get_bundle_uri(struct transport *transport)
 		init_bundle_list(transport->bundles);
 	}
 
+	if (!data->got_advertisement) {
+		struct ref *refs;
+		struct git_transport_data *data = transport->data;
+		enum protocol_version version;
+
+		refs = handshake(transport, 0, NULL, 0);
+		version = data->version;
+
+		switch (version) {
+		case protocol_v2:
+			assert(!refs);
+			break;
+		case protocol_v0:
+		case protocol_v1:
+		case protocol_unknown_version:
+			assert(refs);
+			break;
+		}
+	}
+
+	/*
+	 * "Support" protocol v0 and v2 without bundle-uri support by
+	 * silently degrading to a NOOP.
+	 */
+	if (!server_supports_v2("bundle-uri", 0))
+		return 0;
+
 	packet_reader_init(&reader, data->fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
@@ -1498,7 +1527,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
-int transport_get_remote_bundle_uri(struct transport *transport)
+int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
 	const struct transport_vtable *vtable = transport->vtable;
 
@@ -1506,20 +1535,16 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 	if (transport->got_remote_bundle_uri++)
 		return 0;
 
-	/*
-	 * "Support" protocol v0 and v2 without bundle-uri support by
-	 * silently degrading to a NOOP.
-	 */
-	if (!server_supports_v2("bundle-uri", 0))
-		return 0;
-
 	/*
 	 * This is intentionally below the transport.injectBundleURI,
 	 * we want to be able to inject into protocol v0, or into the
 	 * dialog of a server who doesn't support this.
 	 */
-	if (!vtable->get_bundle_uri)
+	if (!vtable->get_bundle_uri) {
+		if (quiet)
+			return -1;
 		return error(_("bundle-uri operation not supported by protocol"));
+	}
 
 	if (vtable->get_bundle_uri(transport) < 0)
 		return error(_("could not retrieve server-advertised bundle-uri list"));
diff --git a/transport.h b/transport.h
index 015375e083d..f40bf2c69b8 100644
--- a/transport.h
+++ b/transport.h
@@ -296,8 +296,12 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 /**
  * Retrieve bundle URI(s) from a remote. Populates "struct
  * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ *
+ * With `quiet=1` it will not complain if the serve doesn't support
+ * the protocol, but only if we discover the server uses it, and
+ * encounter issues then.
  */
-int transport_get_remote_bundle_uri(struct transport *transport);
+int transport_get_remote_bundle_uri(struct transport *transport, int quiet);
 
 /*
  * Fetch the hash algorithm used by a remote.
-- 
gitgitgadget

