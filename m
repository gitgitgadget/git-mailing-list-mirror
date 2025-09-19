Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A72307487
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270440; cv=none; b=M9+tPZRQTE9jZX8VBk/2+LBLDLUp5xWxRiuy6YzahpLYeVRIpCtNEuk+gE+d4gpyYw1TBM/Yd+t82a1S1pZ1sMNAzHiUzsteQSHMPaYYOJbMO+Lghl6ggu2DnH5mbV0kCdwlcIx4mlKoQiqeszmQNEgJuGbF3UZJnKJFIveFaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270440; c=relaxed/simple;
	bh=9vfIQPZzS78R0N70xVPUGUpgztpONvTVbUXAaTDFigk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNU2YVqckBjPcOHI8MtCr7DgTgbCDNbNImLxjU8sxGS4YX3V38Ra8pu76S0trQ6QoV4IjuvoRNWChvG4qMVwyCxXPtza9Q46Tg/BDe1q4y4pXbfsbrmISZ3XkJl3AMxFItWz+YwRkR2PcbiaJgSHoIyVYsmLnZboK6s1vgrtetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYb1WVio; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYb1WVio"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1373840a91.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270436; x=1758875236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaByfOwz7Tm410PgESFS3mI3VL6dVObAgvO37yeKDss=;
        b=kYb1WViozkZP0E95Ij5mCwAikMTKqGQ01ZOOGGkVyf2j02golaEohYK2OVvPbtLiZX
         /FH7/s1LKoulBluevgUlhvq/BVfclc7Ml3f9APFbg8xL4EP23MsqnV3+7ckcY6e5CiTv
         6lt4YTkddL3seRpuZ5nqiJyENW/RpuDjXaOjRULtH0lA+V/Uz2Y+aJfG6ZfSILYmiZjZ
         7HDttHIssc5Xj6lVMHLx12KKioaW+PcXdnZOVAWrtzOgUmkH4UghYzrdPWCtRRgXd8bg
         QhOJymSOcgFJKkWPhvXZxbYcu9iKXduQKEAmXF875VFhIoKsbylMuo9FluwgrwnnyhfJ
         JUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270436; x=1758875236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaByfOwz7Tm410PgESFS3mI3VL6dVObAgvO37yeKDss=;
        b=Xc+msS7it4ynz0RVSU6mlCzsojIs1i2AEzdJTx9kK+FcMKXbl3s1rnNJOlg6BJcAQy
         4d8IOh16Gdo43LLzZri4M9ak6whHShZoyWvlGD1E1xsx5pMLv8boAvujV88nutPvQiR0
         asuJ3HvwUiPkvGFC+HvL9Q1fNqxbEwlv+cM1eC6xi4mILWLIjn/RyzZjMQsHZdxrKyuX
         p+n0rRh79sechr5Jue7yPsIUDWBLxR7ehIidvbbpEOH9fqQB4R+987Rq7VgY5gORLHPs
         SPmjOT9fnGqbejU4mF5iTj918K7tqrB4c8MEMeoFm2jwXsT52Z7RK4pOrHhqiBPPrILn
         f7aw==
X-Gm-Message-State: AOJu0YyLPCyj198n0lwdZc6QIbXDDEpM/X8U5Lw6DUFRAWujAoXPij23
	mj32j8erYv1DpQfhe4jHgFTxgI8MCXbO9L2XdO+x2SyIAFHeCxokmiHuTcPqjw==
X-Gm-Gg: ASbGnctj7vB9JiJz5w/oLQu0z7iUmhTaKythQsGpw4vo6eKzbUKSf41hazyRaOJ1LKv
	UR6Dw4Oaar09CXmpva0jqjXxugsOejVkH7cGET2YDqW8Zw8jt7uwHHCK8Mdc+HMPHb4MUz7AtQN
	DS9GBlXqCxLnSpz4eQtiNchXXt/gwBhUzKZ6iu8gzNAatobhqGCsQPdM1zqz09V5tJzzGFr4eDK
	f0/DxmjpN9pPU+bqoVb+YCdkicPsL4d/02ZvNfwOh1Px51agyLteuYOsX2RnqsBTG6ccSRBR1R9
	GVrn8z5Xh5ioQ15TtY6JiukdrdGH5/qBdWzv/flmPPAr6dRFca90MPWbySDt5j3UPeWAwrjH2WZ
	RRG2PaHLKAwCWVceoEGs=
X-Google-Smtp-Source: AGHT+IE+O79bMbZLamqeB72IjoM9cRWRKNGXsSkSkKwlSKms3HiqnwYYBHBz2tPf8Hn9wRKPcCKTlQ==
X-Received: by 2002:a17:90b:3f90:b0:32b:6820:6509 with SMTP id 98e67ed59e1d1-33097fefdecmr3016786a91.9.1758270436563;
        Fri, 19 Sep 2025 01:27:16 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:16 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 9/9] t: add test for git refs optimize subcommand
Date: Fri, 19 Sep 2025 13:56:47 +0530
Message-Id: <20250919082647.535213-10-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1463-refs-optimize.sh`, for the new `git refs
optimize` command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$pack_refs` variable to "refs optimize" and then sourcing the
shared library (`t/pack-refs-tests.sh`).

This approach ensures that `git refs optimize` is tested against the
entire comprehensive test suite of `git pack-refs`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build            |  3 ++-
 t/t1463-refs-optimize.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100755 t/t1463-refs-optimize.sh

diff --git a/t/meson.build b/t/meson.build
index baeeba2ce6..92327aabdf 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -211,6 +211,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1463-refs-optimize.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
@@ -1219,4 +1220,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
new file mode 100755
index 0000000000..c11c905d79
--- /dev/null
+++ b/t/t1463-refs-optimize.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git refs optimize should not change the branch semantic
+
+This test runs git refs optimize and git show-ref and checks that the branch
+semantic is still the same.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+pack_refs='refs optimize'
+. "$TEST_DIRECTORY"/pack-refs-tests.sh
-- 
2.34.1

