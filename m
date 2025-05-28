Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA486217659
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474418; cv=none; b=i3mPCxIbEOAzY/PC1hRZ6+swu11wlgS7niTIQTxCiLp2waUW0i3BG90F+o95NOJubHzrdFLXDGwEMLgTsmqwb8EPbPPaD5948VblIGUuS6iWXgDVxM776eTPgBzX0Zp8IvFTSENH4aei3t+f03vCV1DKZ48qfKLP8W6Cv0RjGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474418; c=relaxed/simple;
	bh=9qtUJIUbnvdBMfFuQDGUMYvoVDuNiPXRB9QlMwDNstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxscVQshTRz/P6ymvijUNPxCybwZo02Fjd1Ey9F/83GCbed1uiEpgoza6j1SfAucd/MPzdZkSVZ+rgLw8G3PuLotpwt4NNfxGcy9TrW2gb5ZNHQJWAukyiNM4Os27lW1Jl2ywHSloRBfI3D0x5hoXxv580tPz+V39CTPp+KZEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VF/Nnv1g; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VF/Nnv1g"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e77831d68so4442527b3.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474414; x=1749079214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhwA1G5zTOa12MezV8Yn2AyukfYABbdpTlojF7IGKuc=;
        b=VF/Nnv1gRHTAWaDaIQ8i4978KH1oUar779otaI/yhyvHpaGgYS55iB5qOHV4xqfNCd
         pucHsA0FPqZkpFHKA9i4L8K11H9/W9+2RX2vFkXKFX+J0iXY4r8FEHkF1as+ZpD9k8eu
         qPPZbiW5usDEzeEosuiY/jLRGjWbs5beEwu9w7Dm/1fQHlnXORVBDaiKjtGl7DchVsnA
         WaLP3Naa5rOFcFqZqehU+HjpMTICZ+mDFOIJc0dzr6Fjj9HwJEZCPGZF3MxMYedl9adt
         Vqlp8D0grbc2Z7DZiQ4qcljjpJq1UMJTufbY2qHr7b1eWEpfLz8YaXUMTcOF9rdxADOn
         9IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474414; x=1749079214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhwA1G5zTOa12MezV8Yn2AyukfYABbdpTlojF7IGKuc=;
        b=i8K5neZueko40aADO/PA/zj+WqL6HcYmJ8EF5Kh9mhFAWUAsJI7SXRSzabubhwEfh5
         Np1iXlHIMk494DOJ5yD7KnTZ3xWVV686NNszFApZE9airKx6PEm6CfQvpimnnjK5wTD4
         jBhQ7LFLtQS0WcSYki+ccQv5x0GOdJryfXZyM+NTA2Zi7Ysx5ivAtnCHQ3e/y+HweZCQ
         BINfFRxsIR788bh3rU9wrhN/7VOiY7ZbAZq/ZQdDdhe4lYFhVJVrG5lJRfRK2Uo4e0+u
         nUlBggZksUnGx7kzlsDDUOv3XotlvgEsuawzUqdHtbjmzdGgQs7/8790uVgXXkS5N1xP
         TNgg==
X-Gm-Message-State: AOJu0Yzu5x5opx5c8olCVO9uKvh0tsPE7wg6Gvka6yQYxyW14/oPkLQd
	SZhB16JGSlQMoHeonMOZ4ZVfd503HRAlZw1tAzyXlyG8ZxKLh7HNUdRJG3U9BjSncRjd/KJd2Ym
	IXMAG
X-Gm-Gg: ASbGncuIGG0BfzQ7QgD2Opv+xOArJMc+e4xR5b8KyqroXOwY4gtAYb7Zpwhe9nVftQP
	UYwld5K9QNGqi8QdFPE+jp0mhXvwwWv55hKF6u20AKE4rfRJqp9EOBnf/0SfwDdcU9aoFlqPdTv
	jjL7lNlukEo/K5I5zdE+1nAyQq3lpyM0Q2obd9KLuTNtW2Bbiv/RE0i6N7KX/PxX933cx+G3l3C
	dRGgMAKACPRVlQeX9EDkiNLgNpjB3uQ9kUFSKwxOT5OfSSrWAUc8FpHwcbqzDV1LoD7YdHthyZz
	mjqSfLTOl/Ps1ni7fc8CmZa2QIp2jm+e06001lGSj7m+7i+QgzNyftrl+5YPz2GW5yM1dfUhdFm
	CMLx/bLD7l2pm/N7xsIMyk69KC0qgtSimGw==
X-Google-Smtp-Source: AGHT+IGZ9yMn1VnayKSWDte9Q57dxmxaU7ueFKMa2ew6bK/3hHgRH2VTD86phmYu0DSQOLMNSgpk4w==
X-Received: by 2002:a05:690c:6288:b0:70e:16a3:ce96 with SMTP id 00721157ae682-70e2daaee4fmr240142417b3.26.1748474414628;
        Wed, 28 May 2025 16:20:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8acd994esm359937b3.79.2025.05.28.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:14 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <2753e29648da5034801413451fe2d977b137ac88.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

In add_object_entry_from_pack() we declare 'revs' (given to us through
the miscellaneous context argument) earlier in the "if (p)" conditional
than is necessary.  Move it down as far as it can go to reduce its
scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 20dd870bbf..682e80be40 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3490,7 +3490,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
@@ -3498,6 +3497,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.49.0.640.ga4de40e6a8

