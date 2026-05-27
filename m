Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36641E0DE8
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892576; cv=none; b=A8+Uh+3nDVUbnaClTL7GAI77eLdMjYXMSTJ1UDLDlDwxWRL9FohpQoSZgY/Ctjd3Nmi4HedtWT98GmxHbnXMACBE4KGs1tFiXmk6L5HGFbTO3RRCm23g+iwnr75AY4p0lbaZzqnS25afQIzUfYiqeb+c24f8bgqM71R4fYK+Jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892576; c=relaxed/simple;
	bh=Dhq02FQ348ROHUiTdQTTn3ZE7DPBHPx0JSepi60le5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOD+wnS9ANoBKyrdlYdBqlqWrZMYfvxQyFe5mh2oKFsBp5szNgF7Ujjrq9SOZJVHbkZ2B/nAYR4HACSj/XLdk98m0TWQJdIFnG7hr4o9dMP1fPM1xvDDFWVcnR+9Dd8EoPyuHfJnfabMpFauICyi3P1R/PqHEJB1rUffjaW0ABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jp9lLyEF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jp9lLyEF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdec52f48dso108523777b3.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779892568; x=1780497368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl4VNojSouUxLXZgeBbg38bgzQeG1Vs9X/7tFiLc5K0=;
        b=jp9lLyEFDPsiILOZTC1KYnduRkd50WJ8zRG2dMNPF2fK3U8nFlYVT5PtmthUR5v190
         qcynzn9qGIu9UQs/lci/Ylnsi9eGgv1gCCJfG1DziwSoklM39ud864dEqOibGdSfM0rU
         WoC9wew6H+Yt54PvEEfuSzz7sXY5RQiKk6i04ojbHDA+1I6uNp+eObtwfMlvlYxG4/M+
         d7DoOfWcCSafq/uwjHRyHXfYPJLjVsNdsXst4Hhr6UYoJ+5qnN7OMgKwVnLwPXYqze3y
         In5ZIeHhSj+pWg3VPs28gQRYPA+7slqHce2BR+1+wpwZryLOI1xFrO77hGuM2Krb7gc6
         HpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892568; x=1780497368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl4VNojSouUxLXZgeBbg38bgzQeG1Vs9X/7tFiLc5K0=;
        b=JS+Ci+L0PZUNLQ0D/wIOld0WT1JNEoLZJSoXsLCXtjFNLN+3+eF+IYeMDmSH69GxgS
         MiGpPbp6buqqgyya5dcQzOk2393chG/KSqubXpUr/jK9wdlJp9pW/FJ2NIkdbqODJrEf
         B9dwIofAtXQ7Qwq4hlyHm25kS4xAvumQdCN+BHOcRmulcM94G37g6djDWoHAYIEbSUEg
         18/Srf/Del39/cTzKsV8YnYyDDEKOHEuZ08b/193ULGC6RBrkG1OzqDSxqnBa8psIiGz
         Ee6k3hBfSsSCTQAkftChjZaveguegPSv8bFiCBR0oH2ln1KDUvQIkNlKD8W1YEDGJfOZ
         h79A==
X-Gm-Message-State: AOJu0YwnNkm63tVCcTUAuUnnZDZSExPXv0IP5AmELd+fL8/YSft0oaWZ
	qQHsEp+MNvhIZMX/DMQ8q47+eawhDxLjHXHj3Z0lB40wmUEsSRG0s9NxXfKF2TPS6OM=
X-Gm-Gg: Acq92OHYdO+3ByaCw2Od5L4Q3tiW/jlmGc+qP68XDbDPU6Q5nFbLzvaSc4Del9cuKPB
	EiioN8mKhGlhH6wfuOxjUTcaw6Zkv4d+ViY31yYS/kh8Wgn2PviUknbWGD+JVJn7pQmtP5/EjPB
	3uwIK1gur1xsvq03dDzhBoTCSS17JYGMEWS9qiWgljviAd4D77mvOQKdFzFYU5FCnCxHwBCY0+e
	fuIytrO3cHXzdFxbqQsM9s5mG0fcQ6dxvltLFbSQB4vrK+BSO1E4gpeMCaR3kbcgOA4/VHk7m6Q
	wOy48giUHcqbNFa2S4U6PhG32IWXcGCYOlxEJgUyz9hr39PB8S8jNKAvbOQdiL5ZkZRs3LnQx95
	bs7/46xEg1qMYgC2ukbsD4qAjb2zSO2q+dJlqcBPrIYotSGdTg0ni3bVWOZWrOxDRtcRJWe42Nk
	SrkdqDWPJA96RiPLjUcyeHkOo+IzKRo2S7f3W/VvENlpC5zh4RF8AJENVpbMyYTo2rZCeqLOyuU
	94beb5DwgNMpdMX/ZhvAYUrAnjb2XM8YyEForsd406vFE1sxDuI7Xq2L3sRTEZc6DJLnp08f+xV
	aHK9z5GTY2N0Lsi5o3XAENEGGCLHttS34YHN/g==
X-Received: by 2002:a05:690c:34c9:b0:7dc:1c56:2901 with SMTP id 00721157ae682-7dc1c562a3fmr447817b3.1.1779892567596;
        Wed, 27 May 2026 07:36:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be2dc79sm76870927b3.25.2026.05.27.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:36:07 -0700 (PDT)
Date: Wed, 27 May 2026 10:36:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/8] pack-bitmap: pass object position to
 `fill_bitmap_tree()`
Message-ID: <ahcBVlwysYlKsjUs@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <13191c19b91bc3f5d671b7016b97f2309f12737d.1779207127.git.me@ttaylorr.com>
 <20260527085740.GB981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527085740.GB981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 04:57:40AM -0400, Jeff King wrote:
> It is indeed surprising. There's a possible candidate for the speedup
> here:
>
> > @@ -482,8 +479,12 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
> >  	while (tree_entry(&desc, &entry)) {
> >  		switch (object_type(entry.mode)) {
> >  		case OBJ_TREE:
> > +			pos = find_object_pos(writer, &entry.oid, &found);
> > +			if (!found)
> > +				return -1;
> >  			if (fill_bitmap_tree(writer, bitmap,
> > -					     lookup_tree(writer->repo, &entry.oid)) < 0)
> > +					     lookup_tree(writer->repo,
> > +							 &entry.oid), pos) < 0)
> >  				return -1;
> >  			break;
>
> Whenever "found" is false, we cut out early and skip the hash lookup in
> lookup_tree() entirely. But that should almost never happen! It implies
> that a reachable object is not in the pack/midx, and thus the bitmaps is
> not closed (and we'll refuse to generate it).

That's right, and I had actually written something like the following
while developing this patch:

--- 8< ---
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2d5ff8fd406..328e1c13df3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -481,7 +481,7 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 		case OBJ_TREE:
 			pos = find_object_pos(writer, &entry.oid, &found);
 			if (!found)
-				return -1;
+				BUG("huh??");
 			if (fill_bitmap_tree(writer, bitmap,
 					     lookup_tree(writer->repo,
 							 &entry.oid), pos) < 0)
--- >8 ---

, but couldn't trigger it in either the test suite nor in my sample
repository. I left it in there as a sanity measure.

> So it really is the case that we do the same operations in a different
> order. Weird.

Yeah, I puzzled over this for quite a while myself. I really think that
this is reordering produces more favorable cache behavior or codegen
that results in a meaningful speedup.

> But the patch itself looks correct to me, and I get ~6% speedup on a
> from-scratch bitmap generation of linux.git. I guess it could vary
> between architectures and compilers (I'm using gcc on x86), but since
> the reorg is setting us up for further optimizations in the next patch,
> I suppose there's no need to look a gift horse in the mouth.

Good, I'm glad that it was reproducible on your machine. And I agree
;-).

Thanks,
Taylor
