Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036647;
	b=LT5n6W4Pn1SEzxLvumHWtWM3B6c3hzjKKtJabueATWUnUB4085oTRoynyu8XGQRJGOyX
	 JcMkgoKBHtUUCLOXLOFj8vkASVejgmRV3e+EYPOrh1qU70eP32r14Qft4SRrUVDXvMNpF
	 Ds4CJoJRnN4Ot+DqWGUZHUDumBn3LQ+YlOdsg5HSkmfT9wPr01EiMGHouaOW/3/FRL787
	 0VcK4u/bkOT6F3iFR+zVathqpotZ+n53XleZ+Eii6AuPx7ub5xGHrY25YUapmf0Z0LNPn
	 MguHmFStWcOB05nI5tSUvAuF2BPRP7G+XsBZ0TCukiT64wHI8H0aDFmWq9Y/dqI2PyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036647;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7Fr8w86wzRIiPPPKGe6TZ16qj3Xu5Koo1LX7kqokwGg=;
	b=DGcesgqOGOIZ4DYwUHp2Y02Aq0n9Ofv0k5/lAbGt0gpL5aifxDkJpdzF8fCPg6x5J6Rp
	 JRb2b5fTeFEtGrgRVhz9K8SP1+6Dy0me25fAsNU/Ok+MFl6tTkAgnocTVIYfOwRTHxeGU
	 GnVHsbiFrWwg3JV9wbV0tZ+m+96IL6avp/9JN0EFaLR1L/clGhkiAWUmdAuJ0IekOA4Lw
	 6YWBnzAOnGrBsSZchqraTL19HFhrC0/iocRT5+xhO9NCzjwxpqUzpBJid0cWksAXg3VI/
	 mD6hAxTO6s1JRKv3+AthHKBLYEmt1xeLnaWghHNMQJJzoIB0wtqsjgrnxFiH/KGo8zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b="H0WMgl/r";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ag1TQQh9;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AF606A32A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612AF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=H0WMgl/r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ag1TQQh9
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BE8571D0031A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:44:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 13:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793036646;
	 x=1793123046; bh=7Fr8w86wzRIiPPPKGe6TZ16qj3Xu5Koo1LX7kqokwGg=; b=
	H0WMgl/rqkADHPXD0GEypJLDoExqtgiZeoj2dRQwp/ELW4Hhu/95WMW75uFSmDNi
	jPdx752MhrIkrCBt5SmXdw34JKl/rWtKyqM8nLZeSIMgQwDeV0lKpXK085DlwoEP
	HLAasTZ2mFQvA1rxXouMD0lfEoVB+D1CVrAORXIosfF/Gf4jiRqQgMSKw1Y42tOe
	xJMe+2h5HymV8bLejbhpzBvmuNQdfGZRBYZEo74Sw4Vv8u6PzmKbsXK5v+cQByXE
	ZwMbMAXXCCs1kflj9u8mfsH16pPhwfJbgmTz79ZSTfPatPy0ZaD7251BnooEgJFe
	CWrovGzWGhC4FxObzXnXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793036646; x=
	1793123046; bh=7Fr8w86wzRIiPPPKGe6TZ16qj3Xu5Koo1LX7kqokwGg=; b=A
	g1TQQh9i0woa7yxrc/mFVpvH4nedBXDZbGWK+gkD5wagMe9u5b3Oh+RG55I2VBSy
	lB4JIw38al/UbRMOx+RGYopbxt3QYNmU1M0Gnmx+0tom52MBunvmW4NUyJZo3tjQ
	MQ32HtQAXlscC+kmR6Mol3lVyUeMeNk7RDNIyQkqhrjO9WAYNQ1C54JmPmbLFmc3
	E9p5ucyFpD3li1QRFqkKVM/X5XP3alRkFAg0Yh4lu46hMxt1u72AjbnM8v0erQ4g
	34i10Y2LJkfu15cZuxASEpd2A2Iu2rUKLO0wDOJjsTC+m/kM3/5KtCEn6d+wwbo4
	U6+rRlGArcgM+KsHuxJ7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036646; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KL09p3uWdKMeiacaufDwb2KN4diC/SAv3dp2jZQzdmlUtQW
	YLuUosa5AJI36LALuMzYtDCzR9tbPJVSnkoPMharrF6jc6aNHqNjNfgVgfqDKEks
	vlGUGJlI4r2m7veq1CqSy9DVBssoYj3WGSpF21CvdwYJhlFAPTQ3eq64Z6tZZxFQ
	BiepAeQ8j0Jw9bvmd2W/ndHeED08bXIKMrhNTmWzZbID+RDW8R/Nf2CSknpkYkWe
	gDi4lzJijGLAcDfLodSitm5P9BaIrFX1nutvCyf2n8wSwdySuH19Yw+n5pxK33+w
	NEA4XAda9w0mR9bbPwHPqhrUpa7d42TJ+Mm6QFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8EU5KflNXMStcMHYA0osh1GRbCxFPo/htco5Bn1GlTE=:wf0HU3aj7RGGbtjRRzH1j68AoHlndmX1VLbisGj4b1g=;
X-ME-Sender: <xms:ZpHfakh4m9tOEA9biS5bos_p_P9MRoFihggPHiRnoqoc9GNePvZVvw>
    <xme:ZpHfajCGNlr3vdJLSf8QrcHbX4oGYqNdjEeCJwg19IM9dR6jru33ta8fJSmZy6Ysn
    Q68NzYnoS6tXDXFeGBEesS3RWzvVxkr7xRwnRGQVVbZZyrEQ6_KjQ4>
X-ME-Received: <xmr:ZpHfaps4T-6I_zTJIJWmqcvIEpRSCCsZZKxO_6GIbL93AMOo0YVcwtX5W2S-V2_dt9_h30YGxxnPnc_eMiwod6drCM1q>
X-ME-Proxy-Cause: dmFkZTFJYUsLm7GlYnx5KEUThlR56jMPVc83Wv4woFYlUk3FvIZnR/5el8K8RXOB9CQZsz
    Im/Jx5VcVpPUtqukSZjImTtWvSxkMiwustbt0epzd3cZJ+fJHk6vlaS6nsvFEkowL/o2QA
    gtR7ow4Gc0cBbQI6WVcW1k1mxN60tjEU3FX+4I9tSSpaab6596jUR1PihXHrJJGGHXhtgH
    cSWls5MbggIkfMyq6t4z2cn+ZOOMq8Nj2tZt85xQGHkrBQnp3Ug1gup0Cri3du8XUlxzJV
    /yVXFgAOc2khfBDSwyr3oeek+ZfS6dkSKKQn5nKFH3M8Ba21NwOypikfeZ/D3t2mS4PEYW
    RR+kqyttBhryEb0DIT+xk+OdLBbSevggjfP+TuiMnLplQvvj8K5m0ymrAcmO58F8BIYNUq
    fzbyBCu7+xNjZpre/N7hhCocx5ts2bG9AjODNgTwo+cHk/V9P5eR75qgHHEVlG2npYmDND
    pdMx4acEJSr6tWV0B21RVvzH7tE9HV3Y5ou+h5GhmED6AUD8rE68GljOBBOBNJ26SDaHL0
    jveWH3Bypv6LmtmNu8oMPzWHdeJqslnKPHBnvKGm1GewTcICD+o70skwTErrkpr2Kuh6Zc
    v/QKoVIRVDMU4tTSnPmJmVQwoEe1GqJxpEyWuEu4HEmJi4Da2IFrebde+plA
X-ME-Proxy: <xmx:ZpHfagalVGXqVo5q0R3cUUxJbi7xLqXleO5f8Y-39btJaP9rcGeSuA>
    <xmx:ZpHfakUlnHDAIGgkorx_Eo8BNRE2hL6R175cTH0XijG0PrJE-ciLIQ>
    <xmx:ZpHfas7HKwvPZ8pTSTsVnwRbiRqC-G2z2_1VxjNsUMewJszKJp5J3A>
    <xmx:ZpHfanjZo8ifCI_2Z_qibv70xP0rfABMjVskTtPHVEEB9ee-55jhvQ>
    <xmx:ZpHfan5Kup9AY22v153Fl7T4hDoGgJ1uzTwViI2c_rBwTMgMr-V6bmJK>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:44:06 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Mon, 26 Oct 2026 13:43:55 -0400
Subject: [PATCH v2 2/3] repo: make concern thresholds configurable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-repo-structure-concern-v2-2-e0df34228dc8@fastmail.com>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
In-Reply-To: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16601;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=wf0HU3aj7RGGbtjRRzH1j68AoHlndmX1VLbisGj4b1g=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLLuT0zi8Nwua102s2V2z/oE03UJgnM61mc1lats8NHvW
 MfYo/mzo5SFQYyLQVZMkeX/P4HGVywPJPyC3n2CmcPKBDKEgYtTACYy8Q4jw+o3qrKLT6z9qvUt
 2pzHXzzy3dtG91usCj+uy4RdS2vh1mH4K7DzWQ3zw+JpDLfstd7vXfg1WuF6+Zu7jfdM3+V1c7E
 IswAA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

The concern reporting mechanism so far provides a
measure of concern based on heuristic values estimated
by analyzing a collection of (hopefully) representative
repositories. But for different projects/usecases, the
thresholds at which a value becomes concerning may vary.

Provide a mechanism using git config to allow users to
configure per-repo concern levels for "git repo structure"
concern reporting.
---
 builtin/repo.c            |  62 +++++++++-------
 sideband.c                |   2 +-
 t/t1901-repo-structure.sh | 180 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 203 insertions(+), 41 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a450497d4e..ed579e6685 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "commit.h"
+#include "config.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -29,6 +30,8 @@
 #define REPO_STRUCTURE_USAGE \
 	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
 
+#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
+
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
 	REPO_STRUCTURE_USAGE,
@@ -386,40 +389,43 @@ enum concern_stat {
 	CONCERN_STAT_TREE_INFLATED_SIZE,
 	CONCERN_STAT_BLOB_INFLATED_SIZE,
 	CONCERN_STAT_TAG_INFLATED_SIZE,
+	CONCERN_STAT_MAXIMUM
 };
 
-struct concern_stat_threshold repo_structure_concern_thresholds[] = {
-	{ .name = "commit_count", .threshold = 19 },
-	{.name = "tree_count", .threshold = 21 },
-	{ .name = "blob_count", .threshold = 22 },
-	{ .name = "tag_count", .threshold = 15 },
-	{ .name = "commit_size", .threshold = 28 },
-	{ .name = "tree_size", .threshold = 27 },
-	{ .name = "blob_size", .threshold = 36 },
-	{ .name = "tags_size", .threshold = 18 },
-	{ .name = "commit_largest", .threshold = 18  },
-	{ .name = "tree_largest", .threshold = 18 },
-	{ .name = "blob_largest", .threshold = 26 },
-	{ .name = "tag_largest", .threshold =  15 },
-	{ .name = "commit_inflated_size", .threshold = 28 },
-	{ .name = "tree_inflated_size", .threshold = 32 },
-	{ .name = "blob_inflated_size", .threshold = 34 },
-	{ .name = "tag_inflated_size", .threshold = 25}
+struct concern_stat_threshold concern_stat_thresholds[] = {
+	{ .name = "commit-count", .threshold = 19 },
+	{ .name = "tree-count", .threshold = 21 },
+	{ .name = "blob-count", .threshold = 22 },
+	{ .name = "tag-count", .threshold = 15 },
+	{ .name = "commit-size", .threshold = 28 },
+	{ .name = "tree-size", .threshold = 27 },
+	{ .name = "blob-size", .threshold = 36 },
+	{ .name = "tag-size", .threshold = 18 },
+	{ .name = "commit-largest", .threshold = 18  },
+	{ .name = "tree-largest", .threshold = 18 },
+	{ .name = "blob-largest", .threshold = 26 },
+	{ .name = "tag-largest", .threshold =  15 },
+	{ .name = "commit-inflated-size", .threshold = 28 },
+	{ .name = "tree-inflated-size", .threshold = 32 },
+	{ .name = "blob-inflated-size", .threshold = 34 },
+	{ .name = "tag-inflated-size", .threshold = 25},
+	{ 0 }
 };
 
 /*
  * Concern thresholds aren't universal. We try to set reasonable default
  * values, but projects may want to set these thresholds differently. To
  * support that, they can set the thresholds for their project in the
- * project's git config, in the section "repo.structure.concern".
+ * project's git config, in the section "repo.concern".
   */
 static int config_concern_thresholds(const char *prefixed_var,
 				     const char *str_val,
 				     const struct config_context *ctx,
 				     void *cb UNUSED) {
-	const char *config_prefix = "repo.structure.concern.";
-	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {
-		const char *concern_name = &prefixed_var[strlen(config_prefix)];
+	if (!strncmp(REPO_STRUCTURE_CONFIG_PREFIX, prefixed_var,
+	      strlen(REPO_STRUCTURE_CONFIG_PREFIX))) {
+		const char *concern_name =
+			&prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
 		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {
 			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
 				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
@@ -435,7 +441,7 @@ static int config_concern_thresholds(const char *prefixed_var,
 	return 0;
 }
 
-static size_t approx_log2(long value) {
+static size_t approx_log2(size_t value) {
 	int position = 0;
 	if (value <= 0) {
 		return 0;
@@ -450,7 +456,7 @@ static size_t approx_log2(long value) {
 static size_t repo_structure_concern_level(enum concern_stat stat_id,
 					   size_t value) {
 	size_t log_value;
-	if (stat_id >= ARRAY_SIZE(concern_stat_thresholds))
+	if (stat_id >= CONCERN_STAT_MAXIMUM)
 		BUG("unexpected repository stat type");
 	log_value = approx_log2(value);
 	if (log_value > concern_stat_thresholds[stat_id].threshold)
@@ -844,6 +850,7 @@ static void stats_table_print_structure(const struct stats_table *table,
 			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
 			strbuf_addstr(&buf, " |");
 		}
+		strbuf_release(&concern_str);
 		printf("%s\n", buf.buf);
 	}
 
@@ -977,7 +984,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
 	if (show_concern)
-		print_keyvalue("objects.blobs.blob_size.concern_level", key_delim,
+		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
 			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
 							    stats->objects.disk_sizes.blobs),
 			      value_delim);
@@ -997,7 +1004,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 							    stats->objects.largest.commit_size.value),
 			      value_delim);
 	print_object_data("objects.trees.max_size", key_delim,
-			  &stats->objects.largest.tree_size, value_delim);
+			 &stats->objects.largest.tree_size, value_delim);
 	if (show_concern)
 		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
 			       repo_structure_concern_level(CONCERN_STAT_TREE_LARGEST,
@@ -1011,7 +1018,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 							    stats->objects.largest.blob_size.value),
 			      value_delim);
 	print_object_data("objects.tags.max_size", key_delim,
-			  &stats->objects.largest.tag_size, value_delim);
+			   &stats->objects.largest.tag_size, value_delim);
 	if (show_concern)
 		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
 			       repo_structure_concern_level(CONCERN_STAT_TAG_LARGEST,
@@ -1243,7 +1250,8 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
-
+	if (show_concern)
+		repo_config(repo, &config_concern_thresholds, NULL);
 	repo_init_revisions(repo, &revs, prefix);
 
 	if (show_progress < 0)
diff --git a/sideband.c b/sideband.c
index 0e75ab2317..374187402e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,4 @@
-define USE_THE_REPOSITORY_VARIABLE
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index f1e3fd2a75..e8f1269ad4 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -67,13 +67,166 @@ test_expect_success 'empty repository' '
 		EOF
 
 		git repo structure >out 2>err &&
-		cp out /tmp/test1-out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
 	)
 '
 
+test_expect_success SHA1 'repository with references and objects' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      4     |
+		|     * Branches            |      1     |
+		|     * Tags                |      1     |
+		|     * Remotes             |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.02 k   |
+		|     * Commits             |   1.01 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.03 MiB |
+		|     * Commits             | 217.92 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
+		|   * Blobs                 |            |
+		|     * Maximum size    [5] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [6] |    132 B   |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+
+		git repo structure >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success SHA1 'concern flagging' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# differences between zlib and zlib-ng can cause this
+		# test to fail; so we just turn it off.
+		git config core.compression 0 &&
+		# configure thresholds to get concern indications
+		git config repo.concern.commit-count 7 &&
+		git config repo.concern.commit-size 14 &&
+		git config repo.concern.tree-size 10 &&
+		git config repo.concern.blob-size 8 &&
+		git config repo.concern.blob-inflated-size 10 &&
+		git config repo.concern.tag-size 2 &&
+		git config repo.concern.commit-largest 4 &&
+		git config repo.concern.blob-largest 2 &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      | Concern  |
+		| ------------------------- | ---------- | -------- |
+		| * References              |            |          |
+		|   * Count                 |      4     |          |
+		|     * Branches            |      1     |          |
+		|     * Tags                |      1     |          |
+		|     * Remotes             |      1     |          |
+		|     * Others              |      1     |          |
+		|                           |            |          |
+		| * Reachable objects       |            |          |
+		|   * Count                 |   3.02 k   |          |
+		|     * Commits             |   1.01 k   | **       |
+		|     * Trees               |   1.01 k   |          |
+		|     * Blobs               |   1.01 k   |          |
+		|     * Tags                |      1     |          |
+		|   * Inflated size         |  16.03 MiB |          |
+		|     * Commits             | 217.92 KiB |          |
+		|     * Trees               |  15.81 MiB |          |
+		|     * Blobs               |  11.68 KiB | ***      |
+		|     * Tags                |    132 B   |          |
+		|   * Disk size             | $(object_type_disk_usage all true) |          |
+		|     * Commits             | $(object_type_disk_usage commit true) | ***      |
+		|     * Trees               | $(object_type_disk_usage tree true) | ******** |
+		|     * Blobs               |  $(object_type_disk_usage blob true) | ******   |
+		|     * Tags                |    $(object_type_disk_usage tag) B   | *****    |
+		|                           |            |          |
+		| * Largest objects         |            |          |
+		|   * Commits               |            |          |
+		|     * Maximum size    [1] |    223 B   | ***      |
+		|     * Maximum parents [2] |      1     |          |
+		|   * Trees                 |            |          |
+		|     * Maximum size    [3] |  32.29 KiB |          |
+		|     * Maximum entries [4] |   1.01 k   |          |
+		|   * Blobs                 |            |          |
+		|     * Maximum size    [5] |     13 B   | *        |
+		|   * Tags                  |            |          |
+		|     * Maximum size    [6] |    132 B   |          |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+
+		git repo structure --concern >actual 2>err &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -139,16 +292,18 @@ test_expect_success SHA1 'lines format with concerns' '
 	git init repo &&
 	(
 		cd repo &&
+		# differences between zlib and zlib-ng can cause this
+		# test to fail; so we just turn it off.
+		git config core.compression 0 &&
 		# configure thresholds to get concern indications
-		git config repo.structure.concern.commit-count 7 &&
-		git config repo.structure.concern.commit-size 14 &&
-		git config repo.structure.concern.tree-size 10 &&
-		git config repo.structure.concern.blob-size 8 &&
-		git config repo.structure.concern.blob-inflated-size 10 &&
-		git config repo.structure.concern.tag-size 2 &&
-		git config repo.structure.concern.commit-largest 4 &&
-		git config repo.structure.concern.blob-largest 2 &&
-		touch configured &&
+		git config repo.concern.commit-count 7 &&
+		git config repo.concern.commit-size 14 &&
+		git config repo.concern.tree-size 10 &&
+		git config repo.concern.blob-size 8 &&
+		git config repo.concern.blob-inflated-size 10 &&
+		git config repo.concern.tag-size 2 &&
+		git config repo.concern.commit-largest 4 &&
+		git config repo.concern.blob-largest 2 &&
 		test_commit_bulk 1005 &&
 		git tag -a foo -m bar &&
 		oid="$(git rev-parse HEAD)" &&
@@ -157,7 +312,6 @@ test_expect_success SHA1 'lines format with concerns' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-
 		# The tags disk size is handled specially due to the
 		# git-rev-list(1) --disk-usage=human option printing the full
 		# "byte/bytes" unit string instead of just "B".
@@ -172,8 +326,8 @@ test_expect_success SHA1 'lines format with concerns' '
 		objects.tags.inflated_size.concern_level=0
 		objects.commits.disk_size.concern_level=3
 		objects.trees.disk_size.concern_level=8
-		objects.blobs.blob_size.concern_level=6
-		objects.tags.disk_size.concern_level=4
+		objects.blobs.disk_size.concern_level=6
+		objects.tags.disk_size.concern_level=5
 		objects.commits.max_size.concern_level=3
 		objects.trees.max_size.concern_level=0
 		objects.blobs.max_size.concern_level=1

-- 
2.53.0

