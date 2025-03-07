Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECA1D9A66
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391222; cv=none; b=QrUJpSr/3NDbYR26j6/Z5r5Djzca00HVciLD6cve4e5shxe2DuWBAR+CY2757lVfLOhQhpTE1nYJ8ObumI9nnxribR909GBHtFd00cxjMupdIcfC5bcE8qH3Jp2wb8fMoDv24nNAZgd2zNr68KRJO+sLcJFQE13U1LKeKXrBzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391222; c=relaxed/simple;
	bh=riRPZE43xG/1h2JzaVfTA6+rSIMUKd7tdCQv182M/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz1CsN99ykd0/SPoAcud4yYrvGdL1xK9iDQUHH+x74VS/ThPb3+xQZcE/f1pt2euQg6vjNMwe3AAEAhdNgolJEMmRW+owu38Cj8/nIK84fCYWfmgSk1UhQ8XDonmtbzNmk7BZMqbQbkVjo5vqVH/EEjaTzP01aLtB23ibwO2cts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w6O6UPaL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w6O6UPaL"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so2100469276.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741391220; x=1741996020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9YHCtWv3FPmU7YgNpKlSgYkMknIPPp9gxWCBC8DvD4=;
        b=w6O6UPaLojBeeaLpU7tpSYAPXCNa3+ppU9tv7X3AfXbDkutsz/hUVWwaPeMxoNTOmE
         P6SN8Vg2B2yIR+8T0F1676M574JgnfxewqM3bTaZmMaDwxWCXKf/3o8P+Y1oYEmKhv/Z
         fD76X6hQkG6Z0OIBvAJR1qfM+UjKa4NR6HXNsuXznv67p/jIyWKqIuMnpS1ghvt6kOHU
         MIxY56gnV41h5Hw28WBEZdU+IFSHRkWWXwGovFmHUUIVARuFor1G72xWk/i1VZFuswgG
         D6Dj2HOGwpc+Z32qXSgt2HphyBwLV803XR0PEeCUvZEpbzfk9lhmxJCS/KS4gJqyZD4j
         nKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741391220; x=1741996020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9YHCtWv3FPmU7YgNpKlSgYkMknIPPp9gxWCBC8DvD4=;
        b=WXIp37cnfcd7EPSPmaH2K0foP7KCeoE7zILyz/6XXUQB+meycIu7qaDwppkzCzLenL
         q4M5Gsj6Pv7rYcBxBTab9kYB8fZnGiFZQePT8aYE/WoXu/yxWdz3PRzd3Xa7uoCRXGXU
         y+DAToonVuXjmKbErRI6ysmW0Bnt87Hd2JTOv6ecYz05fzutvVK1axpZIo2DTOQ8XVMR
         md7x8tGXg3pi1ASI83KkDMuk9LjUnc2giFH+jRPahiU5Qdj1gaRqvJxz4nIJkHu1BZex
         Xh71TigLaVLI8QmbZ4NpBiW/5DmVdjm5jFbC/AocC7zarOxsOPktpt5Gxvsxt4xX7vEa
         nNFA==
X-Gm-Message-State: AOJu0YxUYU9ZCsaIhwTAa8yyMY/la76ivjpmghfeK+YdyulHzLG+TMQ+
	40rv49JoVtXpowLLjf0oBsoObOM5K4AYRpdY3eIj/EiD+x9hZA2UHdlmJfqAy9A=
X-Gm-Gg: ASbGnctSqdj6v/Ycm9N0b1rU7s5PGNcG3aeWKi1E7dJ5qKpxkjh6tzv3TcP5W9kMapr
	V7vOwaXZnqT/JCrxfBvfOHWlVRScxztq/+B4F1SvhaHoMUGLXqNuQ4oklKnwnSXwxTdxJf2s7RE
	OwdNp5jQicwliqlrwUrDY+VkPj9crMAHhkGSwuxGYLEbhMC/d31QjShd7rs9B11KXJCAtRZs+sE
	wdCGIlzM1g1M34Ba7cfoybUnHkrZbrnWRO5fNwpVD2N4QT/FihWzxTZWprCtKpJIdZypwve87E9
	YBxUzTHU4aULsujmppDoNSK8Hzh9N97YpuSf9I5g9wI0p+4LIerpa9iQd+ZjvgoAyMQgHgNBPSV
	BriRP417he22yJ/U8
X-Google-Smtp-Source: AGHT+IFZEK17tP8aab2pFfdADlK96LUqAtW3wpdUs+JQhbo4K05xJoDFNtm4zBTNTIGXg4I01D+5nw==
X-Received: by 2002:a05:6902:330c:b0:e5b:1c0a:6cac with SMTP id 3f1490d57ef6-e635c1d81f6mr5940090276.38.1741391220350;
        Fri, 07 Mar 2025 15:47:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e6372629e58sm91560276.46.2025.03.07.15.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:47:00 -0800 (PST)
Date: Fri, 7 Mar 2025 18:46:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
Message-ID: <Z8uFcvHRcBExhjNS@nand.local>
References: <cover.1741223981.git.me@ttaylorr.com>
 <cover.1741275245.git.me@ttaylorr.com>
 <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
 <CABPp-BFn0wht71rM1bE1ABpa6Rn6QRrcVrbN0fhcwprbm+T39Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFn0wht71rM1bE1ABpa6Rn6QRrcVrbN0fhcwprbm+T39Q@mail.gmail.com>

On Fri, Mar 07, 2025 at 01:31:31PM -0800, Elijah Newren wrote:
> > diff --git a/refs.c b/refs.c
> > index 17d3840aff..2d9a1b51f4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1708,7 +1708,11 @@ struct ref_iterator *refs_ref_iterator_begin(
> >                         if (!len)
> >                                 continue;
> >
> > -                       strvec_push(&normalized_exclude_patterns, pattern);
> > +                       if (pattern[len - 1] == '/')
> > +                               strvec_push(&normalized_exclude_patterns, pattern);
> > +                       else
> > +                               strvec_pushf(&normalized_exclude_patterns, "%s/",
> > +                                            pattern);
>
> Doesn't this mean that if the user requested to exclude
> "refs/heads/bar" and "refs/heads/bar" exists, that we won't exclude it
> because it doesn't have a trailing slash?
>
> >From reading other comments in this thread, I guess that ends up being
> okay, because we only promise to filter out what we can cheaply
> filter, and we rely on our caller to double-check everything and do
> the real filtering.
>
> ...but it gives me some ugly dir.c vibes, reminding me of 95c11ecc73f2
> (Fix error-prone fill_directory() API; make it only return matches,
> 2020-04-01) and a slew of related bugs preceding it.  Granted, dir.c
> had this tri-state to deal with (tracked, untracked-but-ignored,
> untracked-and-not-ignored) and simplifying of whole directories, which
> don't apply here, so maybe the similarity of
> "fast-filtering-only-and-rely-on-caller" won't be a problem since the
> upper level filtering is so much more straightforward.
>
> Should this at least be called out in the commit message, though?

Yeah, I think that we don't have a tri-state here to deal with as was
the case in 95c11ecc732 makes this a little easier to reason about.

And you're right: if we have a pattern like "refs/heads/bar" and we see
a leaf in our reference hierarchy called "refs/heads/bar", the packed
backend will not exclude it.

This is OK because the exclude pattern stuff is all considered
"best-effort" and callers are expected to do their own filtering. Note
that the exclude patterns (at least in the packed backend) don't know
how to handle meta-characters (there's a big comment in
refs/packed-backend.c explaining why). So we can't guarantee the absence
of false positives without performing the same post-processing as the
caller would.

Even prior to this commit, a literal match in the excluded patterns
would result in a region whose start- and end-points are the same, and
we'd throw it out before it made its way into the jump list.

Thanks,
Taylor
