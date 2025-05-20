Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95331E50B
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769722; cv=none; b=OVxXz40fffBJEnoCQ2nOcrl6fPJPZ4x53FZ1Mgspf1jbHbgtQHlvXnWEMZ4U6UGBv3bb4rd90VQIst8AMHK1trZtNwjM7IhlSXfMOzxNpnW2R56hWk3CjFXGrmGSrwKeIPkASzc47cUYiGIXndkVBxBgj28aX7eSrqFdEEP34nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769722; c=relaxed/simple;
	bh=Xj4wh9Th906DQVcgN/GgdcT9wBnmA1nliftTxinJxzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBuarh8aGMAuT42hZa1M7ujeHvbft7XALTpVt3cCWEG9q3DKqCEvxbh+kNnB9unp/Rwyizm4sJ+8QM1QO0ja3XnMOCQX5fgDiK0lpXVMdnn/xfGDQ55AXv+s0Z8RP3972Z/S2ek0N3A85JRjNp3wTvhrF6PLyP+aIi0WR57NelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeDf7L3u; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeDf7L3u"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7d56716544so747716276.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769719; x=1748374519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CIuTRUrlpdI7qOBxSgoV+M7cCrIJC1/xOwBT4h+GovU=;
        b=GeDf7L3uwfK78OnuwbRMToXfxTHITqU+s8jgl9VNPyg7aooR7Ms3Gm8R02dLJiUnzJ
         Yc2ktspSFyHfpmSFy/kjTkieBPvQd4z5s08x2zH/Z5RM4DnutwVqGqj9tpfWHrvtMkrD
         jVImMQnjPcdEjgPvkKaG6VNsz2+lLXMMn1/kE2pxFeh+7tDjcw1tBCCkwTtQVVSCNk8h
         yqVXDGYyqWEKVDOK8iSlJIzm371gjuRU5Pu0t2DSzthtBYl8Z7Z4D2rP1FPANgCn39nV
         xXcKwTOHDPYZrECxGk64pU+QSmt5TnXOc64SJBVruhT3TY/QBg4Uw0MEeEsvmsr5kLaE
         MyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769719; x=1748374519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIuTRUrlpdI7qOBxSgoV+M7cCrIJC1/xOwBT4h+GovU=;
        b=hnYop80DHIoH/8dhUvpOOGWKaC2GXW39Rh6Kh2E+UUdVLPnMfGQkIkJgnkVQ0PIXcv
         Scc3iZZUktnXKpBcyvAsZmMYk917o9+sHoogZMQr+39dJeSf8eCtTQJtRZ5WIfmPHwTK
         bA2KGuEdg47BKmayGOB4K1h31h0sPFJGmQ24EwILJeaAonaIVMCwhQTNFRMxuOjAVEYS
         bmMqcMXVnTvaQ013U4ITHHYOEuBbtU3ldec3k55I84619zKXm5OAUdJjq8cVTSLNyDMD
         Jj27/UVdfDdwWn0xqnAhbNgHeyebWEbxbb45/t3w9//AB/YEvvXJG3FKwXAw2elQSMSt
         0fmw==
X-Gm-Message-State: AOJu0YzWt09t5re+cXPxOx+g+CkEEN9Fwd9joGjn2ZTSKE5UPaqMr68S
	GB5uh9QaH6FFpVwynlNjgq9k3Bd47XZeClOvQk3pv64qeuDBCo/bga0XHgQn7W9t
X-Gm-Gg: ASbGncvEAyIwDSsE2RueAL606VHFPMpjxEMz0eYcFOfFEYLFY/ssDNxBRs70ZOO7T5I
	RSoQYY9CntBuvPeefrK4h9/eAAI7e2jSH/kjSNQ99zZyTEj83Mx/W6lWo4KZPJee3HedHTmv54n
	UfUFoMtEWYkoMcD/GZTEDMK+xydwDrl3Sawgq/nqzJRGRj4mVdUyKwamXnGap1s8XbvBInQYLYO
	GFV8nXQf3TaC+A8BuNikn2IVH45ZaoEaPqJOcQHdqdbHRq4rcCfPeor1iPGRZsDCekNZJKX/oEs
	BOzjf3V1+NhQyLezgFa5IR+k69iB5LYyf4kdiq254Jkbp8xHKs/MkANNnZtqOBzv6oXY7Plji5w
	jwJd1y7AEwmoJhwD1HRuwKxvC+Q==
X-Google-Smtp-Source: AGHT+IEWYye9TyCqOZ0XKabyOiSxgA8VmzYhksGqHpGCd+0irzm6PvOdMBT3rX6nAH/e6UhNY4v2Yg==
X-Received: by 2002:a05:6902:140c:b0:e75:c6a6:ca8 with SMTP id 3f1490d57ef6-e7b6d718fb5mr21919893276.45.1747769719062;
        Tue, 20 May 2025 12:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:41e8:72c5:601a:7e86])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d597dd6e0sm131664276.26.2025.05.20.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:35:18 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH 0/4] Drop git-exec-path from non-Git child programs
Date: Tue, 20 May 2025 15:34:54 -0400
Message-ID: <20250520193506.95199-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has caused trouble in the past [1] [2]; after attempting to help
Git-for-Windows avoid that problem in Vim [3] by recommendation [4], it
was suggested that upstreaming the change instead would be a better
solution. Indeed, this should work for more uses/editors/etc.

[1]: https://public-inbox.org/git/CALnO6CDtGRRav8zK2GKi1oHTZWrHFTxZNmnOWu64-ab+oY3_Lw@mail.gmail.com/
[2]: https://benknoble.github.io/blog/2020/05/22/libexec-git-core-on-path/
[3]: https://github.com/git-for-windows/build-extra/pull/616
[4]: https://github.com/benknoble/Dotfiles/issues/143#issuecomment-2869525481

I haven't managed to test this on Windows, so any extra eyeballs there
are greatly appreciated. I'd also appreciate suggestions to fix the
memory leak.

Structure: patches 1 & 2 are cleanups. In particular, patch 1 is essential to
the tests in patch 4. I don't think patch 2 is strictly needed. Patch 3
refactors a little to make patch 4 take effect on all platforms. Patch 4 does
the real work.

D. Ben Knoble (4):
  t7005: sanitize test environment for subsequent tests
  editor: use standard strvec API to receive environment for external
    editors
  run-command: prep_childenv on all platforms
  drop git_exec_path() from non-Git commands' PATH

 builtin/commit.c  |  2 +-
 editor.c          | 10 ++++-----
 editor.h          |  7 +++---
 run-command.c     | 55 ++++++++++++++++++++++++++++++++++++++++++-----
 t/t7005-editor.sh | 18 +++++++++++++---
 5 files changed, 75 insertions(+), 17 deletions(-)


base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0
-- 
2.48.1

