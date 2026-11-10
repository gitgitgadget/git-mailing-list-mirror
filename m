Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337923;
	b=ft2ajN+BIBwXH51bbzlK0BzJBZD8drOO8IGbdT4Pq4ZsCU41Sz9BXa29qqGBKw5B7IES
	 gLRsxeyPe3mP2nmYltiU3l5o5Lnlpj7+s9uh2E5IdBFekxnckxDAXeH21T1niFGI7Q5Lv
	 N6nQxavjrI+3eTtwUOJxA2W61pQY2HBMPPbudzf5/kmbLS0OT0EIaDaCG2dpsko1gWK0n
	 IBZ0HYK6Ozr1i91z5/c+HwPl03pgMlaeK+jm1fqMTz1KC0ERqJwdYtsHdP991bPiyhSY/
	 o8f98wc5YkEo8i3XJW7P5eq1lzq+48zM593vWZ3qy9AJXf1MoyGO+osT4QKAsYMiJPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=I1MQ3FvIaE9YB0vfzH9+neWqBDMW8tFO2hfJzkWhKBY=;
	b=2/PUHy4jhmnhtcTfY2uS5lXPfeaikDr53r6AkXoc1tpwmilKTe+VIm0DsLZA5+pMkAXj
	 ftPcsU0Npgnf3T7gbTkQdE+Edp7eHFwvumVo3qC4GiAaU7mxh+CHRvKOsoAMpsALwhAZd
	 CCCUn0TwtFOhhRRXEAHSVSHzjcpXWHBXSIKwep7sivvjCEOyJcBXjzoQBNWYEwpaGM4YK
	 tOiw5V6ZnJCk47vFatljl45xEqtH/dvVTlrE/RjBQ6Qx4MzevbodytyYlcYIZDVl0ftZY
	 S9hVRAkXorhoJliPo7wuE3Uu+1zFwsL69QUHI7Jldf2OjWlawuekKw5GTSJroPSW4OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWGXfnzI;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1B606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWGXfnzI
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-717034b331dso1411039eaf.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337922; x=1794942722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I1MQ3FvIaE9YB0vfzH9+neWqBDMW8tFO2hfJzkWhKBY=;
        b=EWGXfnzIaY/RoAl7YmHI63ktfdNDN1L5dclsbcFdpIP0oqD8gNBMX0jJ0Ely5WSX3Q
         aeY3vUnw0aSl9DT3eYXVN1Gzj2i8+a/tXlZIm+jmJuwS64M9SXDy2i2kD7KgLWQWfuvF
         ZjId5z3VG1/Iejc5ociwYWDo53zgseDtFTpryZD4LEM1WDoZ4r1b6ABu55mKeCReh30i
         5at68Dj0mkoi9dZsWRWapnIXzSakft+HBpwq+o3YB/jYT3GGUmlL+GgGVf/qME4OTGb2
         l+BtO271iswYTkLfMgy56S/YndD8PZnIDeNqKF3a5YAVEApcZmO4dGGERPmb98m831Xk
         h1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337922; x=1794942722;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I1MQ3FvIaE9YB0vfzH9+neWqBDMW8tFO2hfJzkWhKBY=;
        b=BIv2U76u1L5qPetMA3hoMmLppy1iR3tjCqtzZ4K7pngHwSGivqM8KwSj6KfEbA0MBF
         xdT7nmTKOO6br4A8e0t6iKUXtjPWbUrVaGRZkF5Oxn8WmOC95TwPuKVsSLggT5M8yxns
         nmCMDf1c4+e3g+hGtvcLfvFN01hfWd+3cll24pl/SIr7MINsciUeyHK8muD5iRFmR13F
         yiRdn1imj46y0elQxFTfP8+iBwtfOwJCm9lwPr8AjTHwexMQMRQFWVG0buzb+M7PB1g6
         s67+VpJo5CaLpwheQXg03g/17Y3oHvB8IrGoyVc8Ujxdc0/gqAvFofwvaF5foHHECsQH
         RLKg==
X-Gm-Message-State: APuU4Z/ZFw0G6Y7sVqkdzmrLzItAK7qQGr3eG7ylmSU6qK95mRlFs/U8
	suMpR/rXs1v31gfvXImoKxOKnqaEwHOTXPnrui2q/lKNdnEv9xLD7XR5Ak9LrA==
X-Gm-Gg: AYBFou2EdDRwiqeCXrqCEoqlbE73jlJvw3c2vosX1Sq46ngnNn4IPZVNM43nlj7enZc
	gkyrH/7EwXBVo7QSETNqstdhPTJeyE3wa2aevMV6SLucrAzmyRGgbSRaYRKVsnnZhpom9rOJljj
	DaeM1NO82kXZjuE8igqfhvWStTP7IGwXfQRFMKTfBqBPjGXQyFmO8ytt47z7QUVFeH4FxVlYYnW
	ZKwaITqVJNw3vZXawC373xYlNF3W/soV4KPwvG6jXUKZgb7xtSMHzbHAP2hB2MIIyj+MRDjg10M
	hkl+3+0Vfy3K58ybYX/qMy2hFGQF5vJBmTAAwsmlL2Z+o3z3cg+mMUsKlfTF5Ul1Glq7SzGx5hr
	+Hu+V4gkpUu1R/0E7YiOl8zBQOwpbDr8WhnZ/cQgOf3pP6ezz4PfFZm9LW89V0C7uD8mgEsFBvf
	Z0P8tCdr9O2CN0a5rhITSUVvpLIX+xVQNLXPfkCVST8MjFw4qe7YKg/K0QpWRD5+p9OA8K27WFk
	TgZYC8vuDESKsPH4NkIdBYLgjgxgmHzoV/8D9Y9Uwnxryi8oVioX4yU2JtkrCZiIuOgJuY8umfV
	A+c9pHbAsdcxa3bZZhsaXrV7UnxiXm4q
X-Received: by 2002:a05:6820:c5d1:20b0:6f8:2346:cd78 with SMTP id 006d021491bc7-718a1883addmr1388604eaf.5.1794337922277;
        Tue, 10 Nov 2026 11:12:02 -0800 (PST)
Received: from [127.0.0.1] ([52.154.21.60])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a6f2a264sm2311559eaf.1.2026.11.10.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:12:01 -0800 (PST)
Message-Id: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
From: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 19:11:57 +0000
Subject: [PATCH 0/3] Make orphaned commit checks configurable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    stolee@gmail.com,
    wyattj.holden@gmail.com

Hi there - my name's Wyatt Holden and I'm a Software Engineer at Microsoft
:) I've been working with Derrick Stolee over the past few weeks on
optimizing git in the Office mono-repo. We found some issues around slow
checkouts on mono-repos in an automated environment:

When leaving a detached HEAD, git checkout and git switch
call orphaned_commit_warning() to warn about commits that are not reachable
from any existing ref or the destination HEAD. This requires enumerating
refs and walking commit history, which can be expensive in large
repositories.

In an internal mono-repo, Trace2 showed tree unpacking finishing
approximately 12 seconds into checkout, but the process continuing for
roughly another 193 seconds. A stack dump captured the main thread inside
 orphaned_commit_warning(), enumerating loose refs and opening ref files.
Running checkout with --quiet, which bypasses this routine, reduced the
observed runtime to approximately 14 seconds. However, --quiet also
suppresses unrelated output.

This three-commit series adds a targeted opt-out, advertises it when the
check is slow, and enables it in Scalar:

 1. checkout: make orphaned commit checks configurable Add
     checkout.orphanedCommitWarning , enabled by default, for both checkout
    and switch. Setting it to  false  skips the reachability check while
    retaining the previous HEAD description and normal checkout output. Add
    a Trace2 region to expose the check’s duration and tests verifying that
    disabling the setting bypasses the routine.
 2. checkout: advise when orphaned commit checks are slow When the check
    takes more than two seconds, suggest the opt-out and explain that
    disabling it also removes the warning about commits left behind. Control
    this advice independently through advice.checkoutOrphanedCommitWarning.
    Test advice and suppression without relying on wall-clock delays.
 3. scalar: disable orphaned commit checks by default Add
    checkout.orphanedCommitWarning=false to Scalar’s recommended
    configuration using its existing set-if-missing mechanism, preserving
    explicit user settings during clone, register, and reconfigure. Document
    the tradeoff and reflog recovery; rely on existing Scalar tests for
    configuration-preservation behavior.

Ordinary Git retains its existing default behavior. Users who disable the
check lose the immediate warning about commits left behind; those commits
can still be recovered through the HEAD reflog while the relevant entries
and objects remain available.

Wyatt Holden (3):
  checkout: make orphaned commit checks configurable
  checkout: advise when orphaned commit checks are slow
  scalar: disable orphaned commit checks by default

 Documentation/config/advice.adoc   |  6 +++
 Documentation/config/checkout.adoc | 11 +++++
 Documentation/scalar.adoc          |  7 +++
 advice.c                           |  1 +
 advice.h                           |  1 +
 builtin/checkout.c                 | 31 +++++++++++++-
 scalar.c                           |  1 +
 t/README                           |  5 +++
 t/t2020-checkout-detach.sh         | 69 ++++++++++++++++++++++++++++++
 9 files changed, 130 insertions(+), 2 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2264%2Fwyatt-holden%2Fwyattholden%2Fcheckout-orphaned-commit-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2264/wyatt-holden/wyattholden/checkout-orphaned-commit-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2264
-- 
gitgitgadget
