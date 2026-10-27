Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115587;
	b=H4mPq94F2iM9KplYy0EmwP81Y/w9Z7AZ8Yu5jJCXsLyOhEWAnrulVkca8BU5JYBypsSZ
	 sSLb5AhncvGYgZR8+77xmx/vR99aqatkxaH14uFmIyasoUOGE8ZG6myLcMKwEweGKgdsU
	 4DmosTHRcCR8ckrQIvsk5kG1l62kxheb8shVUzp1uwuu4cnpoHGeX48LTQ+Uvj9wZt+KT
	 +fStm2LMyifLCnZTS98hXbE23I6rMvenVHLPFseIt61gilKUhKrvEP1zsIdOd85NwmZiD
	 NE58Y5KPv8q3nLnwnkV/6pvladG9JTA1S1VvwhhnweyRqcWJQeD0728L/hQXwySuz+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115587;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DrlEwciK/o1qk1c9ePvZ8EastGFdoqq36aUo8FMpK24=;
	b=ehV1e0FsTfQ+MsEuYxUaSgBI5PvR164KEd5bpDjxByX9N0tFBN4a/TU2zKaFVv1ILbio
	 cT1Sy4HJVY711XsXvRqzVHbOtZ1VgyHuUadKmdaLuteJjRjymLmQCKT5BNNTwigrJIlaa
	 qpgZweXxSFzMherjvTT1gHcmNLOLd5AmSEom38/2r376737pFZFkvlIULuMZqTqye+b1l
	 yL7ivgHn6meLsmfs+xGxnHuTmDZ86cP6DXoMMuZerOqXSU3k/atwiKKaMNqHPcJwNByKs
	 jmYtYeagLNCzPSLFz2kXSz1LgbCBswPRHlID/PkD5WhycHLPBla3OTPt+bDLZqvPhZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=BlSbg+Xt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WSjPQOvw;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EEB606B54F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EEB606B54F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=BlSbg+Xt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WSjPQOvw
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AF1F1EC0421
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:39:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 11:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793115585;
	 x=1793201985; bh=DrlEwciK/o1qk1c9ePvZ8EastGFdoqq36aUo8FMpK24=; b=
	BlSbg+XtfIfPzHn3eHJtZec7jERyRsC25wol6JqMcLl5vJVd7dXt4sWyHxwQrwVA
	45mHC1/ZSNN4u8l3XKUivQ7/XongAyXqC9p3J9039IS5KsITop94n9E+rkWgsGU9
	qQNBDiop+sYDYP6XxxSnGL+bL9a6829nlNKP7nLpqW2tZjTUa6SltVIU3GSDf+S4
	JdTQT9ZxPhEbgSKGAmsCR6h8kvffHl8tM9lHyGoPQbnWwzlMjVFikmCS/g6XzG0T
	2TnFIjbmmg08zBubUkqyGJi9uCGfhEoZY1jFb03T+D0XM7iivi1YgWVGO+hr3zBl
	4YabiaQxpR3c2FhnyA+UDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793115585; x=
	1793201985; bh=DrlEwciK/o1qk1c9ePvZ8EastGFdoqq36aUo8FMpK24=; b=W
	SjPQOvw0IZhw7z/LW327jbP2s3R9VXkplT0jk6DRwtp2BtDq2ylgsfWTY737au5w
	uw6PBdxwyra0q2r72kD2musjUAcArMspMvW4ANBbzMLBsdrkm9MiCb7gWJuePnEv
	TZY4bmgKY7pQ6uRVNkAysTy/JsqLwvZmjKGD1Z4paXxiuTGPCAKFYBRgf4XNBzzD
	KhtF/PzvlUR6JJoO8RGJ7Ee9Zd0FSqXMl18JJWSfHkm++5a6YMwJXpA8gdOTf3NG
	KDHAvFRUbvkmeWypxEaZ3F9QYbp7EaZyXUAt3sdVRmZoJj5SAtOlRySn9z1hizgJ
	KHc2CQwf5ceSJFdrB9G6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793115585; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a/3mIhctZmCfNr81sPXPj6dFcvG70RbAj0p6KYxXEaUvFGL
	f2ukvuH/9Qm/w20ccC0jRCGyzxjRYqGn/PSigxv+W3ZHGCLSyQndOCPQD2t7rTrQ
	vCRTcsDC3JNI5p6SX+tWHouUuS1m59Rb+xnFAau/ruY/AlGD1vP/YmcEuMm5LdCj
	wCDzsY344bT7/zGSjjkjkP+KOtjWxH1aFxwuQpN8HQ0hrWSmfNz7WlGhQvHX23wp
	T3XlK4HJHNZXj5UkSbV7yvAYRzkUhUxJLvctU7XBEcTI3ksGNeAFXc7an08E12DC
	FWsMkPwLqnK5ZlmPwwmD3YodFfmUy/tlGn7mEUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bpkop/z8N+A5wCw11AcOoDJZIcZ0uY9roO7hAFB3FFI=:oGMULIzZmQBwdFKDs3yXrXXM8VC0WnW2mXEsXoEMxTE=;
X-ME-Sender: <xms:wcXgah7pKJftHJFf2Ny5UXOSvC9teNNq3Hmzw6Mry3rGyPTVA38G-w>
    <xme:wcXgak7VF-KqyG5vIYsjxlngbGIzTDglhkYb7lE0USfIPAh1ZFrRz_jbGmFJc7IiL
    h0YAaKmN0IMuWoKwo8bE3fpiGkvr4BfpDHRrG8rzuDF4NKRzBCSgC_Trg>
X-ME-Received: <xmr:wcXgamHc-ik8RNyCqTikIMKz858pQW0gniILAd31Pv1_ohFVWBfzpcn6AW3kpGE4QZ_vXde6hafBKFSsqqKbeoCH>
X-ME-Proxy-Cause: dmFkZTFbrZu1YIrsQ4p0sFE8QndOYnCpZb9Tbga11NMPccvnXzkxzcia/tEz+CkG/cTnOw
    0kAEyoRyO9hfiyOjga6mX84fDqkQ0DJbMNDd42Q2coCAzgMfMYeLTumWhgpjfjXGRkUH5C
    MuhlkC03Tp/lyWyCE/STGkiipRrENuim738bT+yZ9rKdFRZZ/e3OlyEmx0/JkXGDF9Ipz9
    c6onnPKtRSrjrf+P5OEndFgSHjsaaLVhm5ZUM8eLW7jXSBusya3HUC8aO+Bq4Mvui+cdFB
    q3Bx5iErI8i8+BZ+OxeIILY0rPQ7xOf7vaDyW40Gm5kIAZYNkaoYBgmSMUYUcezILVXImu
    0pDJ7oCX2zrWloYxHRA9bw+9a5+RzMZtT4N9n9BFrCmOhGMvyS203ZsmZZL522a36hG0mF
    iZHCuZKAcxLs+frpsfzMzaS51dINfSKDuiRH9B3k866R5uAxmeJy2KHVeJVQdNUO/MaB9f
    N9Lt3H8AEqA5VlPhtuJWovaNwJskWDoK4oaRnj1N+T29UmTHg1JAx5xCCZHVNKiaNOWTQn
    5v0getHnvYDnARD3rgyu9hbLAx4jmpBbTyoOYRFBlczZ8CW8v9V/HOukUMlsRQr2kpxQlD
    eWtXq9p+EfVEsJqhOy8uqLmWmMNTkP7IbzdONiThIzeGb0f7Xfd88ViANWbw
X-ME-Proxy: <xmx:wcXgalREFbHMQ9ooUOdoASwhlHqoBf7ub1m_Pu6HtHkaV84QfLfqRg>
    <xmx:wcXgansNqECQAN3xbrSFonQNCMIATP6X_XBUT1qSswZ0pbMCkTCtJg>
    <xmx:wcXgaswqpjh3pOvVfnGgC9t7aeIc05yNuGopvmCsYMvbJLw7s7_W9g>
    <xmx:wcXgap4z2KA_BErev3_dd26lopfaATFM74rE3lWzU2TLoL9JcGJBTQ>
    <xmx:wcXgalTe7oBYFqWm1EGdNBToY15pHAWOXj7NpwIEwJiDRlp2El7VXWUk>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 11:39:45 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Tue, 27 Oct 2026 11:39:30 -0400
Subject: [PATCH v3 2/2] repo: make concern thresholds configurable
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
Message-Id: <20261027-b4-repo-structure-concern-v3-2-98d7a5704170@fastmail.com>
References: <20261027-b4-repo-structure-concern-v3-0-98d7a5704170@fastmail.com>
In-Reply-To: <20261027-b4-repo-structure-concern-v3-0-98d7a5704170@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19740;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=oGMULIzZmQBwdFKDs3yXrXXM8VC0WnW2mXEsXoEMxTE=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIeHN172PusqUGuut/Lrd7fud2qWQxDu7T/LNuR250me
 7zNZj9/RykLgxgXg6yYIsv/fwKNr1geSPgFvfsEM4eVCWQIAxenAEyktJbhN8uJDxKfpZM8d+yM
 SDwrZG4mVOGwqfpkZL73LB3H6v53BxgZJl/ODZtfvuTFbRnmSUVt4hd/CD98X+iZnnwlIdD14ut
 2bgA=
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
 Documentation/config/repo.adoc |  59 ++++++++++++++
 Documentation/git-repo.adoc    |  11 +++
 builtin/repo.c                 |  62 +++++++-------
 sideband.c                     |   2 +-
 t/t1901-repo-structure.sh      | 180 ++++++++++++++++++++++++++++++++++++++---
 5 files changed, 273 insertions(+), 41 deletions(-)

diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
new file mode 100644
index 0000000000..811b099d72
--- /dev/null
+++ b/Documentation/config/repo.adoc
@@ -0,0 +1,59 @@
+`repo.concern.commit-count`::
+	Sets the value of the concern threshold for commit count.
+
+`repo.concern.tree-count`::
+	Sets the value of the concern threshold for tree count.
+
+`repo.concern.blob-count`::
+	Sets the value of the concern threshold for blob count.
+
+`repo.concern.tag-count`::
+	Sets the value of the concern threshold for tag count.
+
+`repo.concern.commit-size`::
+	Sets the value of the concern threshold for total commit size.
+
+`repo.concern.tree-size`::
+	Sets the value of the concern threshold for total tree size.
+
+`repo.concern.blob-size`::
+	Sets the value of the concern threshold for total blob size.
+
+`repo.concern.tag-size`::
+	Sets the value of the concern threshold for total tag size.
+
+`repo.concern.commit-inflated-size`::
+	Sets the value of the concern threshold for total size
+	of all inflated commits.
+
+`repo.concern.tree-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated trees.
+
+`repo.concern.blob-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated blobs.
+
+`repo.concern.tag-inflated-size`::
+	Sets the value of the concern threshold for the total size
+	of all inflated tags.
+
+`repo.concern.commit-largest`::
+	Sets the value of the concern threshold the size of the largest
+	commit.
+
+`repo.concern.tree-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tree.
+
+`repo.concern.blob-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest blob.
+
+`repo.concern.tag-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tag.
+
+All of the concern thresholds are integer values for the
+floor of the base-2 log of the threshold value. The default values
+of each threshold are set to heuristically determined values.
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index f186b27d87..516403e17d 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -101,6 +101,8 @@ statistic value. The value is considered concerning if it exceeds a heuristicall
 chosen threshold value; the degree of concern is the difference between the
 log_2 of the value, and the log_2 of the corresponding threshold.
 
+The threshold values are configurable; see the configuration section below.
+
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
@@ -153,6 +155,15 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+:git-repo: 1
+include::config/repo.adoc[]
+
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
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

