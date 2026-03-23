Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C006381B0B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303186; cv=none; b=DAcp1kdklsB0nme4UntnrmLi88LFU3CwnAFtu6Al8O/tnWTKNZ0G9tYZz/jl+FFyCUsfTKKvxBkr5VdYWRrVu3vcdzYsIKyrFCvSuCB1IpIj2krFh7XOTdiHvjCR9gykUujufBT50JkLWHSo4lLjVtnNqp2bMIsgo3sT32KrQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303186; c=relaxed/simple;
	bh=nDgjs5Bvv6gr9RCezAFFG68/RibrO+hYbjqEQrR1ggU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8b/IrpMdUKf8CdpzsSGiB3/dN9vZHa7vIaIBj0xyoa6EktwGL4yropHEGGhg7WZTR3cZNz3GtTZkjlwl1Bc5rPxZrQKft03XDrMqE6lFOuXZ9Nt8rUqw6fYuO42ENoeBwraS0uwB+xB6p5C1W67E3clYafPqEr/mNqGDTiojVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdGSVA+9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdGSVA+9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso5670325e9.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774303182; x=1774907982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYmqJwYFJF9Rp8qXvDuOXchQpaP037HIPrvM9CaalxY=;
        b=WdGSVA+90T1dVh+Mbk4iPjB23JbjHXoDaJOqky1M5+Mpjnn9dSNya7ITxn8NRTok5p
         Rx3j+9KVcJDmZozorfKLzuUi9owjLJCP2nMNSW7kxGaacw9+O3wCw2k4pVOrZlvLPBlS
         TUgQ8zPmD9XDpRdPfgyNtxxYYalUdlI1KkYrY5hMdD/pHyHEtP/2lm2wdRKXsnF2UBkh
         35hneOv4fZf8WpeZQea9/vN85P+gkvhUpaqRV993QW7yU1+JWct5SQmdKlAPzgT0lLC0
         0/Nn6kyxoECqQE7CIwGFkLZ6z5vy+3fBNPdC5thO2Ry4uoTFkEjTskEKjZPT4k6aC+GS
         6h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303182; x=1774907982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYmqJwYFJF9Rp8qXvDuOXchQpaP037HIPrvM9CaalxY=;
        b=GKGfEnX7Pk3tBKAtuknGXvxbqQYlEMI3R7V4xoRXZcTLbvZmY6YdKg/utJxKWt5Zk4
         iYWkScnD6ZZMBhWIqKh7ntbVb1ncLXd4Sazg6zW9ZxiORUI5QGR1rza6H4R1YZX+aXcO
         2bquIPcG3z/SbPRJKaHDi6sFHKw/Qg9deZghd1xUMfJjrAlYD66igeblYUP2wrxto3jk
         3R1lT/6ARHnBKTbKj73Lys3/PkCYnNv044GQ5cPZpyf/KNrAlsW0Qmq3uH3joQ83UGJo
         KprX688GNTKDho3KW4OlTyAUJgmH297gwPN2dzOzgnev4/MwUdu9a66U10TRecgeftZl
         WMKA==
X-Gm-Message-State: AOJu0YwsrdOlMklhtSb7nxEUU+2FdLLu2SEzhuKGBckYBxMSnzJFbdqm
	o/VEbbboGwGz9eOmQusn3y40om6zJ044nOeBS6XsSn3RjoGr/U1eErqldtx2eFmlVpox6w==
X-Gm-Gg: ATEYQzw+hrh+2A90qS/bUKOcHRSyG0cMOvSouKt0LNvRIchCaOdk+66gAuLicLWnqmS
	WpwpWLuwLqQU6j65nHBObMWwOLaRaEwlhw3KMZxxvOGW3JphXByMoagZdbZnFpMOu9Js4TvdGOB
	uXcth3mcLnoUZmKZpsHy3njPrtAPv2YVZDwim2XbPFw3hMulW/lRjq2KYRK1vS0mticOuBwyKeg
	EA9nbgyrWNhfoUjNBaWSbJWo2IDMAMJjsEgr1buujEXk7eYRpkNu5X/mCwmAPcDHGR2Dcnko99x
	sLHp5kroqnCOQBKmcv+BqBs8IgK4vJAJ8FsRK03izzgCQI9+mjrbWIGGP0bIaRjwMY3os2rOoZw
	6/Mx0mUFZ4fn3gSGSOAGqfRbPVp5BsWlzu12cCxgNVpeQl1I/B6FNHeIXUTKBCc8+MUBOLcRYTk
	xUBwYFRFia9vF/Y3bzldGkhozGaC0cY2IJUGxuegsvjX+/4IeNm2NYBewLCaqB4AOm5r8xmEbO0
	7724UEWWhG5EA2hgXkB/nwaSiq10NLG+BnhqyfePmS9bwG2MbqQkfibAdw=
X-Received: by 2002:a05:600c:34d5:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-486fede7225mr178722405e9.6.1774303181807;
        Mon, 23 Mar 2026 14:59:41 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm2734015e9.2.2026.03.23.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:59:41 -0700 (PDT)
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
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v4 1/3] graph: add --graph-lane-limit option
Date: Mon, 23 Mar 2026 22:59:33 +0100
Message-ID: <20260323215935.74486-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323215935.74486-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time produce
wide graphs. A lane consists of two columns, the edge and the space
padding, each branch takes a lane in the graph and there is no way
to limit how many can be shown.

Add '--graph-lane-limit=<n>' revision option that caps the number
of visible lanes to n. This option requires '--graph', without it
a limit to the graph has no meaning, in this case error out.

Zero and negative values are valid inputs but silently ignored
treating them as "no limit", the same as not using the option.
This follows what '--max-parents' does with negative values.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    | 9 +++++++++
 revision.c | 6 ++++++
 revision.h | 1 +
 3 files changed, 16 insertions(+)

diff --git a/graph.c b/graph.c
index 26f6fbf000..e7c1151ac0 100644
--- a/graph.c
+++ b/graph.c
@@ -317,6 +317,15 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static int graph_needs_truncation(struct git_graph *graph, int lane)
+{
+	int max = graph->revs->graph_max_lanes;
+	/*
+	 * Ignore values <= 0, meaning no limit.
+	 */
+	return max > 0 && lane >= max;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
diff --git a/revision.c b/revision.c
index 31808e3df0..952edb031e 100644
--- a/revision.c
+++ b/revision.c
@@ -2605,6 +2605,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
+		revs->graph_max_lanes = parse_count(optarg);
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3172,6 +3174,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
+
+	if (revs->graph_max_lanes > 0 && !revs->graph)
+		die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 69242ecb18..874ccce625 100644
--- a/revision.h
+++ b/revision.h
@@ -304,6 +304,7 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	int graph_max_lanes;
 
 	/* special limits */
 	int skip_count;
-- 
2.43.0

