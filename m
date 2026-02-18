Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F12FD66D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406127; cv=none; b=c2oNbhlDbfXsyTboPID+3V0xPPe987ShhqSi7dA7aLpvChWGC2oIW/ZxmYcRb+oaPh59rwoB7EWsHjoBukrfw/f17cfC+LdMsATlGoNTbWp20c0aCHS/xJ1lbMCJh5fbT6wkZZCzbcCRoR2iDURhipJA9gXBQ+jIwLalPaLon/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406127; c=relaxed/simple;
	bh=iImQ8yMurf6pqXcwYM78ydDK6Pur9LioPt+/pMxiWw8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uun0j3xcedtwl01LczQt/Gjbr/Z9PhRTbrr7+SWB7jfJnnnz5YBmbPwQqcGnV+VPNtYNtFjSMzYi7oaDaMK2pIUvvsTXhtNmni7tEYd0LJmp8vMxB6vQxrCDjIFIRnrd0kB74zSFoIkQLGXQaEGLgzAgORrFbQQ+aNnnPDls2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA6YgeEd; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA6YgeEd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5105486eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406123; x=1772010923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QnQv/PbTFruBRba6m5v42IQaYErCHDxweqBSgEJELU=;
        b=EA6YgeEd/wmm1kQActRmhUrgzD+v6XvyJ1Q4gyypxPrtjNHQd5lED3ZyrEYOisv0/E
         EP3Flsru3CQn4GWzFZGemitluBrC+h+/NxV/5DagnM/vEeP1owqAS000C2zbGppI4iut
         6Rr+gJKxO9Kjbv+se5BTjg2y9+xaZwtrr5sgoiWQpJN/BoVyOQL4ty3okQQH2GHoiPxw
         LdnvH+p7/knxVmDN2pRaRpfnL27UbWGx/OsEegBiI687DeXm9jmEhaO0XTrn4rCd4x82
         VsGG2ZRYXb3iQUa6/GP66Fs4CQOGZFgs4TDhMXey5O7QBnLEFDjZvce4Izc2EiaxspC/
         rCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406123; x=1772010923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QnQv/PbTFruBRba6m5v42IQaYErCHDxweqBSgEJELU=;
        b=HUdkeWam4rSHioU3dY/V/sXT/wiHFx0N/MLeQlzWRmCWO6yaJtG24Ma8c/LGrEokN7
         vb/da0w94O71KP6l7qoFXvTpXjjGoEWPJaWs22tWnGP3bety86o2IK2WT/KNHw3+Hy/s
         FU6dYezHcMa0gMzqqbNzhCKquJRfqlzT/TuZsO5GNFIRrgHBPw9HtJ+iuR31W26i08DG
         jEN3M4uV3As+jCS73Dgwk8vJUaC5Ol2r7sVOjdgkjLv7BFtir1kZv6To7SAUHK/obIBX
         jeXR6vZq9sx0UriuHxPISVXfV3as0uyVyNJJZgTMSe2eEo/Zlq1+6l/Ybj4NzQLDbaPE
         UO9w==
X-Gm-Message-State: AOJu0YzWlab0KZMVsYG7o4jWrut6eJbBn3UdcQujWCZ6F3i2wGqOIEL8
	SgRQw46UApUUT2Jxe875uz69tjySPsVmgqp/02dMC+ISZmHO8AUhjjL+Lwf1aQ==
X-Gm-Gg: AZuq6aJNBoPIZAbFkEQ6fNO99sjIXTm+XsjZ+EjGYDDlPsGxCaCCGs99S6KgtE4OOnQ
	cx3ffdXzOOHAg7OlGRyQeb9M1jIhoehizl0ukhRWOJTIYnaCAXjkepO4hp2fCJOutRBrl6tmkxn
	DnbQuLwDvgVTdrBlV2pFEP5ll584Np9FLdLpSER7U8dlvMWc+jBj8Yqc9n1HpW/JSZKLx/EIEz4
	r18eJsoGrQNDYQjORp2l64MBsdi+wp26yUEqV9FGy+nXPiqIWt2ifehZvZwfVDY9FUqnQosdaUR
	a7ma1PfZEQ3F7DH2XIT92dzFKl+qcttVBIjrB+oloIHxBgY0zQLkjGD57K9AEOITpYdGe308PXW
	hU5AbfduuWe9nwr4ejKDyTFcZvgoTrofUzwToHYN+bCGlku0BQuERQWdqmATx3tnkbJDAU7uTDD
	oaLViaAqvj19jfCLoCtDeWo/b6Pg82kuFep1gN
X-Received: by 2002:a05:7301:6782:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2bac933ba72mr6561383eec.7.1771406122570;
        Wed, 18 Feb 2026 01:15:22 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb65780dsm17336235eec.21.2026.02.18.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:22 -0800 (PST)
Message-Id: <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:14 +0000
Subject: [PATCH 4/5] merge-ort: prevent the_repository from coming back
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

There are two things preventing us from removing our usage of
USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
removed all other uses of the_repository in merge-ort before (multiple
times), but without removing that definition, they keep coming back.

Define the_repository to make it a compilation error so that they don't
come back any more, with a special carve-out for
prefetch_for_content_merges().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 40a11dca73..ae19118550 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -53,6 +53,8 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+#define the_repository DO_NOT_USE_THE_REPOSITORY
+
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
@@ -4433,6 +4435,8 @@ static int process_entry(struct merge_options *opt,
 	return 0;
 }
 
+#undef the_repository
+
 static void prefetch_for_content_merges(struct merge_options *opt,
 					struct string_list *plist)
 {
@@ -4481,6 +4485,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	oid_array_clear(&to_fetch);
 }
 
+#define the_repository DO_NOT_USE_the_repository
+
 static int process_entries(struct merge_options *opt,
 			   struct object_id *result_oid)
 {
-- 
gitgitgadget

