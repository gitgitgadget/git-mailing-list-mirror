Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202626E622
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895885; cv=none; b=sdgcF/LwO3B45QU+lq+xaG/b8kzmFqQi7Ce7142Dh4ueazQmQ+4sA0PTLauNlRs1gvPyUsj1mdnkUNRE1ieAEnAsBUc/mPXxSo6hxazs9LBD7yUQYL43CH0Gx2Ckm85AHbQK2jmyB6HdOO/sOZki3Zhap+PdEiFKKLcYFrXs/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895885; c=relaxed/simple;
	bh=iB5wMfHI+J9P2YZV+NCaEmyVstCchgGsnuq7mfblivY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=e7vEPjuVGAiZsrpbOew7jac3kmnRq8RYh8IzDZVM3i4zKRLXDkK4+95jSSFCLFgZY+frxsaaWHFl0FI2Kp30bF/M+hLw7kt4Ep5wxzFDuJjfLWw0Recp01hTYlrW14Y4/jd5XYdT+pzqYEdLIieXRCL2SdZH2f1TXRU5tgXOWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMYgnJPe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMYgnJPe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43996e95114so5548455e9.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895882; x=1740500682; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPqc6l0vee5Ni9OfLO4My72PUsnlMX1DvFM+AF0kAbE=;
        b=eMYgnJPe8n1hv/MZ+fJDlS1VobAA0vdbX/TlC+nveHOZvZZ/6Bt2gNFlXW1spH7wo+
         U53Rauj8YC5kF/6zFnUnGCeSwoAdAXOkUaHN4am7gPoYKco2CwRq3W1xB+YWPEDIny3t
         spdUoO3E3/Nd/PjtZFlmNXn//z8dQAwPha4AOHeThmGgbNe5BNfaCtT0IUEz78kxzL6m
         czYYOSuNE025Q7xLpsFi52YPw9lco/dJ4BAm7zZmZ17uqitfdlsHvOyy7qMx75YBRAa2
         lg582ouJa1SoOCaCCZEUgCTfFKj8kgxuIzbjCkGZEAUJnzoUJ6461Ryi6fmc1iEBOtAF
         0RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895882; x=1740500682;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPqc6l0vee5Ni9OfLO4My72PUsnlMX1DvFM+AF0kAbE=;
        b=b+yHMzPLvGPsggw6usnQaowMyjxikJukcedaHi2fiK9aMO6nlPu/V/dnapjLu1macX
         J5I8R+GGVwC12i/xNGqoZ5TBVrdJqhnDP8LFHXTwdl53nCiO6AgF3VWO1qNx6PJ8Ae5C
         f1vug8iLWEui+/tnW3uNR46kpIT2lbp03TJ0fEoAtKLaecf+J80Bj98Ke3Keldf1m6O3
         Nyh0aDChzzVomMhsrsFqyIbCoKW22PPlv50wCJiOgpk1C8J255fKcRq18r3HNBcVCNuD
         8twQiZtPXMNZkZqNINcIihj+KS+aUbxxEqTQvsmy7OApyqu/BnMIAfnB/NvNeVrrhDG8
         wuNg==
X-Gm-Message-State: AOJu0Yw+HZvKun7I/kQy5xUHPGGxcQ2O7S0c4EHznNC+oPvVqvRbtWFK
	vRsvSvAJjolziwhHKm8mYwKV+LVN0Ys+Bn+s7U6HAT5aqKQv2J99L1xI8w==
X-Gm-Gg: ASbGncvo7aTS3CzlpNa6eys5gDT6VRQSJBVF6IWdbiBvL7Eumyd2kRxa8h925j3JbkL
	Glh3P05wfF07qq0sEzGHR6Fmfrv8Ndvhc1HNidFP5fjKp5OcD+ZpIy/CgfvumNPESbqqBZBDuYV
	QyjZY/xQVeRMxrZm6y917Btr+H8HpaGRMgnLRukNPUp4sHJazb6eB51Z/a5QBYAzDb7497R3i7T
	3FBmTa/HmRck/HKNwVrwIHsdEqi5Q258c+bx4FImKA94BLNib4qYElsR/lpMBVn2Do3CsCRWnxE
	sx9E5MkDl2YmpEhC
X-Google-Smtp-Source: AGHT+IHDgtMsD+D2tyZc0T4kGw2KaGPpeY1d/mJPCv65H2tx/vlz0e5e4Pn2RXmLYYCAA8HRz7Jhfg==
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr125862335e9.17.1739895881735;
        Tue, 18 Feb 2025 08:24:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43999e5beebsm1154015e9.22.2025.02.18.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:41 -0800 (PST)
Message-Id: <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739895879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:35 +0000
Subject: [PATCH v2 1/5] merge-tree --stdin: flush stdout to avoid deadlock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a process tries to read the output from "git merge-tree --stdin"
before it closes merge-tree's stdin then it deadlocks. This happens
because merge-tree does not flush its output before trying to read
another line of input and means that it is not possible to cherry-pick a
sequence of commits using "git merge-tree --stdin". Fix this by calling
maybe_flush_or_die() before trying to read the next line of
input. Flushing the output after each merge does not seem to affect the
performance, any difference is lost in the noise even after increasing
the number of runs.

$ git rev-list --merges --parents -n100 origin/master |
	sed 's/^[^ ]* //' >/tmp/merges
$ hyperfine -L flush 0,1 --warmup 1 --runs 30 \
	'GIT_FLUSH={flush} ./git merge-tree --stdin </tmp/merges'
Benchmark 1: GIT_FLUSH=0 ./git merge-tree --stdin </tmp/merges
  Time (mean ± σ):     546.6 ms ±  11.7 ms    [User: 503.2 ms, System: 40.9 ms]
  Range (min … max):   535.9 ms … 567.7 ms    30 runs

Benchmark 2: GIT_FLUSH=1 ./git merge-tree --stdin </tmp/merges
  Time (mean ± σ):     546.9 ms ±  12.0 ms    [User: 505.9 ms, System: 38.9 ms]
  Range (min … max):   529.8 ms … 570.0 ms    30 runs

Summary
  'GIT_FLUSH=0 ./git merge-tree --stdin </tmp/merges' ran
    1.00 ± 0.03 times faster than 'GIT_FLUSH=1 ./git merge-tree --stdin </tmp/merges'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9a6c8b4e4cf..57f4340faba 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "config.h"
 #include "strvec.h"
+#include "write-or-die.h"
 
 static int line_termination = '\n';
 
@@ -623,6 +624,7 @@ int cmd_merge_tree(int argc,
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
+			maybe_flush_or_die(stdout, "stdout");
 
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
-- 
gitgitgadget

