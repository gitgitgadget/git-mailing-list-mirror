Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97E14D280
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935355; cv=none; b=LmqR/nTqstq8ZfzitohSTV6BXzvIRICzOOR1hoJt2iieKsTiDkiqphBSAXEDHO4gun8BEUJ4BekFVkCGXN9dUDKr7P/x8VJGsb0NFt1kbFm2c9xhLQ5W6acYXFSwzdFnkC2GTvcwpuzFhQp6MHLcrRPSOAV9QtfDZ+LP7ruiY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935355; c=relaxed/simple;
	bh=1PA5ohjmN/AsAyqQAApcY2mIpLTbT3btqcaE+eSbgos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MlG1WpSCaY1J2IU2xhrcnc4Qh4pu3F344WLJGFPa310ppUX8QtXWODvshomqSQRfVWWXHaytlO9zQl8EloXV5b3XMNVTIzrLFJ4SwpEjUdpjmiyncE5g0uYmZ9w5t82kwYCQp4QmPy1JtvbvcYwAnyX17gZXcVVupto9yHZGFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDoWHr11; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDoWHr11"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so286002a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935352; x=1726540152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVwOpzShaFdLEHIKShR7it9pXSaygDKlYMAMokAqElI=;
        b=hDoWHr11cvuvoS5m3UzA3MEdacFednK3YOClHUkiiLCajS1c0AxKkEp2NFrgu+9Ldw
         EH/kOvNDs4x9ev6MLZw0p6p6l3b2XBuibQvizTj8JUMDqqz3rA+5242LAFS5bqokZCxY
         7hIie+hkmyzUXsMXudBwH4jUg+4aG+SBlJuxx+AFhaszGt1ghgD318SHjow89fEgxze3
         39oicR/Qe2a4EAH2aGHUAWYp38nNU63yIXd7DtHP0og2eiFVo0qbbgMlhJhfeUnR0Hdg
         URIRSm3PleAfFc1uXmwbSeiIP1u1zUivx7wWlO73uPOjyQ3t3hb2rX7MAwyOf7JRtua1
         Lobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935352; x=1726540152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVwOpzShaFdLEHIKShR7it9pXSaygDKlYMAMokAqElI=;
        b=bLurQZfVypD9IXF0vEuagwlfYwq7Wf74naazvo8UTI65XTXsiCd3dv3JV9iHOVmhj0
         6uQb6QkSLABUfT5eKNHwvxQAdlf88jujNh9q0Vf+JyBQTaQoxoFfkFmArGS1NjrMKOmU
         yCFQ7yc0b0Kx91nPxQ8vi5ks4FtzuFIKSrpTxPZng94MWg9xfk3MLIBFU1xuc6cGlBCi
         KRxmdsSn3G5qonaSMsFfMW2rV2tq3EWNpUvXIDsEAdOgGZGWB0egUGMZ9U6wLZssNhdb
         Jnh1cis0w2Rw2/3Ayx44C84ydDdXRVhlYH1DBe730qwB+M+YomZOs4gh1nmIBXu4wXql
         omsQ==
X-Gm-Message-State: AOJu0YwBoFZyU4kKT+14CqjJf2J8ypJO3ZCKb30jz7PNeMGjUW3HW7hs
	ZmwuyHNZs+LEuvMJtYeT9+sFhW8irLxTTO60zz7Q0gTC38hQHbnCQpVzqw==
X-Google-Smtp-Source: AGHT+IFqrDAhsf1LFMza8+lvewKeR8I/PmFzN5Al4sOe6u2BlGMqE/qH5qO42zvirTf60Mg41T3OgQ==
X-Received: by 2002:a17:907:3f91:b0:a8d:14e4:f94a with SMTP id a640c23a62f3a-a8d14e4fbf1mr833468366b.38.1725935352050;
        Mon, 09 Sep 2024 19:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a455besm419621966b.93.2024.09.09.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:10 -0700 (PDT)
Message-Id: <462ca0b80d29218647ffd26c2ae22c359917f00c.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:39 +0000
Subject: [PATCH 14/30] survey: summarize total sizes by object type
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Now that we have explored objects by count, we can expand that a bit more to
summarize the data for the on-disk and inflated size of those objects. This
information is helpful for diagnosing both why disk space (and perhaps
clone or fetch times) is growing but also why certain operations are slow
because the inflated size of the abstract objects that must be processed is
so large.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c      | 113 ++++++++++++++++++++++++++++++++++++++++++
 t/t8100-git-survey.sh |   8 +++
 2 files changed, 121 insertions(+)

diff --git a/builtin/survey.c b/builtin/survey.c
index 504b4edafce..435c4bd452a 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -64,6 +64,19 @@ struct survey_report_object_summary {
 	size_t blobs_nr;
 };
 
+/**
+ * For some category given by 'label', count the number of objects
+ * that match that label along with the on-disk size and the size
+ * after decompressing (both with delta bases and zlib).
+ */
+struct survey_report_object_size_summary {
+	char *label;
+	size_t nr;
+	size_t disk_size;
+	size_t inflated_size;
+	size_t num_missing;
+};
+
 /**
  * This struct contains all of the information that needs to be printed
  * at the end of the exploration of the repository and its references.
@@ -71,8 +84,15 @@ struct survey_report_object_summary {
 struct survey_report {
 	struct survey_report_ref_summary refs;
 	struct survey_report_object_summary reachable_objects;
+
+	struct survey_report_object_size_summary *by_type;
 };
 
+#define REPORT_TYPE_COMMIT 0
+#define REPORT_TYPE_TREE 1
+#define REPORT_TYPE_BLOB 2
+#define REPORT_TYPE_COUNT 3
+
 struct survey_context {
 	/* Options that control what is done. */
 	struct survey_opts opts;
@@ -282,12 +302,41 @@ static void survey_report_plaintext_reachable_object_summary(struct survey_conte
 	clear_table(&table);
 }
 
+static void survey_report_object_sizes(const char *title,
+				       const char *categories,
+				       struct survey_report_object_size_summary *summary,
+				       size_t summary_nr)
+{
+	struct survey_table table = SURVEY_TABLE_INIT;
+	table.table_name = title;
+
+	strvec_push(&table.header, xstrdup(categories));
+	strvec_push(&table.header, xstrdup(_("Count")));
+	strvec_push(&table.header, xstrdup(_("Disk Size")));
+	strvec_push(&table.header, xstrdup(_("Inflated Size")));
+
+	for (size_t i = 0; i < summary_nr; i++) {
+		insert_table_rowv(&table, xstrdup(summary[i].label),
+				  xstrfmt("%"PRIuMAX, summary[i].nr),
+				  xstrfmt("%"PRIuMAX, summary[i].disk_size),
+				  xstrfmt("%"PRIuMAX, summary[i].inflated_size),
+				  NULL);
+	}
+
+	print_table_plaintext(&table);
+	clear_table(&table);
+}
+
 static void survey_report_plaintext(struct survey_context *ctx)
 {
 	printf("GIT SURVEY for \"%s\"\n", ctx->repo->worktree);
 	printf("-----------------------------------------------------\n");
 	survey_report_plaintext_refs(ctx);
 	survey_report_plaintext_reachable_object_summary(ctx);
+	survey_report_object_sizes(_("TOTAL OBJECT SIZES BY TYPE"),
+				   _("Object Type"),
+				   ctx->report.by_type,
+				   REPORT_TYPE_COUNT);
 }
 
 static void survey_report_json(struct survey_context *ctx)
@@ -500,6 +549,64 @@ static void increment_object_counts(
 	}
 }
 
+static void increment_totals(struct survey_context *ctx,
+			     struct oid_array *oids,
+			     struct survey_report_object_size_summary *summary)
+{
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object_info oi = OBJECT_INFO_INIT;
+		unsigned oi_flags = OBJECT_INFO_FOR_PREFETCH;
+		unsigned long object_length = 0;
+		off_t disk_sizep = 0;
+		enum object_type type;
+
+		oi.typep = &type;
+		oi.sizep = &object_length;
+		oi.disk_sizep = &disk_sizep;
+
+		if (oid_object_info_extended(ctx->repo, &oids->oid[i],
+					     &oi, oi_flags) < 0) {
+			summary->num_missing++;
+		} else {
+			summary->nr++;
+			summary->disk_size += disk_sizep;
+			summary->inflated_size += object_length;
+		}
+	}
+}
+
+static void increment_object_totals(struct survey_context *ctx,
+				    struct oid_array *oids,
+				    enum object_type type)
+{
+	struct survey_report_object_size_summary *total;
+	struct survey_report_object_size_summary summary = { 0 };
+
+	increment_totals(ctx, oids, &summary);
+
+	switch (type) {
+	case OBJ_COMMIT:
+		total = &ctx->report.by_type[REPORT_TYPE_COMMIT];
+		break;
+
+	case OBJ_TREE:
+		total = &ctx->report.by_type[REPORT_TYPE_TREE];
+		break;
+
+	case OBJ_BLOB:
+		total = &ctx->report.by_type[REPORT_TYPE_BLOB];
+		break;
+
+	default:
+		BUG("No other type allowed");
+	}
+
+	total->nr += summary.nr;
+	total->disk_size += summary.disk_size;
+	total->inflated_size += summary.inflated_size;
+	total->num_missing += summary.num_missing;
+}
+
 static int survey_objects_path_walk_fn(const char *path,
 				       struct oid_array *oids,
 				       enum object_type type,
@@ -509,6 +616,7 @@ static int survey_objects_path_walk_fn(const char *path,
 
 	increment_object_counts(&ctx->report.reachable_objects,
 				type, oids->nr);
+	increment_object_totals(ctx, oids, type);
 
 	return 0;
 }
@@ -567,6 +675,11 @@ static void survey_phase_objects(struct survey_context *ctx)
 	info.blobs = 1;
 	info.tags = 1;
 
+	CALLOC_ARRAY(ctx->report.by_type, REPORT_TYPE_COUNT);
+	ctx->report.by_type[REPORT_TYPE_COMMIT].label = xstrdup(_("Commits"));
+	ctx->report.by_type[REPORT_TYPE_TREE].label = xstrdup(_("Trees"));
+	ctx->report.by_type[REPORT_TYPE_BLOB].label = xstrdup(_("Blobs"));
+
 	repo_init_revisions(ctx->repo, &revs, "");
 
 	for (size_t i = 0; i < ctx->ref_array.nr; i++) {
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
index 0da92eafa95..f8af9601214 100755
--- a/t/t8100-git-survey.sh
+++ b/t/t8100-git-survey.sh
@@ -50,6 +50,14 @@ test_expect_success 'git survey (default)' '
 	    Commits |    10
 	      Trees |    10
 	      Blobs |    10
+
+	TOTAL OBJECT SIZES BY TYPE
+	===============================================
+	Object Type | Count | Disk Size | Inflated Size
+	------------+-------+-----------+--------------
+	    Commits |    10 |      1523 |          2153
+	      Trees |    10 |       495 |          1706
+	      Blobs |    10 |       191 |           101
 	EOF
 
 	test_cmp expect out
-- 
gitgitgadget

