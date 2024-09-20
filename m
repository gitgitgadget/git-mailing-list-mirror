Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F355897
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726790429; cv=none; b=E7zRNmxzPWhX6Hy5Do3Xmyq0ZFigNCWXvZ9dImCKFYtloKKcHIlqZXSnkM2CS6dju7F2On+LLzSBVLyhuMpe7hJCTgdBMVJPkMXWOMZEovDVfAGmGebwp9L5vAUdcedZGnimFMpyY4Y3juVL+aZyeYqvLfhZJnNRebD5PtjlN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726790429; c=relaxed/simple;
	bh=pV+ZlUK21pa9S4jQZzYojzg9BSv+Qa0lOfp0Ms4cUig=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ma6S+GmpSMEfDRD7xC7meisxAAbwG1q5sGipa3XBW4/2fm504PVwYjiN3xrwMi0AbRgVGxEI9D4aNHJO/vsmHzReWBiZlHhUvKRWZ6s7U+kJRkbSZhuEKUZfaWnECAclemwgmJP5NKt5E2fxZ8wBr00u2xQW09h8kFgl/MYoU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBz9ZQ+B; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBz9ZQ+B"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so460959266b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726790426; x=1727395226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nq8LOF8fhQ5GAOqDkXLAeUMIwv2bKZfLqgze0wpIPyE=;
        b=RBz9ZQ+BILl3qIihCkzsKBHI/Fb6B6UjyfMkQw7ydVrubddTnSRuTkYevhrsBNHNl+
         oXFBPSrfMhnFDUjAu2oXvw1XnZljnGdTdZown1ICQ8rCw8tgi0Hr/GVazjR40oELkqAD
         RLxBkiZIMHOU5uo/Kr9KW2YMrbHSOilD86mE1vBXiCPd5/Os/Oxe/wIVsyLvJWwIlgIv
         nZtHTG/H6BJvMPkLcRlQ6hYik63AhVJkbzhPa/4AY+vvLIiMSUQrGObu17HwvY/IgPHI
         kwpdwNdDx/O5lrqS9IMbKxV+sjHhiU9DPZN6pfGmdALvVc7yIT8tm7AYW2bDX0inv+TZ
         kKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726790426; x=1727395226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq8LOF8fhQ5GAOqDkXLAeUMIwv2bKZfLqgze0wpIPyE=;
        b=ZNWNKNq8g8MW4ZkNuGY11pry7Cm/c89Y9tJ9Y9swBRpNZgYou/5su+kdT5yygsWgxD
         5dp7eVSd4ZcK9/LQo8tF6BaO5lLvNeV1dJXD/nFnZiekkLhvVfPeZ8luEdtFYn8kjqoy
         cXdXCJeo0I6bBqLNwD0CqkrxlbNN5ko7r6WlLilSZdBBxcdF8zzL/zV3LqgJYl6yovsQ
         cfRT48Y05tjO56aCQKnvoe/5CtmPlRYAoO+Yu1GjIqeebZS1XotuToeSuiyFq0G7gP5s
         3iMCUSl7hNWChn34+k06RBf1OmfO57nngqFRuuAd3SHVTbzAP2kQzV7B+uUxjrPvrzep
         bcXg==
X-Gm-Message-State: AOJu0YzrN4FQJSdr3EAcrVoDJir82dzr3u4OnlmDSzHwswVKf8j+MjtT
	CTTnqwfq/Tc/LRYK7iNJctrcxjopjfKYjqbaqqhBLsEu92tPaF5fsZhYRg==
X-Google-Smtp-Source: AGHT+IFxAvbofeXo7VSWlNPBM8UFvR3ewgKN0CH1LGKFN5N2zK+4qtUlgT5ut4eu0D1d8LBnKj2A3A==
X-Received: by 2002:a17:907:f1dd:b0:a8d:42ec:e65d with SMTP id a640c23a62f3a-a90c1c384b1mr474544466b.7.1726790425809;
        Thu, 19 Sep 2024 17:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df5cfsm785469266b.146.2024.09.19.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:00:25 -0700 (PDT)
Message-Id: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 00:00:20 +0000
Subject: [PATCH 0/3] maintenance: configure credentials to be silent
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
Cc: gitster@pobox.com,
    liuzhongbo.gg@gmail.com,
    Johannes.Schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>

When background maintenance attempts to perform a prefetch to remote
servers, this may trigger authentication requirements. If the credentials
are expired, then the credential helper may need user input in order to get
refreshed credentials. It is not a good experience for users to get
credential pop-ups when not directly interacting with Git.

Add a new configuration value, 'credential.interactive', to specify to the
credential helper that it should not prompt for user interaction. This
option has been respected by Git Credential Manager since 2020 [1], so this
is now presenting it as an official Git config value.

These changes were first merged into the microsoft/git fork in August 2023
[2] but were not upstreamed immediately. The change has been a positive one
for users of that fork, as they no longer get pop-ups and they also are not
getting maintenance.lock file blocks when the prefetch task waits for
credentials. This has become even more important recently as credential
lifetimes have been restricted significantly, leading to a higher likelihood
that this will happen during a background prefetch.

I was reminded of these changes when liuzhongbo started a discussion [3]
about maintenance.lock files and requesting that they are removed if they
are stale. This does not address that issue directly, but is an important
way to reduce the lifetime of maintenance.lock files when blocked on
credential prompts.

[1] https://github.com/git-ecosystem/git-credential-manager/pull/91

[2] https://github.com/microsoft/git/pull/598

[3]
https://lore.kernel.org/git/cce1d054-911e-407e-bc26-1c0bac4dd8e4@gmail.com/T/#t

Thanks, -Stolee

Derrick Stolee (3):
  credential: add new interactive config option
  maintenance: add custom config to background jobs
  scalar: configure maintenance during 'reconfigure'

 Documentation/config/credential.txt |  8 +++++
 builtin/gc.c                        | 53 +++++++++++++++++++++++++----
 credential.c                        | 30 ++++++++++++++--
 scalar.c                            |  3 ++
 t/t5551-http-fetch-smart.sh         | 22 ++++++++++++
 t/t7900-maintenance.sh              |  3 ++
 t/t9210-scalar.sh                   |  7 ++--
 7 files changed, 114 insertions(+), 12 deletions(-)


base-commit: 6531f31ef3bead57a3255fa08efa6e7553c5a9a7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1798%2Fderrickstolee%2Fbackground-quiet-credentials-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1798/derrickstolee/background-quiet-credentials-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1798
-- 
gitgitgadget
