Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350A30F932
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693723; cv=none; b=D4Gx/oLTd3Q5u4hB6rSRcSgwBObjSvtYO3oNdH1wsDjbZfsF/FYfnvSBhFIJIfGxCKyUiaxvGLFWiNiOM0tn2fR+TQ1ombzXCl92cDMhprbhc3j4DxWNFOX7pxeDUM8oEKZ9ZgPdaHvURjaywI/lFARl4t7E736juv3NstwOPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693723; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZOMFISRdzEQoA4zDjYJZbWzjbJjhaBGbMZWe770fJYEeWPysjwB0TbDRz7YpD+WD3h6mkXPzUEIjvVt1L14Rm+LyWbYYZUcfQS1r1fZjt3cgdx6L2cKNnBA+vLvdspoSSHEMaP/FZfYqETDssLeyjgjkGRS2gM0Vi9Ddzs+7Xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdZcYMOz; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdZcYMOz"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8839426eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693721; x=1773298521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=QdZcYMOzaWJ6fGsJzvjsUe24dqrmeOcGZPZb/fkhH/XuDwbB827Rzz1MkF/nUtxqzv
         ic6mz810fPPiS9h+L5bVzzJgqfTuD/L3j8kYFDb7aeOvZuqv6ogip93WqKfxrYudKjkk
         KI1UYDwkpxuxqY2pzcLOhl+zUG8RyJexPTscRfvDNUVk9n+mc/Dz8IamUTH7orxIYGrw
         RGieIFOikaIcOXFThF2sFp1wzRf0ss3cmAi4ZC82uocdlhwFaGKdXDnIwCchHDU2qbK4
         zwGXhAyXUvkM9qRljXwLl1036rc1twOSB5LzSPqmdNz2oKABvShm5J9ovkhTLkdVtRbM
         FS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693721; x=1773298521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=sDGRmR5b/e3zZ+hEiedHA3WpeMeL2ldA071+jxO+jiyRRtnB+dHreN7/eDwxdv1VFv
         HMV9al1YwZyLVt2+mklAp14Nya8t8/IS2i5ysuBMUExT3d/Y1BGGm5QH+T+TZbVPypPP
         PFYum+sFNrtqyI2TeVwV2mhg2l6dClRPCFtMaOUkpsEp4XUkEUfpaPzrInTOahNxajw/
         QJcrlAuBlv+KjpKlr319OXDwDjk85u1PKSS0E+DijMdVzf81547ThH2gC51UymsQsd5X
         wN+MDUEMyq7bucF8NbcBXZVz1wUhE1kpupodIzmElJCX2KNNqvXh2tmz+wbwvrIFq9Qj
         wrIA==
X-Gm-Message-State: AOJu0YwNLF49IjEBBeaScStX6xLsv4VMza1oUBX9tZ903CSx1svxryPg
	/HUI+P9mUCtY/EaFK0lb07Sp2KYqvwi+m8UaJHTl8iQrEmS8Tit+xEsCPqhD6A==
X-Gm-Gg: ATEYQzyampmiFj8PwjXPd0ahzpJg58YVrFKauXzD2Jgsfu1FuszBWKz74ZCIryvIpLS
	EMm8XCqqww0vFZYHBt2ZbVcj9o8ua8ddXEPRXv3YSiMETxV0CtK4PX487mmE3Q/LROZwSUXoUGq
	s1/BYHK4YQUGXPnCLHJTb0Sf4X3taiD/mWfIO6k+/a6gZYXgcpftpskMLBHXgVYy7hRPVRsf1+a
	2CTPt7aCcvfkQoBt9CF2kuyH8KRk3MMhnj2Q7TzEae1UIMhX8K9E3YKv5w/ihe2e6CDidcMmmGG
	162YZIi6Zr6rfDOw9jopAur1FVASJRcm9gmH5DPTkJdjOtAKySGwSEvXEEO7I6CJqolFhwndVSJ
	2pldhhBMVz/RE5C+PgrIX2DiLn0+fNBuQlgLfb3rMYc3mneZ6WZsk8R9XNzAqmSP0gs339c9tMh
	IVrSWC4MK52CUOAhbMNRUNcWlDgC2BBJETcmH5
X-Received: by 2002:a05:7301:408c:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2be30fc14ebmr1568063eec.4.1772693720629;
        Wed, 04 Mar 2026 22:55:20 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be3734fec9sm2103192eec.21.2026.03.04.22.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:20 -0800 (PST)
Message-Id: <cb270120f0e27a34a58c856b7c80e78e2301c989.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:02 +0000
Subject: [PATCH v11 02/12] fsmonitor: fix hashmap memory leak in
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

