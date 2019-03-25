Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBF420248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfCYMIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40053 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfCYMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so9788995wri.7
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/ql19PsfWKCt2xWIuc628GJETf/dP/bTSODTNC2EdU=;
        b=MEgSrxV71VFdA+kAJEtFRnkFQS3TRqs8/8fVnW+ZlwkNIfu1DdMmy8WcDv4AyfH+JA
         AwYaNxoOijLQvPS5qCCZ82E9bQFWGbaW0MBQqfsyl9yNYtserbtU7v1a5zrraawkKC4y
         n+qiG8uo2+B4i/Kvnc7WjKfqRxcMADsYvpravUK1CdiSzA+zAjabjgJ3iyfDjHj3hrGs
         ExAmvjDg7EpAjRZBBCN8TyKNbE3auJx6IB2rIvinyGvHFr6Dq9x57XwHiDGXAUNylgDa
         e/sIp+FvTyQ9aVbskhIyl8YYS1IufqUev+Qb4QNh0gJwWKkCwzKsBMIDkcLRDPL6ETe1
         o+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/ql19PsfWKCt2xWIuc628GJETf/dP/bTSODTNC2EdU=;
        b=nWbc3kA7ABkOURtNklMu7NneGvVw1SbvjlPYjgvgYTNpNxPewXqWGWwp2QYb6XMyGm
         yoHrAYy29xJlrhEgvZxiqsYRx/LjmGvBf6wRsUe3zbHyNylwCxlsGzqUED/rp1zIsFfi
         T3ytkctlUN8ERvu9BEb+LvQ0eoLX27afanlInfWxGcfPoy5xLwka5j1n53Beaa3yDsyn
         srw3CyhZ0mHVsQNs/MrlXC/KwwQhMNqkr2Bdbj81hI/rHF0KRWXsguOmaJRE3SnMNhdn
         BRbuGodQfU4LGsLFvALckvT0T8ERI27lgoAmHurh6c7EmLgBGMUw1h4oYUfZ1BRIts/f
         SxHQ==
X-Gm-Message-State: APjAAAXgezstJ1iDKK+1bMXpNklqQadNNpX6yo+vCPrNpkh7ohK6HZ4d
        /IfwPbvHVWQVplt2SYSJgZ77Mz39
X-Google-Smtp-Source: APXvYqxMAP66bzq29axdHB2lt1jwTYrzvheVpnBfordcYFWFkzmXnHtihs9sMDMdQXPfO72NDFYVpA==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr14868630wru.33.1553515730295;
        Mon, 25 Mar 2019 05:08:50 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] commit-graph: don't early exit(1) on e.g. "git status"
Date:   Mon, 25 Mar 2019 13:08:30 +0100
Message-Id: <20190325120834.15529-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the commit-graph loading code work as a library that returns an
error code instead of calling exit(1) when the commit-graph is
corrupt. This means that e.g. "status" will now report commit-graph
corruption as an "error: [...]" at the top of its output, but then
proceed to work normally.

This required splitting up the load_commit_graph_one() function so
that the code that deals with open()-ing and stat()-ing the graph can
now be called independently as open_commit_graph().

This is needed because "commit-graph verify" where the graph doesn't
exist isn't an error. See the third paragraph in
283e68c72f ("commit-graph: add 'verify' subcommand",
2018-06-27). There's a bug in that logic where we conflate the
intended ENOENT with other errno values (e.g. EACCES), but this change
doesn't address that. That'll be addressed in a follow-up change.

I'm then splitting most of the logic out of load_commit_graph_one()
into load_commit_graph_one_fd_st(), which allows for providing an
existing file descriptor and stat information to the loading
code. This isn't strictly needed, but it would be redundant and
confusing to open() and stat() the file twice for some of the
codepaths, this allows for calling open_commit_graph() followed by
load_commit_graph_one_fd_st(). The "graph_file" still needs to be
passed to that function for the the "graph file %s is too small" error
message.

This leaves load_commit_graph_one() unused by everything except the
internal prepare_commit_graph_one() function, so let's mark it as
"static". If someone needs it in the future we can remove the "static"
attribute. I could also rewrite its sole remaining
user ("prepare_commit_graph_one()") to use
load_commit_graph_one_fd_st() instead, but let's leave it at this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/commit-graph.c  | 21 +++++++++++++++++----
 commit-graph.c          | 42 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  4 +++-
 t/t5318-commit-graph.sh |  2 +-
 4 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4ae502754c..32bcc63427 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -42,6 +42,9 @@ static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	char *graph_name;
+	int open_ok;
+	int fd;
+	struct stat st;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -58,11 +61,14 @@ static int graph_verify(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
-	graph = load_commit_graph_one(graph_name);
+	open_ok = open_commit_graph(graph_name, &fd, &st);
+	if (!open_ok)
+		return 0;
+	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
 	FREE_AND_NULL(graph_name);
 
 	if (!graph)
-		return 0;
+		return 1;
 
 	UNLEAK(graph);
 	return verify_commit_graph(the_repository, graph);
@@ -72,6 +78,9 @@ static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	char *graph_name;
+	int open_ok;
+	int fd;
+	struct stat st;
 
 	static struct option builtin_commit_graph_read_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -88,10 +97,14 @@ static int graph_read(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
-	graph = load_commit_graph_one(graph_name);
 
+	open_ok = open_commit_graph(graph_name, &fd, &st);
+	if (!open_ok)
+		die_errno(_("Could not open commit-graph '%s'"), graph_name);
+
+	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
 	if (!graph)
-		die("graph file %s does not exist", graph_name);
+		return 1;
 
 	FREE_AND_NULL(graph_name);
 
diff --git a/commit-graph.c b/commit-graph.c
index f8201d888b..3acc032c1b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -80,25 +80,31 @@ static int commit_graph_compatible(struct repository *r)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one(const char *graph_file)
+int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
+{
+	*fd = git_open(graph_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	return 1;
+}
+
+struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
+						 int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
-	struct stat st;
 	struct commit_graph *ret;
-	int fd = git_open(graph_file);
 
-	if (fd < 0)
-		return NULL;
-	if (fstat(fd, &st)) {
-		close(fd);
-		return NULL;
-	}
-	graph_size = xsize_t(st.st_size);
+	graph_size = xsize_t(st->st_size);
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		die(_("graph file %s is too small"), graph_file);
+		error(_("graph file %s is too small"), graph_file);
+		return NULL;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	ret = parse_commit_graph(graph_map, fd, graph_size);
@@ -106,7 +112,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!ret) {
 		munmap(graph_map, graph_size);
 		close(fd);
-		exit(1);
 	}
 
 	return ret;
@@ -269,6 +274,19 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	return graph;
 }
 
+static struct commit_graph *load_commit_graph_one(const char *graph_file)
+{
+
+	struct stat st;
+	int fd;
+	int open_ok = open_commit_graph(graph_file, &fd, &st);
+
+	if (!open_ok)
+		return NULL;
+
+	return load_commit_graph_one_fd_st(graph_file, fd, &st);
+}
+
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	char *graph_name;
diff --git a/commit-graph.h b/commit-graph.h
index 096d8bac34..77cc739bc0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,7 @@
 struct commit;
 
 char *get_commit_graph_filename(const char *obj_dir);
+int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:
@@ -52,7 +53,8 @@ struct commit_graph {
 	const unsigned char *chunk_extra_edges;
 };
 
-struct commit_graph *load_commit_graph_one(const char *graph_file);
+struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
+						 int fd, struct stat *st);
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ad3a695f76..71d775e313 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -377,7 +377,7 @@ corrupt_graph_verify() {
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err &&
-	test_might_fail git status --short
+	git status --short
 }
 
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
-- 
2.21.0.360.g471c308f928

