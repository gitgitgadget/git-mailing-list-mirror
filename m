Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD41E25ED
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505875; cv=none; b=tHiR+ULAN4x5qg+koT9kr3c0YF1a5FDo7IwjrrggOU3T3RSunmjE10nXRPG/PPz+MOHQ7aRsqUmuQu/fFTrrJrK6fTAVZdAcBXd0vCHGSDZnRNIokFr7i2iFXCbBTw8brWhLCnGZ48GlXfBJPtEQ/YqaKBmvQMQgo81qRusYfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505875; c=relaxed/simple;
	bh=VHXqtIrTQ8EoL49wvasLQy0bQ90hM+ngote5lOyTFs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXs9bp3yS5kIh6YF3lWAr6TX2FfJk7alrPs/C8vlp0WdzSFexF5pquwtk4/T0/ZAZreZgt3VAEi/pxHyFd1wZVqcvy4T0G7mli9WU9/EhGRNqC0ii2mmoFu5OeQZCSHtr9Z1nsFq8dklP6iDD3LsYoZS/CuTx/Stl5h7UV5mJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1NEkCfK0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1NEkCfK0"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbc9a60480so2802037b3.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505873; x=1729110673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DmxUW9VfrcaxEOmru85wG8XZ8VpKgOyjgrDK9i/sLc=;
        b=1NEkCfK0z12L0kXte+VXzm/8+qEW5gaxBQD4HZw7kJNUTFolD7BGlJQcohyAAeAgv1
         aAg88LbI1iX7lqBli3sSzFuQOT4/C3NVEismZX/9UYHgX24ZOAYzhfEwtBrUQckudIMl
         +uUggrbRQOU9nU9/Y+V3XzV1NPKygbnRZcn5pXA/T370kfu8PlgrwTIsGsJVjPG02gQ4
         5Ravqq/GvevAmGLBxOebTzhKvGHLVNBL/bkX26ZEEaaDeCwp+VYnzlViw2N+dYr+zQpd
         WW7pwtTNMsBczOslcLzhk8dKTKh49Wsn/VslxzvGV9Q8MpPZtwAoY/tt/Fn1qQDHs4yF
         MjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505873; x=1729110673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DmxUW9VfrcaxEOmru85wG8XZ8VpKgOyjgrDK9i/sLc=;
        b=qhfonmE+i+lWie6NV46JV/uLUzieo4N8aNG0ZJMBtG7tL+aeVmDLww1aM/62m3qbfb
         i21kiSLrT4Q8HaN4MiSCJCG7NXxk/pFrNfyoeckfDTWl57iX85yMS2d3MJez98jfqWbg
         5K2hk+q1AqXEQERVnilkDoIcTY6mVNINBbJEkib/jxmwvRuo/HAxx7GqJfzLp0eV5NKG
         oEXHTZZ43A3Bpzb52NXPkPO/5Vro+rtWzzFY8diKtRRCzqQVdT2hBycHgUUnyECFwXEW
         ySOE4MsqNqv7BX/eF7NPEUVgkbJe445YSgb+DzOARjeKEKXRKSPHAJXmCz9dJJrknnIb
         2Ulg==
X-Gm-Message-State: AOJu0YzkSixqAs87ZyflSYOxgcYn36HZCzCILwZmkqf99UYkEttGqh20
	/xNjiqkqgfNMEdGABAyjPRTUif94UOb1ljasH/2r27qATqEJ4bEc2az4bdwkqaqu9AwfOkCjd9S
	bu/o=
X-Google-Smtp-Source: AGHT+IFXrXhIyjKXfwuHcnpecIIWIXyda3nc72rNMpnN9+/kvWFfZHUeWpIL1qkUdAlj4qHrq/4fYg==
X-Received: by 2002:a05:690c:f0f:b0:6de:351:3e with SMTP id 00721157ae682-6e3221867e6mr43772907b3.8.1728505872947;
        Wed, 09 Oct 2024 13:31:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e318698e66sm6554917b3.32.2024.10.09.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/11] pack-bitmap.c: compare `base_offset` to
 `delta_obj_offset`
Message-ID: <bc5ff77f63b42dbea70b12f736e48f95fe8d6cf3.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

When comparing the offsets of either half of a delta/base-pair, we
compare `base_offset` to `offset`.

There is nothing functionally wrong with that comparison, but it is
slightly confusing, since `offset` points to just after the delta
object's type header in the pack, whereas `base_offset` points to the
beginning of the header.

In practice, that distinction does not matter, and it is perfectly
fine to compare base_offset to offset.

But we already make a copy of `offset` before it is moved forward by
calling the function `unpack_object_header()`. So let's use that copy
(which points at the beginning of the delta object's header) in the
comparison so that we are comparing like quantities.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index faabc0ba0e9..3e1034cabf3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2117,7 +2117,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			 * position, since the bits are ordered by their
 			 * positions within the pack.
 			 */
-			if (base_offset >= offset)
+			if (base_offset >= delta_obj_offset)
 				return 0;
 			if (offset_to_pack_pos(pack->p, base_offset,
 					       &base_bitmap_pos) < 0)
-- 
2.47.0.11.g487258bca34

