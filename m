Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F81DE3D6
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128877; cv=none; b=YJjlPZaHpldlxe3n+9kE0LBwJjeYZfxKSLvmlkfOK04AkJRKgjMya0/5xF46fIL0AeECrRxFF7AEuSh2fPM8ijv/aacjTlILwH1RmOUCWgXsdJwxA2z+BmDVXR4qa38b8JO043f3Uy5m7Jb9PmNI3oc7P5ErKKhWGj6dgjRP5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128877; c=relaxed/simple;
	bh=XIxlo032AhCZBMmqg7Fh63D5kmtvO5XXAdOSuUKqWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7l67Cv1BEuaNIkPYyICCEvQvRhOs5Ze68fmuOBPpRUTZ/DwbFSvd4/C/zV0Z5kZYPxnfcntRcNTU62KEKnJGn7tgOXNXQXq28PV+PrsnYVfupCan0GbxMbMatXqgK2J1maMaIknXeE7Hrq/5TLBLPI4Rb7QvRWSvO7IhvNUVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tXXxokvf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tXXxokvf"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3cdbc25a0so47965187b3.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730128873; x=1730733673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIxlo032AhCZBMmqg7Fh63D5kmtvO5XXAdOSuUKqWF8=;
        b=tXXxokvf6XVSwuxA8Q0HKOl7YPJayaz758fsMMe5RmaoTJ/MLZeusG4kT9ExeGHCkT
         2PVzb1md41KR9uNRLjRJgH1eM6iLib3ZPV55V3M52Ydp4N5sDM8b6roXZwRt8hl7UV/p
         jHtxL9Kn/XLXTf5+dGRhcSbx87Lz7xefCXTULRrMsT8l8doP+oqqdD8fv6xj5MU9lNVD
         F3cWD3Y5cbJD9CjOAPGXItaU1fAxJgWTvBiAsEssUSwknob876aetGBD0S06sWfpFdJo
         QRhLE/Agf168fR22U5uh6ZZH8RqzCOlI/NnI62a0SBa3yEbj7gSGtcvjVc54t95f1dVS
         AMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128873; x=1730733673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIxlo032AhCZBMmqg7Fh63D5kmtvO5XXAdOSuUKqWF8=;
        b=lGN/s7BQaV1iJDgQpRy9EV6rglUAkUXR6rrjS12oiaAaEKqCjbh6U5EhRi+O7ysWcu
         RKLFFFdvfTvcH8ewXvHBUERSei3EqhFaYB1RSv3GRxbtdsKhI0KnK49/tS7GZ6N+Pqh7
         lzHC3IKvvDeSUw5r6Kr4jTM0PiIVxj+r/fczBMivxD29u2I7R8aMAlte/ileDzoooU3u
         4rNBny7hamm5Uz9ggcjnTK6FOb5ibPlHFGps+G6MeUdmiIUjYK/+yZ98+S0eIp9wIsQH
         BICTAnVDi+q/JcYw4HZy3xkQULdu2rQI2WcmdeYt9wTflc1z/fwdWUHvo/zIxgkYPH1U
         v8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUzu36D+AdIY/Y30/+yBQOUFuBHaP1BOEwNURv5w9jm63t52nVEOgKY/Eoh+i28o3Ff/jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9+SwXnjmTM9NKTSRNbCfe4eJxvgU0bJ/G0/QPllMjhAX5JVw
	oLJEc0J/phkL7avYKSBPpf1ehUMea36JP22mUhD3zv/sQ1ydWJdExfN01o0xgsc=
X-Google-Smtp-Source: AGHT+IELB8z0HORlJ0dnZPdkEZMO4drrB2LPxyxw6NkZG9SNlG6b1VlrRGvxjeivd6zxEK8jW2PNig==
X-Received: by 2002:a05:690c:386:b0:6e3:3019:6aad with SMTP id 00721157ae682-6e9d89793c0mr71502207b3.20.1730128873399;
        Mon, 28 Oct 2024 08:21:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6baffccsm14797407b3.3.2024.10.28.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:21:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:21:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <Zx+r5gG8Kj1F0PHU@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <ZxbBuyhfq1sFKBIU@nand.local>
 <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>
 <20241028053140.GA2827326@coredump.intra.peff.net>
 <CAOLa=ZRzM8tka_VLc7gmcukCMchKDQu0htF3LT9yiYWW7iXEow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRzM8tka_VLc7gmcukCMchKDQu0htF3LT9yiYWW7iXEow@mail.gmail.com>

On Mon, Oct 28, 2024 at 08:36:50AM -0500, karthik nayak wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Sun, Oct 27, 2024 at 05:23:24PM -0400, karthik nayak wrote:
> >
> >> While thinking about this over the last few days and also getting some
> >> advice from Patrick, I realized that we don't need to be this disruptive
> >> by simply adding the 'repository' variable to the already existing
> >> 'packed_git' struct. This allows us to leverage this information more
> >> easily, since most of the functions already have access to the
> >> 'packed_git' struct.
> >>
> >> This, plus the series by Jeff 'jk/dumb-http-finalize' which also removes
> >> some existing functions. We reduce the impact to only 3 functions being
> >> modified.
> >
> > Yeah, I noticed while working on that topic that we were dropping some
> > uses of the_repository. And FWIW I had the same notion, that packed_git
> > should perhaps refer to the repository struct in which it resides.
> >
> > As Taylor noted this is a tiny bit weird with respect to alternates,
> > which could exist in another repository (but don't have to! It could be
> > a bare objects/ directory). But I think from the perspective of a
> > particular process, we only have one repository struct that covers all
> > of its alternates for the duration of this process. So it would be OK in
> > practice. You might be able to get away with just storing a hash_algo
> > pointer in packed_git, which would be less weird (and is enough for the
> > bits I looked at, but perhaps not in the more general case).
>
> This was my thought as well regarding alternates. Also it should be
> noted that currently we're using the_repository anyways, so we will be
> in the same state as before.

Makes sense. Thanks, both, for thinking through it together.

> In a general case it seems more necessary to add the repo and not just
> the hash_algo. Mostly because there are parts which require access to
> the repository and also because some of my patches add config changes
> which also require access to the repository.

I could believe that ;-). I see that you posted some patches lower down
in the thread, which I figure probably uncover some cases where we need
more than just a pointer to the_hash_algo.

But let's read on and see exactly what shakes out.

> > Looking at odb_pack_name(), it will still need to take a repository
> > struct, since we sometimes form it before having a packed_git. But for
> > most calls, I suspect you could have an alternate function that takes a
> > packed_git and uses both its "hash" member and the algorithm.
>
> I have four functions which would still need to take in a repository:
> 1. for_each_packed_object
> 2. has_object_pack
> 3. has_object_kept_pack
> 4. obd_pack_name

That matches my own thinking, but perhaps there are others that neither
of us are coming up with off the tops of our heads. I think that as long
as for_each_packed_object() continues to call prepare_packed_git (which
sets up all of our alternates) and we continue to consult the
packed_git_mru cache, we should be OK.

> > Anyway, just my two cents having worked in the area recently.
> >
> > -Peff
>
> Thanks for your input!

Indeed. Thanks, both.

Thanks,
Taylor
