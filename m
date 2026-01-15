Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2E3C00AD
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499802; cv=none; b=DfXZ9glgYvtliB4Yuq8DBHsiZzz2X3VePCWwsZIhMX6Dg1DQbwJNF09NVVKE9TVtoMd1tX2kIeBPTtmLG0l+CcX8Fi4RTW3mj81GWCzzUQzYDqvVNzYKoc2CdilPLz796JAqozD+ZFmy+lKk6EQb7HTfTOiob/4y+Qaj0NmrTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499802; c=relaxed/simple;
	bh=SjKyR/SKUVNWgik7e6iDzeIlKuY3gMHmY5hRmYUttVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHt81VAtNkGyEkKiLQPtuGt8EHurx/qBb5ngEDEV2uAps3IRrKMI45Ma/AXdHV1ULo/gMh995ZBNfB2pvsgGlMWzFS4wpRovSWWbzLANQ8kxEiTX/7iNAGj964k03YL1jezidHdhtgaLXjUmRuciWMTkepJf55J9rr6B51t95KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dttOa0ea; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dttOa0ea"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a137692691so7671585ad.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768499801; x=1769104601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDaPDPjWJeU9PIkTEX/o84JC6Kc/k74imeycKBD2BY8=;
        b=dttOa0ea0e4djIn4j1PAVqr6tR9ht9g7IeXqq/tNtC84EYUSIApKUPiEM3G3jmtFKj
         AsP31UMjQxUJ4b591F18WqtunVno9fyKknhK6wgMCOPGlGmWxnMFZPxDgqn67eiFDZAb
         0I+n9EIdD+aIjtHW+zmV+N9AdgsDnbWsZOQ76M1vU3xX3cQjrqfvYqtORcEebh+oQRjE
         BlGO7BVR1yANGkvdiBoUDjknxUb1zzSaUxHOCFB6Iypol61wSCFE4lF+D3tasZD8BLEx
         L47AcmlHTA5BJBeNieymyAL6BspccJY37PLW6UVd8N7HdUrcEKUvM9HTPpIXLYQfp+E7
         U6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499801; x=1769104601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDaPDPjWJeU9PIkTEX/o84JC6Kc/k74imeycKBD2BY8=;
        b=S+mZd/BPUww5d0IYg5BRoO1d7CUgp7lHxetPPI+jFIsXFfJgtVkBB9yxTm0Fr+dcjv
         AvPD2zCLSr/Ah/7bI8VHG2vmNzc6ZOnrZdbOmYucJrrWsjecRsJ9pvskHNXygp69ALKd
         vStypWAa9Fg3AbimUd2V2gb5nYH9Ouuh25ZO/RyLZVUu23dk85OjLKCw6nVjvaq1KBQ8
         g3QnfcUJIbYQC5nrPW4Zx2YQv2sX6OvcY7ud4aHY07NnqXGkOq8+CbA1DqLGIhjD/TAk
         TyyV4FM25st4Lv3CXzJ+bOGc9d+rbigc7UnDEYZ55R1QSt2JltsDU++kfhvzlAsd1Lju
         kIMg==
X-Gm-Message-State: AOJu0YyQB965U1TNMWnywiCKyVhw6DZgvZE0OPWE4KxqWXA1XiAC0nlw
	edIArAQVZdG16AtI+iA5iL+V6uXEiiiltBob2ePoGx0DHPiKPjkVXk2AuDfeZQ==
X-Gm-Gg: AY/fxX6JfVJlYvexTAo0iGlO7c1XCZ9lxIwrL8wIJjYMDX4c1U7a0qweCFUpwkqQ1+5
	/Vcozd5U/Xbf3TEpAS1gaBri2JRT6B4cP72C56eMM+3J9kbAazGVB7UgILUGvWJplzOIhT7pQf0
	ZioNy+lpRDKdAFhGnUyWWKlEzja/LxTl/MBPfIa0kj2R1s2Zk8/ojjLubXyDLgJQQPa9lDCohoU
	JhS4EpS/IZq71VOmVta1o9DzN0fJzDMbyV7ZrYQeCHH9PVcx/9CDp0EBCCRSlSyNxV77k8v4Qcg
	mFHUx/VSgVyD6L7aWKtWoA7Fb6dI2x+kKqmBlgqZVxhBDw+XTgLGjRcwtpmN8RvNz8Vl3jelW59
	WbYQosn1YcWcNLcWb77A3CS41xwXhFHQxUBiPSz0165MTEdqFMEtFOMaN5acY1gm+zMTSxJyns/
	afOanDgmI8FWs40IXrg2pyd8CXFnLFebqL
X-Received: by 2002:a17:902:ceca:b0:2a3:e7fe:645e with SMTP id d9443c01a7336-2a71751c614mr2669185ad.1.1768499800736;
        Thu, 15 Jan 2026 09:56:40 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a717a5bac0sm1469955ad.8.2026.01.15.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:56:40 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v3] subtree: validate --prefix against commit in split
Date: Thu, 15 Jan 2026 17:52:26 +0000
Message-ID: <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqh5smdejc.fsf@gitster.g>
References: <xmqqh5smdejc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git subtree split currently validates --prefix against the working tree.
This breaks when splitting an older commit or when the working tree does
not contain the subtree, even though the commit does.

For example:

  git subtree split --prefix=pkg <commit>

fails if pkg was removed later, even though it exists in <commit>.

Fix this by validating the prefix against the specified commit using
git ls-tree instead of the working tree.

Add a test to ensure this behavior does not regress.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  9 +++++++++
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..324ed38148 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -257,6 +257,9 @@ main () {
 		test -e "$arg_prefix" &&
 			die "fatal: prefix '$arg_prefix' already exists."
 		;;
+	split)
+		# checked later against the commit, not the working tree
+		;;
 	*)
 		test -e "$arg_prefix" ||
 			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
@@ -966,6 +969,12 @@ cmd_split () {
 	else
 		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
+
+	# Now validate prefix against the commit, not the working tree
+	if ! git ls-tree -d "$rev" -- "$dir" >/dev/null
+	then
+		die "fatal: '$dir' does not exist in commit $rev"
+	fi
 	repository=""
 	if test "$#" = 2
 	then
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 316dc5269e..e4f632f3af 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -368,6 +368,28 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 	)
 '
 
+test_expect_success 'split works when prefix exists in commit but not in working tree' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+
+		# create subtree
+		mkdir pkg &&
+		echo ok >pkg/file &&
+		git add pkg &&
+		git commit -m "add pkg" &&
+		good=$(git rev-parse HEAD) &&
+
+		# remove it from working tree in later commit
+		git rm -r pkg &&
+		git commit -m "remove pkg" &&
+
+		# must still be able to split using the old commit
+		git subtree split --prefix=pkg "$good" >out &&
+		test -s out
+	)
+'
+
 test_expect_success 'split rejects flags for add' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
-- 
2.43.0

