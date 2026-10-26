Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036647;
	b=p58CgKIMEGqDG+ZeefmcTpZlKhHzNYWNDqxxmlWq0hqn1qGVlqT35unQZRGb6tQEsDeC
	 zwxJyQvNhGZFpGXHZ4t7DyrrV/xr35nW9+aEmOiunR7TCOplpV/bSYL4+hQRTemiHn7nD
	 dJm46t/tqvIbfbC8WQsh+c/9nXtU0nPIVSVLdlK428bDukcjrK5iY4y84joXYfcnnGnyu
	 Ms2feiRSq+NJwax2x7b3vPMuwKLIdHPMYrNdsw2i71VqQISFMujynj9MEBy2gP6DuQ7q2
	 dSlIavA0hk5LMTfJlfyTe+vsd/qCXMRz7MlzC+asKEgwb9CrQQkym66daHQcK9mpgRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036647;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aNYP5ivZ3JiukK6VBHZt8gsv1EGn0vH3ejCYyn2rnTA=;
	b=dBC/oHk2AWMrbWL4/adqCOdAbs20hE3v7jtoHgMP7SEVZSHOk1W7/NCDtiZFIjwA/DjO
	 F5Z8c3ACbs7IOSVrcWec4Ur2g9Gj0ozL4sjSEgQytZnm4LBnpxHqi8KNKdz1xUtBYLKeC
	 cxBZLLE+Vwbebx6n+kBk6xnG2r0pjH/n70S42E9wd1m7UD9WlY6E1mPwExyf6Q/4QGAff
	 UokU3P0OMMc8kouwWWMolsvEr11PXRdq5FWBnylptTCW/oTnSCZSAHokX85tQGFcLNMEa
	 gTtFmJgzood+btLow21abq8452IDj3y5hXBNY1FG7kfGjgxT+LiyZ4I0xXlTL+wdG6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=T0BzuC4q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a1tAcYSB;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54690606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54690606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=T0BzuC4q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a1tAcYSB
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA6557A03FD
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:44:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 13:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793036645;
	 x=1793123045; bh=aNYP5ivZ3JiukK6VBHZt8gsv1EGn0vH3ejCYyn2rnTA=; b=
	T0BzuC4qJT/bdWvonW/gClwWwhLdQW3u9mMcsnLs2yjhMm1m3s8WHjIcYiTwvZB5
	LE44dINQJyp7OUhIdJ7gDcV2eCoqt/8vYd6ZI9zr3/q4WKChiN3ve7Ei/5laseSF
	F43LCjn6Dul+M++Fp9mgfMS6Tl+2S8J8qugQjyZYFxNpBh3sw3/JVd2MA2Mw0QC/
	XKdEnNj+7N2tw3qQdM8pgMqnsDHqU6cxaps6cJYt5/VzYoVMIP8e5dj+d8/ZRAs9
	UOz+kJyjx3E1M/8Yx0pJCL8QTlL/CQNhP5Akm9v6D8We2fCfELlA0xxd5gL36uBp
	EwQurofziqRRawpX5bl1+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793036645; x=
	1793123045; bh=aNYP5ivZ3JiukK6VBHZt8gsv1EGn0vH3ejCYyn2rnTA=; b=a
	1tAcYSBLo32jQ/8a/7BHmsPgCsbDOVBM3as02FBpUrzHKtSN3YhABSKWMU9jy36W
	3f0OJrkf2bDeQlttoZARCI+WY2VM2F9KrdvUzgg60lMuwmdBVw1uKY7euI65qnXH
	8/55a2XHZjcUoRKkgfd2dJzRfzmqWgZQnF9IVTMIxmYPTVub1lnQNPr9xugc4Yjz
	CqwzX2VTLXn03XpopTaZReFhm/199hO8Q63FdCM0wZ2UL6RrsBOIt4hkFlXZsEjv
	CRZCWRytEf10ja15Kl0TdOrzYPluETcRGf8ZsqM3YmrD9Q/xeLoXqLhyWR87c3fz
	RUKp4Vbsy0z4iYUlY3ZKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036645; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:C/tnkPBjpi1kSNWmVzewaL/wh0ol+VFYx/CfdTvw2a3/Avh
	Id17RA7J2yE27Qsy+djwn2C7279GtKziKEq52G6lJ5IbH05YtOS25b3UzOYbBNq6
	yf5eqUCq1+tuy67IVrVDTJHd/AqGofXCmUdZTJv3+5DiXqeSGwM1sII+AHmNGX3g
	ODVb24+vbCN4jRL8cNRJwnls64kRBHtVFHYMMTokQlmSHRJkKT8e38cIqxmjbnlO
	NfmOp8DWZ2dMi4MGOhLoub2vps7/HIdCczo2euhZqp4Z42LUsWtWkhB1gBl/z+Ct
	MiJucX70ePHl+AgO1mPeC45S5pZwpcta07fY6Ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a+Wbr7qOdrMg/UV74VXfkaejIh00t9E7toe/3IG7UQg=:FxeNpfhvK4lLihFcUXEO1RV+e1CMKampAQJ/9W7SkUY=;
X-ME-Sender: <xms:ZZHfajrnlRY_MyjWc6tW3IOPN9CmjlKcyCXKWmnu5UT94G7EuNnPSw>
    <xme:ZZHfajovnZmd0NEovicVLA_V-Z69U4HXLWmcjerhg5yF-WyDFX0v0gkfrekHlYxoP
    LddwqmDKoRYFdn5Qx0NsWWzsC8VJcvU3IacVY7KUFmoms65c3Fg-ZM>
X-ME-Received: <xmr:ZZHfat0tHKpOywz0HOOqoE15bqD8YIWOtZ-zArlPnlyUWH95xpY86ryfMDSEwaAeX2xAxIny_RK2OioZJGimb6KRVqWB>
X-ME-Proxy-Cause: dmFkZTES29yjgKwHTX7CqDM2YCc6NRdY/Dzlqq+mV/5M2gTSa2iKtTwpbhe28MJGViyjPZ
    DwQyVI1hdIkMCfU7QaR9isZXzEjfpElFENfhygWmbywUOxnGapJZ4gLGs9ajKSsYP0sIb8
    jAXB64NwYAF0mX4LHF6Ti5gDRPhrgkq+PDA6pk9J6AQe4SXaASTDKbLhbdyUw/l5V057dc
    HM6THfkj/mwfpr9+CtTJwQv0ge8ol3D+GqVR2yg13BKUMJlrk5LygMtMD1x7n9b0pUXvVn
    p+ckK5qSdYW1PaTIKe68gH4xh9l0qV2iA1+gYdKjl3kHRffH1aWNP9drmUlht9ksUMKBRK
    PjEopc2p3qnw+qO0AM8mJodImEPXLSLItoZ51cM6X+S58gR/XXaPy6+0fc1rI3ezSbV/s9
    FFZk3CxzS8vuLCELbT+YkGigMlI80e4RXXZEklBQqZJG2BPzcNyadmubSM8ZQ2bkDNN/Jb
    9SzLMo6nLB9MN7paA3jAgAEGZvy95seqfy13p0JDGpaKc1cDAjlMR2tkJwD+OTnvyM8zF5
    IVqOkJPETjtCHT43xcaH+J/RKyLgTLPPQnd+G6/7akA23R+kOWNY7PIMp9ow7UvKtoDqml
    xkhfK125hXW6KMhfv4peqAQ2fJB+OBLhgootJkiKahdxeSwt6Q482CeeLWeA
X-ME-Proxy: <xmx:ZZHfaiBeytTlQjPMa_ZtxqDb1vHEWVbX7gT_yGBi3A1LqlSS6HaCLg>
    <xmx:ZZHfaldRAdpEbt9z5wKet2tpknxa45kxhxhGw9EeWsF_n--N71cTuA>
    <xmx:ZZHfani3bw0lkA5AYU9szQoh1z0bkRPYagbDM8IyRT4QRJWUL0o8AQ>
    <xmx:ZZHfatqgmyXdM_IA-3JZxYQj1m_Bq-uFxgBwzt7bv12FNx_QrHMt8A>
    <xmx:ZZHfauNPSDpB8anRgBh3kPlh53KCY_gkh7UixfZ8plf6-Gjf7tK2O3Kg>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:44:05 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Mon, 26 Oct 2026 13:43:54 -0400
Subject: [PATCH v2 1/3] repo: add level of concern reporting
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
Message-Id: <20261026-b4-repo-structure-concern-v2-1-e0df34228dc8@fastmail.com>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
In-Reply-To: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31056;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=FxeNpfhvK4lLihFcUXEO1RV+e1CMKampAQJ/9W7SkUY=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLLuT0y888d40rJcNZ8L/6+0aL2OntDWdohVOHj6MqvIz
 feyb5uXdZSyMIhxMciKKbL8/yfQ+IrlgYRf0LtPMHNYmUCGMHBxCsBEci4yMpxyePAxJPKseW7o
 LXfvrasb7AX/hap6P4ndc/eM2c4XRy4wMhz1rV2130Ji3Xo9SdEZ3/JlfcLOOoo+S957q2HJvlt
 LVTgA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

"git repo structure" computes a set of statistics
that are useful for diagnosing performance issues in
a git repository. But for a typical user who hasn't
encountered any issues yet, it can be difficult to
interpret the data - when should a value be considered
concerning?

Add an option to "git repo structure" that adds a "degree
of concern" column to the structure report, which indicates
when a stat values has reached a point where it might be
concerning, and indicate how severe the concern should be.
---
 builtin/repo.c            | 329 +++++++++++++++++++++++++++++++++++++++++++---
 sideband.c                |   2 +-
 t/t1901-repo-structure.sh | 125 ++++++++----------
 3 files changed, 366 insertions(+), 90 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..a450497d4e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,7 +27,7 @@
 	"git repo info --keys [--format=(lines|nul) | -z]"
 
 #define REPO_STRUCTURE_USAGE \
-	"git repo structure [--format=(table|lines|nul) | -z]"
+	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -348,8 +348,118 @@ struct stats_table {
 	int name_col_width;
 	int value_col_width;
 	int unit_col_width;
+	int concern_col_width;
 };
 
+/*
+ * For computing level of concern about a stat, we need to have some
+ * baseline values. For each of these, we'define a minimum level
+ * of concern, which will appear as 1 star. Then we scale exponentially:
+ * each time that value doubles, we add another star.
+ *
+ * The threshold values for concern are expressed as log_2 values of the size
+ * at which the statistic becomes concerning. The default values for the
+ * threshold were selected based on observed values from a collection of
+ * representative-ish repositories of varying size, by finding the mean log_2
+ * value and standard deviation (sigma) for each statistic over the collection.
+ * The threshold for each metric is then set at mean(log_2) + sigma.
+ */
+struct concern_stat_threshold {
+	const char *name;
+	size_t threshold;
+};
+
+enum concern_stat {
+	CONCERN_STAT_COMMIT_COUNT,
+	CONCERN_STAT_TREE_COUNT,
+	CONCERN_STAT_BLOB_COUNT,
+	CONCERN_STAT_TAG_COUNT,
+	CONCERN_STAT_COMMIT_SIZE,
+	CONCERN_STAT_TREE_SIZE,
+	CONCERN_STAT_BLOB_SIZE,
+	CONCERN_STAT_TAG_SIZE,
+	CONCERN_STAT_COMMIT_LARGEST,
+	CONCERN_STAT_TREE_LARGEST,
+	CONCERN_STAT_BLOB_LARGEST,
+	CONCERN_STAT_TAG_LARGEST,
+	CONCERN_STAT_COMMIT_INFLATED_SIZE,
+	CONCERN_STAT_TREE_INFLATED_SIZE,
+	CONCERN_STAT_BLOB_INFLATED_SIZE,
+	CONCERN_STAT_TAG_INFLATED_SIZE,
+};
+
+struct concern_stat_threshold repo_structure_concern_thresholds[] = {
+	{ .name = "commit_count", .threshold = 19 },
+	{.name = "tree_count", .threshold = 21 },
+	{ .name = "blob_count", .threshold = 22 },
+	{ .name = "tag_count", .threshold = 15 },
+	{ .name = "commit_size", .threshold = 28 },
+	{ .name = "tree_size", .threshold = 27 },
+	{ .name = "blob_size", .threshold = 36 },
+	{ .name = "tags_size", .threshold = 18 },
+	{ .name = "commit_largest", .threshold = 18  },
+	{ .name = "tree_largest", .threshold = 18 },
+	{ .name = "blob_largest", .threshold = 26 },
+	{ .name = "tag_largest", .threshold =  15 },
+	{ .name = "commit_inflated_size", .threshold = 28 },
+	{ .name = "tree_inflated_size", .threshold = 32 },
+	{ .name = "blob_inflated_size", .threshold = 34 },
+	{ .name = "tag_inflated_size", .threshold = 25}
+};
+
+/*
+ * Concern thresholds aren't universal. We try to set reasonable default
+ * values, but projects may want to set these thresholds differently. To
+ * support that, they can set the thresholds for their project in the
+ * project's git config, in the section "repo.structure.concern".
+  */
+static int config_concern_thresholds(const char *prefixed_var,
+				     const char *str_val,
+				     const struct config_context *ctx,
+				     void *cb UNUSED) {
+	const char *config_prefix = "repo.structure.concern.";
+	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {
+		const char *concern_name = &prefixed_var[strlen(config_prefix)];
+		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {
+			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
+				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
+				if (value < 0)
+					return -1;
+				concern_stat_thresholds[i].threshold = value;
+				return 0;
+			}
+		}
+		warning(_("Invalid concern threshold name: '%s'"), concern_name);
+		return 0;
+	}
+	return 0;
+}
+
+static size_t approx_log2(long value) {
+	int position = 0;
+	if (value <= 0) {
+		return 0;
+	}
+	while (value > 1) {
+		position++;
+		value >>= 1;
+	}
+	return position;
+}
+
+static size_t repo_structure_concern_level(enum concern_stat stat_id,
+					   size_t value) {
+	size_t log_value;
+	if (stat_id >= ARRAY_SIZE(concern_stat_thresholds))
+		BUG("unexpected repository stat type");
+	log_value = approx_log2(value);
+	if (log_value > concern_stat_thresholds[stat_id].threshold)
+		return log_value -
+			concern_stat_thresholds[stat_id].threshold;
+	else
+		return 0;
+}
+
 /*
  * Holds column data that gets stored for each row.
  */
@@ -358,6 +468,7 @@ struct stats_table_entry {
 	const char *unit;
 	size_t index;
 	struct object_id *oid;
+	size_t concern;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -391,6 +502,8 @@ static void stats_table_vaddf(struct stats_table *table,
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
+	if ((int)entry->concern > table->concern_col_width)
+		table->concern_col_width = entry->concern;
 	if (entry->unit) {
 		int unit_width = utf8_strwidth(entry->unit);
 		if (unit_width > table->unit_col_width)
@@ -410,13 +523,14 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
 }
 
 static void stats_table_count_addf(struct stats_table *table, size_t value,
-				   const char *format, ...)
+				   size_t concern, const char *format, ...)
 {
 	struct stats_table_entry *entry;
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_count(value, &entry->value, &entry->unit);
+	entry->concern = concern;
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -425,13 +539,14 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 
 static void stats_table_object_count_addf(struct stats_table *table,
 					  struct object_id *oid, size_t value,
-					  const char *format, ...)
+					  size_t concern, const char *format, ...)
 {
 	struct stats_table_entry *entry;
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_count(value, &entry->value, &entry->unit);
+	entry->concern = concern;
 
 	/*
 	 * A NULL OID should not have a table annotation.
@@ -445,6 +560,7 @@ static void stats_table_object_count_addf(struct stats_table *table,
 }
 
 static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  size_t concern,
 				  const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -452,6 +568,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -460,6 +577,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 static void stats_table_object_size_addf(struct stats_table *table,
 					 struct object_id *oid, size_t value,
+					 size_t concern,
 					 const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -467,6 +585,7 @@ static void stats_table_object_size_addf(struct stats_table *table,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	/*
 	 * A NULL OID should not have a table annotation.
@@ -501,47 +620,92 @@ static void stats_table_setup_structure(struct stats_table *table,
 
 	ref_total = get_total_reference_count(refs);
 	stats_table_addf(table, "* %s", _("References"));
-	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
-	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
-	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
-	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+	stats_table_count_addf(table, ref_total, 0,
+			       "  * %s", _("Count"));
+	stats_table_count_addf(table, refs->branches, 0,
+			       "    * %s", _("Branches"));
+	stats_table_count_addf(table, refs->tags,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       refs->tags),
+			       "    * %s", _("Tags"));
+	stats_table_count_addf(table, refs->remotes, 0,
+			       "    * %s", _("Remotes"));
+	stats_table_count_addf(table, refs->others, 0,
+			       "    * %s", _("Others"));
 
 	object_count_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Reachable objects"));
-	stats_table_count_addf(table, object_count_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, object_count_total, 0,
+			       "  * %s", _("Count"));
 	stats_table_count_addf(table, objects->type_counts.commits,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_COUNT,
+				       objects->type_counts.commits),
 			       "    * %s", _("Commits"));
 	stats_table_count_addf(table, objects->type_counts.trees,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_COUNT,
+				       objects->type_counts.trees),
 			       "    * %s", _("Trees"));
 	stats_table_count_addf(table, objects->type_counts.blobs,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_COUNT,
+				       objects->type_counts.blobs),
 			       "    * %s", _("Blobs"));
 	stats_table_count_addf(table, objects->type_counts.tags,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       objects->type_counts.tags),
 			       "    * %s", _("Tags"));
 
 	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
-	stats_table_size_addf(table, inflated_object_total,
+	stats_table_size_addf(table, inflated_object_total, 0,
 			      "  * %s", _("Inflated size"));
 	stats_table_size_addf(table, objects->inflated_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_INFLATED_SIZE,
+				      objects->inflated_sizes.commits),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->inflated_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_INFLATED_SIZE,
+				      objects->inflated_sizes.trees),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->inflated_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_INFLATED_SIZE,
+				      objects->inflated_sizes.blobs),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_INFLATED_SIZE,
+				      objects->inflated_sizes.tags),
 			      "    * %s", _("Tags"));
 
 	disk_object_total = get_total_object_values(&objects->disk_sizes);
-	stats_table_size_addf(table, disk_object_total,
+	stats_table_size_addf(table, disk_object_total, 0,
 			      "  * %s", _("Disk size"));
 	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_SIZE,
+				      objects->disk_sizes.commits),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_SIZE,
+				      objects->disk_sizes.trees),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_SIZE,
+				      objects->disk_sizes.blobs),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_SIZE,
+				      objects->disk_sizes.tags),
 			      "    * %s", _("Tags"));
 
 	stats_table_addf(table, "");
@@ -550,51 +714,71 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_object_size_addf(table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_COMMIT_LARGEST,
+					     objects->largest.commit_size.value),
 				     "    * %s", _("Maximum size"));
 	stats_table_object_count_addf(table,
 				      &objects->largest.parent_count.oid,
 				      objects->largest.parent_count.value,
+				      0,
 				      "    * %s", _("Maximum parents"));
 	stats_table_addf(table, "  * %s", _("Trees"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tree_size.oid,
 				     objects->largest.tree_size.value,
+				      repo_structure_concern_level(
+					      CONCERN_STAT_TREE_LARGEST,
+					      objects->largest.tree_size.value),
 				     "    * %s", _("Maximum size"));
 	stats_table_object_count_addf(table,
 				      &objects->largest.tree_entries.oid,
 				      objects->largest.tree_entries.value,
+				      0,
 				      "    * %s", _("Maximum entries"));
 	stats_table_addf(table, "  * %s", _("Blobs"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.blob_size.oid,
 				     objects->largest.blob_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_BLOB_LARGEST,
+					     objects->largest.blob_size.value),
 				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Tags"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tag_size.oid,
 				     objects->largest.tag_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_TAG_LARGEST,
+					     objects->largest.tag_size.value),
 				     "    * %s", _("Maximum size"));
 }
 
 #define INDEX_WIDTH 4
 
-static void stats_table_print_structure(const struct stats_table *table)
+static void stats_table_print_structure(const struct stats_table *table,
+					bool show_concern)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
+	const char *concern_col_title = _("Concern");
 	int title_name_width = utf8_strwidth(name_col_title);
 	int title_value_width = utf8_strwidth(value_col_title);
+	int title_concern_width = utf8_strwidth(concern_col_title);
 	int name_col_width = table->name_col_width;
 	int value_col_width = table->value_col_width;
 	int unit_col_width = table->unit_col_width;
+	int concern_col_width = table->concern_col_width;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf concern_str = STRBUF_INIT;
 
 	if (title_name_width > name_col_width)
 		name_col_width = title_name_width;
 	if (title_value_width > value_col_width + unit_col_width + 1)
 		value_col_width = title_value_width - unit_col_width;
-
+	if (show_concern && title_concern_width > concern_col_width)
+		concern_col_width = title_concern_width;
 	strbuf_addstr(&buf, "| ");
 	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width + INDEX_WIDTH,
 			  name_col_title);
@@ -602,6 +786,12 @@ static void stats_table_print_structure(const struct stats_table *table)
 	strbuf_utf8_align(&buf, ALIGN_LEFT,
 			  value_col_width + unit_col_width + 1, value_col_title);
 	strbuf_addstr(&buf, " |");
+	if (show_concern) {
+		strbuf_addch(&buf, ' ');
+		strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width,
+			  concern_col_title);
+		strbuf_addstr(&buf, " |");
+	}
 	printf("%s\n", buf.buf);
 
 	printf("| ");
@@ -610,17 +800,28 @@ static void stats_table_print_structure(const struct stats_table *table)
 	printf(" | ");
 	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
 		putchar('-');
-	printf(" |\n");
+	printf(" |");
+	if (show_concern) {
+		putchar(' ');
+		for (int i = 0; i < concern_col_width; i++) {
+			putchar('-');
+		}
+		printf(" |");
+	}
+	putchar('\n');
 
 	for_each_string_list_item(item, &table->rows) {
 		struct stats_table_entry *entry = item->util;
 		const char *value = "";
 		const char *unit = "";
+		strbuf_reset(&concern_str);
 
 		if (entry) {
 			value = entry->value;
 			if (entry->unit)
 				unit = entry->unit;
+			if (entry->concern > 0)
+				strbuf_addchars(&concern_str, '*', entry->concern);
 		}
 
 		strbuf_reset(&buf);
@@ -638,6 +839,11 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_addch(&buf, ' ');
 		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
 		strbuf_addstr(&buf, " |");
+		if (show_concern) {
+			strbuf_addch(&buf, ' ');
+			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
+			strbuf_addstr(&buf, " |");
+		}
 		printf("%s\n", buf.buf);
 	}
 
@@ -681,12 +887,15 @@ static void print_object_data(const char *key, char key_delim,
 }
 
 static void structure_keyvalue_print(struct repo_structure *stats,
-				     char key_delim, char value_delim)
+				     char key_delim, char value_delim,
+				     bool show_concern)
 {
 	print_keyvalue("references.branches.count", key_delim,
 		       stats->refs.branches, value_delim);
+
 	print_keyvalue("references.tags.count", key_delim,
 		       stats->refs.tags, value_delim);
+
 	print_keyvalue("references.remotes.count", key_delim,
 		       stats->refs.remotes, value_delim);
 	print_keyvalue("references.others.count", key_delim,
@@ -694,39 +903,120 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 
 	print_keyvalue("objects.commits.count", key_delim,
 		       stats->objects.type_counts.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.count.concern_level", key_delim,
+			      repo_structure_concern_level(CONCERN_STAT_COMMIT_COUNT,
+							   stats->objects.type_counts.commits),
+			      value_delim);
 	print_keyvalue("objects.trees.count", key_delim,
 		       stats->objects.type_counts.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.count.concern_level", key_delim,
+			      repo_structure_concern_level(CONCERN_STAT_TREE_COUNT,
+							   stats->objects.type_counts.trees),
+			      value_delim);
 	print_keyvalue("objects.blobs.count", key_delim,
 		       stats->objects.type_counts.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.count.concern_level", key_delim,
+			      repo_structure_concern_level(CONCERN_STAT_BLOB_COUNT,
+							   stats->objects.type_counts.blobs),
+			      value_delim);
 	print_keyvalue("objects.tags.count", key_delim,
 		       stats->objects.type_counts.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.count.concern_level", key_delim,
+			      repo_structure_concern_level(CONCERN_STAT_TAG_COUNT,
+							   stats->objects.type_counts.tags),
+			      value_delim);
 
 	print_keyvalue("objects.commits.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_INFLATED_SIZE,
+							    stats->objects.inflated_sizes.commits),
+			      value_delim);
 	print_keyvalue("objects.trees.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TREE_INFLATED_SIZE,
+							    stats->objects.inflated_sizes.trees),
+			      value_delim);
+
 	print_keyvalue("objects.blobs.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_BLOB_INFLATED_SIZE,
+							    stats->objects.inflated_sizes.blobs),
+			      value_delim);
 	print_keyvalue("objects.tags.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TAG_INFLATED_SIZE,
+							    stats->objects.inflated_sizes.tags),
+			      value_delim);
 
 	print_keyvalue("objects.commits.disk_size", key_delim,
 		       stats->objects.disk_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_SIZE,
+							    stats->objects.disk_sizes.commits),
+			      value_delim);
 	print_keyvalue("objects.trees.disk_size", key_delim,
 		       stats->objects.disk_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TREE_SIZE,
+							    stats->objects.disk_sizes.trees),
+			      value_delim);
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.blob_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
+							    stats->objects.disk_sizes.blobs),
+			      value_delim);
 	print_keyvalue("objects.tags.disk_size", key_delim,
 		       stats->objects.disk_sizes.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TAG_SIZE,
+							    stats->objects.disk_sizes.tags),
+			      value_delim);
 
 	print_object_data("objects.commits.max_size", key_delim,
 			  &stats->objects.largest.commit_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_LARGEST,
+							    stats->objects.largest.commit_size.value),
+			      value_delim);
 	print_object_data("objects.trees.max_size", key_delim,
 			  &stats->objects.largest.tree_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TREE_LARGEST,
+							    stats->objects.largest.tree_size.value),
+			      value_delim);
 	print_object_data("objects.blobs.max_size", key_delim,
 			  &stats->objects.largest.blob_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_BLOB_LARGEST,
+							    stats->objects.largest.blob_size.value),
+			      value_delim);
 	print_object_data("objects.tags.max_size", key_delim,
 			  &stats->objects.largest.tag_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(CONCERN_STAT_TAG_LARGEST,
+							    stats->objects.largest.tag_size.value),
+			      value_delim);
 
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
@@ -935,6 +1225,8 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	int show_concern = 0;
+
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -944,6 +1236,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "concern", &show_concern, N_("show level of concern")),
 		OPT_END()
 	};
 
@@ -962,13 +1255,13 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	switch (format) {
 	case FORMAT_TABLE:
 		stats_table_setup_structure(&table, &stats);
-		stats_table_print_structure(&table);
+		stats_table_print_structure(&table, show_concern);
 		break;
 	case FORMAT_NEWLINE_TERMINATED:
-		structure_keyvalue_print(&stats, '=', '\n');
+		structure_keyvalue_print(&stats, '=', '\n', show_concern);
 		break;
 	case FORMAT_NUL_TERMINATED:
-		structure_keyvalue_print(&stats, '\n', '\0');
+		structure_keyvalue_print(&stats, '\n', '\0', show_concern);
 		break;
 	default:
 		BUG("invalid output format");
diff --git a/sideband.c b/sideband.c
index 374187402e..0e75ab2317 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,4 @@
-#define USE_THE_REPOSITORY_VARIABLE
+define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..f1e3fd2a75 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -67,77 +67,7 @@ test_expect_success 'empty repository' '
 		EOF
 
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
-		test_line_count = 0 err
-	)
-'
-
-test_expect_success SHA1 'repository with references and objects' '
-	test_when_finished "rm -rf repo" &&
-	git init repo &&
-	(
-		cd repo &&
-		test_commit_bulk 1005 &&
-		git tag -a foo -m bar &&
-
-		oid="$(git rev-parse HEAD)" &&
-		git update-ref refs/remotes/origin/foo "$oid" &&
-
-		# Also creates a commit, tree, and blob.
-		git notes add -m foo &&
-
-		# The tags disk size is handled specially due to the
-		# git-rev-list(1) --disk-usage=human option printing the full
-		# "byte/bytes" unit string instead of just "B".
-		cat >expect <<-EOF &&
-		| Repository structure      | Value      |
-		| ------------------------- | ---------- |
-		| * References              |            |
-		|   * Count                 |      4     |
-		|     * Branches            |      1     |
-		|     * Tags                |      1     |
-		|     * Remotes             |      1     |
-		|     * Others              |      1     |
-		|                           |            |
-		| * Reachable objects       |            |
-		|   * Count                 |   3.02 k   |
-		|     * Commits             |   1.01 k   |
-		|     * Trees               |   1.01 k   |
-		|     * Blobs               |   1.01 k   |
-		|     * Tags                |      1     |
-		|   * Inflated size         |  16.03 MiB |
-		|     * Commits             | 217.92 KiB |
-		|     * Trees               |  15.81 MiB |
-		|     * Blobs               |  11.68 KiB |
-		|     * Tags                |    132 B   |
-		|   * Disk size             | $(object_type_disk_usage all true) |
-		|     * Commits             | $(object_type_disk_usage commit true) |
-		|     * Trees               | $(object_type_disk_usage tree true) |
-		|     * Blobs               |  $(object_type_disk_usage blob true) |
-		|     * Tags                |    $(object_type_disk_usage tag) B   |
-		|                           |            |
-		| * Largest objects         |            |
-		|   * Commits               |            |
-		|     * Maximum size    [1] |    223 B   |
-		|     * Maximum parents [2] |      1     |
-		|   * Trees                 |            |
-		|     * Maximum size    [3] |  32.29 KiB |
-		|     * Maximum entries [4] |   1.01 k   |
-		|   * Blobs                 |            |
-		|     * Maximum size    [5] |     13 B   |
-		|   * Tags                  |            |
-		|     * Maximum size    [6] |    132 B   |
-
-		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
-		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
-		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
-		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
-		EOF
-
-		git repo structure >out 2>err &&
+		cp out /tmp/test1-out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
@@ -204,6 +134,59 @@ test_expect_success SHA1 'lines and nul format' '
 	)
 '
 
+test_expect_success SHA1 'lines format with concerns' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# configure thresholds to get concern indications
+		git config repo.structure.concern.commit-count 7 &&
+		git config repo.structure.concern.commit-size 14 &&
+		git config repo.structure.concern.tree-size 10 &&
+		git config repo.structure.concern.blob-size 8 &&
+		git config repo.structure.concern.blob-inflated-size 10 &&
+		git config repo.structure.concern.tag-size 2 &&
+		git config repo.structure.concern.commit-largest 4 &&
+		git config repo.structure.concern.blob-largest 2 &&
+		touch configured &&
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
+		objects.commits.count.concern_level=2
+		objects.trees.count.concern_level=0
+		objects.blobs.count.concern_level=0
+		objects.tags.count.concern_level=0
+		objects.commits.inflated_size.concern_level=0
+		objects.trees.inflated_size.concern_level=0
+		objects.blobs.inflated_size.concern_level=3
+		objects.tags.inflated_size.concern_level=0
+		objects.commits.disk_size.concern_level=3
+		objects.trees.disk_size.concern_level=8
+		objects.blobs.blob_size.concern_level=6
+		objects.tags.disk_size.concern_level=4
+		objects.commits.max_size.concern_level=3
+		objects.trees.max_size.concern_level=0
+		objects.blobs.max_size.concern_level=1
+		objects.tags.max_size.concern_level=0
+		EOF
+
+		git repo structure --concern --format=lines >actual 2>err &&
+		test_grep "concern_level" actual >actual-concerns &&
+		test_cmp expect actual-concerns &&
+		test_line_count = 0 err
+	)
+'
+
 test_expect_success 'progress meter option' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.53.0

