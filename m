Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003A1D14F3
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059258; cv=none; b=hWv6v9K8is9yM5gmbsnJ+zIKC5jn6/Sz/ZdwwiAcGh5gFkRvWdT83TOft/j0J4kaj81rENRiiTV7MtKPinx4dQ2f9ayhl1O/d9VRU3Fuu1hpMgoRrpo9eiFFxrdSsBA+4hMc/3gk9h3WMZiTIvmmzzMAj7UY6ziYd3odp9WyLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059258; c=relaxed/simple;
	bh=gtuFAIlkz83zEK3Olvfb66Y3eNFdRePYsd3w6HgnyEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP9tBGNocCC7f2mCzK9GlnugDQvYOLkbr8oVShxHWoKbdrDatnSGoZXClZJ33jUvv01RgNoTkWHZ+8zhYdfUPcApEqD3cnyQ2+4pEA7nmpmN3AGO5N1Yy9Umsl/AOYoklkJArdEzzGPpWTAaJsZRdoi7/T/8VWNMkP8eZ/PE0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JLP/1TFu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JLP/1TFu"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso3339566276.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732059255; x=1732664055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwAUdcaXHBzrE6YeYy/XkPTj57jJJM6as1tStUXA12w=;
        b=JLP/1TFu3mKcKmMP/bPGdyCXiNAx8DNJ3adOD1sH1jzFL5ln5fVeZhxF48s83Q4DrP
         rkkO8TXftSkzBRzocZ/fK9hnlHyZvvTNju3XwohXYRAlfP1nxlqAxK0ASqX297fIgz8y
         9krMzmcsfWNvLgCYBtGteELRHkAphAS2L8MwMo6aqm6RgSToxVi/N23L4CUN22l8ah1y
         aoG+Mff4b8sXGXG6/g2kSgNCIIW6Mc+kkaog+4w/8dR/qlshsPRbdHqRaMLsWqHV3rKv
         ZOOFt42Y7QtYnjwyoRwtcJrzU2FerZtfvn469FehjqjUV9+BrfWCVZMGJlAg8a37Zejj
         YK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732059255; x=1732664055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwAUdcaXHBzrE6YeYy/XkPTj57jJJM6as1tStUXA12w=;
        b=uXIZK7GOZW2EwAmaydyuFdkmjkaeCxqHg50vKPzXwyuP/SQworyrRegzlkTBR8B/9I
         5zqnLqHAFizg7inldR9ARszkvbDnC9gwo1ZYHOO3hvjR3jv9PenJ9TZtXWhGm+26zMzS
         2RKOPXBM/iubxtPLxCfRjvGxhkAoOAh8XDM3a5UPCRu4WckeU+6DDSr3OtX/3eUxuM5t
         0yCoMydI7Kw4cj3XZpGDRC8swcwririBNtHXMBvuMeKj+P3irR+e6IhSmNYRV85REgLW
         es7u2WJPaq8X6F1pSPTHfZQJx4it4DW4G0I4+APDh+z4jPol9yrSwW0bNdkmLCczydUh
         inzA==
X-Gm-Message-State: AOJu0YzrL5TaqrTOCRjxBPXE4Fm1CS3pbyKZzc/Ey8zOShemfpcGRKmR
	oHcv7GTu5PZvdVy0lRlSmEuHSPvgeA8ngasza+WWN7H7LcqPnPcIMykzwenb3z2O0y8I1aL8HgI
	I0a8=
X-Google-Smtp-Source: AGHT+IGnIO+bDC4yRMaASND/o19xVo3KwRKVPVV4hao6v9hkKDZ4xmguJdyIZTZ1UUtdh0UDJeLmlw==
X-Received: by 2002:a05:6902:2e0d:b0:e30:c739:8e5a with SMTP id 3f1490d57ef6-e38cb59b650mr545852276.14.1732059255068;
        Tue, 19 Nov 2024 15:34:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e763c98sm2769113276.28.2024.11.19.15.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 15:34:14 -0800 (PST)
Date: Tue, 19 Nov 2024 18:34:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <Zz0gdHrwC4CTAtZn@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <20241011083838.GI18010@coredump.intra.peff.net>
 <Zz0aaPdHiFyoRkKg@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz0aaPdHiFyoRkKg@nand.local>

On Tue, Nov 19, 2024 at 06:08:24PM -0500, Taylor Blau wrote:
> Then when running the same command, we get results that are quite
> encouraging. The runtime jumps to 24.213 seconds, which is ~9.73 seconds
> slower than the average of the baseline measurements. But it takes
> ~10.418 seconds on my machine to compute the forward index. So it's
> really around 688ms *faster* than the baseline, despite doing a little
> more work.

Sorry, there is a much quicker way to generate the forward index at
runtime, which is the following:

--- 8< ---
diff --git a/midx.c b/midx.c
index 67e0d64004..1023bfa51a 100644
--- a/midx.c
+++ b/midx.c
@@ -989,3 +989,17 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag

 	return verify_midx_error;
 }
+
+void midx_populate_forward_index(struct multi_pack_index *m)
+{
+	uint32_t i;
+
+	ALLOC_ARRAY(m->forward_idx, m->num_objects);
+
+	trace2_region_enter("midx", "populate_forward_index", the_repository);
+
+	for (i = 0; i < m->num_objects; i++)
+		m->forward_idx[pack_pos_to_midx(m, i)] = i;
+
+	trace2_region_leave("midx", "populate_forward_index", the_repository);
+}
--- >8 ---

I don't know if this makes as much of a difference for regular
multi-pack reuse, since there we're only making calls to
midx_pair_to_pack_pos(), which already uses midx_pack_order_cmp(), so
there isn't any additional translation to do.

Thanks,
Taylor
