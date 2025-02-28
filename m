Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1731C5F18
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785210; cv=none; b=R8yyvQJzm1WviM0Fbj/8HWIbq5rL4Ri46W3WvR+EwGgYyXFSiHWv2G4CFVQaG2t/DuH5EZqz9iSVaox/mLy1Q8mZqSF9a+V3/DUxmzzEH5yszOudc2TwzVguztMjBz5MSoFxq14LJxorWIYOKFqo3igjP8TwhqIuKla8+GvGaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785210; c=relaxed/simple;
	bh=oNT46T19CbrG0yyLU3bB1tVL4IPlSwmsKd0clbIz5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWL6pL/VDyMAEcYUdbb782KV7RSmgULdH/LuG9U9jYjlvFuh0pEBDUGz4x5VXvSVw8DNTOlXIWJHQLccGOQwDU5bmiZVVJqDLI6UJa/RCqQqO+tOK27EKcIO90N4JSLFN2Op7/dsr43vblLv8lEOxAdzyr6XGxOmPuthLO1F1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hkI3hw3P; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hkI3hw3P"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6ca9a3425so24581817b3.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740785207; x=1741390007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1jJcSsahDHZB3GQoaFoWFVJ+0g8cEW2Q26lP2IAkLs=;
        b=hkI3hw3P2yb1yWRtcyDRakqtMRAeZZt7V+9Tbo6pUh2q4bkyTHK0LZe7RojH4iJ7kQ
         YKU+fq8qDzcOnBxO+ZesDyYzeZ0yhPWjYGxPiR9bCDnN7ylq3dZcQNKOpO2YiRpZ49+G
         i9+DPwoz7eir5pZ1zTX1SOsGZ/aR2dp8WEPMHJpqAoURjhweC5lSxan0r4t4KRjg54ug
         fRExUSWtScV5eGMYa7m8tQmXlPirx8iRs60xzoUOTB0GhsV9G+0R5P9cLMkrxegjDEbo
         7fHqnJjmjSXusrPmxZItefUrhsC4ErVaXIx1qvonws9NTbjozeVc3Xwoke97ZeioJyJN
         Y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785207; x=1741390007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1jJcSsahDHZB3GQoaFoWFVJ+0g8cEW2Q26lP2IAkLs=;
        b=w7ywuWOkqyAfh2AYQ8AGRDDCFqpKMuNvF6+U2mEEQaHZVfrCoTrIbfs/WYdtgokm8z
         uaPUJE60jc6hwUOQkBd98b20JIbKS/kHGn+P0WA4FfqqZMG1XXitjYrWK8oQMqd6HsKo
         Dl6iS6LMzSW0g17vzWhydtISTN42fMahRGiM/UYc0XSxzHFWo8YQeFvVkH/lDpmq6I5e
         kAwUl/5rQ8Y3+HIQITvUBS6EgsKeJk+8yzq0a7EDdPmv+0Ex1xoBpLaQ9/oInAHkoi7d
         PzIkAgPxwhhtL5VQcX0/UBWvMohF55h3qJ13iCQ6t+wPrgoBEZounT1E3oXBDK9Ahv8k
         LUcw==
X-Gm-Message-State: AOJu0Yxpy6s1EZE9jhpQ+4IPiwTA5I5iSt4pZcfD7olPAiVwgBqG8hX5
	msgo9gB2C8QAUfX+GuoIR3QGJQrmT5XpBwnbWeZf2vHfQo6GgDlhvj5vaWhrET4=
X-Gm-Gg: ASbGncs+UrO+doyAxKLjOuYxuWpmUgF6wEfUjSJyZ6WA7QxAnPqni60dRWGZIW9+K9N
	ctdPybhoHQL2pQUHbSBPrEih+7EBRkgPNbAMthVIK+JnmePWst/2PQSv9N9eC+bJWuzJNyKpI5K
	VekVuQSpjSzDUSExOkS31ufGht9m3MHSDcBS4LiAvx/M0JXGC5GyvqgSl/1uGi/oEmG8EVNRMEc
	m3f1B7jITEaMTjZUGQwXO48sAZLp9fIuv/yN2smbaA7nS9A3s2umgl2MQh2IGGWjBbbMGIymxef
	jwtT0H/5lhHJ00uZN7IKAVVrZB3myowaLir+l3yYSMHEPEzdDV9/JVL/cFx+Z9QzpCIyMLFcIOu
	ow45AiuUq+wN7jNDM
X-Google-Smtp-Source: AGHT+IGixan0/M43q43w6OWUq6n1GVHJUPpPmlIC8ELNQZo+nkGraePsY7u7j+XZUZHCHR0txpKRpQ==
X-Received: by 2002:a05:690c:4a06:b0:6ef:94db:b208 with SMTP id 00721157ae682-6fd4a12a1c0mr75429967b3.24.1740785206776;
        Fri, 28 Feb 2025 15:26:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca0eff2sm9479897b3.20.2025.02.28.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:26:46 -0800 (PST)
Date: Fri, 28 Feb 2025 18:26:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <Z8JGNQZolfs7fm65@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <caed2c6ec3483f028f59777bba40480e2661ca80.1732054032.git.me@ttaylorr.com>
 <Z8GJYMbXMZqI5fUL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJYMbXMZqI5fUL@pks.im>

On Fri, Feb 28, 2025 at 11:01:04AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:19PM -0500, Taylor Blau wrote:
> > diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
> > index cc063b30bea..a063262c360 100644
> > --- a/Documentation/technical/multi-pack-index.txt
> > +++ b/Documentation/technical/multi-pack-index.txt
> > @@ -164,6 +164,70 @@ objects_nr($H2) + objects_nr($H1) + i
> >  (in the C implementation, this is often computed as `i +
> >  m->num_objects_in_base`).
> >
> > +=== Pseudo-pack order for incremental MIDXs
> > +
> > +The original implementation of multi-pack reachability bitmaps defined
> > +the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
> > +titled "multi-pack-index reverse indexes") roughly as follows:
> > +
> > +____
> > +In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
> > +objects in packs stored by the MIDX, laid out in pack order, and the
> > +packs arranged in MIDX order (with the preferred pack coming first).
> > +____
> > +
> > +In the incremental MIDX design, we extend this definition to include
> > +objects from multiple layers of the MIDX chain. The pseudo-pack order
> > +for incremental MIDXs is determined by concatenating the pseudo-pack
> > +ordering for each layer of the MIDX chain in order. Formally two objects
> > +`o1` and `o2` are compared as follows:
> > +
> > +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> > +  `o1` is considered less than `o2`.
>
> Just as a refresher for myself: what is the consequence of an object
> `o1` sorting earlier than `o2`? In the case where those refer to
> different objects it is only used to establish the pseudo-pack order so
> that we know how to interpret the bitmaps. But in the case where those
> two objects refer to the same underlying object, e.g. because the object
> is contained in two packs, it also impacts which of both objects would
> be preferred e.g. during a clone, right?

Great question -- the pseudo-pack order here is how we translate the set
of objects in a MIDX into their corresponding bit positions in the
bitmap.

So if "o1" sorts ahead of "o2", that means that "o1" will appear in an
earlier bit position than "o2". But note that we're talking about
objects in a MIDX chain here, comprised of objects from each MIDX'd layer of
that chain. So by that point the duplicates have already been filtered
out, since:

  - The MIDX only stores one copy of an object in any given MIDX, and

  - The incremental MIDX design avoids putting objects from earlier
    layers in later ones.

I tried to get at this a few lines up with "[...] a MIDX's pseudo-pack
is the de-duplicated concatenation of [...]" to make clear that o1 != o2
here. But let me know if you think I should clarify or emphasize that
point further.

> > +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> > +  MIDX layer has no base, then If one of `pack(o1)` and `pack(o2)` is
>
> s/If/if

Great catch, thanks!

> > +  preferred and the other is not, then the preferred one sorts first. If
> > +  there is a base layer (i.e. the MIDX layer is not the first layer in
> > +  the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> > +  pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
> > +  appears earlier, than the opposite is true.
>
> Another question for my own understanding: why is it relevant whether we
> have a base or not? I would have expected that the case where the
> objects appear in two different layers is already covered by (1), so
> from thereon we only need to care about two objects existing in the same
> layer.

Good question. Throughout this design I'm trying to get rid of the
concept of a "preferred" pack with respect to the MIDX. Before
multi-pack reuse existed, the idea behind having a preferred pack was
that it was a way to indicate which pack we should prioritize for
pack-reuse.

But now that we can reuse objects from any pack stored in a MIDX, the
concept of a preferred pack doesn't need to exist. It still makes some
sense (if you want to use single-pack reuse for some reason, etc.) but
I'm trying to push us away from it.

So to answer your question of "why does it matter if there is a base
or not?" the reason is that this series treats the preferred pack as a
property of the chain instead of the individual layers. And the
mention of it here is to differentiate between how we compare packs in
the base (favoring the preferred pack) versus subsequent layers
(reflecting the pack order within that layer).

> > +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
> > +  same MIDX layer. Sort `o1` and `o2` by their offset within their
> > +  containing packfile.
> > +
> > +=== Reachability bitmaps and incremental MIDXs
> > +
> > +Each layer of an incremental MIDX chain may have its objects (and the
> > +objects from any previous layer in the same MIDX chain) represented in
> > +its own `*.bitmap` file.
> > +
> > +The structure of a `*.bitmap` file belonging to an incremental MIDX
> > +chain is identical to that of a non-incremental MIDX bitmap, or a
> > +classic single-pack bitmap. Since objects are added to the end of the
> > +incremental MIDX's pseudo-pack order (see: above), it is possible to
> > +extend a bitmap when appending to the end of a MIDX chain.
> > +
> > +(Note: it is possible likewise to compress a contiguous sequence of MIDX
> > +incremental layers, and their `*.bitmap`(s) into a single layer and
> > +`*.bitmap`, but this is not yet implemented.)
>
> Fair. What do we currently do in this context? Do we just keep on
> appending layer after layer?

That's right. At this point in the project we only know how to append
layers and compress the whole chain into a single layer. But
fundamentally it is possible to compress any contiguous sub-sequence of
the chain into a single layer, and part three of this project will do
just that.

Thanks,
Taylor
