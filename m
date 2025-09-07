Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552C147C9B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263369; cv=none; b=C3uGbebq5EtPWo6xyxqT8xLX8LEsbr9uur8OpDn/KzYPdIVN+D9EgE/1/EhpdkUZld3GNJX3mTfyo1EL4CGNeARbGwi71VXrEsTZVpXKauL9+iVZxpnmegOopgm3sD4+6JqikEcF4clqAtlJnbPY+dCWNdp5cUklQ4jgoWWIRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263369; c=relaxed/simple;
	bh=YxflvnelRWTDGnYw8qT748OsDUSlpuNkuHr9XAQizAc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTDWIBnoLA6Enl6N1TIJLpoo+LPat0suW3IrQIc3lyjlkZXGc9b+1KJwVUoTiFYjP+gsKVBU5gMO4K+y6b/P7ZJdDcNvz9B3zgiN9ACUlZZAi2GxN4jHaH8+WDTSpJ675SnDQwapGplnpyeHmhpzZbVySQRfIn605ZJuL4d3aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz+nm/37; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz+nm/37"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2518a38e7e4so11197785ad.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263367; x=1757868167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=Fz+nm/376TEq/CCs/W8gB+v8XJRciLCdcwTHNqUuJwc6IruVPex0cu0ZEI4jWcv+fu
         RTRQj+cEx05vwYqwMYBdl73LejTgGD9xrcGXqDgM1uApwYAc1+n+88FOIbPjeB+iJzgZ
         KRuxxhzBDZOF1L1wEeV5BJMgdzlvBJ2LZfP0d2ueCRuzIKim09xF2mp4koEpzliD5/Xb
         x3W4gCmXjbu8aylXeaRbRte4K3IlbOkyxuwW8J5W00WGFczA8+R8lb1/Rkj9HIePx6Ek
         c794rCgab/HQta/Bgrb3a41jl+0OGOd4cU9H8dNpcue49eVk+C91xb/VNdEn6aGip4jF
         NWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263367; x=1757868167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=Nhp8VQPMk2/q+vMOynMw3nAwWYiAS8bKSfQmtqJq/sKyfPIRAyZveb91fMZiu66Mj9
         4CTv2vKq63FoNqCUMgJh4PHsUjQjuoK7ZacT+t9PIv4QD7nzt7vqID+ov+Q/1I9g2zRs
         xCB/QHMt/OssyuoYlaana4bbZGLp54I3sROAbZ4SgL8/SVT/CyuaPUqx1KWmQ6H8lN4n
         D1vT2MEkfTnzlMLueLXan0P6TGpeoEwWo1dsiBbRgsUsPFTuzdivOYqe9OzVs7/yNZ2H
         oJiie6oX2K4pVaZwYU+Ct3a7RZmJxXeL/0id3y7n1expR2VeDrr+F/CZ1PUKllf56QXZ
         Y82Q==
X-Gm-Message-State: AOJu0Yy1x/PORETAX2QC0XvkZwMxHL9ocF2Lx0LJR/dRVVkU/HXpoYWf
	/xDuLHkkz10lfEwc3Mj2RcExLzOosTmMMsC1rqsiVxnXIot1hFk+MThMQmVHP5R2
X-Gm-Gg: ASbGnctuFkXhwQJKyvv0PfvY6raTJZRhbLt4RE0siHRTV6U9EPY/AiRmJ63a/qC/lNi
	htHp09Opu96OayiwZzqGbOgU74fpx0VOPRSO3QN8r4qB5yUHmD7Hsv9rEv3vCDpm5i/mJxLN7yi
	w45dLMNfJHQtjlfMlT2vvVJwLoD7/wlQjO70h+EdMPIoKrkHZ52kGVLg2LrTMb7/KRLEsEY8/Yr
	MjxeBnWKmW04A/7Hrzr+bcOc21VPo5V/vJacUndQLd22RkI8OPtBhEGnsmi33RgqJVTCUnKV5TW
	GpZWxTaE0XDx/kU5DF3yGHBq5amPZjVlWrpsguMKXpYLdpvpFxjLkd5pvqDh/QRriffegrWXMKS
	5EkEIOqF2cmNC+5CCRA==
X-Google-Smtp-Source: AGHT+IH2bF5cbaU5nU58eSA8ajQybhnNMWgcZAaHEgcF56Y5oW6DIRRpdNinf9UYnSkNi2mzFgYLEA==
X-Received: by 2002:a17:902:e742:b0:248:ac4d:239a with SMTP id d9443c01a7336-25178ae6c73mr69511225ad.18.1757263367279;
        Sun, 07 Sep 2025 09:42:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24b14e1b097sm151096265ad.21.2025.09.07.09.42.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:42:46 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:42:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] refs: enable sign compare warnings check
Message-ID: <aL22Bd_6YM-l92hm@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21cEM0OcnrKtBW@ArchLinux>

After fixing the tricky compare warning introduced by calling
"string_list_find_insert_index", there are only two loop iterator type
mismatches. Fix them to enable compare warnings check.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index a8f06b9a0a..79069c37b8 100644
--- a/refs.c
+++ b/refs.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -2381,7 +2380,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
 
 	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
@@ -2398,7 +2397,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		if (update->flags & REF_LOG_ONLY)
@@ -2791,9 +2790,7 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
 {
-	int i;
-
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		cb(update->refname,
-- 
2.51.0

