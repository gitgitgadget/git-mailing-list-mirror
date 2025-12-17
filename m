Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE07369960
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981141; cv=none; b=bjvPwu73TzzeE/7++gWAwX2RSl6gDPwKUxCx0cRHunDGsMJFWcbp1HQaMC4XNOkLqErkrZH1f8bVJ/5qGD/80Oi8pkvWJBicZFozMajsQSIbMQVY9L93HH8WuRyOLOSHrx4ljLOslNU7IJ0ds3e1S6DVhjwJo0vHC+mZbeUUYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981141; c=relaxed/simple;
	bh=oZaLOTVlbZaMMOUyojkmt0fzh178aFUpiYBxAZ6RFmA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kFNbfQCxjAqsAftPL9tAjcYuqrO9ViM/2NCYF1PtCr02ttiS5k2b6CBLfLV0ModR+yceDCHkKMHVT8j2IM+tcwMkvVRQLZwRr0qocdxZFpW/7PnDnus40pD6ejrcMWMcboM6SjfJdy0EplpOlnJvjKpse10UUmcRFcaiCMIeitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpmjykGg; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpmjykGg"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75a5cb752so4062421a34.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981135; x=1766585935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF0/9k7+5kiugSM7dWVf98N8rbcXlJUxQ7z66V8dGag=;
        b=BpmjykGgCWJmZ9xmqAzIVpqdkTda41sVuZuLmK1XA5/8ez7YauHCclIRWXyY7brmZT
         91qIzGOYr8zgGmqu7qcOHpTjptgz1vJ6vtXYSvnUXfA0QjeDh9FcSkpw369fRTUPvfyz
         S+0I7RdpJpYu2ox5L+6ey0sR790yFXdtHdTD3x29igtCHRr3j5mt5IR2prZ5/wrivE6e
         7bAZYVMm8qKTG0DgtbnPIdeWFNZ64aUwbGDjmVOn1wVS1uyp8RgkOu6yoQvEvsLG7KJZ
         S5Y3EidLWxutHjncS/DDvq5wU4Yki3H5vhT6Jdwf/8OxrpxoLe2lOtvc2smGyPPPqqar
         W/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981135; x=1766585935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zF0/9k7+5kiugSM7dWVf98N8rbcXlJUxQ7z66V8dGag=;
        b=j6vnBqXDF2uqMayggVHzczUjcqZTICZdUj7HRZpEJCpB1Ac7PzIn/N3c/Nbns4hxL0
         d1TW4Ajqd/u15kC4ImZCx2hO33kGwMgV1bsfZT20pgq5rHZKGY4c6EXJmCjkqz30fcnb
         LgTVlf7yXUco10Mj4EuQ5fh4iYsgOWOXd6VhZvyHbjEWpd/1R7omXtkuS/khtsz9B+sa
         ZLlJDYCms4X3dLhx8jkZwEJWbn+ovENe6egPvDEk9CTApozSdfO6/erF7Y01IMpXbynl
         R2lZtI1LUiF4BOwPPVwBAzMK3CBbUeVpvQXDoiGwgCUCRhf4wQnpjDeY5NiYxJ0K0MaB
         uLCA==
X-Gm-Message-State: AOJu0Ywn6LUpSNaaGCgVcr+rSze6LQIDrN6v3WwuNXvTHEGLfawPHQCn
	sMuV33KlUuagV9890emU9xZVnyenObR7aWKVSHLD1Xou5HTHiiQLJMu38KSZsmw4IYqONw==
X-Gm-Gg: AY/fxX4eurzL9wjfg0Gfgr/zfFsOCqZ+PjyToIJ8xRBIPTBs1ffQaXjhwXaHvu9uF7h
	ZChMVFwBBUIvQ8CWqw6s71RA8rdAHibKHRn0i7/0E8cysSx86zqjJFW6ecBGSEc2tEQ0Vpy5vf/
	vXD4ozwrWsPWhmu7+ATsZjiD7SeHtLiOnSs1lal6ykWyJmNE232WEdqtrvlCVAZdD6Tx779pkr3
	R3tTkBVP3YScBGE3aNJ2RLa342IoUG23m1XmgYiKUG/If0TnxzcQzk6pFueGlYraMNdX5eA28S/
	jMkhwNWFFUtYnPGrO/ZqC/QRzFgmPpq3j4144gRMQV08F85ZmGpYwD4gFr8+2pMcIny+A9VbWU3
	m/X96LLb5EI4iRBd0QQKb5MWTFXvmaMx5g0JwAY9qXDhPRJher3aRjneR5ZmSvfQJKmWaMWpMHA
	U4Ac5jR1mkv+nz
X-Google-Smtp-Source: AGHT+IGCsaC6Of8RdZFolFgH1Nvzp9gw3j8zRtBEN+MTzW7FOe4C8GBC/3CuQMefaUJbTYYsFLq0Rg==
X-Received: by 2002:a05:6830:6e52:b0:7b2:aba7:f4e with SMTP id 46e09a7af769-7cae82f3a9bmr8510261a34.10.1765981135562;
        Wed, 17 Dec 2025 06:18:55 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1ff3dasm3888051a34.11.2025.12.17.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:55 -0800 (PST)
Message-Id: <7b233c2d406d1aa3bc9bfd4d084c6e5dba481b47.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:42 +0000
Subject: [PATCH v4 06/10] t0600: fix incomplete prerequisite for a test case
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The 'symref transaction supports symlinks' test case is guarded by the
`SYMLINK` prerequisite because `core.prefersymlinkrefs = true` requires
symbolic links to be supported.

However, the `preferSymlinkRefs` feature is not supported on Windows,
therefore this test case needs the `MINGW` prerequisite, too.

There's a couple more cases where we set this config key:

  - In a subsequent test in t0600, but there we explicitly set it to
    "false". So this would naturally be supported by Windows.

  - In t7201 we set the value to `yes`, but we never verify that the
    written reference is a symbolic link in the first place. I guess
    that we could rather remove setting the configuration value here, as
    we are about to deprecate support for symrefs via symbolic links in
    the first place. But that's certainly outside of the scope of this
    patch.

  - In t9903 we do the same, but likewise, we don't check whether the
    written file is a symbolic link.

Therefore this seems to be the only instance where the tests actually
need to be adapted.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0600-reffiles-backend.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index b11126ed47..74bfa2e9ba 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -467,7 +467,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
-test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+test_expect_success SYMLINKS,!MINGW 'symref transaction supports symlinks' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
 	git update-ref refs/heads/new @ &&
 	test_config core.prefersymlinkrefs true &&
-- 
gitgitgadget

