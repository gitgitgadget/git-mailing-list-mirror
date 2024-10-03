Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB4158DD2
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956734; cv=none; b=uEv8sn2VQQH/PV9stirztTA9tSIkjOf+QvRCZs8IuvzXpN+nzqLEmXdC4fDr6HnJM2K01e5AtX3cOp/aoZMsLMxyZRI8zfGoohU9/QH09BHB5C2wW7JDt1JHGmAF5zB/HHacM4ycrDLuwlnzecVYHZAgU6qchT9fqqz4il5IU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956734; c=relaxed/simple;
	bh=YLlQlYGH+wueuNmC4ZzbFWGcsjYxAmmR78vEpicFtBM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qf8Fr2H89NivhgeOz2vg+9rqEidoktOccyy26VBrhGR5VdeWXSUxvj1qCVlN4ai9EMZyEbyaQS7jDDVSP767PnZKYLA2csc5W/YRyscdkY9ZRU5SB9Ws6D8sDz7AA9ff5jLLCiC/69gmrBuHaUuunpZwpbXarPW8aMC83XOtP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvF2qpaP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvF2qpaP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so133291766b.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956731; x=1728561531; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbWICdkDxaVwBcEOzsxxr6cI7xE82tedg+uvnQR2erw=;
        b=IvF2qpaPCFlHEHBkifrfKd1mmQhZzeUry1HpBDycKpTlyP/QrLNwewibIGNIGPlEx4
         lDEEuv8hodI2Ojnx1ERe7IJ8oxPVTDUlfMbxa5gZmSjujHj917f/3/p9AMbw49NLA2YY
         4al6dFx9FI/8usxFwDKGjytx8jybbtJit3ZKqPxsrZ+XqJMtKayKu0HWgnEbTv7n++mr
         Cfy7+NhsxHIqWjCzDzj3ATeFgEZFZPfeY8Yylb2AZx3PVPlBUJdJf+NN2C+EZKOWMQg5
         vlk1gzS5oMyXU+3ia6zXqdEmcSRhv6mK0rvyKW33wIu1awedhHlFx3aR1NABWFF7xsNq
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956731; x=1728561531;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbWICdkDxaVwBcEOzsxxr6cI7xE82tedg+uvnQR2erw=;
        b=eQgeEvmNx/PUXvQGsZveqta6CmEIaK7Iybq4J136KC3Bt7EHfRzYEWNCiDaq/ecydI
         JT+nrPVgnYRxmD54kwhnulsD0TNmUIXvy4dQwkFSIhzUxasNSlTAKupS48NCThs3q/zz
         j6hLEcEaV1//DkNBvAxMmbcPrqcFb5YnMr2YdHa1h8WHget+Y3BqVQ0WETul/sLD7ZaE
         y8lTCaQ1cHdqHyPqfrhFAyNqJ511FXq0MxXNIyshBy4AVfWz/smgSHpTiSOeImpufezy
         viOIvgd06bPkyjpqc/yYWzv73gfSjL3+uEmL9imtvF+BUoLfYoeNquZjtHnlp36EnkcP
         kb+w==
X-Gm-Message-State: AOJu0Yz57jeMvo3XKOTTZDYCeTqnn0Pa9vMfB2aUPIBCq91sZj8ZxvpC
	gJOekJyDJzisECLefEQUtN6ZiwIeqFQ4nQ0iSpiSYlkpo9UtwBJUhBZpXg==
X-Google-Smtp-Source: AGHT+IEKS8tJC8JkQjyljI+b303JyelPrWarql1rC2fs/VmCHkNvs5v87AsB/WHbKt5tqd4EZ75qFQ==
X-Received: by 2002:a17:907:7fa7:b0:a8a:9195:922d with SMTP id a640c23a62f3a-a98f7fe6002mr710450766b.0.1727956730648;
        Thu, 03 Oct 2024 04:58:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c6785sm75257566b.204.2024.10.03.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:58:49 -0700 (PDT)
Message-Id: <e1d825ad212d91505eee9d911abbd3ba6bc170b1.1727956724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
	<pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
From: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 11:58:44 +0000
Subject: [PATCH v2 3/3] diff: modify output_prefix function pointer
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>

From: Jeff King <peff@peff.net>

The uses of the output_prefix function pointer in the diff_options
struct is currently difficult to work with by returning a pointer to a
strbuf. There is only one use that cares about the length of the string,
which appears to be the only justification of the return type.

We already noticed confusing memory issues around this return type, so
use a const char * return type to make it clear that the caller does not
own this string buffer.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 diff-lib.c   | 4 ++--
 diff.c       | 8 +++-----
 diff.h       | 2 +-
 graph.c      | 4 ++--
 log-tree.c   | 4 ++--
 range-diff.c | 4 ++--
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a680768ee75..6b14b959629 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -701,7 +701,7 @@ int index_differs_from(struct repository *r,
 	return (has_changes != 0);
 }
 
-static struct strbuf *idiff_prefix_cb(struct diff_options *opt UNUSED, void *data)
+static const char *idiff_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
@@ -716,7 +716,7 @@ void show_interdiff(const struct object_id *oid1, const struct object_id *oid2,
 	opts.output_format = DIFF_FORMAT_PATCH;
 	opts.output_prefix = idiff_prefix_cb;
 	strbuf_addchars(&prefix, ' ', indent);
-	opts.output_prefix_data = &prefix;
+	opts.output_prefix_data = prefix.buf;
 	diff_setup_done(&opts);
 
 	diff_tree_oid(oid1, oid2, "", &opts);
diff --git a/diff.c b/diff.c
index 84a6bb08681..82a9545afbd 100644
--- a/diff.c
+++ b/diff.c
@@ -2315,12 +2315,10 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 
 const char *diff_line_prefix(struct diff_options *opt)
 {
-	struct strbuf *msgbuf;
-	if (!opt->output_prefix)
-		return "";
+	if (opt->output_prefix)
+		return opt->output_prefix(opt, opt->output_prefix_data);
 
-	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
-	return msgbuf->buf;
+	return "";
 }
 
 static unsigned long sane_truncate_line(char *line, unsigned long len)
diff --git a/diff.h b/diff.h
index fb40c6e6d60..978450e20ac 100644
--- a/diff.h
+++ b/diff.h
@@ -94,7 +94,7 @@ typedef void (*add_remove_fn_t)(struct diff_options *options,
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
 
-typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
+typedef const char *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
 
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
diff --git a/graph.c b/graph.c
index 091c14cf4fb..ebb7d1e66f4 100644
--- a/graph.c
+++ b/graph.c
@@ -314,7 +314,7 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
-static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
+static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
@@ -327,7 +327,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 			   opt->line_prefix_length);
 	if (graph)
 		graph_padding_line(graph, &msgbuf);
-	return &msgbuf;
+	return msgbuf.buf;
 }
 
 static const struct diff_options *default_diffopt;
diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8e..3af34b91a59 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -923,10 +923,10 @@ int log_tree_diff_flush(struct rev_info *opt)
 			 */
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if (opt->diffopt.output_prefix) {
-				struct strbuf *msg = NULL;
+				const char *msg;
 				msg = opt->diffopt.output_prefix(&opt->diffopt,
 					opt->diffopt.output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, opt->diffopt.file);
+				fwrite(msg, strlen(msg), 1, opt->diffopt.file);
 			}
 
 			/*
diff --git a/range-diff.c b/range-diff.c
index bbb0952264b..10885ba3013 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -480,7 +480,7 @@ static void patch_diff(const char *a, const char *b,
 	diff_flush(diffopt);
 }
 
-static struct strbuf *output_prefix_cb(struct diff_options *opt UNUSED, void *data)
+static const char *output_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
@@ -508,7 +508,7 @@ static void output(struct string_list *a, struct string_list *b,
 	opts.flags.suppress_hunk_header_line_count = 1;
 	opts.output_prefix = output_prefix_cb;
 	strbuf_addstr(&indent, "    ");
-	opts.output_prefix_data = &indent;
+	opts.output_prefix_data = indent.buf;
 	diff_setup_done(&opts);
 
 	/*
-- 
gitgitgadget
