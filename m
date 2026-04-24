Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68331280CFB
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042885; cv=none; b=HAeEyrf1JNG9U9ThEGgJi2hVTw3+FfDxJpxobPWO3XlAKMcDQuJEPEqPmmt8WEWPRv84oB32jaUExKNLzaf+4f1C2I/y5WJP0JhFFrcA8rVqYDwr8rQ1WqPCoxHxCHvyfQM8H7GmYD9E8NS7kROFmBca8r97TJBp/x62aJr7BY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042885; c=relaxed/simple;
	bh=zybI3vBkHjddp9qA4zOkYagmVVZI/AnjXPwAHdFPIjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s8wiSUambci1AUsqVQiY/2EiL6P8YGvKB7VCZ0hoajyVXNvE14/P0La8G0OYlvlO8IGwmQxegesYXzMKZrJeTfbqVShJMroFFTlssLfS4S0ov9G1MsYv6OuOwlZjPVx+O0VocIuBaxobeB51d7XqXZ/Sj32e9RqgIYoNguYpboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdcJUtoi; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdcJUtoi"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-42fbf95cca8so2541194fac.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042882; x=1777647682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFpggHaSoj2Tklm9B6rhJzlbpA8+LOPq74rQDTJ796Q=;
        b=OdcJUtoifIfw9bEtnn6KCSX/RfMRGOHaXqBojewTqGlT5gL97PWGRu2j9aKUOCSc/2
         ZTWJk7NXwTxl+itQ0neWQEfTK8eKVXHY+ebk2BYejpSzRrHh6oSm7Ob/6AUo1rUe3cJS
         ZprC6ElxiqzGGG1JXmPR56JIucIDvUKjG/BlpJBGbEtNJjjOZStS1Tu0ETgdCGCVXby7
         LAjJcFOemL+VBWH9W1v8PEUC710nk5uPJ0J/mbCqRLn7QgatioS9QCUSwJHHOgnhO0jM
         ViLpVoO63Mn+FAUZqDrEOAcZ/GZdfjcsyQbyKv5iW0f4n1/mpEr4M6QJ3nLN9vXZGM7t
         W+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042882; x=1777647682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFpggHaSoj2Tklm9B6rhJzlbpA8+LOPq74rQDTJ796Q=;
        b=UnAw62xhihLXcddGL2c0uc0aBbSZixHyvJxRXfn7HrJgbRSpkj+SldpViixQ+19LsF
         kr7qD/zMi6h4xXaZcKSJKwW4aWesiTuPc+AH+5bLuMGoRVFu1mXztvxnSdFBNJ5qOXYg
         1GUkwrpuVVim+bN/QmKRfiXWx+ltElUrIpr0WBr49m4ROhm9gHmgFODfQG7S/ay0ewL4
         MvXfw8R+d0e6/AuaPNE+4claBWRX87nYa+6Mt1Y+AWe+sHj+3xu2bkZy8WOCVQFp0BfD
         5yauleCUD/oyK+dAAnieOEfSBm8cPfd08frTlFbLkTcQZieKbWzQW7IZbIFAzEyPut+p
         40HQ==
X-Gm-Message-State: AOJu0YyqK/q+9G4sAcsp0ajtOn/GFuSkZ4LL2mMgEmOj/JLeeAeORdmq
	kJWYoomwRcGbunMovK79qjLAE5QjLOCk+fgkB+Ez5uMZeNCj6MaoP8uQ01j+ow==
X-Gm-Gg: AeBDiev5v+viqhYM/8VgaVh1eh3W5n2mWcpyoPatsU/TJ0ldGHyq8CGM56oEo3fCphi
	CzSmMDnTZYG9t+yz+VRnTjM0vmdBx5JFFU32lfY+JctRIG27iO30FqSukmCpBlChxVXdOSItcPO
	Z/LM0Rx+jW6iUSNxPZSwOCJZAu52fW3ro67hZvmHRKl3jAI89tc4ExnhOFmwopSIgNu4G6n7+B6
	Fni4JkX+gnuteqgz3ua2KWiFKtJ7ul3hKWtLz5576En2nsP86HI3A2kEyhUlCKdEnYNC3pZLa/m
	OWIAvX9QRK4rVec9zf0oGCtDSyRzKiozoSn2/+wJ8T0jTSFTtwh2NJH+8HDwXffDVFyocug1Zve
	0nggXmGpPgoSlIaey/6Allcx/GcAXLJD2TPa8YW58oMNB388qfmzZvW4lyQMXhICYzBs+cP/q/F
	+9FdyCCkY6aRsmKGwzB9/kK8+rmw0+To77Dly5ug==
X-Received: by 2002:a05:6870:8318:b0:42c:7f40:b1c with SMTP id 586e51a60fabf-42c7f407626mr11282542fac.36.1777042882535;
        Fri, 24 Apr 2026 08:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe8f3csm1947097985a.2.2026.04.24.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:21 -0700 (PDT)
Message-Id: <9c10e72eedc76e03306664b5c979e536a50356e2.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:12 +0000
Subject: [PATCH 3/8] t1300: remove global config settings injected by
 test-lib.sh
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since test-lib.sh now writes `safe.bareRepository=all` to the global
config when `WITH_BREAKING_CHANGES` is in effect, that entry shows
up in `git config --list` output. Tests in t1300 that expect exact
config contents then fail because of this unexpected extra line.

Unlike the working-tree contamination fixed in the preceding
commits, this is not about the file's existence but about its
content leaking into test expectations. Since t1300 does not use
bare repositories, simply remove the injected setting in a
preparatory step.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Assisted-by: Claude Opus 4.6
---
 t/t1300-config.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 128971ee12..11fc976f3a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+# test-lib.sh may have added global config (e.g. safe.bareRepository)
+# that would appear in "git config --list" output and break tests
+# that expect exact config contents.
+test_expect_success 'remove global config from test-lib.sh' '
+	test_might_fail git config --global --unset-all safe.bareRepository
+'
+
 for mode in legacy subcommands
 do
 
-- 
gitgitgadget

