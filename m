Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE4224F3
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619678; cv=none; b=fffPd/REGk497WBLt3BTFTAYq82thX+c9dRUsuAsFm9eC5nz0M6I9ilrvBlHuCD0Ssi2zMFxbhEzgB9JQG33AmWcM6Y1VkkPgVL79ld/eelSZxK75c+8RBiwWAcjKzBMu7/d2+N/gxt5sDsbniVYxwEIXBcYcReCBQlh7arxjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619678; c=relaxed/simple;
	bh=zC9P0UONX1lTag1Eh4USgpOgxOKnEeyJ3sLkeGLLwV0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bMHKoqb+daS1Uf5vfUMfbotJ5pp+DzQxAKVavfTSShXJbxi/UWll5PJNz4v2uBZWiyuJt+iu7twuZacE9G6j1YfTa5ZYoa9TU1HllczW8V9Na0ciHfmu3lYMCbQTg8Irs3qM8uZ3YVXPnHrTInxNi/JREN2f6bq8y/QRTrpTW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaKLF4o0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaKLF4o0"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso33182051cf.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619676; x=1767224476; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRj4Egn3NHbPqFn6yJ2wxgJ3yaw9UsMMmt2SLrZMuS0=;
        b=aaKLF4o0iC5x6MAeUwj0tcN9kAbUA6gDxPdMIf7UbQgOj8sLYh66qSx1V4BeOkXjYx
         OaI4qbyiS0xWvcz50HnmpYXg7KxzjBq+sB9QmEhvwISG5JP98Uol3hh2qYywjEgCb/H9
         ZQjUtfCndB0OPFhrwSMKYqw44ubFUBeF0mLG91NfiH3QXZwTsNYb5yKtLdn8pwM1Y/jZ
         tdot4/qTnTFB6IbDUXkwYQ7KmpBF0GecTTqI3iebeoTLakVX0TeikGMd9jx3XJe+0BoY
         qXifELA6Y9p2sHiBPJ04GbWaEBJ1505UUesUlwWVUrL+GCnQahOd9UZisN1vzr+QeNMZ
         ebhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619676; x=1767224476;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRj4Egn3NHbPqFn6yJ2wxgJ3yaw9UsMMmt2SLrZMuS0=;
        b=dgoryOzb7NwzW7DqL4V4+/7gu5D1tTzTHygBEd9YdLcrZNXZv6uFL11iTOrlgoVQQ1
         DWZfSSE7KefDKtFpSTQNHnxd8E2oIzn6IwvpkfT7Bnw+aYjg2tFKkkZ9f1jHMckIHAK5
         +COccHJpWoPcfK7/X2nbqb1tnnrPDi7zlHV8mixQi5yVAYSgvSk4tE9t54JLK9wIl9SP
         YqoXdmmdl56Cm5gRnWUAcqZEHAkQnaPY4QxOCys/GYiDGDJL31g9P5DbhiRLyKuJnoSN
         kzZSH+A/2G4aJwpisQF2Hdlepe0K/7AqBMQj1UQFu7Q6UYtbvL9qzqO5hFflo88uzpAs
         1emg==
X-Gm-Message-State: AOJu0YxkIw6eJjv+yGbR95Uz2d2stpWQD7nBfwIW38ppCErTgsnsop7F
	/sP2pNqmckAN/4Od7P4ZLEqNrljjAAFFvkqfJkouod3a+yNEd79rKvMWNwIX9Q==
X-Gm-Gg: AY/fxX7JA4s5Tb9tkRGvPRLD1bp6edY9KuDt89lw8LB7J1lpy16kg65YqIFZUhQnZGz
	QmtVhFFBU3hQwssMNKTjxWQxiWOVhezdUDuX1xZdH0NA6zidR8SWIe6ax/L1a8h7lXbd1C41H1+
	VIsstxuU39mCyLDKrBuhRJ7+WWcRjlrn7tudSZObijYDUKMAx97a4PV536ATFO3hWW17n74waKW
	Ycncw5fDpsq09iFFv1hd7U9/vbtOv6w+0xxQOlDDS4Zrk1M/qpWgYd1atevsFlO9YAc0u1tjrmG
	TL96SxjvF07G/NGUKlcxsQTGe9Oy0xLfh8AXJV8rOZUiEtduq9CXClRAUZiFnjEGLkmp7L6JCQw
	E2ZB1MCDhrre67LAyPqcC1Uqp5yCtazPX00X+gdCd+XL2SWH+oIR6Zau2RLli0H6xFpgir5tELh
	PhrRP9j0PFzInd+w==
X-Google-Smtp-Source: AGHT+IEPCPoiSf3glGHAtggAtUspJBtZdUZZZCeh/BGt3VyQDZvbtpnKGGNTeWcYDs2ezlifjfwEsQ==
X-Received: by 2002:a05:622a:418a:b0:4ee:2352:1bb2 with SMTP id d75a77b69052e-4f4abca8d04mr295709831cf.11.1766619675828;
        Wed, 24 Dec 2025 15:41:15 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9680dc3bsm135668526d6.14.2025.12.24.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:14 -0800 (PST)
Message-Id: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:06 +0000
Subject: [PATCH v6 0/6] status: show default branch comparison when tracking non-default branch
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

Harald Nordgren (6):
  status: show comparison with upstream default branch
  Simplify default branch comparison logic
  Use repo.settings.statusGoalBranch config for status comparison
  Rename default_remote to goal_branch
  Add warning for malformed statusGoalBranch config
  Change config key to status.compareBranch

 remote.c                 |  92 +++++++++++
 t/t6040-tracking-info.sh | 340 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v6
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v5:

 1:  a3800aed18 = 1:  a3800aed18 status: show comparison with upstream default branch
 2:  417f2075fb = 2:  417f2075fb Simplify default branch comparison logic
 3:  c9ec5d9610 = 3:  c9ec5d9610 Use repo.settings.statusGoalBranch config for status comparison
 4:  0e308141da = 4:  0e308141da Rename default_remote to goal_branch
 5:  441678939f = 5:  441678939f Add warning for malformed statusGoalBranch config
 -:  ---------- > 6:  242dbbae44 Change config key to status.compareBranch

-- 
gitgitgadget
