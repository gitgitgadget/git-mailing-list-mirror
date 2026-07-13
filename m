Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47D43C054
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961057; cv=none; b=Dk296QXtGAU9TZRqOgK7mHaGejW92wcDURV0kCYUpn/Bh/gfuYCDRyrXmoFCc/X4PNqYA/0cLjZn5T+ItvVxhWGrxMwMLiW3rhUaob1/VJPvZMODruAT+GNmDhJpjqjdMrTSIicjFu0v33IlrPqbJHTJwOmLSyTjMpKEpbMSQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961057; c=relaxed/simple;
	bh=dHJ5v+flstXJg1b4fiPgGpXAxz73aDHe48Jklc6zTcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elOLQCcyMZqXtZAHj9LEbhoNc8NFcFCsZxtxZs4mAcHcAaTzI5omrnX8lMDeITafq8mitrYmmPtJFUfEBQnA+Mio5xfykWhBxGnWV+Xb6AzpaG/uxWHx2P0magjDhqu9X7QsRixlDW3OfaqTX1AchhbGBlYmiyHl0Fnl/2W3QNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1LuBKNa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LuBKNa"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f60208a5so29362245e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961054; x=1784565854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=l1LuBKNahH/QRgudky+0b4RimHLNoo47bpHYWW/4XShArfMetj+2MaHls6cZ1uwetN
         nTLoqrU3sB8utTIVh5q4/Fe7/r1PI5TvdDSzU/Ct02zq8QOZ9QuaAasGGBLYf2TCcI4W
         WiKHXFWMhfEEckCCqKAA8NMN/E8E8YN3YgmpL12tbABjBOr+3o9HCmOXJQ/zYBH1sP2u
         XNMav7zz0Ll2Kix3Bw6GjMJsefVDGPnGLpA0UrQJZPn+jkP0SV8dbyzvaaXdhHyLTLlx
         oEvT7oJvbqxtwcHfAtxirkT5Z8XdchmXrWEuBTs27eweOfRgQEMu31MO+a9Vvet7RxFR
         +uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961054; x=1784565854;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=LCh30Z+Ema2cKagqp18P2FFoj2cCYl/4xtFEF20o9+kT9DyycEUECjnmPkv2TCZrAM
         om6GiOzxd34rfJ0ImCFn1PWiZk3m/y8QgAQxRpVZgtASVmQ9WGHUgGDq3PZwM793sZ7I
         /leyueY1s/02770XUaMJdad2Heke74J7lBWrNXKbjv2qaSuR7MilQKt5/DYsswuRjzZa
         +cVmQQdRF5VkhYSMOztwqqfW+/8vN13b/JZYqoEjcT+aLTPC7XiMTLplbEIEKd/42yiJ
         /tRn547Sqd+LVOq/dHcMd53JyaVYnnazIkPyFy45GA0HBWD1d3GiyYzQ6lTLGdiVkzPo
         IFDA==
X-Gm-Message-State: AOJu0YzuMqUXTvWExzzav1k9LwtTf7hcx05jjHNhPcEmILZdyvMDx+PJ
	90694n+bXDJMBPq2j/CxFgb0ktTgUmx67qJBDSzVtq1zbdMp4s0x2tVitBj0Imp2
X-Gm-Gg: AfdE7cntTKmbxNGUTn+rVvTCD3e5JhgZUMPx9MOlvuSsox2hKlyasxjUoENv346PreU
	bZ1YAgBNuI4Elx7fIyYZHNKk9KWUYILkNyP0v41pECvPZ2W9SZUA1hYWDlBQlkg3qNw+NwcV8ZW
	Ikpux/bNoNptjke6ijfGqOfc8JJ5s6VHOiyZIw/nbHPL3UmmGPgm76V4jjGeFtRvIGdEler5jMF
	fK/7G0zm4uQjAUytwjMlk/4WUU37qSatImxj05WJCuPdW7PosD9pjKPBdGJ95I+JbStlLw//Mkl
	5uOC1Aa9pTK0K6IfEHvGdVP+uuu1dNHo0QPNfaEl21XxWeJMMwsKbhTPGtjGzxtxD3CuwfOm/U1
	ORT4ePL5SUmOqSocm/oKzDGZGfdWjAwjZDHxFqbJA6fSMoX7h2zlRmT6jnvsdbtFWp/oN6f0IFL
	qgVCNDINxaOCHKCiXnmWpAS0xN4O9UUze8SPMfhC81/gjaIBZijrQ6ZrGLWNXEKKAZf+nr9ipXJ
	SVPRt13NCCwQbyy3NBfVQvg+Roi8ke4De/TOCTge8r3xnFjCBBFiX2JV1M3AdSY0MGb3odQYMHM
	s0GXkU60/Kph2/nO7ontnS3Hk8cg0W4YIyLG5XxVGrWTER5zcWlMvqtfDKHrXSBxY6Wo/PEXYEb
	8QdoJZNG9iU/Xv5jkKyid
X-Received: by 2002:a05:600c:314a:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-493f8818d5dmr105506455e9.23.1783961054188;
        Mon, 13 Jul 2026 09:44:14 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:13 -0700 (PDT)
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
Subject: [PATCH v11 6/7] graph: move config reading into graph_read_config()
Date: Mon, 13 Jul 2026 18:44:03 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-6-dcb65bc4ba99@gmail.com>
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

Move the repo_config_get_string() call out of graph_init() and into
graph_read_config(). This simplifies graph_init() and provides a
function for future graph-related config opt.

This commit is a preparatory commit for a subsequent one.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index e3e206170c..c14be934a0 100644
--- a/graph.c
+++ b/graph.c
@@ -417,13 +417,11 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 		diffopt->output_prefix = diff_output_prefix_callback;
 }
 
-struct git_graph *graph_init(struct rev_info *opt)
+static void graph_read_config(struct rev_info *revs)
 {
-	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
-
 	if (!column_colors) {
 		char *string;
-		if (repo_config_get_string(opt->repo, "log.graphcolors", &string)) {
+		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
 			/* not configured -- use default */
 			graph_set_column_colors(column_colors_ansi,
 						column_colors_ansi_max);
@@ -437,6 +435,13 @@ struct git_graph *graph_init(struct rev_info *opt)
 						custom_colors.nr - 1);
 		}
 	}
+}
+
+struct git_graph *graph_init(struct rev_info *opt)
+{
+	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+
+	graph_read_config(opt);
 
 	graph->commit = NULL;
 	graph->revs = opt;

-- 
2.54.0
