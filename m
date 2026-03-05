Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C12989B0
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715261; cv=none; b=lsh7n5oyZkKNv33TtcSaEaiM0r++odh8XLtwH+6z8Xan4dw2zLFx9jcTyHzT+0pPkKySJVODH6Bpzo5evzRoVzshrG9e0CPXoejXhiZBr/iRBl6eFGXnU3vawxsHvVgfoKWTox6ltT+odJdBsXV4DIiNACOnL1wFI48n9nGhdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715261; c=relaxed/simple;
	bh=Dj4gdRFzh0hOy7XcuosANh9NJEsSaBxVv96LiSaLzTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3HFphHlD5MYDLhvbBy0EEkAxZoJGBn9DcJ9tNsDsh1qvx2ENuS9EA6qr4IALnjyPRe3UVd47ppZhBspHRBPxPU0vwkThh7/5YR+IWPAr18XfLmjlgbsSmfiTc+5419nqQjNEYusKbmP3E3T6mhwlnAwEjK6+76IFMwsHzBTPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVF8UzWj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVF8UzWj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7393536e53so157461a12.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715259; x=1773320059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKj30UY7GTp/yySEtikodVMIdykfH/VRNpvdw0oIRRk=;
        b=AVF8UzWjdKfgoN795FFP0VmDFieFjmx+pP99LfomB4ZocABzXI5zhbrlteM841J/fn
         nAtw7MhVNcPNQy3SVW+n1FdKtN4eiC1v2FCPr7g4snTcrToJC4r4jQK1DRuPx5OmTjif
         EjYUYlg3ysT6Z3PPHTMgrZlCr/IfKi25hkioxHpJZbfA5mp3reE1ZBj37B2SMPNRphTO
         oBdhSyLakyMjCTuTVWTWnDc1SRdwSy3QgTOE6sF2iuzbUoiNJICmgC/31frLZpc1yO1i
         AwqG27KMUTxDyJtF9U9oON/h65mKD/YQgYt8AfrVpxSzOF776uWd9GAuQZV0JWk1Y2uT
         3rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715259; x=1773320059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKj30UY7GTp/yySEtikodVMIdykfH/VRNpvdw0oIRRk=;
        b=vTWBPlfyQIM09B8fIASBBJc9H3OjJo84GUhB2OiT/yjSg5ONLrtpEmjpIhciDUja8t
         MWRI/UEOGDR3bnWW8f2WnfxSZIf2hLYLA7ynUUu/8P1kZgiBr7AqiY6imvO9CZADnJYf
         Jw/JpWismb+xQeZl2aqdhFtePZICrQD/LLDf9BIdpqSykO9+2dmX7alVDeqn4ymbmntR
         /1vf/Vm09qmEBJtLCwgRC1709vfVCf7SqYyiJ6DofC3VZD7DCrQ5uMV8VpdSdYpe5IRk
         OQ2PJ1VoMGyeg3sx9KiFXIax773eCLAWQrgolvi1eMVSJGEM8sln6iHht8JRQVFc3aHw
         hUNQ==
X-Gm-Message-State: AOJu0YwAwtjEQEqFKiMLvNmxJnBe2Xnkr2xFINNppSkANmOA4jNT9N2j
	B4R7LLyiIX589zOA54q8CbtCgA9hYMcJBv8RRYLepnD4Je9qUTCoSOPNRU+prsY0D4k=
X-Gm-Gg: ATEYQzyVGU7PFkoN/yem7ZRal9vF89tOz5ynFw4oL+9B052o0WbQUS27+y9MIaN2fdZ
	RNHuW9ARPWAW7SDiDJzd9BTeap/jZmam81j/6V9CIKVKEivN2h6XCmPHpAAFHubGQnjyDoi1CYv
	+gw8D4h2pfpvRR9NuToHYSuN1qHitAxhMKxep9cfSphLeZpmET/s8DiyYpqEexxzSPt81eaA76Y
	bQwRY6EBCgb9/DghDGxYo8858uhR/bR0tKV3hFL7tweQZvWMMz72sO9KYq3URFlko+tAkXJoOy6
	V88eBZIv2vXIei1zjMgju+gTX+3k1FQfg+ZCXD83N7afnI8fMm7n5exui7dD3ZNCQWi9wfO3c5s
	jkXU+TbXgzcDRFE/Z/WhHtcvFRokzauPJPwGgnccdWBO1xDjsMqW2dSRlxw3Zh1SIJOCfs0UMCs
	4oQFXWGn8AZSol4Qzh2jdXuJ73cSz5kjLFuu/oWG6fNtWxbBsPUF67uTltWHDrPJx9CBvhrw==
X-Received: by 2002:a17:902:cf07:b0:2ae:6192:8da4 with SMTP id d9443c01a7336-2ae6aa0fd9bmr62480645ad.2.1772715259356;
        Thu, 05 Mar 2026 04:54:19 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:79db:400:2c86:b232:da48:a029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c3b01sm238972465ad.31.2026.03.05.04.54.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Mar 2026 04:54:18 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: avarab@gmail.com,
	normalperson@yhbt.net,
	peff@peff.net,
	gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t9123: use test_when_finished for cleanup
Date: Thu,  5 Mar 2026 18:24:08 +0530
Message-ID: <20260305125408.16958-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the setup logic into a 'test_expect_success' block.
This ensures that the code is properly tracked by the test harness.

Additionally, we use the 'test_when_finished' helper at the start of
the block to ensure that the 'import' directory is removed even if the
test fails.
This is cleaner than the previous manual 'rm -rf import' approach.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
I have kept the SVN setup and the Git SVN initialization in separate
blocks for clarity. Would you prefer these to be combined into a 
single setup block?

 t/t9123-git-svn-rebuild-with-rewriteroot.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index ead404589e..8fa5940abe 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -7,12 +7,15 @@ test_description='git svn respects rewriteRoot during rebuild'
 
 . ./lib-git-svn.sh
 
-mkdir import
-(cd import
-	touch foo
-	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
-)
-rm -rf import
+test_expect_success 'setup svn repository' '
+	test_when_finished "rm -rf import" &&
+	mkdir import &&
+	(
+		cd import &&
+		touch foo &&
+		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
+	)
+	'
 
 test_expect_success 'init, fetch and checkout repository' '
 	git svn init --rewrite-root=http://invalid.invalid/ "$svnrepo" &&
-- 
2.51.2

