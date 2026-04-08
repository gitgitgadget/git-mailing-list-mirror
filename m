Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18453921F0
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679997; cv=none; b=YryVdRp73b5ltDCBvrj0wzbFH8Z99pAFxcFYEUXgSM8idMa2joQYyqzEeWP+ClbpEfUulHAWkho6N3FLSJWHdelpwAyDNBhbnjNtVfJfHHGLFcY73hgVohqT0AixCAZ4M88j4UEgsmYqfKZGnmRLGm48HVoTeugoJvkcgTsLiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679997; c=relaxed/simple;
	bh=Ao/aEfOMWdkk7cG6BaxAqunla7Vo6n4VL55nZxp0zQk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fkk/EFX655JXmL+TBGCM9dGdH8u88SheI5OpqBGLB4c28zUJOJ+RGfRjChbqqN5GIIxpd2gQRnEv5cneTn0LX/+V/BMbjyvpcDenAJKCAO8/nKLW7ZKoUbnNWeR4BrPCEMS5ARfat9y4MhOTHCSCl0ZFrTlXYfCoEKwIT0c68lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBvsuOm6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBvsuOm6"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35c1a131946so116374a91.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679996; x=1776284796; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=dBvsuOm6Ogf8fcYxM4M6vSphCkhShB3lUfTpSEehuZi8tE+kelvJz4hRxP0motUOjF
         hHZfPBVAmdhYW50t5Rd7x1+NPRCZ7ldtIYDmRlFsOMdGeg7RFMmNUluJ5ReSy+K91oe1
         n99f2lzrJU/SJLJTPC2RRCxZ9cSlLyIKNjMc4DtIvkaI6M5/M6vz9jWgMX0n5Jm1WVTm
         XL2Yh+p8n6H77zpKL21j/GBuT+TtQscAtlzC3cjP7epvis9P60C91Ak9mZPo1ySTU5jD
         +eYp33s2nTslhrk9T70aCpkZaEOVbq7PPD3XkWQFT2P66SAGc8qww56x6JoBYk23o5rG
         Tvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679996; x=1776284796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=HhKJgIA6eTZDHQH3tAUAPXlj4gwTv+MimdSaBz4BSnwt4FrDLcOO1Tt7JYNfwmi2Fg
         /dOkL8HPSMioOm+86fhb2ZZAvDQhChUd0ji78Ak5p28NT7V5D48fqejzoFxxtOM1lVTV
         SxzWdQjqTAxJVG+LdwUdcZCjrJMn4PUvhGIpWQAwoXIiBltzh1BuKzQxsZYCaws3LGvr
         4PsDlQ2ITC9/Jt5qqSXx37SOyAiDzT7XqeSrbfW4s2CULhEE+uTfhpH4kn3iYIu7i3JQ
         g1L08lr9RvJ0KfKo3fK4TC96NT8I3eutBd0UNIPIAts9ifwkDXGCfFyr2mqk4Cu/e+26
         aKvQ==
X-Gm-Message-State: AOJu0Yyu97nk2RQSaUL3ScUi+EKVtlLkY+14StS4EZw7SqePJnfqJDDy
	wdlHOq0PlX2GSCxc5a8vAIYZZCYKdkRHFns3Wrs3aEPExfLvrg0fUTmSHBIvSQ==
X-Gm-Gg: AeBDievb/J9ZtShKGYorAcZCfo/pTgZKP06YEm8ql+cTK/PVl5X1ROygk9z/ISesc7m
	/X/ERAqODEiqcEYM+cofIcO9Dvs0gu8pVTNH+5zlgChzlM9nkOKojvtYnagUr85JVPAtuEOrlWs
	lHbVBjiN5druI1Gbmpw7r7miVvDmLBehjmqXEfcBcvzoYfR6ebzcKZOEiDqRwTgRqEJwm97ZHZV
	Xvn8l5OavwJKFlXc6KcokCMCyTcGhDLVge0QB71ZASLALwbBNVZIaMbfCTOf9kBQdR4URhZAgWX
	N0yjt+GaOLhg738c8Tdp56BvsGJaZSsnTpJOgGBYMR03VvqGGnPxgwAP2jl8Im4cAhKpeqjWm/f
	Ph13puK+GxWNVddwCmkRuy4uqy/tzn4B3J5Zqzi2o61WD6DeXFED5ADgBygrZUrxnjHGLu/NcG/
	Rnxv8eZnc0cIzkpGtk846+IZ0waEr3
X-Received: by 2002:a05:7300:fb89:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2d4106c7c60mr404091eec.18.1775679995597;
        Wed, 08 Apr 2026 13:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c0c2sm23395925eec.17.2026.04.08.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:35 -0700 (PDT)
Message-Id: <85aa0da90c62d9217ac2a3f907c37855a95298b9.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:25 +0000
Subject: [PATCH v5 3/6] xdiff/xdl_cleanup_records: use unambiguous types
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Change the parameters of xdl_clean_mmatch() and the local variables
i, nm, mlim in xdl_cleanup_records() to use unambiguous types. Best
viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 48fb5ce6fe..386668a92d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, mlim;
+	ptrdiff_t i, nm, mlim;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
-- 
gitgitgadget

