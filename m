Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553928;
	b=BoOraTxPds5Dl2AfdV4b2izYSYelnLGIhMVAC2H2941rUkpAvGcfH2pXsEEpOs98pLfE
	 tJgVZbWemnZSWFX16CYX+5h5w369C9v6Hfx1LNcOTaCoa6ozF9LH7anQyrNiwcx4C0zJC
	 YTb3rMy+gm2ewONSvnTGyEf6QrEDjDNiLQ1kOnbZLbe/aRwF5t+8uBfXm/zJMiRgGwBef
	 a9QHUozsao09IWyoFUQ11G2F9MLr/9vSVAp7vj0/8rReE5OLel76BjJSi2TTQ6Y1VAIfm
	 tepzDSounfVMLt948BLGQ51McBdhdVTn3yUP7tMBAJdgQVy+BN5NLcqUzxVxHy/VRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aQWxtREw1svnhLh7N5bhcusQxt4kXbmshZwxCqFOL6s=;
	b=Ge8rY/YjKd7VN3WrJcRRLd32ENeMRcvLB2b1JuAcxBjNiD9tEKVMbunjoWsm3UZV8Y+7
	 qBtQEcEz2i2NV2zsOlcAexZB5OAtAed2TGOwhw3yiJbg7imB//QbIHKWk6EzA1Ww7iWA2
	 Lwf/lcH3miymgBWP/Xa3tWO+8paipaBjFEIGbVnp6JbajK+clhMIkYzmHWVx7c7orPwQ7
	 b7jE2MIUePUYx+JOGvusQnML+U8mE8af9UBtLRv0Q8ZagOCOXCJoM1qs3KfgWo3jJVK3a
	 z8ldFip1inCjhrYNs8VjPBCFzw1+cEDbvjlrAZHPaofuXvo52qCMGHTOyJToKGpb68A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FQO1w5+8;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4952606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4952606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FQO1w5+8
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so205894f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792553926; x=1793158726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQWxtREw1svnhLh7N5bhcusQxt4kXbmshZwxCqFOL6s=;
        b=FQO1w5+84vdoMqCSLNb9yNVCwEZYSJPHsMlhRR89qHb6BDY6hdjQeD0sXDBKkU3ljZ
         CaoTRBfHR9LF70w94F72nj2Ajm9ku10YnS7rx58GQ95xO9056XZmfsPcRCfSigYzYpyL
         neko6z6UQQD4juzVma8NHKCNqQbpgcEWdRlCSjdXOK7xmUGxL7wGDHuzhHRdvT9gPl87
         NrSwXN9o+D0KHbxuMnpAk4dNcp6T2rKMWsWx2LQh/5uHyvg2n0HsOgbvqf/PcOtx4hHF
         rl+9glGv8DBEiuGcOhMSP+cxOIsdM7hfaDwVNX8rWcOS1Q9Xod4fXfPB07PExPwKKHDA
         5YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553926; x=1793158726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQWxtREw1svnhLh7N5bhcusQxt4kXbmshZwxCqFOL6s=;
        b=NJS3PuIsPuqvHi4tyatpBjoqoeaEpJxLECRJmWajecSzss7ybsBEnvPGjrhSc1O+b6
         EhAHaZMdsQx2t4aIWyArAGqo7MPGr4PPVoPjWdA8KpqDEqhxlYSj5LzJR1VqZNdxROPf
         VHs8kCZVJDmJHq8vzB6epmMav/+JJ0lSiLoFZW3fIDWVL+41gHr9/qSJlzhMXiPJE/Lj
         OAIVwVpvd70wWlLdIiuySfPwp4HIwpid3km6aJD6xlKW6nQpJnIyzdRbqgXxSy5w1YBm
         yYud9D5AjMCUASxA6s+CLKiqFcMp5EfhNHxR6hKiqhhxfcXOIGCBdEcl+AEsr9GPiApP
         aJaw==
X-Gm-Message-State: AFq9FYKQ7R0SQOKbpOABebIlN2TvN4Z+gMjpxqSSkFFV7WWxEz7IyLhV
	xqucXHxgV+HbymiSWEXbk6/Tfkz7XTqxqPiHZJST7KPHgyQgp/fo/MjPhJ0C/zdzG9AOSQ==
X-Gm-Gg: AYBFou0tMWhmx8lP7Lbx5Mxb+zUEi/o73o4d8T9Wo1N7qrwGCKRN3U2DAE2MEGvEXky
	/JPxndFU63w1uAb3c4BBRUPXPIHPSaR/XLPJQFYZTw44zmWmVFj/NegOOWIpF+4o3phKHVhhqns
	kr6WFYHBFJopkaNOOpnAw/3zL2IxIKbKMdtBSIIeZKfbR7ObS4uH59/mbqDJgatkTDeHlCPlMhy
	F83MagdGgVYEemV+XlOsOaFAYYfM3OZML7YiE+4YLXGUSjlkCzJJnYUt+xY3K8RVvLpg6BbZOlL
	El31wgWVNyscPwXkuFQJMRo3JJwQPoKtbKyKN07ePfMck4Gjc6sPY6KDDpw/BOvqyK/0mHjwxt+
	qwVRU8C6CffdLOCbvgq67siSBZ+9hOuRxgnbYtaAnJCqST5mpyS55we6GYn/gY6/BCUfm2y3vZ2
	LvbpZX4cWrgWJaHSESK1fuKEP77P2d7ZllS/mxQop6dXZ/UtPVdsRV9o5UVyVnXpe1OxDez9uZr
	rvLmpPz+207SsevMjr/QDIn/2G/60aW0XDBqIUP/yneeYFYTECx/rT6LrR2jf+DHaJXaSSBe0W7
	xDE=
X-Received: by 2002:a05:6000:3106:b0:48d:f14a:9179 with SMTP id ffacd0b85a97d-48e264afb68mr1138026f8f.48.1792553925836;
        Tue, 20 Oct 2026 20:38:45 -0700 (PDT)
Received: from GODS-GIFT.localdomain ([197.211.58.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c6dsm2683305f8f.24.2026.10.20.20.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 20:38:45 -0700 (PDT)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Cynthia Uche <herroyalpriestess@gmail.com>
Subject: [Outreachy PATCH] t2104: avoid suppressing git's exit code
Date: Wed, 21 Oct 2026 04:37:23 +0100
Message-ID: <20261021033723.5265-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the upstream command in a pipeline is lost, so a
crash in 'git ls-files' would go unnoticed. Write the output to a
file and compare that instead.

Signed-off-by: Cynthia Uche <herroyalpriestess@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 7a0778ed98..68a4339e24 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -34,7 +34,8 @@ test_expect_success 'setup' '
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-	git ls-files -t | test_cmp expect.full -
+	git ls-files -t >actual &&
+	test_cmp expect.full actual
 '
 
 test_expect_success 'index is at version 2' '
@@ -43,7 +44,8 @@ test_expect_success 'index is at version 2' '
 
 test_expect_success 'update-index --skip-worktree' '
 	git update-index --skip-worktree 1 sub/1 &&
-	git ls-files -t | test_cmp expect.skip -
+	git ls-files -t >actual &&
+	test_cmp expect.skip actual
 '
 
 test_expect_success 'index is at version 3 after having some skip-worktree entries' '
@@ -51,12 +53,14 @@ test_expect_success 'index is at version 3 after having some skip-worktree entri
 '
 
 test_expect_success 'ls-files -t' '
-	git ls-files -t | test_cmp expect.skip -
+	git ls-files -t >actual &&
+	test_cmp expect.skip actual
 '
 
 test_expect_success 'update-index --no-skip-worktree' '
 	git update-index --no-skip-worktree 1 sub/1 &&
-	git ls-files -t | test_cmp expect.full -
+	git ls-files -t >actual &&
+	test_cmp expect.full actual
 '
 
 test_expect_success 'index version is back to 2 when there is no skip-worktree entry' '
-- 
2.56.GIT

