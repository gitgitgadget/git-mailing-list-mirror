Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4C30F52A
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965886; cv=none; b=XVkywPp0egN6BenvU9poOp+B52bkrKUXho6SVk3KOelwxyKzlC3RdIKIe3wHKnutjgs5XGjHkAvDg0iqLS+f8wHvIFmCojcTvYuYKVWLA044V9hXVx1Iog7/BgrSj1h5dwghO60VA5J01/z5/zjLAP8BSjo7DMX5HGGw6eiCqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965886; c=relaxed/simple;
	bh=La+ucrKJA+ZkkOCNLHPH/CCU8+ggLfe1/3HAEID8nG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgJFVQmttKeAElkwCB1K0+gn4oEy2XM0+7PYos4Lw2do1iKLLdMTXtIvwQpXksEl5T+AyuwdtGhpS3r2ZLu42kE/F0U9UIGAvYnE7moKFAVd+av97nutEHKhbivIblPipPhOTRxFIrgpH9mnHgIAmVIrosqX8LfMEEz0fPWMuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chjv5uCk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chjv5uCk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0a81d286so781121cf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782965884; x=1783570684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxFmMLHFKHJN98FnvsMg1gW+nIF4mB3woZZlTu2YcsE=;
        b=Chjv5uCknj8VxIYqk+0qDHqnnYlA1T8GvGy3W9kEYx+dNb7no/hJ5BFRrnS8fsFsk8
         JKQfqipwJYABCys2xZO/a+Sg2rGGlwDSKT8Ny8Zmm6mtbd5FDeHNyGS0rcstmAZhTnYW
         Gg4TAsELh1HtzQDFfWrOJNfkGR5ySaIpCZAlnQVSzO+Xa00y9glWntuhSBxMuxSbzLQc
         dgXGSyX72EOV4ARANnoZd7GXlVJr1ka2XWK8g0Rptar+/h6Kil4eGdnJO74XAs2i8uZy
         0oAW+JDm6mMjdCkVDRoIMd2dlAbNYiTeK9VgMICoQ4486cywxS+BliG5HRpKbjUuASnN
         Xuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782965884; x=1783570684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxFmMLHFKHJN98FnvsMg1gW+nIF4mB3woZZlTu2YcsE=;
        b=JOqlnki86HUA/L4YJIQezWfDfDe2WgTVUY0WsuCwiAwzKjfdKcPta1rp41U4Rjciki
         1iFO9WBjZlG/G0BKqtkArlljBuDfSzye8fHmPQ+Z83VAlOeail32QB8uPLibvkxjkqsN
         IzcL1KGXkiwTGinPrdFkXM33sOmB1ooMSGOCQtb+qoz9s2S2rFWAuNkykND5m8zG1Mmp
         8O/SMFv+NSZ3tqZgzPD0nWmmrKMjzUyQYi/qNTpTMHsTd14uNabCPOv0mVa/0D/Y6a/p
         phL6nE8DYK9pt5okumTV0RIwjHMO/xzwrgZ9gA+R32t8ZUGUnjLikmjhLcVP5a48QUws
         PvMw==
X-Gm-Message-State: AOJu0YyVjP/DVTogRAJhlqG0U9dTkIGBoJD+DgoH/bpBk24zlVQO8cKC
	AFiS7zwNU1uCJ2k/alQ/3YVpprJZ/1LWdCIpaiI94J4OuGkPUJwj+95ZfyZGeOhUMAm7RA==
X-Gm-Gg: AfdE7clwYy6WejLuzF9ubCr0IKTa2vj7GbyqW6wXEJ0vBBpd+sWoeE9Tt81usD7aQgk
	pioPLk4vAAKSWhgQ8Rcz8LGy05oydFZqzGmcFyWY7WLlif7MiyYccxjLojn8y+sT6tgwS1+YlLJ
	qiEbEsJK0ZceBsepxkssw1QEeMh7YOoJgwl5qLZ+S8z1gR7GkVJopuVtaHhSGTvBxA9Lqw+2gWA
	8a87erFCo1N3JgkY0N972bZ6xFqpQ2hoVxOGxhbkJPyEyOdylVlBgSQKY0U1QrTtM/jdDQEqCOV
	/S0X2MBx5u2KBD8UwLlVU9Q7uTo59V+doJBcoZusDzCopixkhQWvSljqwvNV0KxHssNdKvpzr2a
	x6CzHnZ1OnPhFrypENg1h+94NKMr0h90PRCNaKEpO+uepTn2+NginR5S1cKv9yyycIzWtZ8qtXB
	rz++yeB8gq8N97xHUVWGW2+RwvnCq2s8jOAhZ9eKtFnjtCWZVH4MGKFmvb
X-Received: by 2002:a05:622a:13c6:b0:517:c699:3387 with SMTP id d75a77b69052e-51c17fe22b7mr99087331cf.37.1782965884404;
        Wed, 01 Jul 2026 21:18:04 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4040:a540:dd00:408c:f99e:29b4:a810])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm17167846d6.49.2026.07.01.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:18:03 -0700 (PDT)
From: Zephyr Yao <zot.zot.yao@gmail.com>
X-Google-Original-From: Zephyr Yao <zhihao.yao@njit.edu>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Zephyr Yao <zhihao.yao@njit.edu>,
	Mahya SamDaliri <ms3539@njit.edu>,
	Haotian Zhang <haotian.zhang@njit.edu>,
	Martin Kellogg <martin.kellogg@njit.edu>
Subject: [PATCH] apply: avoid leaking abandoned git-header state
Date: Thu,  2 Jul 2026 00:17:59 -0400
Message-ID: <20260702041759.51572-1-zhihao.yao@njit.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When find_header() sees a "diff --git" line, it calls
parse_git_diff_header() to parse the git-style extended header. That parser
updates the caller's struct patch as it goes, filling in the default name,
old/new names, and new/delete state.

But not every "diff --git" line found while scanning is ultimately accepted
as the patch header. If parse_git_diff_header() returns a length that covers
only the "diff --git" line, find_header() continues scanning for another
header. In that case the partially parsed git-header state must not interfere
with the later traditional "---" / "+++" header.

Leaving that state behind can combine incompatible metadata from the
abandoned git header and the later traditional header. For example, after:

	diff --git a/foo b/foo

	--- /dev/null
	+++ b/foo
	@@ -0,0 +1 @@
	+x

the abandoned git header can leave an old name in the patch, while the
traditional header marks the patch as creating a new file. That impossible
state later trips the check_preimage() assertion that a creation patch should
not have a preimage.

Parse a candidate git header into a temporary patch and line number. Commit
that temporary state to the real patch only when the git header is actually
accepted; otherwise release it and keep scanning with the original patch
state unchanged.

Also reject an empty parsed default name from the "diff --git" line.
An empty patch->def_name is not a valid pathname, and should not be
used later as a fallback when old_name and new_name are missing.

Add regression tests for both the empty default-name case and the non-empty
abandoned-header case above.

Co-authored-by: Mahya SamDaliri <ms3539@njit.edu>
Signed-off-by: Mahya SamDaliri <ms3539@njit.edu>
Co-authored-by: Haotian Zhang <haotian.zhang@njit.edu>
Signed-off-by: Haotian Zhang <haotian.zhang@njit.edu>
Co-authored-by: Martin Kellogg <martin.kellogg@njit.edu>
Signed-off-by: Martin Kellogg <martin.kellogg@njit.edu>
Signed-off-by: Zephyr Yao <zhihao.yao@njit.edu>
---
 apply.c               | 29 ++++++++++++++++++++++-------
 t/t4100-apply-stat.sh | 25 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index 5e54453..2ce9b6a 100644
--- a/apply.c
+++ b/apply.c
@@ -1362,6 +1362,9 @@ int parse_git_diff_header(struct strbuf *root,
 	 * the default name from the header.
 	 */
 	patch->def_name = git_header_name(p_value, line, len);
+	if (patch->def_name && !*patch->def_name)
+		FREE_AND_NULL(patch->def_name);
+
 	if (patch->def_name && root->len) {
 		char *s = xstrfmt("%s%s", root->buf, patch->def_name);
 		free(patch->def_name);
@@ -1632,15 +1635,27 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_diff_header(&state->root,
-								state->patch_input_file,
-								&state->linenr,
-								state->p_value, line, len,
-								size, patch);
-			if (git_hdr_len < 0)
+			struct patch git_patch = { 0 };
+			int git_linenr = state->linenr;
+			int git_hdr_len;
+
+			git_patch.inaccurate_eof = patch->inaccurate_eof;
+			git_patch.recount = patch->recount;
+			git_hdr_len = parse_git_diff_header(&state->root,
+							    state->patch_input_file,
+							    &git_linenr,
+							    state->p_value, line, len,
+							    size, &git_patch);
+			if (git_hdr_len < 0) {
+				release_patch(&git_patch);
 				return -128;
-			if (git_hdr_len <= len)
+			}
+			if (git_hdr_len <= len) {
+				release_patch(&git_patch);
 				continue;
+			}
+			*patch = git_patch;
+			state->linenr = git_linenr;
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 8393076..d3406ed 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -113,6 +113,31 @@ test_expect_success 'applying a patch with a missing filename reports the input'
 	test_cmp expect err
 '
 
+test_expect_success 'empty default filename reports the input' '
+	cat >empty-name.patch <<-\EOF &&
+	diff --git "a/""b/"
+
+	--- /dev/null
+	+++ "
+	@@ -0,0 +1 @@
+	+
+	EOF
+	test_must_fail git apply empty-name.patch 2>err &&
+	test_grep "git diff header lacks filename information" err
+'
+
+test_expect_success 'abandoned git header does not reuse names' '
+	cat >abandoned-git-header.patch <<-\EOF &&
+	diff --git a/foo b/foo
+
+	--- /dev/null
+	+++ b/foo
+	@@ -0,0 +1 @@
+	+x
+	EOF
+	git apply --check abandoned-git-header.patch
+'
+
 test_expect_success 'applying a patch with an invalid mode reports the input' '
 	cat >mode.patch <<-\EOF &&
 	diff --git a/f b/f
-- 
2.47.0
