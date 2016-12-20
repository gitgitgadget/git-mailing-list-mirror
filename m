Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF351FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933766AbcLTMjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 07:39:37 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35868 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752032AbcLTMjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 07:39:35 -0500
Received: by mail-pg0-f67.google.com with SMTP id w68so5784093pgw.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 04:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7bLrB7o5Xcl00utqAzEFVtmCiQ1/88C9YLpVkbwtbs=;
        b=Vb+R0i6VBqkN1rS+opgS6mZffCeIPR8hhvJWBccAupAAu+tuVH+iUt1AMnxQ0ZlSrg
         NuarBQl7Aj6drHeOoij/XnE5mVyxmOkp+1WPrr+1RMJWVXC8rP7G3fBHwGl4coSur1SF
         qCtFxMVJ7fQDgvZ6fHbZZWCBTErE2HQVKxGgotzMojvNLZSX4xzCFPEwpefz+bb/Jy9k
         klEdHyOiaLkB0VfXmSPvKNHvK7l5ZAbQXWrWU5nKTHhfzlatmYrJKgbE/FM0RnUTSXap
         Dx3Sawx79aWV7BMkfrEb15M2270ySFIF488kUWq5Pw68Q3fJQZmslA4FKqBwlPnuiqt3
         u9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7bLrB7o5Xcl00utqAzEFVtmCiQ1/88C9YLpVkbwtbs=;
        b=gKVWi2o2gsjD1K3lGMdhPIJIUHq0PjMJ87ljcSUj9LXSVb6H7Qxv2rpvbTNfVTHWX5
         XmbUNbUV1RSwKMHg1OZBerFfrkbYR8BAlQoAGKBrSbRc8X1dv8CEnEipfL0qjCLxftYy
         trQ+ajYqpBuh/piJugwYuTilwrwVcKQm8H7rwEOpaG3YIpKOqxDME3//TPzabZSN52Aa
         2LZewSn/xxr5UOZ5ovlLqzM3PTdjCDP7lX0UXeIbJfMsRB/lEK57eK4ge0i0creb72lY
         5Mf7YjiVg43oQmb9Vf5/+dE8hP2r0cSMyk7grXKGwrDmUyuz+qqDb/ytaHFYT3yVM048
         pfvQ==
X-Gm-Message-State: AKaTC0133g4gRZbOauiVdAoHPhRjQz25xVNwRIsqGUQqX+V86sqYrn18uhQHpSp55qkCAA==
X-Received: by 10.99.166.2 with SMTP id t2mr35902447pge.40.1482237574862;
        Tue, 20 Dec 2016 04:39:34 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id u23sm39021595pfg.86.2016.12.20.04.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 04:39:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 20 Dec 2016 19:39:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] log: support 256 colors with --graph=256colors
Date:   Tue, 20 Dec 2016 19:39:29 +0700
Message-Id: <20161220123929.15329-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I got mad after tracing two consecutive red history lines in `git log
 --graph --oneline` back to their merge points, far far away. Yeah
 probably should fire up tig, or gitk or something.

 This may sound like a good thing to add, but I don't know how good it
 is compared to the good old 16 color palette, yet as I haven't tried it
 for long since it's just written.

 BTW anyone interested in bringing this type [1] of --graph to git? I
 tried the unicode box characters, but the vertical lines do not join
 with diagonal ones, making the graph a bit ugly (even though it's
 still better than ascii version)

 [1] https://github.com/magit/magit/issues/495#issuecomment-17480757

 Documentation/rev-list-options.txt |  5 ++++-
 graph.c                            | 31 ++++++++++++++++++++++++++++++-
 graph.h                            |  8 +++++++-
 revision.c                         |  4 ++++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5da7cf5..0a0c2f3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -825,7 +825,7 @@ you would get an output like this:
 	-xxxxxxx... 1st on a
 -----------------------------------------------------------------------
 
---graph::
+--graph[=<options>]::
 	Draw a text-based graphical representation of the commit history
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
@@ -836,6 +836,9 @@ This enables parent rewriting, see 'History Simplification' below.
 +
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
++
+The only supported option is `256colors` which allows more than 16
+colors for drawing the commit history.
 
 --show-linear-break[=<barrier>]::
 	When --graph is not used, all history branches are flattened
diff --git a/graph.c b/graph.c
index d4e8519..75375a1 100644
--- a/graph.c
+++ b/graph.c
@@ -78,6 +78,7 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 
 static const char **column_colors;
 static unsigned short column_colors_max;
+static int column_colors_step;
 
 void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
@@ -234,10 +235,24 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 }
 
 
-struct git_graph *graph_init(struct rev_info *opt)
+struct git_graph *graph_init_with_options(struct rev_info *opt, const char *arg)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
+	if (arg && !strcmp(arg, "256colors")) {
+		int i, start = 17, stop = 232;
+		column_colors_max = stop - start;
+		column_colors =
+			xmalloc((column_colors_max + 1) * sizeof(*column_colors));
+		for (i = start; i < stop; i++) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "\033[38;5;%dm", i);
+			column_colors[i - start] = strbuf_detach(&sb, NULL);
+		}
+		column_colors[column_colors_max] = xstrdup(GIT_COLOR_RESET);
+		/* ignore the closet 16 colors on either side for the next line */
+		column_colors_step = 16;
+	}
 	if (!column_colors)
 		graph_set_column_colors(column_colors_ansi,
 					column_colors_ansi_max);
@@ -382,6 +397,20 @@ static unsigned short graph_get_current_column_color(const struct git_graph *gra
  */
 static void graph_increment_column_color(struct git_graph *graph)
 {
+	if (column_colors_step) {
+		static int random_initialized;
+		int v;
+
+		if (!random_initialized) {
+			srand((unsigned int)getpid());
+			random_initialized = 1;
+		}
+		v = rand() % (column_colors_max - column_colors_step * 2);
+		graph->default_column_color += column_colors_step + v;
+		graph->default_column_color %= column_colors_max;
+		return;
+	}
+
 	graph->default_column_color = (graph->default_column_color + 1) %
 		column_colors_max;
 }
diff --git a/graph.h b/graph.h
index af62339..8069aa4 100644
--- a/graph.h
+++ b/graph.h
@@ -40,7 +40,13 @@ void graph_set_column_colors(const char **colors, unsigned short colors_max);
 /*
  * Create a new struct git_graph.
  */
-struct git_graph *graph_init(struct rev_info *opt);
+struct git_graph *graph_init_with_options(struct rev_info *opt, const char *arg);
+
+static inline struct git_graph *graph_init(struct rev_info *opt)
+{
+	return graph_init_with_options(opt, NULL);
+}
+
 
 /*
  * Update a git_graph with a new commit.
diff --git a/revision.c b/revision.c
index b37dbec..07bea54 100644
--- a/revision.c
+++ b/revision.c
@@ -1933,6 +1933,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->graph = graph_init(revs);
+	} else if (skip_prefix(arg, "--graph=", &arg)) {
+		revs->topo_order = 1;
+		revs->rewrite_parents = 1;
+		revs->graph = graph_init_with_options(revs, arg);
 	} else if (!strcmp(arg, "--root")) {
 		revs->show_root_diff = 1;
 	} else if (!strcmp(arg, "--no-commit-id")) {
-- 
2.8.2.524.g6ff3d78

