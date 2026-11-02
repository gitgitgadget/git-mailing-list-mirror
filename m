Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637178;
	b=UUqIaraJ3J8iX98mYgORUE1mLJkXxu8z0nrJVzDYr9GC4Ie4mrgA6zylCYzmyWvBIguq
	 0dSTPgfS9ts5zAxLdriPwdhvTK1g2P8RtsQKiO7i2YbSvLZV3IRCWqRG86bsmm9wFJO6J
	 PjLsPVVMUwWl46iw6pEYVbZ6pqTdgP1K4K5omlD4oRP56Ixe4uFXlsBtjttpT6zpsDDZT
	 j0FWfXKdov4FRQ6IPDURaIB7TE68k3J2XAQkdmu4yvppo6jWbN7TN4i+EQFyhmIaR3nX+
	 Z+B54FA/aIge/at3QDiz+d/yvFUJLGQZ3lPKWmiFTw+5NyEDwrrQQDZGCoqLlbICAIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rf/tyGPky/dRgiPmCHAWAqIDkRNTfV4dFoO8bMHwN1A=;
	b=GJOx/kexuj0pV67j/yDwPVwil6M0pxUr2A5/clQ3w17gh/KL+4iOrP1ibEwZ2ggbG7lD
	 rcy31WUDohXBI6hpbCExbnkP5lPpgDNzaLfiw+NBxoo8EA77D9WonDgKgu4+Db3MeNrU3
	 1TJp607xKyBmTP2MqMkn2g/eRd6I4Yj8kkJB5TH7h9n6P2Sm7W1FZwdIpDTqS5lqJ+8Xo
	 sWykvbzgoO6Uw0s6lTIByDxhqA0NGGrZXCiJg9XTs7RvIzaKRbtt/jylM2h0ql/vWQVTr
	 E7pZ3lbyWeeo8UawhqtqJkIKmHgSEf6j5/eD0xTM/r3AS57ptU4OrHkjRFkZwGmO4OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=dtL+vQbD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ha8UlRmi;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD364608B05E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD364608B05E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=dtL+vQbD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ha8UlRmi
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F305EC0309
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:32:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 11:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793637177;
	 x=1793723577; bh=rf/tyGPky/dRgiPmCHAWAqIDkRNTfV4dFoO8bMHwN1A=; b=
	dtL+vQbDlbDCg4i0foIgPiOl0OxN2/OdtByePPmBN1TBDaw9zflOGu1rddPE7jCz
	HbzzF7lsI9uqAeE5NvgUO8Qh4srclSO0xz/uSOj/ku2eLrZ7RnLsaccHorXFFRYY
	d16YB6jJjqvk/eYUNKbo2UlKs0RdzCL++yzC5M7N2nHpcg5jWhX38/iihY+Oh6wR
	pPQs2M1RMg/DBo+TZDVwUav4CqELjur7Nh2/SxPmSZEgLioAML9DR7hsXwnUkSnp
	tzw49Q8PA+6OdCgL44gNd+pCyTZPc1KMMqpKzJWYqUhuNe6ztv+bnQVGccbEnYOg
	JQvMWzp9gwkT9BOSpx676g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793637177; x=
	1793723577; bh=rf/tyGPky/dRgiPmCHAWAqIDkRNTfV4dFoO8bMHwN1A=; b=H
	a8UlRmib/zVXlFLuc0SlXRt5iK05DdvTM1IuTS5DopUTzFwQ24FL3PFwz64t/zA1
	BQsDmT52tuAzId+QeN4U4hvKTBD5MkjWSLziBpa27AufmCJycKmksPEV4BeJ1r4T
	rdGM4H6JXhAhvyuSSlT2p0u7wf1wgRPtwcF0NVl3ZlWpCEXfU16CPw6YQbctcJoR
	bSQ9nheXFPdVfpDkHsx7jSXhq/hNqQvri128AA11SJwcdpeX3RvkVQUwMQwWH4ri
	0HnjJ+5xQqQXJP01GiL63gJUL6HcRN5C+HK6kDnkF+eozkcRJKTluBkQnbRb7djQ
	tN79nnOLTLzuNhLCZybLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793637177; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HgR1+a9JNpXBCAiFGEC6Dnni1po0x3Di/hIOWStCYT45r6m
	HKb7QQRtRaXyv67hbUF1qaFVY5/dcX9L9Eo5ggwd7quNxgvQbD3GEduJkrwfX807
	Nn4bvT+Avv3Xd1k5nAj2zorEDHBxUdkG+xIyKyh22W/dO5mOwr6lQEpR1/hFOIul
	ZV0dbHlEqd49dXDPZhvgB6LIraI4PJWPrVcbVle1DRvIiyGuOW2QAnxDYPbPjphR
	BXXEdPsnsJHuF5XrqMhTnkdyzebwJeLwnCv4QoasVaQ7ejs9QRnyF9YXW9ULXRiE
	ahI/QQiVldgOBYw/NWSlegRPtIsW/SE8SzHINgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ULgn1qrmnve4GJnEHZHxGQXhfsfUbCgij+Dnun4jplY=:y7Rnj8tWSByjQiXLqYilBXR9/QvTHmnEYcLiHPyVsoo=;
X-ME-Sender: <xms:OLvoascaYpUrWc045EOp0KgLXLtjUdzKQrKebi74KGVyy_-rkNJf9w>
    <xme:OLvoakPQ29hWvy6BN8-4Pb2nEn1cc9mH-Lik2f2KhQpYaXUz1-o_FbRSgfTvCkzEZ
    UcjMHaSQDUBVOEItmaF7SmnekG-iFPVOWHdEGGZ4_Vu2b904NFU7LWK>
X-ME-Received: <xmr:OLvoarLUwB6VcB27L3ENzeUT28xALpsvfLraroIQVTghqx1i-viWDLH1xkuyQQ>
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
X-ME-Proxy: <xmx:OLvoatHEJO_F6q6vDcSFLwRq-xkbuTKDsTzmLFlS0pe510gfM4QZ6Q>
    <xmx:OLvoarQQ7nPLQLsgosZa3UQks1Ff7tUr_ZPwu7DaMhAYikezS1susg>
    <xmx:OLvoahHA5lpDkjFHj9oqlKGR96NiRcxV-kcRaXlGmW2C5CkBLt1bvg>
    <xmx:OLvoav-_D66wIYV1PCHgnKvEnKE96RvciRBoqMnotynT7gzg7pSgTg>
    <xmx:Obvoan0YF2fJ-4IrJcZ4tXwxdstsHzsEc5r5DCDulwd5kNKvxY2hzLrH>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 11:32:56 -0500 (EST)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Mon, 02 Nov 2026 11:32:44 -0500
Subject: [PATCH v5 2/2] repo: make concern thresholds configurable
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
Message-Id: <20261102-b4-repo-structure-concern-v5-2-2d8f37b70b75@fastmail.com>
References: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
In-Reply-To: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13527;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=y7Rnj8tWSByjQiXLqYilBXR9/QvTHmnEYcLiHPyVsoo=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJe7DZTsTI0vq+V49JZyjrz4KJHt5SDH+mcFVl3JPHTv
 HUO9zs8O0pZGMS4GGTFFFn+/xNofMXyQMIv6N0nmDmsTCBDGLg4BWAia58yMuzocdu46dtP795y
 n2txV8sP2phK+QTbz2dc3rGs5bJKTxLDPzMNGc0fGWH7DPcaPnyxb2332T1PpoqzhbYfS5eTzaz
 /xAQA
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

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/config/repo.adoc |  63 +++++++++++++++++++
 Documentation/git-repo.adoc    |  11 ++++
 builtin/repo.c                 |  60 ++++++++++++++++++
 t/t1901-repo-structure.sh      | 137 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+)

diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
new file mode 100644
index 0000000000..9692f8b71d
--- /dev/null
+++ b/Documentation/config/repo.adoc
@@ -0,0 +1,63 @@
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
+	Sets the value of the concern threshold for the size of the largest
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
+Thresholds are actually computed using log values. But for human convenience,
+they're set as integer values. If the integer value supplied isn't a power of
+two, the actual value will be rounded to the nearest power of two. For example,
+if the value in the configuration setting is 80,000, the actual threshold will
+be set to 65536; if instead, the value from the configuration was set to
+100,000, the threshold will be set to 131,072.
+
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
index 7a50605779..5dfe813907 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -430,6 +430,8 @@ static int repo_structure_concern_level(const char *concern_name,
 		const int threshold = get_concern_threshold(concern_name, thresholds);
 		if (threshold < 0)
 			BUG("unexpected repository stat threshold: '%s'", concern_name);
+		if (!threshold)
+			return 0;
 		log_value = (size_t)log2u(value);
 		if (log_value > (size_t)threshold)
 			return log_value - threshold;
@@ -440,6 +442,60 @@ static int repo_structure_concern_level(const char *concern_name,
 	}
 }
 
+/*
+ * To make configuring thresholds as intuitive as possible, we set the
+ * internal threshold value to the _nearest_ power of two to the value
+ * the user specified. So if they set a threshold to 500, we should use
+ * a log value of 9, but log2u would return 8.
+ *
+ * A threshold value of 0 means "never flag concerns for this stat".
+ */
+static size_t nearest_log2_value(size_t v)
+{
+	size_t logval, power_of_two_floor, mid;
+	if (!v)
+		return 0;
+	logval = (size_t)log2u(v);
+	power_of_two_floor = (size_t)1 << logval;
+	mid = (power_of_two_floor + (power_of_two_floor << 1)) / 2;
+	return (v <= mid) ? logval : (logval + 1);
+}
+
+/*
+ * Concern thresholds aren't universal. We try to set reasonable default
+ * values, but projects may want to set these thresholds differently. To
+ * support that, they can set the thresholds for their project in the
+ * project's git config, in the section "repo.concern".
+ *
+ * This is used by repo_config; the call site is guarded by show_concern,
+ * so the global threshold array is only modified when --concern is requested,
+ * and that will happen at most once.
+ */
+static int config_concern_thresholds(const char *config_val_name,
+				     const char *str_val,
+				     const struct config_context *ctx,
+				     void *cb)
+{
+	struct concern_stat_threshold *thresholds = cb;
+	const char *concern_name;
+	if (skip_prefix(config_val_name, REPO_STRUCTURE_CONFIG_PREFIX, &concern_name)) {
+		for (int i = 0; thresholds[i].name; i++) {
+			if (!strcmp(thresholds[i].name, concern_name)) {
+				int threshold = git_config_int(concern_name, str_val, ctx->kvi);
+				if (threshold < 0) {
+					warning(_("invalid concern threshold '%d': value must be 0 or more"),
+						threshold);
+					return 0;
+				}
+				thresholds[i].threshold = nearest_log2_value(threshold);
+				return 0;
+			}
+		}
+		warning(_("invalid concern threshold name: '%s'"), concern_name);
+	}
+	return 0;
+}
+
 /*
  * Holds column data that gets stored for each row.
  */
@@ -1300,6 +1356,10 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		usage(_("too many arguments"));
 	repo_init_revisions(repo, &revs, prefix);
 
+	if (show_concern)
+		repo_config(repo, &config_concern_thresholds,
+			    &repo_structure_concern_thresholds);
+
 	if (show_progress < 0)
 		show_progress = isatty(2);
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 9eafff0a36..b43b766e81 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -143,6 +143,89 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
+test_expect_success SHA1 'concern flagging' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# differences between zlib and zlib-ng can cause this
+		# test to fail; so we just turn it off.
+		git config core.compression 0 &&
+		# configure thresholds to get concern indications
+		git config repo.concern.commit-count 120 &&
+		git config repo.concern.commit-size 16384 &&
+		git config repo.concern.tree-size 1024 &&
+		git config repo.concern.blob-size 256 &&
+		git config repo.concern.blob-inflated-size 1024 &&
+		git config repo.concern.tag-size 4 &&
+		git config repo.concern.commit-largest 16 &&
+		git config repo.concern.blob-largest 4 &&
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
@@ -203,6 +286,60 @@ test_expect_success SHA1 'lines and nul format' '
 	)
 '
 
+test_expect_success SHA1 'lines format with concerns' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# configure thresholds to get concern indications
+		git config core.compression 0 &&
+		git config repo.concern.commit-count 100 &&
+		git config repo.concern.commit-size 16384 &&
+		git config repo.concern.tree-size 1024 &&
+		git config repo.concern.blob-size 256 &&
+		git config repo.concern.blob-inflated-size 1024 &&
+		git config repo.concern.tag-size 4 &&
+		git config repo.concern.commit-largest 16 &&
+		git config repo.concern.blob-largest 4 &&
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
+		objects.blobs.disk_size.concern_level=6
+		objects.tags.disk_size.concern_level=5
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

