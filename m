Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5B1B949
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602507; cv=none; b=uY213Mx9x6NYvSat0ArxyUqm6wGFVPTWm9RoxAVDnLNJtQhdg6gidFFYt1iy34hTyn6FS6gi+Pn/xZi+zKPEBtmljkeNJACxzug4ddsAJ/wgTcw6C8yfYdbG/n9PqVA6YXVEx5DuVpWFf4Ju/5G4rk9A/DfayQVpB6AZ3z1ruWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602507; c=relaxed/simple;
	bh=tXbtvUJVcMdHV6b4LADDYM9y7culs6Dnp8Lzb27Tpk0=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=InynpXqrk4HwsqCCIDDI2KjB8xW7q31es4nh7fn8/CmoppUDc3EZgB3YuG17XZC7Fjjd75Hgi0nmeMCizE+2qVvLbX6xRIV/HMnPc04nCqepNILj7iqrSRepYSNZPY8zmuw/4GQ/JnwvDVqIpuCbA8+1m8hWTF3a7EDUUFr9RLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcNBOtCy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcNBOtCy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413f4cb646dso16860235e9.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710602503; x=1711207303; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S29GWDGsU3x+B+SIsCy+pHdtMQAmmdor8HOTQSuqhnc=;
        b=KcNBOtCy2cEfxhnDXSsaUZxAKJrYFEPIoNCuHzx+mg27XgyVn4Mys/Gb5AC2jeVS0X
         RXmiqXZW5OLqvq3NHI3VcYVSXR3Zgnk1L+K8CeVKLUAmP5tJ7ABDD5alwJjiAIYGByns
         Npj988i6yiu5QYZ/fkMmjJbgb4a4Ka7uZwD16ZNVeQ8Ikx+ozhOYhahZ02KduY8/M5Oy
         2xfvnXjcmZe0b+37G5mIuOvcQ/nS0kT4iiTDy48x9Kj8arxsbEAF8n88jhJapLV3Talj
         58NWFvurcBrqAlIbwoG3DaxyXnwX5UQDq3YRqA04CLvxGnuPa/b4/BUo7aoYSX6lqpiW
         RyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602503; x=1711207303;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S29GWDGsU3x+B+SIsCy+pHdtMQAmmdor8HOTQSuqhnc=;
        b=osZ13o5UAz6mxqxt4cExQ4rgFRNZnCPWpubM8/1uliatksl9eKHgY92DQuk1blE7Os
         q6+NcTdOIb24K5RoezPuVvFyioA+XFFzy2quH/69oWpldvAnJYWw6Dpvsw2ytR1C1qKg
         nAFdShNWF/guIAarNl5YgH8TER0mnhRp8jbUE9WkphBWz7YQoQsl1VqToW/m6/PTVShS
         WuY/lAnCn4lQj2hGxCR688O5e8VrX2GEDoODwoHT3+vGYh45f1Jx12d1dys8AC4kr2yj
         ayEMLd/wk16xcYYPt4Jm2JZMRTHgYPvJUq5rKr41iYeajChX+VyJeuK9z6l9BtUjXV/b
         YD9w==
X-Gm-Message-State: AOJu0YzrPXeR1jjoNCemzycA9E0pfdAPzsTZPtQixAvxZlq1Q+jA+erS
	t7HQZ2xzom4ZOpcsm1sFvtPneewvkmx7BWk12pHUqm/9oBbPUkEjCjXUI89P
X-Google-Smtp-Source: AGHT+IEI3QSgOGfe9SuuRMcOWC9hWyX5gx/Bralir6+2DRtNNJkzTW2GE9/J0a7ZtxKIHZD1HegFEA==
X-Received: by 2002:a05:600c:1914:b0:414:22e:1761 with SMTP id j20-20020a05600c191400b00414022e1761mr3042859wmq.16.1710602502899;
        Sat, 16 Mar 2024 08:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05600c0c8500b004140a757456sm241965wmb.5.2024.03.16.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:21:42 -0700 (PDT)
Message-ID: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 15:21:39 +0000
Subject: [PATCH 0/2] Doc fixes
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

While translating this session, some translators and I found inconsistencies
in the manpages text. The fixes were grouped together in this series.

Jean-Noël Avila (2):
  doc: format alternatives in synopsis
  doc: fix some placeholders formating

 Documentation/fetch-options.txt          | 2 +-
 Documentation/git-interpret-trailers.txt | 6 +++---
 Documentation/git-pull.txt               | 4 ++--
 Documentation/git-rebase.txt             | 2 +-
 Documentation/git-send-email.txt         | 8 +++++---
 Documentation/git.txt                    | 2 +-
 Documentation/rev-list-options.txt       | 6 +++---
 builtin/interpret-trailers.c             | 2 +-
 8 files changed, 17 insertions(+), 15 deletions(-)


base-commit: 4f9b731bdeccffa1b13e5edf4bc0428b8d49704e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1697%2Fjnavila%2Fdoc_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1697/jnavila/doc_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1697
-- 
gitgitgadget
