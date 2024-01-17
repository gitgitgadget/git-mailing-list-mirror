Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEA250ED
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521167; cv=none; b=ZRQT2oQCuAmQ0UneVs5lINbn6V1pQZe7YiPoRydUys0hYh1LLD9ugGN/yThAzzTwz+rTTGVsvxi42rkuoPib3BjjsBJcV0Sbpamg9rW+Gv7Mh9Lj/bvccIfDyezuvgZw34yWoe5uoBhbjAS/c50kwrj+wwH9F1YyiGwoRCxQBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521167; c=relaxed/simple;
	bh=2AVRJUnv5FG9qdXXhD2voc5n2a+ZHNzQPULWoIKmfAg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=IvsAsfB7LqB6rq1iwFGm3dP3b0R4oyvtweU7vBR77VNUD/0DXz0I1JqRbMrQjxlCfwrtZ3mrdS3IGcuCoaKxb4O7mQDEo/t1YpOrUWHQwBJb+tZ1QhZ2UlTAIPjPiyuL5Zd7o56zu5yFgLpxaLwZTAdBNYv01YBE7/gOPE/0dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7NT8j+v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7NT8j+v"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337be1326e3so1871476f8f.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521164; x=1706125964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ecjz1VzHaWr91sVTBWAyAlNQiO1X6dU1IsIua5EH4E=;
        b=c7NT8j+v1bqGn04+nfG/08M1ApKfcP9F+SHanwNEWH08XS9q2iWtZi9MllbKYjOfW+
         JI6p8Bu2TeSzGlJEYBp66ZJFoU7x4Rm9WXx7zZeQ9C17gQktCF61ynOpoF8Qx+/w3f4t
         0W0EjKjGtqUwxOPlyHHMk1Eoy5hk4XsEfyk45Ez0gmd3q2LxdVxjoYWs/WkJ9wFXtIIL
         SVJDCoIyc9dFYMIDyJY+r5/Rwd7GIte0HdIOyB2Wj7434Kg4IQYVUri8yLj0YQgxG+ZX
         pzoig6RGiouNhFaMYpC6ZVLJslpdtfGr51RFpqP1Cb7mqzLe09qRLeM3JZtFUi2H1Oh0
         QwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521164; x=1706125964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ecjz1VzHaWr91sVTBWAyAlNQiO1X6dU1IsIua5EH4E=;
        b=GgMzs06iJxW0mrBBYJdiYMHGNcFxrlHtMBRfG24z4uQI2SPc8wHuJqqzR4r7jfsIN8
         FPoyxpXRaSAJiYwxmWiIT2eSMA2DflxrI1RvnCzUl0nif/uEXGMOHq8T5O2QYZcIOyZ4
         x/kZvLalRGkArbigEq+wOG99uEWjgG2ZpupHu8FZzqW2Wqj4b97JoNzfQrMvmpQ7Wv5A
         F8iRbwrOVuOceN6d/HryC6+hwMTZzibyW6RSbtPHkbNW3bJJ3y2A3LT4UPVim7CUwbso
         wh5VVLX44/XGuQzwtBDKLx0hkPtiZdfycGfIYTxu7UZEGKTFc1+nWlyTWlvvcHz1fwYT
         R0Kg==
X-Gm-Message-State: AOJu0YwWjbBJsIdhtexZbNicVjMUha6vEYBQXLxXy0pSwPlLrlhXkY4u
	tvCKCkCnP19QgE1twHs4iSDHr3a05fU=
X-Google-Smtp-Source: AGHT+IGFxlmsbKAGJFv439asZ+TCsiAWMfWXNyQXyogHbgE2kp13zt0fRdZDIjpqaqLyXwhJaAFgYw==
X-Received: by 2002:a5d:488b:0:b0:337:afb7:1acb with SMTP id g11-20020a5d488b000000b00337afb71acbmr2135616wrq.114.1705521164120;
        Wed, 17 Jan 2024 11:52:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00337bcef9193sm2353816wru.44.2024.01.17.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:43 -0800 (PST)
Message-ID: <dcec7f10ab67f33dd0de87e74698cd222f18603f.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:32 +0000
Subject: [PATCH 09/12] t1503: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move this test to t0600 with other reffiles specific tests since it
checks for loose refs and is specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 5 +++++
 t/t1503-rev-parse-verify.sh | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 8526e5cf987..704b73fdc54 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -522,4 +522,9 @@ test_expect_success 'refs/worktree must not be packed' '
 	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
 '
 
+test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+       ln -s does-not-exist .git/refs/heads/broken &&
+       test_must_fail git rev-parse --verify broken
+'
+
 test_done
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index bc136833c10..79df65ec7f6 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -144,11 +144,6 @@ test_expect_success 'main@{n} for various n' '
 	test_must_fail git rev-parse --verify main@{$Np1}
 '
 
-test_expect_success SYMLINKS,REFFILES 'ref resolution not confused by broken symlinks' '
-	ln -s does-not-exist .git/refs/heads/broken &&
-	test_must_fail git rev-parse --verify broken
-'
-
 test_expect_success 'options can appear after --verify' '
 	git rev-parse --verify HEAD >expect &&
 	git rev-parse --verify -q HEAD >actual &&
-- 
gitgitgadget

