Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D238A73A
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063569; cv=none; b=G6lfLHRKgYUkTBnYKRtZbMk41DbvzXD57aSERs/BdEbqExaWi7MamGy1GxDG3IZ8JeOqi0v/FSZ80vvMHqEdc4EWPHsxwDRzL7ia820nWKZH/IqEx+4/HDOky5tXJql/elq3IZEDGpqsAkXh9WTgJNQ0y8claoHwSG1Ucrt6lPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063569; c=relaxed/simple;
	bh=bSmBNy8k8zVLK5pfwt3QJ3G/Fv86OM/FkZsOv5Qv/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWgRoYYCjsIUm8F87P6QcDPBBkDJdd5IwFTnfKypgeC9FQrz1AiuC/T+fvC0e139I78upEO6ovuP5dLqzfrE31oKvsKIYFNR3D4Ijzhx8+P3cO6qkC5qim+zWBuTX0ztGYyT6IYJNuKWvZ6traj/1kj8qcKOYn+TWIbggjD8Wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK1VN6AP; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK1VN6AP"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40438e0cba6so4499301fac.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775063566; x=1775668366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMSsme7IY6vT4HlvsfRM4eERQk7wvlp5eIvDhL6cqs4=;
        b=HK1VN6APxesibXNcib4Mu4UAD84CkMjEYYSGUGO7nEekzfanWgmeqe5R2lgSmp8nxD
         uk5obbWCgjUe4DT92hZ213xfjvXOqAVF7FynPPvZP8SDNW9WEOv1G5Z8f7Tvk0zTSDcK
         XwMvTUF3aMojZ5ExI6ZbHiIGSgudjlwftxxaMSQdB3F9h764gDvf6WrAWw3RoeVP5ods
         XbsiPyLAiyk7UbBDeYiRM9VLU8rp3dlg4Zdd9Kl/WqiJKP6vpxU1Wh4CwW+SvAKH3DqX
         mJhUOpcLp76wPhZWxAGhC5o3YQscBf951t3EjdQUsfXJJIDKYNh+fbI7A5ZmkgPThejb
         0rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063566; x=1775668366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMSsme7IY6vT4HlvsfRM4eERQk7wvlp5eIvDhL6cqs4=;
        b=sGe9EyhFUnhQz0/W4/xBs6T3TlbcB32CVQXp3paC5bTXVktB2bNEWTbj4ioPvy3BtK
         xOMxwbrRRKSZ957nIBOb3LUT1+D9wAsgQkoJgTmgnH2tlVzRgc/a7N27PVG38N/2px80
         W6mFDtG7CgOD1iPPeVYcLT65UUs4rEMyMTrnxIzlqLSjt0Cj1inxKS4/sjH+wfIWmjO9
         aZ57i2XKzfj7QGTuzbzJQGgvNT6HPII7d9mF5cOE7dBxjJQVBwXxpYBZLqYZ8vZS/F4v
         oRdWk9Gw0LtnzJ2xz1JItI3nqXin76Xn5p1rRET1NtkZ49pwLOsdvx6dX/t8NCzoTrbg
         +h0w==
X-Gm-Message-State: AOJu0Yzwd49UL/397MHTVb57FSNYtT7oR3gPdkAUXJCQLbNnoC5VTTv3
	oD6cN1mht5r6RG/Vtl5prk3dIzC0sNYG35IaDo3i5D16OROyJhPXJIkDXfaulA==
X-Gm-Gg: ATEYQzxYzYKovVxsTVedt27MQ3ruXoy43bxf5rzYcYmgFXrsLEWRaPZiiW2MF1M2T3m
	jXPrlfPkN//p6fkim/YiVqA7pHhZpbBWc9N4p1wbRctMBiMEf5j3Va5fD0PnmnPDBO4B+7sWC+C
	/0O8ODfq46hasggXl/H21DzB6ZAQNGRTPYexL+YR20RwVuKcE3s3eDvDMx0d6gAQay1+JLExINZ
	wZj9Zu+7gmh9nsZO1B9QyqzIt/SOLTIrnrcVA4ZOE/fyW8R55VJoXBzU3QZYkVzE3OzNOtZGxo1
	Em0FTryywbXvlVmmGmablkZyIezBvPYE2+JrO6BlOWdssuZ3U6QU/6As3h6+/bbG9okpETxqd9h
	hsevpVgHbnfboVWFzbTdsUH0RiwNX5FVFT2iIiNLDbk/EI4QUCokruP1c+5Ge/lwlNQYbIU6dtc
	0+auFT1klgqqQm1Fqh4joJCaoQDi5aA+YvtPpZ7dWuYL2s8kSL2UnMs5XKatM=
X-Received: by 2002:a05:6871:8314:b0:409:8473:d76 with SMTP id 586e51a60fabf-422cfca6e82mr2614034fac.18.1775063566265;
        Wed, 01 Apr 2026 10:12:46 -0700 (PDT)
Received: from Mac.attlocal.net.net ([2600:1702:74a1:4770:a4f1:5ce8:780f:fe5c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf94eccsm256464fac.8.2026.04.01.10.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 10:12:45 -0700 (PDT)
From: blindmansion <blindmansion@gmail.com>
To: git@vger.kernel.org
Cc: blindmansion <blindmansion@gmail.com>
Subject: [PATCH] read-cache: disable renames in add_files_to_cache
Date: Wed,  1 Apr 2026 13:05:02 -0400
Message-ID: <20260401170502.35877-1-blindmansion@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
References: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_files_to_cache() refreshes the index from worktree changes and does
not need rename detection. When unmerged entries and a deleted stage-0
path are present together, rename detection can pair them and rewrite an
unmerged diff pair to point at the deleted path.

That later makes "git commit -a" and "git add -u" try to stat the
deleted path and die with "unable to stat". Disable rename detection in
this callback-driven staging path and add a regression test covering the
crash.
---
 read-cache.c          |  1 +
 t/t2200-add-update.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5049f9b..d938abc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4049,6 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
+	rev.diffopt.detect_rename = 0; /* staging worktree changes does not need renames */
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 
 	/*
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 06e83d3..56c7e55 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -200,6 +200,45 @@ test_expect_success 'add -u resolves unmerged paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -u avoids rename pairing on unmerged paths' '
+	test_create_repo rename-crash &&
+	(
+		cd rename-crash &&
+		test_seq 1 100 |
+		sed "s/.*/line &: shared content that is identical across both files/" >conflict.txt &&
+		cp conflict.txt bystander.txt &&
+		git add conflict.txt bystander.txt &&
+		git commit -m "initial: two files with identical content" &&
+		main_branch=$(git symbolic-ref --short HEAD) &&
+		git checkout -b feature &&
+		perl -pe '\''s/^line 50:.*/line 50: FEATURE BRANCH CHANGE/'\'' \
+			conflict.txt >conflict.txt.tmp &&
+		mv conflict.txt.tmp conflict.txt &&
+		git add conflict.txt &&
+		git commit -m "feature: modify line 50" &&
+		git checkout "$main_branch" &&
+		perl -pe '\''s/^line 50:.*/line 50: MAIN BRANCH CHANGE/'\'' \
+			conflict.txt >conflict.txt.tmp &&
+		mv conflict.txt.tmp conflict.txt &&
+		git add conflict.txt &&
+		git commit -m "main: modify line 50 differently" &&
+		test_must_fail git merge feature &&
+		rm bystander.txt &&
+		git add -u >out 2>err &&
+		test_must_be_empty out &&
+		test_must_be_empty err &&
+		git ls-files -u >actual &&
+		test_must_be_empty actual &&
+		git ls-files bystander.txt >actual &&
+		test_must_be_empty actual &&
+		echo conflict.txt >expect &&
+		git ls-files conflict.txt >actual &&
+		test_cmp expect actual &&
+		git diff-files --name-only >actual &&
+		test_must_be_empty actual
+	)
+'
+
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
 	git ls-files >actual &&
-- 
2.53.0

