Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE31137923
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834010; cv=none; b=eX/mspYosVUMN7nc7sz704NOpVzCKIh9TPa6ZNEUy16TNfdBMQXZji0JrtuwCL6qbrzgVYjPVCKCwFLtn7SYeOre7gXmQf2C2pSW4Wp6ZzTKYehJxQwwNliKCFdjZi1gHCfhNFs/U93X1o/ySqGnq9qwkYkT9xXKEP+sCorzTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834010; c=relaxed/simple;
	bh=nsGHKNcDtwMBPgznnsaZ6t0adM5uk30DmWL9oAlw3YU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k1YCBUURYhdem2BEGPH7rqHMGEaGYHEdnTIp7l9JXn/zImq4+BAb+NpNFmsOXk3yZ0S2Xu56P8Fot5sQHG9EYB4ITtwqsNxyBnMGSdzoYmWb9xUPfFrlUREnRp5sOcscNf6camxtW5VdfdNdCLMwPGhDHcPKW6cven+fRe97gBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfZfzjWi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfZfzjWi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25313ea37so102224066b.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834007; x=1742438807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sojw9SiGz0+X+51vZnmynJtCVIS+mCImu6MKlhc0lCI=;
        b=AfZfzjWiF4X1yu1aXwPRQJnYgK91GWKwH+e/1AV3xJr4GVSbEy9Z+WLVIPh4jPm+DU
         jd996LHkDEW+fbMtG/XILUszo+QAaYGvywZ5bEtMioqxWYntnYgauUc6AsOi2+tziKs2
         h7hBAAN75jvrh8bgTaJ32u9tTey45j69Md6JcdDjTP+haONAdepXZzpdejKEh98eMT4x
         BHpKniu/+KZP7Cgdl978Ov685vTFNyemJfffrtU0Kf4qhv4PWnWHM7uds8mGFoV8+HY+
         My9Rsds4b777pQaBAF1bLdJO7y5bRMYF8uyBdKWFnDSWATJAAa8bIy9EtuEostwP86Cc
         g/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834007; x=1742438807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sojw9SiGz0+X+51vZnmynJtCVIS+mCImu6MKlhc0lCI=;
        b=PfEyN/r2xXdDKHOKoih7fe95786TSkDLn3IX7NxbdsIsNQqovU6DGOS2QCOEmO2ihX
         tDROwrm8faxgQNOzVzAx/r+8LZfNlF+2zEtOSESJSiPXTotkorYsbkyvK2w44uRceHZ8
         enX39gGwdpPo/ym97Ldc0ml66SnBPyieISPjvJnJRn8wvIWykazoPZCJvyHxQWCJSlLM
         CYei0qomDp2FTmR0rayl82vkzBFEFYp171eMTFwOdXkZjiz9xcsqaCqj3vepc0PFJrbW
         vBZrdlWn9ReoJEUluUjYJkJil37fdaacorfWG+DywVQYVMjXQyqjxhtCKD4SbFw3oMPv
         JuUQ==
X-Gm-Message-State: AOJu0Yyr225CnlYz5Kklap9Mpw7yToiRVdod7bWoe2A7EHMHnVdx+m5E
	TttIb48WjKQRnCPCLA023mkioPN/2mtI1zOj3TKRfaXTKhrzwwvYsKrrdw==
X-Gm-Gg: ASbGnctNcLrp6wfJl5IQAANMGRIfDJYaqmXlcTy4Igz1FWWsHJ2Kh5wuo+RMkfFx52I
	wC5vRU3ElyZJesUqQCa+NLIUoBXFYRqCRZUXARLrEoT1sV8E+IWsIscWcvtiF0JhSAu0iX76/CI
	UZY5p9k7h0hyxtdtJQnTx0ExTj5QyaQnwKJF/gGUaflcScnhf9AFj4BuE2/ISLG2wCaNy27EAdW
	J+rYNZaghPW32eIU8UGQCjrITbdplSeiw+y4e2EehNwRBh2SQasJwkEbBaH0bPqUXKB9bBMrzJQ
	m1eaKqci6d1Nmk46TVipXnacKuT2UI+aUiOgwLCTyymJkUNtzZQ9bzch
X-Google-Smtp-Source: AGHT+IGAbvzGh+lELnMVHcEqxTrX7F4B0HRwXe7CEUKkPOqdX88n2cAzVDsDDil3qu/03ulHOn3cjA==
X-Received: by 2002:a17:907:86a7:b0:ac2:d55b:c35a with SMTP id a640c23a62f3a-ac2d55bcb69mr822903166b.47.1741834006450;
        Wed, 12 Mar 2025 19:46:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf22dsm20827866b.111.2025.03.12.19.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:45 -0700 (PDT)
Message-Id: <fefda4add11074288811752f922c309963c57eea.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:39 +0000
Subject: [PATCH v2 4/6] t3650: document bug when directory renames are turned
 off
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a bug in the way renames are cached that rears its head when
`merge.directoryRenames` is set to false; it results in the following
message:

    merge-ort.c:3002: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.
    Aborted

It is quite a curious bug: the same test case will succeed, without any
assertion, if instead run with `merge.directoryRenames=true`.

Further, the assertion does not manifest while replaying the first
commit, it manifests while replaying the _second_ commit of the commit
range. But it does _not_ manifest when the second commit is replayed
individually.

This would indicate that there is an incomplete rename cache left-over
from the first replayed commit which is being reused for the second
commit, and if directory rename detection is enabled, the missing paths
are somehow regenerated.

Incidentally, the same bug can by triggered by modifying t6429 to switch
from merge.directoryRenames=true to merge.directoryRenames=false.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[en: tweaked the commit message slightly, including adjusting the
 line number of the assertion to the latest version, and the much
 later discovery that a simple t6429 tweak would also display the
 issue.]
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3650-replay-basics.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 389670262e4..cade7930765 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -195,4 +195,26 @@ test_expect_success 'using replay on bare repo to rebase multiple divergent bran
 	done
 '
 
+test_expect_failure 'merge.directoryRenames=false' '
+	# create a test case that stress-tests the rename caching
+	git switch -c rename-onto &&
+
+	mkdir -p to-rename &&
+	test_commit to-rename/move &&
+
+	mkdir -p renamed-directory &&
+	git mv to-rename/move* renamed-directory/ &&
+	test_tick &&
+	git commit -m renamed-directory &&
+
+	git switch -c rename-from HEAD^ &&
+	test_commit to-rename/add-a-file &&
+	echo modified >to-rename/add-a-file.t &&
+	test_tick &&
+	git commit -m modified to-rename/add-a-file.t &&
+
+	git -c merge.directoryRenames=false replay \
+		--onto rename-onto rename-onto..rename-from
+'
+
 test_done
-- 
gitgitgadget

