Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7128409611
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679870; cv=none; b=tXYCXABR4LP5oqauanKaLk1H6oVB17h/vbzNlLl5bP1NbA03ncz3yO2I1y/wsahCHZ3sMfnPjnntYN80Ys3NyIpqJmlelgXrgyKRB2K7GztvJPuE9nu41kwLk/EGF3EXfZG9oYfjmCF+pYanpYs0QqUKY1ZDSmbERObvGsQpBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679870; c=relaxed/simple;
	bh=jUhovxAa5ZxXxbm/qdyjXPPY4tfsgeqkKDolY0Tc34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMUxKjwc6adHrmtlwPO0QRWsR5D/KLdvR0OK0f1e9B62mYAtkDrVEgNjw+sUtk0tp/nKPhFTjR/mpV26wjR9Y7cvtlv0sWHlLBES6R4ormL7q8kTH+0FzjaRTorHNdbzhGsi/Sc+QCqQ1qsS0sGS1i1S6+pEcuSgZK5axiTDOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGbWjCks; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGbWjCks"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-476a130c138so1014455f8f.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679867; x=1784284667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=GGbWjCksTB70+SdhKttPoaoulT8liU4nvDpOh18AWPLEEAREFz7zWOpgxOYjCPip9L
         ySHDksJdlc0MECaBOn41xkDioQkTYZIbIftIp1auMy1YheOUC+p3pgWDWlJfzrOQpemg
         XpWfpsvpclsY49YfoMbHKJPHRpnRNlKH3/wQmJFIdHD0n4NC/Zn/D/rrWFm+pzxik9dn
         zrCu6kHMN6yzLt7PKZGeiGxeWhwFEXZCECQ9V8dWLz6zbqnmYV5gjQQRBCFJhvggg3PF
         KDb2RAaLHW9snR7MVciL/pApDV4gC0IF4D3jCoOpdmYMTJP8pLnXeQ/DDtFcB/3Fe7Ky
         hHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679867; x=1784284667;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=cGy9ul9zJEsa3VR9yiHsbBBus/4K9glx6ZkmcSJZ3eC7uv/ldBYMpZsR5eOYroUPNw
         GoO8EVBhJe/tgfJn8+VAEqy6uQqfn5s0lVygrB2Omt6hnLpjhjoxyjm7s4UNzPYA27Jf
         kCfrzFu/MrrT/EB0XDmolMWtCpyIb4dU5/PFNjOcn+7Nf//NyuuqZQVre7kmZkdw6we7
         cV+ZF38KbmliuodMau9SixOSK0dvE32cmyY+HpxY8sIEUJX1D5YeGmfups1weXtyqu/C
         jArKGEA8AKFl3GRzjhtRk0ssTEdkGBo94JFScuXEmGdOSr7eYWiqb/nlCn39R3/m50JG
         W6Ew==
X-Gm-Message-State: AOJu0Yxa55pfFUM7zTnx4PzeZZ0nB81dlrclN/LgxxIyoyimzsj2Gytz
	ytib+2R8gRuPZVDFkl5D6MDrBzX6jM6E0OfKAhVn6MCmU1k73zfoNLOwiUwhyX34
X-Gm-Gg: AfdE7clXFqj656hnjyh9rISEO3+d8t2cIT3HLhiZaSpyI172Tc3ihMBP3X6Zf41P5Xj
	GdzkaWv/9xQf5fnatsTBhxR/oxprHKum9JhGG/+7YZqL7cG1V+LK9idFdPYsT7ISHfzjCAG0Q5k
	UO7iPos/9LDAJVgJE0Aj3ACmp13Bq3JuymeCjnPa5A6kQXuO2em/nk6o23ljB+ooyHZaHoqxWmO
	KsqGSbtYkGQkAxCjvASmRxaWY0kQlw+SheonzLPb1c6iDnEGw68XnjgUKyj0X7Cgyb7TwJVG7br
	L+4LEw4buXpKcFSaOKrrAMWUrPxaJqj+Jx8chyoT8YPlhVO3DrVC/kc1A0s3zUHvSoBfvsElmVc
	dJz+0CYtiZoljskKglB/Y3DR/fVbZE2piJ9mhxOL5J0Bna6MuZe//OEFqsVv4edRldHY989CpQK
	0PqFQK/8Qg+vHilz6FPX3pM9x0ZHp2SSYGopFxK0To79VyV73kYRyUTfwjpVr1oWWrE735UnTab
	YuEleb51Kzuz32de26yEZMwy0jj96YJyhvO6JOlBfGGJCgxuU1wtceYvtuwv6BwTLvKJO+yWjZM
	ptduY3pu40XyRurVqlTy8KdhFDCsBQPaM/AWwaBmDXj6hQPIh2x9Q2G0oicHeDNW7i7AfqHjU5n
	74taSVt8SKQ==
X-Received: by 2002:adf:f04c:0:b0:47d:fc45:ab38 with SMTP id ffacd0b85a97d-47dfc45ab64mr3518535f8f.40.1783679866795;
        Fri, 10 Jul 2026 03:37:46 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f25b23b7esm4222784f8f.18.2026.07.10.03.37.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 03:37:46 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	mroik@delayed.space
Subject: [PATCH v8 3/4] graph: add a 2 commit buffer for lookahead
Date: Fri, 10 Jul 2026 12:37:06 +0200
Message-ID: <20260710-ps-pre-commit-indent-v8-3-d3b636463bf4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
References: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In a subsequent commit the graph renderer needs to know if the next
commit is a visual root or if it is the last commit to be shown. This
requires peeking 2 commits ahead.

Commits are pre-fetched in get_revision() through next_commit_to_show()
where they are also marked as SHOWN, regardless the source they come
from.

Update graph_is_interesting() so it considers commits inside the
lookahead buffer as interesting as well.

Helped-by: Kristofer Karlsson <krka@spotify.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 graph.h    | 17 +++++++++++++++++
 revision.c | 18 ++++++++++++++++--
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index 842282685f..89ebcf7540 100644
--- a/graph.c
+++ b/graph.c
@@ -315,6 +315,14 @@ struct git_graph {
 	 * diff_output_prefix_callback().
 	 */
 	struct strbuf prefix_buf;
+
+	/*
+	 * Lookahead buffer: up to 2 pre-fetched commits that will be shown.
+	 * Populated by get_revision() so graph_peek_next_visible() can use
+	 * actual walk results instead of peeking at rev_info internals.
+	 */
+	struct commit *lookahead[2];
+	int lookahead_nr;
 };
 
 static inline int graph_needs_truncation(struct git_graph *graph, int lane)
@@ -388,6 +396,9 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->lookahead[0] = NULL;
+	graph->lookahead[1] = NULL;
+	graph->lookahead_nr = 0;
 	/*
 	 * Start the column color at the maximum value, since we'll
 	 * always increment it for the first commit we output.
@@ -456,6 +467,15 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
  */
 static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 {
+	/*
+	 * Commits in the lookahead buffer have been pre-fetched by
+	 * get_revision() and will be shown in the future. They already have
+	 * the SHOWN flag set when they were pre-fetched but the graph still
+	 * needs to treat them as interesting parents.
+	 */
+	for (int i = 0; i < graph->lookahead_nr; i++)
+		if (graph->lookahead[i] == commit)
+			return 1;
 	/*
 	 * If revs->boundary is set, commits whose children have
 	 * been shown are always interesting, even if they have the
@@ -763,6 +783,37 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
 	       graph->expansion_row < graph_num_expansion_rows(graph);
 }
 
+struct commit *graph_pop_lookahead(struct git_graph *graph)
+{
+	struct commit *c;
+
+	if (!graph->lookahead_nr)
+		return NULL;
+
+	c = graph->lookahead[0];
+	if (!c)
+		BUG("lookahead buffer has %d entries but the first one is NULL",
+		    graph->lookahead_nr);
+
+	graph->lookahead[0] = graph->lookahead[1];
+	graph->lookahead[1] = NULL;
+	graph->lookahead_nr--;
+	return c;
+}
+
+int graph_get_lookahead_room(struct git_graph *graph)
+{
+	return (int)ARRAY_SIZE(graph->lookahead) - graph->lookahead_nr;
+}
+
+void graph_push_lookahead(struct git_graph *graph, struct commit *c)
+{
+	if (!graph_get_lookahead_room(graph))
+		BUG("pushing into lookahead buffer when it is already full");
+
+	graph->lookahead[graph->lookahead_nr++] = c;
+}
+
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..1193711fb8 100644
--- a/graph.h
+++ b/graph.h
@@ -262,4 +262,21 @@ void graph_show_commit_msg(struct git_graph *graph,
 			   FILE *file,
 			   struct strbuf const *sb);
 
+/*
+ * Pop the first commit from the graph's lookahead buffer.
+ * Returns NULL if the buffer is empty.
+ */
+struct commit *graph_pop_lookahead(struct git_graph *graph);
+
+/*
+ * Returns how many more commits can be added to the lookahead buffer.
+ */
+int graph_get_lookahead_room(struct git_graph *graph);
+
+/*
+ * Push a commit into the lookahead buffer. Must only be called when
+ * graph_get_lookahead_room() returns > 0.
+ */
+void graph_push_lookahead(struct git_graph *graph, struct commit *c);
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index 288935943f..258c3cf782 100644
--- a/revision.c
+++ b/revision.c
@@ -4715,10 +4715,24 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	c = next_commit_to_show(revs);
+	if (revs->graph) {
+		c = graph_pop_lookahead(revs->graph);
+		if (!c)
+			c = next_commit_to_show(revs);
+	} else {
+		c = next_commit_to_show(revs);
+	}
 
-	if (c && revs->graph)
+	if (c && revs->graph) {
+		while (graph_get_lookahead_room(revs->graph)) {
+			struct commit *next = next_commit_to_show(revs);
+			if (!next)
+				break;
+			graph_push_lookahead(revs->graph, next);
+		}
 		graph_update(revs->graph, c);
+	}
+
 	if (!c) {
 		free_saved_parents(revs);
 		commit_list_free(revs->previous_parents);

-- 
2.54.0
