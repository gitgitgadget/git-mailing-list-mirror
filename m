Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10E29AB16
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314723; cv=none; b=bE7YXNbtAEqjoL/AUgqddu7xmencZzcY/18x6HECW4jweelSnGpS6xpTsS5GIp2Ynu3GAUQHYfit+r7tr3KzCjNblpNKuVVEZ3dWQZjfP/GQFboimmUY6ayLyN/2az1tJz6tjUajH9iRl6mkW+b2HXf65i+s619h+Xb4LODwfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314723; c=relaxed/simple;
	bh=ZtxDSmhvw+RmpVzM/pOYkudhJuYo4Xg/Dpvwv39nl9g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lLLU3Vrg/llr5VbhYWPFlSzHRVMLsqHlklGoSa6yuQAu6WNoM0gGSG+4nBpiTBnsfkGyVJFdj7pBdjg5OEPt098metlQro49Gg101b675cRALAiPDQXmeTGgAK6BdnH46zknUFdjidWaMj+tJlVmWj8TgdfEYHMDOosCeFFAARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVjcwcFo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVjcwcFo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso9256175e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314719; x=1747919519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKAm5p/TVwARDVGs0tJ3qKY7tYOep0dCVjK01kBhV7o=;
        b=VVjcwcFozGxD4xKCwl/lOK4hlQF1kMWmGnfT8oCAe1zrwizBxp4yH2yPHpJQ4G3McK
         HON+o3xMiCrHVoO0k19ZAKF6Mul3yCyXcVka6XcMEQJl5PzTDGHJGZKj1/iF9o9VvZlf
         MDpjVMfw4t5dynGQICWghUVKQ+Fu6ijS3/gBkmBU0qXPKPgQQnyeptzdmulANaJ9urWC
         kSiTi8NfLXotTyD6qr+C6OngiP/fc87NJ82mu+e9WeZc8D1LigQz7HEiLiGLA2Gn65SR
         v28UzY9CEX8Vr2bb+LbUbzmdsIaE/48o/sZO66jy/UQEV7QPuV/3avggiAmS4ZDQH96B
         CA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314719; x=1747919519;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKAm5p/TVwARDVGs0tJ3qKY7tYOep0dCVjK01kBhV7o=;
        b=oTin/5FEUvJE+sBPJckFXOPIXFpj7QqGybn67Y/RYVHcdxFhCKY+N7uqQbs07k6Sqa
         d8YlcdATiEw4o8VB4adqRnv64pG18AIhQC27MgTetbVOjehPjcwyksVYPMMTWwvUVN+q
         tPb5BuofxQAfejQu17YkVnHBEhtoBU5q44L5OMv0RwpEu53WvhSSQBWJx/5L0s9snKTX
         DEAchz0QKPsBX0T8uihOyPrAKJy98BPF4V9rnX059/uF+ULH2OVr/eQuo9oXxhVIZ+da
         DZRoQM5u/yb4O2bTmnbp1YVwSqgmOyeCDvp/Ejgka/tTg3LvYHrA6YBhfCanXskMvOlX
         PMYw==
X-Gm-Message-State: AOJu0YzV8xMTsgQfbJixm9NDTbGEvQuiTzect0cr2PXvWOHVtvjmNMOC
	xHQWDEXdWFIMSaKjhPiLopX8HqPO5yA6WZxBbxZRQppQorzgapD/rwF3Aw==
X-Gm-Gg: ASbGnctdwAsqEyPAL2U98m+v4U1TQhpj84d2vTBt0u5d5y+rxG44c8UXCwotAPNtkQ1
	dI1KQrwgeZHJ61VqmqyfStw0MY9hSsUTPxAdyHX+bDAtz++PQtk0gisAfc2RWEXVh1f2qWaBKAN
	qhwugfYHqETOHXEkcGS2M7lp1FyB/SAT3XqmtLW8fD3NDPF2aA3hdopA4CdN9qa40keVLnMX4fc
	iS7NV+t0PJyyNC9fVxdMHWzlEVAhsMC/b4orFy+x0Sj+uOEDP9dnKWaNlx99mJ3MHX3AH7ffS4S
	FPtBE68eLH9E53u5im6HMV2lC45eX0JNGDzqwRdK6zbI2OL9QRvHEsPkN1lxscY=
X-Google-Smtp-Source: AGHT+IFYPDUSJsCxaAdwpsvC6v8RrWMLk1bKl6vRb5Qy4+LSfEEZGttb9NV8ZjhE6L3sKDe1AAOU+w==
X-Received: by 2002:a05:600c:3592:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-442f1dd5ec0mr70423725e9.0.1747314718892;
        Thu, 15 May 2025 06:11:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690f0sm68465425e9.1.2025.05.15.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:58 -0700 (PDT)
Message-Id: <a3f60183633eb17fb300309cf1a629234588418f.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:46 +0000
Subject: [PATCH 08/11] trace2: avoid "futile conditional"
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

CodeQL reports empty `if` blocks that only contain a comment as "futile
conditional". The comment talks about potential plans to turn this into
a warning, but that seems not to have been necessary. Replace the entire
construct with a concise comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 trace2/tr2_tmr.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 51f564b07a40..038181ad9be0 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -102,25 +102,11 @@ void tr2_update_final_timers(void)
 		struct tr2_timer *t_final = &final_timer_block.timer[tid];
 		struct tr2_timer *t = &ctx->timer_block.timer[tid];
 
-		if (t->recursion_count) {
-			/*
-			 * The current thread is exiting with
-			 * timer[tid] still running.
-			 *
-			 * Technically, this is a bug, but I'm going
-			 * to ignore it.
-			 *
-			 * I don't think it is worth calling die()
-			 * for.  I don't think it is worth killing the
-			 * process for this bookkeeping error.  We
-			 * might want to call warning(), but I'm going
-			 * to wait on that.
-			 *
-			 * The downside here is that total_ns won't
-			 * include the current open interval (now -
-			 * start_ns).  I can live with that.
-			 */
-		}
+		/*
+		 * `t->recursion_count` could technically be non-zero, which
+		 * would constitute a bug. Reporting the bug would potentially
+		 * cause an infinite recursion, though, so let's ignore it.
+		 */
 
 		if (!t->interval_count)
 			continue; /* this timer was not used by this thread */
-- 
gitgitgadget

