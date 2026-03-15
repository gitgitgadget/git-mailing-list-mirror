Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCB81724
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584968; cv=none; b=F9zDt73LSB+ogDb1xRvUNpJjoJMaeJACbXHCuz2YoquHDfJTLqv7bsX5R8f/4o9WXSQgQN/R6DIDCowNkb0QMHAgrWDGAI4Ab6yAiWEyiV19kdFVDev3UeCgqxmuZRgc/SWtLqfBoW4MNIXHtlpSR85y1x0ZwabeIHTDia9WJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584968; c=relaxed/simple;
	bh=kAO+CrUTDVAH5ZV4XOyc049WVbHfCmAIP920/KNyHxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ajlGPcHJrsSRXzAYBbo04Ffbgjlywc88iwL1u6SpwR11JgBWy4V/Y/SMWdZeHrHcV/DoxELX3gc4qnI8/hMxY2veTbvZ0a9/jRK6y0z4Fw7SWrrECA0mOihO2aEQrwVmfz50TSIFNNVqqzrxNixiR+0z1U0WSDzmsZ+9HTXvpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU4MyomI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU4MyomI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82976220e97so2208482b3a.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773584966; x=1774189766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAO+CrUTDVAH5ZV4XOyc049WVbHfCmAIP920/KNyHxE=;
        b=UU4MyomIrwJ/49udpSDyxjOX9R4QR234ByNTX5qQECWNDuxQpSR5nJ65ug++ovi/Tb
         Ct3ziuwNXC7ZASRUsARUwsN0uyKH/SZq0b6Wo3OK7NoAowmgEmnZHYItVzuUqqVvtu3n
         chRpqZf7UT25UY0KOFdtiQj8iclW/HoPmsEzks0EmihTcHtZcOQQT1XUNzW2os49/p3y
         GAJfaLIvaJN0aOC5Pk/qLxW8wkNH19xKyAh99mpKfzgc7cq2XBmby9Y8FTc8CRldhhO4
         6uD2+FRXZqArbFloxPtAI50DYQIqqiC05hsOAcmbJVh/BOaNWmDevwQsKqmTEY6YWHSJ
         GaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584966; x=1774189766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAO+CrUTDVAH5ZV4XOyc049WVbHfCmAIP920/KNyHxE=;
        b=n8v5GS6tXPmiaf5Z5vtik65OOw3P9tUxkUsJtFpsR3/Lugac+oiwSpByXKagC7HKLX
         WwpxJnVoXQekQ1WFrUvA1+mosCRI7BBFXDiH/cAitlJz/kgvl/VJlAs6dRcxrW6fGcNs
         jD4FMC3kzWlQL7BkbDb+W4ONHDIsQUhFSDdeWZB8x9Tj7C58EczmN+ppbOGdFSC+rakr
         SaDeDbnhKK24unk3UMPPJMmGsL5AfKe4kYagRTNeb7UwpRJbKsxA350tJdjkPCce6bix
         RY3d1aoWNUVxrhYfcQIDyxOEpEnXf3ZjbhFjYCc7ZhlX0IZQu8T1O0XxguEpt7cafBJt
         PC9g==
X-Gm-Message-State: AOJu0YyzstDCgHK3I1DwpS86vxDVYJLBfiNzbgRuK7NxyifH6eT/RR+M
	Ykg2zXZe5TAt5wrF9GByWgKlMiVVnlFPRRQBg6nlT8KysGN/tYU8e0z6kZQuwk2w
X-Gm-Gg: ATEYQzzXkmOHDBpBVzirLDcgjJyDMNs2D7cXcaz3JmaCAa9ZYcqHierBe7CCRgwOJ/a
	QAC5+J6+RLAW1pleXHK7ocrj5IVBFtBYbNnaG2xQRM1J4rq+SisIyzMWHEj6VZupuYUgPbxn1eo
	u7DylCooe7OZ0GSOsbxw/Yi3W45ng5v4QvzV+LPTGwQGBpleT5stMlspbjxbBxkYUqSEUlFQE7M
	intIy1uuK6g4hAvlxcggnPbtkrXjefUkcOGkwgmLyNz4IuDZ0aH5G50woL1Wy6qZ5q/xbCHVi69
	VB0dQ/RM7fsOZk7xdz7UUciHgS6W7kbO5Bcd02xOt2vO8hVDfLvQZCx4QpGrqIHR0WnNEg2F/6H
	Oh7bO6AuvbkQC26CMfsg27bdbqMNLlnHbsV+WsnzOJ9U70gLKpkay7eco8SdisLy7E6KsN/SQGi
	dcmgScKishW2kjSScmmvpOfS7b
X-Received: by 2002:a17:903:41cf:b0:2ad:d0ff:2ed4 with SMTP id d9443c01a7336-2aeca9415e7mr107352825ad.6.1773584966402;
        Sun, 15 Mar 2026 07:29:26 -0700 (PDT)
Received: from Dummy.. ([2409:40f4:ac:5e0a:3e63:c59c:7030:5250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81cde8sm81084585ad.70.2026.03.15.07.29.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:29:26 -0700 (PDT)
From: siddharthantv <siddharth13102@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC] Introduction - Siddharthan T V
Date: Sun, 15 Mar 2026 19:59:10 +0530
Message-ID: <20260315142910.17684-1-siddharth13102@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am Siddharthan T V and I am a CS student applying for GSoC 2026.

While I am looking at the test script t/t4014-format-patch.sh for
my microproject, I found the usage of test -f for the $filename,
sub/$basename and $basename in three tests, but the same file
already uses test_path_is_file for pager_used.

When the test failed with test_path_is_file, it showed the exact
filename it was looking for. With test -f a failure would show
nothing useful.

Is this a good microproject? I also have a patch ready.

Thanks,
Siddharthan T V
