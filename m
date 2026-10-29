Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296355;
	b=5VAzPb5SGWv3/9OI10Apu8ykjsMMBK0kjDdkUQ5BKCkTFoa9kASE345q68y4vQUbdhY/
	 08LI7rEkOTmEZLbKuiFUgYkaSf+hCX6mM2mtu+1VTDRVodQbWjTqQPg3bwYg56GkankAS
	 oLUaf1fIiUKJWxho3FFOhAGQqGeORt/vYTCtH+zy1rJ2qCPJ01Q7nxMNNmOB6urVJtPg6
	 rMY4tUxgu8TcJvVjoluDLPW3mfLU5ZI+zXc3J2zOwNORjM7FhUv+h20t/Wspvdb2GvyLn
	 q3RjZTdMcFOWdRDfisCgjmZoJHhOgUezTVP07q2F68v/usnfBPYrF6cQ8rSws2SnIGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gmQAj8smqbOekXedK4tzHEZ6HCCvPe1Xl0gRWee0LtQ=;
	b=3fLPsWD/q1gEEiR1g88I3B6JEw3DTneb8WpZod6bqWaZDwWFnW72FJZ7JQQ/b+x2godN
	 nnSet+nUsjTGUfgqjrELLuHp2rZMZuK/9YPVazHxAGzKTxqCvqJPCutFsH6uEL/pCbrto
	 EFhMw3iuoRmSm/7UiC4Slnm4Np/A/OTbytIZti9+rbw6yb3eLLwPu+CFV6WXWY9DOQxZ2
	 f33xStxVbsm4PEGYkikQA9HDiEAI01Z19HSkDuyq3smPI5UGPANTa+KiN8yMjvHZV9ucO
	 YkJoPFKPuDHnCyFedVC/uk8A5CbQG2rtzj2dOA5YhpXR3COyY4WuZTz6gh+X7+vwpWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GuJBuQ4J;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="JU3ngK/U";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A4606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50A4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GuJBuQ4J;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JU3ngK/U
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67A587A0101
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:52:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 13:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793296354;
	 x=1793382754; bh=gmQAj8smqbOekXedK4tzHEZ6HCCvPe1Xl0gRWee0LtQ=; b=
	GuJBuQ4JVFxOP9jAq9PMwjsBvnPf20OEEDjhGZUXgIXpvgukUBMjBCO93hPRiS04
	M/5cwwJtePKWs4gvX4SwY5J+9YouTx9T1GNcA9wVeE01tleVki9vMU9LQR7eajNT
	tGnDW2PiX3XEWazvKmW+9oe/Ugewj53rDTM/wvWniWzXqBceNgeNfAs/L+LBkQ6D
	KecAnOnzYOj9AJDY5e6Z8hzofajdjK4bpUNq5ST20zJbZ/f12Ke7uU5jjNzdaYQC
	HcL0C8w//tuWY3Y9c+6RnxQb9DoyWb2uamELWmzzdICmdOzIR9LnRE+stJopT7kg
	wzPZUJNGzEYmqFbCf9ExWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793296354; x=
	1793382754; bh=gmQAj8smqbOekXedK4tzHEZ6HCCvPe1Xl0gRWee0LtQ=; b=J
	U3ngK/Uf0b5JdpbuSD7hjeWFhJqZ9+J/4TxSNYxdNWOgcnnElskQXai6pI/xunk8
	u56DOIq/Eq2w6DvumEHTNbGics5OUgUNC1CPv1YMpH33oOLIJ6Ka50Xhk9jcnQ2b
	at/Eh1LYqe8j63ZlUTH6eYGb4OtSbwZaNobu0akXt81VCOjaGI4190nj0TKjnP6W
	n/xn7xCz0q2/kSnUjPHELjRbrtV7tv4BkOWkot/vurvzSCNJUeK2dGCjTy2nAu3Q
	FTm/0gVLkidGwZmjK9lMj+bh/ZIkVpZCmmAr4xaUEUTdYIqx/35exc7KGnwlDCvR
	Sw99XGnMM9gwaywET/Z1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793296354; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CV2mnWqnN0k5+Rj5aiexeL19tzu3kXhAbad+I3EYxOxgEiD
	lcxcdFGbHkEDukgtsatQ41J2wAo7d++r8QoG5C1QshKUxeWfm12KEITWWBJJ3MwN
	wgbAJuVwcOBj1myHjmI59MKNB84hOU8n2lV9YS/zeLBZimM5OEqFOssSuNxyLjid
	aHR9x8Fw51iF0oaXOkyV+8IMuz3AkirhWIBSMgLGs+3ljTJbO45kjQcI+HPkjlEY
	MUMnZsftj7liQ80jLULO5zdnPYr6WRYhojRfuTKGSy0PWBtJtX7SYHTALrkyvIUR
	+3G/YCwS4dEPPqkf3ByAJc7Zw1ITZxKzP5GR+pA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yvg/eSKKaX1Vuyp2O8qDaGgVkLo7vMMMXztBI1XDTIo=:KfzJVPq72VBvFBTyn/w+wwMN7dBYVwhEvA+99m1z0LY=;
X-ME-Sender: <xms:4ofjahyWYRufZiXSJ6MZm4Reh5zoPq47uEL5ZoOcOLxjQOJEC9gP0g>
    <xme:4ofjanSxzddjzn6_b7085NiuBfT3YLixPUSyGJr8C-RoZg-GzSRHPC6qKMD5xLKXn
    i2lrkTt-JkpFz3-mYggPjVDtYiRu9pZJy3bn1CLdBQtai9OEZJus2tGBA>
X-ME-Received: <xmr:4ofjao-8OxPPqXYg6KG7Mc6u1pYjOssns4QrzUdgjznJWa9L_-sVq0akpdK-PJf9Creh8wzKJDde3JZWz8CXVaCMayucWtouttRQJ-L85j_60xZFu77O52eX-lmn>
X-ME-Proxy-Cause: dmFkZTE/VjdBqvwNLfrp4gI9rckMWet5kQuYx3L9iVPgMhaXWIaNlB09fdNrOV3y0C9gDA
    Oteq/SalDEeZjHMXpA16MOhIyyiiSnj2/0KcLmKB/woHaZib4TW6sHGpFwJkYTFf0U94Wg
    bx+o1hj4lJjqv2W0mlRo1pXQyuxIzzyrvEF2gHTcXVWsdZpacu46CnM3UQyKkO+u8+51a9
    YYDQxy0p3jvErUxpRBiJarRH6f8+w9QPvuYwaLB4++kMPWdOZkRm7L5cbU7U8oNnCH5R6x
    Z/7Y4tAwxr/+uihHDiPmXsJr2RWwPF8ymc+Gqsu8O4jR+XbWSakeBx4KitSUTRPSWR8/Zx
    yXLlgAmyHE6KnVjsXioRUXpGw08f9QZHRV+1Jr1iMdPM+YR3j5buiEzc6MTSC4KBzuPOB3
    CcU5W5sVHD26JjU76lKQ8yAbfYSZ/zv1TPrJDSNwG1vO15OATJLu9lFbAGp7jwg6VwCFpC
    kTWqnjeH0OjTuVijifOVYKn3IxixQKiafWOx41p1Zc0xnrMORl0P5yl3PJktBxBGU5Qq+P
    KnLonUB5ET971TOf5cQwLdJB8ZCobKr2//0arsVLMuCTbJapDWgV3hmAPsImHcsnSwPR04
    2nu4f7AiPNN60x3Pw1M2bg0MswADuAxmSm7eEduxojL6jmXGnvOFa7dIGF0w
X-ME-Proxy: <xmx:4ofjauoLhtm9_HOd6ycasuZw3l6f6J2vJyw9Lj4bMuHEEcz5QwnBaw>
    <xmx:4ofjalnMRd6bgh4qWWnSr8eI2-RzvZZ1w7Syif2xTzNHZD0ABsLE1Q>
    <xmx:4ofjalLj84YjnZyfw8DmlLLLTLWKV_7pBNIQ2P5Dgevg42DAavA9Dg>
    <xmx:4ofjaqwoQBtBLYId7xbG4g22McaPsbtRvx0ZVS5gcwVBXszlbHaqRg>
    <xmx:4ofjalLiJyIjfBG4zxWqxORHWfnpWukeKlHiZPAnRv2GmkyW6ilh6L30>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 13:52:33 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Thu, 29 Oct 2026 13:52:22 -0400
Subject: [PATCH v4 1/2] repo: add level of concern reporting
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
Message-Id: <20261029-b4-repo-structure-concern-v4-1-d813537ec617@fastmail.com>
References: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
In-Reply-To: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30591;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=KfzJVPq72VBvFBTyn/w+wwMN7dBYVwhEvA+99m1z0LY=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIet9+/OWftoe6YxTPZ0vSE9OZcK8yM/1XU8D42xFxtB
 X/R/uPRHaUsDGJcDLJiiiz//wk0vmJ5IOEX9O4TzBxWJpAhDFycAjCRkxMY/pcGbVrmwMT8Rydt
 wrL1cz0uprvN1Z1xxvbpZL74/z4njkcyMpwvVjC5d31Z+eF1uc2L1yZe0mk75Th337ZzJyalnxF
 PMOEBAA==
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

"git repo structure" computes a set of statistics
that are useful for diagnosing performance issues in
a git repository. But for a typical user who hasn't
encountered any issues yet, it can be difficult to
interpret the data - when should a value be considered
concerning?

Add a new option to "git repo structure" which causes it
to generate an additional column providing a level of concern
for many values.

To select defaults for the thresholds where a value becomes concern,
a (hopefully) representative selection of repositories were analyzed.
Based on empirical exploration of the data, the measurement that seemed
closest to accurately assessing when a repository's structure becomes
concerning was based on the base 2 logarithm of the value. Across all of
the sample repositories, for all of the measurements, the point at which
things become problematic was when a base 2 logarithm of a value was
more than 1 standard deviation from the mean of the log_2 values in
the sample set.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/git-repo.adoc |  16 +-
 builtin/repo.c              | 370 ++++++++++++++++++++++++++++++++++++++++----
 repo.c                      |   1 +
 t/t1901-repo-structure.sh   |   1 +
 4 files changed, 359 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..f186b27d87 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]
 
 DESCRIPTION
 -----------
@@ -56,7 +56,7 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z] [--[no-]concern]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -88,6 +88,18 @@ supported:
 	quoted.
 +
 `-z` is an alias for `--format=nul`.
++
+To make it easier to know when one of the values is something that
+users should be concerned about, adding '--concern' will provide a
+level of concern to be added to the output. In 'table' mode, this will
+be a table column indicating the level of concern as a number of stars;
+in `lines` or `nul` mode, a `concern_level` line will be added for each
+statistic with a numeric value.
++
+The level of concern for each statistic is computed using the log_2 of the
+statistic value. The value is considered concerning if it exceeds a heuristically
+chosen threshold value; the degree of concern is the difference between the
+log_2 of the value, and the log_2 of the corresponding threshold.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..bd1866c5fa 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -21,13 +21,14 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
+#include "wrapper.h"
 
 #define REPO_INFO_USAGE \
 	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
 	"git repo info --keys [--format=(lines|nul) | -z]"
 
 #define REPO_STRUCTURE_USAGE \
-	"git repo structure [--format=(table|lines|nul) | -z]"
+	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -348,8 +349,87 @@ struct stats_table {
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
+#define CONCERN_STAT_COMMIT_COUNT "commit-count"
+#define CONCERN_STAT_TREE_COUNT "tree-count"
+#define CONCERN_STAT_BLOB_COUNT "blob-count"
+#define CONCERN_STAT_TAG_COUNT "tag-count"
+#define CONCERN_STAT_COMMIT_SIZE "commit-size"
+#define CONCERN_STAT_TREE_SIZE "tree-size"
+#define CONCERN_STAT_BLOB_SIZE "blob-size"
+#define CONCERN_STAT_TAG_SIZE "tag-size"
+#define CONCERN_STAT_COMMIT_LARGEST "commit-largest"
+#define CONCERN_STAT_TREE_LARGEST "tree-largest"
+#define CONCERN_STAT_BLOB_LARGEST "blob-largest"
+#define CONCERN_STAT_TAG_LARGEST "tag-largest"
+#define CONCERN_STAT_COMMIT_INFLATED_SIZE "commit-inflated-size"
+#define CONCERN_STAT_TREE_INFLATED_SIZE "tree-inflated-size"
+#define CONCERN_STAT_BLOB_INFLATED_SIZE "blob-inflated-size"
+#define CONCERN_STAT_TAG_INFLATED_SIZE "tag-inflated-size"
+
+struct concern_stat_threshold repo_structure_concern_thresholds[] = {
+	{ .name = CONCERN_STAT_COMMIT_COUNT, .threshold = 19 },
+	{ .name = CONCERN_STAT_TREE_COUNT, .threshold = 21 },
+	{ .name = CONCERN_STAT_BLOB_COUNT, .threshold = 22 },
+	{ .name = CONCERN_STAT_TAG_COUNT, .threshold = 15 },
+	{ .name = CONCERN_STAT_COMMIT_SIZE, .threshold = 28 },
+	{ .name = CONCERN_STAT_TREE_SIZE, .threshold = 27 },
+	{ .name = CONCERN_STAT_BLOB_SIZE, .threshold = 36 },
+	{ .name = CONCERN_STAT_TAG_SIZE, .threshold = 18 },
+	{ .name = CONCERN_STAT_COMMIT_LARGEST, .threshold = 18  },
+	{ .name = CONCERN_STAT_TREE_LARGEST, .threshold = 18 },
+	{ .name = CONCERN_STAT_BLOB_LARGEST, .threshold = 26 },
+	{ .name = CONCERN_STAT_TAG_LARGEST, .threshold =  15 },
+	{ .name = CONCERN_STAT_COMMIT_INFLATED_SIZE, .threshold = 28 },
+	{ .name = CONCERN_STAT_TREE_INFLATED_SIZE, .threshold = 32 },
+	{ .name = CONCERN_STAT_BLOB_INFLATED_SIZE, .threshold = 34 },
+	{ .name = CONCERN_STAT_TAG_INFLATED_SIZE, .threshold = 25 },
+	{ 0 }
+};
+
+static size_t get_concern_threshold(const char *name, struct concern_stat_threshold *thresholds) {
+	for (size_t i = 0; thresholds[i].name; i++) {
+		if (!strcmp(thresholds[i].name, name)) {
+			return thresholds[i].threshold;
+		}
+	}
+	return 0;
+}
+
+static size_t repo_structure_concern_level(const char* concern_name,
+					   size_t value,
+					   struct concern_stat_threshold *thresholds) {
+	const size_t threshold = get_concern_threshold(concern_name, thresholds);
+	size_t log_value;
+	if (threshold == 0)
+		BUG("unexpected repository stat threshold: '%s'", concern_name);
+	log_value = log2u(value);
+	if (log_value > threshold)
+		return log_value - threshold;
+	else
+		return 0;
+}
+
 /*
  * Holds column data that gets stored for each row.
  */
@@ -358,6 +438,7 @@ struct stats_table_entry {
 	const char *unit;
 	size_t index;
 	struct object_id *oid;
+	size_t concern;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -391,6 +472,8 @@ static void stats_table_vaddf(struct stats_table *table,
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
+	if ((int)entry->concern > table->concern_col_width)
+		table->concern_col_width = entry->concern;
 	if (entry->unit) {
 		int unit_width = utf8_strwidth(entry->unit);
 		if (unit_width > table->unit_col_width)
@@ -409,14 +492,19 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
 	va_end(ap);
 }
 
+// define a symbol for 'no concern value for this stat'; this will
+// make the code below easier to read.
+#define CONCERN_STAT_VALUE_NONE 0
+
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
@@ -425,13 +513,14 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 
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
@@ -445,6 +534,7 @@ static void stats_table_object_count_addf(struct stats_table *table,
 }
 
 static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  size_t concern,
 				  const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -452,6 +542,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -460,6 +551,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 static void stats_table_object_size_addf(struct stats_table *table,
 					 struct object_id *oid, size_t value,
+					 size_t concern,
 					 const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -467,6 +559,7 @@ static void stats_table_object_size_addf(struct stats_table *table,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	/*
 	 * A NULL OID should not have a table annotation.
@@ -501,47 +594,104 @@ static void stats_table_setup_structure(struct stats_table *table,
 
 	ref_total = get_total_reference_count(refs);
 	stats_table_addf(table, "* %s", _("References"));
-	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
-	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
-	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
-	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
-
+	stats_table_count_addf(table, ref_total, CONCERN_STAT_VALUE_NONE,
+			       "  * %s", _("Count"));
+	stats_table_count_addf(table, refs->branches, CONCERN_STAT_VALUE_NONE,
+			       "    * %s", _("Branches"));
+	stats_table_count_addf(table, refs->tags,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       refs->tags,
+    			               repo_structure_concern_thresholds),
+			       "    * %s", _("Tags"));
+	stats_table_count_addf(table, refs->remotes, CONCERN_STAT_VALUE_NONE,
+			       "    * %s", _("Remotes"));
+	stats_table_count_addf(table, refs->others, CONCERN_STAT_VALUE_NONE,
+			       "    * %s", _("Others"));
 	object_count_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Reachable objects"));
-	stats_table_count_addf(table, object_count_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, object_count_total, CONCERN_STAT_VALUE_NONE,
+			       "  * %s", _("Count"));
 	stats_table_count_addf(table, objects->type_counts.commits,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_COUNT,
+				       objects->type_counts.commits,
+				       repo_structure_concern_thresholds),
 			       "    * %s", _("Commits"));
 	stats_table_count_addf(table, objects->type_counts.trees,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_COUNT,
+				       objects->type_counts.trees,
+				       repo_structure_concern_thresholds),
 			       "    * %s", _("Trees"));
 	stats_table_count_addf(table, objects->type_counts.blobs,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_COUNT,
+				       objects->type_counts.blobs,
+				       repo_structure_concern_thresholds),
 			       "    * %s", _("Blobs"));
 	stats_table_count_addf(table, objects->type_counts.tags,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       objects->type_counts.tags,
+				       repo_structure_concern_thresholds),
 			       "    * %s", _("Tags"));
 
 	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
-	stats_table_size_addf(table, inflated_object_total,
+	stats_table_size_addf(table, inflated_object_total, CONCERN_STAT_VALUE_NONE,
 			      "  * %s", _("Inflated size"));
 	stats_table_size_addf(table, objects->inflated_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_INFLATED_SIZE,
+				      objects->inflated_sizes.commits,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->inflated_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_INFLATED_SIZE,
+				      objects->inflated_sizes.trees,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->inflated_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_INFLATED_SIZE,
+				      objects->inflated_sizes.blobs,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_INFLATED_SIZE,
+				      objects->inflated_sizes.tags,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Tags"));
 
 	disk_object_total = get_total_object_values(&objects->disk_sizes);
-	stats_table_size_addf(table, disk_object_total,
+	stats_table_size_addf(table, disk_object_total, CONCERN_STAT_VALUE_NONE,
 			      "  * %s", _("Disk size"));
 	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_SIZE,
+				      objects->disk_sizes.commits,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_SIZE,
+				      objects->disk_sizes.trees,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_SIZE,
+				      objects->disk_sizes.blobs,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_SIZE,
+				      objects->disk_sizes.tags,
+				      repo_structure_concern_thresholds),
 			      "    * %s", _("Tags"));
 
 	stats_table_addf(table, "");
@@ -550,51 +700,76 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_object_size_addf(table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_COMMIT_LARGEST,
+					     objects->largest.commit_size.value,
+					     repo_structure_concern_thresholds),
 				     "    * %s", _("Maximum size"));
 	stats_table_object_count_addf(table,
 				      &objects->largest.parent_count.oid,
 				      objects->largest.parent_count.value,
+				      CONCERN_STAT_VALUE_NONE,
 				      "    * %s", _("Maximum parents"));
 	stats_table_addf(table, "  * %s", _("Trees"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tree_size.oid,
 				     objects->largest.tree_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_TREE_LARGEST,
+					     objects->largest.commit_size.value,
+					     repo_structure_concern_thresholds),
 				     "    * %s", _("Maximum size"));
+
 	stats_table_object_count_addf(table,
-				      &objects->largest.tree_entries.oid,
-				      objects->largest.tree_entries.value,
-				      "    * %s", _("Maximum entries"));
+				     &objects->largest.tree_entries.oid,
+				     objects->largest.tree_entries.value,
+			             CONCERN_STAT_VALUE_NONE,
+				     "    * %s", _("Maximum entries"));
 	stats_table_addf(table, "  * %s", _("Blobs"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.blob_size.oid,
 				     objects->largest.blob_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_BLOB_LARGEST,
+					     objects->largest.blob_size.value,
+					     repo_structure_concern_thresholds),
 				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Tags"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tag_size.oid,
 				     objects->largest.tag_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_TAG_LARGEST,
+					     objects->largest.tag_size.value,
+					     repo_structure_concern_thresholds),
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
@@ -602,6 +777,12 @@ static void stats_table_print_structure(const struct stats_table *table)
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
@@ -610,17 +791,28 @@ static void stats_table_print_structure(const struct stats_table *table)
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
@@ -638,6 +830,11 @@ static void stats_table_print_structure(const struct stats_table *table)
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
 
@@ -681,12 +878,15 @@ static void print_object_data(const char *key, char key_delim,
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
@@ -694,39 +894,153 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 
 	print_keyvalue("objects.commits.count", key_delim,
 		       stats->objects.type_counts.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_COUNT,
+				       stats->objects.type_counts.commits,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.trees.count", key_delim,
 		       stats->objects.type_counts.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_COUNT,
+				       stats->objects.type_counts.trees,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.blobs.count", key_delim,
 		       stats->objects.type_counts.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_COUNT,
+				       stats->objects.type_counts.blobs,
+				       repo_structure_concern_thresholds),
+		 value_delim);
 	print_keyvalue("objects.tags.count", key_delim,
-		       stats->objects.type_counts.tags, value_delim);
+		stats->objects.type_counts.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       stats->objects.type_counts.tags,
+				       repo_structure_concern_thresholds),
+		 	       value_delim);
 
 	print_keyvalue("objects.commits.inflated_size", key_delim,
-		       stats->objects.inflated_sizes.commits, value_delim);
+		stats->objects.inflated_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.commits,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.trees.inflated_size", key_delim,
-		       stats->objects.inflated_sizes.trees, value_delim);
+		stats->objects.inflated_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.trees,
+				       repo_structure_concern_thresholds),
+			       value_delim);
+
 	print_keyvalue("objects.blobs.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.blobs,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.tags.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.tags,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 
 	print_keyvalue("objects.commits.disk_size", key_delim,
 		       stats->objects.disk_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_SIZE,
+				       stats->objects.disk_sizes.commits,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.trees.disk_size", key_delim,
 		       stats->objects.disk_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_SIZE,
+				       stats->objects.disk_sizes.trees,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
+	if (show_concern)
+
+		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_SIZE,
+				       stats->objects.disk_sizes.blobs,
+				       repo_structure_concern_thresholds),
+			      value_delim);
 	print_keyvalue("objects.tags.disk_size", key_delim,
 		       stats->objects.disk_sizes.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_SIZE,
+				       stats->objects.disk_sizes.tags,
+				       repo_structure_concern_thresholds),
+			      value_delim);
 
 	print_object_data("objects.commits.max_size", key_delim,
 			  &stats->objects.largest.commit_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_LARGEST,
+				       stats->objects.largest.commit_size.value,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_object_data("objects.trees.max_size", key_delim,
 			  &stats->objects.largest.tree_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_LARGEST,
+				       stats->objects.largest.tree_size.value,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_object_data("objects.blobs.max_size", key_delim,
 			  &stats->objects.largest.blob_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_LARGEST,
+				       stats->objects.largest.blob_size.value,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 	print_object_data("objects.tags.max_size", key_delim,
-			  &stats->objects.largest.tag_size, value_delim);
+		          &stats->objects.largest.tag_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_LARGEST,
+				       stats->objects.largest.tag_size.value,
+				       repo_structure_concern_thresholds),
+			       value_delim);
 
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
@@ -935,6 +1249,8 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	int show_concern = 0;
+
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -944,13 +1260,13 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "concern", &show_concern, N_("show level of concern")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
-
 	repo_init_revisions(repo, &revs, prefix);
 
 	if (show_progress < 0)
@@ -962,13 +1278,13 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
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
diff --git a/repo.c b/repo.c
new file mode 100644
index 0000000000..51f8b7042e
--- /dev/null
+++ b/repo.c
@@ -0,0 +1 @@
+#include "repo.h"
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..f92168025b 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -67,6 +67,7 @@ test_expect_success 'empty repository' '
 		EOF
 
 		git repo structure >out 2>err &&
+		cp out /tmp/test1-out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err

-- 
2.53.0

