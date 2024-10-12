Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDE19C551
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774579; cv=none; b=MeF+eGo3L6aUByW22neTAVqe1hxFiwXXCUW4t8U6EXTRfaFeqf+5Y0o8ti6Kv2ScM1UJNybFtQ/D4DX6soLdFPsjaktd9R1Oimcdab/z8EggOors58d93Tcj6dXnl0KOFQ8QY9mfipQYy4Vy+8oDGWw5/tjVHTeUaRU8VdLn4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774579; c=relaxed/simple;
	bh=jsmKu8bpyQU8myOEm2XGCEAFN6M3cU4EJF9kV/RfPXw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qDvqJRh/GJRQJO4U2EXov2TYnYsAPpJhv/PIB5DxUH6obtMzxf3L9+X3XCQS2vDe29Gi9ssv6YWhXR+vmDHYFPp1eY7aLcyQ+qNceIlwDReHinyB8MiguBP3RhTe9bO5pvBEwHeoy3dsBuYcImtdl4aclifjYTzSboUJ0XNotUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRkYOH4F; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRkYOH4F"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso800486a12.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728774576; x=1729379376; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jy6fyxD1fwLahXX9BBXWcMuBXqMLhi0IHPh73hbm1wk=;
        b=BRkYOH4FnDZzKBnH96gqU+LGLTdePHKQmgT+UyaHXuwnMuWBYcDJBI4RAdghFS3m9c
         hUXcJLtUvks3SjuHnwIvbKWSiVELViiCGQhp/jvsvABLnP8BqXYZ9XHMgH6aIq0gPm/p
         PvL5m2UmS5OKDL7qXfpccZXsUXzw61OTp+YWgYpPG4pGuLzb1dIw2dCPtUlVLaK7eiCG
         AKph86iTwsVqS+Xqxx8VGRYu3o6il5hBHU2vEJEzGR8fTGgU7Pksho6ItR/348OHHavT
         VzMdk4rpTaf1+/nl9zZj9nL9uuZxykFnXAhuItDVrghkkc8xL7gVFgnzo4oN1647qbg/
         1fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728774576; x=1729379376;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy6fyxD1fwLahXX9BBXWcMuBXqMLhi0IHPh73hbm1wk=;
        b=B7tyrFHReesZXsqanbsLj+eV2/LhqyqqSFPJ+dLwmeH5rHALMYoEqgpI+8L1ce12R+
         NMu6egvh6rb/qXUUQFzBonRfqlNBZ8bydOX7LC8dPhm37STKi+nQvUh/e0/SzaF29R6I
         82yX9ivV1JuzjrpwXJuMDy7wU2AE3sr/x0oVMd3mb3SniLGSblru71a8fInIeEVV7w/d
         AQIlZuzC6KD9mur510o6m/Y3LELujNEini9JWPkC4MCh8dBRlGNF/kLoWsUPAJWe2cfN
         R16hxuqCco+T24wbE3mDo5kPQgDJRO192JGBRETsJvLexc7+xiLs3tBszoy+P4W7c39r
         sgxg==
X-Gm-Message-State: AOJu0YyLJPoTYwJ90ETEQ6Ko/l6IF4WiSIcTBDOsihf1cr+f/qjK6rpX
	VccTzBNNvfMSOyPUAaMc8Z4WrJ6stW8LhRGJVOatsOmA7IJ3enkCsyqf2g==
X-Google-Smtp-Source: AGHT+IGwjksNLBYP9cUwG1FJWYtHBfJzfzAT7q/seNZLsxQGrt3EMT24xmt528lyBKYPVgVsBMD0Ig==
X-Received: by 2002:a17:907:d2c7:b0:a99:7a05:a652 with SMTP id a640c23a62f3a-a99b943b060mr586383566b.13.1728774575570;
        Sat, 12 Oct 2024 16:09:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a04223e3csm7796566b.52.2024.10.12.16.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:09:35 -0700 (PDT)
Message-Id: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 23:09:31 +0000
Subject: [PATCH 0/3] R atoi
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>

parse: replace atoi() with strtoul_ui() and strtol_i()

Usman Akinyemi (3):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-file`
  t3404: replace test with test_line_count()
  parse: replace atoi() with strtoul_ui() and strtol_i()

 daemon.c                      | 14 ++++---
 imap-send.c                   | 13 +++---
 merge-ll.c                    |  6 +--
 t/t3404-rebase-interactive.sh | 75 +++++++++++++++++++++++------------
 4 files changed, 69 insertions(+), 39 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v1
Pull-Request: https://github.com/git/git/pull/1810
-- 
gitgitgadget
