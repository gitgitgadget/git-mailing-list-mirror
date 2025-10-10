Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7972797B2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136750; cv=none; b=HfkbnRM6c+W82WYVdyS9HP/KDSMQT0tzdWp6wo00P8+DA5q5n9Hnw+4OIpFsSY564OBeW/AeXgF+1kQJx8dFjq+1QxPUnoVAVYTb8T2mfG4qYxzfYEjqQzuQ91QF0ZK2onbcVAnaMHSW1OoFUQQO+i+ugB2hFWHoQgGSGDfwEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136750; c=relaxed/simple;
	bh=nwLn9sOnj6/6qagz107mi8y0Y5/bqVoNyyCzk0aPOr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU35QFyU55g897/FLuP7QxZTMPGJ5CHWTpto8qqayaqtc+IrFn4Oz45jwq+vQE3dsNmeEFap+ezEBsIT7jhvHSN/c0mYovr+0sXOMXsFj6Ynz4dJ10nNcH/q0iD9mBTIqsL9GcjSxG92KhmKFe1gF+IwFGIFVFB8nzFwcKxwY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=a9nhG7Rz; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="a9nhG7Rz"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-635380a4a67so3231722d50.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136748; x=1760741548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwLn9sOnj6/6qagz107mi8y0Y5/bqVoNyyCzk0aPOr0=;
        b=a9nhG7Rz6EYg+MuJ9cvlVDUjuB175NHZJJYKNnQSN2pAB6ruRxcv/fDn5ylsYRdbkX
         riFMOj6UlbnRCGuCUSORhXl4Ss9TfThg3eHagWqiZS8P+wa63N4pWUXrcv7ae1C4Y4+E
         579SO15+S+zaun3JcLqjy/X/halUcVjjW+HhaandHi9BKKmdpm2RjGklDTurv0bfl98h
         bgzrykgiOArVt5SoiAkpA0qOGxiTtyaGjKVasNiZPrm+o3jYYx3QpQcaLtP1zrMvrlP0
         ikY/5lbU/DFD9qvy4+0uZlpQ/ZwTmlz4SJ0Hmi/bUHmeHa4jFvAmv5HZote0LUQDyYXn
         JpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136748; x=1760741548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLn9sOnj6/6qagz107mi8y0Y5/bqVoNyyCzk0aPOr0=;
        b=t/iNNNpgil9ODk1LR2Ij9b73Gs5CHdalYYwVc2fx3QEenTvVKkgjgPM69Dqlo79u78
         gurOZTq8krolZ8enEVPuxFnH3fLbIvW10mjWuTmJQ9bQZrcq8pq6X8Rw/IYDwcaTE2ww
         4E2S3nyTweaOLf5D/mJeAEyFZ1MzIpmb27LGbru5hVx4NIlbDgoCMdwYJ5LAsY+CuyHr
         hvX1xRglNXLJKr+Dj/syQ+4gw/GYV6ae2ysefmltIRw3FTwkW5Zs5nCWmvCEcO57CGnz
         YtHlrrgA65BR1JcEJ/l834jMpV2cvWdnn5qWRb6B1uDYcG14C86LBLxKT1QDvhcKGSEl
         R2bQ==
X-Gm-Message-State: AOJu0Yy5gpQz7gXj1EyV7cEF46J24ZZtqrBenT3jXuBoAJUK7ty+T9iA
	jD7M3TYi030MZ+FCOpGdnAZ8RYiBiqPz4ThB63U9qu5/gBOFQihvggX4ZRr50A44Lww=
X-Gm-Gg: ASbGncsfphZbHov530TwZnPdn8A6GTfrxVismyom3c4OuS+tsVwsioPo6QgNk4SBmkX
	Vn+oETLOK5OyeRtb09GZB1ZhiE0a/Bveu8wdVBIOWmFu0NSw2XYNw6pQgRa3itL7S0s+GjIDX0O
	wtyhZ9BUr6yKKlIA7jr8+zYE7gNQxaCXWFVYAhvVpIZ5509YSguaEp9pIsP4FJ6q/IsuYWQnvwc
	GqHC2LSG6e8gGRyeINCn6RVgZaVYttC1Ah493DyRelkdT26Mko6mKDToVNi9jJTaIB8fRJ/b+HL
	mEW451Dd6cves7gqAK/ZJ9BDNrloNwy59YcfsvWUUbGnEc2bq45XQIPm2LkvN3WpXvBuThWSy/Q
	KI7UIwYqMNnUfqXYQ9jYT2NBowQT/jbC/kYYEDKppBgTlrCh4hjhUtobQekaSbDnqIEt56aNn+h
	AFP6zQZfO3BWN/9JB4wHW7//etw8KEAEiV0NWLCCGxusF/ECGhbkBvYFA=
X-Google-Smtp-Source: AGHT+IFe0vj0t4a4khMNlDJLTVQ0WgaEShoBgjRPn5tW6Hu0+/OEyQ+cvAVzstcxqaTGxHfC9a0xHw==
X-Received: by 2002:a05:690e:245a:b0:63c:df06:47a0 with SMTP id 956f58d0204a3-63cdf064b8bmr6165857d50.0.1760136747799;
        Fri, 10 Oct 2025 15:52:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd9524284sm2024585d50.10.2025.10.10.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:52:27 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:52:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 11/49] repack: introduce new compilation unit
Message-ID: <aOmOKso3os5fP6cf@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <fe3328eb3d8202f8fa8cbef11cca215ace8b2285.1759097191.git.me@ttaylorr.com>
 <20251010054804.GD1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010054804.GD1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:48:04AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:07:53PM -0400, Taylor Blau wrote:
>
> > Let's start by migrating 'struct pack_objects_args' (and the related
> > corresponding pack_objects_args_release() function) into repack.h, and
> > teach both the Makefile and Meson how to build the new compilation unit.
>
> This name is a little generic for something that now has external scope,
> since it is specific to repack's view of what it might want to pass to
> pack_objects (and not something that builtin/pack-objects.c cares about
> itself).
>
> I don't have a great alternative name, though. I guess it could be
> repack_pack_objects_args or something, though that is getting to be a
> mouthful.

Yeah, I had considered `repack_pack_objects_args` initially for exactly
that reason, but discarded it because I thought it was too wordy.

> I dunno. Maybe it is OK as-is. If I stretch I can imagine a world where
> pack_objects_args is for the lib-ified version of cmd_pack_objects() to
> use (like we have send_pack_args, etc). But TBH I find it unlikely that
> we'd go that way anytime soon (and if we did, we'd maybe even be able to
> refactor repack to more directly use the struct offered by
> pack-objects).

I had a similar concern when writing this patch. I think that that world
is far enough away that I am comfortable crossing that bridge if/when we
get there ;-).

Thanks,
Taylor
