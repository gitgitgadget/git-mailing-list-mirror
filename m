Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF12155A30
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765760; cv=none; b=f0rNR0lmo4zU4sfVpis/oRHoGBWtCweH95dgcbqJdWu6zdD+tj3eZhmdwJFBdc/74kdw3+pKn60hUdRXXEE9KhBaRr+O75hQo6vxe2doFGwqGmlNz969sZXQMbOpUIeCJvhZqYaS9kl1j1mkjz8XSMc18QujEPvrtQacXuwPE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765760; c=relaxed/simple;
	bh=yHG28fCt+9Btk5ijZufpPHSNXRwx6P83QynAVKZoiXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsIs8hk0hODJI3xpEkw0LuM5tV9Ga4i5P1aWlP2Q7k37jXUyVNTnerlw7wL98SPrTw4Z2KF9xxQHj1XdVphlKDB/baen9vcMncYk5s3expA+V9NKU8g3NGUmRAA3fvwIDzxRPp5GV7S5p0v6n0Vh+feA53ov7bcv82s96SZdwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwuJ4B5j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwuJ4B5j"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9d9f14a74so2315444a91.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738765758; x=1739370558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI4O2/QHXP6PE+KP3P7PJJllEiGcG7EeLUoAtyWpahQ=;
        b=kwuJ4B5jQceTTOPrsMVaTlOKyM/mQJazJZ6g3hJpdZ3hP8uJW5W1siWDIiN3w3PIRj
         sJ9qpdNcj2iPpn+bGX0197qL0f0cHtq76Wo5UDBKqFNz5IhtI93bJcRqeR+z62QL1l59
         vjDzQrckTB2XO4VxufAyGfzt4pKUF8w+CdKd17ObAr1lYw92v9tnbLMXkOEhqoONUmLn
         fUXML5Y9lwqKv4HCbpYLw2XYgqfJnwfL32b0Uym0c249tet86r5zAmo98SZTcbcjcqv/
         oKIj9xvD0VNMTkhG6x3xDMj75kh2azNgcJCmYFPwkTrWVKHulWZJiwuXnroh0vVjZtbu
         9dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738765758; x=1739370558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI4O2/QHXP6PE+KP3P7PJJllEiGcG7EeLUoAtyWpahQ=;
        b=JpTpu/SRj0uAndPZ9eD0zCWkGLFCGQsocsmyZG7MrDuSXQKjdgUICJzWMxTrZE+KaG
         BMmdcCTFYkSwHAzpZ1Gs6SHdCvwkwk7k0oTdQySk2TeDbhJbOKehYN2MyWbAAbCiJSdL
         6kxLvXuL3N5UGTYxYMCTSTWZR4DE/YsX2ATnY3l0k1YfEqTOaIo3uvNcZq/YPLK9yq87
         zhJ/0QHQFdaJqxEcNInbhQkLiQ6SaFXrbSvprec/d1SL6lNJFGeKpljV0MYH7xtug37u
         1liR9r7tCDnXLVICvkLp+wm+XU57PIWOvyV+zKZnzEQRbRP3q76SR2mlpH/sJFtM4G9H
         kirA==
X-Forwarded-Encrypted: i=1; AJvYcCWJPoL7o9pZ/bxS2x9sSwUQqKCsbHorCtN0XWgKOb4UjODEme/waTUd++WCHAVZZRW2Ym0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkwHwFFNU3TFa360/eY3mkem4tFQ5S3jIzsUXurom93R1zUAz
	9aFe3wBropkaeeIRDU1kqccAtxHnjkdumUy0S18TkDEnPN0p79Qa
X-Gm-Gg: ASbGncs85TeXsz3i4zT0USjCLHgnVsa+1+34t9PkrZXXeRzQlVSf2EvsBPWyNh3vQBX
	2XfeAdRRDQvJU9CSNIjnBQib9HEV5Jn3P5kJ8KD9hM4eLMz9bQWdpgjF0bPtLe6O5wmm4nq81cx
	q2H8uzm+/8iDDdbzlgG84f8z8BtS8E2+ksHuJtdXkthVp5b3QEuCwhlK4gjsj/GngQO24XI+aQo
	YfByMNW1uvc70NazEZ/jhXViKsg/qe6vb4YUTLPNFnn1Y890qqAwiwpEih7CepxJQSeIwlJr7Qo
	rI0JGVKk7lyIoMk4F0e8WFPnst3QWTem
X-Google-Smtp-Source: AGHT+IEbGcuMYvExGoiNSY9QA/M/tI3uE+Dr6z/emqCCKJGbPJoOu0gutwGUNQQfN6Bo/RDUxSr+7w==
X-Received: by 2002:a05:6a00:140e:b0:725:e309:7110 with SMTP id d2e1a72fcca58-73035108059mr4392001b3a.5.1738765757855;
        Wed, 05 Feb 2025 06:29:17 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427abdsm13043820b3a.59.2025.02.05.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 06:29:17 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	sunshine@sunshineco.com
Subject: [GSOC][PATCH v2] =?UTF-8?q?t6422:=20avoid=20suppressing=20Git=E2=80=99s=20?= =?UTF-8?q?exit=20code=20in=20tests?=
Date: Wed,  5 Feb 2025 19:58:17 +0530
Message-ID: <20250205142817.42117-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <xmqqjza5x3go.fsf@gitster.g>
References: <xmqqjza5x3go.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some test in t6423 supress Git's exit code, which can cause test
failures go unnoticed. Specifically using git <subcommand> |
<other-command> masks potential failures of the Git command.

Instead of executing a Git command as the upstream component of
a pipe, which can result in the exit status being lost, redirect
its output to a file and then process that file in two steps to
ensure the exit status is properly preserved.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde..a6c5b5a494 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5071,7 +5071,8 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		test_path_is_file source/bar &&
 		test_path_is_file source/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5129,7 +5130,8 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		test_path_is_file bar &&
 		test_path_is_file baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5187,7 +5189,8 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		test_path_is_file dirA/bar &&
 		test_path_is_file dirA/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
-- 
2.48.GIT

