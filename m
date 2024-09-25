Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115FD520
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287569; cv=none; b=G5WfsS9r4ohNf+hcWRe/oSxSueoJ1bKfheQAilU55iDZSIY3bGJsD1mhciQMRHhciz5nV0CzAwzhV8Qeovxn4TH12QtmXMmxLymfXg0A8yyWNd6vmLdFV3rP4YXKHpyYbmnGKgdkBm04wiF0M0/Xn2phFihNSxiusq7fqt91piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287569; c=relaxed/simple;
	bh=QdKmrc5QatdWelI6+/JXyr9aUyutIyn5l/4zwtggUd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXZ7Ol1BQ9SpamnoiFOtY+ryINZ3a5GhWFz7wD7XD+ABxWNlaw5QcehCaSVVvpD+QvZNaEF/qRThvugZSAmAhdQbtusvtpUomf40EN5EYq0JTrG7ZtteDhpSavwyfpt9NqQ2zsnXZK39Y821Ow27DRS+Os1LE6wMdXVZMSvrqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v0pp8LWv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v0pp8LWv"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1d2cf4cbf1so135499276.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727287564; x=1727892364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtK9exLvRHVfnAA/TIJXxMBP818P4KWg6aWPIboxMSw=;
        b=v0pp8LWv6nTKEWOeXjWJm0BUgfLtFquzAZT92b7SmmwAn555hvMiuxgZHb6agtSKzu
         7MBiFhCsqbeSuFl7xCYUr2yo78kpsZTtkm26godkVCusFGFkyDZpNSU1axyHAJPMP9GW
         2Wl0qUYocOzvU2NiJ8C+tUUuKa65ECQzwNwBJytBJs7J7lOeWcLZyna5bPHkazWZYE6h
         fEUuS/QYmOw15w5ziTi9Hti/rWpfN8eSq1X/neNOFGT8/PF6qsVhuE4amerhMtOlLkTg
         8h11gIlLfxcpia0wOucpTycC3mUj6UB6QFVlTdVpjBkZBoV/W6UH08hfU7mkQPYlgEVx
         sEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287564; x=1727892364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtK9exLvRHVfnAA/TIJXxMBP818P4KWg6aWPIboxMSw=;
        b=aID1Rjbzaf3RKWxQdt9mJuSlZgfbCHBmi3PrALXVJbWdlIz2XfNGGbgOgJ0astIxEe
         9F5q93Nhpm/yFJkaiNOVK2oyyadmU53dJXxd2gkeB2aVQBu2EtDp26yIz707WiCMyRMu
         JCowEPQ2S9qQUttorA4DpjsyJi0ADNZ4dEJzPSdbeJcKfgCg653m/mUeC+vJWKiC59uX
         SofDJto6vdsg3jcrvmJ5tcVjfXhsT2fEMbHmLzQwzangYbXsnh+GYKg8Spu0IcpLNtDF
         72J0G9QIn2ZjEk280WmLUhEAnrdsU5EaoOybhYAdxqv35VVscHGlEeHnZCm+Yp4Soe5s
         irfw==
X-Gm-Message-State: AOJu0Yx7n+cnRbWRajcru6A1t/Tza+n7/rFTtv38WdHYBHLrYMfRjuXB
	o4Ja1o6mp40ME1J/HNYbETzdvQheg3Aq4azfVV/IgSH8cHcLDO0k+Cc6O9g+aep9SfBIb/dSMqw
	31y0=
X-Google-Smtp-Source: AGHT+IEKRrQO398pm3LXB7ejYegayy9UNYmLFhbG9Fn4OXgU1vmC7zB1i3S0HdiTHAYoeAL28mttZg==
X-Received: by 2002:a05:6902:2b85:b0:e1d:c07b:a680 with SMTP id 3f1490d57ef6-e24d7fdf576mr2759379276.22.1727287563988;
        Wed, 25 Sep 2024 11:06:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499ae6812sm656193276.2.2024.09.25.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:06:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 14:06:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <ZvRRCb0+82p/IeI3@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
 <20240924203718.GA586150@coredump.intra.peff.net>
 <ZvM2Lkb0/LPrqizO@nand.local>
 <20240924222039.GB1148242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924222039.GB1148242@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 06:20:39PM -0400, Jeff King wrote:
> On Tue, Sep 24, 2024 at 05:59:10PM -0400, Taylor Blau wrote:
>
> > > So the argument I'd make here is more like: this is the wrong place to
> > > do it.
> >
> > I think that is reasonable, and I agree with your reasoning here. I'm
> > happy to reword the commit message if you think doing so would be
> > useful, or drop the paragraph entirely if you think it's just confusing.
> >
> > Let me know what you think, I'm happy to do whatever here, reroll or not
> > :-).
>
> I'm content to let this live in the list archive, but it sounds like
> Junio had the same reaction, so it may be worth trying to rework the
> commit message a bit.

Here's the relevant portion of my range-diff that has the new wording
(which is more or less equivalent to your "this isn't the right place to
do it, and we're not fundamentally changing anything from a security
perspective here" argument). Let me know what you think:

--- 8< ---
3:  ed9eeef851 ! 3:  41d38352a4 finalize_object_file(): implement collision check
    @@ Commit message
             object name, so checking for collisions at the content level doesn't
             add anything.

    -        This is why we do not bother to check the inflated object contents
    -        for collisions either, since either (a) the object contents have the
    -        fingerprint of a SHA-1 collision, in which case the collision
    -        detecting SHA-1 implementation used to hash the contents to give us
    -        a path would have already rejected it, or (b) the contents are part
    -        of a colliding pair which does not bear the same fingerprints of
    -        known collision attacks, in which case we would not have caught it
    -        anyway.
    +        Adding a content-level collision check would have to happen at a
    +        higher level than in finalize_object_file(), since (avoiding race
    +        conditions) writing an object loose which already exists in the
    +        repository will prevent us from even reaching finalize_object_file()
    +        via the object freshening code.
    +
    +        There is a collision check in index-pack via its `check_collision()`
    +        function, but there isn't an analogous function in unpack-objects,
    +        which just feeds the result to write_object_file().

             So skipping the collision check here does not change for better or
             worse the hardness of loose object writes.
    @@ Commit message

         Co-authored-by: Jeff King <peff@peff.net>
         Signed-off-by: Jeff King <peff@peff.net>
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## object-file.c ##
--- >8 ---

Thanks,
Taylor
