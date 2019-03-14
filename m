Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CF020248
	for <e@80x24.org>; Thu, 14 Mar 2019 21:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCNVsB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:48:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfCNVsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:48:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so4175457wmg.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEOZPpNa7heO1E7SS9u5IQ8e8RpiwVKTgwPoVN6GV8c=;
        b=gbs3bU/oi+UnkRGoT6UPxVUpWnv5sWemsM4731FAav0Lm8mPqpGv2yfW7AMho3Vsu+
         LG7J4/3KuwseC+g0QeFwUjZK0Sm/Kesu6TbYS7hlLyGc+FYMeE9yHT7wTz40InEv4ztE
         pCzJDZAtPcDnQxf2+H0XoGIABd4R+eCp5f26zJletXvFlWXo9NavoGGgohC116IESQtw
         xFIm9obfAS0XesYtFHvTh9diycVO87g5W4kVw9CW/KfpS1bdBrwUf6ZtTzBPr1y3Z0es
         11JrYftgiQipALTdhzb75+RaMbFtBDokTGK8NVy7TsJDf6Kfv/GLLmmBd8wkDZecsuy6
         Ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEOZPpNa7heO1E7SS9u5IQ8e8RpiwVKTgwPoVN6GV8c=;
        b=kOmHgWAG5Tv9oC2Y/NbQoi0riejslKywWqEx9upm8BOoVL2n6Cn9X+6dFJ9KE6Hh+H
         d+sUC3rOj9BDcv78yyoopY2FwYGcWxx66vrhn3vxjnboScjkfP9z3mJYJsxeboMO7X1G
         dU3TO0TFl2xlmc8Q7skrBZ3EA1LcWAYLtvX1SHcQMeLwX+dVi03bhJFKyDUp/5vI1Beq
         Z+6FSbnOlJazuX0mhmKdWk/oFsKW80zHaVchIZaBdoelowLTuc4yWexhkb3VwAGnbCU+
         9btdZ8oeOokilaZRL1rODkarectXSQoHr+cJfA6NXHeNVo8alLdaoOd1qzvn7vPIboUQ
         qygA==
X-Gm-Message-State: APjAAAXYockBVvRrFJpGhD2VvEeOKs7G181uCZtxUM4tyhHi26TZBoTl
        fCggi8NICACu3y+tzA+bC1fwmLV2xJ0=
X-Google-Smtp-Source: APXvYqwX66EQGC68ystHYMb1F+Wu/KLNzrbio7vw7MDJ+e7mza/VXLDwahRj947P5rSBgNn+cQkblQ==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr340334wmc.129.1552600078618;
        Thu, 14 Mar 2019 14:47:58 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] commit-graph: don't pass filename to load_commit_graph_one_fd_st()
Date:   Thu, 14 Mar 2019 22:47:37 +0100
Message-Id: <20190314214740.23360-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
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
index b1ba7a09cc..d945e8f3e0 100644
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
 		return 0;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -127,7 +126,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!open_ok)
 		return NULL;
 
-	return load_commit_graph_one_fd_st(graph_file, fd, &st);
+	return load_commit_graph_one_fd_st(fd, &st);
 }
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
diff --git a/commit-graph.h b/commit-graph.h
index e4f17071e2..36d8109901 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -54,8 +54,7 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
-struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
-						 int fd, struct stat *st);
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
-- 
2.21.0.360.g471c308f928

