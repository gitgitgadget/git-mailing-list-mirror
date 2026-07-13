Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD343CECA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961054; cv=none; b=Wk01LlHSnkAIKceDRhi8P9Rm5JU7eWqPJ5r0TxI96W1LMDZHfS7BaHDbU7EKYX1kGsE2IdkFojfles7HyxfT3OiuN9+qGxRQaj+DcUoamWxQAZtRy+GRmPeDdPdycf5lCXrK9EDRjHWO5E2j5iTha3lT/8A2aitdzNrDOGxMr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961054; c=relaxed/simple;
	bh=jUhovxAa5ZxXxbm/qdyjXPPY4tfsgeqkKDolY0Tc34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCYYoIBUG7oFZkXeqDrEw/mFmg8NoZpO8O5Zkms93NJGIoOYuAQbzFk3BYFMFLYOH2huhGW1ejfzLS4CQcGZSFEewkCiUBMWZcoT8krXNwXSiGgziH/Hk4ESmXd0IYfTHjCRx5xuRzmvXG0JN37XvJI8vKpwtZ7/PfK/QqaFTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aph7xfC2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aph7xfC2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b779003fso14905355e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961051; x=1784565851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=Aph7xfC23dEKHENDtU08KeaV6mrvrhNBD8iQh+S5qr8LP9JcUguGmXzLrrb6OwSyzy
         ympQ5k3ucb2NJCMRsuEygPypvlVSgfOIeQlZynkxRsBlVkuowPsQX4qIIbPRi7gpxWlm
         Xznq0QPDz3EOG4XE8m/cxKr92QQ0t4rgEjeYE+3jQEW52pwFkh6PRqCOL/G9yPZzXQ+y
         oACBJ2k11Kuv/VoZraDfMXOQQgOgMqrM9c6v42SRhyzGhpBmPOg1T5ebYX6ImSOrAQyw
         Hj3BpmZMoPe/32PTFDM2vPEPPMYtuNvNyThwJoRX2xyhGGgop8con2++GB05NKjwThUd
         W1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961051; x=1784565851;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=ag3rNEdXDCz6pGWCKL7YqvSUyYmEqvHXHvPbAMsWNZh0F9m5YO5WdoDnOq6u2Oce13
         gkPpuYB+GtXN4U9NVd6hEfWrjzHUQkQVsBIYCSHlZXHRdSgknvEWQED2MrjLBchfIgSJ
         uhUkCdYXxxCaYSgK7RxtLAe79h/3wHuZebSqgLsfxz3CPwkS6L6qV6+mHAr7pV5EKzu0
         k9QbJ6rrRFmr8YF3WKAbhsimI77JoElOyjfpCO3GO4FzkmYAZfLwtuN0R6Rkb8Zox9Sf
         f2Qrgh+hwMYTNTJ1RXZXjr6x6REnLCmuQaY/kq2SNL7Ao7+9x4Wa5elfz9VWuBL9RHqu
         8mXA==
X-Gm-Message-State: AOJu0YyT9vCSCraODf+ILzfrvalgxLQ8+m5kbisdsuw4zll+vj9P7rVl
	xxdWGpb3l4spZ7a+qFOEHA344JxY7l2jqcXCi+ujO2WAfUYNbeU7pmqpDpp5xneV
X-Gm-Gg: AfdE7ckVRuPlOb4BHvEYQ+rZns6/wmDZGYcjQ2tAFZRqS4BTEXn/LTugarG9INax2XG
	1zwKDWzQ5mfetay6TSRutB3cu52FlM3OAMzQhWcinOsYcmQvO6L/kbeycnaUZXmuwHrAodB71Vs
	VkG0GlvaevIapRrVQxaoJe45OlgX0alvjqIOVXRduirXZQheOBXVc5MHbyH3N2hJvv5ZuE7ghdN
	KyuipX5sFI2CbwIY2PkmcvvP+qZIIVRjovPvVAi4157Y8F2+ub1l5QfHjLrOLRYNxZMOCLctN0v
	rlLOwSeOLnxOLczWKLZyc+GwL3X7fOTr0kc2h3wQPphf3PWIjywLHzuQfkTKB/lU1Oo9Z5+QWgX
	H3AVgwPVfU14z+U8ebxE7zPKrTWuz3mzD4AbeJsP4rgws09JYJl8KQP/FPiGbPwV3IiHHQAYe4V
	CV9IqMWZUlBTs4SNubv7K3Ke0fN6ec0d3WiymIFRFtOfk+lyy3Nu9hllrLygEKV3zyAAUrmjeiM
	elmUIUwlz4CESxa+9AXHFVzj4Fty30pAvVLVZqRk5nLcRPSD4L6+RTOz9NGFv0HeraErNJTL0GD
	iDnHYamQSQCn2wXP3XgHyy8N9dOG4EMpgG8jljrHA6utHnAxaEMWBk2RqVsPqdk9QtOq7IAvgCr
	FJvrdhZj+gw==
X-Received: by 2002:a05:600c:821a:b0:493:e4ce:acd0 with SMTP id 5b1f17b1804b1-494688d099amr22302615e9.1.1783961050718;
        Mon, 13 Jul 2026 09:44:10 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:10 -0700 (PDT)
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
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 3/7] graph: add a 2 commit buffer for lookahead
Date: Mon, 13 Jul 2026 18:44:00 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-3-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
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
