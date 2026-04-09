Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D382EA749
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710782; cv=none; b=QRPvAy8UgwH2jq/5klfoHha2KL1KNHzu0IAtKgFc+ZElFGHRgXMugjuPzKzHxKcxQV3OVqCsaWdOzZ675DU2ZqAruj7sSWwkp8fYqJiGijI1jRQ/SlsMLjffERiVWbSJyejt7LEXhxGEjuAkxZCvLM0dnJ6v1074UADvnNov4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710782; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QLaUt0hSwTO4xaVAsy8cjlYjGwexgcj405zk/RmQSvyJ7QibxRxe7BvZxkEOp6NJsw9WeM7fbCw1b//ZF3DK1mpk3YHNG0mEZ8I4p253PyvI78eSeL3v4IMI4MmEbWh9zf8lgO1u+9TOQ7ZskNYYIIpT7x9nB1/AvzWA8CECWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjXQSX/I; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjXQSX/I"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d67a483d3eso41834885a.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710780; x=1776315580; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=bjXQSX/IoyNnf8MZBy8NgxD/xIGjBcdf7GC2TlwwxgQkfP4qS2TjDNcmnOAlsRUfEs
         vXpEwwBV5zL2oxyBf/D3BGva87NM/7y2D9+qFt9rq9Jd4qKgVFN9FxThtEJT42Rn39jb
         qnGRYvdtxj6WQJ70RQSUBFxStuWo2PG2pkCUYqHbkhCXhGAyXumNLfi0y0h/B7gKTQjd
         Fs4leG7TnR1mdfUPtZdEF2LyHWUx7pF6q0kcNvJDEaHGQzTsW5ZgYyP1chANtTp4mFIy
         dD7zeyKWgXpcB/SgaD6CmAPHJtX7YGYYPhAAYf6JbGBgTWJywZW/ecUrv67O6D/NRv3r
         wBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710780; x=1776315580;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=A1Iu3C1fErP2LpBHT85vcnu0yavlE3+0m8WE+XxHKGrlM/FvfL5TzVbVuZ+9/DbSOm
         2opGDSMsxOJHcpr2tt7ne63f15WAbSpwRVVoC2/uSHv6zIttFO4k4jqBp8+dh3Sswph/
         djEuKLD61mKHHuK3uW+eFH3iTsQbqjduXS+ygACohdKUBkxXZhzar54AFRXSCCKuXI+J
         fJ7D+bGlzyTpTQLvX1T2id7czp50Fm263S/ibVJ4W6FSaONzTokStcm+3V1jctl3oF+t
         w9GbmH7hURylVgqTB0Ysojp5zRL0eLbHeTQmAXQ+j47bzdxhHxJ8+1qf0qdV8wK7lfsV
         7NCQ==
X-Gm-Message-State: AOJu0Yy7kCdU8RvK4i1RrC2rMKt5Pe13lWpYOz3y+aPRVhzi2UA1Veb+
	GZhWJnf4X5OHMxWUcfOYrHPqeqfRFqS682ymfl5FwL31jaZiNq0MhzWrK0NRbg==
X-Gm-Gg: AeBDieuH/L54zQ9EZVByPV1E+E8gny4A2sI/NlhRbf/G/dNYJPO3dBBPL27roX3J4L4
	rbzWuNCSXii/6Fu8rbXfGsv/2aRaiBdlVi2ybEYrX+E2qh8r7M4o2o4OXwf2sjKxQQxiRTHQhdA
	/3memucVv/vtpuxX8JZCXoDpDmpaFF6UDasPdNe/AIum7mOy4FBCld6bp8s/gW9cIWmAyk0BEgo
	wKAFy699X0WhsWZKcqzTTLQSCsN3/D+3iwVTFUK3ZNyXK0HZ49cvnbOwF2/fI6Ik1ygazhhMM8F
	jsKfAwqOiJL6bbiT20ETs1pwEibwO0YcLMhEVearETMaS5t2sjYWKa9Z28AGYOIL1aLoDoJwctj
	aKeTNKQp6lNmFRxwyz6U7iNWC07OtkTNtNlBV8uZNoyY81DrCnizQp6bFh15u9+ur42QRo3R78w
	WwZ+0KtfmIfB19R+rRKGnD0dFCzE16CQzVuDZkAw==
X-Received: by 2002:a05:620a:560f:b0:8d7:e7f4:7e9d with SMTP id af79cd13be357-8d7e7f4888bmr1555432985a.59.1775710779880;
        Wed, 08 Apr 2026 21:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d526e26c19sm1330237885a.18.2026.04.08.21.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:39 -0700 (PDT)
Message-Id: <11ba6ca9aca3a693ce3eb03df802e2c8beaa2019.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:25 +0000
Subject: [PATCH v14 03/13] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  The cookie entries also have names allocated
via strbuf_detach() that must be freed individually.

Iterate the hashmap to free each cookie name, then call
hashmap_clear_and_free() to release the entries and table.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..d8d32b01ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,15 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	{
+		struct hashmap_iter iter;
+		struct fsmonitor_cookie_item *cookie;
+
+		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
+			free(cookie->name);
+		hashmap_clear_and_free(&state.cookies,
+				       struct fsmonitor_cookie_item, entry);
+	}
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

