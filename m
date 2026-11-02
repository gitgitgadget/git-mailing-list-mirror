Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637178;
	b=jTYc7NTlzMK7eJjfnKKyNynkGrcM1RFcYwU1YwDtNwG9bZydY+USLam48V4mXHQtkQ+q
	 MNBq5oR+qRy23AGXMhBl9jTIP3/rTO98FRNYGeERrD9W7NY5BarfrZhXw8y5BtKr9NmAL
	 bVkEqWIA6z3zCl5hugFgipxmpMKAc2TXJCXeFagfnliHY4KQIBo+2VSx/W7+8UlGJ8d9S
	 9zEoxIBiqlhLYdBRL2sidqB1tyYrubxq9z1gPCsw2VP+S7B4fueVaLj23epOjHrOzuVI5
	 uA/hORk/7tv300IVYdV6H8HwdeDNFUKZYrRKdPKb5voVwcLZnSy4KMjPH/MrAGnNgBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/9C3ZZ+d5esWe5Jr9U1cns9OBNuDSo6LjsB3xWBHDz4=;
	b=ZmoquGFl7O6kL+nqLf2vBGeLXPlAQlU1DCVtKlpxCuCKWkC/XkDAWQ9bgASwSLX1Xyrg
	 2dx0PGCg9dBYbNMPbw4zNfzu3sJvKgDE9s1SP2R4AiEkIotj8nxYgIyVgSDBiX+FQACei
	 Rfs3XyhiRAl7RPP4IU/KFkM/QJMGrKryNTZCRdgpWdcS7b0l8JUoxOL74wVQPIBxuTSJP
	 sJWx+68sWw36iXLInd7qnu0sCck4I67bZnhEhc07uI062qFs5HZ7h/4tJmob56lgZFKXM
	 3tCZIpVkvWK3YmNnxzJ5R7KpTz6dU7R6m0U8fRhJKlZ3Cgn3T5P7fAtqRnYanM+sjMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=O4TNRrSq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DPRsbrbx;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E406608B059
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E406608B059
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=O4TNRrSq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DPRsbrbx
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7460614001C4
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:32:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 11:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793637176;
	 x=1793723576; bh=/9C3ZZ+d5esWe5Jr9U1cns9OBNuDSo6LjsB3xWBHDz4=; b=
	O4TNRrSqmiijUnCyV2LUGxt6VU3zCnbvFdk+2quYEfk4sfIvR4skNPfchDfyKZKH
	n2lo8avLyokpSO72XuYem1K8AUCcJOKFXOqFCOR1a1ABftbWxVptFjY/ogIocu57
	DHOM8HoscjcrZj64FlqaXUfkFxyrOt2gfAQUMo9gtiA7Df4O71I94/LHyVJmtUOZ
	sxuPO5VIxbqmZMZ4Vrf2AW97AD4acqmEx/qGpMRb4TsuPXnE7p9X/CPyFtusZAyT
	a2YiRoI/J/Cao4Nvdcp9yr2XGrnKHapMSLz9vjvh7+9qGM5F0y3WPIEcw9vmzyhv
	Aw6G6bEcwNDjxAS4kcAPPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793637176; x=
	1793723576; bh=/9C3ZZ+d5esWe5Jr9U1cns9OBNuDSo6LjsB3xWBHDz4=; b=D
	PRsbrbx+nlZkAaiYF7UnLgA7vxqSFimDc4uYmR82bB+MA2qkvMPmj7QexgnL5kwD
	FL64Z5NoZYCF1VLttqLzcPM1649xFx2ZlZPbf9QOGwsLaxxnPSxxR41E7PcbW/lh
	ZuivWMFp43Z+CcdBgzd3tZQVBrdKNwD5/DlKpcL9mSKSH7A6DXE5IvwCJLDl8AcB
	C561UEclWx0JSOjzIpvxEjOGhFahF1oCpC1DveIlIUeAIvi2h51mMJBFdz4jEIfg
	2cXAG7jsXuin/s59nwQphG12c3UG5xy9MYO32Wax35eTL/7VTLF7nbI+zEkrcjyV
	f3D0Sghwpf+6Syfs5NP3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793637176; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qjm88S999oT3IQo5xX+AmUt0aUxGkua09potv2qwG07ijNl
	urPTOuSDhVthOlQIY5L2BqA4hCSVcPwydBJ/crx05XokPik7hfLOTmi19Z2Y5rVO
	IvTbRhLwASVHz9pNYsevSjwFhLNzALfY9RrkyvFqL5Aej1L8WTyKp1Kc+0Avx/qf
	HJyfKYc6Lc3d3zNeoH25p0ecW9ZkfgIxLjgP34Z87EHaRukQ41uliLVZbKBBuxnT
	71hR3druH08zf1hGUa+Lb3q6EOfAP3BqwSHVD/EJu7NQn8BO7rHfZxxcsvNJVQk8
	upHt4XutnFMPRhjss8Od5f331ajD4822QnVPKhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vIlfA8IM5gbQOREntGFG5Sg1/BsWXqpRagVxneaToXE=:KLFSyxGhiV/6SqoOZITrlee7TQEj/qBsQeium/DUQH0=;
X-ME-Sender: <xms:OLvoaph8GkTaHwO2JGSAyRcC_BsL7b_cFHpQJPn64Ezv199nkCW3vA>
    <xme:OLvoakA86086FpyTux1lUdMezkhGCUhvPdlqyII_DayP3x6xt_llpRLG8tdfxjbsd
    oMdZfXM_aFC-fuvFuV8fLmJ5cRTgP0iByHaquxWl_MQV_5Fv1MGNak7>
X-ME-Received: <xmr:OLvoamsdk56L1t5dM6CpOemUTR8J_5CGmHcvgUVe4pG0fS2WBo01J0doYZurnA>
X-ME-Proxy-Cause: dmFkZTFR3HxVgQVqvHA2IOoLpvY76lDf+KJM6IdxIhGJKH6g4doFbosYx5VJ3TEtegRcj7
    dsFar0YOEKgKf5A+L+kjc4XuCf3NWu7az3wcGgLTO5DzL2o1P4briZqUqT8Soz6ekTBnk/
    e+jrTNvbW82lymEcH/T2y8SNjDu37RPtqS/LT8+Je2zxE5+6HRpODwNYbr+lmIwnPHLaKw
    wOQQ20MlXbOPW4ghs1iqIZupZKVkCp0W/UeEnYqmuL2UnhYDSjYlQ+w+b6GP1ytMffwS7k
    2sLhz05r6EHcbfa64x80SBnXZiYKIxuhK2UvpV+fSekoaj5HeydXjKkRYwW3iGawsXdxNH
    2M8GEoq8hv/PoZMIA03neP1BTWv0clD5IZKB2FvIZkJb4gqtofAXLfyaZB2EySPfRPRncc
    nNNDWdVvp/F4J7imA8GwnI9Q95o/m6Xhf5uzg6DDiO5VS/ibguEbzkrCkmdHxv5Fsquugl
    mTdrdh+q8kBF9j+I+nFyoIou9pXD0XjmwgGmLDwTmjmGQNfXsy1XVYYqCFuHpyTjnCIhXi
    GILzgQvFN1q5kb842hAEeXApEdt9IShn1uZkNx6jErcwsNNKFLhRiP9KhKYNxWv787N6tj
    wlK3Ok0niiqZYmQ4D1K0pI3qr6KR/87i5OYyMoT2u0EpJ0EWxB7qUgHgANGQ
X-ME-Proxy: <xmx:OLvoapbxj8Ei1ZOHgW_UrH1o1rSHJnsz6eOf7GM7yXdRSq4ZptzHMw>
    <xmx:OLvoapUeZXELfQvG8rGDNtFDALctQ_whajS4euLSwo7CVsD9y3SmLA>
    <xmx:OLvoat7OeyZYe26gLBqtantkCzhagV1qTuNDXVrXSL23D97fPP3Q2g>
    <xmx:OLvoakg7z7Kg0m6aY9J8clhdajMNYjYk8ZDM0JegpBgtx9NPF7jzfg>
    <xmx:OLvoas62IVKZYJuHBK6dWVnlGo-jGuCUscv9uzAxkRDOp8OY6sOmdDBX>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 11:32:56 -0500 (EST)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Mon, 02 Nov 2026 11:32:43 -0500
Subject: [PATCH v5 1/2] repo: add level of concern reporting
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
Message-Id: <20261102-b4-repo-structure-concern-v5-1-2d8f37b70b75@fastmail.com>
References: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
In-Reply-To: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=32198;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=KLFSyxGhiV/6SqoOZITrlee7TQEj/qBsQeium/DUQH0=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJe7DY7U73Z8ETEroBNfzcd3vW74VCbr5qVptN0lhqFX
 CsBx9L0jlIWBjEuBlkxRZb//wQaX7E8kPALevcJZg4rE8gQBi5OAZhIdzkjw8nEq7W8fz42BGya
 ojVt227eLO3jYal8G+KCG1Qb5igWHGP4Z+ARePFF9cT0xhCnLQ37PVM/qOUE1V/Szp2hyqQtdya
 SDQA=
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
 builtin/repo.c              | 419 ++++++++++++++++++++++++++++++++++++++++----
 t/t1901-repo-structure.sh   |   1 -
 3 files changed, 397 insertions(+), 39 deletions(-)

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
index 84e012f83f..7a50605779 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,7 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "commit.h"
+#include "config.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -21,13 +23,16 @@
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
+
+#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -348,8 +353,93 @@ struct stats_table {
 	int name_col_width;
 	int value_col_width;
 	int unit_col_width;
+	size_t max_concern_value;
+};
+
+/*
+ * For computing level of concern about a stat, we need to have some
+ * baseline values. For each of these, we define a minimum level
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
 };
 
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
+static struct concern_stat_threshold repo_structure_concern_thresholds[] = {
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
+static int get_concern_threshold(const char *name, struct concern_stat_threshold *thresholds)
+{
+	for (size_t i = 0; thresholds[i].name; i++) {
+		if (!strcmp(thresholds[i].name, name))
+			return thresholds[i].threshold;
+	}
+	return -1;
+}
+
+static int repo_structure_concern_level(const char *concern_name,
+					size_t value,
+					struct concern_stat_threshold *thresholds,
+					bool show_concern)
+{
+	if (show_concern) {
+		size_t log_value;
+		const int threshold = get_concern_threshold(concern_name, thresholds);
+		if (threshold < 0)
+			BUG("unexpected repository stat threshold: '%s'", concern_name);
+		log_value = (size_t)log2u(value);
+		if (log_value > (size_t)threshold)
+			return log_value - threshold;
+		else
+			return 0;
+	} else {
+		return 0;
+	}
+}
+
 /*
  * Holds column data that gets stored for each row.
  */
@@ -358,6 +448,7 @@ struct stats_table_entry {
 	const char *unit;
 	size_t index;
 	struct object_id *oid;
+	size_t concern;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -391,6 +482,9 @@ static void stats_table_vaddf(struct stats_table *table,
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
+	if (entry->concern > table->max_concern_value)
+		table->max_concern_value = entry->concern;
+
 	if (entry->unit) {
 		int unit_width = utf8_strwidth(entry->unit);
 		if (unit_width > table->unit_col_width)
@@ -409,14 +503,21 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
 	va_end(ap);
 }
 
+/*
+ * Define a symbol for 'no concern value for this stat'; this will
+ * make the code below easier to read.
+ */
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
@@ -425,13 +526,14 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 
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
@@ -445,6 +547,7 @@ static void stats_table_object_count_addf(struct stats_table *table,
 }
 
 static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  size_t concern,
 				  const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -452,6 +555,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -460,6 +564,7 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 
 static void stats_table_object_size_addf(struct stats_table *table,
 					 struct object_id *oid, size_t value,
+					 size_t concern,
 					 const char *format, ...)
 {
 	struct stats_table_entry *entry;
@@ -467,6 +572,7 @@ static void stats_table_object_size_addf(struct stats_table *table,
 
 	CALLOC_ARRAY(entry, 1);
 	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+	entry->concern = concern;
 
 	/*
 	 * A NULL OID should not have a table annotation.
@@ -490,7 +596,8 @@ static inline size_t get_total_object_values(struct object_values *values)
 }
 
 static void stats_table_setup_structure(struct stats_table *table,
-					struct repo_structure *stats)
+					struct repo_structure *stats,
+					bool show_concern)
 {
 	struct object_stats *objects = &stats->objects;
 	struct ref_stats *refs = &stats->refs;
@@ -501,47 +608,113 @@ static void stats_table_setup_structure(struct stats_table *table,
 
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
+			       CONCERN_STAT_VALUE_NONE,
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
+				       repo_structure_concern_thresholds,
+				       show_concern),
 			       "    * %s", _("Commits"));
 	stats_table_count_addf(table, objects->type_counts.trees,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_COUNT,
+				       objects->type_counts.trees,
+				       repo_structure_concern_thresholds,
+				       show_concern),
 			       "    * %s", _("Trees"));
 	stats_table_count_addf(table, objects->type_counts.blobs,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_COUNT,
+				       objects->type_counts.blobs,
+				       repo_structure_concern_thresholds,
+			               show_concern),
 			       "    * %s", _("Blobs"));
 	stats_table_count_addf(table, objects->type_counts.tags,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       objects->type_counts.tags,
+				       repo_structure_concern_thresholds,
+				       show_concern),
 			       "    * %s", _("Tags"));
 
 	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
-	stats_table_size_addf(table, inflated_object_total,
+	stats_table_size_addf(table, inflated_object_total, CONCERN_STAT_VALUE_NONE,
 			      "  * %s", _("Inflated size"));
 	stats_table_size_addf(table, objects->inflated_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_INFLATED_SIZE,
+				      objects->inflated_sizes.commits,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->inflated_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_INFLATED_SIZE,
+				      objects->inflated_sizes.trees,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->inflated_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_INFLATED_SIZE,
+				      objects->inflated_sizes.blobs,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_INFLATED_SIZE,
+				      objects->inflated_sizes.tags,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Tags"));
 
 	disk_object_total = get_total_object_values(&objects->disk_sizes);
-	stats_table_size_addf(table, disk_object_total,
+	stats_table_size_addf(table, disk_object_total, CONCERN_STAT_VALUE_NONE,
 			      "  * %s", _("Disk size"));
 	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_COMMIT_SIZE,
+				      objects->disk_sizes.commits,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Commits"));
 	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TREE_SIZE,
+				      objects->disk_sizes.trees,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_BLOB_SIZE,
+				      objects->disk_sizes.blobs,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      repo_structure_concern_level(
+				      CONCERN_STAT_TAG_SIZE,
+				      objects->disk_sizes.tags,
+				      repo_structure_concern_thresholds,
+				      show_concern),
 			      "    * %s", _("Tags"));
 
 	stats_table_addf(table, "");
@@ -550,35 +723,59 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_object_size_addf(table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_COMMIT_LARGEST,
+					     objects->largest.commit_size.value,
+					     repo_structure_concern_thresholds,
+					     show_concern),
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
+					     objects->largest.tree_size.value,
+					     repo_structure_concern_thresholds,
+					     show_concern),
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
+					     repo_structure_concern_thresholds,
+					     show_concern),
 				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Tags"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tag_size.oid,
 				     objects->largest.tag_size.value,
+				     repo_structure_concern_level(
+					     CONCERN_STAT_TAG_LARGEST,
+					     objects->largest.tag_size.value,
+					     repo_structure_concern_thresholds,
+					     show_concern),
 				     "    * %s", _("Maximum size"));
 }
 
 #define INDEX_WIDTH 4
 
-static void stats_table_print_structure(const struct stats_table *table)
+static void stats_table_print_structure(const struct stats_table *table,
+					bool show_concern)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
@@ -587,14 +784,17 @@ static void stats_table_print_structure(const struct stats_table *table)
 	int name_col_width = table->name_col_width;
 	int value_col_width = table->value_col_width;
 	int unit_col_width = table->unit_col_width;
+	const char *concern_col_title = _("Concern");
+	const size_t concern_title_width = strlen(concern_col_title);
+	size_t concern_col_width = (table->max_concern_value > concern_title_width) ? table->max_concern_value : concern_title_width;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf concern_str = STRBUF_INIT;
 
 	if (title_name_width > name_col_width)
 		name_col_width = title_name_width;
 	if (title_value_width > value_col_width + unit_col_width + 1)
 		value_col_width = title_value_width - unit_col_width;
-
 	strbuf_addstr(&buf, "| ");
 	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width + INDEX_WIDTH,
 			  name_col_title);
@@ -602,6 +802,12 @@ static void stats_table_print_structure(const struct stats_table *table)
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
@@ -610,17 +816,28 @@ static void stats_table_print_structure(const struct stats_table *table)
 	printf(" | ");
 	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
 		putchar('-');
-	printf(" |\n");
+	printf(" |");
+	if (show_concern) {
+		putchar(' ');
+		for (size_t i = 0; i < concern_col_width; i++) {
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
@@ -638,6 +855,11 @@ static void stats_table_print_structure(const struct stats_table *table)
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
 
@@ -646,7 +868,7 @@ static void stats_table_print_structure(const struct stats_table *table)
 		for_each_string_list_item(item, &table->annotations)
 			printf("%s\n", item->string);
 	}
-
+	strbuf_release(&concern_str);
 	strbuf_release(&buf);
 }
 
@@ -681,7 +903,8 @@ static void print_object_data(const char *key, char key_delim,
 }
 
 static void structure_keyvalue_print(struct repo_structure *stats,
-				     char key_delim, char value_delim)
+				     char key_delim, char value_delim,
+				     bool show_concern)
 {
 	print_keyvalue("references.branches.count", key_delim,
 		       stats->refs.branches, value_delim);
@@ -691,48 +914,170 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 		       stats->refs.remotes, value_delim);
 	print_keyvalue("references.others.count", key_delim,
 		       stats->refs.others, value_delim);
-
 	print_keyvalue("objects.commits.count", key_delim,
 		       stats->objects.type_counts.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_COUNT,
+				       stats->objects.type_counts.commits,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.trees.count", key_delim,
 		       stats->objects.type_counts.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_COUNT,
+				       stats->objects.type_counts.trees,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.blobs.count", key_delim,
 		       stats->objects.type_counts.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_COUNT,
+				       stats->objects.type_counts.blobs,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+		 value_delim);
 	print_keyvalue("objects.tags.count", key_delim,
-		       stats->objects.type_counts.tags, value_delim);
-
+		stats->objects.type_counts.tags, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.count.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_COUNT,
+				       stats->objects.type_counts.tags,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.commits.inflated_size", key_delim,
-		       stats->objects.inflated_sizes.commits, value_delim);
+		stats->objects.inflated_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.commits,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.trees.inflated_size", key_delim,
-		       stats->objects.inflated_sizes.trees, value_delim);
+		stats->objects.inflated_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+					CONCERN_STAT_TREE_INFLATED_SIZE,
+					stats->objects.inflated_sizes.trees,
+					repo_structure_concern_thresholds,
+					show_concern),
+			       value_delim);
 	print_keyvalue("objects.blobs.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.blobs,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.tags.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.tags, value_delim);
-
+	if (show_concern)
+		print_keyvalue("objects.tags.inflated_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_INFLATED_SIZE,
+				       stats->objects.inflated_sizes.tags,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.commits.disk_size", key_delim,
 		       stats->objects.disk_sizes.commits, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_SIZE,
+				       stats->objects.disk_sizes.commits,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.trees.disk_size", key_delim,
 		       stats->objects.disk_sizes.trees, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_SIZE,
+				       stats->objects.disk_sizes.trees,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_SIZE,
+				       stats->objects.disk_sizes.blobs,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			      value_delim);
 	print_keyvalue("objects.tags.disk_size", key_delim,
 		       stats->objects.disk_sizes.tags, value_delim);
-
+	if (show_concern)
+		print_keyvalue("objects.tags.disk_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_SIZE,
+				       stats->objects.disk_sizes.tags,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			      value_delim);
 	print_object_data("objects.commits.max_size", key_delim,
 			  &stats->objects.largest.commit_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.commits.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_COMMIT_LARGEST,
+				       stats->objects.largest.commit_size.value,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_object_data("objects.trees.max_size", key_delim,
 			  &stats->objects.largest.tree_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TREE_LARGEST,
+				       stats->objects.largest.tree_size.value,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_object_data("objects.blobs.max_size", key_delim,
 			  &stats->objects.largest.blob_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.blobs.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_BLOB_LARGEST,
+				       stats->objects.largest.blob_size.value,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_object_data("objects.tags.max_size", key_delim,
-			  &stats->objects.largest.tag_size, value_delim);
-
+		          &stats->objects.largest.tag_size, value_delim);
+	if (show_concern)
+		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
+			       repo_structure_concern_level(
+				       CONCERN_STAT_TAG_LARGEST,
+				       stats->objects.largest.tag_size.value,
+				       repo_structure_concern_thresholds,
+				       show_concern),
+			       value_delim);
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
 	print_object_data("objects.trees.max_entries", key_delim,
 			  &stats->objects.largest.tree_entries, value_delim);
-
 	fflush(stdout);
 }
 
@@ -935,6 +1280,8 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	int show_concern = 0;
+
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -944,13 +1291,13 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
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
@@ -961,14 +1308,14 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 
 	switch (format) {
 	case FORMAT_TABLE:
-		stats_table_setup_structure(&table, &stats);
-		stats_table_print_structure(&table);
+		stats_table_setup_structure(&table, &stats, show_concern);
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
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..9eafff0a36 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -65,7 +65,6 @@ test_expect_success 'empty repository' '
 		|   * Tags                  |        |
 		|     * Maximum size        |    0 B |
 		EOF
-
 		git repo structure >out 2>err &&
 
 		test_cmp expect out &&

-- 
2.53.0

