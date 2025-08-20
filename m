Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2F2E22B2
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701030; cv=none; b=HRDsjVyd+ka8pzblKxlgyKguQJ0w2/IMqrX0XOXXJ5BuYu2nmufVzlXgb/HR1A50+IzLp+MzEx4HuVeqPsNrXrvt6HBEV0gNkXQBw1+nqjEeXIAZLmsScZx8VViPQVHWaCRUMcPo6QUeltDW6VMtI74e1c1mg//F8SNQfA1+6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701030; c=relaxed/simple;
	bh=Yix9qzgiJ+hg0/MV93rD55BxCg1SzlSinXAQu6PmFgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s7gg9yDCuqqZyDV1dwzfixoc6ACaY5SEw3YH1mJzAM3DhOn07NwiVAISoCFuruPOYOMA81s1JFLT0FSF9QA+ysD0/6H5nPm2/i03Br39ywGFP4Z9ca1YeNERSnRhYgGypoRHFZi/lzRhfJhkPFoApH2er9IEaOxLj/GFdg/c9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3nhWFgp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3nhWFgp"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso4059827a12.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701028; x=1756305828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znJULQ0DsVsDl3Y9ZTRStvVOtmPlf72pNUpmaYQjr2s=;
        b=N3nhWFgpNqaw7ctSaDNF6WXq1ZC/xcg/xa73uQ+AVQL65Gff5iph7S+oc+1/UtDmv5
         X2JQHj6dfTjlr0wjNxkPI0fo9z9iVQ7w94wCmt1/8IE2UUhrr6Q//UxdheJ2iuEQCquF
         N3N5HOKXdey9iwJ/GxWH7ygx8YH51CsBWOsB71GiE+ikElYJvpGy8VGgZ0h+Ztl7vfAH
         Ns3Xpqm5XAsTHrghD75rfM+hV1h/wgzYIEzu7BS6voRcmDVbxjIyQ8JknzeWmBmXoYlx
         Ao0uSfF4frzGhWQa/kRsCCvnRXMFDa1BjzYibvcDYiW+4S2nbt1FbI0HwzPNFAqWRitU
         eVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701028; x=1756305828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znJULQ0DsVsDl3Y9ZTRStvVOtmPlf72pNUpmaYQjr2s=;
        b=v0Vuf40eoVvfG1646eEuzmqQrWibT1CHmItkzrjDVzRnHsRDHDZmRrubp/L/qlLDmS
         fEbYC+XNC9sBrWh6O4ySfYi/20rkxa4RUWHkh5FkRMbqBrWax6kMBqSRUNViBSesgUbz
         p2anE4WUe9QCDuYn/H0NmedoO0MtCObd3NK5B64RXMPqdoXeuOAlJ8hJ4tN7tmbEjEQX
         dRKjMvMjubhcVfK5+Lp/jOTyABf4zXFRWfakzmA3tmgqmlFv8dZ/oOi1LcRrwBWOerAh
         znCG3qPtn//v6St4X2zodBpYZSe1JkQd1nJbLM9RhZwd3JcMDHEZeYLInEk04Yx29Fbt
         PmZw==
X-Gm-Message-State: AOJu0YziHyF8KhvrHXxFgfmFLCg/CBdAtXAQrNSmms6cziVn3ifrsuib
	EMwXYKtG1AcX+K5rVTFNps0aver7NvhcIM/SJrTkSjTr68i0sPO2ZqqOEz3tqw==
X-Gm-Gg: ASbGncul0SZY2JM8cFRgeTXeIWV+EjFDUQ1bB8hofGplRM90DA63IjY6hmBUwtg2RPv
	cKI3GWKDy5UoTcSlvY0GWzwgTCpDgE/afJlnp743YopRkxwnNRMzBYVcjxIWAUsIYWYekouhC7h
	uDbiEsXFfO4zEy8YfDYEL+aervuOVWLvsPcylgjQPgp3aCbhKUz9FsRttQYfe8mkKgODFmeq1+2
	KB3T61oXd++Anx71RHwhzMbyZrA8BRaDSRR/tRrXUwl2SFM/gdU3mMHI3FqjQDMv61L8fj2kWKD
	AiiiUIgeaHiHXYYlvE5ienzZTT3VTQAitW3MMHt+4ZTM/5hYW5Mxq5xcZBrgqbHumopNzDcRdU+
	l7AzTRExlLYWBl3BVVkgZrDxtpbwySUZNk2W8rc7D5FE4otBNk5WXBuSd15x2lDo=
X-Google-Smtp-Source: AGHT+IEdyBayog3GLRhrazN6AU9+heUF9DUdG/KQSeMwF9JFmc7+vzbJjpQF0Jv2jQVvXIS6DMPZQg==
X-Received: by 2002:a17:902:d4d0:b0:235:c9a7:d5f5 with SMTP id d9443c01a7336-245ef143734mr36505115ad.13.1755701028301;
        Wed, 20 Aug 2025 07:43:48 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e923f8364sm1950291b3a.107.2025.08.20.07.43.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Aug 2025 07:43:47 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 0/2] repo: add -z and objects.format
Date: Wed, 20 Aug 2025 11:42:45 -0300
Message-Id: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This patchset adds two features to `git repo info`. They are unrelated,
but I preferred to send them together to avoid merge conflicts and
because they are small.

- The first patch adds the `-z` as an alias for `--format=null`, as
  requested in [1]

- The second patch adds `objects.format`, which retrieves the same value
  as `git rev-parse --show-object-format`
  
Thanks!

[1] https://lore.kernel.org/git/mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg/

Lucas Seiki Oshiro (2):
  repo: add the flag -z as an alias for --format=nul
  repo: add the field objects.format

 Documentation/git-repo.adoc |  9 +++++++--
 builtin/repo.c              | 24 +++++++++++++++++++-----
 t/t1900-repo.sh             | 18 ++++++++++++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.39.5 (Apple Git-154)

