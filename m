Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE233CEBC
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402805; cv=none; b=MBO8j/Ru+aRAi7KfRxJJRcKBKyVxP8g6GiEuCLcUFeBCcQrkGWYHMxflP4YUixVu7NH3dtdbBjobPpOw8veZdHFjAuFcda3iC5S9fX23eVGR0FlgVODyPf77UcM3aA0Gz/uO2ogUxqdS/QiKiGAz2Y7Z0BYDUporR6qvZfnnvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402805; c=relaxed/simple;
	bh=u+65bEYlQ0xDjDhEYmkvDNN7UgDSE4EApK30SOb6poE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YMl0TSHlCO48Q1urvfh7DK34Jif86Dj7xqks2Cyy6nCtWWVjUUSigdCF0lEkC8yGbhGbmqOHsAdSRQBWAm+eVmSP5EwD7wcL/ke7Qr9HVhYSG0IdjCDhwkErKQBGQSXfYJxfvygOXyF+2DwK66nwNQ5jrNxb4fYGHwmNBMHaYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6jhTFUr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6jhTFUr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c59dc9so14731881cf.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402800; x=1757007600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSB1ZjKXsOlCk72NGjmmXxnlzsc5+RtjxlXZyosxCZw=;
        b=J6jhTFUrEGXQYlMYtw6l8dv+gWWhfFnWB54SJGhxrQgzyH2GxgPdN4s0jAH+H7vbgT
         XOKWSu6uEqiUnaXxiADXR1pe814z1ACo77a612MSo+MU+pl4FGrJJq0xQCxH89QcY2yl
         dgw2XkkfswbYpuWJxa2xo7rvPC11qgmsVfn33+pdLm74W5RFUIViBAvJ933p5UvJCKZh
         4kjbzKmibWcUgIg5Xe/Emqdv77xf6FLSUPp2P0UHhzb5ZxpeRKjc5RY5CYoMhGla8pIY
         LbEjAt1hWROBXWO0IjBg/yysY/BSibMBtMDsnjzoz6fb37BKVoLFaXJC2Fz0i5Km76PU
         RT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402800; x=1757007600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSB1ZjKXsOlCk72NGjmmXxnlzsc5+RtjxlXZyosxCZw=;
        b=huEwIVts3o7KAGilUAtwRRvZeYaMk1FR7JeruMxczHBMkp1VvxCRUu3FATlQVpg8fY
         OxE7G/oSRIu3v5nuFBAtNynpx6Hmv4253yQqJd5CFBWxKpGZFnUQHiyA6dXoys1WIKdZ
         E6RrzGNrh9pnIV/BMJFWdWLjqr276tYewrOC8SbMZ+6Es3MZ93kRYt+xuIk5E088H1Sr
         sB+6rK+TYLtimiH2EYBM9446l6ua0vPXs+Kd+Z92liQtssBLtz8sZIiqyUf2H3T4uxMc
         xDUJXI0lNwdV7FZL84ANY89DC2W/SptmPgo7jvBccAGRtcLRxqwYUWceYqrGxjTOhXLQ
         zGow==
X-Gm-Message-State: AOJu0Yy2SttU+768mquZQ9GWUV5C5QxCumJ6QgVazx5gqG+YPK3hjSEt
	ReGfWTmRU9DCKQ27CCcl4/PAZF4uzfLdSAoO4Ma2lxcSB2i95IZsCzVrQIbVAc5m
X-Gm-Gg: ASbGncuZm+3nS1k8PylnM4jcNRqRkAbxX0b3aBZihXWcgG2OKVJIzzhLAaV4QfAaYvH
	8z+6glG4hM7ht9zqdmlOAlJCKjaPRvhE18kfA9mWYCY5hgL2lHbRNLWYX0TFLqwdJZ/AXUZ9be9
	HHyj/P2Da+BzC7m5yk7JRrDYFb1I02tKRVtHjiq8+9am63nJcKPA2k5uLgBQvU+FklJBFNVTZxv
	WW7rusJCHwQlxuhHVLg484425nhMRWVxWoHJoCxJxIezG/xlJETqniqbAyMIXGh518ZA99sN4Ri
	T3m81aFSuSqLbHG0AdkgKCh3ZSBQhznMIx7HSgAhM0GAkFAZSA1KDnzY6os1Qd4gslQevZaew7Q
	Yh8VfDpsG2zmuLEyEjw9suOqP
X-Google-Smtp-Source: AGHT+IH63yyDad18VGNxvI7Q/krCC5vSyK9d/RnnUQ4I16EcBvjpgCHk6B65iu92JCLxkRmxWYKyrg==
X-Received: by 2002:a05:622a:540b:b0:4b3:27e:72d8 with SMTP id d75a77b69052e-4b3027e7eebmr33026511cf.40.1756402799849;
        Thu, 28 Aug 2025 10:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b584340sm1377881cf.17.2025.08.28.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:39:59 -0700 (PDT)
Message-Id: <a5bee036019a044273f93434f9e382a4cfa6533c.1756402795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:53 +0000
Subject: [PATCH 3/5] midx-write: use cleanup when incremental midx fails
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The incremental mode of writing a multi-pack-index has a few extra
conditions that could lead to failure, but these are currently
short-ciruiting with 'return -1' instead of setting the method's
'result' variable and going to the cleanup tag.

Replace these returns with gotos to avoid memory issues when exiting
early due to error conditions.

Unfortunately, these error conditions are difficult to reproduce with
test cases, which is perhaps one reason why the memory loss was not
caught by existing test cases in memory tracking modes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 85b2d471ef..f2d9a990e6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1321,13 +1321,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
 			error(_("unable to create temporary MIDX layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
@@ -1427,18 +1429,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
-		if (link_midx_to_chain(ctx.base_midx) < 0)
-			return -1;
+		if (link_midx_to_chain(ctx.base_midx) < 0) {
+			result = -1;
+			goto cleanup;
+		}
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
 					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		strbuf_release(&final_midx_name);
-- 
gitgitgadget

