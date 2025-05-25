Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3025B1E0
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198515; cv=none; b=jnar05B4yjfbjsM8zRBQPMQ8GJ50EEJ7DH3O28sKX2Z3VG+hvjinxBZd8qzVOqVmU6rWxi2EFDd/nWYUS6QUBScNBYqdhAK+IJgBAPCDKv0yA7TGpEGUkRFpVNY1jkvVCqTYAOExWMpHlzZonA8/4ZaqZ1/1mQ7H9t4Z2xPrq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198515; c=relaxed/simple;
	bh=DG59sHpBYC2pHoLOtx2OjSBS57V3xPkhmuHGKz09Hvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLDAOJ3YIKBeGCIlSuQCXeLR6iBfxSbhOPKbF9KheLJ/4JXT94zFr4azFy0yPoBya6DkWHIs1O+zE/SgWh1eUNPzD4Kwey4Qj7TGbrhVpkmQo6W7QLRtnyqTUsUhjtobmyOg3miK0RI7NlfRb3EOLEM7l2nlN5wbWRLr1SaMaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BDu8FYw+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BDu8FYw+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f8d8fb211eso12997106d6.3
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198513; x=1748803313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTEeaKmJSlTWnxXRVuHeQLC/jR2Ff9zhxX2PlUzFVxc=;
        b=BDu8FYw+wFzRXHMvy3H1WVx7uMuWwS2QW003GhMOmUfyfQg4o+VSVzabHUA4UIJ1qV
         DmNuGjEGixWX4Cw07GS9hbnfu+Gb2TKrWBXqyGq/aIzt4YCQpMGyTPuN9PEijJ/OoXmB
         GRzScBzvvMMK5Yn3+7IAR5SOtlUDPBZvjMCsj/aODvKUnE6d4CtpAQ7Wpn+QcloEHoUZ
         9VRM3EnSSexB1LSr/c80XcsW1AZmAW9Y8vQz6E+eVHuFtGWaCQSFX0Hxsk4MXMns33Zk
         W7hMsFItl1du5IGJTJCFA+om2EwPL+RScfISLv3CMIDaiEI50mQIb/0ZwaJEUem+0S9h
         lOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198513; x=1748803313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTEeaKmJSlTWnxXRVuHeQLC/jR2Ff9zhxX2PlUzFVxc=;
        b=gjVYDhXxnNJhvyCRUdeGlZ4hLNy1LXDYTEoTksyu6lQEL9+w0bQXLozzx/2GP1r/9q
         p/k91Xp+muFdSWSYfn//wimUfUNT7qU9v9UGagbTGAsTPsIeGtOfdKb5ehkEk/Lplc7S
         MyeBRGQsgIqb+gEMokeBLcAMTy2f9mEMUQpnQNjni+WVkLDxqzDcwCNPg590PpgfLGkg
         OLQ44xJ02/vn4psn+S9fgBDfS8kmHUYjABOGfXdO5xw5l8MAsZoudpZ2QjMs6H96EcKJ
         hScK1IlocAercniJaUAZVXY3Usn6cuc8fkgCpSq8XPP+rqbha0voVbZDiiqdSiGn2YzX
         1mTw==
X-Gm-Message-State: AOJu0YyZLDyoKOCMoE1pRvFH0lC1kfGdbRTGvYsQulnZGn6woIFCiS1i
	Vl2jDhTstffkPDwiiOIym8QYQ/bhAQPsAg2XgqoyvW+zrhUh0/auFOTbfWKm1lujp2NEf8eyHpM
	e3yYq
X-Gm-Gg: ASbGncsW1idLxD+1ButkbXdM8uJnjYPxpT1rSl90mqNbg7yJxDDJWuaEl5Hh4Nx351W
	iGe4clV4g1/BzMtcBJ4iZON1aSvl4Ir5xY2z839S2W3q0g0Y5czSwj/gBXhOfODP63G8xBx2ou7
	CsjMl2qHQITtX7rY5nvuDcfxPIQfD0eAJw1l5iMwnZz5zrVGqhOdERcu07vs7nnfq31MyOQHTyz
	axBziuMdjSmHlY3LJEAzfANUwTl4mqkMs4888R5rSgYgSC9e2Gn4X2tAMcABclpszTJfayzy5nM
	j9k+JK/4YtXUG/oy+IzrVbU5r0/VwcRmmM6Y5O3UpSrkg5S+qymb6G/Y3l3rsW/5MY/3UNoNmya
	wnTunULLDMigSN/AXjAcoadk=
X-Google-Smtp-Source: AGHT+IGhnnOxEHZwXfp9vTj6QGB2nngIOAPNJwQQ67l0hoFKPGl9+kvHXdzxfUae278SocvGS1oW5g==
X-Received: by 2002:a05:6214:1d0d:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6fa9cfd2a93mr116484576d6.9.1748198512862;
        Sun, 25 May 2025 11:41:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6faaa13fe74sm2941076d6.51.2025.05.25.11.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:41:52 -0700 (PDT)
Date: Sun, 25 May 2025 14:41:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] pack-bitmap.c: fix broken warning() when missing MIDX'd
 pack
Message-ID: <ad7295b11b2e2c48d859623bf1bcfd92ef15ef9d.1748198489.git.me@ttaylorr.com>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748198489.git.me@ttaylorr.com>

In commit 44f9fd6496 (pack-bitmap.c: check preferred pack validity when
opening MIDX bitmap, 2022-05-24) we started opening all packs contained
within a MIDX when loading its corresponding bitmap.

However, if a pack is missing, then we will emit a warning like:

    warning: could not open pack pack-$HASH.pack

Later on commit f31a17cea5 (pack-bitmap.c: open and store incremental
bitmap layers, 2025-03-20) updated this code to work with incremental
MIDX bitmaps, but did not adjust the index into the 'pack_names' field.

So if there is a pack in an incremental MIDX chain with a pack in a MIDX
layer with a non-zero number of packs in its base layer(s) (in other
words, any MIDX layer outside of the first one) that cannot be loaded,
we will do an out-of-bounds lookup.

Adjust the lookup into the 'pack_names' array by the number of packs in
the base to prevent a potential SIGSEGV here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d86604..99c4927e9c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
 		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
-				bitmap_git->midx->pack_names[i]);
+				bitmap_git->midx->pack_names[i - bitmap_git->midx->num_packs_in_base]);
 			goto cleanup;
 		}
 	}
-- 
2.49.0.641.gb9c9c4c3bd

