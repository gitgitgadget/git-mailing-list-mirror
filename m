Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598230;
	b=VxH12HGdglOzlNOJkVgu2WOVWguL2iZGTymN2nAsIuxWgW/S/YBQ+RC4neD2FSKjkc/W
	 e5ipj7gFPmGeBPSWrrj6qI1NQxObvhQwdWJZ0H1v916RarMhUcs6l+yQD6gmlMiFVTe1E
	 IIbNAM3hmeOeU7JEq5H+Vd4k8v+2jymWqWugnTGG5hAizny+Nec1E4NBwYZ3JUxrLfk1w
	 UieZYM/jqSPb+1NtWAC90PzX5xDSPKA/0ZG0mfThprAzowrGzbZ+BXkstDeCnfZRD2OyM
	 rzQM6hrv13NiG4yEnY+Yz04womAWXCAz88DSiyxemTiahQq2D4Q7F8sQwL+J74bVTdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9i/A719V0OGYXpg+QuXgU5DkQkL7YQUECVC4iD993MA=;
	b=qzmhTwF1sMbybZCc0MllOYZCP5AsqKYcjfP5aIBQEeGs0pz2d5RV7gVz3dK5tSxtr2nc
	 nkNfC8+yY71PxYbl/3+0RCirJVvwHuJfCtyWL9gCU0jE1VgJ7xqqbDa7K2OW8L0Fe0wGv
	 W+cVynGzYerhhjlZ2qL5FtJW5gDjqYvm9t4WxS/BcwSRxNXNX6D7GDUcaf34JTDui018k
	 3opBlMerTxc5zgb1FmnLIf/xLmsT56GxILcsKxQX48KbjOZYYDdeqeB98cmOlXnEJ+D/M
	 LtiTGn2jEG3zLtO+Oo+26e6shtDeP0XtikQUG3Ak1DUqM1YxqEVC5RNv5IxX3kppo3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lpGWvxzu;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99E606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC99E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lpGWvxzu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so791267a12.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598228; x=1793203028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9i/A719V0OGYXpg+QuXgU5DkQkL7YQUECVC4iD993MA=;
        b=lpGWvxzuOXEcYXhphqaCX2lpA+eNPbcgtN7MFjOrPv7NLNNOh7vVZl/AlPb3sbycmp
         nOZlrDQ9PfWuu9wLgAYS+efFX5ynxq00Ac5Cbe1psst5lMm3Imytag3x9d4dUk3AaEEW
         rooilOfLKoWT60Hp65GU3ICl7cof58y+1yRzaaMPHcA7UIM47hmytCK+G/xoXrY66iP+
         b+yCJlId9aAp1y7LHzDqkGvaJBo44tgX3w5L/x0vbHcIMHxCWQrp/wRXvr/WV4gy5D0a
         ra405/v06YhFCcZtTv6mqJbqaXkRffIPgRtP7j+QKs6cdyO8ciGDP6561RMZEcTDn924
         5/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598228; x=1793203028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9i/A719V0OGYXpg+QuXgU5DkQkL7YQUECVC4iD993MA=;
        b=aw7h900KnIN1QbkTrXiYfALI3Kyc109JMMv3d1iQEBNnDeieldBwCKuTJ+I9Pqbion
         eQhMKSLZnawkvkFEhN++TwNJdS20HqpPle2+hiINNBneEOZLoHeIHhg55bov/8SPdxsi
         P/HwFkdxnutcCd8/Kl5ponPhoD+EfKasIIUVw/tPF3/CJVlleFHaqQXSVMfnSzvlqaMm
         7Gem+fbTrp2+8VgIcmq1sRUPE4Fvn8dAy0ux+Azz+5Dr86oM/euBEuTkC7rmW1tRuqxn
         g66xHAayPDElEYNRiFS0QZV/QkHJnflt6AiDCWx1gPvvFBkfww7WJO3cSn4tVdZMLG/9
         eLvQ==
X-Gm-Message-State: AFq9FYKcoRSWGDCP9MUXu4PzmBNqDUE2af4EByj5lly4sUrO1UQxnSDI
	ZNg7Eb0BT9yjJtZLmwjWxrkmlNMD2dPk+pVnFZCvD3DSpSta7OqhFCrXFkH8/60e5GM=
X-Gm-Gg: AYBFou3kY1NP0I+FTBxuzW9BHwG3Ckm6HJur8MLZMVGobx/s+Zapwgi70jPWbQWI3Xz
	dbvMEfS8MlgiWYlCiUNq5gX3RiOnmwVwjL7Gg+mWtOjzzUEMuJTaG8fmmrHj6yAUviDc6SzKbrR
	EFjFQ8S8P2lyED8CPsH5eiX5m4PlWPABahPTTCtKR3ic9vw46kgAG8FZ6sYFpsWkvZKBJ2zCpK6
	qwESNTq/fmjasZZHsZdplmD3bO1O7xQtYjed3icih+Nyq0RznBZMVedeN100MB+DMy1M4jkmORT
	++qwx6/vMA65mJ1XRXjriW88kCtWVkMUyPmBTvFl8xQ31e38qrnTn/A5abeikWYptRF8JY4tK/2
	TsWHIORK6XC2xILJSsqV2xrS6h1bH7YZz0hnRaOax6kM+Iy6WtbrbmWusIm1PCym/mn2LUgG1/g
	FqM9fjqxaiK/beShyttM5ry0gHZy8B8S5dcu5EbEuw8/8wSP9uBKLzu6UrSJbV0VMPds3MujoiS
	v+YrT1ZhTogJ8tY+vydFrBu5/SBsX4RPY9aS0JAU7hMsVBs2sjrdAwIpEpKa417e5ZnsHEFWa5T
	IEi8SqgFTQ3bvzo6Xw4FbsXm+r9UcTSf7KDzzNde3IMg8dDXEMJkv25SqRTYD/UF3lntka7eZCl
	eVxfPyNjFoFFEf+BnX2pv95sDFEhGL69ALEnNqeDkffXNQAF88Jm2pS0n
X-Received: by 2002:a05:6402:52d9:b0:6b3:c44d:6529 with SMTP id 4fb4d7f45d1cf-6b408ef108cmr1544626a12.42.1792598227806;
        Wed, 21 Oct 2026 08:57:07 -0700 (PDT)
Received: from localhost.localdomain ([104.28.219.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4030dafd6sm975763a12.7.2026.10.21.08.57.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:57:07 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy PATCH] environment: move commit_encoding into repo_config_values
Date: Wed, 21 Oct 2026 16:56:08 +0100
Message-ID: <20261021155608.58509-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move i18n.commitEncoding from the global git_commit_encoding variable
into struct repo_config_values.

Initialize and release the value with the other repository config
values.

Pass the repository to write_commit_tree().

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 commit.c      | 16 ++++++++++------
 environment.c | 15 +++++++++++----
 environment.h |  4 +++-
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index ad26f0b40a..91287289f4 100644
--- a/commit.c
+++ b/commit.c
@@ -1683,7 +1683,8 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
    "variable i18n.commitEncoding to the encoding your project uses.\n");
 
-static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg_len,
+static void write_commit_tree(struct repository *r,
+			      struct strbuf *buffer, const char *msg, size_t msg_len,
 			      const struct object_id *tree,
 			      const struct object_id *parents, size_t parents_len,
 			      const char *author, const char *committer,
@@ -1691,9 +1692,10 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 {
 	int encoding_is_utf8;
 	size_t i;
+	const char *encoding = repo_config_values(r)->commit_encoding;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(encoding);
 
 	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
@@ -1714,7 +1716,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 		committer = git_committer_info(IDENT_STRICT);
 	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n", encoding);
 
 	while (extra) {
 		add_extra_header(buffer, extra);
@@ -1734,6 +1736,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct commit_extra_header *extra)
 {
 	struct repository *r = the_repository;
+	const char *encoding = repo_config_values(r)->commit_encoding;
 	int result = 0;
 	int encoding_is_utf8;
 	bool warned = false;
@@ -1744,7 +1747,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(encoding);
 
 	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
@@ -1757,7 +1760,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	for (const struct commit_list *p = parents; p; p = p->next)
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
-	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	write_commit_tree(r, &buffer, msg, msg_len, tree, parent_buf,
+			  nparents, author, committer, extra);
 
 	/* And check the encoding. */
 	if (encoding_is_utf8 && !ensure_utf8(&buffer)) {
@@ -1793,7 +1797,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 			free(mapped_parents);
 			goto out;
 		}
-		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
+		write_commit_tree(r, &compat_buffer, msg, msg_len, &mapped_tree,
 				  mapped_parents, nparents, author, committer, compat_extra);
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
diff --git a/environment.c b/environment.c
index c83cf44839..632fbfad55 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,6 @@ static int zlib_compression_seen;
 
 int minimum_abbrev = 4, default_abbrev = -1;
 int assume_unchanged;
-char *git_commit_encoding;
 char *git_log_output_encoding;
 int fsync_object_files = -1;
 int use_fsync = -1;
@@ -222,7 +221,9 @@ const char *get_log_output_encoding(void)
 
 const char *get_commit_output_encoding(void)
 {
-	return git_commit_encoding ? git_commit_encoding : "UTF-8";
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	return cfg->commit_encoding ? cfg->commit_encoding : "UTF-8";
 }
 
 int use_optional_locks(void)
@@ -597,9 +598,11 @@ static int git_default_sparse_config(const char *var, const char *value)
 
 static int git_default_i18n_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
+		FREE_AND_NULL(cfg->commit_encoding);
+		return git_config_string(&cfg->commit_encoding, var, value);
 	}
 
 	if (!strcmp(var, "i18n.logoutputencoding")) {
@@ -783,6 +786,9 @@ void repo_config_values_init(struct repo_config_values *cfg)
 
 	/* section "branch" config values */
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
+
+	/* section "i18n" config values */
+	cfg->commit_encoding = NULL;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
@@ -794,4 +800,5 @@ void repo_config_values_clear(struct repo_config_values *cfg)
 	FREE_AND_NULL(cfg->askpass_program);
 	FREE_AND_NULL(cfg->apply_default_whitespace);
 	FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
+	FREE_AND_NULL(cfg->commit_encoding);
 }
diff --git a/environment.h b/environment.h
index b336459e90..5b9c445146 100644
--- a/environment.h
+++ b/environment.h
@@ -147,6 +147,9 @@ struct repo_config_values {
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
+
+	/* section "i18n" config values */
+	char *commit_encoding;
 };
 
 struct repo_config_values *repo_config_values(struct repository *repo);
@@ -242,7 +245,6 @@ extern int grafts_keep_true_parents;
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
-extern char *git_commit_encoding;
 extern char *git_log_output_encoding;
 
 /*

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.54.0

