Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F42F83A2
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960590; cv=none; b=nLG2Ka9x4/pBv22xZlQ6nOXCsK4L268i3lUx+pOtDNuDo36/OgYQriQXT5fSlW2DwUowKOKY1rxloGjaSiFL3VTdbfQG4yNlAuB9vMALkzUod2LpV4B7InrdWn94miho2H1G7q95htT0YgEnx+6cNq+IU46YdEa/yNwqOVm/EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960590; c=relaxed/simple;
	bh=H83fir5OrY7oWhEiZHbJ+UFx36RFgPMvC8PFxbnUiWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzU0au18zquaBT0o6kHuFii+COko3pnnX15I5p2L26k696p/goPcQg3nXiUgAfLl+mO3MmjlUh0bptQOrdp8oHmh5pasm/ksqCRnjbY8cw7HrB4Nh1RhAfXbI1ZFZmtkyP82pluMgEf59DeWAoG0rV1nHAmPPCAvb7E/nKqtE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoGHfi/t; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoGHfi/t"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7dfcso64354877b3.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960588; x=1777565388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPeV9vPSZnteYUoIyo8WQTDauSCnCxSLrkFwOaWygMo=;
        b=QoGHfi/tRUD0HUHgsy29t3fTDsasYgNnXu75w0MRE5cTzXni8a3b4yoHslfkJFgk8j
         IU/85H9rTtH1ztsN6mDsAADn+KrKwp+4hsA6+8/Zzl8O4K6bp0cNBvgeeoCI30Le0KNr
         9eG15vyGw/5Vh4tzNbwJXfhmYHBU8hfKsyVtzPU4+3a4MURSUH5W9t5L77DMhVn/uISJ
         KEaAPxmiyOfgpgszYL2dulNPqB6TpLfU8nBmutyrQOkVO+C6YnfAwh/WJVrJXQx2mrTM
         QmAE3KuKEmc5E2boN73p9/3c/M1VPzdN6BJZXDZ2smw1QwLNPfgLtszkEOrCUv2cORiT
         D8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960588; x=1777565388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPeV9vPSZnteYUoIyo8WQTDauSCnCxSLrkFwOaWygMo=;
        b=QGONb3CwsYeRJmPyixQ/qX7LDERrmlXLJClSINCbfv+beQ5HIF4ycDFBs5B6CQ2BFL
         EJ+FYXDDGp7tDbkUrdoeTXst0rnPlPql+CF7vtVMFlM0l0GF099msNr0Nip++yejCtsp
         amhFlPynX1psnrSU4wbESQRR2eHUfkmD5x6GdQ1zdHrv+vhIoaXYwRtfcUSI4020SoN4
         L2HhEDt9LUBLJScbu8bnxY4UeXtcv71x9MOjTg+WTRBL2/aZP8ETZ5R+ZU1ofKitkNIL
         oLC3T675WwWZM06yEVPZoGjsHAuerQaefsy66TCmA95r4NC0P9joIXRzlzo0NZbvv8lZ
         1Pqw==
X-Gm-Message-State: AOJu0Yy5IeFprq0pkCWs9RTGWefHiG+Qg3R0t9Q36epC9u5TSOE55jfZ
	LkBNeJ+i+xTNrV+C23bHf0aV3LsEozRSsrdSlp6mmrJRGvWpQfpxJdPT01ry3hPS
X-Gm-Gg: AeBDiet9CCI4YrDs5Aw//cypmOOErlXWMcHrFlVGu9f+gYuOdO/5spLsRKusMGPKMHW
	j9zjWtoQPB/CAa59dAMKau7F78wpiv+NzC8zjksdlqXUBwQQvasio0+FJ/O0GhNIv7dHkKCS+70
	MNgqi3DY6jNFiY/5j48fCFT+DFxddM9fVTo5TNHuOdMFLi7rceJOtqrKoQY12wcj6wmpEpkPlgl
	2q0eC+TR/buxEyERAaEehTqnElnOKy7RNOPpZzqrZhzPaQZVej+vkU3ZGGMSluXCqwImdzYNXPd
	Gcaj06Fe7fduvXOb9siEiZIqFd6M6oj3pMggRgM6+iIz3kuINyEsor0ZZhfn6G0mHBJKstFojOL
	rp5MNEtNt17MX4fDywI1sGOHrOiDivd3SYKj8C4XDLw23fYjDczzSb+Y+LPrzNklt+pNGb0z7zI
	AlNpr+/6PvJGX1karu286DDCPECtkyauhUhfAAUFoaB73Q1Q3wDHAx+F5xw1CdzQfnO/c2J4XEh
	RYOc3BB
X-Received: by 2002:a05:690c:385:b0:7b7:5f48:d9a8 with SMTP id 00721157ae682-7b9ecff43bcmr293385967b3.43.1776960587623;
        Thu, 23 Apr 2026 09:09:47 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:47 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 7/8] Hopefully the final tweak before -rc2
Date: Thu, 23 Apr 2026 17:08:31 +0100
Message-ID: <20260423160832.114816-8-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.54.0.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
index 3fa25e06f2..2ad73ff473 100644
--- a/Documentation/RelNotes/2.54.0.adoc
+++ b/Documentation/RelNotes/2.54.0.adoc
@@ -526,6 +526,12 @@ Fixes since v2.53
    conflicts.
    (merge c0ce43376b ng/add-files-to-cache-wo-rename later to maint).
 
+ * Doc mark-up update for entries in the glossary with bulleted lists.
+   (merge a65cbd87ea jk/doc-markup-sub-list-indentation later to maint).
+
+ * CI dependency updates.
+   (merge 4bdb17e3a8 jc/ci-github-actions-use-checkout-v5 later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge d79fff4a11 jk/remote-tracking-ref-leakfix later to maint).
    (merge 7a747f972d dd/t5403-modernise later to maint).
-- 
2.53.0.155.g9f36b15afa

