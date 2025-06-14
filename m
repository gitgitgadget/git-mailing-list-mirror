Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914F34545
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749884808; cv=none; b=RyqaZ/8C/73o5LrcEbM4aCE2g1vpPOpgQ9yyYukkvXo/HPx5N4o08pN1mcsPGxT4zqxS6gsiPpIzfpzkd+PLYSQ3m3o2iNwCBz40rNFOZ37AyhyBdBxmbbRSFFQ/aQG4Cb8xDH+4wkQ2c8QBLVkkWqz8nI8gHLMPh7h5YrIhb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749884808; c=relaxed/simple;
	bh=MHBpow0npD7mLxPppTpAdJIq8zY05DwdqvAy6+SK6qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRZMalya1OjAFn1UQ2PdeWSHpdY72FQ/xY6+akokQg5thlWp+wyJS2uWu/g6PeKigVH2R6KIH8yiFcOEk/38KnfFjs664ZL9gPzA8vVpFbBMzHTrrSU/SdEUie6b/omA6M2p07UsKdb8EvoS7Y9pGXy54D4fWFrM8Wfqm9jEGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQbyPaEc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQbyPaEc"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c40a7ca6eso2950309a12.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749884806; x=1750489606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK0LeXzvkMg0+06wk26azMgsByvyALAL0ABZ4OteOuQ=;
        b=aQbyPaEcajnI9y22I9gbcUGZco9Re9zrbERnLKddiliJcj1Bx4uHzjZENUFkQsrxZ5
         NHzL1qkpR7buH4/YCd1pOTW7k4qNESA1MWZGlIgKe8E/wYCNzIY9tLCm0dKFK9pycfUu
         jt0FyK7dzIemUZsSL2JrfMAjFNYwh838sTidalZYmP/0TOUihfNUfgD1wL/oP4Ixq5MH
         qCx2iR/Kuk48dUY/t6zxSOFOkvl3PdR74SHH+54ridoaFoctEnRzBsAFnQa2Pv7r2dQ/
         mI74xtd8CopLrAxHEWBBuo37hwxZyUcFg60TgQYCMKaJxEGVvdjfKqdBx8B0evd84aax
         +/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749884806; x=1750489606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK0LeXzvkMg0+06wk26azMgsByvyALAL0ABZ4OteOuQ=;
        b=DJrgTq4x+uhUWTt5ANC7ImYIZLB0E1cyonr5H4Sh3WP2v+Yec70IOqE8iMg/b12jeK
         0XwiZrye5kRYjyiYo5ySBG86uopJpkj/79g8CXwvRnUPNocxUp7IS3LQGTItovqb4HeL
         Fhprlc/o2bzOCFXyrkcYjmA5rf4yiK2b++hmzdKsaJLAtltaYQauK+VlA7R9iA4tirKh
         f9xxTtheQrneAIMOKr7ZEIGYe7rf5nGuC0Olr/FGjr9MWWZtHIfX3BslI9lafZrbqiE/
         7S15W0vuk6TuFV7jBmfnk7R3dDwJoUxCLaxZUDCxgBqO6yeQMjxsxtHZVOlrRwB5sCUe
         g2Bg==
X-Gm-Message-State: AOJu0YweNlP+GnYXSirOG3OZelwuRhdk4qdOUiw5Qz/mDZYPguqywdUk
	uGxCOlYZGWQMLPSVeDKCs9aQb2dPFUyZkH2wAk0GMpgkUpv2Rjb0aX3Gcnmx9XIa
X-Gm-Gg: ASbGncu+Gv0n/LAf8zsIj8JhV0xzMqAnHlc3BynneX65cFgalOS2lTw4Ra5kX2U29Ee
	6RIsDc/mpOFPuZugOq7fbJ76TWf3JheOXrn18pbHFKmQtDD8l0L1Mq4Fk4BAnp5WeSTtas1Zzdg
	BU1YM2hHXQh76xHdu093qKDafkDJqhUFsy8OsnMAaEaYzC+3yjR7eEY2OENMuzUPrR0ZRtWcAEk
	4EBBD1ieihO3nw18fdzsBElo03wDPBmVC9oh1HT0XpPbzZpnQ2CyOGHXgWdPn2g4Iipr9bTNCEv
	6TjZh/cJxADk//mmXBHKA15PKQQObsiJ/7lPciPHkZ6oNXlTst8uCPn0MCE=
X-Google-Smtp-Source: AGHT+IG/NuJqORsUY1YY1gYWzZKgszdrM9KEkiIaPA9UfLCdLVPcje7gNA/uvIbB4G9UjVlfxFo6pQ==
X-Received: by 2002:a05:6a21:a343:b0:21f:4631:811c with SMTP id adf61e73a8af0-21fbd556858mr2650681637.19.1749884806252;
        Sat, 14 Jun 2025 00:06:46 -0700 (PDT)
Received: from meet.. ([43.250.165.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168999asm2380814a12.54.2025.06.14.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 00:06:45 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	shejialuo <shejialuo@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][RFC PATCH 2/2] t: add tests for refs list subcommand
Date: Sat, 14 Jun 2025 12:35:36 +0530
Message-Id: <20250614070536.17320-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614070536.17320-1-meetsoni3017@gmail.com>
References: <20250614070536.17320-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the implemented functionality of `git refs list` and verify
backward compatibility with `git show-ref` for the supported flags
and patterns.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build        |  1 +
 t/t1461-refs-list.sh | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index d052fc3e23..c9d0863490 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..d628a193fc
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='Verify git refs list functionality and compatibility with git show-ref'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit --annotate A &&
+	git checkout -b side &&
+	test_commit --annotate B &&
+	git checkout main &&
+	test_commit C &&
+	git branch B A^0
+'
+
+test_expect_success 'refs list --branches, --tags, --head, pattern' '
+	for branch in B main side
+	do
+		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch || return 1
+	done >expect.branches &&
+	git refs list --branches >actual &&
+	test_cmp expect.branches actual &&
+
+	for tag in A B C
+	do
+		echo $(git rev-parse refs/tags/$tag) refs/tags/$tag || return 1
+	done >expect.tags &&
+	git refs list --tags >actual &&
+	test_cmp expect.tags actual &&
+
+	cat expect.branches expect.tags >expect &&
+	git refs list --branches --tags >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		cat expect.branches expect.tags
+	} >expect &&
+	git refs list --branches --tags --head >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+	} >expect &&
+	git refs list --head B >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
+		echo $(git rev-parse refs/tags/A) refs/tags/A &&
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+	} >expect &&
+	git refs list A B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Backward compatibility with show-ref' '
+	git show-ref >expect&&
+	git refs list >actual&&
+	test_cmp expect actual &&
+
+	git show-ref --branches >expect &&
+	git refs list --branches >actual &&
+	test_cmp expect actual &&
+
+	git show-ref --tags >expect &&
+	git refs list --tags >actual &&
+	test_cmp expect actual &&
+
+	git show-ref --head >expect &&
+	git refs list --head >actual &&
+	test_cmp expect actual &&
+
+	git show-ref --branches --tags --head >expect &&
+	git refs list --branches --tags --head >actual &&
+	test_cmp expect actual &&
+
+	git show-ref B >expect &&
+	git refs list B >actual &&
+	test_cmp expect actual &&
+
+	git show-ref --head B >expect &&
+	git refs list --head B >actual &&
+	test_cmp expect actual &&
+
+	git show-ref A B >expect &&
+	git refs list A B >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.34.1

