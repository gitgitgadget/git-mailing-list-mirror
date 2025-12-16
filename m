Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3334DB5C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885594; cv=none; b=D8aMMBu9C24Vmcw/HNPo+iXF0ccBua53HVjCOacodAokT9DXYeAoXQHTqvQ4CfFtXXfz4S1XuUxIRF02Vtbgif+fu61kIygE17UTqeLGmgPO5+yOJIcbQJmhsxtSiNR49r6X/o3JDVC67/j6VTVCCmlDR2EsWHlA/UdlBk77zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885594; c=relaxed/simple;
	bh=miKtS8gVeLBQxEb1qhafBvJeGFIR8q5A5wiQrIWCScE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZZdOUYwq3Gxvb6NtBsj6bfE/4ougzCJJR3u7lTFzQbqQ//Q1zcsUKaUJJiuErfqJoo/qhv812QtwDg8MLUAK/4XJIUCPuPkUv8pG5lqBYU+UfmosE3e4PmuRrzOo+9GEwnNEQcMh2nPLx+0qi8Cj4AnOroDlNqswzjzkLxr0pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV6WeFNA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV6WeFNA"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso4522460b3a.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885591; x=1766490391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=OV6WeFNA/3O9clyU8pIACuBS96el5kd3ped+Cxblk0MSHz4RMgK8gJiu1mIRiLywej
         LCg8GqvcAoMrdgziQ9VuckopHMLa9JcAdhIvi4qxT8L2EZX3yzrHv8XjpLQjIomcURsA
         aMAa5LSpg1aSDCkqfOBCCdwyThvLpAx5SUebCBIQ2ObcGL+Lh7WaiGzWEANXn1YML9u9
         yyjUVRkSc23cU0dS8tgEZMESqJEsyf4GA7KR/tCMeKEUykExHL0cdij41dFhjuRy1I+N
         RMW5LWpFYpW9HxpuL9dymWZUhBeHF76wY5wM2bzJPYCx6Wf+FoyMJHl1T/t2Sb24Esrj
         ggGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885591; x=1766490391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=mkM1P7LMxJ7sWMNm8JfzxO+I6Gxefbb6XI/hIRTKLDZFPgmQGGJ7sgX1K9me7VK07c
         HrwO4x92sTKR3Lkrd3EP0ciwCb8HkqcJwi2fuFOoAX3MRsXupOnj8lg/Jxd5lWXqogBs
         cM6TrVRo45ASR2wZYyE+VOLEgvKhIpAvZRXDdZIOq0cVs3NNRTPoQG44VSFyamU/uvVj
         0Nf8A3Y+66djEbrp98cJRSH/9uNfUqAnYutAI/QBrez45dH36xh6I32lMfSs0/DFoodl
         cEeebF4Igmwb3pa+KZrh/ZSdRKgQlU39+RtZt5PQGEQ9Z4tjhJ+GxNx6yxcQTCTcUDlU
         NYnA==
X-Gm-Message-State: AOJu0YzFZxFo1NUOmkXr/bXaFmHyMI117srywyY456v+emRLom4egN4v
	h1KtV+23k5RpVsF3MLl7hdiQIqxSoprI1DA8ZIRIo3uVXKuHliPYu6oMKvyV3A==
X-Gm-Gg: AY/fxX6v7zn36FtXbu5fBsADMqhfTsjOiuN+WvNZKT0/l5dz5nmsUZ+XJkkcXPUv9IR
	Nt/cHkHzW8GO+hJ5b3eTbZYUT1KuZ2UUvDuAUWdAkNPRJzaagzi92YDLQsPIHDYMVegYokiTWPi
	9PKDjU8Cv2kj15bropSPT4/SiBQQroaP4nhqsSFNKE2CNkyf2rwlE9ljEPX564wmgPuEUgf1fp5
	ZeQRch9DiK04vVbfBr2MLkCsak/6MkEDwjFmcwItJ113Y8YMwqLImtLJL0+SWnRaY9BA1EtaYGA
	A5UqOhE2OBdrSvUqxKvcQzG9j9t0efb3ptT/jrc/oaRxap28Y10chd26ORijMIDk7BD3UCTmdnf
	Vzyn6A63/SLyhCDdY63YmExVC/s8a2yX+/UuopUXQ2xKOBXB0X6J8r6WNyhYIqhRpnUQxLLqbt9
	jhozJr8Gzzhd8K
X-Google-Smtp-Source: AGHT+IFeTK0EGn/ukYaccraNpS0x4kkjq9lGzBYcmWRch+bKLOprqI5/RYODRnnTq7Kpz2ixOriFjw==
X-Received: by 2002:a05:7022:170a:b0:11f:1500:4e9a with SMTP id a92af1059eb24-11f34bfaf61mr8071164c88.32.1765885591304;
        Tue, 16 Dec 2025 03:46:31 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f392500cdsm35366492c88.7.2025.12.16.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:30 -0800 (PST)
Message-Id: <4ab6aaf2cf20d2508ae5a816ec7932c8e9c4e639.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:16 +0000
Subject: [PATCH v3 09/10] t6423: introduce Windows-specific handling for
 symlinking to /dev/null
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

The device `/dev/null` does not exist on Windows, it's called `NUL`
there. Calling `ln -s /dev/null my-symlink` in a symlink-enabled MSYS2
Bash will therefore literally link to a file or directory called `null`
that is supposed to be in the current drive's top-level `dev` directory.
Which typically does not exist.

The test, however, really wants the created symbolic link to point to
the NUL device. Let's instead use the `mklink` utility on Windows to
perform that job, and keep using `ln -s /dev/null <target>` on
non-Windows platforms.

While at it, add the missing `SYMLINKS` prereq because this test _still_
would not pass on Windows before support for symbolic links is
upstreamed from Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6423-merge-rename-directories.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 533ac85dc8..53535a8ebf 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5158,13 +5158,18 @@ test_setup_12m () {
 		git switch B &&
 		git rm dir/subdir/file &&
 		mkdir dir &&
-		ln -s /dev/null dir/subdir &&
+		if test_have_prereq MINGW
+		then
+			cmd //c 'mklink dir\subdir NUL'
+		else
+			ln -s /dev/null dir/subdir
+		fi &&
 		git add . &&
 		git commit -m "B"
 	)
 }
 
-test_expect_success '12m: Change parent of renamed-dir to symlink on other side' '
+test_expect_success SYMLINKS '12m: Change parent of renamed-dir to symlink on other side' '
 	test_setup_12m &&
 	(
 		cd 12m &&
-- 
gitgitgadget

