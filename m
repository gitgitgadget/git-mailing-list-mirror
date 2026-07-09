Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB233A0B31
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615800; cv=none; b=R446L+JnQLUq2O9dDjwCrDTVNIuhBw96GgFIKQ9h0ZaQgktvloG/9KeorS7DBcPvb7cqAxWyp+k72MweMAVB+GHcHP2QOaZSR/HrKATqmV8ujuKZgh/YQRW0YZAGj7yimvphKpVgmZppW1FEAYZMPeR75SxmfZ3DJnVle4LgkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615800; c=relaxed/simple;
	bh=nQoo89Tuvwiq0Wf4memVLPmGl5DPelWekXA5nOU5DMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cQAP295ljuN+/HiDkkFTMOkhe3Txd1RXpjO32lDPAQnCm6IZf95MQcwWFnnKGaRQTndXIzuqDoDBs1PtcP+wGL4o1aYl0fEjZ0pEuEN8jDlORL1+JovKjooL9bNLx3m60mnr1QtZ0RDxFu17IIkvV41qAjuEJmt+VutVhIqKXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK0qmibW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK0qmibW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so38332585ad.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615798; x=1784220598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=fK0qmibWstRDBJ2gRI1tX99O0uodUzsBohUYWinF/6GSchDC3xRhf0WJ1aOYoDoPn9
         qQjs4jUNYJqlfauusMbQFXnj6miSqTXGKD4D635W8IcoqTDnrRXrHdn2dSS79Ru5lcm3
         uTSM9/sEvEbO74ebxYLHe/3zEC+mYDMB0nzTT0wnqsN3nw9JBd0EIl7sLhEGlSpNj9Zm
         5WC1qcWB22SKl01KX1BF1i7Nk6ifsSV8IjjkuOAGBlD9pq9fymqO0tVFaNGYyn78zZ8g
         XxneMfWP3eU40h7GTrAK5eXtKgIJqS/62t2887tFUN6iM6tyy5ydWlGOv095R+2SwQQ3
         KERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615798; x=1784220598;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=BzVTRR75jEZdpYAQlTkDoLhRqPLJvBw5WbY8ovVZNb3CYSpgLPC4GqIjO5XWJyMHE/
         DV88S0wyD+ZB0SYgfeDKHAwMtV+ZNamJ9+FaM3OuDff6V1QBuPk0grRQfMr0v0txHqat
         O+zavENihYTuZ/XJr1+eyTgpFiftj6egqh7qRYy8TsDjU20X3FgGuGH4GQXuH6icOj1a
         iPDZeU6DKkl7LqXyu6JpPq7y0COQbt0rRbHHdoUzaAFhpoaMK2iz9n8FPFX+K83dLUGr
         K2qrJCDvuDtZ9Wu6xWNoe6thy8+/7pllSqHcKvftknL9sdBQqS9ET8q7tz9ughipJ7os
         InzQ==
X-Gm-Message-State: AOJu0YwqE+JtSCCHN7KSfQpHiajmTwx3GFICBWIZHLfwNCIjKAGQyWbj
	Ev+nna85KStG3HwPPmm9rdHoIcZfeKWdqR30Opgd8zZpdbtDyVaqioxUxIbbcg==
X-Gm-Gg: AfdE7cn5FcdBtj0rHT4CE9KVam4Gcvudvx1AVkbWZuAMvRPJd50RoDtxac4nrWyDV2M
	4wpSw6Ucvn77KbNtwcmpJz7Izj6gAzH7o0Awgwx5kUqeK0FBKDnw5yzslk7sOPW+kSiPDJa+iDP
	192562ln3Xc3hqmOaiyvPI94Wu5/S7bR6y7BIvJcgSVWr8PKWw8nHNx0diLAHOS23AP5XOt5LOn
	A0sTZMCKkooC/gzab3ADKvChJcTiA9u4kPvzFt1JmcfdOn8NbE8MJ/GAoXmi52GLysTcD1Ayvxl
	9wVnZUPEqEXNPqdjRSqkpe/eEXCH8RX1t5fJZheGDc3id2caXxYnMPZNltd+86ZfJVwVVdTKbzV
	GKKUuGhmKxKcpqJYiNz6my7DufL/zUFFThd1uJTmRyNT1zejniMQ/5dI8OHgBCqQA/f6LPC0nMd
	WRKCziJfbFad46QTE=
X-Received: by 2002:a05:6a21:3382:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3c0bcfea3f8mr11368780637.23.1783615798303;
        Thu, 09 Jul 2026 09:49:58 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm35059604eec.30.2026.07.09.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:57 -0700 (PDT)
Message-Id: <2d4d19c5fbeff50340308b8cffbab21156807b49.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:37 +0000
Subject: [PATCH 10/12] http-push: widen `start_put()`'s size local from
 `ssize_t` to `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The local is initialised from `git_deflate_bound()` (an unsigned upper
bound on the deflated output, never negative) and used in exactly three
places: the initialising assignment, `strbuf_grow(buf, size)` whose
parameter is already `size_t`, and `stream.avail_out` which became
`size_t` in the prior commit. There is no comparison against zero or a
negative value, no subtraction, no arithmetic that depends on
signedness, and no path that would assign a signed quantity to it.

The original `ssize_t` was the wrong type to begin with: a
`git_deflate_bound()` result above `SSIZE_MAX` would have wrapped
negative on assignment and then implicitly re-extended to a huge
`size_t` at `strbuf_grow()`/`stream.avail_out`, requesting an absurd
allocation. That is not a real-world concern for the object sizes
http-push pushes today, but it is also the reason the type needs to move
to `size_t` before `git_deflate_bound()` itself is widened.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 3c23cbba27..2a07d14259 100644
--- a/http-push.c
+++ b/http-push.c
@@ -367,7 +367,7 @@ static void start_put(struct transfer_request *request)
 	void *unpacked;
 	size_t len;
 	int hdrlen;
-	ssize_t size;
+	size_t size;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-- 
gitgitgadget

