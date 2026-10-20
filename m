Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520357;
	b=5ZVQRJFRS1FMniwVIVTF11D/FYqf/pXL3ZdBYL9kk8dBPIj7ZoNOtwwMYNVWapDkNzDU
	 ZB6G8eFxYTbX7fqpx4avE2h/jOr1KRrx33ePcb7Y+nnuVKOO6B6OFNAfGAtvXLkuxKPxt
	 M32U+F7JgIUAFY1up0IsODFlL8DcpcDqMFYNkWYFywLt9ynvUmW9/dNAexH01prpdytXx
	 89/9yaxYYId1FmwlDV7X18fkzA+18IQQetwNg6ux6RgiOjhOlUvVFKzwkTu38vrhU5/tg
	 Ex+xmIGtP+0sAlcIZQP0dUyeXVIGe5sZJLbV4NmOkcC+XRcabRsJar5el/RwcLl5ohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=0DeWlfKdthZWk97gWRh+RJMCpsxfhtgWRhhmJDNovSs=;
	b=rqp2MCGIPffYB+L+JFogIBcHZaREQ6KAlr50tOsDD9Y7ttTcT7KFDAmV6xcw+Ych7OOA
	 xihBmq03N+jjP0r30s/RzJm3NYzrS3iQALXtqF0bFCGtqndz6tSmfY5bZxryCJGNhFFuv
	 EaaLZl67yn3v+tw8j9cCKwX0l0PFbzJFabR5a1vTiUAQO3pnPUjpGWgY2gCk2u3msXJUg
	 JaV480kVbnXbf5sSoxRTHR/Z4d63yxVM74f8ZLqhDjHQP1TgWqHz6EGk03Kr5Qp70PcKv
	 dr7V39l+niC7bPMkik1L81+yGPf316QXWMEmVDjYQdjC9dNejfBYiqckl8AdPItB/BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="SH0L/Nml";
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35B60A263A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B35B60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SH0L/Nml
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-47b47de8b4cso2486431fac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520355; x=1793125155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0DeWlfKdthZWk97gWRh+RJMCpsxfhtgWRhhmJDNovSs=;
        b=SH0L/Nml/gugMYVMp0rXFTpssY2TCasFJ6N22gf3b2fy7akxnoz927qhoW8cXdSuyR
         ZYi04G2IRTj/WPgbHsn4SbgsacqCNDOrF3QpRd7hETnR/AmW9bD41w+aq0DHMSSwaxOI
         nW0zmMME9qaWHrVqWac5bEVdxPLesgztbMx2K8k/HXdhijF2GUZyBck2phmYDWpabCPi
         sft/IoDrGfyohyaOrrOV/DkdEslXSFlxPYnYCaphAScCZo5XHdu7QdBGHQ75lrUsghiJ
         mKtUzOkHnIA5Ho9dKU56z5khUMHMD1UH5681yYBXhUbIQkfFunWR3EiMjOQCQeczt17I
         LQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520355; x=1793125155;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DeWlfKdthZWk97gWRh+RJMCpsxfhtgWRhhmJDNovSs=;
        b=TAzIFH+yG58ieH44RZdcLG9ovLlmgry4Fh7L+t4M6PuQkjJZ3TpLMGea3sZP5DX1Zj
         XQgSEaXvQkwYIkWeEnalNXcYXnngWobDRiEzy/Bby65q4iQviJvqSv1NvlURHTPmoOYX
         bfCiwjEo57aRbvdH6uFWS7TNxUc56AysI9wiFMWRV3RYbQqtBHXxCjVMhdT3uWr99bU0
         l78UW3AbAVdl/hI2x0c9K8X2P8ts8G7fRdVcDypozEQudqkRsL1GwO/2zZxZpG5+TIG7
         FfaZOmgMF8so3mgBBG1bgQVlht8SfpJs+9ZeAHMSFoo/yJ3RiTVNdMmaATDzoXTUNSbK
         hK9A==
X-Gm-Message-State: AFq9FYJht5Wj1GnerV+cuxeuuxgg1POoodeFwt4bk4H/ePjCl/2uzPjE
	Jozxo4cnhxNYr1a1F5lyzOwP24qIgj61chOAmTizm2uv+yg8PBSr63Ext/wsGA==
X-Gm-Gg: AYBFou0PqRWgSINxQsF9pFxocmmJBlsAR/32kCjowVKvCe5kqp7I5+E6gMqGG36uaAJ
	DrIem+YQcNrCealaPZxScm5/Q+acSURHXkQ9+QoUZUvGhMctFmzl+MQ9HDOLPMvRit9c8n04iGS
	A16fQfJfYQZXn4Pxsv31x7qObBVrjUw76YDIiEDhWSOKV5ZeCu6A6aAAvubrYug4sC+Qm7ZzXwo
	rtEwzOIMfEHSbaBhFM4fxaVEXVhmaLIbtqeFQf64ZS/nvOlmmUklKuIgEu6ZbGNRl9JlMbSV9uj
	1UXRMnOd+mofzzxdcJ0RgHXu6VoKbaYMIhfapJnLTf4HIB8ayfA5btw7f6PYo7S42FW/jXl1pFg
	JShuS/1+G8c2C6JJoowOemcykt98O5IJsoGVoDLUyAmX1XHp15H56yTKEe6TYQE9JK7/rAD2G5n
	C5YyjRHLuEqIvogKS0LwHXOEBT5GLXIKFiUYxrP80mD+nYSDzoOTmpge9AzmTWzaCBbdW9Q3THF
	7XDnSx1iwhsUPjU+G47+18Ui6ELWU39R70KjlG107yBgfsSw7eRpOW6VpI=
X-Received: by 2002:a05:6870:7187:b0:4a7:163b:f528 with SMTP id 586e51a60fabf-4a7575d3327mr9923004fac.1.1792520355210;
        Tue, 20 Oct 2026 11:19:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.125.200])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d622c09bsm159309fac.17.2026.10.20.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:13 -0700 (PDT)
Message-Id: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 18:19:11 +0000
Subject: [PATCH 0/2] Fix two hook configuration bugs
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
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
    Patrick Steinhardt <ps@pks.im>,
    Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>

Two small fixes for hook configuration. With the first,
hook.pre-commit.enabled=false also stops the pre-commit hook in the hooks
directory, as the documentation says. With the second, hook.*.enabled and
hook.*.parallel can be given without a value, which means true, as for any
other boolean.

Thomas Bachem (2):
  hook: honor hook.<event>.enabled for the hookdir hook
  hook: accept .enabled and .parallel given without a value

 builtin/hook.c  |  6 ++++--
 hook.c          | 17 +++++++++++------
 hook.h          |  8 +++++++-
 t/t1800-hook.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 71 insertions(+), 11 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2272%2Fthomasbachem%2Fhook-event-enabled-hookdir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2272/thomasbachem/hook-event-enabled-hookdir-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2272
-- 
gitgitgadget
