Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A4944E
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749515884; cv=none; b=bdDE7G7vNJ0lSzZpExCNOTE0mq2gXaExfyxwaq/01tbnl14xe8I+8kGLHBRxeGlLRDEp6wCnquQsbwH3H5IUov4BkORpcj063sofsSLXAtt5YY9EBSXkHOSv6QT3+4ceCUqWDJj73VTuXVYK7RtCzHt9pKz1mQhXIlWIPjHM/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749515884; c=relaxed/simple;
	bh=auZ2HEAAFB0Bfi/b9obE1NiSaf6Eu60oGJogSU7xiVQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QjFjQV5wpxVXEaSrZIWLtizT7v+69reHcKBEnOEGGCCY2BmdgGzoIb28z4J6IRlguOKsXTfGGw5AVPzNKF4HBy56GsVclTfx+VeQ5KaAG4KUarjk7D6YiOa66dlNm/Xl/HMwPMg60Qt2pW2vUjOavZ5hOHFaNxraZ0aAEv3o960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV6e/hDp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV6e/hDp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2709857f8f.2
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749515881; x=1750120681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd+vf8U6Km+tpXoSkL40gibdS3EO/s0OmuO0rCFduKU=;
        b=QV6e/hDpHi91pJZh+/F2SFW21YksGTGhOWjQip2BZI0YRMP6ane+THDgZ8nKMxnvnn
         tf8p5nfRSShIIzJ9ejwnYX7cNZfexqNQNiiEN+WZo6nI5MnINieT1yHAz0xMqwmSJTmJ
         uQSAjd5cS2xTX8FXmkm0oYBsjQp7JqopKcC0QMz5OvAWBykRHlAYMX5l0xPeG1NHNbYY
         095J3ec20+Z7p/IC4AdNgot6iqllSx8ujuHzs6Yiocx8whXNZPKr6w3NBeRatbs7T16p
         iOIWwCX7QEtPJlLeT8uASdnFbih/zexSJK54r3g3ND9FR/qFbzE4aL2JnEppHS2aa2Fu
         SdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749515881; x=1750120681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd+vf8U6Km+tpXoSkL40gibdS3EO/s0OmuO0rCFduKU=;
        b=I8mKj2eu4J6ZcjgwwxoLsLsjqEOoTDju9QVV0KsYM9nIicr1jLIe+wO4dOQNEO9uxN
         V9rTRtgwAGI8n9uqcTEvGxTTc85CpWgWL69z76yPJAYFKyFSx/TO155on7rUF2vqIkeP
         9wBI6QpkdaH6OE7pWdc+Vbv9AQdyf7scIIHUH9RqRAecSQaL2XAUbn8EaMCOgUWrXPEw
         sc9/rFOJtVdFkjH4T0cLY4tijccLFThKprjVvSE8GosFtxPyVjZUEck2/95AOswYYyax
         q8qjUm/OZZWoFoOnw0WcKXAa2Ku+STHxaG7kCnLfzPQUM49bP41mD4OMVPEABdcd/K8S
         Iekg==
X-Gm-Message-State: AOJu0YyDbQAMlPVUJb+UWvxu5aSnOevxYelpyUBFNH+3dk0sB8Ezks8f
	e0lAEELF2Ihe4Syh3TMaG8eW0qPJnAibG1AEmcbbgqgDaZN8h3FCqATHhU2CDQ==
X-Gm-Gg: ASbGncujHpYPqseoT1WU4LWow7wVMnOdmeo1L4sBqWdf6x/gqpKs8kxQUFK5edUSwmN
	N83nQXRtW/Otrx0ttfKXf6dScLX5pRY6Gph4uzdBjPFhleNBaHmPapXXNttDJUixXQSM2AYrVsV
	Y2OR98H8fowxfw50oXyyRj4LSmU33aZA7nSbTP2CXXhx3Ew9PV+ErApWHgsdpnYQgIQonva8JWC
	jCz/5SBUVPJNKjqrgLoHAXLidQnYkzXfPcPpeOgcpq1CZThk6qioXIE8nkpnmGiy7jPK4CJFVTr
	j4HtVHvgeTHjs4ycSlrI1xm5U/i6kyBAEuO3MKEM4JDQXLRTeqH+iKfkE4Aw7ck=
X-Google-Smtp-Source: AGHT+IEjIHNBPI1VeF7Ah5L4ZWhqj0VVOWahNtuKnBaMOw3tRm4cIP7YtcRNxpJ3XlFLpGWBcN+5+A==
X-Received: by 2002:a5d:64e7:0:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a531cab757mr11043039f8f.19.1749515880907;
        Mon, 09 Jun 2025 17:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137258bdsm126134275e9.27.2025.06.09.17.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:38:00 -0700 (PDT)
Message-Id: <pull.1989.v3.git.git.1749515879546.gitgitgadget@gmail.com>
In-Reply-To: <pull.1989.v2.git.git.1749456990648.gitgitgadget@gmail.com>
References: <pull.1989.v2.git.git.1749456990648.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Jun 2025 00:37:59 +0000
Subject: [PATCH v3] revision: fix memory leak in prepare_show_merge()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In revision.c:prepare_show_merge(), we allocated an array in prune
but forget to free it. Since parse_pathspec is not responsible to
free prune, we should add `free(prune)` in the end of prepare_show_merge().

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    revision: fix memory leak in prepare_show_merge()
    
    In revision.c:prepare_show_merge(), we allocated an array in prune but
    forget to free it. Since parse_pathspec is not responsible to free
    prune, we should add free(prune) in the end of prepare_show_merge().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1989%2Fbrandb97%2Ffix-revision-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1989/brandb97/fix-revision-leak-v3
Pull-Request: https://github.com/git/git/pull/1989

Range-diff vs v2:

 1:  61a2d98dad9 ! 1:  88795b33bbe revision: fix memory leak in prepare_show_merge()
     @@ t/t7007-show.sh: test_expect_success 'show --graph is forbidden' '
       '
       
      +test_expect_success 'show unmerged index' '
     -+    git reset --hard &&
     ++	git reset --hard &&
      +
     -+    git switch -C base &&
     -+    echo "base" > conflicting &&
     -+    git add conflicting &&
     -+    git commit -m "base" &&
     ++	git switch -C base &&
     ++	echo "base" >conflicting &&
     ++	git add conflicting &&
     ++	git commit -m "base" &&
      +
     -+    git branch hello &&
     -+    git branch goodbye &&
     ++	git branch hello &&
     ++	git branch goodbye &&
      +
     -+    git switch hello &&
     -+    echo "hello" > conflicting &&
     -+    git commit -am "hello" &&
     ++	git switch hello &&
     ++	echo "hello" >conflicting &&
     ++	git commit -am "hello" &&
      +
     -+    git switch goodbye &&
     -+    echo "goodbye" > conflicting &&
     -+    git commit -am "goodbye" &&
     ++	git switch goodbye &&
     ++	echo "goodbye" >conflicting &&
     ++	git commit -am "goodbye" &&
      +
     -+    git switch hello &&
     -+    test_must_fail git merge goodbye &&
     -+    git show --merge HEAD
     ++	git switch hello &&
     ++	test_must_fail git merge goodbye &&
     ++	git show --merge HEAD
      +'
      +
       test_done


 revision.c      |  1 +
 t/t7007-show.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/revision.c b/revision.c
index 2c36a9c179ef..afee11119615 100644
--- a/revision.c
+++ b/revision.c
@@ -2060,6 +2060,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited = 1;
+	free(prune);
 }
 
 static int dotdot_missing(const char *arg, char *dotdot,
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index d6cc69e0f2cb..2d322b53d16e 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -167,4 +167,28 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+test_expect_success 'show unmerged index' '
+	git reset --hard &&
+
+	git switch -C base &&
+	echo "base" >conflicting &&
+	git add conflicting &&
+	git commit -m "base" &&
+
+	git branch hello &&
+	git branch goodbye &&
+
+	git switch hello &&
+	echo "hello" >conflicting &&
+	git commit -am "hello" &&
+
+	git switch goodbye &&
+	echo "goodbye" >conflicting &&
+	git commit -am "goodbye" &&
+
+	git switch hello &&
+	test_must_fail git merge goodbye &&
+	git show --merge HEAD
+'
+
 test_done

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
