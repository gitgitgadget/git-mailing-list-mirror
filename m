Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAD366
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937894; cv=none; b=D4wz7/5YKpC/dAj/v60zJO6Rdhy3wGZ3XdbbWTXmvYptUtJPnBTJakw2enhb8DS6DSPLGdJReINKQ2n8RJOgyMCMDJgLc2bAfsjklP0rvdk/O5mHn4ZzQl9qFtrkq6Hoa4+xAhXywN4eWMO/uucpf5B0Sz4/nZqxHF82Qi1ExFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937894; c=relaxed/simple;
	bh=P6KD0yPLRVpikRAng6QUsaDD65DWpTAkQzR3u206wS4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZzMRlPAkvfJv57AhAj9EZTF4hrfIDheCmKtDbCNZJUCv0FKCTxdqITLxr7TIqwllJ/VThbbVOK0at8eepIMCg5m38a/53RJCzs29EQI1R2mPw4mJXH4kp0xYgu4NH4ijmSmT95FWm2qNS3J7veR/BrOy+9X2XYrWQHhVGLkviqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Taibw7iP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Taibw7iP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so3238475e9.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730937891; x=1731542691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3g2vyVLXWE4bMPub6ghUYQQkpOZE+WhG+fqNQXlQPg8=;
        b=Taibw7iP4e4//WPIPW7FbNn6hg8obFEfhFjVD9enhOo8DW5aGKXgY7U58KRPkl0z8O
         dBpWyOYYYxSzkF+zCeKLvF99mL3ojfufZvcSyHEdfUKlbtf30JluF2+bE5wlWoFsCN7s
         KuWkR9oaYZs5yEJOZBIjIs5AlZ/o+HrrY+uiOo8WAdmUWNxOniQ2lf2HLynFIDipKGgu
         AwSnVcE5PWiuMJlWH74MNNKVytqiUMoaDdP8EJqFS/ibAV67IAGwJSQtCY1IEgVCCOhQ
         Vkchrv06pI7sywv3OI7m5MIvLgGAfEgQQslv5Q4fiDGXzwBAYwuQ+1QCN/lRzjgMUCxA
         u4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730937891; x=1731542691;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3g2vyVLXWE4bMPub6ghUYQQkpOZE+WhG+fqNQXlQPg8=;
        b=hRepq5mWo9xeJQPWY1KwjCRSX+voQUTZqSKBr/VqehvAlJUGW+FjsjfWhMBhicg0ri
         ShOtKq02wiO7rsi6oWQy5GqvCAYMtGaV7yFQx7hBgdQNKEcwnruF9wxO0149bplwXchh
         kGiaxQ9WBIMmI0DWVGJoE8uKP9CTWjHqIpqc4hQZO345cUosaqyhxWAkr16rs8ZPVTqT
         r8gx4Md79OcOBpVvp7X+UrqVzxcAKp89GFl8CUdQdeCDCwkeEehAsRCAL9g6fIAcmycP
         YgWQrWCy748jd/fBbM+ma1aTVAgyyI/6T81wDUIZB/RYzeK4Cx2wiJ87n+XR8dIWiW24
         Y8Aw==
X-Gm-Message-State: AOJu0YyRjNoEp7QnnOXwmKR35uh18/HNef9pyxhY9mOCgjkSCoEQBwcL
	mEODydY+jUBZcTJs6ztL2fk+X+XxxnvKIpPr9EKx6VaR1hXXtBv1YYT5JQ==
X-Google-Smtp-Source: AGHT+IE01Gs1JPAftEUozrE9f6ozu3q6oPmn2Gbt2RtHeif8er/o58RKvyc2fIKF/fqAP3yc/HkbzA==
X-Received: by 2002:a05:600c:19d3:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-431bb9d0aeamr264122605e9.22.1730937890885;
        Wed, 06 Nov 2024 16:04:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5d29sm3578145e9.39.2024.11.06.16.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 16:04:50 -0800 (PST)
Message-Id: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
From: "Adam Murray via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 Nov 2024 00:04:48 +0000
Subject: [PATCH] trace2: prevent segfault on config collection where no value
 specified
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
Cc: Adam Murray <ad@canva.com>,
    Adam Murray <ad@canva.com>

From: Adam Murray <ad@canva.com>

When TRACE2 analytics is enabled, a git config option that has no value
causes a segfault.

Steps to Reproduce
GIT_TRACE2=true GIT_TRACE2_CONFIG_PARAMS=status.*
git -c status.relativePaths version
Expected Result
git version 2.46.0
Actual Result
zsh: segmentation fault GIT_TRACE2=true

This adds a null check to prevent the segfault and instead return
the "empty config value" error.

Signed-off-by: Adam Murray <ad@canva.com>
---
    trace2: prevent segfault on config collection where no value specified

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1814%2Fad-murray%2Ffix-trace2-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1814/ad-murray/fix-trace2-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1814

 t/t0210-trace2-normal.sh | 8 ++++++++
 trace2.c                 | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index b9adc94aab4..4047ab562a4 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -244,6 +244,14 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty configuration values are handled' '
+  test_when_finished "rm trace2.normal actual expect" &&
+  echo >expect &&
+  GIT_TRACE2="$(pwd)/trace2.normal"  GIT_TRACE2_CONFIG_PARAMS=foo.empty \
+	  git -c foo.empty config foo.empty >actual &&
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/trace2.c b/trace2.c
index f894532d053..5df43478b8f 100644
--- a/trace2.c
+++ b/trace2.c
@@ -759,7 +759,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 	int j;
 	const char *redacted;
 
-	if (!trace2_enabled)
+	if (!trace2_enabled || !value)
 		return;
 
 	redacted = redact_arg(value);

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
-- 
gitgitgadget
