Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CA3DEAF2
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903600; cv=none; b=VA9Va+J0mRToQWW8pD5j6PYDNEt4TDkJ5rr1g346CraeAoU2MWhIMcHxOTgaMaQ1ygHbmk2WEc7laQN9csk/K3KPsouObpJkZwBQfrGUg90g20wyqye2d0WipgPU9U+VABlYu4la3sCTDprY9kPLc7i0INORem+8Ywduyiyh5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903600; c=relaxed/simple;
	bh=fd3rofD/A6WllCOGjYm7vodCTxKgw7/FTUSmCGlrg0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNX85vckw6Nf892etD0oRr3+m7IJXWy5YZ/VOlwPQmedb3OLPY0+1PLJ3gpRaFyKATq6BPyX8++4T0QHHz4RDYymmWeTFUYSg+nEKqoemwrU8outk5BrgV9Ka4EGxvwLC69pH4b/r4jF1O9+8Gi6BkhFjnqed/0tTkf3D9FxYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxAkUVm1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxAkUVm1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so54763815e9.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903598; x=1778508398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lt9fIjrLHmbjOzpedTGdW8Pjy6EMnWiBA8ahbyQzpjg=;
        b=CxAkUVm11r21OozP0WCHmwmI5KJnJjjL+2ZJSGx4BqyDIgfPr3V3Q/u17jai3FeW63
         ohN1jzyYrDBt+2dxNRCd29VfmFtIy+zYQLoJoWm1i7crNzwBTtKHxEtqXve/mAdl8Yu8
         TtN99+atPp7t67kcPuDUlVLj0+o/HhI9zTLM31bmUqj7H2eYmvPUJxdKLdZuqz6FV2bK
         7exidrLIZ83D6hv69/ldx7PPwfgYbnce1OCp9FiigHm3gRRn99w9pJrITJFlnen9ZtHL
         5xX/YyB5iZM7WMDW23JQmhVH9CXgMlTb9pHGrOobfslY5Cn59f3fZcV6+4tia0u57vSe
         pEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903598; x=1778508398;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt9fIjrLHmbjOzpedTGdW8Pjy6EMnWiBA8ahbyQzpjg=;
        b=FfMSlmn6avUja2mQgxDvxDcCc0jQ3HRSXux0E3M3ktSqWTof6gci6WAroBLohNDcVf
         /uGQyeiW+Kbd55oibQInQapkTBg1T5yElFuQZ2Imo5FI/nlJFhpBZ9rUw4t/rC4G32wV
         2XHtHuWgk5b1vB5fpgjHYfu/gp/ZEHLsKAx7ZjmmpX7/P9NHGbEuQhpKaAP2Na/UDGms
         BP0bwBW6wXUzbMPbPgAoiUKV8qj4IptkwfVVCYNaW3rhtsdjE0nPcKEVUwmW+GQ3DUCh
         lQvQwaBIzdtL37dKgZ8xS0rjdYqkWOhAre7uP9zL0pZ4CEzSfOgh+hsqs4r7tNwfS9Rn
         H09Q==
X-Gm-Message-State: AOJu0Ywv3ok/CI6nIzNXC5K/eWVE405WmrF7g+nsT+cmaZiaARYpVw1X
	i5/X13cAeO9Dp9FE1zaSYk3Pdw6+MZ3ez4xIPSIKad8npQhxqiqsjl4DjPInEw==
X-Gm-Gg: AeBDiev44gy+XGN7sKMhp39AWF0w98eFrCSEaWrlTDJyQOQRQSh5CZbCNiTQOyI71OH
	q+UVpr93ocFaIGbXcfaMx1ghyN7zmsfUJF+TDxD5YImPIJliikHCwkWzbIGADRQAaVle/ebyjks
	fgQa0rB0+a6nzyAmgtO7nmZJ0U1PTVsyUKJ5fCEyyH3C0lMpvxnwBoKJwdKZKUwRo164v2DeKlU
	Iob6VOMCtxcMg0DTtsOdSpakV97A0l6QBCZC9J9MsHKK0O2bDygIZeiQcHJ3S9ZICT1bfeOrdc1
	7koGIHcrhfo/1mClTkP/WfnuHhCvdCqxmbgDOYnY/0Z7lKP0XUkoByQvkajrS+xVArqWidzQe1C
	yh7wW7PEWYYDm1m12DLtEBEnuJDTbV+k35QPlc7dUsowKTifuPdnzIFvIcQQqZDGiD7mxRdlOC0
	ScKbr2cGSpql7k+Uuo/qnQna+0Gk1BlSmQqN/hhnsU4kdCBh+NDg==
X-Received: by 2002:a05:600c:a30a:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48a9865f34dmr119307505e9.17.1777903597793;
        Mon, 04 May 2026 07:06:37 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm390520555e9.3.2026.05.04.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:06:37 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/4] xdiff: cleanup xdl_clean_mmatch()
Date: Mon,  4 May 2026 15:06:19 +0100
Message-ID: <977f457752111437f7d6c15a214b2233566cab63.1777903579.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1777903579.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk> <cover.1777903579.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove the "s" parameter as, since the last commit, this function
is always called with s == 0. Also change parameter "e" to expect a
length, rather than the index of the last line to simplify the caller.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3b6bae0d158..81de412875a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,9 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t len) {
 	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
+	ptrdiff_t s = 0, e = len - 1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -342,7 +343,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		uint8_t action = action1[i];
 
 		if (action == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
+			if (!xdl_clean_mmatch(action1, i, len1))
 				action = KEEP;
 			else
 				action = DISCARD;
@@ -363,7 +364,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		uint8_t action = action2[i];
 
 		if (action == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
+			if (!xdl_clean_mmatch(action2, i, len2))
 				action = KEEP;
 			else
 				action = DISCARD;
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

