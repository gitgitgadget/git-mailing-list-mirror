Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE943246F8
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393591; cv=none; b=CTFxNlAgwOm5MqJTJBpHhrVUwKa5JZM56paIsbXoACWWrQZaW7UUMJHoE11BUHdGvXqb7vevehVFn2Yrla8VrLwItv4FitLy1WaJAoXRB6NYCzzKyLgSQXdzon2jl+XfoQS/ikrZmxPwcW7DgQJKFg1pJbLPsEdrz5z3Fw5N6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393591; c=relaxed/simple;
	bh=Ch4ZBErVbusY8xMbrJ5XYeRQDTufxLWyl7o+Gu9/3+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kz6Se9TqyuzwpL9T7Lxuf3M+NNtokWMkJA2ebutcr5CLCp4SvNCa8YrUIggLyiqX6Tf7qEXPr1w9Fqxty3qoF9N6ViAxE49IZufGn5YXyNpMST5Y4ecxJmtMvfDNUQ/VZNh/1R3uyLJq241YocSC+lWoisSMN/vo8cPhFhmQLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyiu42M8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyiu42M8"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-42ff0576868so2389034fac.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393588; x=1777998388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=Wyiu42M8lx0pAXKIELvCfkQjIch7W17rq9tBiJrO4k3XypmxyGYx3k4aHpt1mi1fTL
         FsUofoB/KkXarknLFpbjnacMUMo4g98HDzIpE+QJZPyE1EpjcfyCculBrogteHY8Vgha
         hRB11Hs9xYwJJGPFLYCpSOAVcOa/7vhRQQuCpRxkyUqAF/kzLFEfukbVCW2MbSjuRn2F
         P4UQNJ4l6wJIMMJc5Tz+N1poYdJcCCJelVLwvZ45/meDJR6y8VZfuNUZ7BFLV9TS0VdB
         iSzGMOTkjKhCXJZdBjRfWqccZMfwePc0RqbQSp6PhrwvYaxaxs04Ba7VRCMR26vZ3WxV
         NzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393588; x=1777998388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=esgyD8EYFnlRwZ/kF0ozAK1ge17F31AFKQqzBcDLvf9VED1CtD3CwFFbWQs4LKO+2q
         w7pzvc7h65At6cZx339WASWuMd0/mWVbq7p5hGKoyVAGqbIoLTDW0oPw7C6dT4YM+RZu
         NHzbpNzYtm/68QHLFwTwLjgkKZ1c8oAX57pYqqMaJ3C2g/Oo6U5tL26hKE1g7vdrfRAH
         xnbYu22K98p9Uyivy5luW0t9uzojY0RhiHsuejnVSFm7cwOnMoaLOcrkLDk6wwpsjGyp
         8qQkDxTJtCtoNtPXfVeM8Os+KnqhDGhYc6dEnOMV8EtxcYvR+hquU64W56+kMUZL+ULa
         RKvQ==
X-Gm-Message-State: AOJu0YwGk269Rt7SngtikxrjHJS4f+9tb+tXD1VI5+BGIEVzQKxFePQZ
	lFxyqJETRmBpH5LIpaFdFcq0EHqdHCxpk6K0D2WuXrSFY2soDjOMjYwesUWyUg==
X-Gm-Gg: AeBDietGQzd2cmiPHmKMRw0vN3lTOCC6fdKKN6EVNe6sUWep4Ivl1VefzA2dbzU0mtt
	FVBPsW3NQxrEJVpEZoNmhqcfwAJFsUyQMwngF9mDdcRH+WuSCVtwqRywjyRVvSOlksObQeJcXgN
	YJ2JREktZUOqL6wRe28Sml6ZbroLNiA2T36miH8vYe/nEs7N+wa4FQGmAstQkFfZkmBayCCfW2Q
	EZzTL3y2dwNtqDGqJqyfhHGTLTFlk6/N13WcRDC45d8eYj7gFD75O/b+vcVbG/EFqxbfqxJCWRk
	Ht5NI1EJTrOaE+QrDoL9h7265c+LkOKfuW+80lPRJfHNC4kBPn35IhP4TpNU4lxi/CLKg7iAGsb
	1jSL5tK/U03j8rss9DATgEGC3fjpMVeeUsBy1OsjyoFzQ1T10gMw5n/KlnYvCmOzvMawVYwMPYr
	4W9LUpx6H+1dPp6P6w2ybqt30AO2x5NfQhxVMwhn8=
X-Received: by 2002:a05:6870:e8c:b0:41c:4423:5f0 with SMTP id 586e51a60fabf-433f387780dmr2185045fac.14.1777393588253;
        Tue, 28 Apr 2026 09:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433eff7bb70sm2069722fac.15.2026.04.28.09.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:27 -0700 (PDT)
Message-Id: <3274cba862ae42a6813710410274a692ec0f5d29.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:18 +0000
Subject: [PATCH 4/6] delta, packfile: use size_t for delta header sizes
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

The delta header decoding functions return unsigned long, which
truncates on Windows for objects larger than 4GB. Introduce size_t
variants get_delta_hdr_size_sz() and get_size_from_delta_sz() that
preserve the full 64-bit size, and use them in packed_object_info()
where the size is needed for streaming decisions.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h    | 14 ++++++++++++--
 packfile.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/delta.h b/delta.h
index 8a56ec0799..fad68cfc45 100644
--- a/delta.h
+++ b/delta.h
@@ -86,8 +86,11 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
+/*
+ * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
+ */
+static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
+					   const unsigned char *top)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
@@ -98,6 +101,13 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
+	return size;
+}
+
+static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
+					       const unsigned char *top)
+{
+	size_t size = get_delta_hdr_size_sz(datap, top);
 	return cast_size_t_to_ulong(size);
 }
 
diff --git a/packfile.c b/packfile.c
index fdae91dd11..4208f53046 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1161,9 +1161,12 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
+/*
+ * Size_t variant for >4GB delta results on Windows.
+ */
+static size_t get_size_from_delta_sz(struct packed_git *p,
+				     struct pack_window **w_curs,
+				     off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1210,10 +1213,18 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	data = delta_head;
 
 	/* ignore base size */
-	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
 
 	/* Read the result size */
-	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	return get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
+}
+
+unsigned long get_size_from_delta(struct packed_git *p,
+				  struct pack_window **w_curs,
+				  off_t curpos)
+{
+	size_t size = get_size_from_delta_sz(p, w_curs, curpos);
+	return cast_size_t_to_ulong(size);
 }
 
 int unpack_object_header(struct packed_git *p,
@@ -1618,14 +1629,18 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				ret = -1;
 				goto out;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
+			/*
+			 * Use size_t variant to avoid die() on >4GB deltas.
+			 * oi->sizep is unsigned long, so truncation may occur,
+			 * but streaming code uses its own size_t tracking.
+			 */
+			size = get_size_from_delta_sz(p, &w_curs, tmp_pos);
+			if (size == 0) {
 				ret = -1;
 				goto out;
 			}
-		} else {
-			*oi->sizep = size;
 		}
+		*oi->sizep = (unsigned long)size;
 	}
 
 	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
-- 
gitgitgadget

