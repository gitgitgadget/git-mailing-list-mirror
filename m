Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF581F12F4
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860306; cv=none; b=Y71jkUaK6cEI89CAe2ohBUeAGa/W8oTIBoR+GCDHxpeSckTvjfizCXR1j4k23qgNx1dPizNFn+DXWbzK1FWoS5dOhWjWI+U+0ppfU2tChTBgwQFO1WkGEHUEG0zdPpOFrgIWG/TXyzyDMdK9gMT7hvcuS/NNnlQovRnt1Tu26LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860306; c=relaxed/simple;
	bh=Kcj0jTcXnTOkoGJ2DH9xqL/sqN1B/dJPnhh170VcTDA=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=WzS5stW2jzHvagqJ85Stkt9c8d/c236TPNN4pfmHqDc15sWzBU0plE2GGG6nP5LYJgs+2EVfHxjFvwa2sJS9VqxhgtY/f0YqbnENDeauktOFvrSzeZu/kK6iYksIWlfcYdNrZrgj24H0RIAEwO3G7ew7E39vCfwCfpWe6gKisDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTIRBScL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTIRBScL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563a57f947so1984815e9.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753860302; x=1754465102; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cD0i7BVIFlLNUl3cuQLielyVZO9fYPw3C7rFz1Tl2Xk=;
        b=XTIRBScLrvgVH8kMZTNWx5r4+fuD4hGVRoQgUMptf/fmFxEu/iKGVTEg/BLM7Xljmu
         It6Fv02+hLq6rvMJPc1sbIgIR3SN8OKyFB8k71Bw1WibstIQGTy/aEApLhq76SVgd7tb
         ct4nQHhHoMJvXNODIxz3LTNooCfKDi24wRUZfNMK5UgNwnqrpvdPSKHjY6/KIojxKo0/
         0WoYnD1Mw1xq5SA6lWGrkWBYZ4kcDD6Awlg9xeL+tGK91K80cXW4rs3E9yS76iS14lbQ
         mpqPyNOGBcNMRN4xNMBLNyyIgp+sQggIKnyX0IHY8KJA+0bj69UXwPW5MYMRZkyRTITE
         pG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753860302; x=1754465102;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD0i7BVIFlLNUl3cuQLielyVZO9fYPw3C7rFz1Tl2Xk=;
        b=p6Vu5u+f3b12YbP7+koPXziDazWoJ94pvNV8pka7DnvV0op6p142+JNbMNPDxueIZe
         WM9m12eWtSih2zJ4bnD5wH58L87ACaC9CCQtmNP1quxYxUfVQ179XfqZ5Iw92ycOMWkP
         N+34xjnmSp4egi91IOOI2R58MXnzu4c3Xwpk65fB0gT2ZjyF0zEW4ssB3KV1mVJGz/3B
         9hasIiH5Z8KNOZ9JA6yKNagwUI+1N/Vx9R6BdaEeySP0gnj5sI3tZgZqiEjrsOENXYwX
         QDSS9Cp33/o/KZJ5uxlPJNtiFlD5mvaKuD6fY2rNLgvYmiq41e4PGuCsCTz5KTNV4NCD
         73Eg==
X-Gm-Message-State: AOJu0Yw8+G96UQkBM/iGOpIfcH9nmZ0Kb9YGTnfbgcro3846RbqRCsMy
	dMEDMq1yOLKuRv0owa5eDAAnZaKD6nifuCHuCw8AiiJFDd1DKECTW9RSL+anuw==
X-Gm-Gg: ASbGncs5Ho742nuQ9569zKQxher0VasFrCBIFPZXDoYsy3ZARXn8uoj+nbLCWNM5Cvu
	h3fqqkZlku9fJilvOtT90AG2zjUDAj6VDTSgrfRLdlcQI9iUmmtjf6LGDaPnHYsgTCenHMJuNYM
	lGThVbqy+P1RqTqG+VCEj4wmQAFgmTIpAKF0hxPq+hxaOidLdZdWPvEojCFcBKpLPH56ojtSNYj
	ZtETjmQdrIasoRoPEXbuKIPjDiY6AwC/WmIvvhXi8HOFMCNa339HzpY4WSXEtAFwXeluK/NhnmJ
	yDksXKyhsOMDMy/E5KV1Ds2vX3IcXw6tNoG5JhKvBj/uIa1zLt+4XpfEy9tWz0oPMT88ZrtOyB3
	zcf+lTteXg5GNLI6wEUKOSMk=
X-Google-Smtp-Source: AGHT+IErC7SwQWOtgN9w9D4MlOSK6XO2Rvp238ejLAiODYOPaWqi3j+SKOsQT8nSxNn7jXEs6ANGVg==
X-Received: by 2002:a05:6000:2510:b0:3b7:910d:8054 with SMTP id ffacd0b85a97d-3b79509a3eemr1651346f8f.11.1753860301767;
        Wed, 30 Jul 2025 00:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f034a6sm14944735f8f.47.2025.07.30.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:25:01 -0700 (PDT)
Message-Id: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E9=99=88=E5=BB=BA=E8=99=8E?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Jul 2025 07:25:00 +0000
Subject: [PATCH] =?UTF-8?q?modify=20the=20=E2=80=9Cfoo"=20file=20path=20to?=
 =?UTF-8?q?=20"$PWD/bad-clone/sub/foo".?=
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
Cc: =?UTF-8?Q?=E9=99=88=E5=BB=BA=E8=99=8E?= <18230222379@163.com>,
    =?UTF-8?q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>

From: =?UTF-8?q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>

In the t7450-bad-git-dotfiles.sh, when post-checkout
is executed, the actual path where the foo file
is created should be "$PWD/bad-clone/sub/foo".

Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
---
    modify the “foo" file path to "$PWD/bad-clone/sub/foo".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2022%2Fcjhxmx%2Fcjhxmx-git-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2022/cjhxmx/cjhxmx-git-test-v1
Pull-Request: https://github.com/git/git/pull/2022

 t/t7450-bad-git-dotfiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 14b5743b962..f512eed278c 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
 	git -C repo commit -m submodule &&
 
 	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
-	! test -f "$PWD/foo" &&
+	! test -f "$PWD/bad-clone/sub/foo" &&
 	test -f $(printf "bad-clone/sub\r/post-checkout")
 '
 

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
gitgitgadget
