Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA61C5F30
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754752; cv=none; b=YdWjlSYOt2ldpc8dm2MeA1QM4ExtfCWQ+lKunJZJI0xU8phYHm5Wy//dAjvZujgxeF0I69vYtn1eT7IXxPdNoEvnod2hV0BxmvQTlVH1sLo9ek4/KSX5VOfM5EZeLhIpgmHasLZws0jAi+FOcMRm9EopREA2z45YglNVkR65hBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754752; c=relaxed/simple;
	bh=oCcZKFuPU5GShELtTFbFzvp+UJOUuzw4Pe2JhhKgEQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX2PHtzQ+yHpx8DdFB204kdpEHeTu2p9WNCY63mEVqb17FLU8bO7gxoX1iWBAhCYcGNRrYco0sHPIikntED242ROtJVPxHiWhjnX0shRjaBImJ2M1OOcVrf/eNZqC78yP/vDDQaxtcxYoJSwCZ5nAB7ebJKlrmQxiyh8Z0q8rAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x57FvWrN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x57FvWrN"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso507266d6.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744754748; x=1745359548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WwRRYWcpQXPBZo43V27EsRQgP7ftYzqofAZoTZw/6O4=;
        b=x57FvWrN8inTU6+/zBI5dHUziFfx/JveWo9vNC0KztmzjCJYanoAVgfeSwIkBvsmsp
         lAbaSs+rZ899o9E0FwRNCZa89CqogJ8BorVhyovazBXLAJvtfZypDUJa0qcNZtRjPbxK
         s/uPtylwcIKhGGpUy2/klEBIPCJKysCbBgS7e6aLD8UfMRAI63ScheRV3cEosedxJ2zh
         j9CZFTmuFIFnmGnwCdlHXsHYxSHZPl7Yz7Me/18lWcs7qeW9B1QUtY5NK4sPOi5lkrdf
         J+Vw7z019GnJEgmdTVyrHHPP8lt125sq9oA9CBQLCfaQh+GYqN1vmKig39zkNd6nsKbV
         TFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744754748; x=1745359548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwRRYWcpQXPBZo43V27EsRQgP7ftYzqofAZoTZw/6O4=;
        b=fBTE4OhSKRmFpjD7SHaffBEugTDt0Kj+i175s6SiI3mCR6IPMSp5XW18JFV/NLESvh
         qWJGCXxlSeIfY7JOR2+OSoyV9o3z8TNlKzJa+xPKSEASZBCHrYkwKMc176BvJEFMI22a
         nYok7Q379n5dxgbIaJArdEVCNeEC+q68MCTmlBYXanKplEGDDlUPLcYwarpIO1HU0O1S
         qpukUeZgpZqxIoaDWDEFh1GUG1thxKks+9Pkh+1Sba6rU9l9veSmkH5VGLXfW/svzjbx
         C3CsmHBMhy0zOkk1nJc9JxBOBqO+kA4NfgBcwK1mpxd2oZsbcVdqaOsHgRnNHwPxrE1s
         TqZw==
X-Gm-Message-State: AOJu0YyOkPPrqgATRWlrilh9vNaI0LF/ERkaOEf2l3TdftB6AtDliIfs
	aKX++Gh/9HXvk4i8qYoSo8aWxRC/R6Gm9Ef1CeAwzkSUpMAZ/8526pEjySQWI5uvhL54BNpnOqg
	2TkU=
X-Gm-Gg: ASbGncvTYQZHJR0NR/l7oJ0lIBlK07yrbiSolSn5vLbqsj5gtJvaRzw2TIUQ3vEC8QU
	3IHuZXBWoMflxNiHj4SBJQ3Vs1AQVQTCOx6jO7e4N+u9jV6ydh88/hMB2kne7I7JTPdVUgPrNkI
	sF8XUu+6ju1nRrY1UF2WQTK5d7kWkQ0jruaTMQLi59FGAI74ns01yUTaxnEXeHSyH385pwuYMM5
	t4RCz1kMWq0p5U+Gx07mPxCl3ONWh8SpSyl/ant2SsRbaih4T0i5Z5tocjFmvfTAjL7xDXgxyak
	qDWxHgyQqvP66nh+Xo4r3QaP4UYtTRRWH5LbUvY2zD/xI2RIhNjXG+0C1dmchn7GNNjiRDHh70y
	h4Jk5B/qZjsMMfNWP3+XXtyg=
X-Google-Smtp-Source: AGHT+IGQxZTGnn71EWj6VrAn4Q95/BGnlDYkFlZUcz9+zoRytirFTC429DRp+04VuMr5+4agj7L1TA==
X-Received: by 2002:a05:6214:d85:b0:6e1:a4ed:4b0c with SMTP id 6a1803df08f44-6f2ad91b7cdmr18980116d6.26.1744754748545;
        Tue, 15 Apr 2025 15:05:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f6f5sm106155056d6.7.2025.04.15.15.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:05:48 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:05:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] repack: avoid MIDX'ing cruft pack(s) where
 possible
Message-ID: <Z/7YOh+bDN17jye+@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <CABPp-BH7U4Vh8b6L9_FNUsBqKB+4hNT_Twn4S7LTocLvbw1LjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH7U4Vh8b6L9_FNUsBqKB+4hNT_Twn4S7LTocLvbw1LjA@mail.gmail.com>

On Mon, Apr 14, 2025 at 07:57:52PM -0700, Elijah Newren wrote:
> On Mon, Apr 14, 2025 at 1:06 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Here is a non-RFC version of my series to explore creating MIDXs while
> > repacking that don't include the cruft pack.
> >
> > The core idea behind this approach is to ensure that packs generated via
> > geometric repacking traverse through objects that appear in packs which
> > are neither included nor excluded.
>
> This phrasing feels confusing -- what does it mean for packs to be
> neither included nor excluded?  Maybe:
>
> "The core idea behind this approach is to allow some (most) of the
> objects in a pack to be excluded, while still including some subset of
> objects from that pack as part of the repack.  In particular, we
> include the objects in that pack which are reachable from the other
> objects we repack.  This is different from our current handling which
> either entirely includes or entirely excludes all objects from a given
> pack."

I am admittedly having a little bit of a hard time parsing your version
of this, but I think this part:

    [...] In particular, we include the objects in that pack which are
    reachable from the other objects we repack.

isn't quite right. It's not that the output pack contains objects
reachable from the other objects we repack, but rather it contains the
reachable objects from the other objects we repack *if* those objects
don't appear in an excluded pack given as part of the input.

> > Then if some commit (for example) in
> > a pack reaches some once-unreachable object stored in a cruft pack, the
> > pack generated via geometric repacking will pick up and write a copy of
> > that object during its traversal.
> >
> > If you repack consistently using this strategy, you can guarantee that
> > the union of geometrically-repacked packs are closed under reachability
> > without having to keep track of any cruft pack(s) in the MIDX.
>
> Also, if you do a single non-geometric repack with this strategy, you
> are also closed under reachability, right?  Is that the suggested
> transition plan for those that want to use this...first do a
> non-geometric repack, and then ensure that subsequent geometric
> repacks are done with this strategy?

Yeah, the last commit gets at this a bit. The property you have to
maintain is that the union of geometrically-repacked packs (which form
the MIDX) are and stay closed under reachability. I am pretty sure that
the way this is constructed, adding new geometrically-repacked packs to
the chain does not violate this property[^1].

But you can't guarantee it part of the way through a sequence of
geometric repacks, which is what midx_has_unknown_packs() is checking
for.

If you do an all-into-one cruft repack first, then there is no MIDX to
begin with, so there aren't any unknown packs to worry about (since
there are no packs in a MIDX to begin with). When that property is met,
then we can use the new behavior.

Thanks,
Taylor

[^1]: So long as you don't drop part of the geometric progression, e.g.,
      if you have some pack that was in the existing MIDX, but wasn't
      repacked or included in the new MIDX.
