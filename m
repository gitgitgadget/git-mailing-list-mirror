Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5A745C1
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435918; cv=none; b=XSn6fmURXwxKWGloSfbtPmuaGD4LfxXa2sJIgU+fgZbbGleUzLi9KmMQ70sBwPxYT1cwNf8HwQ/0ThWayfFqswJ0kzPFrGxeQOyidoJJuwx/4CjCiuCg/zzpMaJ+sTnfdd8wpA6ZWVrnDa94vMVKI84zcxV7VdCsPqrmP5KNIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435918; c=relaxed/simple;
	bh=T5XxBEBaYuACA2GrzRCBSpRuI9t7YZuvFVR64MSqJ+E=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eJP+/UxZiVMXC4OuoNiBapzT089q8a4gyrt6VudvHuIrpEnEbNH0ALTw9Q1QDE5w9u+enwSEkIUr7WExWLDdBHnvRZ3cM4w2Blq8CHUyOEkKHiOxqH/yQmoh4pTgRLWiMdnLDs20h0OTmGYtcfb2gRq5nJjBbHAWpPLkxXPAcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsn8narf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsn8narf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413f8f5541eso3475365e9.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435914; x=1711040714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IQe7fFSBIOKmZgTGj08sFRGzDizk0S4zIjA9PLPARo=;
        b=Bsn8narfJpGQqI2qtqYBGXSEbl1sDO/fUp4sgic5Jlhx/TPb1HD0x5+TbW2Md6sPVK
         meBzZbYkjYsd19cxfiwdPtHi3LQb0bOnSrzncYABV4Bmq1V+Y9Faza4K3Mv+Omu4gsCj
         1fKBes+OHDzV5mtFH638Rt3uxTABxNsO2tGgpicv2lC2j2JLhlezVBLf9lFKFvMf/Y65
         JlNarAkARgfo6O2qXltl/tgoxv3OCr/m723G2pOERk7FiSQrZ6b6dOgZyY2lT9pcMcRs
         q7UadRYanalV+B3mFe0hj1lRk4PvlpDtF3/LXKDG2cZVgxwWzmfc/sWPBG5m3B3tz7AU
         nVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435914; x=1711040714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IQe7fFSBIOKmZgTGj08sFRGzDizk0S4zIjA9PLPARo=;
        b=CSYnXxyQp7CeSuO4TjC6/92kOpvpS1Oc3C1HakKZWDCNFK9+yUpl9t9ToCbEdbBZrh
         nOxn563lFrcWOLD132DR7C+iE5cGtOFdl3EThF/jZNhnY1Gl2FZwzKfAIkshpMo/Lrib
         7+lw8ZhDONMhVZSvLq4PhBNpIog+sVOHQS+H0wOxPcconmLyg8tOCTGMsEMbvTsiKWTH
         4PIDkwBfYgMGkGFAYH13rDYWhdrfyJYsmvqHRGRdx2Hrbkz1IufvU195OpIl2ty3Qe8M
         L9SGmoKTjOa83AzL0fkR22oVTgtGbaSx8lft1dy6/b1WoiM+p19uVi/y9FPQBD4DT1mm
         4eyQ==
X-Gm-Message-State: AOJu0YxbGAnZ6NYtFSbte6qKQSGBGGQ2py4NInJPzkIYX2Kqi+dLfvET
	YquzOz76xDaMa54v+XY6TTgr8pxQK/K/WOlvWbM9DgRtl9Krwb60DHlsTLOU
X-Google-Smtp-Source: AGHT+IH3PjdEEf94EBmt3WQAsX7JCwSm49Z8/U0h1B72eoN2s6k7Vlhr4/SpHAF6V4Dduf8KroFZAg==
X-Received: by 2002:a05:600c:4ecb:b0:413:fc09:7b1f with SMTP id g11-20020a05600c4ecb00b00413fc097b1fmr619245wmq.11.1710435914275;
        Thu, 14 Mar 2024 10:05:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020adff206000000b0033cf5094fcesm1171034wro.36.2024.03.14.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:12 -0700 (PDT)
Message-ID: <47d0ec28a55a5c6604b30ad99953a078a789023a.1710435907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:05 +0000
Subject: [PATCH v2 3/5] merge options: add a conflict style member
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a conflict_style member to `struct merge_options` and `struct
ll_merge_options` to allow callers to override the default conflict
style. This will be used in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 merge-ll.c        | 4 +++-
 merge-ll.h        | 5 ++++-
 merge-ort.c       | 1 +
 merge-recursive.c | 3 +++
 merge-recursive.h | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 6570707297d..bf1077ae092 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -128,7 +128,9 @@ static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unuse
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
-	if (git_xmerge_style >= 0)
+	if (opts->conflict_style >= 0)
+		xmp.style = opts->conflict_style;
+	else if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
diff --git a/merge-ll.h b/merge-ll.h
index af1ee36abdb..d038ee0c1e8 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -78,11 +78,14 @@ struct ll_merge_options {
 	 */
 	unsigned extra_marker_size;
 
+	/* Override the global conflict style. */
+	int conflict_style;
+
 	/* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
 	long xdl_opts;
 };
 
-#define LL_MERGE_OPTIONS_INIT {0}
+#define LL_MERGE_OPTIONS_INIT { .conflict_style = -1 }
 
 enum ll_merge_result {
 	LL_MERGE_ERROR = -1,
diff --git a/merge-ort.c b/merge-ort.c
index 4a02c3ecd99..a9ab4031451 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1966,6 +1966,7 @@ static int merge_3way(struct merge_options *opt,
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
+	ll_opts.conflict_style = opt->conflict_style;
 
 	if (opt->priv->call_depth) {
 		ll_opts.virtual_ancestor = 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index 02b7b584f95..33b5f9384e8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1054,6 +1054,7 @@ static int merge_3way(struct merge_options *opt,
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
+	ll_opts.conflict_style = opt->conflict_style;
 
 	if (opt->priv->call_depth) {
 		ll_opts.virtual_ancestor = 1;
@@ -3899,6 +3900,8 @@ void init_merge_options(struct merge_options *opt,
 
 	opt->renormalize = 0;
 
+	opt->conflict_style = -1;
+
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index 3d3b3e3c295..e67d38c3030 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -31,6 +31,7 @@ struct merge_options {
 
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
+	int conflict_style;
 	enum {
 		MERGE_VARIANT_NORMAL = 0,
 		MERGE_VARIANT_OURS,
-- 
gitgitgadget

