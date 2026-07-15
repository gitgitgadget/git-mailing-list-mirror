Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDF481224
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128942; cv=none; b=cP/MPPtB3M/pbFHglV6jb8NXx1yAWI6+ArPYsjti0rwnJ/ZjqmjZvQP4TwXNLlMFgDRmDjmacGtLb62Jj/EqFgonaDWTKyO1Lgf+zd+I98lWUZAL46boVZSRMovf0Try4a9Deg+9PBnzFPXv8u+zhTndKMcV729fwxKBwtq2o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128942; c=relaxed/simple;
	bh=N5XT3voEDCzk7ACpi8rr4NwVep0XbfE/BJcj1LtfArQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxqlOulQzDsgKHitA5+LxglN0rUKZq6cIIThClfCNwce2nUSI/E4bN1zc5rf93jOvE1QRQ2oXMz7zJbFeOriSXrQXEUXHhYoljTZb6xWdh0o18oW/NgW4ur4cPfRXjjhjuaJQRM1GN6N1Qk9ZGRO3180R4uQ01GrYIBndNdj9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFaKYqta; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFaKYqta"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f45e206dso5912755e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128939; x=1784733739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jmeyyl7TJqetxHM4uLA4NUmvH++cr1ZHOGJx5019X1M=;
        b=gFaKYqtap2ihMc7Zjc2S82YJcgGn9BHKDeprtmUH5AtLrhThmcD6H0zKEtj5I6zm3c
         mc9ZKT9oxkNmBIoh2ynFgcgXOUvcqs9D3TMxmqEKO8Y8jtAYXlVPiRA7Qhj+BQ3bAEuq
         PWmEAPDWsQKVMRoDcbFHHujmmzAZM5r8SfsGuqgG9PI2VySuxbsJzvVDoqKgmOESWw8B
         7zTUrfCaJ+mL9TnQCQR6xzwWjMOdyDhXAmelp3hOicpNq2WdKeL7gpytFxHchgx2DN1U
         XWQFkRl1B1o7+WUZGg3mf0Y1Qx9XyQPj4rSpwNhU3wFBBSnJpR7v4kgRpVok/nBVsOsv
         IGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128939; x=1784733739;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jmeyyl7TJqetxHM4uLA4NUmvH++cr1ZHOGJx5019X1M=;
        b=UYo7D1tRkEBINPBVB1I8KA1uSFEnIwd+aLsA5290+4RBHKGaHrAnkiF0i7nF1uXz5F
         qWVW3y3hnJ2NSYxw7bozbQ7sOeM+O9dByvzbKJQfE/walJskkgqy+WhGz5N46Eq9NAA6
         +GhKUR1+wlBPASwpbJ7MM51vw57srH+Z4YHDFEGnxHsQ1ISWqCOpIcjP+uDG3jKpijeG
         u261fiqceolQ3ZeHmFglNH2XDRl+4a/C4vF58TluIiZDnVkqESfWY8HhX/8J0fgsBfM8
         1agMsde1FBA4LmMddz/5dAn8RbSV4VUg70ysNfTWMKIHMa+cB9hZt+oL54v42C2aaGvw
         fsBA==
X-Gm-Message-State: AOJu0Yyxj1lwLoSRfbzniBdqcPDM3jPgavzapWoTOMsEs7e8XqQIjNUx
	3zr47nilRnmrG9Lt0zbIry++ZsTSqaAeKwuN8/qieXouh3dLhFyjnnQAVjWdnQ==
X-Gm-Gg: AfdE7cm9BjmBSYzgMXQwhidwTMlumdk/u/xILR2o9AwgwLkJo7T4IASXwfdzyjhEBtH
	xHJ7VSFW7wmDtrOCe5ygD13taYc9an/ApGI1Il6m7sJsIHiHBlp4yNFyKsMY3atr6mWsl1B8UUl
	7mPmGQEgjIifG5GMjqweLjwMyhACuHIUCtgPN2p1vJ21zZeT31gNTh+Pat1R/TrrF+C/q9VaezK
	G96OkhzkHX4x720gPOTK9qTxVMGnKoNLFeVR+yXLRHuinh8qBrgsK6vpG4js1UiCsdRrjHEC7kg
	qrtbo61V3QePisyC+x8cqNmKfDBQbjpbJkCqFL/CpG/hVk/+6UVMdq+HThqzBdVhVg2PZFhpB1E
	eqIoHAnDoQqxhORFgbDyoMX5iq2IHcpqB7RAtVgWRmie3vn+KQLzhCbpwF3YnDFsq6nHz7jWWMq
	RqlOIGCMEK/GJlN9ixxfveGboRudg=
X-Received: by 2002:a05:600c:8b32:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-493f88db5a9mr180216815e9.18.1784128938749;
        Wed, 15 Jul 2026 08:22:18 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:18 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/9] t3400: restore coverage for note copying with apply backend
Date: Wed, 15 Jul 2026 16:21:55 +0100
Message-ID: <c4705066ee0e3da2110fe155161ab669aff87425.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the merge backend is the default, we have lost coverage for
"git rebase --apply" copying notes. Fix this by replacing "-m" with
"--apply" as the previous test which uses the default backend now
checks the merge backend.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3400-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b1..f0e7fcf649a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -270,9 +270,9 @@ test_expect_success 'rebase can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
-test_expect_success 'rebase -m can copy notes' '
+test_expect_success 'rebase --apply can copy notes' '
 	git reset --hard n3 &&
-	git rebase -m --onto n1 n2 &&
+	git rebase --apply --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
 
-- 
2.54.0.200.gfd8d68259e3

