Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EF274FDF
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240390; cv=none; b=kBw/1n4p+RQdV2bDcs9UbWMGPH3QBra3uQvwha5+9vokLYJtqpyi8jljUgPrA37grwtVt+5qbwx27hEy5R3QTwXk+v8OZLbVXIgk0Ow9PGXoNNE1ypySyQkv7DavAe/517ipaRcXOLlto20S7DF6xcT10HZO6AZfMiaUX5RIqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240390; c=relaxed/simple;
	bh=mVDqxnrA9stMyy5NPIHXdJXVrtrVDLfKl1W30WBXTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuWVBHYmqlsB99qwqRDgRUm1FGPvF1V3M7+pJ5dviWzv7m9mAY/die2niuiLtCesR+aoW20dr4pnEdVKjmnE9tRDKtUS2KCas4LtCqcugPzwr7Glu05+055gpCQc2Th714o26Av92LGIs4dqebXdlqkklwTReO5XKatrgZUhGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjGCF+nY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjGCF+nY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso20756575e9.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240386; x=1772845186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY7OyWdJfu/As1yv8ceZN9QSUaLxaTT0/LoK9FUjPL4=;
        b=IjGCF+nYYx2cA57axf38MYXNH82RP1sbYZEJUwzg4qTLyNNuanK1SJiNnlV5a9k1I9
         4CVBRC09qnsLX+VyxzS0a4U3UYYVuTBhC3remNzQpZjXZm8s7e1T29WfaB2Z5bBoIbok
         rdzrW6BQv/b6MmNG1zJ/ogm/K7c/1znHPJupwwXOaPqhSYDEMV79TWHpprIL9oEmz2ps
         FQRBohvvCb6qusAb5h+bhnXx61CcrExboVvfQ9FzEGjJvtjxMaCbEGbRJHi0QGXp5HrR
         iQGEoUpmpRxsSKizBEIHg0pgzXqE/Dzi5NlHrcvqLPbN3dyE/yUwmUg0jDcKPNb4YkyC
         YGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240386; x=1772845186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XY7OyWdJfu/As1yv8ceZN9QSUaLxaTT0/LoK9FUjPL4=;
        b=vIcKmC/VIZ7TxcmZWfrlfahco+5GxWQKCWO29c1edSSIQOGtm44gqh/6qeQ8dZ6pm6
         KvjWL+c/sa2RKsKqelA2RWZew2qIS9zC8dyLj14Onu0pgboO1WbtFAFp40M8C+UWspO8
         NDOU0GUp53bzjES4IKDL1y5CiFu6VtMp50AgVlOKbvfzE0MHVsX35EqJHA1knMDtB7nY
         3AQV7eojQ5buILF3t6InPLLzOOJ80OY1VqNjFCGsR0M0KKBG0QB7iDXNVnUOcsH0OjFB
         JhO2XFTFQnA/qNHGCwsnF+hnWz8/5t3fqFmkMQ6ajSGC3sWr5RBMe/ZJirR6/3vCMPj1
         wWTw==
X-Forwarded-Encrypted: i=1; AJvYcCU2y+KUtzXBqlSo707sV2TAHaf7sk9KT1Z9J44qXxs2MYo1jFPkb3jPGFHbzOEzr4VJm8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75N1nbnzw2sDNHAWQxAmRm6aEFcyiB5LdxBThTlSUHfqRL54E
	WSdxfGl4UNOFY8D2H9NqC9wVAyo3BCX5LyAumfou01XcrB2QCLIMVdI=
X-Gm-Gg: ATEYQzxCyMybc6aA/s+yWpaHUPCSYSSvprI8URG6IQQXRyebN9VgQCR9cS9A6WGaFhP
	J1YiJTxVnefGkXmR0PJNO6qG8Ns+doS9cvwiUwiiT5AaAvbSEpAYCWsqZT2RuAjBzVW3HZCexG/
	lkVxV7tCDaRH7wq4YAcZUNcG76HDvZog8ocm4cRiPwWt+WFpd7Fms3nko9wlNwUDN5SbO2lMHxF
	NEyGS+pJdtM+6ar9KKoTE5VuQoppFFULDn0XIXBD/02YZ0ON0qGp96jhpWyhbiS8SE6vJsvi7UE
	mURgr9IpVpllvXd2OzoND1/xn/Fi9uJwW0VHkehliJi2sEdTOD+tXLd4HGm6jzC5wKuI75PrnS5
	xvzJTsj0hZlQuPgd/Iy0rt7l+NnHRZE1M6WfCaHakyZIBCKn8vqnF+w3z/xOhXoJvQg0ebLw2BP
	GDA7vkNRo6GoqxivQ2VpTSYooWMk3NXkha0zs8fpcQLYCRHInxAlvqEueQWu1jQ4xcx9oZROhm+
	Gceuw54aSwpNljdO8i67nDMDS3YOyDs6weN
X-Received: by 2002:a05:600c:3512:b0:483:80b0:b245 with SMTP id 5b1f17b1804b1-483c9bbc276mr71822515e9.9.1772240386175;
        Fri, 27 Feb 2026 16:59:46 -0800 (PST)
Received: from Mac.lan (93-35-143-163.ip55.fastwebnet.it. [93.35.143.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb87030sm71337415e9.10.2026.02.27.16.59.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 16:59:45 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	francescopaparatto@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com
Subject: [GSoC PATCH v2] t3310: replace test -f/-d with test_path_is_file/test_path_is_dir
Date: Sat, 28 Feb 2026 01:59:39 +0100
Message-ID: <20260228005939.9012-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqv7fioueg.fsf@gitster.g>
References: <xmqqv7fioueg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path assertions with modern helpers that
provide clearer diagnostic messages on failure. When test -f
fails, the output gives no indication of what went wrong.

These instances were found using:

  git grep "test -[efd]" t/

as suggested in the microproject ideas.

Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 597df5ebc0..f0054b0a39 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -260,7 +260,7 @@ test_expect_success 'change notes in z' '
 '
 
 test_expect_success 'cannot do merge w/conflicts when previous merge is unfinished' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should indicate what is wrong
 	test_grep -q "\\.git/NOTES_MERGE_\\* exists" output
@@ -320,7 +320,7 @@ w notes on 1st commit
 EOF
 
 test_expect_success 'can do merge without conflicts even if previous merge is unfinished (x => w)' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&
 	git notes merge x &&
 	verify_notes w &&
 	# Verify that other notes refs has not changed (x and y)
@@ -564,10 +564,10 @@ EOF
 	# NOTES_MERGE_* refs and .git/NOTES_MERGE_* state files must remain
 	git rev-parse --verify NOTES_MERGE_PARTIAL &&
 	git rev-parse --verify NOTES_MERGE_REF &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
-- 
2.52.0

