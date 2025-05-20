Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4182528E0
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753488; cv=none; b=mEXQxTQ4uP/NF+v2eAHSk5gXI/jehcAtoMtQbjiXTm7uPw+YiDgrT949/RskAvIFQJ25RkRXzQan+3CBkGNatqbmOY9Fuk1ZnQGnKLLp2ZVLSL0kTc3Q5WSEm3hHDZDwBtpwARS0bsA3sFoqa3L2xuhadw42ec0TayOUU0Vijms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753488; c=relaxed/simple;
	bh=VoPZiAm+esnYeW0d101GSIAnInu5IQ68i19aaXX56Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGamLeEWdPx0YgoUQOh11gfbJ/j07A4PDQ+8yT36k4BsD20JhAv2HkhkCqVUlA01SvZU6ZrtbyLge5FqnFIwG2WEGA9cvA+hE23X8GtRNVAiZf97Ny3a+5xEL+NiRQAu/KWHFfyGnWkRrXcdb4EJnvQLivn/5WADZP/ISM6S/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cStNFe3G; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cStNFe3G"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a363ccac20so3432701f8f.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753484; x=1748358284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eeCMRX8vvTe9R3//xsdAlWl9luYzOv9tBZ3nft9sLEc=;
        b=cStNFe3GQTciwuG6BZu14NGt869FifJKa0KXnWVLB4Xh2pcj3Ncvpx56r2QfEDuLpm
         z4MRj+8NLUa9VJP885B3sQjvFcXuxKLHkbQp9R2KeWDuIonjqOzeibQEDAdtmO+Z0l4F
         pcliMDsHSmRiV/pXdBx90zkDRxR+9pcFA/TcxlFIUQoj4VX0q6RFwdHJEqEe77u+rOKR
         7oalBtLK0N/Ig9zvg8aF0scziBCmTX6Jlak83YQLzZnUZUS2y4jSi1lYBQOjZL0a+3yf
         TQKO2qJyuqypJwkJQ5tZziFXgbWRg/TS6A8/5x0Sl77+SV6ULr6wDZI0JsQ4XrDj6Q40
         IgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753484; x=1748358284;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeCMRX8vvTe9R3//xsdAlWl9luYzOv9tBZ3nft9sLEc=;
        b=nafTgtXsEaRrfCl51I/JX+od2P9fkalmE2ofY7qKKz0FEiy0uKjv4wE1SEBOViaSjx
         lRDmEZ47xgI+GibEEZvoj29BGbZr7s5ooks7RxKV8oMV2T2o5ZRg3mTt7QKKInTaAMmr
         hXwQFC7k9r9AU1nFCtf+DAcDUMwkqkXqXE5XMg6KWZdeWQH8xHGWj1hWXGueDv8OFWON
         aR/wp68EsCBPNl5Yk7lsGVXIOE7J9V5c4SIvnRWCVKvuw0iPX4kwRnY80nH6nIBvXlCU
         bHpBHukbggMomqRRkrGh66zcmb4vWL7tBEzxah5rBqr13rALY2GltWiNu66iHuw4zePy
         ekCA==
X-Gm-Message-State: AOJu0Yzuu667Rw+WZdMbyukg7fDXpv3W5sBOb3mcjeqByfTT7ZEigF5l
	E5lHClSzUwFaJf42WHi2lcgydjqPSEER1OihUGfEtMRpuMs9IWlBKbrFHTcZCg==
X-Gm-Gg: ASbGncthv4b+M1rDKHNdrdTmFsOqeCFgehnzBM2S6m75V4p6bJd06NuSl4T7FrhN2ZW
	26NZZVpDHdkNHBdMDHcydjw/aJswcc5NGVJtoOueX4ZZlXjGIr2vYjAWi1onEsXLP/doUqA9fu0
	Bwe2j22xU8+aF8A9UkSWqsLTvZItq5Hhu8XSgdHv1GENIgakFCiqd1jYXmGq9cZT2IxwXFTeVEf
	oAmALA+qw+WfU/6ArvTt/P/BiEFglkmxKw4Al6b8esrlwQcwLLObWniGXCTkr0zkWRVobcAwX3g
	CsZEhYWyJa9R6QJ6tUeqCy32c2Hw4RqgHpNUYE3jmE0n6IPMj9e8revdrBYA4CKUTuqtMcPutV0
	BHw==
X-Google-Smtp-Source: AGHT+IHSPq0sZbpnOZ2a2PXhGBCNeUUfUyQjXCSUn0kGOB2K+a4lxSCVca+ulu1eKxGEXs/Jto+cQg==
X-Received: by 2002:a05:6000:2304:b0:3a3:5c61:591 with SMTP id ffacd0b85a97d-3a35c84afe5mr13447040f8f.41.1747753483773;
        Tue, 20 May 2025 08:04:43 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm17014029f8f.11.2025.05.20.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/4] midx docs: clarify tie breaking
Date: Tue, 20 May 2025 16:04:27 +0100
Message-ID: <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Clarify what happens when an object exists in more than one pack, but
not in the preferred pack. If the user does not pass a preferred pack
then the pack with the lowest mtime is chosen as the preferred pack. For
objects that are not in the preferred pack the pack with the highest
mtime is used. "git multi-pack-index repack" relies on this behavior. If
ties were resolved in favor of the oldest pack as the current
documentation suggests the multi-pack index would not reference any of
the objects in the pack created by "git multi-pack-index repack".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-multi-pack-index.adoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 631d5c7d15c..1f016b2f682 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -40,8 +40,10 @@ write::
 	--preferred-pack=<pack>::
 		Optionally specify the tie-breaking pack used when
 		multiple packs contain the same object. `<pack>` must
-		contain at least one object. If not given, ties are
-		broken in favor of the pack with the lowest mtime.
+		contain at least one object. If not given the pack with
+		the lowest mtime is used as the preferred pack. Ties
+		for objects that are not contained in the preferred
+		are resolved in favor of the pack with the newest mtime.
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
-- 
2.49.0.897.gfad3eb7d210

