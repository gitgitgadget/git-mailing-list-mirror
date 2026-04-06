Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E7372681
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482054; cv=none; b=iGpsy3E7upKDUIC/J135iNc+Ds6eGlf/oSnvvU3OatMCWEn9hrNM5Kqe38JxeX3OT+ekF4LIr7blD7vooQAbA0i31tOnaAKOwp59XNFfbjKEf/P1FD2w+dSOIqlMKguwgi1y61MdbLomPQxQXbvqpttd9gJo9nGbWlbUC1rIq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482054; c=relaxed/simple;
	bh=FwsR5himag1daJ+LPzE57h2OeMW0JSxXdGn+6b8faYg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q9NZ0h1KYrVywbN3fTQ3Md/TVuTpqoHWoksbyNiG1x5assVcyF4zIfZ5wpzNbJiSPAXtedkOy9p+yDHhZrVdTZS7Gvhwa24DnE/z5YZRhBZ5m//IgPosQpAC33e+ClXnS8wFLk3tjK8W/l/xLOqsat10U01R0iVWSb3zgFyMnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qs00l4Fi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs00l4Fi"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d75bfb259so15411631cf.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482052; x=1776086852; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G6Y6FDXRhH+RdEiV4s/aR5af+S0hLsJF1TYJJBUMD8=;
        b=qs00l4Fi3xi1f+3xiUn7beD5l1/JMAs+l3Qxa767IyysXLsD1W19eolnSw3nSsrSrO
         FpJxFZffgw0uaC+WR6wtk2gQpa0XYsfLwKH1sSryWzQaauN2ef/aykOmT7Olpy8uSN7s
         m3/OGw09pFfk0lmZXHKfP3Sw6nB8yxh4bupgxv0bDFsEJ4diJmpVGlXSFnEiXTux9KSY
         3xV4eSQpzoLYGMSOy8wVBkt88ynD8gpN0DahYvm7xtfx8xS4lcp0gCiadzITkk0mR0hu
         ZYHWe42rg57+fTb+urmI8NTAWBVpasdA1H2k325AaG0g8F+UaEqRzj8svkWJaYJ3cQPs
         WQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482052; x=1776086852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2G6Y6FDXRhH+RdEiV4s/aR5af+S0hLsJF1TYJJBUMD8=;
        b=el44aAOAvlolAOh+qySSSBBmL/bFgAs9fYarWuYPmoBscbs6quvOuXytOPPeuWnmwL
         BiM/zj1eKNAgXNnUwiYLV6gd1DreDgmP88FHYqvvgTUweO7LF+/iH+I84IhCRmgxjB0j
         aqlqes5+wVpklZuO5PgOBs5QN2DlkV3F3TZFL/rV/Llc5rrQNTHlQICpDNMmYWNilyV5
         6Cri9ZEJ5Ykf/ufTpsm7OIR+hFzlcUUr72xS8xzXIBPJtqi4n2yUSvKaj6wUr46IwebC
         qu5hojWgHV4wfHGF4X00SFAXoUQIPQNBB+OEPu7XkHNZH1hdZ2bq8u7v+LkK/bZ6fxVi
         SL3g==
X-Gm-Message-State: AOJu0Yxv0boPd31Ntqep2LHAPwh7q0uhjpg6Kwy441VmZ49YPjC9TdVa
	qdmJEQMoi1iDnyYvKjygLAnPCE1/fuT+bh6JpDLpxjgwYabiKJzlrkU3AHfXeoSL
X-Gm-Gg: AeBDietfeZUTRYDDzRU4FxFdKGgSQsPmNaY82EtY+3MToWj96rbdEnoSvV2EWAiyZV/
	dx1GXUL+DUR6d8yk2QojK66f6y6E4ylbex+sRq0j7G01FqOdpHmnPISTDibTtNZ5rb9kOb7Cw7y
	sqS5eD2k0GUZ1gpaDTQMPUyUYAZVkWhvaLwjjkhJ8iFwcVRbfuaQNp7SUDerWC8uv3ThEsa+vWW
	KhkLZYfwVLyU2D6bN9kO758bOg5pWZe4DOugTivzqJxym6Oike5mURHzEvz+nsQ5jvUtgGFxFj8
	U39abuhnUax34pEX8O4IgRV5XaEJeMDNDNFOHaE6oPA/LfHVOnUqMntEjcsQnGJxc/jTJmr/G5f
	SeKEGCxEF98n41xtSNz8zCo8zchiHAxDVYelUWZ2xqK01+EI3eUacWUwn8b7iiXnc/40UnWvKHr
	TkNTK4NV4ax0BCMk7FfthpEIOecrmdcztz6BzEEQ==
X-Received: by 2002:a05:622a:5c89:b0:50b:1e5d:992b with SMTP id d75a77b69052e-50d62b53accmr191537451cf.54.1775482051389;
        Mon, 06 Apr 2026 06:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4aed181asm127419191cf.0.2026.04.06.06.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:27:30 -0700 (PDT)
Message-Id: <176d1606c824f58443d085c6f5a02ab17a16ca1c.1775482048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
References: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 13:27:26 +0000
Subject: [PATCH 1/3] t6600: test --maximal-only and --independent
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
    j6t@kdbg.org,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a test that verifies the 'git rev-list --maximal-only' option
produces the same set of commits as 'git merge-base --independent'. This
equivalence was noted when the feature was first created, but we are
about to update the implementation to use a common algorithm in this
case where the user intention is identical.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t6600-test-reach.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 2613075894..dc0421ed2f 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -837,4 +837,49 @@ test_expect_success 'rev-list --maximal-only (range)' '
 		--first-parent --exclude-first-parent-only
 '
 
+test_expect_success 'rev-list --maximal-only matches merge-base --independent' '
+	# Mix of independent and dependent
+	git merge-base --independent \
+		refs/heads/commit-5-2 \
+		refs/heads/commit-3-2 \
+		refs/heads/commit-2-5 >expect &&
+	sort expect >expect.sorted &&
+	git rev-list --maximal-only \
+		refs/heads/commit-5-2 \
+		refs/heads/commit-3-2 \
+		refs/heads/commit-2-5 >actual &&
+	sort actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted &&
+
+	# All independent commits.
+	git merge-base --independent \
+		refs/heads/commit-5-2 \
+		refs/heads/commit-4-3 \
+		refs/heads/commit-3-4 \
+		refs/heads/commit-2-5 >expect &&
+	sort expect >expect.sorted &&
+	git rev-list --maximal-only \
+		refs/heads/commit-5-2 \
+		refs/heads/commit-4-3 \
+		refs/heads/commit-3-4 \
+		refs/heads/commit-2-5 >actual &&
+	sort actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted &&
+
+	# Only one independent.
+	git merge-base --independent \
+		refs/heads/commit-1-1 \
+		refs/heads/commit-4-2 \
+		refs/heads/commit-4-4 \
+		refs/heads/commit-8-4 >expect &&
+	sort expect >expect.sorted &&
+	git rev-list --maximal-only \
+		refs/heads/commit-1-1 \
+		refs/heads/commit-4-2 \
+		refs/heads/commit-4-4 \
+		refs/heads/commit-8-4 >actual &&
+	sort actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
 test_done
-- 
gitgitgadget

