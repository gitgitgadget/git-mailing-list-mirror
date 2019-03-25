Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A521220248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfCYMIy (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32916 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfCYMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so9854892wrp.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KBMIoufgK0VuPFB2g3EY0LDiHONfBFoAK4Gz9Ecu2E=;
        b=Kj0B0UIz+u1hVqzcgZs8NuLgPVhp9TW5XlbH65pjXV2e9sOmapVL1H1SfBVwZGSZyN
         LJogbHHgE4ugvBr+kqKhmo13prlX8ayAwiGBdlEBaa8v245UkkJXtydpKD4hC17597VH
         7DRLuTVi4CAmZCEGsC/uBkKaBjdqCeZNewoxjDBsg5vLA5iz9Zw9ILLhTLoyba2/Sc7S
         HXfn2tfSXXe4BxvGnk1doh2GkLfvbb6lR30DYsCXR+Krnzjwu1J0KWooISbWyBLQtoKr
         hcEd2jTP5InALgI19sWAhvBh8BCDRBL6ZWgkg0bovTNOn3gpqzu7WiNtGEXMwCFP4mxF
         VhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KBMIoufgK0VuPFB2g3EY0LDiHONfBFoAK4Gz9Ecu2E=;
        b=PzbUwWTi0UWj2QxLs1MgjwfiFRmu+Bw+mYEXiisFtWqGmee1wL1T1xH6DgCqPIJD6Z
         8LSFQNH8Czg5jgHpJfmtpyYRU4C5NZUIedxfxL3AHQyjd0EHBPdF4dlitqTh2oz8N+Tf
         G2KMVLvb39BsGZLU477eFsC+xTAXIu0tRj9PoaiJMUQhvxynOZn5em7Ms8Ll/ZFjUKCM
         ppP9QRsiFKU2YY+pFZRFHTw9uw7m/dzknNgDSBQWADCyCof3y1GoV2SM0bQTY1us6kx7
         alOynQBWoTMHwveG0k48jxWR6NurMDi1xeUHQBIGOgJC8uRnhd0DNFNq8QT7Rb11Z8aL
         S5ig==
X-Gm-Message-State: APjAAAXtEbgciY7wouJdnFUlStOm+VH3P5GqT+yL7bohtBBcEO6nxSvF
        qMQCPRYMxJfVu/C2DW+SZFI/NaQpzkI=
X-Google-Smtp-Source: APXvYqzmn6VnlJQJTKW+04FqTHoNm4bkKjjR0W0xkT4cOHrZu7GECr9w6J9azD0C2U3DIMCOlFt6Kg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr14486141wru.266.1553515731693;
        Mon, 25 Mar 2019 05:08:51 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:50 -0700 (PDT)
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
Subject: [PATCH v3 5/8] commit-graph: don't pass filename to load_commit_graph_one_fd_st()
Date:   Mon, 25 Mar 2019 13:08:31 +0100
Message-Id: <20190325120834.15529-6-avarab@gmail.com>
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

An earlier change implemented load_commit_graph_one_fd_st() in a way
that was bug-compatible with earlier code in terms of the "graph file
%s is too small" error message printing out the path to the
commit-graph (".git/objects/info/commit-graph").

But change that, because:

 * A function that takes an already-open file descriptor also needing
   the filename isn't very intuitive.

 * The vast majority of errors we might emit when loading the graph
   come from parse_commit_graph(), which doesn't report the
   filename. Let's not do that either in this case for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ++--
 commit-graph.c         | 7 +++----
 commit-graph.h         | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 32bcc63427..8196fdbe9c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -64,7 +64,7 @@ static int graph_verify(int argc, const char **argv)
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok)
 		return 0;
-	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
+	graph = load_commit_graph_one_fd_st(fd, &st);
 	FREE_AND_NULL(graph_name);
 
 	if (!graph)
@@ -102,7 +102,7 @@ static int graph_read(int argc, const char **argv)
 	if (!open_ok)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 
-	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
+	graph = load_commit_graph_one_fd_st(fd, &st);
 	if (!graph)
 		return 1;
 
diff --git a/commit-graph.c b/commit-graph.c
index 3acc032c1b..a26d266663 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -92,8 +92,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
-						 int fd, struct stat *st)
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -103,7 +102,7 @@ struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		error(_("graph file %s is too small"), graph_file);
+		error(_("commit-graph file is too small"));
 		return NULL;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -284,7 +283,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!open_ok)
 		return NULL;
 
-	return load_commit_graph_one_fd_st(graph_file, fd, &st);
+	return load_commit_graph_one_fd_st(fd, &st);
 }
 
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
diff --git a/commit-graph.h b/commit-graph.h
index 77cc739bc0..ada7aea9ed 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -53,8 +53,7 @@ struct commit_graph {
 	const unsigned char *chunk_extra_edges;
 };
 
-struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
-						 int fd, struct stat *st);
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
-- 
2.21.0.360.g471c308f928

