Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49332DC337
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839099; cv=none; b=Fav65txQPB0pGeBKQ7L439P/JCLaUpbvhkf9Zzq5r+EpqwAsPff96JAcSL0nUyhVxaBROh++kuS/1SQjWDFGra6hamsUIjbm80Ri6DWtMFLJigZHO/rjp77H7oVBSXi8t4ZnrYW0cqud0/KKZ5XkUMPWPl5A+8WBDRzm81JmylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839099; c=relaxed/simple;
	bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHll1XnEMDJHB3G9c3GWR70ZB/4BaBz6nmIBtIMVPjDKmQT92DUaIhEVPCbiYk7PlkH9YxrrFpZjQ1Wc6EkTr1JpSJ2BvQNugBhzxL5Ry7SNjDLWs2luKmMd2zOildPBGGnGDPoLNPlgwLl4lLN7lct17lfjV+YYS8Y5cW2zxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgN7Of1G; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgN7Of1G"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1250494166b.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839096; x=1760443896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=NgN7Of1GLWKKCBVZC2yTn4engHxwJj/6GXVAZ3j0V/M6SKzz29zT7EFFU3hHfwFOVJ
         7qze/LJtoB+JCPoVDTRQsan8tB3gAQH7nwkTWaOIFYdVoSqrKfI+F8KXdmkav5GfbCEr
         3T6CIVvKBjbcnzO4zV/BuqfKkUtn9XH4eoNT8tKbxC/DrrzS00OCwi8VYTYduq7kzRjU
         gohrmUU4qDI2YnuyxjUAttkrPVPd1Pmru20141NVOvfnzhtBwvq+P/l+LuB0WPi7zn/U
         gAF5MCv+ie7mXzGOaUSXDt6GY2NiqBo9m4+uyRhdV6W6kooaEUyGSniDkK6iDJmI+vu2
         rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839096; x=1760443896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=tD454tF7wDAJFkOzS0z6BKKwdkgJo1MvDROon4n8PQJ1GNfdoIGQAqJGDLh/f2sE0l
         Rz6xObdzCP9TuFSP1F3YSUINg0K7X102r9qU4xjgW1CUW5SoDasJ2USfEV+OT3AmPMtk
         tvwNfAvpoH4NiMhMSj8Ttbhei2+kxDvdnz5m78aRsIo9bUB3JmRSstag+iXfKQOBIl62
         bbV8/+Q3mi+2L4OvWHBm+9m+PKSriSJ71wRWIhZkjrF/BGLKN0EZdMhjqrcidkfthwMH
         DbDoZ6cVNfqiLrAH5kq/KEIDJ12ZcNbEYHthLQrnecgKRouUPftMTFuTwdRvU2LLenhG
         dKrQ==
X-Gm-Message-State: AOJu0Yw4u+0kyd3osOfnupneuyY8JzzxHgY41xYhaHYpbMWZHPkr0Lhf
	qY46RsJFgUuy2h00LuCJlFj3qYrPOYjgMJTPNu9Bplkct8cf72ECg/Zk
X-Gm-Gg: ASbGncstIZ6GNzNGKtDisfs3De5VbHzAerQjGrJlU52QRVNzUIS7BxMRmp1N7p8YQ0C
	FjFlM5uwAAh3N9VsSnZa0u3GpXGMOvXWeo7Zm0MP5krzW02umCOTb/eOtSnmlTE8HZoYMCeNFM1
	tJU+sr9BaIrllXfomXvMSSu9EYHvQSuh8a9zzyEEyPigrQIcMOusNcjuw9pa+9ms+2cgoQUQiac
	bGkPpd+YWE7WcKUSo1vPvYhG3FNjkG7hj3JAOV8sYkqfd82LFHZ+a0iuJzm/VSTyMR0HR3XlTjP
	v8vwJaB1vvunnXndaTYgzcIxe+Ja+q/s97jvF3aChw9yVMAszKiBVIUdeJB//mYC5Wyshf6PlFQ
	d6RYgV+3CohfXPMufg9mopcpSzidrtXLTa5L5JCWMhuXaZapt
X-Google-Smtp-Source: AGHT+IEiJ4L1LNvXNvHH1OiRKF5qzBD0Ezy9Ga6A/cFWOVpfBjZrxVpRBSjwUQSwc+vwHfoyHa3X9A==
X-Received: by 2002:a17:907:868c:b0:b3d:d6be:4cbc with SMTP id a640c23a62f3a-b49c3449f39mr1941819066b.24.1759839095946;
        Tue, 07 Oct 2025 05:11:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:26 +0200
Subject: [PATCH v6 2/7] refs: move consistency check msg to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-2-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3TYdKYoVrdqFooDT86AND+kVWkGElmyv
 nvLkV6NT09I3IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/e2ML/0WhEt6Q9cMXRcV+f71U6UzBw66gp+XcBmBdCVCdxD6b4+/aybTeM3hfjxZceSOhSZ0
 DVYvSRw1eqWRzS9OV2v5f5v1V3pvJe0ZJcmaxr7OMFCOuaJzkAuyUtJRrw1JKRFW+mWOVD7k/M7
 ZQlspVcMtusfrVQHOYbsFVN0CRm5AneLo6pdB4+QdZZIenNczyG6wZSQomGO+BMBt3VrMMhtUKg
 bzF4ZzRPNaUt5/uuyASgnhkEuuomPlOYHRX8qDo51Gii3gu5D29z2GVLvyocqoMdxEeH/zEUaLL
 XN2jA22wECsq5GQESkr3jlbGRUObicbeTrFTTeSk22rMpF0ZLxMV5YJ+NNg17GmhMnx2VU6wlq5
 /t1v5vY5iCkGySbQfoegliDyUui8noCl/asWmKLyUx0UPC/IcfMrl9uBdFfGoyQBDHCAZV0vqgJ
 v54Zjg7KXkaYDXVPEhKMlclOlRV+nACN03ngE84VppVEmgA6QaeJkxxaM59HayxSMwdhdPkMyV6
 VU=
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

