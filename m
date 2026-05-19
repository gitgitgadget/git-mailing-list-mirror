Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C93EA94D
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206301; cv=none; b=ehZUg1QqTbMlt6Wr/AT/GY8gwHeCnrLEK+Da58uE2um8i9hB8bRYpSMYPyWZifArTxCUE7eLFY0I6PWWCWSLclAqaXlsqLUrDmuqqF5r5Y2KP5GcSA3SJQSIqh7iqoTtny7ytcoKt+min9a1GFdzNL0quTQR8baOlV0BIXSOcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206301; c=relaxed/simple;
	bh=mKZw51KQ2qPl4yWDze4Q5MzC+zWQtA32adggS9CbOMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFPJogDqvAPJrrlNXnDzfAb8+UP5cwMea9i024iUTnFPVDzIlmFn0Xu2RPFqBgkqCrL+iYcPp0ROQY59WGc1uhTN7MZbhipbg7kkORtkGxFBwbEBQ/iH5+FQnty0+k1ciPYvuKTupZYBAG2RUYZHDYg9nH6UMgK+7l4UIj7nEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PtlvA5eX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PtlvA5eX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c04749d739so23818957b3.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206298; x=1779811098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHqF58FCnNBs/rAH43L5IcTIhfj52tp4FAIlphCUeiE=;
        b=PtlvA5eXJ8qSqA3UDBhHmhYGgBer34S+ClnASjVtoA+gCQUGEuWd/wS2emVMWPC/P5
         q3wmnT9tPPEsm7s7zIXoKzjBhfjvDEU/KXJ+mKGBc6mkNHI2fYNPXR+G5Ce7R+cwoe2x
         HcP2de0JFr6tywyQq33HPREA7e9Su0OCdREjI11bWTeLnPR5ge0twFHzscA6ePzv7fyu
         YUh1Do8SA7ckF1w3UNydXGk8hSGxWnbQAwOe30LdrzsHe8XA0eMumrL03l3bDqkEQTyb
         NxOdqWiq+HbSvfJGq8x+glWa1yHAx8sDVlLEfGJ0DkDGFXGo9gHZYWz2MMKMWbHrhIyt
         l/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206298; x=1779811098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHqF58FCnNBs/rAH43L5IcTIhfj52tp4FAIlphCUeiE=;
        b=TxVhKuHg3ozXx5gNt0Yvm57sDLJgBIOw47cI/eJBVEJmfTZnmS3cBBmYdKnrKonJOm
         vk3+lJvUq7MH/pTo5tvejQMRFGMexchCKNsUdQ52C9/6Fd4+qAIiUM5kgPE7STaquSrs
         Ku3psFXwYYAc1iwaVqEBzfaUmkViorbABw9Hb7x7sr4VZE+wY8zXwqYXTAcb8Ddw17oo
         8gG30/iM1Y+wbJM42EWlOkaAzZ7tujvkrq3BY6IPi8VToaRJxwUl/MUzLAZ8M064hc8E
         Rglw/ygUS7EwwURzUv4KR4gVVCw3X3Sz8915JAg0WDrnuoTCdmmV4V6YsCCYqoqfTE/L
         WOeA==
X-Gm-Message-State: AOJu0Yzzk0SQVCjU3ajwGihwKCRDTghtZ1TOjvQx9l8Rp46YyYnABJR1
	vKE/v7y0b0ljtpPKD1uZ3eQ/86nbjGZbA3SVwCtMHI8jKcUq0RJc5Dnspyi8rfFBQuKYfj6yDEW
	vzNFghivn3Q==
X-Gm-Gg: Acq92OETvSthY7NT+uxL3iTWZs+BKoaqYFW27HTbUcyNPTx5cnc0X6cw+fDGhx3ydRs
	NrQeJd86lq0YwOaSoxPJtyYUF1eTh62CijkA6U8BBqUzFG1v8JVPCX2YPyCvET+hwpcwp9Pyfqa
	gzuKfW/T2XQRck12AbDfqWX8D+CK/BgYFlc4Ji4eDqcez58+kgzOSH4LnFFxLKnolTSV+ubbdtB
	/XmCLpj+zd3zsTPb84zkm3rsK8GSOGyQITRRL6VjRtAcUX9tlOKh6Zzh5AFS80BwnJx10eAC5HV
	c2tqMnLNcoCjaOGfBaBZDewLF0B9oXBgZYO6huglSmIkJONpWOmV+VutFiB2UumA1V3vO0yxad1
	FjtZg41nLgnEkcCXblDrz9Ie71/oRhF7BV/b8KOZbQHsXCmDBGZsbLjulIVS2mN5gGRc5fhm4sw
	CRxEEAXrn/NKGBr/7DhbBfF2N2B6jqpqHFdrUkza+JiePjdAvznuJGTqCWv52xaQnmH1XG4JeQA
	ILY5/vfqClXjs1q7ZG6gwMPchibCZQPD5wVW4WtXweGtkXrNSWv5dZ5EZ2D5HwrdmupcxEtbSZ5
	4V3QFM1YFE/DFIln
X-Received: by 2002:a05:690e:d4c:b0:65c:5b88:84a5 with SMTP id 956f58d0204a3-65e2265124emr17772458d50.7.1779206297773;
        Tue, 19 May 2026 08:58:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm8003071d50.1.2026.05.19.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:17 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 13/16] packfile: ensure `close_pack_revindex()` frees
 in-memory revindex
Message-ID: <c8c846b1ac17caea4a4ee62d9150ab8014b96fb4.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

The following commit will introduce a case where we write a MIDX bitmap
over packs that do not themselves have on-disk *.rev files.

This case is supported within Git, and we will simply fall back to
generating the revindex in memory. But we don't ever release that
memory, causing a leak that is exposed by a test introduced in the
following commit.

(As far as I could find, we never free()'d memory allocated as a
byproduct of creating an in-memory revindex, likely because that code
predates the leak-checking niceties we have in the test suite now.)

Rectify this by calling `FREE_AND_NULL()` on the `p->revindex` field
when calling `close_pack_revindex()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packfile.c b/packfile.c
index b012d648ada..a1e88fdb223 100644
--- a/packfile.c
+++ b/packfile.c
@@ -420,6 +420,8 @@ void close_pack_index(struct packed_git *p)
 
 static void close_pack_revindex(struct packed_git *p)
 {
+	FREE_AND_NULL(p->revindex);
+
 	if (!p->revindex_map)
 		return;
 
-- 
2.54.0.175.g8bd0ec98dc3

