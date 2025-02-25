Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A718DB03
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500377; cv=none; b=lJwt71IFjc+AmOf8a4ES4BX66SL4K3bohl4H+GCuXbZPLKdsjcySsFZGj37AzFb/yQKK6Dkusg6dNg3M41xcReRLWHwO9QdconE6rTtUYGIjHYBhCpjcyufN8ZO3xDzelWlQ38skBAg7cz9MxxV9rTYeWupoatsY95EINQCw2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500377; c=relaxed/simple;
	bh=25zGZuWbhnsVoXOdirIyGHdAdNrCA3grxXZo4ItofHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QUUoRkL9CWCVno+VwB3+xlVAuJ3RVTVGyLfEGxEHvponP314Nq7TrXLEz1+XUYtHbG/U51IuzncgETv80uPcb1MlJChMdxElgBejKjd+F8Y5jSJrk7TNpj+0kfnA5u6JpU8DVxkdoeF/kfW+dtu4Nx6WKeZeoY4olexxmON+Dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9MqfWcW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9MqfWcW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso98672355ad.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740500375; x=1741105175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVr/027L4S/DUbjAMVVWuZmIS0EGuvnOuXKtGPuCE9E=;
        b=M9MqfWcWgBXi57L3tjspmJoBIf/LqQYOX4iz0m6haqBSChZVEdxjg9LthdF7P1JObq
         fo8LjqvQBh5Cf+lrhuX5fJPWPF4wRVRG+2AUyxIljky7VMhnCxqiuih+34aGwrffg4oM
         NUyIiAz+8uxTN/KLWrGYZbYeBKNbux0r1WUePT5Bo5tItzq1fJQ5PTHTTRxtMzL3F+C2
         3mkA8OHGuzVXUMH3++CTASgvj9JPk1FToofbqD0kzDPmwE5Gcd9oa+7CWdGK3rCw074X
         LzUqFMlbyqwBLBEdX8MGOPIL0JaNEax5jPv9Z33Shh0auSSZVsztH9PfTB8xaZrvFcOx
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500375; x=1741105175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVr/027L4S/DUbjAMVVWuZmIS0EGuvnOuXKtGPuCE9E=;
        b=ZiOEPaj9/tsQ3mjMzw1ncErLMS7xuN5dXGIJGS2tQdDhTi9Kk7tT5K3AOspjH46Tar
         MzBwANo9/WWMONpqz2Myk5JKZS8Uuw1b60z0Yw0oPvXDg13mv3Hxc1rLra7gSAuLjwQL
         N0P0A9tfp0T6148NuzSMv/09lxOEqFFsmbhlLsH/9bsrTNwfgJcU9vGQUrOiWA7hV1v5
         zjgFRsURh5NChYVeVTylWz223jLcfM3M26xHvdDkuLQ2tzgSIL5LO+bljun7nOS/CMDs
         GZ6iqo/bYPbtynDGbZYCZ39OIqbUUhf0+IP4h3FgQwd4PhFz2FlmprlOb/x6C1Y3uhxJ
         q7ww==
X-Gm-Message-State: AOJu0YzLAOhjFEzLKYVgikA22XHgqrwwbUqimNlDM0axinRnUTwwvgSc
	IcWPkPdUFLLw5KOtTKKWnc1I52I8BOMQ3BD3YorDSth8vwA8bAtE8dTkcQ==
X-Gm-Gg: ASbGncsF4ScQigVn/odkToYW+0LKYaPyv3pSJ146axo/trJ2fG8JpHLI2bndK/xkaTV
	9XpCHn1feJGDhLg7Y5P40QJcLY9x87mA0EigrLEUoECKPrasEg71GIbU7RIbIBQK9qGrQFE+QeN
	yuxWNyo3EjOlIFtH7lfTOwTOK+x2WFRna832/sFPiqjzk61f7+508jICN5BR+DkJreUEy4l0idu
	RPmtfF/l59TYjIPBPVupNbHDwhhV2Cau65fHnOMMCjlCdTuNcTSTiXzMfC+GeM68qATMoFvSC+4
	xrIrx5qcQnQHSEwGmvphMuumhIdz2jHIaQlE92h2HD1f3gMftFT6mOA21MIHwL1fqg==
X-Google-Smtp-Source: AGHT+IFwPBBN02hYDbQXuek+7pUA5z6Fl8wDrEnR7bJwZP48j9Wg4ic3x6XiSkvxxv2ZXkh12/eMaQ==
X-Received: by 2002:a17:902:cec4:b0:21f:53a5:19e0 with SMTP id d9443c01a7336-2218c3f435bmr380861875ad.12.1740500374716;
        Tue, 25 Feb 2025 08:19:34 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8834:3146:eeee:59fe:57ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fbeasm16121605ad.86.2025.02.25.08.19.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 08:19:34 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][PATCH v3] merge-strategies.adoc: detail submodule merge
Date: Tue, 25 Feb 2025 13:18:00 -0300
Message-Id: <20250225161800.8268-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submodule merges are, in general, similar to other merges based on oid
three-way-merge. When a conflict happens, however, Git has two special
cases (introduced in 68d03e4a6e44) on handling the conflict before
yielding it to the user. From the merge-ort and merge-recursive sources:

- "Case #1: a is contained in b or vice versa": both strategies try to
perform a fast-forward in the submodules if the commit referred by the
conflicted submodule is descendant of another;

- "Case #2: There are one or more merges that contain a and b in the
submodule.  If there is only one, then present it as a suggestion to the
user, but leave it marked unmerged so the user needs to confirm the
resolution."

Add a small paragraph on merge-strategies.adoc describing this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

This v3 keeps the same content as the previous v2. However, it uses the
proper way to declare paragraphs inside explanations and replaces the
duplicated paragraph in `recursive` strategy by a small paragraph
telling that it behaves the same way as `ort` when merging submodules.

 Documentation/merge-strategies.adoc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 5fc54ec060..9c30f1c900 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -22,6 +22,13 @@ ort::
 	was written as a replacement for the previous default
 	algorithm, `recursive`.
 +
+In the case where the path is a submodule, if the submodule commit used on
+one side of the merge is a descendant of the submodule commit used on the
+other side of the merge, Git attempts to fast-forward to the
+descendant. Otherwise, Git will treat this case as a conflict, suggesting
+as a resolution a submodule commit that is descendant of the conflicting
+ones, if one exists.
++
 The 'ort' strategy can take the following options:
 
 ours;;
@@ -95,6 +102,10 @@ recursive::
 	renames.  It does not make use of detected copies.  This was
 	the default strategy for resolving two heads from Git v0.99.9k
 	until v2.33.0.
+
++
+For a path that is a submodule, the same caution as 'ort' applies to this
+strategy.
 +
 The 'recursive' strategy takes the same options as 'ort'.  However,
 there are three additional options that 'ort' ignores (not documented
-- 
2.39.5 (Apple Git-154)

