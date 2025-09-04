Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC99301016
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992180; cv=none; b=O+BIR267AfpOtjPxRVTTfCcsG7UGhdp4/2KCwI7KKmb+OMBfG6lW2ry/XRF94VtC4K0RzlsaeJE4XkvqC8AGN+IwY9GPMdL3SufOkQj0xcCHD9bMDbnEaL1CUfiqxLWjBV4Y4Jow9EXfZ4gYZQGRT25jk7DpFFEcI6Z15TXVKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992180; c=relaxed/simple;
	bh=PinyLMWA0UMyg+ogPJCxwJenLWF4lkTw1utx/vKDyAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxyX+cXBf2NThTf/n2PefyzRVCKfwYwIMuDLjtNgRGGo2LxDLiK4qYiaObtWXFvOgK+8JNUaYGicX9BdffPGctVRvaGO6tMWGNd8HD6L3pjBg2qYZFiQg88cOWjkuabNQd1eb+h4rYbi29e0u8ITgji4/HoIflU98+MmCTqa6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTYoJCZi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTYoJCZi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e249a4d605so317805f8f.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992177; x=1757596977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bopsx0aTlycznprcnSAfMhQgBMwgzDBPvcl6Ril0uZU=;
        b=eTYoJCZiwOTL86jQ/TKpP1uhpc86veANj+pFYSQOSnuX4Nt97z2xuJwBD4kKHkwF+p
         YH7AbV/rMCVIJzVsTaXA4pVCATO3e9xTBcUYo61XPyHp2gjEcYZX3Cx+hO0FvzSvMWrX
         VywJvl+RkbS8IVJapwaHyX3SS3uXuDC9RMmZ6kVgQls3rb4+4IK7DC5kd4DWVoOmpNg/
         btBSBlT/s8eg/v6T7mBO5dm7YhfrGge7cVLlyAqfsJOOhFjPSM4Jz8GfvMcJKms2PujS
         toA7G4zajbmfD2PGMBxX+wEy5eR9nwC2Q1xuxEMhDlTX9dWuh56InVzpp7D9EBy6nD2Y
         2D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992177; x=1757596977;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bopsx0aTlycznprcnSAfMhQgBMwgzDBPvcl6Ril0uZU=;
        b=b0NVcy3YbmiScHDRHT3YkFa4hkli6rO4fxnp3txly82KLH9JifG+wNtklBsLrhLFxv
         n2CMr6eWPRDw5tmBcICP3G+HNjGGrO8q4qW/tQAI6zSGHEkiIcy2iqTcLeQPUu0E87n0
         tCafCylHG6pbYfceaV5Gxgp8+a1wCVDTtqtaKE0Ee9iuqLRJ73SRfcnWohf10ncPexdt
         uBE6djbBydirjcwQ695v2linIDLI4Vmfwo+ZK4zFps7X45dM3aMHEP9J1NFtf56CSucf
         vEeSzo0uephgvz2Zvf6aGKGHHYpePgm0g/lC6Pn/G4yOq6IHgIRZvSs1ExnlvMBP10Xl
         ciqw==
X-Gm-Message-State: AOJu0YxDGHB2Cxc8+5hroI+nXwntDT7MBiWtlWhXKW+fkpZB2PEwkhA6
	TbHuon5uUTIAI2vSfWyahH1GtjlLW/7hJWjDXJzCtcxDC4f6zZZAYBMCKa/Enw==
X-Gm-Gg: ASbGnct7GcS1tVJARg+ABQmL3GDAOCHL4j1p3uH3M1VhczeZjMK89jlU2/ZfV4QdyHf
	SqpRIQffxHbryn+O69klpGBBm5/ouAvOOGGk+XIHpQl1fC4aAFFu+y3/OjEfq+V6ENpCd0E+Bjs
	wLk0LEX1dtgETjhRpedgTZS66xX+Yf+3EY69NFD9AU/+BIuUnUu5+MIYDHvcgRMhiOFh0CJHhay
	h2C6R94LW0BmyFNCGOi6ZjsjMcGzV7j9twOefIv+LBlmb0ScGJrUrbJTcpjzZzQjUv0fx0mGm/V
	2ifVi1hsjJkJAEnkRUaOu95GKAV/mgsDtyA2rorgwM6W9kPBUMgj0jm0AQHiPk4bYF9SXopXgSg
	EMewuX3SraSrbdWKeN432po7K/M3/T+1j18YVYkypDxELkmdrrerqL/PeXw==
X-Google-Smtp-Source: AGHT+IHqJJryBekv9yVJwgIHo1SEz27OA9rmLRx4EGtpkGClWAVy8BuRV4LyISK6esS/RSmC2o59hg==
X-Received: by 2002:a5d:5d02:0:b0:3d5:55c9:f210 with SMTP id ffacd0b85a97d-3d555c9f811mr13469115f8f.40.1756992177012;
        Thu, 04 Sep 2025 06:22:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm28278985f8f.26.2025.09.04.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:22:56 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/4] t9902: switch default branch name to main
Date: Thu,  4 Sep 2025 14:21:31 +0100
Message-ID: <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756992089.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1756992089.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
main" in our test suite. We have slowly been removing these ever since
we started to switch the default branch name used in tests to "main".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6650d33fba6..964e1f15693 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -11,9 +11,9 @@ test_description='test bash completion'
 # untraceable with such ancient Bash versions.
 test_untraceable=UnfortunatelyYes
 
-# Override environment and always use master for the default initial branch
+# Override environment and always use main for the default initial branch
 # name for these tests, so that rev completion candidates are as expected.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
@@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
 		HEAD Z
 		final Z
 		initial Z
-		master Z
+		main Z
 		EOF
 	)
 '
-- 
2.49.0.897.gfad3eb7d210

