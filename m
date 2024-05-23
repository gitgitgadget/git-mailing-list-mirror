Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C911B7FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482297; cv=none; b=ULesWhl9oO12z6wWUROALWLmlqD7CDMVEUc3VooibogIRjrfTTkKCYif+Qf9j4wR+lR48pGStaEM9S/F8QgjrMvemkBxkpljpdVYC8SO04obLH+vCBrw6Yu5lrK01p50WLoWZaGlGFh1oJ96lWTtCpcv3vWXi9Wz8v97qd3ueEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482297; c=relaxed/simple;
	bh=o3id65niulCMX++GDzA3VFolhNsb7ubDDbSO568qZuk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOlNsNBORIkzIvqZTrwwq9TCXsFdwLe5zs52tcOJWLbUtpZQJF5tnBTeQLR9qOadQYyYwQSURq7+LV+7Lb9DlOG+AdLeX3awiuLRSGdyu/tWtF33n1+ZRvla4bjRBMGHv+bDoSF1P+h078W1YooFdiSR7/4KqU/IgEbH121M6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VoWJxx6F; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VoWJxx6F"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794a028b8feso96704085a.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482294; x=1717087094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r17ecaxES+jsXGGPceE1uS0rUQtx2r9DaLWAKfBvml8=;
        b=VoWJxx6FlDmiKGKvRLXT++CKQP+cv4hpYnUWnMqckwXY4piQVb7qx0wwhK0jNR7kBv
         somgaGsJr0tNwo2epFbfpeuP8+vSXDOaEKRbWXUr9QfpgvYSBbUUMRaAtprMmy03o2E/
         WgySjuPglFZut8VNDjj6MVBF5AuL5ZawfmVrbqLTY/hW6iaJhXEP0TeZIFlr+Axv/h12
         6/11JQDQxQ4s9IqQeI7mG0HasEBGSoKNEq8Qk75AMmVUA+aADzpQfikePdMIvmhkSXUV
         n+5d338+cb4o8431/IAVpsar0N4lZ8+FTrL0FhG5Q2bAZ/5lrpHmfPnPYpkdu+AW7ETf
         uVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482294; x=1717087094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r17ecaxES+jsXGGPceE1uS0rUQtx2r9DaLWAKfBvml8=;
        b=dIS7NLscVL4ohiw5YAqQplOitAKoW/4il6ehkKqj/6315jrgPnSX2fMexQKdLY2uHW
         M2uHKB/2P6dL/dLupVUjoVnNpLe+rYox+KgnmajCnztl5Fdm91KgCVapgRxv4iMwbQzG
         jz6RCaoR65pw4am4asB9Pmv3/f4DixUvQdMV7uWqovXl3MPJgJkOkGwTRHtmGJIzr2hO
         +LTu0OvSBt9IkSc3lweYUHvJaHQe/xiz7ragu+OrhYwwJ2YfrRHsKGSFDOMf/LrD7jsE
         MMZNYN6A2+g25UnMmAbRgI64knt4eG/mm5L7Zn0C1hDdjba1F/f+OY5S17d+L/qNe8dr
         HrUg==
X-Gm-Message-State: AOJu0YwuvP/6DfvUC6WY0j3CNpIC6z3eFNwqdpug+P3A90MKsX26kiTy
	CkxP8ypaDh/UWAewoOmTSgDbz0+BHRpMsgqV+NKsU4aJc6jV7q6aWaMgvPWWaQwy/2BLLIpu85k
	z
X-Google-Smtp-Source: AGHT+IHfn8YWGI8uPXt/K1k0GAfS5AvXCiNA9gqJornexu0joz61k9uhuY9PRT43HGtL5VPNop8TkQ==
X-Received: by 2002:a05:622a:18a0:b0:43e:2f13:6072 with SMTP id d75a77b69052e-43fa7455dcamr51066951cf.9.1716482294524;
        Thu, 23 May 2024 09:38:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e144a98a2sm147051961cf.16.2024.05.23.09.38.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:14 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 4/8] midx-write.c: extract `should_include_pack()`
Message-ID: <3908546ea85eb36a27ce6bd681a3c2152ff005f5.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

The add_pack_to_midx() callback used via for_each_file_in_pack_dir() is
used to add packs with .idx files to the MIDX being written.

Within this function, we have a pair of checks that discards packs
which:

  - appear in an existing MIDX, if we successfully read an existing MIDX
    from disk

  - or, appear in the "to_include" list, if invoking the MIDX write
    machinery with the `--stdin-packs` command-line argument.

In a future commit will want to call a slight variant of these checks
from the code that reuses all packs from an existing MIDX, as well as
the current location via add_pack_to_midx(). The latter will be
modified in subsequent commits to only reuse packs which appear in the
to_include list, if one was given.

Prepare for that step by extracting these checks as a subroutine that
may be called from both places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index cf7e391b6e..f593cf1593 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -100,6 +100,32 @@ struct write_midx_context {
 	struct string_list *to_include;
 };
 
+static int should_include_pack(const struct write_midx_context *ctx,
+			       const char *file_name)
+{
+	/*
+	 * Note that at most one of ctx->m and ctx->to_include are set,
+	 * so we are testing midx_contains_pack() and
+	 * string_list_has_string() independently (guarded by the
+	 * appropriate NULL checks).
+	 *
+	 * We could support passing to_include while reusing an existing
+	 * MIDX, but don't currently since the reuse process drags
+	 * forward all packs from an existing MIDX (without checking
+	 * whether or not they appear in the to_include list).
+	 *
+	 * If we added support for that, these next two conditional
+	 * should be performed independently (likely checking
+	 * to_include before the existing MIDX).
+	 */
+	if (ctx->m && midx_contains_pack(ctx->m, file_name))
+		return 0;
+	else if (ctx->to_include &&
+		 !string_list_has_string(ctx->to_include, file_name))
+		return 0;
+	return 1;
+}
+
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			     const char *file_name, void *data)
 {
@@ -108,29 +134,11 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
-		/*
-		 * Note that at most one of ctx->m and ctx->to_include are set,
-		 * so we are testing midx_contains_pack() and
-		 * string_list_has_string() independently (guarded by the
-		 * appropriate NULL checks).
-		 *
-		 * We could support passing to_include while reusing an existing
-		 * MIDX, but don't currently since the reuse process drags
-		 * forward all packs from an existing MIDX (without checking
-		 * whether or not they appear in the to_include list).
-		 *
-		 * If we added support for that, these next two conditional
-		 * should be performed independently (likely checking
-		 * to_include before the existing MIDX).
-		 */
-		if (ctx->m && midx_contains_pack(ctx->m, file_name))
-			return;
-		else if (ctx->to_include &&
-			 !string_list_has_string(ctx->to_include, file_name))
+
+		if (!should_include_pack(ctx, file_name))
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
 		p = add_packed_git(full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
-- 
2.45.1.217.g9bb58e2bf5a.dirty

