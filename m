Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABD1362
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745117710; cv=none; b=oY+Blez6HE1WY0mHSfXP+l7jCIVkncv6tP3LEF7fFHMAC9PxE9IphCt9rfGqmjuZkVGG02tqWHdurMIrt4rIfq7DIaeMxdVW1BKMXOCPimyyAAWHvGULrzc5WMPnyUuzlZC6IETmYtfhiu9MYKZxRmQrXvUrEViZGUTKlmVVAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745117710; c=relaxed/simple;
	bh=ZLejuVh4siA9O3YXSqkb1U0dBPvh8LBed8IBa38avUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVCCaTkcIPFJnKw6mTInmCWzOAnYDiVUCnIbxYpww5tDyqOjLSLO97DUAggPO5Az5kJwYOmsSocvqblYaQoCukfc70AyURym2v+utA3eFCGAaXFgQkXpQ30bNsWmiF+LDXDouB6thqZu1kQCVThMAeOUKhosJmZ7PRb0t6QiI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krzKr2Mn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krzKr2Mn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-226185948ffso33597335ad.0
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745117707; x=1745722507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKCivSqnGiImP1KwDVsSWKsNR0/TJITiUMAEGRrpE1c=;
        b=krzKr2Mn6UokqYM7Bu62g2YEUfrP+Yncjr8WqG0mHo6yiuFTNTfzAf0jmU8aEFo3Gp
         piWMzBAwO7XUGYY/+0dqvC850V6xDUlipZviUYB0ylPGStUyTp9Sa2BXaaOzD0MfUjXq
         +RIoskTPcAN4KuUWFleEZnXJMFdJ4GBbKBqycXlSc4Wf+mBEKoMGwfoP3hWwyVMYRvAm
         M2U+3wq2lwrsDIRUWP6gz6O72oUN+wm5ONLaX2WlBd0KmOTNjVlNLy/GTGn7snhHow8D
         5N9wnhsk38egCWroNRqR0JA4/Gz41YMO8ssDlbgrnstWAgC854W+jJENn0Os6uZUCc14
         kdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745117707; x=1745722507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKCivSqnGiImP1KwDVsSWKsNR0/TJITiUMAEGRrpE1c=;
        b=wwAUgVfHT/XaBAKFS7vSOp0ImHsOy6YBwzPU6OarswthpB4r7pHkXkh08mFCbJEdG+
         fV4ypVQsq/DO5ZVbV0eFcJpiBi3a9SfQAdkC6sau29n1jNjG+YKXek/ydYgPpbaP+gi9
         gJtsUeWVYK9RVYriZ/fL9XRHSZzkBRRyJxoDBbFNc6SGDT/KuEnCQDDuMuPZA2Ymcr6q
         RG8Pl92DmVloUn4O6ZwlfONoLxJcuQvB/VWQJBY4m0a6KFO7gtNNYDX2FLixwD34KBzB
         PdpwVVpfciaVO/x/ZgK9UKQMIi3+KRc34S9QebcORNDmDM0szxwylCj5fiMQP/p3veUZ
         1LJg==
X-Gm-Message-State: AOJu0YytEy1v41Uzm8sHx4pLT9jLbsG4Q/A6SnIkMwRonFcGJrq1JI8A
	HqRsjE9oByDFbeXshocFnyrwTzU5Q8LOinCm4IRO9xBcL8jvIIvb/O3QWYfa
X-Gm-Gg: ASbGncs/wxJrLKtl57U0vawsVfYZCW1MQIdR2nB84SwFvzmMVuMXBmS7IwW2SF+Rmvn
	U+i7Dx0LnfnGBPM+bhqx6AlmL26YYCSnnngYBpA07IXlXKAov2SzgSkldUv2E/w5MU4utSYRach
	zVIOB6J9V/1SBa6u6Bw8jYdnbAuCkgIyHhjsduk/KW4+B41dXDnJlYAXqU/Ym/8rJtlu7gav2Fi
	wG0t/2W0Wqzk7wW6sozUpC1xo7FFQc4LGgSSeJDFr0Uo/MeVRLsPI9Z+vjgssI5wcG69QU/wRP/
	Pfr7yPhwdat0e7P58UfAi43+sHvrhWEE5EeOiGgrT7vcoNRFMUUSlHsyerpE94u8GA==
X-Google-Smtp-Source: AGHT+IFacxOpVll2EoyblAZBajMhbSYzz9BwlB+FiNVfiEGmqM1N5Fzg2VnPgOxM/cZTeq+fVVLCqw==
X-Received: by 2002:a17:903:2349:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22c53608137mr109578335ad.35.1745117707408;
        Sat, 19 Apr 2025 19:55:07 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecf362sm40568605ad.164.2025.04.19.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 19:55:07 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH 0/2] remove unnecessary if statement
Date: Sun, 20 Apr 2025 08:24:31 +0530
Message-ID: <20250420025501.183290-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` in "f29f1990b5
(config: teach repo_config to allow `repo` to be NULL, 2025-03-08)"
to allow `repo` to be NULL, no need to check if `repo` is NULL
before calling `repo_config()`.

This was suggested by Patrick Steinhardt <ps@pks.im>

Usman Akinyemi (2):
  builtin/add: remove unnecessary if statement
  builtin/difftool: remove unnecessary if statement

 builtin/add.c      | 3 +--
 builtin/difftool.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.49.0

