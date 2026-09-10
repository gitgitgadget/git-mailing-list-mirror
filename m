Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526238E11A
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020349; cv=none; b=JyDttb+WreqXw3BHfeTbY1h/KD6G2VaLDupk6gQXkz5/OPF7kccIjXAL8A4brnAVNEPy2AXLgotjsr/anxsjS/1sZ/IIsR/JUKDTsy1PP3R1J2f2bqvD57wBZEfrMKqDoG5ozUWP6akZiTDxichTxWL/GOZSN0h3Hix2Qo0X3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020349; c=relaxed/simple;
	bh=3DFWDpAnmXkMf058iIkQ1dZ0gm0oS3urWEWGzGkWid0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rNnOJjfL7srObpn0bmMjKE+l30P86Gz9338HiqMSqNv8eOXWsIKYp4HLmqbY9ootYXC9z7GZJazxZ/tgsoloi/+4P61cbzFc7mv7dIYxEm3HaZYUhNQkTNSwQ/2OF+fgDdc4XzyE8PDUgT7/jB0c2wUGtkGXiAUKYDu0UYaDLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGhaVRAP; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGhaVRAP"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1158990a91.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020347; x=1789625147; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5O0hpwKbRNHZruElXdPgimyVb/CH4pCBknqYfNNOVSk=;
        b=dGhaVRAPx3Q0dy+n0Mu8SHfKqBK/FJVN3f/zf/GMXMG7GPT4LphtrALj+XER5U8Ezy
         00Z3gCeVTYWCQb8Qw7opro3g66WSY8IERTZsgBO2n/dMc5dUae98csUSKWsztqBiHjaO
         MWE0kbO4+7D8bwm+a+T/MBwLWvPJp+WJXEmXHkPbpasdu/i6Sob5Aedy9g3KbKCfph6b
         8Hvm+V09s2HQOemjqswPT7TeAib1EgHAZOIJsqz7DfGSy9JnhRAiFS4XjA3LPrWEBe0k
         jqBCUyuq50FEk3aJRir216Ibq+A6+BFM9+xFZytmQkJDeHJS7YTofMKsPFk+c8nz1n+o
         +T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020347; x=1789625147;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5O0hpwKbRNHZruElXdPgimyVb/CH4pCBknqYfNNOVSk=;
        b=eUKPObMW+/DqwT91A1VO+1zJIMznQUzc7upveeYA+80Y0s4FR5Z9HuGBRl9EAKsrQq
         XIoZ0BV81mwV7TMa2sT/q1IvJEtgo7dDc62f7FFw1Y6NEsz4eRu7RyxU8dDJOEcV2jxj
         I3nIFWJPFEbwn8HgQtYcvXXyYbNk0j9oERxXDnGvgmjkhLFBdFo/gH2nuuBAp0k09+xB
         zaD2reqFQwvski1Z7SXzU+Wonzgs0dOOIIUXeC3Pi+firzmYDdnAbBllhMdv3G75OBwS
         KkM1tJL1h4qvQiiEriTlQlj7K54MC8spQSjblvYHvbR50f7z9r7UAL+WChrazf7d3IdA
         R76A==
X-Gm-Message-State: AFuF++nFHuSjF5RaIcHGwXwd0NzRdyRg7yG7jgsnuSGE7liT0m2the29
	ihoSMc/za1k2EnD3Wf1W69mIUoxyPTPbNuu7I9ym24e1awxY1xbzel2PHunBRA==
X-Gm-Gg: AYBFou1bZsvR1jh4SZMLgVQcKkUMBZKnLz5Xb+jTPLaokVoQwTRdW+lc4dWySN9tR4z
	p0Zkh708q5NzKtfbkeS4xNWC4nY5CuMG+x30FgzVEUCLROs3zrD/FTb3DKAabppWg3L079Nu87j
	nOwaxT8FFSXw6eiGE299NjBVI+dq3/kUOK895HUYfZ4MvLTiJfYCoTTn2OVFdg5ev3olUd6t1tw
	x82vr5/+3whKxS+swgNJb9mX75or6+TIcj48TkI4Erj/wdVNleAJ87xeX1HyBLQ9Up5YZJaN9FY
	g5Wue57N+vSwxpACjz7+R8q0H9i1xJewEXO16sTxSL8OnS7lgnEN2kwCF9pNo6ep4bkI2bfO//a
	Y+mwGFpvZBZGV4Jnh4TOsroc0TzvfdaPkAEpJ9sZp6DVK2cVvytguNPXYw5lm26CZYTDQpbmz60
	3wBc+lA8cBq5VUFvZaS0vikXWPLPFkYo3kCy+m9O2bDikjHVXcL/z6OaX2M0c7eHjLIAzZdUcf
X-Received: by 2002:a17:90b:3e4d:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39d709e74ffmr9078659a91.4.1789020347500;
        Wed, 09 Sep 2026 23:05:47 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm18656462eec.14.2026.09.09.23.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:47 -0700 (PDT)
Message-Id: <88403ffc9ea5c3cba4c410d80efbbc36becefa0d.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:27 +0000
Subject: [PATCH v4 13/13] t0060: adjust the code style
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

These days, the test cases are less free-form than in the wild old days
of the Git project.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 02906055d3..56faf5fe73 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -602,7 +602,8 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX wor
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
-	test_cmp expect actual'
+	test_cmp expect actual
+'
 
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
 	git config yes.path "%(prefix)/yes" &&
-- 
gitgitgadget
