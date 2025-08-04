Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F85161302
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291816; cv=none; b=I1BLx6q1tMMKOj6xnLy4oDsxVKPv9VcLPYUGdQkkjBGq8rSLVAQLAjD/lzGHpoVBaqiuVnYhn94ocTXyzMtqGt+kB+n1eWodoT4pagJNWQRQupw74/WKg0bVMrPgdrdtZTux8Jp82z99VMHmsFpNKysjjXkWRgDc6pvxSxv5J0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291816; c=relaxed/simple;
	bh=buXxr7330ko6rIVs6xdY5in0f6weXlEoaNZI0NC+pGg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SDEMZOoQ+pk68iwrYq63F0qQSkravtfx0280h3ovFUXhrfhUSZfgkHXRmuvehWjCvf31lTELTzpu0+URqGO/pwjepznCxpQ6UfSg+23jjuBvQ2zkfsBRZOHM6k/3BPPTtGfPnrFtP3QPs1/lnrJi/270wCkdJnajJGMttKLN8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOUwK5Lj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOUwK5Lj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so28013315e9.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291813; x=1754896613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dAufSdaXTIAXtc5I2CF6HRoBmqx69Q4G7Onqs+1JwrA=;
        b=NOUwK5LjhWPo3eBT/QqkU94lvBKXvi27+5vbBYDK6hR95MqN6cU/45YeurVOV/WMCs
         uDeNUxKuxNCdDwAh7oIVKMKmh0iEwyth9XJrGzsE1Q28vIkRstwGNOJVLCuAjqdPTPSe
         q/eQFF6MVfzTbGJQ3tdHj3RToEEPJbHnq4SWOaLS54Jog87Eaj6Kpdh6kJb4j/C0O7kU
         /SdOSuYL4Oj8D8fQetuwX75K3ufrpET0nlnpQ1Rif7GXhVDTk3lpMB7zudwt16p6FZk8
         eVt2OuxJsJVWHy88HNQGC5+tKirfHJokgncj4vHoELM9pRKHT9eikK0aue2jFZ5GsyJq
         Dkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291813; x=1754896613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAufSdaXTIAXtc5I2CF6HRoBmqx69Q4G7Onqs+1JwrA=;
        b=fSKFNhe2v7+FTf5Qgo27I7GGIYTtBmZvLom21rWOJOkmLEQuoIlDIDUl6IsdhSUcFC
         L4Yx+Mc5dFxISef3k2BwGYIQFQu4gCVz9VMx7qIQOVC8jYTQt2AkxKvRNL6nxg4wMzlA
         vDjkpOfB7gAC7ZtisVuc/8Tdquzufs76c+qP79rvEtmNmbTE/8u4gkT0KjxL2dh/2zcl
         yvkKGmQ8DWkklpScWN222biDysPMvmbEPxtLgMtv0L51dNM/Dl7gvjmq0KaZGMFHPizQ
         lzRta00CBTmHbbfoP6dIFXi8+ysZG42RhgCxy6/r27idGRMmCkjLB2iDYm80AxrioQF+
         kYyQ==
X-Gm-Message-State: AOJu0YzSPpzOMwuzhBronFh1B+mJpQG9ho8qfmKfo6rJEFiv0CzoP77E
	XQhFkFLauf78W2fCyCkJO4Qz94exZV1RB1Ua5Ah4llf4RTDPjO+YSwU1l5U/Nw==
X-Gm-Gg: ASbGncuDFGsbIwhJs9pwFRWwpxVdAI+vG8bXkYp2mUlmb5GRrNBH+qLWtOEDMUiysqY
	TtIdUTmWucEgjUYNRD4k6O4vtqaw/BgtCdgctm3YFWCHjTXhWOxD/036Z8ZficL/dp5P92qr1Lq
	FNCcYgWGQ5hhtKy32lQ6vpIbtSjIiDDAqw9NuRd9Hh54oSyY0+cgrlaBz5llLEVZr71qsOkHNAP
	SUc/LNAuoXZ0ySW7bpf5QH5cI/gpnOkEXB2rRo8AVD0nRlQla2SCZ6JulidRQpq2hgjcoKXsvb1
	GAGRvX4cdqNaUkRpuaOlLdNTGkQmoX+ZPyvOuqnCME/AkLS3V+f/sGK8eFoeCLlhzI2gGn7x4wW
	tvHgM4U9wu1xRleSRhpfrrYk=
X-Google-Smtp-Source: AGHT+IEaaUWmHzyd2Qusmcj90jz3hHKLV/JvsaqcKfMOaUFdzZZaXrPE9Mnp8ySyq0Mx6FivpdPjXg==
X-Received: by 2002:a05:600c:a48:b0:456:10a8:ff7 with SMTP id 5b1f17b1804b1-458b6b5879emr48994815e9.28.1754291812720;
        Mon, 04 Aug 2025 00:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm14470346f8f.67.2025.08.04.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:16:52 -0700 (PDT)
Message-Id: <pull.1936.git.1754291811503.gitgitgadget@gmail.com>
From: "Mihail Malinouski via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Aug 2025 07:16:51 +0000
Subject: [PATCH] docs: fix typo in worktree.adoc 'extension'
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
Cc: Mihail Malinouski <m.l.malinouski@gmail.com>,
    M-L-Ml <m.l.malinouski@gmail.com>

From: M-L-Ml <m.l.malinouski@gmail.com>

The documentation incorrectly referred to the extension without an 's'.
This fixes the typo for clarity.

CC: m.l.malinouski@gmail.com
Signed-off-by: Mikhail Malinouski <m.l.malinouski@gmail.com>
---
    should be 's' on the end of the "extension" in the docs Update work…

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1936%2FM-L-Ml%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1936/M-L-Ml/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1936

 Documentation/config/worktree.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index 5e35c7d018a..9e3f84f748c 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -15,5 +15,5 @@ worktree.useRelativePaths::
 	different locations or environments. Defaults to "false".
 +
 Note that setting `worktree.useRelativePaths` to "true" implies enabling the
-`extension.relativeWorktrees` config (see linkgit:git-config[1]),
+`extensions.relativeWorktrees` config (see linkgit:git-config[1]),
 thus making it incompatible with older versions of Git.

base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
gitgitgadget
