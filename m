Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070012AAE5
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328471; cv=none; b=u8f4WDfA8QwwbdDhVeMrjMgFql9y1C1Pp1q4KEFQ3e3+uuts5Hic/CTVFnZKWJHkVFBBsjdnrb+e0O/O+Vi7j4dGgq+GD6VebPmMxsUeB+Sr+x/a0pQa/4IX+rWVCDnlzVeNKCZl3QYFvNhH37Z/5QKRLk5k9E4reHUvMBcq2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328471; c=relaxed/simple;
	bh=yIiF2wNFdL/D3h6QMBkxP8GndPtnEFjgtO6g93hrxoU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=k5rvcGbzYdC59+mmhi2JvjnyRG+1nhKLTLGnkIyJqT5XKQrPmj6JwFwTMbqKPLblpOmSdSFuoLk98UBPTzAKAR+oeYgj+2tG9QLH97rXjZMM952ZGVrjpfG5p4jzb0i5EXbc32uorwXaJVwFKd3I7ygYe+R6rxFoKktbDLXWYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVMI4PUm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVMI4PUm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso13217035e9.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715328468; x=1715933268; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zl2c4uEdy18Kj1FKLSGHFleHuIC/RYxfUy0wPWx1Wg=;
        b=cVMI4PUm+Wa/jxY/aR7EVA996swM7M1V0urdt1b7QwaepABoRWNNDLikf/6QX33SpC
         VGcH546XywthFE7c0vUnnHJdZ8QQn30G9hpa2rtmFp1bmgW81Lib6LGb1XbfPdnUAbqh
         jJhoiJBxz/L+b3b7acq9DZNmgmeZ2IEBmd/1MZm8BfyB9mcenDl498CVp75V9mQXiO8n
         hK+mU57GQGlsPrqnqcH843pQCcqSLwLvmVRujF1ISYt6qrpl7MGqwdEpMsRX+90ay5rs
         +BMtCBVAgxfeSJZ6L3f4ogu8+JKFTt8+KYm1Lt/PoqIe8BSMR3eQR2k7D1IIQVz+8B9N
         pEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715328468; x=1715933268;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Zl2c4uEdy18Kj1FKLSGHFleHuIC/RYxfUy0wPWx1Wg=;
        b=W4J0LGU4XuRavvSv/dBf1VzgG9b3if5sWoZxT+blCzRLnabWSROXAMiT7uYvEmAaVu
         OSP07dTUKsDq1c6RBeJbo+RxKpHIu2YzTFmEeDDNsvHUQIGhmryxpY4+Zdsh43kjbWO0
         9J90AqNJEPbyaXBvY7t8pNHJE6m7u92+gDBnlQrvVTQlAitLdo//dBRtsZxEW0iuS5sh
         BLHH+SxID6B6OCCCJvnTdoitLiWocvx4lx5WEtTqz1XG8nBV8A2BgoY2GLOypsojFsrW
         Mr0U0axrTUHaXDfncBzwIc1REeHtAsbArsxKg5GyZi2gWfNnNZSxXLR1CeZxs9DCbjqN
         BpuQ==
X-Gm-Message-State: AOJu0Yy5DTpImjTldE2qlSb2jRE+s6zl8bLXCNboeUkTqK9eIHPc3NF2
	7WC4ag2vwNUsYxzPARiQRkFUtS+8AnTI4E8R8b37wyBBI5jNohQmz3VFwg==
X-Google-Smtp-Source: AGHT+IGC12JkMjAnrpdrUy2HH+vDsYg2rVBHJa7+8/6oGjObFVR0hG1haMi4VFP1BXhQPe4dHeVRJg==
X-Received: by 2002:a05:600c:1c88:b0:41b:855b:5d26 with SMTP id 5b1f17b1804b1-41fea927e30mr13968285e9.2.1715328468232;
        Fri, 10 May 2024 01:07:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm53522375e9.36.2024.05.10.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:07:47 -0700 (PDT)
Message-Id: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 May 2024 08:07:46 +0000
Subject: [PATCH] osxkeychain: lock for exclusive execution
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
Cc: Bo Anderson <mail@boanderson.me>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

Resolves "failed to store: -25299" when "fetch.parallel 0" is configured
and there are many submodules.

The error code -25299 (errSecDuplicateItem) may be returned by
SecItemUpdate() in add_internet_password() if multiple instances of
git-credential-osxkeychain run in parallel. This patch introduces an
exclusive lock to serialize execution for avoiding this and other
potential issues.

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: lock for exclusive execution

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1729%2FKojiNakamaru%2Ffeature%2Fosxkeychian_exlock-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1729/KojiNakamaru/feature/osxkeychian_exlock-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1729

 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6a40917b1ef..0884db48d0a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -414,6 +414,9 @@ int main(int argc, const char **argv)
 	if (!argv[1])
 		die("%s", usage);
 
+	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)
+		die("failed to lock %s", argv[0]);
+
 	read_credential();
 
 	if (!strcmp(argv[1], "get"))

base-commit: 0f3415f1f8478b05e64db11eb8aaa2915e48fef6
-- 
gitgitgadget
