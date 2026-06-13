Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76321303CAB
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342193; cv=none; b=Y8oicSGoon1YxlzUK+JMlPrpAWAoJTLYs/zpZKfENziV9EnxBPlypOMhuHchoJRMtd8n85Gpu1u6Xi8hdAfs6odw6PuakbMemv7ThVref+fHmh439NxHn8wJKem8ZQamjztpM314INWM8w2PeUdGga2/52Nd5sPVy34D92VS6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342193; c=relaxed/simple;
	bh=wubsWaJwE9ktz68NVO37njhmgqLFPCTUNB9p4bWiEPI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kI1TZbHTxf/SnmCigHCijuDkGpdo9ZlOe0wukMKFPezoXdB7nbbFKHfKnkj/pMzu4vmPoUQeZeXOmzF14svTpQcMG7UGmW25v33jzyAGeuUUC7KRy4BQ+UHtQnlzSBxc6meDDxs5scixCpK1A8jyzlpO3zz/E2bZN9NzyYtDBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcAp3V1e; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcAp3V1e"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ce9df4732cso21181536d6.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781342191; x=1781946991; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wuVmUtC+uxPnwTsgLMHUuKWM+kdWj0cVxcm48HAmtkg=;
        b=ZcAp3V1eVWCykDt5Lb/RF1ufQkhxn9iivTbr8BtaeexmzkLY9AXdm4+kyz9Ex7/OSC
         SMyfxYcewG7Zu5S9eO75HkotI3swrJnYFJC699mvJuMxy/YUNLRFZdhYVj7QjD0VlNmT
         sx4/262+s5BUZY8o7k+1hZ7/TuFwKxE67o8ndadtouAhnwv8MWEE9qb+Yc1OHnOUCVZK
         xzyPuyYVfmgWrpTx2QLk9fdVml8pWljF5uTU9CqmJwveHOdRJsUeJEz9Hndfm9HIBJ9e
         YgcCQHSUDEt8rcwiEXE35JbefnKXaHLdnu/l61WdhHrw4YomTX3jOO6VWDTRluj3yuPX
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342191; x=1781946991;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuVmUtC+uxPnwTsgLMHUuKWM+kdWj0cVxcm48HAmtkg=;
        b=i5RohPWpwhjUexSnYSDrmnxsZ4ixdFPMh3rP7VxDQoyIi4hI9+TyQP8HX8vyk+xeNN
         FX2EPiFYA90F0x9Ky9iGwNuFhZt77a189NAn1wPkfVdI4OXc6A7uuvtLDamYyznOaHUg
         yHjG56nJyKVYgtqv0xolhL7JzfdBrZ7NM+Krg2bihpo6r0ksdmsFQMjsqjRty+x704zh
         7A97gNgU0XEk3vVzpYJOFHh+NVPIfZtpQkXW5ZyU2W5lNYQMwvUg8RT7VKqVJdwLCyRm
         3IWhUUQunauXZoKDokXWPUFIgxST0tfmdifgmnPAjpiCqXBLqmCvweq64ewG74ntm5NJ
         wWvg==
X-Gm-Message-State: AOJu0Yz/bDNoqh7ZAfQe6VwvURAyabyXy42LoZJyKm18tHGcA+MLJ1Qo
	dedjhy4RILMCFMznwkGgErdZVcqIcEEVkZV6cwf+WRIyu0HMfNpkD6VXuGTftQ==
X-Gm-Gg: Acq92OH9bRVwpUSI58miiOUzcS6VyDgLCH5U3jkGJ4qJ2fQWNxfTsdugQuaNbLGDpk6
	x2hv9/6lNqZ/ePLxnEP1MswKVl1JEOTUwTyhZ0uoAdJiE8Wyw9R9HM4lYViaA34zdrcvKJz9YkY
	ma2e13H7iCxMNMwxi9QQHon4Yk92W6y11uV8z4QtWOptc1vsoZdnDuPADQMbQNxoUq3P3p+mMcC
	ws8Zs8cBjzORQQdbkuu8QkUL68I7//9lLj5V61NHISHS3R/s4gWItzCdT4a2ukb2Q6m7sViIR/b
	n0YLJlLpY9V6c0f97LOb6PUyWKODr8PAkXNHOBRwuLRIsyhkMzBZ7+XUHsRTXBPZReGu5qhA3rm
	CHsUaVLhebU/BpbIXgu0FmlDcPAWJTmj+AtTRwVj+Sp1ak6jY2mc8S9+5fkGRCPVS70NnW+XG38
	W8aXr36kjpXUoyQX1N42ipDOEQJr8=
X-Received: by 2002:a05:620a:448f:b0:915:cda5:2805 with SMTP id af79cd13be357-9161bf57505mr976398685a.52.1781342191376;
        Sat, 13 Jun 2026 02:16:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a005a49sm449637585a.23.2026.06.13.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:16:30 -0700 (PDT)
Message-Id: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 09:16:27 +0000
Subject: [PATCH 0/2] commit: preserve commit hash on a no-op amend
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

git commit --amend --no-edit rewrote the commit and moved the branch tip
even when nothing changed, because the committer date was reset to "now".
Reuse the existing committer date so a no-op amend keeps the commit hash and
leaves the branch untouched.

A real change (tree, message, author, committer, or signing) still rewrites
as before.

Harald Nordgren (2):
  commit: extract commit_index_files_or_die() helper
  commit: keep the commit on a no-op amend

 Documentation/git-commit.adoc         |   6 ++
 builtin/commit.c                      |  69 ++++++++++++++-
 t/t7501-commit-basic-functionality.sh | 119 ++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 4 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2334%2FHaraldNordgren%2Famend-noop-keeps-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2334/HaraldNordgren/amend-noop-keeps-commit-v1
Pull-Request: https://github.com/git/git/pull/2334
-- 
gitgitgadget
