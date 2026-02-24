Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AC2DC789
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959597; cv=none; b=VdeUZjfBDfx2d4oVHbYcgu2JgQVjW1rsBszfljCNH74bdqTPGG4Ny0NCdWFM0qs9GAfbmOqsWzaESKMKeBM+E9r+7HJy88Bc4NFpgRASDgAZxwfNld//zPzHTEBtPHCoar912FUqTeocCoPcy2gH/zYp4cksKXjEoEkJQj6TPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959597; c=relaxed/simple;
	bh=CWNC+k2ETcWIIs7UNGyAlUSA+u3ZQMpOVDBt1KgHVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWS1W2V+4gZoCQWhx+Tg6De6Ze7yRFNJHDPdw6bKOo1SfI+i+z3434W6xylHPWetXuEOGpyvP92/hOYJldenwLPv+aaQNJfNtt9+FfSqrYAfnm1DseiAjvjXJAsRLVef9mvdDm/a81Du5m8ndb6/BYdLon6TE92IbYA6LYF1F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Ws+Fbxeg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Ws+Fbxeg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5033387c80aso1622371cf.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959595; x=1772564395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBv7zrbbVf7YyT6pSImwtFJ/uzV5TaD9BvMrDzZdKug=;
        b=Ws+FbxegUlWGFYYhthP8pgBCWP7t/hjmtKH3CvqEatbA7bhul921DtHDRwsyl5Vh68
         qQ2zmwmuK9EvH3uxkiKKqjNWa7P7AbP1q9a3AorC5hZSzw07OGvjeOR9XUdUgctGc54Q
         VdRDsoZiDGI0x0r8nAnkUeEKnKpsZ/uXbVLARdDXa50wF/4NK6kiE2Cx7uNvu1ld6Ewe
         C0JzQ98C8cKdjUr8ihjNdQj4acseJyn3MMgU0wnXooS7A+DT6ROzWpuZjRDQTlNxYoqP
         x9yRBrJ4N9qkaVwvkY1lTBdePbd/L+oR+61EClPB7oQvU+TTX80W4Q4q9v2tF0o+/y3D
         mCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959595; x=1772564395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBv7zrbbVf7YyT6pSImwtFJ/uzV5TaD9BvMrDzZdKug=;
        b=I8zsBYCWL2Whws9v1/mK4J4BP9vOIKYkAi8wpY3m5mr8aFvzmBsbSIxHsertnFc2ZW
         977ntUrvthCux0+PKFHfswsmasS7r/xCeiGzdiEIetJjfsqnmmAqyIHx5YU0U+TDST1O
         qiVmaXtFxX5fO/Q6hoZwDmXOgAgQqzjB/+4TTS+SLvf1DJY4nqVlLKmbyAOnrnaMNCh1
         sdUqpgF1v4lApBNE9vJ5oNVTUBtya+eqsOQzr/rwdLyk8y82hTE8Dy/Jt6tYCLibO9Fh
         H/5fJLRaBozsDakvia+bwyC5/WPogosLFLP+3Xs0e8YoPwxFD5oxG+2oPN/x5vLZbhHS
         97uw==
X-Gm-Message-State: AOJu0Yw/QIko4dqenCfoeochagYqn2qP/p55LnSF1pZnn+XvKpQAWnen
	z5dnU21BNrM9ObFqkj91NslIP/vMDVO6+nn2EUV5A15FK9l54dNgOW3q8N/I9v3tXE3XgnDXcxu
	xZlTpSDSNOA==
X-Gm-Gg: AZuq6aJnad6anPRqYEbzEo9G3mV7e8N3Kr1/KDRmltt1AUC8w3Eo7iZ/K/tcZbiiOQY
	afZw4MwcLVgu2TOBuz+5LOiQHO/F+mfTSPaTXpkpcw9XQfzXiJMgNzCEpgEMqZzugU2VNITOjzZ
	slNVIrh+whHi2s1k6pb0iFkX/56Gs8JSm+wz2ypSHrM0D4Kz/JWjqQwvohdT/6dI6Gpl+xFYTXS
	cC3jNnDI0ETfByv9w0EhZyl/e1nUUBLfYHjMzfXHxu/96dy3Okfb5TI+MA9Ex3ajjKBidPhgO0h
	CptjwWV2dxK1v2hnQpKT/8JGF+Pim8UegaqreNg+GXXZon+51ONGI57MptEyU86WrnVDyJYUuR6
	0XGZpw5mdFNyW/S295HEwQyusk+ZXQPb6RfMN0UwEBUDsohtDUwNJKEgGZ2dMUeUJcEeZaRUkdf
	6Lu8goJI2OBGX3Nri82FdsGwCA+rmuoGSKXIkqFCWaM1dIupeXQ0CNbTMfA9xEHc/Bl9lFguRz8
	txEyPcz3RFUw9ip81cL+8YvMtVChWKi5CgFzV0Q
X-Received: by 2002:ac8:5708:0:b0:4ff:b32b:cdf9 with SMTP id d75a77b69052e-50736581d78mr12705221cf.14.1771959594837;
        Tue, 24 Feb 2026 10:59:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d544cb8sm101673991cf.12.2026.02.24.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:54 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/17] git-multi-pack-index(1): remove non-existent
 incompatibility
Message-ID: <feb9ca5538e9dcdc9f8bb1ec1370ae7c26cbd6fd.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Since fcb2205b774 (midx: implement support for writing incremental MIDX
chains, 2024-08-06), the command-line options '--incremental' and
'--bitmap' were declared to be incompatible with one another when
running 'git multi-pack-index write'.

However, since 27afc272c49 (midx: implement writing incremental MIDX
bitmaps, 2025-03-20), that incompatibility no longer exists, despite the
documentation saying so. Correct this by removing the stale reference to
their incompatibility.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a4550e28bed..a502819fc38 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -75,7 +75,7 @@ marker).
 		Write an incremental MIDX file containing only objects
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
-		necessary. Incompatible with `--bitmap`.
+		necessary.
 --
 
 verify::
-- 
2.53.0.171.gde83996e422

