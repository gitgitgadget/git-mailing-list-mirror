Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9A46525
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670986; cv=none; b=sT4+9eN2L/NNFPWyZErxvxejgve1NgPDLbQoOxgmmWvi133o+6TnxohujxN2ur06twSacEN2Q3QOG7Cu5O6hM3Q0+YbxVh3oxCrfa/LwBE5kCuWPF+JdXbx6uzxVA8yXXyr6jWfdkS3wle5GjJQwAzzKUab77lSTQ1w7ODrTnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670986; c=relaxed/simple;
	bh=DbDjM44UTBrQHH9duNJqT0R92lfap9KzIQyTbrG3zAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtgGolrPL/D+5xYKagVheZgEui+LhAtClz/2KV0GQAiWeTgee44oABsc4YYXADScLgsslkFFBwZd843OyKswMWXEZ/W2F5kPD+VXqaecS+n28NT7nRMpzy/n4IQ76r+kkwFAZzQ6stJ3CRl34c5NHyVgMd9Htthxv2gJsDDVkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7IvNX2R; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7IvNX2R"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb72eb3143so3369045ad.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670984; x=1721275784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0SahC0FCi1n/BbK98X91PQY4a0Ro2QoUZr/ZjAgUOw=;
        b=g7IvNX2RCjtZ2QW7ffvMTpYMBwJuj1V8jpigJt5HSVNqZG17E4DILj5GqsGYTbt+jz
         3W9rS82vmjsijudDCtoy82ak5aPxb3fVTntLmj2xKs/VigWo8/DjTUb0tiCHwsb8V28J
         pyqCM0wUWFsiAMZIn7iTF0vPtB+KWHfAlQ0kDXKk4ZrLDibPw4mN3nlWF9bqHlTm4DlP
         ZxQg/0dCJvE7E49v56B/eF9zSAA9in1+k8BINaWycWqblSLWW58t6SFbLM8If/V8lbwC
         Cq6k5PyYNysa2sr5ZLg6Vf1wZ298bwOLUjfp108qfDLTrqI+b9456rUwRD51LsZi3hPm
         CQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670984; x=1721275784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0SahC0FCi1n/BbK98X91PQY4a0Ro2QoUZr/ZjAgUOw=;
        b=X2v3CSPJLY80WL02LHZz3Dg2zgswdLqxYl9RqweDap0wVMsXkw7gD8freDu779CuQ9
         o1puLD3nZU9AUq0RTYPzcO7XWs553K80C3VsZ9TSUGkSlED/Y0v4f+M/jxE+vkXCe8yB
         dbSRLa2vnqGwRnM6EQqR7AD/5wWOsyUJoazi6vI06N0yy8iX8wQ1VTZH1CCz16woHnpD
         ZEF55sICnlt9RQg4USGOPsLa05cE6mb27q72Kv24mjiUDjE5/q/vushyR3qk7/kLQwCK
         pZRn8kUJhPW+zoLqHWKqJDrcYejmH2dzNxcCOX49lINHSGKYHJvWOIXm1M3AZkdBjetI
         yYWQ==
X-Gm-Message-State: AOJu0YwJsRzvG9V2FQv2xr+wmDXvPYl3bu8yrShTdeAdRz43sX2QzpO6
	CusVqED6KDkJyUmj5tTRxpXD4skX1vW/UO4CeuM/sZxR4Tf2dQpLkTPw8Zwk
X-Google-Smtp-Source: AGHT+IGnevQ23OyivwBrKuCPwZba4sSimPrkuHqr4oB1h80evjNGr47v5zys5SIqKdDz8O/PQTktAA==
X-Received: by 2002:a17:902:eb81:b0:1fa:97ec:3a4 with SMTP id d9443c01a7336-1fbdb9e8b0amr23860675ad.8.1720670983970;
        Wed, 10 Jul 2024 21:09:43 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 4/7] t-reftable-merged: improve the const-correctness of helper functions
Date: Thu, 11 Jul 2024 09:28:33 +0530
Message-ID: <20240711040854.4602-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t-reftable-merged.c, a number of helper functions used by the
tests can be re-defined with parameters made 'const' which makes
it easier to understand if they're read-only or not. Re-define
these functions along these lines.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 85ebb96aaa..d151d6557b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
 
-static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+static ssize_t strbuf_add_void(void *b, const void *data, const size_t sz)
 {
 	strbuf_add(b, data, sz);
 	return sz;
@@ -27,7 +27,7 @@ static int noop_flush(void *arg)
 }
 
 static void write_test_table(struct strbuf *buf,
-			     struct reftable_ref_record refs[], int n)
+			     struct reftable_ref_record refs[], const int n)
 {
 	uint64_t min = 0xffffffff;
 	uint64_t max = 0;
@@ -62,9 +62,8 @@ static void write_test_table(struct strbuf *buf,
 	reftable_writer_free(w);
 }
 
-static void write_test_log_table(struct strbuf *buf,
-				 struct reftable_log_record logs[], int n,
-				 uint64_t update_index)
+static void write_test_log_table(struct strbuf *buf, struct reftable_log_record logs[],
+				 const int n, const uint64_t update_index)
 {
 	int err;
 
@@ -90,8 +89,8 @@ static void write_test_log_table(struct strbuf *buf,
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, int *sizes,
-			  struct strbuf *buf, size_t n)
+			  struct reftable_reader ***readers, const int *sizes,
+			  struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
@@ -116,7 +115,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	return mt;
 }
 
-static void readers_destroy(struct reftable_reader **readers, size_t n)
+static void readers_destroy(struct reftable_reader **readers, const size_t n)
 {
 	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
@@ -267,8 +266,8 @@ static void t_merged_refs(void)
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, int *sizes,
-			      struct strbuf *buf, size_t n)
+			      struct reftable_reader ***readers, const int *sizes,
+			      struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
-- 
2.45.GIT

