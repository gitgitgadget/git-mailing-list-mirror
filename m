Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D488CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiCASpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F216579E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk29so4650397wrb.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LiVhcaCHGvMCsb+ulNn/6al8f/Ptsx7ApJ9UIEJdfOk=;
        b=Jr4HO8k1LxPZL5/8ANcjki9Xe2UbbNqi9qrhsjSqrVzVqtrZO/ir65wln3HFNbcKmQ
         EZjUtFEa6/oBLmVkv8AsWtx0SBK5UQx6uCBKkngCDiAT8cnZWvHNU/e8GNQJLTckAJ4i
         K0mMnBclofWFIxGL2OQLf+ticFTcxx9SeFT7Kb9R3zycdleNyCaLtxKT8c+ucO7oQHVM
         XErhb5zuoIIqwzIHbhazssEnHp0ZFGtYlE7/l9UQ6vHvGCv9NWlbCbTOYer+Sk1iiwQT
         10MOeGdq1FropFDsbFSQBjiz9W/3lR6zun4IPicdZuPgCelbOIr/9x1w67Kw3kGXZj/l
         XsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LiVhcaCHGvMCsb+ulNn/6al8f/Ptsx7ApJ9UIEJdfOk=;
        b=TgRaD8MpUe4cKz13iLp5mcBpbvYUU5TtC+PXyEDhXCpsKLiSViDGTRF1jtM/8CM7JV
         5Us/JwnDe8w1nf3vLsTY4CWc0RYpv9tf9e3DILSG0v2t+UFwMAQugC0HYesWslCy9ABL
         iEtjGDkZuteJbSub2yP7gq1GS6T9rGvl6qotqyg32zfEtCHQg7LZoBap5Ngg7o1r1adR
         prqFTsrWxFgfi+9WIj7qTaMt3cNkgcPM6ZnbkOopI3PMqGreeUezubhTfIj+PggETiFH
         JoLpPkRrtMHSG9HvDNlJ6Hzz2f0CVBTx7+KG6WpIOPxc/MsaJoD+4/J+bfn0zRK6B0qx
         Iz7Q==
X-Gm-Message-State: AOAM5331Yfh0J46+idxWoJwo1MbL8SA/SJyOj4PuVqk5jp1CyB2+q4td
        SCX/iDGCLwjM4lWnvsX52gsVB6+UeE4=
X-Google-Smtp-Source: ABdhPJwTm4PwI07qT859kRCLpjjqrTR0oXxCS8PIwdyf+9LDsCrbjIBNqiPTxs+OAcQSjmQfwcdHvw==
X-Received: by 2002:a5d:4d87:0:b0:1ef:cf9a:2f9 with SMTP id b7-20020a5d4d87000000b001efcf9a02f9mr8454702wru.204.1646160231916;
        Tue, 01 Mar 2022 10:43:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020adfce0b000000b001e7026150besm14567721wrn.31.2022.03.01.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:51 -0800 (PST)
Message-Id: <2b563c240eb1b592e95e89400aa5d57df1bf29b8.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:22 +0000
Subject: [PATCH v6 20/30] t/helper/fsmonitor-client: create IPC client to talk
 to FSMonitor Daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create an IPC client to send query and flush commands to the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                         |   1 +
 t/helper/test-fsmonitor-client.c | 121 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 4 files changed, 124 insertions(+)
 create mode 100644 t/helper/test-fsmonitor-client.c

diff --git a/Makefile b/Makefile
index 26567d4f772..daa21bed6c3 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
new file mode 100644
index 00000000000..f7a5b3a32fa
--- /dev/null
+++ b/t/helper/test-fsmonitor-client.c
@@ -0,0 +1,121 @@
+/*
+ * test-fsmonitor-client.c: client code to send commands/requests to
+ * a `git fsmonitor--daemon` daemon.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "fsmonitor-ipc.h"
+
+#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	die("fsmonitor--daemon not available on this platform");
+}
+#else
+
+/*
+ * Read the `.git/index` to get the last token written to the
+ * FSMonitor Index Extension.
+ */
+static const char *get_token_from_index(void)
+{
+	struct index_state *istate = the_repository->index;
+
+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update)
+		die("index file does not have fsmonitor extension");
+
+	return istate->fsmonitor_last_update;
+}
+
+/*
+ * Send an IPC query to a `git-fsmonitor--daemon` daemon and
+ * ask for the changes since the given token or from the last
+ * token in the index extension.
+ *
+ * This will implicitly start a daemon process if necessary.  The
+ * daemon process will persist after we exit.
+ */
+static int do_send_query(const char *token)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+
+	ret = fsmonitor_ipc__send_query(token, &answer);
+	if (ret < 0)
+		die(_("could not query fsmonitor--daemon"));
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+/*
+ * Send a "flush" command to the `git-fsmonitor--daemon` (if running)
+ * and tell it to flush its cache.
+ *
+ * This feature is primarily used by the test suite to simulate a loss of
+ * sync with the filesystem where we miss kernel events.
+ */
+static int do_send_flush(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("flush", &answer);
+	if (ret)
+		return ret;
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	const char *subcmd;
+	const char *token = NULL;
+
+	const char * const fsmonitor_client_usage[] = {
+		N_("test-helper fsmonitor-client query [<token>]"),
+		N_("test-helper fsmonitor-client flush"),
+		NULL,
+	};
+
+	struct option options[] = {
+		OPT_STRING(0, "token", &token, N_("token"),
+			   N_("command token to send to the server")),
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(fsmonitor_client_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(fsmonitor_client_usage, options);
+
+	subcmd = argv[1];
+	argv--;
+	argc++;
+
+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
+
+	setup_git_directory();
+
+	if (!strcmp(subcmd, "query"))
+		return !!do_send_query(token);
+
+	if (!strcmp(subcmd, "flush"))
+		return !!do_send_flush();
+
+	die("Unhandled subcommand: '%s'", subcmd);
+}
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e6ec69cf326..0424f7adf5d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -32,6 +32,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 20756eefdda..c876e8246fb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
-- 
gitgitgadget

