Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC2DECB1
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946960; cv=none; b=l1Aj/XZS4y1lAPDvUrxPHWxyMG13TLbvoxJIbbkmFo2Igbjv0w0MiXpGU9LVIULq9li3lFCPQAW/lVFXlc5x/RBQu+9KFPVjGpjS4WvMTK5mMWqgd0mk4N3Rv9FO8GNtU9tgEEWPn970ff9p+70HHY/ah+pGi/YyApE0ZT00z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946960; c=relaxed/simple;
	bh=NJLyjStT8CtJY7u3JKMc79pbawme/rAuvso2pNsfeAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gVOrSxMI39aOV4CkWFcrgaq04xKrXHkLNayfqluAqrWB7GZ0jHY588x+UcadS1mYZ0d6oL4MBGqRwKwHgfGc69eMeMyxJr1htf7IZIYG1q1oKim9V70VwsJcHRBxQ59SIVUHAhJWDA8uV4emmQ0tmej7d9ADBGfhJFJZj2SqV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPfwTZ29; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPfwTZ29"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8824ce9812cso20697136d6.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946953; x=1765551753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=hPfwTZ29Jlp72vOJfXX4/ZAxRZ5ngv53g/DlUF8AYNx2m2HO+glWuztJStKe3ED7cP
         opjtmzRiT8ftnAeIT5n7pvpprBT56m1gSx/EACQXNOltM2AUwPirT5ZEopwpLGogqp/K
         aSlPYYF2naIufsrbWpBsrg+u7IgEJdazKxWW/nxKyNeWecHACY6sfK51Lhicc9fmejYN
         1zIEBq7FlUzyrdeCvr25tuWPIWCMV3m15XRnNfM1kM4ChAfoD5tg9DhS8tg2TKnZGpso
         8ZuwqU+NRd4did1iYVk+W97XJmZ9Cm5c57znr9V72/JbxYJd4MKGp9UxUkaCqrSae0EW
         GlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946953; x=1765551753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=TEmCyt0jqDz5InnOddt/fpENUqpE0DHPur5ACyxhxFhp9/Ji3tI33GmPw7DE41qPnB
         muuez2FzsmaJNjGiZFdmmAB0cQ1nIQrvNwDqhFUKF88vAFfFD3MvYOLd6R4Nv1uJW7xZ
         mApfBiTecKU9CUowBv2tJMfvZa96AGrG0BkTEknBsoPjqfyMa8X1QOpHoNe/cUhXgy/k
         inTuuxC1hqWFavjTjsVxlyx74s2Co2QMDE5/bZOi6H0VL5RvxoFLuP4E4xalN8tWQHhV
         n+FC/yM1wfuTP4sAl8+qX/Bk4dZT9EUjlx71EBHlixPXjnrVuPd4HHBl9bRz9ITaZxIy
         vliQ==
X-Gm-Message-State: AOJu0Yw9Y0WYHMXbsO5pY+eUBti73CXFy27qEBXJ8HD9L/D4jKfZm8IS
	zbLeK9I51poXftiuvWnIweCLL27aQolLKykFRvpt1wX2sjwcoN+xLEM/9KagZA==
X-Gm-Gg: ASbGnctVSrO8/Vwv+WLrKVLoqMK/6iSHZlvoYbneddD/PB6opX1AVTm2GW4zI854fJt
	HdwICskJqwonACCbfM1kZ5FsVsaFZHtPb+eODhUq2p36QOsL9PNPFNXzto12+QU1IYDUV3mwqpi
	NSloWXObQJ3KNanabCn7dg5u42Tcicw1Xo+GhKIjtlAUbbRLY9jnFFh73E5kk8DL7ohOHLgkKru
	hOzDOM4yRGqJbPtGclKP/GQ/j7pscSvbsn8zrabSKBgVG4kl8lYlARVjOagHkG0Qs65TPZnvyhH
	TzxU40oTVM4o3WCbIXs2hGriHYUN/wMLN6v0DsM8ImfdDecasKe3QLJ3VbtHLDfOGJNu3OFB/9x
	Ouc7C+XUsVUQRx8i+q+wdcqxqXJYJpkL5vLKzAfx5mIRNb1QsDDg4cVnCmBu4HN+Vj0Ht5Ip7ud
	cxgZL5V0cB2Ya3
X-Google-Smtp-Source: AGHT+IEOMMaKLfGFSjZAF3HCp17P2zBEE3vo6sVxQdFlqN6WB/7ejhHbwtWEPr6whH4p39+MvzlwGA==
X-Received: by 2002:a05:6214:491:b0:87c:20d:6ba with SMTP id 6a1803df08f44-8881953a293mr150715746d6.31.1764946951761;
        Fri, 05 Dec 2025 07:02:31 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888287d6c1fsm36942916d6.44.2025.12.05.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:31 -0800 (PST)
Message-Id: <9639e04ac6208171f6e51077649e82a3be4ac70d.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:19 +0000
Subject: [PATCH v2 04/10] t0001: handle `diff --no-index` gracefully
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

The test case 're-init to move gitdir symlink' wants to compare the
contents of `newdir/.git`, which is a symbolic link pointing to a file.
However, `git diff --no-index`, which is used by `test_cmp` on Windows,
does not resolve symlinks; It shows the symlink _target_ instead (with a
file mode of 120000). That is totally unexpected by the test case, which
as a consequence fails, meaning that it's a bug in the test case itself.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 618da080dc..e4d32bb4d2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -425,7 +425,11 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	case "$GIT_TEST_CMP" in
+	# `git diff --no-index` does not resolve symlinks
+	*--no-index*) cmp expected newdir/.git;;
+	*) test_cmp expected newdir/.git;;
+	esac &&
 	test_cmp expected newdir/here &&
 	test_path_is_dir realgitdir/refs
 '
-- 
gitgitgadget

