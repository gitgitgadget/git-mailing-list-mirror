Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A97329C40
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054480; cv=none; b=bPqmIU5+XN5ALNLW/YldBlmZ78Dwg6PZA4ZU5RJFsioZH7xX5aXeD8RG0g2d5O+8RjzAPi3sY1B2Q+AVVQuC9X3P7pPabjziNVg+GoIrr4muD1T7YM/8wDcFt3efMVrWe0M5SuRx/adZaNlwoafsa7TCPlXDQK2Xm9xoDrF+bHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054480; c=relaxed/simple;
	bh=l2fv5w1rx99zbFO7ezpQTFGh1MkF+eOKEIntWWJoJ0I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SlA+HaFN9oTOGO/1QgJ6PsVBMTBWhGAWwA/GET1mPPdq37VK0pm0be5pGcR+G+1/zsaRz+rkZyBrpss/sUGYN0Nhpcc9S0ZnIMcxEgt2TSedbdsU2+A7BZPngNpK+lhY/qFfYhYuoVsgivFN4ColDD6ljadbbqZsaI59pnDI9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muzVnPGc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muzVnPGc"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51a868b6962so2137081cf.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054470; x=1783659270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiAmM3pttDX18SRiSdUkVjzvqVOqJ1SGEU4OnMt0mw8=;
        b=muzVnPGcGq73lbnGFTxc1GILd3l4vNhXbS4Pf0D4ou07CsEP/y3gJU3JHWH/s6okWg
         Z8BjKhn4eUihb5ENUglQl1oVgPYk+Oh8Ou3EnX3hbW3UNZ4T6LR7/PfVH24KKS6D24m/
         007z1CsJk2YirpOyeLXRlIm43uMhe66Suljdkd9OOqidm3Q7rjZBZRhAy/bwbq3mFHdh
         17AbYAgHfLeAXOorRWe0lp62z0zpFvak4LJiMDCteEDMAIB7HRiseVfQ3leJw717FxZl
         YlN87jSzKsEziUN3dHd8x+vwK912T4QBtZCfpoOgLpj3tr88PeXdnCXUM0MJFaen8N+c
         wCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054470; x=1783659270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiAmM3pttDX18SRiSdUkVjzvqVOqJ1SGEU4OnMt0mw8=;
        b=NSxhZL7Eid3DPL9EfiM32Sc9GEwwpKyUC8+nn2gYPfdnTv5Gr/7KFLevkCSdIZUOxQ
         4cOIpeLzZzS+KQGWbTPprYN3qnrZe+SqNh4pBLfpGLBlkdL50kedoinDIdwt3VtLh3g3
         8ndS2bG6amBvUXnVVJftVHe+v8KWtDoP5/gcTeRc7DOQdbHROi9MNsIdszqfPV7JUzop
         6w0HZ6PcIQkwfhL0+mAXGYm5WElbPyR5hQ4kvJCFA/f3LY43fqiGfXc+gFgvpTbnQk0V
         CttymdTDmDSOeSgbqX2u/u2tVhQv2YdU8gKp+MyiCW23AkacnLH2YXWVSJr7D0gNr1qf
         p0Gw==
X-Gm-Message-State: AOJu0YyUFmfwc4w+k8PQBVyVOoo1eGhADj9fksrxDAIaDrMgXIPcyXRM
	V3vO2obV/w0g5da+wd/b8a9EnlCbHe7FDUK+vcdOlUy/eb5HnV/HaixsvgwVNw==
X-Gm-Gg: AfdE7cn/BEHWscra7lFVaUSG34OWhyzujEKQDzv3+COK8wME8fA4dtr6HcRUJabtCP1
	rsHpyp82xb7udM1hSDAW9z5IxE+UfFTTE8rPmOxeOGv2u2dEZwzeOwCklZEs2tMinMklcUynaZ7
	J4umb4u7ArJyI1G6rhHzPtVNew48whAjmkF/QmHwzNGzBaFXSpCZBh9LfM9Uq4CdLzTMNTcboMz
	CQucWSrd3/KtIEhHqq4p4P1N/VNf2cQE34FE9SFcArDU8Wde+auQxSw63GJoj04X/05AIoCQcQK
	0E4LChqWpfxXJ+3/UMWf9cQtb/hdhUqned4sCJCSqtpfDHJ+tj1P+8iosx3zWhp7pSnvPoDElbn
	hyjLPHnpP8Ag8VLD6wREUi/M9sfseinmT8/+a+EXTth2nRKcg+0p8fxAVWu5t9EYQqIr/we0Ih2
	JRPyKg8xuTU3cs/KY=
X-Received: by 2002:ac8:7e94:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c26af015bmr106818421cf.35.1783054470099;
        Thu, 02 Jul 2026 21:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2cf18sm8068591cf.14.2026.07.02.21.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:54:29 -0700 (PDT)
Message-Id: <ec6b478c4ce0da2c963c4cee4eacde50d3d877cc.1783054466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jul 2026 04:54:20 +0000
Subject: [PATCH v3 1/6] t/README: document test_grep helper
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

test_grep is a wrapper around grep for test assertions that prints
the file contents on failure for easier debugging.  It also accepts
'!' as its first argument for negation, which preserves the
diagnostic output that '! test_grep' would suppress.

Despite being widely used (and the preferred replacement for bare
grep in assertions), test_grep has no entry in t/README alongside
the other documented helpers like test_cmp and test_line_count.
Add one.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/README | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/README b/t/README
index 085921be4b..928331fc7d 100644
--- a/t/README
+++ b/t/README
@@ -1039,6 +1039,32 @@ see test-lib-functions.sh for the full list and their options.
 
    Check whether a file has the length it is expected to.
 
+ - test_grep [!] [<grep-options>] <pattern> <file>
+
+   Check whether <file> contains a line matching <pattern>, or
+   with '!' that no line matches.  Use this instead of bare
+   'grep <pattern> <file>' in test assertions.  On failure,
+   test_grep prints the contents of <file> for easier debugging,
+   whereas a bare 'grep' would fail silently.
+
+   For negation, pass '!' as the first argument:
+
+	test_grep ! "^diff --git" actual
+
+   Do not negate by writing '! test_grep', as that suppresses the
+   diagnostic output.
+
+   test_grep should only be used as a test assertion.  When grep
+   is used as a data filter (e.g. 'grep -v "^index" actual >filtered')
+   or inside a command substitution (e.g. '$(grep -c ...)'), plain
+   'grep' is the right choice because the exit code is not the
+   assertion itself.
+
+   test_grep requires <file> to exist and will BUG otherwise.
+   When a file's presence is conditional (a backend-specific
+   file, or a path that only exists on some platforms, such as
+   an NTFS 8.3 short name), keep a plain guarded 'grep' instead.
+
  - test_path_is_file <path>
    test_path_is_dir <path>
    test_path_is_missing <path>
-- 
gitgitgadget

