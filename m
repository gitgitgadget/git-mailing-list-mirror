Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879237;
	b=bazRf1JnPe8vNNrXrhIi+sCBDERTY1qr4Q/MZQdDnOVHK5yztn0qZJaLPnrm/HnRSTFf
	 t8zdFCC/H4aQw3v3i8eMGPItT8Piy2BkpJLHHmErqLNsTUIaPi1Gsp67uSe3vgeDqpmAh
	 lQ22OMalMbwQiWcJVzwVj/Dh4IY0A84j8FFk/sqfp97uxc89qyxUJxwAwxe+xLrKHSR+7
	 362IaJqv//mJoZl80PBSgU/BHyCWDkWaBI8DzGxBKqD2sCgdtwEDN8T8CwE/RSgKfmzBB
	 LdNEocMWzKOie5zBP08DViHwLuIuaMGq4KLBhrfiu820IWKvksdhclVIJkngt7OtKzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+zefEaevQGwN4Qbc5MAJZZquvoXUJb1xP8zawhi6E94=;
	b=yhxkHUYpxaGz4MuqgF+iqHP3MaaOpxEwLKKBQ8QhHpdyt+7IP24/PG/TNM+wQXda+W+A
	 8SzwedCB3uJiQ+pesn3bIdF2+NEFnYkTpBpv7c1kEDLFkF4K6q9/eU+QspfwqG0had/9c
	 WHB9a6xMYbvUUjd/3ioqsaVTmZDNTXLBOxXFAXOx1F385Xorrq8SZ75M2IeZ7Fgkxno4S
	 L/CiRmpzf12Zpl+qy9fkWxhcvVQMXSvL5P+ke0VzsMOs8JZHMLtD2fPTofTKzI8m+Givt
	 SnxKzftFLseOHrM43/KqyhDoJ8soIfHxlxZxCqrT9HPNp28nAOQmUtoLiNdTYvb9ePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cKNhaYLX;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B2606A31D
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43B2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cKNhaYLX
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so2605055c88.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879236; x=1793484036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zefEaevQGwN4Qbc5MAJZZquvoXUJb1xP8zawhi6E94=;
        b=cKNhaYLXMiDFLzpjCtjn2WYyJRZoN0gaxKw0LW5mFW2KWYAR/WtUuSLFBsq/Lu/NIj
         B4WpCvdyY4UJhcscTWxzflpavjNfai4sKtCGOjRjMwiyKSLhQIUbjiO985Im+M+AXV/n
         FpE12wguX+Ei9qB/GYwwP6Qkwyc7FbPQVII75GTTVw0xvfzFZI15rTemOXaxd+ddmuwA
         HWE2fzDicbBaw/UmD6wfiEXqogmR2O7wWnAWzA0mZLcQckZpbD6uEVaQIHbJy4SRKopH
         TrZa+iI0MiDtQ6ERR0gT+E2JIxqVNQAIP99IXGufmd9NCJslch2+qWpUZceCimq37OB5
         +Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879236; x=1793484036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+zefEaevQGwN4Qbc5MAJZZquvoXUJb1xP8zawhi6E94=;
        b=fsjS+jQ54Ih0uwtBVn3mzNkLeBHyUyPfk69oKGchnwKb2r7bunfb94YGul39Yrcy86
         iBmLljX/MZaVh1/0ele46MflFfl6w4+RSj5SizUM7YndukX/5ktyTb/84t6k1r37lWOg
         aq3uW+tZOc1/oRdFSxB96cj/hlhP4lAr3H6HMSloXswSWOL/8vyGCWSS1vXBCpiaVTKD
         ONAaPBlC4FeFA5rQl8aClZGE5zzhuwi7AxIx3mltbO6QvkYaSvVhkencT5Gga5Jv+Yu5
         /vjSNxYpNa9nB9Dac46lsLvqiV0BXYBHa992pPpvWSpA9AKtpeqLadyZCetnMfXw+S8z
         0rqg==
X-Gm-Message-State: AFq9FYKAJTUCqf0JoVbInnFnWaioRn7agNXssk530IljTXvNluCEkf2h
	Syr9FB/73gtDtZ18P954RZOGicmiKELfyqoPWeGC/UuyHXlfsUSs+qsLyg+vAYIn9+M=
X-Gm-Gg: AYBFou3MUbuip4I405vvCYgdwDbH1wtE0E9lHO28OrqNxPqom8GIWIpwUcadgCU2S3r
	kJWik1v/9C662ENtYxOA9+KOALA4rf7mIZ9tB6JU6gLDtjOz/p+XIXQa2lRuCF0kEpWaSb3A/dA
	qWUCgy0SYrReOVi2NL/l2477BeAuWOHvTX69xL6fqqbkJNlTMsGrbxwRNkJzfAQydicKV4Apcv+
	7jYXpjFFFbwCJDAThRfd9gho6SnY9n/YDCLQMPjwIuX+/cUFoNyq89JrbqF6r1zEt1cpWI8fkst
	R2DQuFmCjD5szDVOCqOuhLXGpUZ4VBqd9lQEHqY7R03qjq8adjLUKhMSMrFDSfpGD2RSBGIa9Ip
	ov5bLYFABhr6/kPD+Sm5Pq78CSxLPNhfohJD58fG45rL+osYO7VXADxs7/+h6UlBJONzl8KDKeU
	DRkeAjEQMONjLpKGBfNGIoAdnlPGu3RqXDqOLd/FFd5QWzD9vjFJOhKs6jf9iCBRScUTRp9xyDB
	AO0C+VhQD+2an+/62Orhl/wOlq0tikAjJpPbQE7mytexaT18WahRW0i0T54GjHRNocnj/WkxTRA
	wL6XCpcZZvGyRenPvKSNafXKbMDqh4nI6GRx1yfDtkA=
X-Received: by 2002:a05:7022:7e8b:b0:16a:1fa:58cb with SMTP id a92af1059eb24-199290fe419mr4288070c88.1.1792879235622;
        Sat, 24 Oct 2026 15:00:35 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm11578875c88.11.2026.10.24.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:00:34 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH 4/4] environment: move global_conv_flags_eol into repo_config_values
Date: Sat, 24 Oct 2026 22:00:12 +0000
Message-ID: <20261024220012.486-5-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
In-Reply-To: <20261024220012.486-1-aniketgupta3001@gmail.com>
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
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

The global variable 'global_conv_flags_eol' holds the value of the
'core.safecrlf' configuration, which controls whether Git warns or
refuses to proceed when converting line endings would not be
reversible. Move it into 'struct repo_config_values' to continue the
libification effort.

Initialize the per-repository value to its default in
'repo_config_values_init()', and modify the configuration parsing in
environment.c to update the per-repository structure directly.

To read the value, introduce the getter 'repo_global_conv_flags_eol()'
and update its users in diff.c, combine-diff.c and object-file.c. In
object-file.c, pass the index to get_conv_flags() so that it can find
the repository.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 combine-diff.c |  4 +++-
 convert.h      |  2 --
 diff.c         |  2 +-
 environment.c  | 13 ++++++++++---
 environment.h  |  3 +++
 object-file.c  | 11 +++++++----
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..c77990aacf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1098,9 +1098,11 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
+				int conv_flags =
+					repo_global_conv_flags_eol(rev->diffopt.repo);
 
 				if (convert_to_git(rev->diffopt.repo->index,
-						   elem->path, result, len, &buf, global_conv_flags_eol)) {
+						   elem->path, result, len, &buf, conv_flags)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.h b/convert.h
index 3c51130177..18be39ca90 100644
--- a/convert.h
+++ b/convert.h
@@ -17,8 +17,6 @@ struct strbuf;
 #define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
 #define CONV_WRITE_OBJECT     (1<<4) /* Content is written to the index */
 
-extern int global_conv_flags_eol;
-
 enum ce_delay_state {
 	CE_NO_DELAY = 0,
 	CE_CAN_DELAY = 1,
diff --git a/diff.c b/diff.c
index b4ac17f8ef..7eb45160c2 100644
--- a/diff.c
+++ b/diff.c
@@ -4480,7 +4480,7 @@ int diff_populate_filespec(struct repository *r,
 	int size_only = options ? options->check_size_only : 0;
 	int check_binary = options ? options->check_binary : 0;
 	int err = 0;
-	int conv_flags = global_conv_flags_eol;
+	int conv_flags = repo_global_conv_flags_eol(r);
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
diff --git a/environment.c b/environment.c
index 6445994986..9b98b3b075 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
@@ -164,6 +163,13 @@ enum eol repo_core_eol(struct repository *repo)
 		: EOL_UNSET;
 }
 
+int repo_global_conv_flags_eol(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->global_conv_flags_eol
+		: CONV_EOL_RNDTRP_WARN;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -442,11 +448,11 @@ int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.safecrlf")) {
 		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
-			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+			cfg->global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 			return 0;
 		}
 		eol_rndtrp_die = git_config_bool(var, value);
-		global_conv_flags_eol = eol_rndtrp_die ?
+		cfg->global_conv_flags_eol = eol_rndtrp_die ?
 			CONV_EOL_RNDTRP_DIE : 0;
 		return 0;
 	}
@@ -791,6 +797,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->use_nanosec = 0;
 	cfg->auto_crlf = AUTO_CRLF_FALSE;
 	cfg->core_eol = EOL_UNSET;
+	cfg->global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
diff --git a/environment.h b/environment.h
index bf6701560d..47d7a9792d 100644
--- a/environment.h
+++ b/environment.h
@@ -168,6 +168,7 @@ struct repo_config_values {
 	int use_nanosec;
 	enum auto_crlf auto_crlf;
 	enum eol core_eol;
+	int global_conv_flags_eol;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -226,6 +227,8 @@ enum auto_crlf repo_auto_crlf(struct repository *repo);
 
 enum eol repo_core_eol(struct repository *repo);
 
+int repo_global_conv_flags_eol(struct repository *repo);
+
 const char *repo_excludes_file(struct repository *repo);
 
 void repo_config_values_init(struct repo_config_values *cfg);
diff --git a/object-file.c b/object-file.c
index c049bf13f7..b3ab8f5bcb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -33,12 +33,15 @@
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
-static int get_conv_flags(unsigned flags)
+static int get_conv_flags(struct index_state *istate, unsigned flags)
 {
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
+
 	if (flags & INDEX_RENORMALIZE)
 		return CONV_EOL_RENORMALIZE;
 	else if (flags & INDEX_WRITE_OBJECT)
-		return global_conv_flags_eol | CONV_WRITE_OBJECT;
+		return repo_global_conv_flags_eol(repo) | CONV_WRITE_OBJECT;
 	else
 		return 0;
 }
@@ -576,7 +579,7 @@ static int index_mem(struct index_state *istate,
 	 */
 	if ((type == OBJ_BLOB) && path) {
 		if (convert_to_git(istate, path, buf, size, &nbuf,
-				   get_conv_flags(flags))) {
+				   get_conv_flags(istate, flags))) {
 			buf = nbuf.buf;
 			size = nbuf.len;
 		}
@@ -615,7 +618,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 	ASSERT(would_convert_to_git_filter_fd(istate, path));
 
 	convert_to_git_filter_fd(istate, path, fd, &sbuf,
-				 get_conv_flags(flags));
+				 get_conv_flags(istate, flags));
 
 	if (write_object)
 		ret = odb_write_object(istate->repo->objects, sbuf.buf, sbuf.len, OBJ_BLOB,
-- 
2.43.0

