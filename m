Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D614C79
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707885535; cv=none; b=KA4jtJTIKZZkxIp5OAML2owlM/glxiZqBxQ+gHJ8LLOBXkjj3aJLrQZ/z+Q/zcvk4JiQlxyAiDM8RuyQNZAxYnhjlXu4UGYI1q2vuoaVy+GdN0J3kQ6VhHfaunf54Yv89kVVsFDhvhAZwHyVAK8IIdl1hDSKZ9MVUeLeOe3C90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707885535; c=relaxed/simple;
	bh=9hhk2sB5AcFu6g43SZ0aKGTo1BKYwDUJ3IjZG1GdTH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emhBGn4rTaKrzwFX+wbMBz/IWCSXKD4rdTtiZGBCuPDb5yyMZWr8o0kRw5WqdCTyVY2OpdaaaSGlOv3qvIb517uO4adW/A7Cm8ijF+Si38nmJrNDP3eUsALUqduTH4BoywnTLFeOXk42i0j4ZvrYd41FE8nm+BHZWeo5JvIIVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+bmxnL5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+bmxnL5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso37860445ad.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707885532; x=1708490332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ki3lCv+aSz2bGqsD5jM+pzS5wjnnkMgFqxEdZk4bfT8=;
        b=l+bmxnL5i8lrFfVCSOtrWg0XPG68bbTOp4c64/O9Fzq5MRCKcyIv4WCDxiECi7mlCw
         pqrg0YH/QFa7D4pqriVUY9DJXITdWDB4nhj8yph4UZxQ2ymBL6W7IK+9u+8xFBZ9p2qx
         awQJr9kPLV4H0KJHulOIgWGEpRPVCkeuqw7g6xd6nTkGF4PizzDcqRqQiuSDvA54iKvG
         hHIp7MszI1GbyEgsHF6kl2tsjPec6w6nBLrBKOOjreNiJH2gaE6Su7mrw+ol/dJPkhE2
         F6lXCQQr/G06Kbvi8m14ke69KQ9LG7wng+lw80r41v+YwjI+dhnxwsIVMYa90bVXwInj
         bIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707885532; x=1708490332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki3lCv+aSz2bGqsD5jM+pzS5wjnnkMgFqxEdZk4bfT8=;
        b=U+WMBZQ3xHckdObZFg8ZTQdbD4xsXPfxOsmibRuXz6U0PACAAdAEo0Plgzv7vOuVCP
         0zdjDQMWlwPqCTWm/Rb4rwdPJ7ErYWCDpCDYnUpOATSozRUAZ4w0XZiAVuewYcBkmj70
         RHGNoDnS6ZRf6osnC2PRCKgFwF4JqqqP3kNGpmfsGGKD5LouhGm5UEKojSSwITgaCvSH
         hfntKU1UvYu/fsNubwBS8Xlitb3YkAMxo49joHdvKNv/YyAENVz6FoRQfzNB3t5ZHvy1
         XS7w+VjG7fPklxM+TFFP5Cc6icKgYt6NLn1UuiEXOfbFg5gHai+AuRaiQpxun67Oaiv8
         alTA==
X-Gm-Message-State: AOJu0YytS58moFCk0ejnG7PvptYZHYYY6iI7TUUkLbX9fD+bj1jUzJgx
	+By1dyh12oKsxty1bnSTWHVTwxOBOLM90sFHhTEQWBEj9A0gYvyTAF0RJOiu
X-Google-Smtp-Source: AGHT+IHe9a7MXb0OBdQYJ0XWgJF0HVqbkb8Bdt+L8gt7O0Fuf1VReTu0TRFcWSM+kax7iLD1ZFZw6g==
X-Received: by 2002:a17:902:c411:b0:1d4:e0e6:693 with SMTP id k17-20020a170902c41100b001d4e0e60693mr1951112plk.35.1707885532115;
        Tue, 13 Feb 2024 20:38:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtHK5s43uF3hwCIgku/Cs5H73zOepWweagjBnqUeimbP1s1b7+E6tuyPYmiUKaVVKYyPF1LAoT/MPxNQdL/Y85LzfbuFYv61uABQUfj5dV+bxloXbDMTpn3oJvnDFys1/xauilHY/0YoEM6Bt50qx20A==
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id kz14-20020a170902f9ce00b001d8d1a2e5fesm2833186plb.196.2024.02.13.20.38.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 20:38:51 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	"dependabot [bot]" <support@github.com>
Subject: [L10N] ci: bump GitHub Actions versions in l10n.yml
Date: Wed, 14 Feb 2024 12:38:46 +0800
Message-Id: <20240214043846.4385-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Johannes (dscho) sent a pull request [1] which updates the git-l10n
GitHub Actions to the git-l10n repository. This change can be tested
directly in the git-l10n repository, because the git-l10n GitHub Actions
is only turned on in the git-l10n repository. I will merge this commit
in my tree and send it to you this Sunday along with other l10n updates.

[1] https://github.com/git-l10n/git-po/pull/749/

--- >8 ---
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 7 Feb 2024 19:42:17 +0000
Subject: [PATCH] l10n: bump Actions versions in l10n.yml

This avoids the "Node.js 16 Actions are deprecated" warnings.

Original-commits-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/l10n.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 6c3849658a..3d89758981 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -63,7 +63,7 @@ jobs:
             origin \
             ${{ github.ref }} \
             $args
-      - uses: actions/setup-go@v2
+      - uses: actions/setup-go@v5
         with:
           go-version: '>=1.16'
       - name: Install git-po-helper
@@ -91,7 +91,7 @@ jobs:
           cat git-po-helper.out
           exit $exit_code
       - name: Create comment in pull request for report
-        uses: mshick/add-pr-comment@v1
+        uses: mshick/add-pr-comment@v2
         if: >-
           always() &&
           github.event_name == 'pull_request_target' &&
-- 
2.44.0.rc0

