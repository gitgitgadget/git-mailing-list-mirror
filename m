Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA32F0688
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183113; cv=none; b=obTmCGkXrbi7fYT8nN5PspVFWB7gsp5zaO2Q/08cSaZ4SzqxzwhMkTy/wmAGlE/6jBzhg6WtwyW8g2NjUsnu4y/drT65i/t+1Q6nowOczqvhrtegpR6iKFb1oQ6D6LDB5rPC+f5ryjgyWnQyCK1/hjzbNmcV7qlu2aQudPOLH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183113; c=relaxed/simple;
	bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSbwV+Spvka43lAilgSiS7CcMjujLQoU87dz4YVluAZgY5MJudCwKSP6NvUcP7L+XSq2PtJp5XvM6DxPA1LwUVeZmh45vaiC577MGCyX0NoOEPW2ipFiAh0IFavGDSl5g/3HN733l1THD05OMK1KyTdJkCEFXOwEcj5csyP1j7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IslLivtH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IslLivtH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b223ec0d5caso30536666b.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183110; x=1758787910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=IslLivtH+Fhr7IMfQwfllPFPfkVnh5QWZqjPOVf4+71Lb8jX288bShye4LaR7bhrxq
         Nn+cvo9aYbxxStidWhhnrVDwixDeoLCwWIC5JvOe3tREhbXUJMdk9ow8Uw8P7Yhkb+NE
         UBQynJO0ep51o7mPYYAiI4jB00yFuU/vHLNp+GIxj9X+nWPtMg5QEHVV87by1TvmLpNl
         rnQhVohirBwAt0+rmzQ5DHKLoyW2rOJ7lmgPO0TID2VFPVy4XHj8f709IA+OVz9TA/ML
         dxWHhTGAdCAKQ7/wC6cYdOrHqcDmqB065//El0ePGocFVi1cxvnkDGfYIDjJyDmTKFyJ
         ThYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183110; x=1758787910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=qhcd1WdygCUvMJ9r2S3US52FCiFfqmhjLNR2PfkAWKTp9H0rCD/c0pb8B7csNFWbFz
         6cN5eX3QhHIG0p49yNJFy24daEsCNEKAt3R0v1aw3yIqL3gWo9uw1egoqIniXdGkh/cH
         u/xG+YySr04RxdXLoJ4HdUEuwhVJv26oufPHWFNqBrXmtkYVMJdOLxd5MHvw/MR1G17q
         d0e2uv9tdtDbaKOLTk0HlXfoHYP5LNfkCsEJwLekYmsgVQPdLpcsyIPe8JJNEorow38P
         RFkY5gaBQ7yHdqe6XNhw/b2WsURDS2egSAYKd64BhjkYtZ4tP0TzXYzyrMiJwmbYQbQF
         JDCg==
X-Gm-Message-State: AOJu0Ywbu0XC67BMoO9i8kyBFtkBfGMcBv5VlYY6v0deRUPTQOjfhW4o
	8fnCbINPWdufH8fE47uzECSsYlU6MNaxXbkFx9lh22fE47/w1nic9N3q
X-Gm-Gg: ASbGnctd/mJjJVLiptsLO5RrHeqGIIFWU6Fs1lgpA/+fGfvphQSz1cbgW+D++AwBNYL
	pXkGMYTFvnarRbj0uS0DZdMwfK7439EU5ZyWPdpmOcq+7eOn/DB21A+w4hrAilFmPra8WWcCxs5
	LXZjRwdrsuOh3B6FfWnkVhpqvwcSw/WXkkATmfTawF53ZUlErm+PPT5F8bF52RRqZDf2sEd+1oM
	nXwq8hRb67pOaVE/UA/WQ0lnHvQLzhMWPDvZTTR/3BbZcsMu2Qd9AvdgormDMnG851z2ccMvLCK
	I4yBal+gguAYTcmgj4sIJxXqm+dGgUShSwvD+1qD7SB2I0041yL2ucTAxk1F6izMTG79BNpg/GK
	kA5lbniBNqNgqkl+M/zMLU+DEVuhGD8aXvCFb76p5dYAiryE=
X-Google-Smtp-Source: AGHT+IHqowS1Jm0alpqNLSmUSeVetn5l8V69a93XnOpFx+EIGvDwMxkm7z5Ei8GqjD6OY+y1WtWi+g==
X-Received: by 2002:a17:907:9408:b0:b0f:3a50:82a2 with SMTP id a640c23a62f3a-b1bc268440dmr563068866b.57.1758183110005;
        Thu, 18 Sep 2025 01:11:50 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:43 +0200
Subject: [PATCH v3 2/8] refs: move consistency check msg to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-2-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsK50jYUeIjD62lMT6B3iHmyqQmXLp0bT
 ARqEMoRjSA774kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77CAAoJED7VnySO
 Rox/ZCgL/j9qM6jF0U3lX7lStQLS+uRk4m1FDPVM0q7TuEdf0Cqb8e8XW06BrhZQQwmZvzch3+o
 mc+DMH067eqTgUpqTYv/tsraieJ4VoHMKy6QoIl9cHIuBYr5ydPNBgAkpvx87V9N2rpMYiKbSmj
 NkmXOlk3rhNzQ7o/dD7kAl63KJa6n534k2XIzMnS+7Qcxig3gT7qWeQed6qQucSnQV3py5kGzTC
 jOu32r8boCByY62juy0FSYdjf/XoGaytsMLLyZcUFhGypQRrR99XfnrcdsoyLnxSnR1xSgQ26A1
 qm/6qhcijxkSl6K0Rj7XdsXl7WH+2xM2W6pPzBefuK68ycP/KQ42gYs2LlqXROOFs5thFOGrC3C
 5p3HfaRRRiWY8jQxv5sPjw67GTuY0xj0+N1DPyr8ehMjPtfYwdya6dJhddNlbwHa26vBr8/IZfj
 qyFOLX+TYFeY1fmUWoZDgka3bfDx1jrO6LUSJtl8+j/v9fun++Y0cqbeCzUfpopzdPWNP4+03y8
 JI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The files-backend prints a message before the consistency checks run.
Move this to the generic layer so both the files and reftable backend
can benefit from this message.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 4 ++++
 refs/files-backend.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..4a7c394226 100644
--- a/refs.c
+++ b/refs.c
@@ -32,6 +32,7 @@
 #include "commit.h"
 #include "wildmatch.h"
 #include "ident.h"
+#include "fsck.h"
 
 /*
  * List of all available backends
@@ -323,6 +324,9 @@ int check_refname_format(const char *refname, int flags)
 int refs_fsck(struct ref_store *refs, struct fsck_options *o,
 	      struct worktree *wt)
 {
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+
 	return refs->be->fsck(refs, o, wt);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d4fb033417..603b1343d8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3906,8 +3906,6 @@ static int files_fsck_refs(struct ref_store *ref_store,
 		NULL,
 	};
 
-	if (o->verbose)
-		fprintf_ln(stderr, _("Checking references consistency"));
 	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 

-- 
2.51.0

