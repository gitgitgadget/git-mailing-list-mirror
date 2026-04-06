Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54956336896
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482052; cv=none; b=t02vCF4FdW1LN4L+A4VFp85HFYTGLnuIE7mK/gukrbY6bUwYmLeEX6ZWqBQy0wB/QAJ/IHAUlxzlpjYatxmEHzhFrRz4Ouxlnses+Yg5rLvfYlVgWzDAI7VFw9n4YFchsxeARY1EIaTUR69weAa0/tC81HJ0aTyKC8EMcgOpTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482052; c=relaxed/simple;
	bh=BpHiN4HMoy5rWTZh9GKIZEJ/vYL85UJyhhpDqpWoe/I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=F8CHhLB1LMCwr+0Ylr7SpVTMlq2bDav9oFWgce5FiZzOgW9jUu4D64qoyoGmVe3c27mIFh0Z1rtO1jZZGePygkE8uuQ5HQAz9qDOX8KIlvoIi1nYijAhKiJ9h7V8hDGyJ3NHHVgXhsteLXetVisTf1vWME8lKH2YJlY/590eiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csVQhV6r; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csVQhV6r"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d68bcf50fdso168057085a.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482050; x=1776086850; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nCwChT9Cm2Hm7m88y+CfbzGEJ0bG41vbk4/Li8i6r0k=;
        b=csVQhV6rseTXQkralDDw6PriJduyPvq8iyLXN5FKJcookt5LxyLAExVoB9Sj/gDX2N
         Lg7AZcrivRPHmNE2tHysfly8S1z/dpciXyM1AVx3MvOvhNTQZplqrM/jTXvtttFgNNdN
         GQJR4lKUtBSCmxRvVlatBv1roLf4du2uybyMFhGTeCvhHPGa2e1Rj2+amT2dOGwdqG/y
         Do7sqa4zUaDZ+rfGiJAD2aw6f16bEzsjw/mF3HuzQDSR+RY8CUuaIfXn60L4bEHkL6N0
         Xup2mPR0DCZIYDEB+CgrLzMm2uUUESlUZPKiXKi/NBLbdw0eDbnraX4yQr+HHvOaKorU
         OScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482050; x=1776086850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCwChT9Cm2Hm7m88y+CfbzGEJ0bG41vbk4/Li8i6r0k=;
        b=qbyBijK1TxDKj2FyJnOzuRKl4VVNWxJXVgH+jfQlxqUX9l8SHt730w1XGTMwmrmsbw
         9iXB/vQz295MFYJEYBVuE+bAqhJ/SiV3RWGCM8C0jsWt2J/G7I8s+3GEz19NlNCSR1nk
         E3R/0lukOsxhikZBs127mu0Xub3Yy0+S0TAyINDarW4UucvHkaNSPD+pwAgw9LdMmkeA
         X2/+biNS3pt81bwYhuwLG4A5V6fIb0aGTuUOb5xLFXZRCzzRWZza7bs/diA7HoAiWkka
         pxVvQDX/W9YaSzjBXyonVfDlikO4oyJAAStR2D7g0+ShvJk/pkSOCW34Oztu3NdyXfzY
         nmnQ==
X-Gm-Message-State: AOJu0YzwKvnycDe6clSXIZDQ0vXkbNt8cPh1nCr7wg172BF4sbuaGdJW
	cy3DsWGQR87hQl+su1mrVQUyMPLhDCDHvLSopBHXXPyc62ViKgeh3jISlI/Xjeoe
X-Gm-Gg: AeBDieveANJAXqb788mCs0unAjHGtF0aVjtndGYOdIp6u6h3ruH8nG3nJLZ+xGHjQ5v
	2RLDvjm7M/fOfELapE8sEbP2d3Dd0xf4mhOFEAcMlECaAV7oKPsyz+tzRGmm7OHXiJSAGZb4A7d
	BbH0wPdjIi7PYbY22iR/7xe26+ouA8OXIzADT8f/tPVDXt3y6n9OzbrLnZEVziZhLwB8vQ//zfG
	Pwh/eVXvLbHRtzSEXcTvbza2zkhRvYfaij3pS6ykJMadWL3jTo285fE62u3B7OOL4Rlsuxb/quP
	awO2Awyrb7Lyk1O1HeuBOGGJeG/YF8BVF9p+sC6U6k0JWxZPYoIXL8mND607Aw8n1gfqdpAcF6m
	Qu15WljQ74WrHdemk1kaMz6em0cLVn32ONwebroBh+bAY4sOqzF4PKURRkAnH0o4exigFTQ/jb8
	MIf/j83LEwq/DNuNH3igxHLeSF0I4=
X-Received: by 2002:a05:620a:c4e:b0:8cf:d65d:adbc with SMTP id af79cd13be357-8d41c2bae71mr1786598885a.16.1775482049744;
        Mon, 06 Apr 2026 06:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8647b4esm1072730485a.32.2026.04.06.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:27:29 -0700 (PDT)
Message-Id: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 13:27:25 +0000
Subject: [PATCH 0/3] rev-list: use merge-base --independent algorithm when possible
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
Cc: gitster@pobox.com,
    j6t@kdbg.org,
    Derrick Stolee <stolee@gmail.com>

The --maximal-only option was added to git rev-list in b4e8f60a3c (revision:
add --maximal-only option, 2026-01-22) and the discussion [1] included talks
of how 'git rev-list --maximal-only <refs>' acts the same as 'git merge-base
--independent <refs>' assuming that no other walk modifiers are provided to
the revision walk. And with those assumptions, the merge-base algorithm can
be faster if the refs have most of their history shared.

[1]
https://lore.kernel.org/git/pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com/

This series updates the revision walk to use the merge-base algorithm when
possible. This checks the rev_info struct for options that cause the walk to
be different and also looks for negative references. If none of these
appear, then the merge-base algorithm is used instead.

The series is broken into three patches that could theoretically be squashed
into a single patch.

 1. The first demonstrates the equivalence of these two commands via some
    tests.
 2. The second creates a performance test and documents the current
    behavior.
 3. The third updates the implementation and demonstrates the improvement in
    the case of no walk modifiers.

Thanks, -Stolee

Derrick Stolee (3):
  t6600: test --maximal-only and --independent
  p6011: add perf test for rev-list --maximal-only
  rev-list: use reduce_heads() for --maximal-only

 builtin/rev-list.c               | 59 ++++++++++++++++++++++++++++++++
 t/perf/p6011-rev-list-maximal.sh | 29 ++++++++++++++++
 t/t6000-rev-list-misc.sh         | 31 +++++++++++++++++
 t/t6600-test-reach.sh            | 45 ++++++++++++++++++++++++
 4 files changed, 164 insertions(+)
 create mode 100755 t/perf/p6011-rev-list-maximal.sh


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2082%2Fderrickstolee%2Fmaximal-faster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2082/derrickstolee/maximal-faster-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2082
-- 
gitgitgadget
