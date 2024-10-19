Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38013635F
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355693; cv=none; b=rylt5DH3BgZPVlSeYTUQZABqy2liIBvh9NSmFulZvbGototZIrEffNp04gbCuPQti8d/BFlDnJKXFF3MFE9YO5CmS2ZhSO4dCSGDY6OqeHljOXp5na7E2f6G5R5lt0JOEQkDcXT37Ygsn2dJrTOwLpiDHUotAkFaOiqHDHgv2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355693; c=relaxed/simple;
	bh=yLCkGv55iw6HetIf3dhTBkbj+nbBVCRR4GzMNWLAFbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3y+s5P5u9qglQtlROql6UOR4xHBrYNjWK7Y10TMV0GbeyCUrRj54P5ChPhZEkvNShad5/vK/e8ba40oVMDevRZ76EYZzL3M4ePGXvdjddb1YSUMn0YrdgviTSNMl0ZTpczrn7riMKhUumcptAWXesrB82fL/fNFy/n9JAg3OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYqTuM6n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYqTuM6n"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so408107166b.0
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729355690; x=1729960490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAmerYCJVY8NWCU2xtindRXG1WBljQbsJEWKTEKPCgg=;
        b=iYqTuM6nhiM7LJ/q8lNr+M2PcMAnxuV11i7OkkxQ4zBDltzaNh58/Sf99izzPQkbk5
         3cbidUPvI7pnYbwtstE7dOGiCUUq5huWcJ81Vavk2GR3mDZFet2VRZ8yg1ULiAZ94JI4
         bAdxF1Qk8WOshyL2xTECfm1Co42nXs57iDQYzKWy+M2GlsWmOVqymdNo+8BXxkD/piEn
         eqMuelK0B9V2pbVpvkc6cxckPcFaDmE9JZpRMk1F+C2RRxzWbynmlGz3q5YTwfCCU9yQ
         eg7swxK8pcpj0JAaTJD7RDQ+lXb+LW78as8315zbyPELL8O2eWMtGQKwFFsY1T5sgoKV
         QwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355690; x=1729960490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAmerYCJVY8NWCU2xtindRXG1WBljQbsJEWKTEKPCgg=;
        b=oTDOdgLmzl0a3mgrgvP908qOYQxf8GdkNJh8yeCF2asqYerb9Tp8aFY0pMCQ73oahy
         XkePHICydV5w9tnCa1fsHcs6X9RNHFkHwlGp3qfLq5nbPxh9ukzEZ8YS5ItDgjPGLZX2
         PMtvc09Ni6Z2x9SKtV0htuPxqVp+DBMckeZFyq9jqzhqPbQzZFsOH1mQdSWah8xrQEDF
         XWJTAH20wLK67TgM2wYkJg/jK3yyMpKB4ZDnFsadmGM/N0ohT2yG/8JunUx2S+O2Lntt
         2F0e2xT0hl3Vyxd7Edb6hrkgmG/FX+E/ewCUb+J0E4rUkhpElGL9Jseb/12OXjoqhO9U
         eRGQ==
X-Gm-Message-State: AOJu0YxFXC48FwV0+rhFFB0sdGOuBoVbiRfkcEJgR4V9XNX+06MCOGKI
	1HOpw0VyOvpNkUOEFwHqOizRm9QGL0feUxTwlfpGzVLx05YcVCAR5yfcAqkHYbxZR4Ac
X-Google-Smtp-Source: AGHT+IF76f/qfmNv1K7OxMwaSjCRKE03ld/GHrdpVZd/m0fJ+HvG/B6zsuTTfhKAs/LFty0ZOwEmYg==
X-Received: by 2002:a17:907:9303:b0:a9a:67a8:4c0b with SMTP id a640c23a62f3a-a9a69cd3597mr492838766b.60.1729355689564;
        Sat, 19 Oct 2024 09:34:49 -0700 (PDT)
Received: from localhost.localdomain ([154.118.11.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a68a8ec7fsm229286366b.26.2024.10.19.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:34:49 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	kristofferhaugsbakk@fastmail.com,
	me@ttaylorr.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Date: Sat, 19 Oct 2024 17:34:38 +0100
Message-ID: <20241019163439.274656-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the script to conform to the coding standards
outlined in the Git project's documentation. According to the guidelines
in Documentation/CodingGuidelines under "Redirection operators", there
should be no whitespace after redirection operators.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 4adac5acd5..c86abd99bf 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -32,24 +32,24 @@ setup_absent() {
 }
 
 test_absent() {
-	echo "100644 $EMPTY_BLOB 0	1" > expected &&
-	git ls-files --stage 1 > result &&
+	echo "100644 $EMPTY_BLOB 0	1" >expected &&
+	git ls-files --stage 1 >result &&
 	test_cmp expected result &&
 	test ! -f 1
 }
 
 setup_dirty() {
 	git update-index --force-remove 1 &&
-	echo dirty > 1 &&
+	echo dirty >1 &&
 	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_dirty() {
-	echo "100644 $EMPTY_BLOB 0	1" > expected &&
-	git ls-files --stage 1 > result &&
+	echo "100644 $EMPTY_BLOB 0	1" >expected &&
+	git ls-files --stage 1 >result &&
 	test_cmp expected result &&
-	echo dirty > expected
+	echo dirty >expected
 	test_cmp expected 1
 }
 
@@ -59,7 +59,7 @@ test_expect_success 'setup' '
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
 	git update-index --skip-worktree 1 sub/1 &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expect.skip result
 '
 
@@ -86,7 +86,7 @@ test_expect_success 'update-index --remove' '
 	setup_dirty &&
 	git update-index --remove 1 &&
 	test -z "$(git ls-files 1)" &&
-	echo dirty > expected &&
+	echo dirty >expected &&
 	test_cmp expected 1
 '
 
@@ -110,16 +110,16 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
 
-echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
+echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" >expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
-	git diff-index HEAD -- 1 > result &&
+	git diff-index HEAD -- 1 >result &&
 	test_cmp expected result
 '
 
 test_expect_success 'diff-index does not examine skip-worktree dirty entries' '
 	setup_dirty &&
-	git diff-index HEAD -- 1 > result &&
+	git diff-index HEAD -- 1 >result &&
 	test_cmp expected result
 '
 
-- 
2.47.0.86.g15030f9556

