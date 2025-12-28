Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DD252917
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766936489; cv=none; b=fKjFj3RP8d7fFLIno9XnrBS8KFxu+AGMMnP0/JH0Q/ydUdvE1grDh+Z1fRW3xCw3cQKMKN4CspRBrK3P+O89YIg8drC1KZXsnPKXR/gwbNhIZDxmE2pSF3d+UvRuS2KOPsCUvZP3QGriMyhstTKabKZMsiA+cO+g3s0k71VDUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766936489; c=relaxed/simple;
	bh=SK32Cs8/4/JPwdxTnZx1+rD+Rz++UUch+ViJ/DBuEGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gdioEnV9tw2jDlVI6ARzK7IBNcWH8ZLcrNcPltaiUtW2uYanZziolFMdhxg9VGNrGavWM9WgWnUAwfTDZLk/dpi9T1ckw4b/WupYeF0b1rlSE2DvMTxwo27zGFDQCqvqv2tKtjgdYWJGmQP9b95lGdwkOudKQUt8ycD4lEprMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFcV45Xo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFcV45Xo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2d56eaaceso1021607285a.0
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766936486; x=1767541286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE8FPFVJ+cYbtmyr8bUReJBmzkLttGQJtBUZeIk+ayo=;
        b=aFcV45XolO6RvNTTlJAnb6tt9rPSyhXd27MYQbNKe49dsEW4jRbFKnD/teLOgJ5jmA
         kShkljWlSFs/51w2lCTn+B5fjoq/jlsJ8meW/L4LRp8SoswADenrG8MRIacJcd7ZXAqp
         QjoVoav6nWSxf4pnNwDSNcB9KS8rKBJ3bPR/x5QgB6sleXjJzR0VPnmV8vnFkhn9zdbU
         C21uIxe2a/7672x8pT9JW3mB6qmK0OZFRYOEmtM1HvXQIJ/1Mag/0PPBZc8JDWMLxOkO
         wM0pMdTs3PaW7TSE5M5jQiRv6FXjScGiiMdTcJ45ETumgp/bZkAQOR1nAgBG0+IhnRfM
         TLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766936486; x=1767541286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hE8FPFVJ+cYbtmyr8bUReJBmzkLttGQJtBUZeIk+ayo=;
        b=bHErDWHefbsPUgMpM2jP678c3tEZ3NLdYpQfib1cmHrcR1X8ghZUr6bRcM4aTSdf1N
         3HF6DaXJ8FsAErVFp4IYIA3YeyzQVNaxBRBEj/qhgRFuhjgCbvjNvpFHayYPqEeGNskU
         e5eCvXV0rmhr0V7uqR3Cp9HBoxM6cRmhI9vB8UEdCLYgK6zfLGs5x+hZg5jPe6qyFb9V
         U5to7HdC4RWl3ar65kXDIR1pJBnmJDf27/s8BfKm6KyTkPRWszfve9Wy4t3baoVG9MNF
         bh4OVnks32XVZwdR2ZqLsUHM4tRVlbsd0PzwCwdzPilNgxkIcmzDxm7OVttewZby8a9/
         jQ+A==
X-Gm-Message-State: AOJu0YwywKV4QQRb5SU2XEQK0Ydu3kFE65qWokRaSmrGZ1gPfsbV5wAY
	EOXbLmXGpIxx2m00drfJJYhnn4wwqR5hAR3NOcCVaHLO411Dlm2V0CW9uSITUQ==
X-Gm-Gg: AY/fxX4P/+cKYFcd22ej+pLeNM38LlwfLh1h3uEHkpIw8JB+M13hfbKEIN25cIDNW9y
	Vh65Zvu4eSPoykxJMXcnl0JMSSSiq0K+agG37HlebSXDqj5piMMnopR39GmMqD5dVMc1Ao4gG5H
	dDeEXi/aJJS2AqYxQygJGJL4Tsklrm6PmqluBmy9Ep9NsfmSFg1jIIVwEJREN1FdcDdK8g0TgVu
	5Mz3WWoW6UR9xPFriNglDGE6nNf/hes8TvFQC8GT+OHvzcP+4smHD7uyO1Rgfh0XIX3xFAG8N0N
	SN4TmZiZmhjBx4vMd9RApKGQZsN0QE5JF1kZ8yMFCkEnPwCuVL1IoJEOzBGvqjkKMe6rl0RPNb1
	2tioZ5hLfXxpMQM50y7mNRPqUByPYhqPwcQFwyaKwpG20MX+vcN9MWLvsB4gymgNI3dk4wePsmY
	2QRUG4pbD9ec8=
X-Google-Smtp-Source: AGHT+IGgtRXArM5vCWO8NQxoQxHd1vF9KncVtRhZqA6XRUcTWXY1dWSNmb2QtE/nvsJjOG8ohDCpdQ==
X-Received: by 2002:a05:620a:2994:b0:89f:7feb:fd71 with SMTP id af79cd13be357-8c08f664ba8mr4098189085a.19.1766936485727;
        Sun, 28 Dec 2025 07:41:25 -0800 (PST)
Received: from [127.0.0.1] ([40.76.239.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688dcedsm2189248085a.12.2025.12.28.07.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:41:24 -0800 (PST)
Message-Id: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
References: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Dec 2025 15:41:21 +0000
Subject: [PATCH v9 0/2] status: show comparison with configured goal branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net

Harald Nordgren (2):
  status: show comparison with configured goal branch
  improve tests

 remote.c                 |  92 +++++++++++
 t/t6040-tracking-info.sh | 339 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 431 insertions(+)


base-commit: 7c7698a654a7a0031f65b0ab0c1c4e438e95df60
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v9
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v8:

 1:  7e2574d5ae = 1:  ecfe122585 status: show comparison with configured goal branch
 -:  ---------- > 2:  53bab23737 improve tests

-- 
gitgitgadget
