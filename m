Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296358;
	b=KDy15ykwU49iZ98fdeQ4QxyT9CabtgCvjFBSijNksSiuOgiz5Gru9dSrwoRSIwLp9vuZ
	 jAOWCpKRNc0ut5osxw2HDjxMJy5BTyndK4fn8ymLi/lx37PnfN73svWt+PFrCXyWg35cx
	 thHg+vY4CICmjsDCIruMfSLPJya3P67Y64W3Zre1e+pcm1ytlwRPVVeRSAqnxclsbzuBd
	 a6ydQ5wYa+Zjlb31RtOfM5wBzOLAERS18FiCF0yMl8jdjZ/LbX2x9u+nRAeaUmJTePt+f
	 Zb3jWYyaYgCfhR37cTlT6nSI7PhVL/49z4k8OMbkOH/gajha0XU6ItX9vlL5lN1zuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296358;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ALD2DiWITDFS6NLYPTWu12lDjQ8T3NXc13fJmMCZEyc=;
	b=RXMFVJOet7CRhNPaId4z4CJ7IJG2QcVkCkEdeiKTNpwIqTjo7A4QuAolgBpFMW1aldx5
	 4fPnCXwRLoI/Dfigp4A4IuukZG85F9LJVKwknV67t7E/is8Rjvu0wOYZrC/Ijlggv+0hn
	 INQ+WtfFSMUTeuZISmH7CWCV3xE2k2a6Igw55uqRAhgGuDf8qRSFS5oL2sVPjYa6h9lZ9
	 DNO/u1K7g7vh2MtPcYq5OjMd5y596FZfh30ecwEv/nrXtaOflF21w2r5BigiGmDg7OPC7
	 OIza03+aZma0BV0BqEoUKoLZ8LgMR9KXkBJJHtG/Mo7xf64PY6o8TbFNiH/IO/iYKAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=nOXUQ1XC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=idDxlWC7;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB69606A324
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB69606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=nOXUQ1XC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=idDxlWC7
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F2191D000CD
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:52:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793296355;
	 x=1793382755; bh=ALD2DiWITDFS6NLYPTWu12lDjQ8T3NXc13fJmMCZEyc=; b=
	nOXUQ1XCK5US/f1sWBNRz+VOCVib/Xd9BJQDs+8NgbtM1ZL5b3W+T7pMIKdSO/oX
	DSslMzmIDol13ofH0BuowvJPV9ZJ1xajPtNmPae7YS571h0xADwIUmLmZJJqO2mo
	e5Gbvh0snyMOUagf8Eqk8uqeJGbvrTdBouG+u+jYX2NI/dB2k9gyXCDQv740LHBl
	ENfl7vzzkAEdu9v+UiVkUYMdcJLIaPTE5FFILxpLa1hnWR6Um/MQjKQJqeL20uXh
	qyZoCri3gV4T9OrCbQzgzxyNqX3xsHhl0d2iYAWITqaAbN8cgigVLH5PjJ31+nrb
	KvRp83YjrS5YdZt1Sngfcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793296355; x=
	1793382755; bh=ALD2DiWITDFS6NLYPTWu12lDjQ8T3NXc13fJmMCZEyc=; b=i
	dDxlWC7h4V1ja5+0BF67kpMidFulx+FxwaIyvKGbCWyI2WMp2iOk1uXRRWx58Yih
	K+/VrQB7UuknyNVMsltObaa7qpWyXl9ndbt51my/c0/1kmi70+7cuAZKqP8jHEbV
	rEFV7OMSGXUzzeheYRJQo1lYPC/ED7feTfqoC4aJQCVHSCxVyd6o4H+1G1WLNiz4
	mB8MvjK7Gmk76txzgK8ug569ORMoPeZFTqvdenYpxvjHtIc69YeiIKiSTONNFeMd
	igZqwk/JdZ6XfAh9o/u3FuEiwitNbrSy/cfYcqOthIu/7SKRghshXL8/ztUzIpGJ
	0KeZVw7HbXAqrZzfNYDxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793296355; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bSqMZOcbipVCKSJVQK3KcwyZxcvB/HecKNydVVanN8egXKR
	YL2UGJ2C0lX/b5fM5zvmQ8zTzgs+EOGjjOzuCUH7my5hcwwj/vD3MVj+19hDNBxt
	ypk2rrPra6pQMVKpvthaExd+c2ui7XQodwc+1IIbED60zMjp4izsGKlCg3fBnaYc
	h9auoK7e34EBMLnOOHu7io5GCcJ+kj7wP7Dt2apGJkWvl3bfzstBLBkrqc4YyXWB
	+avuk/JprcbeGX8vOEYUUewVzZCUdwCFnPa/62eQQ/kBjLeCoSscNlb80J1tm7Nm
	09bJAb0/icFCf5D+bCevXnhKK87YAb2gTiUhKHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rT6R/TrXp+dHYbZKeqraQPkRuXAc1WNg+G7HAR2Fut8=:knBmcWR2cT92jNGvpokXgNlCAjCoLT9mdp+StU/Fndw=;
X-ME-Sender: <xms:44fjakNyjswLSONWpF3mQhnZmPpMuioxGHCA9n9zU9OQB5_KgjCMLw>
    <xme:44fjag94plv9qGEOYeGZHQ4kL2z1meqbPLiiGodOTIymXtxF_HpEcdiyaIBZPVT5p
    ZsQ6NmeKpzRTb27_prpTSdVXtqTia_W302ATOpPjF9D7641vRYO-H-5>
X-ME-Received: <xmr:44fjao6O23nzlnIzsU_84FrsrG_Yxyuhcq0jUylXeNo4jLkeyFCQJL7lyftK5klxPGuMNsiIrFAdQbZ6QY-XgbBHlu-ib_HTHlSwk75pkMnNrjhKZg77QIFmGa4Z>
X-ME-Proxy-Cause: dmFkZTE/VjdBqvwNLfrp4gI9rckMWet5kQuYx3L9iVPgMhaXWIaNlB09fdNrOV3y0C9gDA
    Oteq/SalDEeZjHMXpA16MOhIyyiiSnj2/0KcLmKB/woHaZib4TW6sHGpFwJkYTFf0U94Wg
    bx+o1hj4lJjqv2W0mlRo1pXQyuxIzzyrvEF2gHTcXVWsdZpacu46CnM3UQyKkO+u8+51a9
    YYDQxy0p3jvErUxpRBiJarRH6f8+w9QPvuYwaLB4++kMPWdOZkRm7L5cbU7U8oNnCH5R6x
    Z/7Y4tAwxr/+uihHDiPmXsJr2RWwPF8ymc+Gqsu8O4jR+XbWSakeBx4KitSUTRPSWR8/lv
    UVTDi55haSdgKTgrQdWNgUJ/z1zZsqCHnFYl8Ynzqh2Ng1AfHKEJxHs/Y7C/9G2f/LpaOy
    VKHTXLKB+yX/4Bf3iSCLWlPMjbxigTk2r452eXJegJHnaOaXWpBs3vF0Ig3d+DH+3d8Ovp
    YAsBGpMvK80hjsfXX2zwAdu9TF1Dh1wwzvqqwuMug/sTBiMJ5rrHeHgtR5tQFvvF0Fy9/W
    O6v0DPfO9vv3szRiAJhBkd6mwXzsKYn5/HhnFZ1WkSRqg+Wt24KnGT7h+w7EEHpHicPrci
    WYsNp5tp9wF2v9aotXaPwuUvrtmvW8rsmcNU+k7FwaWdsSa+v+f0Ub7RD9Lg
X-ME-Proxy: <xmx:44fjan2PUdtqjIij1Olr4207Q89160fvEeEWo_2LkpGVIVGZiioxJw>
    <xmx:44fjavDjpj-5zBIuCPyQVi1RuMK5kkhBLAKR-6549rUgiEmZmerPyQ>
    <xmx:44fjap2YsOldYTo-l3YPR-fjpsh4nOpRYPUwvq560ZtjWY5NJQoTHw>
    <xmx:44fjapu7ntvR5bAnwZfINiJJW_PLjFHl9ZXZB-vH-TqzFOigY3MHWQ>
    <xmx:44fjavndEIFwgjE3aBN7ZIgLDnbcHBl6zzcKM54JKiImmq6RokCb5Hd_>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 13:52:34 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Thu, 29 Oct 2026 13:52:23 -0400
Subject: [PATCH v4 2/2] repo: make concern thresholds configurable
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
Message-Id: <20261029-b4-repo-structure-concern-v4-2-d813537ec617@fastmail.com>
References: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
In-Reply-To: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13232;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=knBmcWR2cT92jNGvpokXgNlCAjCoLT9mdp+StU/Fndw=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIetz/Ytd/rfH3hZ8aV29QYQnYmqJ45cf/68ZnyDPkse
 3RnfnZO6ihlYRDjYpAVU2T5/0+g8RXLAwm/oHefYOawMoEMYeDiFICJ/N7ByLBYYsPZSS7bN3ip
 b11mGMmzIddd0Pz5vZYLfTOP1efGLiph+CsZwvg7LZe/80fFmgl9j4ySUrL+fLVk1Pyq536wzft
 jGRMA
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
 Documentation/config/repo.adoc |  59 ++++++++++++++++++
 Documentation/git-repo.adoc    |  11 ++++
 builtin/repo.c                 |  38 +++++++++++-
 t/t1901-repo-structure.sh      | 138 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 244 insertions(+), 2 deletions(-)

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
index bd1866c5fa..4880c8b8f7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "commit.h"
+#include "config.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -30,6 +31,8 @@
 #define REPO_STRUCTURE_USAGE \
 	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
 
+#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
+
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
 	REPO_STRUCTURE_USAGE,
@@ -430,6 +433,35 @@ static size_t repo_structure_concern_level(const char* concern_name,
 		return 0;
 }
 
+/*
+ * Concern thresholds aren't universal. We try to set reasonable default
+ * values, but projects may want to set these thresholds differently. To
+ * support that, they can set the thresholds for their project in the
+ * project's git config, in the section "repo.structure.concern".
+  */
+static int config_concern_thresholds(const char *prefixed_var,
+				     const char *str_val,
+				     const struct config_context *ctx,
+				     void *cb)
+{
+	struct concern_stat_threshold *thresholds = cb;
+	if (starts_with(prefixed_var, REPO_STRUCTURE_CONFIG_PREFIX)) {
+		const char *concern_name = &prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
+		for (int i = 0; thresholds[i].name; i++) {
+			if (!strcmp(thresholds[i].name, concern_name)) {
+				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
+				if (value < 0)
+					return -1;
+				thresholds[i].threshold = value;
+				return 0;
+			}
+		}
+		warning(_("Invalid concern threshold name: '%s'"), concern_name);
+		return 0;
+	}
+	return 0;
+}
+
 /*
  * Holds column data that gets stored for each row.
  */
@@ -835,6 +867,7 @@ static void stats_table_print_structure(const struct stats_table *table,
 			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
 			strbuf_addstr(&buf, " |");
 		}
+		strbuf_release(&concern_str);
 		printf("%s\n", buf.buf);
 	}
 
@@ -1041,7 +1074,6 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 				       stats->objects.largest.tag_size.value,
 				       repo_structure_concern_thresholds),
 			       value_delim);
-
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
 	print_object_data("objects.trees.max_entries", key_delim,
@@ -1269,6 +1301,10 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		usage(_("too many arguments"));
 	repo_init_revisions(repo, &revs, prefix);
 
+	if (show_concern)
+                repo_config(repo, &config_concern_thresholds, &repo_structure_concern_thresholds);
+
+
 	if (show_progress < 0)
 		show_progress = isatty(2);
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index f92168025b..1db2cc5293 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -67,7 +67,6 @@ test_expect_success 'empty repository' '
 		EOF
 
 		git repo structure >out 2>err &&
-		cp out /tmp/test1-out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
@@ -145,6 +144,89 @@ test_expect_success SHA1 'repository with references and objects' '
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
@@ -205,6 +287,60 @@ test_expect_success SHA1 'lines and nul format' '
 	)
 '
 
+test_expect_success SHA1 'lines format with concerns' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# configure thresholds to get concern indications
+		git config core.compression 0 &&
+		git config repo.concern.commit-count 7 &&
+		git config repo.concern.commit-size 14 &&
+		git config repo.concern.tree-size 10 &&
+		git config repo.concern.blob-size 8 &&
+		git config repo.concern.blob-inflated-size 10 &&
+		git config repo.concern.tag-size 2 &&
+		git config repo.concern.commit-largest 4 &&
+		git config repo.concern.blob-largest 2 &&
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

