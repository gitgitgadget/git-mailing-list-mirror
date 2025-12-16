Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521734DB5C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885591; cv=none; b=B6ALTSlU2iSGexFsSIOjFR3N6uQt0fmwMfXqqdpQx2htvSQzc2BZsh5nZAbdVDc+wOo970O7wzwjdlJXr6pgIowA1J9/GaKwGuePj496VXu4J+kBoRd5P95b9kdhu4iz9ys9nkPNTm9xx6jelyZjwlcKXTGwsROc2vutgNELlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885591; c=relaxed/simple;
	bh=rMV91nQ/tiBuBzSqZx+K8CebyVyDPsaXNDyDQr4XJCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AqliIS6Wgg8JbbjY7pWxgohPBuizoqRAz2wrZdtpQknIdRLAfttT6L0IjVfzpcX2JPA0nesopokEHUC1fmTX909Y8gIeLQkvHNHHbpaXXGVI6eaHYM2Br9A5WBxN+nlKv/IXk4WAYfXkmjNGHNK6r+BsNOzp8z/lYKI0+/+fa9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPBmbD+R; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPBmbD+R"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso2652744a12.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885589; x=1766490389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=PPBmbD+RZ77qzWuwhmR1+29EEqVa8xGdU8WELHuLSTCXuwMOXaoX1aAFJEE1ETgFke
         uq3NkF8OnUVb6B0r4As74VNjVGVy7z7EiXnyxBxFPqIk2+/RNXq92wQZWoW0JOv1+xb4
         RBMc3gXl1iXRUEpVVu6RCiO8nHl6svWsthh9hfXTZsyywvyG7PLUsi5MniZ/ftg89zu5
         405A6CWZtkDzhaLS28N9PnWfunSKjm38I7VKanqZz4sulLCRwK3JAVRkygGwwvENkeo8
         iEyPby9rG5JoMn2HDvNLHAMXVBe0n6ibyuqAIbNTDtz6QpiQy2pK0SfV+vuklZhsE41Z
         DC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885589; x=1766490389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=cQZq+NVsL2FDFHQVs1EMBEFTKLitc0L0PagRINZD96+mMLk4ST8ddTiukqyzymidLi
         Hn2vnvJ/N0VfkvIRVBYZuUyU4PuqVRkYowUnqPsqZrkq1b7dwkIQBiQTADWFE7KDDwGt
         T3h6R/UI1Rk0xY/U6aI4rvtQHtUa/1plbDt2oXIgleCyGu8qzvWc+uZ6Fi1zfKD9W9FT
         WGTDr7EAQKj+HpSFT7hN26Q31iqgTTKkvsXdYCTyTy0I0ZsiMLnJre4jpJCnwa4t8jXL
         EGsj2uJaIPvxYMf7JwZlxERbsd3cU+vBDSxEXrUWiWZR/tlR0yJ+bZnk5js7nKz+HIG2
         MOeA==
X-Gm-Message-State: AOJu0YyLmNp2oBm9mzQTGmmFftLVwO7bIfIr8afV76Fewi+pd/ve8+XV
	c6vIDsK4FM30WI5Hn8cNZeZMhRlSyirMMSBUCwr1y+5Y1kRiVjItwWIGb+mehw==
X-Gm-Gg: AY/fxX7LSNEo65WkPIlOZLL3YH1m/0tPt4UB/qNJbnKnDR26RVlUpxCmNSnwJZcjX1T
	S/tjlpQB3BTnlH3tcezK+pxGvjzHRwLWcILyDD6QqfZfMBOYdGAEyNhs41OkAJqoT6ez0pIJp40
	ZakvWfvhmqdF7LqQ9DayC5GMFjQz8gsAyNUFd4o/Bqk/uX3MaA+Axfk2pew+dEkIg3/GKTbnog3
	fSeu9X4nBVlOpvq/fuNWYGdBm2ue28RVCbjt2QIbdv6b9aAmvOGnQUkNYd9ukmpfbjy0VygKzHG
	dcJ8ZLkrZixJ5ZoRPriSxBmXjPKyf6E0zK4dNHwBIRdUja/wDZ8DjYphaKLK1RZJn2cGUf5vGPN
	xBO7q+pEG7pXJ3wmVoe6WvuZDCsme6WfIuftXyuC/Gcz8EZfiCrXdvDGkZZW25hX0VVbiUElTDD
	TzSB5P/WB1X9Py
X-Google-Smtp-Source: AGHT+IHQ6/60e6CT7AqZnvA3w7CoJW9yvXS/BkpPi7uu7vqWtTl5VzJhV10muOs3o3hGb56f3iX8/Q==
X-Received: by 2002:a05:7301:fc85:b0:2ae:51cb:7a98 with SMTP id 5a478bee46e88-2ae51cb815bmr501635eec.33.1765885588522;
        Tue, 16 Dec 2025 03:46:28 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f054603sm879980eec.27.2025.12.16.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:28 -0800 (PST)
Message-Id: <c2d3212f11ada7a0cae66812938b3d88a186a4ed.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:14 +0000
Subject: [PATCH v3 07/10] t1006: accommodate for symlink support in MSYS2
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSYS2 runtime (which inherits this trait from the Cygwin runtime,
and which is used by Git for Windows' Bash to emulate POSIX
functionality on Windows, the same Bash that is also used to run Git's
test suite on Windows) has a mode where it can create native symbolic
links on Windows.

Naturally, this is a bit of a strange feature, given that Cygwin goes
out of its way to support Unix-like paths even if no Win32 program
understands those, and the symbolic links have to use Win32 paths
instead (which Win32 programs understand very well).

As a consequence, the symbolic link targets get normalized before the
links are created.

This results in certain quirks that Git's test suite is ill equipped to
accommodate (because Git's test suite expects to be able to use
Unix-like paths even on Windows).

The test script t1006-cat-file.sh contains two prime examples, two test
cases that need to skip a couple assertions because they are simply
wrong in the context of Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1006-cat-file.sh | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1f61b666a7..0eee3bb878 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1048,18 +1048,28 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-
 	echo .. >>expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual &&
-	echo symlink 3 >expect &&
-	echo ../ >>expect &&
+	if test_have_prereq MINGW,SYMLINKS
+	then
+		test_write_lines "symlink 2" ..
+	else
+		test_write_lines "symlink 3" ../
+	fi >expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
-	echo HEAD: | git cat-file --batch-check >expect &&
-	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
-	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
+	if test_have_prereq !MINGW
+	then
+		# The `up-down` and `up-down-trailing` symlinks are normalized
+		# in MSYS in `winsymlinks` mode and are therefore in a
+		# different shape than Git expects them.
+		echo HEAD: | git cat-file --batch-check >expect &&
+		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual &&
+		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual
+	fi &&
 	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp found actual &&
 	echo symlink 7 >expect &&
-- 
gitgitgadget

