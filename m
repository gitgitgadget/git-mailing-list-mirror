Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66A346E78
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371180; cv=none; b=B5siY/rRMzlpMdAxEA3YX2yjpt3pGS3OC5h5d4SxMVVys6gXFeq9aHemL1PjPWriyE/GcUDeov23m+wzcr+OMWmaY1SfQGYZ2ijU483UIS2KmArIpf1QCDNdBfe9/AZFbnjC7Z1bVe7sfjO8EH4yvakgwXyltxZvU2N84qw5DTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371180; c=relaxed/simple;
	bh=LRpGX7UbqycBF+b42Rgw/tcoqNlD4vET4TJFlD30I/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz9DxtqtWSG07bC1wywR+DEfO0CHisxxkvVomRjzL+WLint9AJ8mcJzy+1MaEiYvM6gicoMzkoNPDXu7mH3phi4qCfSi8oD2Af5A3K6TngmcvPmpVpG3wHvOBwoGQvgh5PnNr6lpF0govQ5jF4lceaCfdKwEKxvffX6bRqCCP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=XU+CknhN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="XU+CknhN"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ee5037d44so207517b3.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776371178; x=1776975978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STYWHmLl/A9psAXNcAOqkpkXpx7h8xuFkNnYnSyaZ8k=;
        b=XU+CknhNhLSjp0NEhbVhEII2n7lpepvjSXri9N6D7oiQAOxC+/FGLyV8/ayGTQcaCQ
         PqeScgc/GonxfLQWoQNlB+PYeg6VowIxvocGew2TVKXcYuHPIoQxqZpX+hJlKYMeO0zy
         lbrT/QWOi7LqY520R6fqPd9ODbU9P7S4mZswCHLBqJZqnFym8QEOERFpS7G0D12o5nie
         SUeJFCNcYhyFaQ1h3gj6pbNhMctBUARwS0NdeNlklAEcKhfwBMw+FObIv9ouct2t4Wu8
         APKlH8goEBH3aVquocJZHVJ/SchiwzBtzAJFHPI/HIvAv6XEYMVKtnYVbnxFShQidx+4
         cDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371178; x=1776975978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STYWHmLl/A9psAXNcAOqkpkXpx7h8xuFkNnYnSyaZ8k=;
        b=r1lxYP4wO8xYAq+EA+sud7zKt0KKAOAGkRP7CgUpFu6kOYm0EPmWcBUC4Rr7dTs3G4
         mdh7rp2YViSzZKF/3dGDxD/9Hdk9BoIbAkp3AypOuLt7bghA9SrauxhvahAhJXSW3Mn4
         0MqfzQE2UHCEua+K4/9fljPe+V+I82XsAIo8XeW16U1tjtrE5lYo8kR2SM3Dj+4DsyCI
         JUUC+n9j7a7wBcTR6sRZNpnfK1ygQlTsnPVt41RdalJfoqD1BbAZB16GRFtmo+oKMXRt
         iPKzWgyTiecGGIEltMaJ7W9u2hvAC8VBApq+FuSaVxLsx/XHdLy1EO9SXpFEraKuAE4o
         iG2w==
X-Forwarded-Encrypted: i=1; AFNElJ/9fOpvQI/W+GhAD6fi+fbWAwFDxxkH6bMNDw7LaD9C5uPam5Ar5aisoYkiVzHsJ15qaoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwALSFnDF9X2im0u37KYzMWbY7NZvQl6ptFwKVOqbARJ3WX2DL3
	gXJVI5ZslHUNzdM5jApzctsyK8K/UjA4Oo56MjpUNF+W/whTH3Tl4jXsbw6qXDJn9E4=
X-Gm-Gg: AeBDieulfdm1ale7gPJm7c52j81HD7bsfcxiJVZhYtY5GDkP8f2vQ1ixzfbELwEb4FX
	YBHVLYmBVpvBGAEVx/a1nBwX7xR2FiCtAEIdOCTUX5aAzt2F3dfarWap/sEAJ9eJsNgJb24pnwP
	tYbLpfr5poJU5VJrbDBHsUZziSYOtB4/9u4oftOvQDr3F7RJlxubVpHygz4atVxwpz1WRnqTDn4
	UBzHZJ7SDdcHktZrZcfirNPg83aCRXrL4vSGcCCmfYqh4/omjNpmnqmEnhjx4Wha2S7HiEdVCl7
	ZwBo6IMDeQKhrD4F52QMm5z+lHyK88KBmzssamjBAeOwdPzuHQGYQNpoKzPHq4MEmJ+pvO/cVdj
	Sl7zvBSSz30Jjw92WvX2mJLkQYRhAthmyEZURfnUSkOg27QEcYsMcqDPiyC+WudTQkZbh0m3dS9
	eDOF4F61uQ+COdohEhIMyBqWacN+LqwqOIAFHnsq5k6pJDUbGbjWjksjvuGqtmcSaxCP3pb4M7p
	RtM7VOTgaNC/N7IOwEGJMkSAE2ejJ4CB7ez7PwP8jQICFpYb+Js0Ttnoe/y422OOm0qY1GXLXN+
	NAMl3+PGJrUbqDlzhWzYp5ueQbw=
X-Received: by 2002:a05:690c:67c8:b0:79a:b8d6:110a with SMTP id 00721157ae682-7b9d6081692mr8170717b3.5.1776371178455;
        Thu, 16 Apr 2026 13:26:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b7636be8f5sm27904427b3.0.2026.04.16.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:26:17 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:26:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <aeFF5s5m76Yz7F/Q@nand.local>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>

On Thu, Apr 16, 2026 at 09:24:31AM -0400, Derrick Stolee wrote:
> On 4/16/2026 1:34 AM, Jeff King wrote:
> > On Thu, Apr 16, 2026 at 01:17:33AM -0400, Jeff King wrote:
> >
> >> I think removing the .midx file (and optionally regenerating with the
> >> old version) would be the appropriate workaround, but I wonder how hard
> >> it would be to go back to generating v1 midx files by default. I know v2
> >> is a building block for more advanced features, but for those who are
> >> not using those features yet it is a strict regression.
> >
> > I think doing so is just this one-liner:
> ...
> > and then here we need to use v2 for the new compaction feature:
> ...
> > So that would make things work as usual for anybody mixing and matching
> > multiple versions of Git, but does make life slightly worse for anybody
> > who wants to use the new feature (they have to set the config). We might
> > need a doc update, or possibly even to automatically default to v2 when
> > using the compact command. But that could come post-2.54.
> >
> > At this point I'll stop poking and speculating and see what direction
> > Taylor suggests. ;)
>
> I think this is a good change to make. This fits with the standard
> approach of not making breaking file changes by default, but letting
> users opt-in to new versions (at least for a few major releases).

Yeah, I agree, and sorry for the trouble here. A few thoughts:

 - In the immediate term, we should downgrade the default format to
   write V1 MIDXs for the compatibility issues pointed out by this
   thread. That would seem to be the minimal thing to do to make sure
   that the 2.54 release is as smooth as possible.

 - In the medium term (i.e., on the other side of 2.54) we should
   implement the changes that Peff sketched earlier in the thread to
   make loading the MIDX robust towards unrecognized versions.

   Of course, that doesn't fix any old clients who don't upgrade and at
   some point want to fetch from or otherwise interact with a repository
   that has a V2 MIDX. But it does improve things for, say, users that
   are on an eventual 2.55 if we make the V1->V2 by default change in
   2.56.

 - In the long term (i.e., in 2.56 or otherwise in a release after the
   above change is implemented) we should make V2 the default format for
   MIDXs.

Thanks,
Taylor
