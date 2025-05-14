Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E017996
	for <git@vger.kernel.org>; Wed, 14 May 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213452; cv=none; b=A0w145wMZK5W6vdw+bLffOReMdZqhrWyGEWLGL7ZJku80pXxElU/9BEMV5qOq8+SXpoBn/ODYLwZ1FtNOybRrUMOXiwoNEBP4I9GkD9VF+hNOHUyf9jdUjpveMnP3oFs/CBf2x4tnaRwOvsqwHZnk1DC/6SquSVK+xJwhc2epno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213452; c=relaxed/simple;
	bh=CpFZ5/B6ZgkBtClhUkUbeuI5GK1rxBmib+I0lncfsj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwhhToIYAvSi1jWTmuVvci/K9Y1YBKBoVRfOcpa15RnUZ98qblX4Sh5mYCOKn1i8fmGpi84Bl9+kaZ63uetLz89MSl1C2lZwYXDmCgYHOoz/TgCF1fmZtxaBcgTl1rBnNZlWwI1oro0AN2GKJixRKmUPJW1gEeHQDv814cGiuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/9bOUvi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/9bOUvi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso69598865e9.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747213449; x=1747818249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djJa35a+2NL9z9mmWgDpsMwJwpL6EXl1uRIhiYUaXhA=;
        b=O/9bOUviWpxv8FxpaSOVI+3hvOYmmzP17hQT+ZOu7b381vDw8Ly4HYYbH/NeL0hgu6
         EpD+5WTbbu2D782OsfYVAOfXp/CKTcOiF3lmdv7e0NPrBiHOVLUr4jwwTnEAED2whRc9
         2rnOIoGGWr2NKPV/1oE/1fm9KDK6X5Kfa2CpJaiDENUzsgXJp9BkIi1LNBEvwOkLIepk
         yLsZDL7IoAZYa2rC8TYL06b1jDlVsK32LwAoAJfg34bwVbBo0rHIimRiru+h7Y7poiI6
         MDw+pHvoS9dg2KBDepLK1KLy3t9E1D51VEfpwAoIizBdo2o5Tf178myUvwPaTaxvVkLt
         +P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213449; x=1747818249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djJa35a+2NL9z9mmWgDpsMwJwpL6EXl1uRIhiYUaXhA=;
        b=PDEP6/X2vnlI1Egc43RH34/5/VQAwzdvei6GcRoV9xDmiUI/g2RVb8kspI8vHTLT1t
         3jMIw9uaczTyQr8a13INphzXm8XLvt4aEhd81ZIspVPH7COySRJkYeHt+RAwtqQctCu0
         9Mhlo8nr7cf6faZGMYI8lDmsEkjc7SjC8Gz29Ihr6byq/Q+2YMVFK1nmGi2iEnKKK5i4
         +hFVj6m98lBaWDMkwODGdfvcIPiXeySD3OcHsWclzpJ8aX/7m1DMtj1grANhzCHVL1iw
         zTNDkN1f8K3UGWGw4weATfjIBPaex3eFSV/mFb/3ePp3hRQZZ3SQibnnjtwPJl4/wGOY
         nYXw==
X-Gm-Message-State: AOJu0Yz4hi/fJAN0DoaHX9EH6HsX9uSPBNkKiC5vDBvy0rCX3hgcPVgf
	fRFCUE4qThHoGUBpth2WQdAx9sgnPZUT1TTeNQzOQsIKrjmo84yV7PREHYvL
X-Gm-Gg: ASbGncuBZL+3JNV+oh5gtvl/55QTKXEGZLW4b3pWNPJXgxW+8wkk4cJskxozypz+t8I
	9++ptr8E6/I4FAI5kIgOB+CoHXyd8YBmAQjXsm6tKT1jRrzBL6qg75FR6vRTM2mPXw7ZSbF15Lp
	3EC8jLjbPLMvo1uQDALRbcUNWwCioaT+wTfXguxR14eNoTsW6w/cNEtkAr8Erwra4xNBXJyETEM
	t4CO9149TeKFKesSf1E/1bvBZjsVkQL2DzMGWfDGpKd3veFd/Xb+DRyecCzwPOYKpmHmgdkeNPP
	ANZjOSFaC5B445UhyEzZnpPdlL92fp1LLdGxMxXT8Ng6WQ+St8RdPS1jIDNhocGf8oS9
X-Google-Smtp-Source: AGHT+IEO1qLmYFZxThXMqNZM/IvhLclX9kIaDfrbjr0IsqmGnVvVfonFKSdFN388p1shyJ5ZTWz5kg==
X-Received: by 2002:a05:6000:22c5:b0:3a2:21c:208c with SMTP id ffacd0b85a97d-3a3496b8fefmr1961783f8f.22.1747213438033;
        Wed, 14 May 2025 02:03:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:768c:74a5:aa9f:b39e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm19084461f8f.91.2025.05.14.02.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:03:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 May 2025 11:03:48 +0200
Subject: [PATCH 2/3] send-pack: fix memory leak around duplicate refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-2-7c65f46493d4@gmail.com>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=CpFZ5/B6ZgkBtClhUkUbeuI5GK1rxBmib+I0lncfsj0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgkXHt3/i+iBtc8c6UjDu0hdhZV52y2IGTR1
 v7a58BMnFWjNIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJFx7AAoJED7VnySO
 Rox/aH0L/0LgjQ1fztYizmB3g0MBPvrVSKMP1/a0ZEvpBBtJPujR9sbHDB3DCDfKvOfwhAcdpvB
 MvBrOAaYJI5HemCceoXcYniuhjK3ccNcTDeL51+bdZ421K6BxObDhfI4WiaZzTTei6F+Yu1etUi
 fbHxa23/mMvuPZPFdLxvh5B+oE1gM58dcwr5XFNjURzKH+WUMCKfzu0cyhdHkzV/xYMhC739OII
 AK+/o44GDRapFM2dr/ZuXaXi649cMMhQw/hDkaMeuAB5OeaVikLrgjmMLd5Eck+h54nQbEF1+JR
 aL+FCiiSXgfstMlwFp2TvUTYXrJ9KTtrg11kUHYwJhSfTG8tH9d/JjoHE6anELF+MfisN4kUB+U
 ocu62UZLKIA7tmumjNFdG4W2QWylE/d8zOpcbqr75simyPmfuYm/C1s9Ge9tS/Eq9fe4S8pAPyM
 rc4WRde+jVVTpP9qJlnZCzxnO8yujVPc9yON6qFAaNcHj7dnDGw287eHrgT7o6WBPMTzdknih66
 Ms=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-send-pack(1)' allows users to push objects to a remote
repository and explicitly list the references to be pushed. The status
of each reference pushed is captured into a list mapped by refname.

If a reference fails to be updated, its error message is captured in the
`ref->remote_status` field. While the command allows duplicate ref
inputs, the list of doesn't accommodate this behavior as a particular
refname is linked to a single `struct ref*` element. So if the user
inputs a reference twice like:

  git send-pack remote.git A:foo B:foo

where the user is trying to update the same reference 'foo' twice and
the reference fails to be updated, we first fill `ref->remote_status`
with error message for the input 'A:foo' then we override the same field
with the error message for 'B:foo'. This override happens without first
free'ing the previous value. Fix this leak.

The current tests already incorporate the above example, but in the test
'A:foo' succeeds while 'B:foo' fails, meaning that the memory leak isn't
triggered. Add a new test with multiple duplicates.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 send-pack.c                | 7 +++++++
 t/t5408-send-pack-stdin.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 5005689cb5..4cd41a64ce 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -260,6 +260,13 @@ static int receive_status(struct repository *r,
 				refname);
 			continue;
 		}
+
+		/*
+		 * Clients sending duplicate refs can cause the same value
+		 * to be overridden, causing a memory leak.
+		 */
+		free(hint->remote_status);
+
 		if (!strcmp(head, "ng")) {
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			if (p)
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 526a675045..45fb20179b 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -73,6 +73,12 @@ test_expect_success 'cmdline refs written in order' '
 	verify_push A foo
 '
 
+test_expect_success 'cmdline refs with multiple duplicates' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git A:foo B:foo C:foo &&
+	verify_push A foo
+'
+
 test_expect_success '--stdin refs come after cmdline' '
 	clear_remote &&
 	echo A:foo >input &&

-- 
2.49.0

