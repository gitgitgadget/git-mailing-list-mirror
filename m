Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484989;
	b=q7R7e9OBLMjHTocAJOSuWvnI5j5YC/FxfaIBUmn4Y8EsifI2s069NF4M5PChNy7ReDdh
	 eX4ghmNiVP0hn2iLcUgFS8FTO8j+WnOVFX5LQrNmBtjgA4paD5RV4MBaTYj58dtMdP2rW
	 +NivkqBTlDuR28J0yqxmr+VebUhDIZCyclCHWp8IIhbaVidQsRAW5JZkB3+2a4ay3Cb56
	 ldEhpVMo8P6zxVAoUuUyIOBh4LhuelmjIr9hP1qfuiLGEo+N/hS4ZqqsO0QnnQ5WnsHEs
	 IV4Flz2gn+a6RNv9A/gqAOVmnNB4lFQZlcynR43Fk7/xBzb9QaNw+98uV66M+WfunpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=ZgrHe4Dm9MKwswZjPYrnbHj4WpRPYemEsbRo3yKoy5U=;
	b=aIZaMc1JjoqaENvu+DM8g7ICfjd5ZEuiN/mPhIkxxtm5KXadpDt15OG7rq84/nDSuEXJ
	 XzEHYnoInZ5bdV/8WRomlgzwuKJMI9/M62CgHbUwfL/PA8tn/BvKW6vowcC65RzXX5Zh1
	 66f4QTdELAOqGQflShMP1eItmkLvXJvppMAjUoVR7cX2XHfvYFapezZ1s4WXIHvX0N7nY
	 PLHQgv+ZXXctLCglJuoAMFfmDS+A+lFkplJPQCMDknLkbKHUXjd5gWwMHSgdvAIQuQC2B
	 CZKg5dbufUkpK7kLjGiV14b+sANJRPaZJ9zp171neCpWFAgbVMn8aaOQUe8EP5MkZNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1DQW1Qt;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BC606A88E
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 12:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6BC606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1DQW1Qt
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ea16d8072so31896896d6.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484988; x=1795089788; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZgrHe4Dm9MKwswZjPYrnbHj4WpRPYemEsbRo3yKoy5U=;
        b=D1DQW1QteI7h6gKMOUlMeGz+ZJ9fikQzT0NYksEvNbkwCMbTqzzDjyg8LTRIdN3C2T
         2BZ5cfnCv9K+DAAE0RmymKVsrK+lQQK5+GzRrLe8voo4Dbj45wRaXSxDDQs+/suVD7Dg
         /xSgoR3M8EOCfUBvTR85c+91LWnbikLbEdv6S4MdqGoB7IyDkn39lD6i6aIMgdqo83gp
         3QZVh7ydD8W7j1wrdNuXX7baKj7KvPESqeO5Bu71kFrUuQNbuyb4+9Mux5xF3YfGY+SS
         tPd5RFuVgB2RhYyQe9jaamwEJEgIL5t9I3lMnOCyJ4uR40PpTSTpj0r7XR+agPQKcP9/
         DLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484988; x=1795089788;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZgrHe4Dm9MKwswZjPYrnbHj4WpRPYemEsbRo3yKoy5U=;
        b=PGoaqNb+GGbvyE0QcfPmrJWlWc2FN0qZmSetnMcS2G+9OXdrLbRlREjpBpX4215vtR
         TVtw0yEZIyAa8DG9+9gxvXQJ5FYM40VBybcSaNyXs5ih01Mv3z2SIueZDptyKLKGUXN1
         ECv4czztPzb5Q+CUqUXDFGx0DiY+KIivpUjr2qW7hRDKO+ynrOrd9H0h9qDym5X9lzXu
         OcSwWUCkK9KNn/hOP4S8dQ7b168VlIsIOMAIh8/HmjF1zClzxj1jB4RlFdD6KOZ27NRN
         AjpuzRHwq/MpdILft9zQUB3lyMIjB6tOOJK1ABUPuA2LVdcmdOqivw84u6QLCRZTGXfn
         rEmg==
X-Gm-Message-State: APuU4Z/xe+vhO8P+ck+9SyelR+Hi0bCOxVdz20Z2MSiGivsdWJ7TZQx+
	UK6fbrNQHL5Kvs6QsEX7oOKJ1vxdDg1b/OoSP0yUmXqZWNPYtz7mnbDEyGvnpQC8
X-Gm-Gg: AYBFou0cUJL1Hk25ubDeB1rH3tK9BBHsh8uv4n2gsy8uKg4ejt2d7fdpHEnAzMovMVn
	bwCmNb/kp8A9QdP0/ER8Ce8zvVNrif9G/2RG65CSgkAp2qhqel0RX2rwUYJuTl+x6yvKUWnZfK3
	xbtLzsVbbGdnj2fMzALK3YDBsJoB22BRLNGI/ImJQtS3R8Agjsk+XYQfc6gtrYDQ8ld20cLrXXi
	MQxiTrOtmVALqiO7y2ytmx0cKCtEFob+AR04oRDX9zqAmoMd06Ldo/kQbM+h8cQXQEV+iQRq+nN
	zfZ8uw7NCEDs9MhicW28b/aPCwZT42JMTJ81qfYs8Fm6UWnSPSMuWeU0e/rJ2A7FyCe4qjFh3AD
	jCd6OwpdrAHXFnIzPD62o+DTtvlxhefZSLC/2uBPlzyYgXcBW6cRWC2SXdx9la33RdDV8gq6+x6
	GzJoUofiZrI+zHoIOMfNNhBpKrjsXvo7Li2FnPbrcQgSqgAnUmqlrG5gOM8ZYCdM/FyxRb9VC4b
	8+VDqKJXq6AW06YT6cVfFPVTdvtu8Lt84edosMeEtX8qY3t4HxApesQk6dwDmCaVZiZxK49r+ZC
	z53SDOp2s7hRqXL8EhiR5rUeRLZw9SXB9jlY3RZXAN2Wuyzgr8jmUp8g
X-Received: by 2002:a05:6214:4a05:b0:91c:8fa6:1789 with SMTP id 6a1803df08f44-91f041147f2mr92154086d6.28.1794484987713;
        Thu, 12 Nov 2026 04:03:07 -0800 (PST)
Received: from [127.0.0.1] ([172.206.245.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91efe5da1b4sm52460016d6.13.2026.11.12.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:03:06 -0800 (PST)
Message-Id: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 12:03:02 +0000
Subject: [PATCH 0/3] submodule: support worktree-specific configuration
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
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When extensions.worktreeConfig is enabled, this series stores submodule
settings that can differ between worktrees in the worktree config.

The changes include:

 * [1/3] Keep submodule.<name>.gitdir relative for linked worktrees.
 * [2/3] Store submodule settings in the worktree config when
   extensions.worktreeConfig is enabled.
 * [3/3] Make git submodule init copy an existing gitdir setting to the
   current worktree config only when it belongs to that worktree.

Yoichi NAKAYAMA (3):
  submodule: make submodule.<name>.gitdir relative for worktrees
  submodule: store settings in worktree config when enabled
  submodule init: copy submodule.<name>.gitdir to config.worktree

 Documentation/config/submodule.adoc        |   3 +-
 builtin/submodule--helper.c                | 197 +++++++++++++++------
 builtin/worktree.c                         |  23 +++
 t/t2405-worktree-submodule.sh              | 129 ++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 131 ++++++++++++++
 5 files changed, 431 insertions(+), 52 deletions(-)


base-commit: fbd2d1e765da4d2931cadc4c62d3ca5d5b590e7e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2306%2Fyoichi%2Fsubmodule-with-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2306/yoichi/submodule-with-worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2306
-- 
gitgitgadget
