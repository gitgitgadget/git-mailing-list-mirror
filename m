Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF622083
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656688; cv=none; b=JYGzBwhnXi8tc4mLarAUvTaJ8wZSnB4DHivM9zO664Lv/lPhH9mo3C1rOkvjdqr9Qdmxvd4por5WmWe5y2gZyoCzG2n0vW7hYvJd96m+APOz6JJku9Q/i44vhQgEK+YQce1FJy6jclO69VscALtkNDmXNtg8EYqR+xkAx39nXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656688; c=relaxed/simple;
	bh=e6ENhnSXk5UpP39K8MxuoCNRyeab129uBD/g+PwqEYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9M5r8dsIWQb53UHEXhBmOdnfHVOWwdKLcoWi6x2bV72n8l8fcBWx1870Dk4bkNm1txUa5YtoFPCsYxYgd1dsxmXlRrTSJizFreA///ta8IEgD/ejVNQ+cbyWM2KeRwubnBevLvBLZsUogPCUXTQS6cEiRPPzSmoufMKG4Qz+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKbOYJou; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKbOYJou"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so33338775e9.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774656685; x=1775261485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve0dfqs6KIm+n/GNQDHIUopK6SDwQSg4mxoKsCNQDeE=;
        b=WKbOYJouCF7jAZUJlE0nq0TEeydCR1XtAGk4ySMHq2cqaRUpkytCIDmaDVFRv/GAnT
         APXhtREhzsiVYzg5pv6cbrYRpPvJ8/R6LpP/12ty9KtiiKxoAcEJ4g4JLMW4qhJVzqU2
         hsGg0vpq/AnJveFoI4yW+puRryA9nbRBPORtKxTaoRb8JHERLEDIf1MQSJR6WibEYTjd
         6AtETkjp3EfWvWLtFzU+WFoBeX/DpPmWbzEjzoMtpP0xqVr+9W1Y0vh3LFacOYV7Jrc8
         xsx/fvxUBklI4ahJx+UFzd2DpFpvqndVDOQ133v3vuh4l6/nVVHTpaCcKkVppi/f6fli
         vSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774656685; x=1775261485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ve0dfqs6KIm+n/GNQDHIUopK6SDwQSg4mxoKsCNQDeE=;
        b=PvHjPtwjd7tStwUbNzuZzoXx+kz/rDY0Pf9feK0IdexTB1611ykr3E0cn2PyGAsjyh
         /UfOIXscUMCYutUzMINW25WxIlQRglRj6tsV33LGRH9obH+n/6XOGonDGbxhyzB/8OBL
         IeIZTstU/loYeWzdd+/fodxZBctHY7s1UEXCc/Geor0rhj5bJJBnETmcUUFkWR3HjI5w
         RM54uvbG4EsXRCgZAM3m+BE8R/zKCvdGRrrVcCu4NO4/lRbkghrl63wywfszSdMfvsYq
         ugBiapEcjB6/fDFSiwimXAPZ/5DIAUe2TtCirOaD26Vxahla6+AUeuzk/A8m1hM/TDy2
         S1/g==
X-Gm-Message-State: AOJu0YzZkag5MSlGRf8YTFI/LumPt99aQcHeuD0eemcE3udt1ezOlslq
	6bMVczFXRs9AryEIBYkwdVrfaKKQMrWVV6rNJdj7GioUt+wz0zpYFPV91LxK1FqzTkY=
X-Gm-Gg: ATEYQzxcT85TyBhSQ6qb5zUEG2EODrDOWI12TfTUKn58WVX7JbqAUzoeEeYZKeb3FFl
	MmaES0JCcY+hLFJ+/pkYpVVCic1nHjpx35x/3RpMvqxBMG6wLc1hQ82DWeBJuVrfb9SiTM/5enA
	co3XYJBtA8G0nADZwyBgz9K6YTyzpdkp+AhgtuVuEMp8vQX++YFDlSPzomJ4Atx06l62ehFpJLj
	IQ9RlTpu+Taw8LAYl5CtMTVIw4YYtDbEXRHU+wnOhmmbPFmle10Dunp8c+wTeaEgzu9Mggc/t6e
	XV9o4tUARykOVuoCDqdmJYKmN/1h6L/e3PgD6LMhEG/GN7EOVfIYAg0eJ+bdo256B5W6WdwMjGA
	LS1nUt59YUetmH7RWG0mWGYV9gg/3SZL4KIMp8mInE7MHb78I2EG9l+ObrbTREaZDIR256UhyyO
	Yczu/DUsbD6ENKNZ08bCJ/k87KBLmYxjh01fkU8LaL6V47V4oV5ODGtySaCMcBUbfGtAMYYWpSR
	LUebrQMhdwdfcjmb8PH2GP0bxIQWOv7LudH0LubuRsZZNtLDiX5uZvt538=
X-Received: by 2002:a05:600c:c086:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48727d7355fmr60931575e9.11.1774656684573;
        Fri, 27 Mar 2026 17:11:24 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm116147635e9.10.2026.03.27.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:11:23 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v6 3/3] graph: add truncation mark to capped lanes
Date: Sat, 28 Mar 2026 01:11:13 +0100
Message-ID: <20260328001113.1275291-4-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328001113.1275291-1-pabloosabaterr@gmail.com>
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lanes are hidden by --graph-lane-limit, show a "~"
truncation mark, so users know that there are lanes
being truncated. The "~" is chosen because it is not
used elsewhere in the graph and it is discrete.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 ++-
 graph.c                             | 22 +++++++---
 t/t4215-log-skewed-merges.sh        | 64 ++++++++++++++---------------
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 1b6ea89a63..937ffc6195 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1261,8 +1261,9 @@ This implies the `--topo-order` option by default, but the
 
 `--graph-lane-limit=<n>`::
 	When `--graph` is used, limit the number of graph lanes to be shown.
-	Lanes over the limit are not shown. By default it is set to 0 
-	(no limit), zero and negative values are ignored and treated as no limit.
+	Lanes over the limit are replaced with a truncation mark '~'. 
+	By default it is set to 0 (no limit), zero and negative values
+	are ignored and treated as no limit.
 
 ifdef::git-rev-list[]
 `--count`::
diff --git a/graph.c b/graph.c
index ee1f9e2d2d..842282685f 100644
--- a/graph.c
+++ b/graph.c
@@ -706,11 +706,11 @@ static void graph_update_columns(struct git_graph *graph)
 	}
 
 	/*
-	 *  If graph_max_lanes is set, cap the width
+	 * If graph_max_lanes is set, cap the width
 	 */
 	if (graph->revs->graph_max_lanes > 0) {
 		/*
-		 * Width is column index while a lane is half that.
+		 * width of "| " per lanes plus truncation mark "~ ".
 		 * Allow commits from merges to align to the merged lane.
 		 */
 		int max_width = graph->revs->graph_max_lanes * 2 + 2;
@@ -868,8 +868,10 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		if (graph_needs_truncation(graph, i))
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
 			break;
+		}
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -928,6 +930,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
 		} else if (seen_this && graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
 			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
@@ -1025,8 +1028,10 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 		 * Commit is at commit_index, each iteration move one lane to
 		 * the right from the commit.
 		 */
-		if (graph_needs_truncation(graph, graph->commit_index + 1 + i))
+		if (graph_needs_truncation(graph, graph->commit_index + 1 + i)) {
+			graph_line_addstr(line, "~ ");
 			break;
+		}
 
 		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
 	}
@@ -1070,6 +1075,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
 		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
 			seen_this = 1;
 			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
@@ -1203,6 +1209,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				    j / 2 + i <= graph->num_columns) {
 					if ((j + i * 2) % 2 != 0)
 						graph_line_addch(line, ' ');
+					graph_line_addstr(line, "~ ");
 					truncated = 1;
 					break;
 				}
@@ -1214,6 +1221,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 					 */
 					if (graph_needs_truncation(graph, (j + 1) / 2 + i) &&
 					    j < graph->num_parents - 1) {
+						graph_line_addstr(line, "~ ");
 						truncated = 1;
 						break;
 					} else if (graph->edges_added > 0 || j < graph->num_parents - 1)
@@ -1228,6 +1236,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
 		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
 			break;
 		} else if (seen_this) {
 			if (graph->edges_added > 0)
@@ -1388,6 +1397,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		int target = graph->mapping[i];
 
 		if (!truncated && graph_needs_truncation(graph, i / 2)) {
+			graph_line_addstr(line, "~ ");
 			truncated = 1;
 		}
 
@@ -1487,8 +1497,10 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
-		if (graph_needs_truncation(graph, i))
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(&line, "~ ");
 			break;
+		}
 
 		graph_line_write_column(&line, col, '|');
 
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index d7524e9366..1612f05f1b 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -376,9 +376,9 @@ test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
 	|\ \
 	| | * 7_G
 	| | * 7_F
-	| *   7_E
-	| *   7_D
-	* |   7_C
+	| * ~ 7_E
+	| * ~ 7_D
+	* | ~ 7_C
 	| |/
 	|/|
 	* | 7_B
@@ -389,16 +389,16 @@ test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
 
 test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge' '
 	check_graph --graph-lane-limit=1 M_7 <<-\EOF
-	*-  7_M4
-	|\
-	|   7_G
-	|   7_F
+	*-~  7_M4
+	|\~
+	| ~ 7_G
+	| ~ 7_F
 	| * 7_E
 	| * 7_D
-	*   7_C
-	|
-	|/
-	*   7_B
+	* ~ 7_C
+	| ~
+	|/~
+	* ~ 7_B
 	|/
 	* 7_A
 	EOF
@@ -411,24 +411,24 @@ test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
 	| | *   7_M2
 	| | |\
 	| | | * 7_H
-	| | |   7_M3
-	| | |   7_J
-	| | |   7_I
-	| | |   7_M4
-	| |_|_
-	|/| |
-	| | |_
-	| |/|
-	| | |
-	| | |/
-	| | *   7_G
-	| | |
-	| | |/
-	| | *   7_F
-	| * |   7_E
-	| | |/
-	| |/|
-	| * |   7_D
+	| | | ~ 7_M3
+	| | | ~ 7_J
+	| | | ~ 7_I
+	| | | ~ 7_M4
+	| |_|_~
+	|/| | ~
+	| | |_~
+	| |/| ~
+	| | | ~
+	| | |/~
+	| | * ~ 7_G
+	| | | ~
+	| | |/~
+	| | * ~ 7_F
+	| * | ~ 7_E
+	| | |/~
+	| |/| ~
+	| * | ~ 7_D
 	| | |/
 	| |/|
 	* | | 7_C
@@ -452,9 +452,9 @@ test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows fir
 	| | | | | * 7_J
 	| | | | * | 7_I
 	| | | | | | * 7_M4
-	| |_|_|_|_|/
-	|/| | | | |/
-	| | |_|_|/|
+	| |_|_|_|_|/~
+	|/| | | | |/~
+	| | |_|_|/| ~
 	| |/| | | |/
 	| | | |_|/|
 	| | |/| | |
-- 
2.43.0

