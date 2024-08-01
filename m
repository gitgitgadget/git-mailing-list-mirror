Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3661EB48A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542740; cv=none; b=SQf7PmMztsp+D+UZmuhu5u37pqi5bCSCkdHeQYpg5j2qnnO7ZGkQr1pi2RmxOkRqCvAFn1318p2xUbW5zFH509tk+yrtDnqzL8bsPrwAi93w8JMZLoMH+H25xEsercBsIn5t8rgejMP8CkkdH+d0B70IQZEixhcvmrXCmYvJzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542740; c=relaxed/simple;
	bh=7fBSqmGRjmWW5IcYTT6lB2F6peUtUfdPOlvvCF9KW8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsHRSKhhCdLP0vICbJq/nihPyLWQkSvhJoM5TtJiTzDfEo2P3D7D9q7sn1BdpFzVsyx9FzjgZrjOXZsFWt4X+mqbOYDb5w9J4lCzcd2D4EGC8SE67y2YpQornA7tfC+zHYs7O5GWzGlnLkNExliynm1NnPaOgfHBJAJR+aAPP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0XkoR/WH; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0XkoR/WH"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2610623f445so4907126fac.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722542738; x=1723147538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIXKTkxSpgAP4igJEgaiwFvcBpHeTlmWCP0WFErA748=;
        b=0XkoR/WHhqyJ8mHpX9fpeAHcQI3Y2rrLouaWkLEHi/9YihJh9LbGI3GHGwJ7e3v16J
         AS7szI8XNGuj0EwFBYmtHbbnx+0QUngBY1myr8YiRAz5Ra1+5Io2tyu7YGcIxzzZQT0w
         yvp6xau5AaYnC4EGb0CH/OLJXqBfAiDh131+yLUghjQF/AiPg4X8JDlJLUgO7ruGcHMn
         CMh9VXLx0rAmsOBfTa9yGgaR6W5M8YC60ne4KaPDLyp5v4rqoR5EdIkiDwUJMQo1jBRX
         MBwjvotBC8zPyAPpPoIKyPKNwXFMciR0DEfjrLoKWjiAY+odM0NI/xYAfujY+ib9n4/4
         W+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542738; x=1723147538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIXKTkxSpgAP4igJEgaiwFvcBpHeTlmWCP0WFErA748=;
        b=D+qI14VyF8fwdexJ8L/LtVg/ZSx5nuljFAT6EKeYeeydWNPW8wKMrA8hW9WxbDCt9r
         trICLgOg0p6gniI/gcPTAD1lGHiomDY1Vu+s1Dj/GaVeBkwt2r9qN6DXgkcTSnFKZRD3
         mNPxP36hf53AaLrrCO1rzWLd4oYZNGjmpUBHlToS6jUnkilJB+h6196gOMv8oyDtKnZ6
         fY7OttBPbM1GbEi9rJhQdiLxv+h2/cGWPh1swAvNkXvF3IaGVKYIdlpo4xyL0Md9x+SE
         mDmrUa6WL1ERK3OLjeB9Dseb/IghYS6rK/zhtfknR7jESMhOVIhMD1cd1jHV+VSqVv+Y
         EGCg==
X-Gm-Message-State: AOJu0Yx9pt3fvNp7qlc0s8YR4+GLpZOZ7T81FeqReR5HHsXQkc6vgELr
	yLdxLrfdx9kmCJRon95Pym9hsi4f9OCb8sMvGkXYj2+cAyGL6xhdBk9WoH8mI1KOh2WyPy6qpz6
	S
X-Google-Smtp-Source: AGHT+IGRjZN87w/2b3BWmzqTWpwyO5oZfE/1wFm/xO1W+QlWz1lF/ijhfJCHB61Vg4hqn248VLHVVQ==
X-Received: by 2002:a05:6870:1718:b0:260:dec5:11cc with SMTP id 586e51a60fabf-26891af7211mr1487108fac.20.1722542738433;
        Thu, 01 Aug 2024 13:05:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f786979sm22990085a.112.2024.08.01.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:05:38 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:05:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/19] midx: teach `midx_preferred_pack()` about
 incremental MIDXs
Message-ID: <ZqvqkHph6YYyEHy2@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <38b642d40423f2e14dd47d676de54f264b9d6f22.1721250704.git.me@ttaylorr.com>
 <20240801102517.GM1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801102517.GM1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:25:17AM -0400, Jeff King wrote:
> > diff --git a/midx.c b/midx.c
> > index 0fa8febb9d..d2dbea41e4 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -500,13 +500,16 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
> >  int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
> >  {
> >  	if (m->preferred_pack_idx == -1) {
> > +		uint32_t midx_pos;
> >  		if (load_midx_revindex(m) < 0) {
> >  			m->preferred_pack_idx = -2;
> >  			return -1;
> >  		}
> >
> > -		m->preferred_pack_idx =
> > -			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
> > +		midx_pos = pack_pos_to_midx(m, m->num_objects_in_base);
> > +
> > +		m->preferred_pack_idx = nth_midxed_pack_int_id(m, midx_pos);
> > +
>
> OK, so rather than looking for the pack of object 0, we're looking for
> the first one in _this_ layer, since the position is global within the
> midx. That makes some sense, but is pack_pos_to_midx() ready for that?
> It looks like it just looks at m->revindex_data. Are we going to be
> generating a revindex for the whole chain? I'd think that each layer
> would have its own revindex (and any trickiness would happen at the
> generation stage, making sure we don't insert objects that are already
> mentioned in earlier layers).

pack_pos_to_midx() is kind of ready, and kind of not.

The way that the pseudo-pack order is constructed within the
midx-write.c code, we will write reverse indexes (within each MIDX layer
itself as a separate chunk) that contain data for each object within
that layer in the expected reverse index format.

But we don't bother writing any reverse indexes for MIDXs which are
incremental at this point in the multi-series plan, since we just bail
if the BITMAP flag is set (saying that it is unsupported at this point).

Arguably we could have just left this hunk / patch out of the series as
a whole. It's this kind of stuff that's really at the boundary between
adjacent "phases" that I think is awkward no matter which way you slice
it.

> -Peff

Thanks,
Taylor
