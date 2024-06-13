Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC182C67
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310313; cv=none; b=A/jzK3J63wz/vju++yRS1h7UzgO3FTaOYHJXl0Dz9DlgH9zUHt6688IhyVim925ydQQyuEPdWeLsRwlRYmmGV9kUP4ozI7ZorvGsLBWz6lpn5VxLDmr4C4heUpFdConb6z3bosctSpvMuf6zcdG6qHXv7SaAoVb3OtukP7XvyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310313; c=relaxed/simple;
	bh=OPi3b/GMulpBT0QV1VdSJlP0mGfS7ONhiG6/DdJUfJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yh8mR1lqeENexuspY1K6KTT8NMtXqxyhr/yPvNbwp4qm9l3OfJDyd7F9YBHy53uyVAMr8dn6ibcjbKJeTt/wvbd1e0xqXePHOHtPu+z1xS0mGiEa0mIQKLFn35LeP77dUfmSq++ZN7Ckbgn2jDvMhED+tnRw8bRicEjnEixhdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddYtnuWg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddYtnuWg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421757d217aso16272915e9.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310310; x=1718915110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQB926BDScI7gAUE1hQ2OAdJAxYFLzHUV8FSZigHySU=;
        b=ddYtnuWgpRsxEwG5s1z4NOoHIXGsHOs68P8Q3f77/GXDpb9PRPVOTTHZOKSbkZx8uy
         dxfcU+EMgyqT7H7jHb42cwyMU84Cs+HhEVe0Az7ziTBEzJELTqeNFp2+MSEvbUMOqxL+
         BUWK/6Z4/dB2yBGrYex0LkGHxOwpL2UNF91AvGlr0yu05cfeCv+zftSwkTxUvYlVJXSn
         XqB9OUu5bI273cP9guyhDPVZnNLuJ4mVp8MbmDtOypoD3YLCP8usw9WG/rQyDNpmtQea
         by6PnuMQy6TkK3z71nocg7SnvoOhr0KGYiKUoA+7nVACyx+rLlL/Nvmhp0Fl6rCd108x
         LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310310; x=1718915110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQB926BDScI7gAUE1hQ2OAdJAxYFLzHUV8FSZigHySU=;
        b=qss7+1xhTT0zGc3+N6NLoHMVnicicu0WzsIpQVyb5jqgC5iO6E/NzdBhQX2ZlOGEsg
         8OmPb4sJ8qdBA5nbxgBKlCdJghcgaYl3WwtfMI2RLtw40QS4Bx4ei0AWiApluqumbTF3
         ByUOcSyyr/y87a11Al2XRnSjv5/AUvwqVS6HWAUu/7FVcUzxgz0CdDMFhELEH8FB7rzS
         rUBASb05v1Mb2OsYmHsUTB0boluB/D1qTmx+6VzGxZ7VqFe33JfzMqaPI//zswGica9f
         nIqHMXYezQMCj2mwJ69tAQsx2dAP0Dswjo0oKTGM5+M9lzQFXfeV6nkrQo19NoA5FBTb
         nwxQ==
X-Gm-Message-State: AOJu0YwHgm9cY/C4i8vg7+7ASme+wngDgviOxdUD6rOHW5zvIkPiJANo
	HajqMTezUgi1iD3SonyEoCMcbz4gRcGFlsxxup8ET5ei2iAOotK35q0sYg==
X-Google-Smtp-Source: AGHT+IFy9a6VsEkbV730nIpos3DRBUwAj83fL7JEYtf97V2jEEHMfo8jiU/MpUsmDpHMY58vazUuhA==
X-Received: by 2002:a05:600c:354f:b0:421:e7ae:955b with SMTP id 5b1f17b1804b1-42304825ca9mr7502285e9.21.1718310309999;
        Thu, 13 Jun 2024 13:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423047e28b7sm9942485e9.44.2024.06.13.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:09 -0700 (PDT)
Message-Id: <d4ba1fccd9145db9b3fe1530881052315cfa16b8.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:01 +0000
Subject: [PATCH 1/7] merge-ort: extract handling of priv member into reusable
 function
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In preparation for a subsequent commit which will ensure we do not
forget to maintain our invariants for the priv member in error
codepaths, extract the necessary functionality out into a separate
function.  This change is cosmetic at this point, and introduces no
changes beyond an extra assertion sanity check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eaede6cead9..10f5a655f29 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5000,6 +5000,28 @@ static void merge_check_renames_reusable(struct merge_result *result,
 
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
 
+static void move_opt_priv_to_result_priv(struct merge_options *opt,
+					 struct merge_result *result)
+{
+	/*
+	 * opt->priv and result->priv are a bit weird.  opt->priv contains
+	 * information that we can re-use in subsequent merge operations to
+	 * enable our cached renames optimization.  The best way to provide
+	 * that to subsequent merges is putting it in result->priv.
+	 * However, putting it directly there would mean retrofitting lots
+	 * of functions in this file to also take a merge_result pointer,
+	 * which is ugly and annoying.  So, we just make sure at the end of
+	 * the merge (the outer merge if there are internal recursive ones)
+	 * to move it.
+	 */
+	assert(opt->priv && !result->priv);
+	if (!opt->priv->call_depth) {
+		result->priv = opt->priv;
+		result->_properly_initialized = RESULT_INITIALIZED;
+		opt->priv = NULL;
+	}
+}
+
 /*
  * Originally from merge_trees_internal(); heavily adapted, though.
  */
@@ -5060,11 +5082,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		/* existence of conflicted entries implies unclean */
 		result->clean &= strmap_empty(&opt->priv->conflicted);
 	}
-	if (!opt->priv->call_depth) {
-		result->priv = opt->priv;
-		result->_properly_initialized = RESULT_INITIALIZED;
-		opt->priv = NULL;
-	}
+	move_opt_priv_to_result_priv(opt, result);
 }
 
 /*
-- 
gitgitgadget

