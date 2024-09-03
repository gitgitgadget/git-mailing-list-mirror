Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3951DC72B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393061; cv=none; b=GFTqldjEhELUwAIp6rPmorQtnKtXJKoCshx3WdeUaagNiE4KmPvY/lTX4dEdjfm5vcM7dAhchyD3ArA9/Un0vaHgbR4w39bSKHGseh1qcM3DEaoQFyi2AoiKOCiHq0iP8tAS1068qe2dxluRSVKDQH3/8wCI2nAsLK0skwji4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393061; c=relaxed/simple;
	bh=epDHs752GA4zNGrsnQderR/H0dnfbM52dIKbi4xwpJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1NEIjNj+s8R0hr4aDdP7GQ3LU3ZukL839t6d++uKFtbCNfJOeH43Q/WDOOzB/0sPmxy3xDV8I/JvU545ucC2D3YDMYxTMOq1qxWrF3H62rfFHQwDCGCASlKgTPkdq8ZtwnSCF1wezEVKFwpLNcRi4HTMWUPTTzjwd7O7VlhUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZlIcE1bG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZlIcE1bG"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d47d860fc4so32533437b3.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725393058; x=1725997858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t14xa2Dg1XQ1zPR0+G9If4oYdN5QlZ9ZZpb8gcXe5Yg=;
        b=ZlIcE1bGDJ2PkPgw5uZfpDMk6gLXtLp3NQ3PVN09z52m/3eUUfUviBngyWGJFGBKZ5
         EgUbmjw17AgdDqEG6vDmkA5qOhkaz6Cop3KjxZcCI/nr4fJW5QH54lYCbVyZttzg77Pa
         OO8yshxUjYF3LQ4j8B786zujhNucQhna7yv/EOFdYqrjIek2yibSqFigPMe8FDAdot7J
         GzdDs45tBgiRwMWBXRDJ7AXjfmngs6WsH41k75S7yWo5fUa51B7sqRWxZqZGmbVZyx8B
         zDKhXisxSRyslOJjf5dqcKZoYAGO0HSncKG93ZJAAMUzNdh/GCtTTGjja5dXJa3bjE3u
         Ip1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725393058; x=1725997858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t14xa2Dg1XQ1zPR0+G9If4oYdN5QlZ9ZZpb8gcXe5Yg=;
        b=AAw54l6MFaBX4e3WXWioN/tUFkFiHG4zuLIVYdh0HMX/EyykxQWsEayGcBX4mdhKEf
         3lgbcPGf3HDBua6WsrcqR5IJLHOYOHR73iz8Na7NdyHsILtFRdMxzu4CBbvVomEDVwJh
         vuoc1Mq827Mw75Jg6apA2VxUWI0c8h5kn4WwCgKG19yNpHmKu1hPK0zwY9upX9D6e8uh
         Sltsanhp3Dbz/hAgfDOSFiePGpL8nPj8cTy/hIMfQazBRrV1mPFbBLv785MrRLQU2JFv
         Cxm+4wnk7Dqa4SdxgpUBywbTvNg4I0/G9YA/Crd1hY3bXadtcjoDibXGqmywYz+JXWF1
         Hwvg==
X-Gm-Message-State: AOJu0YzPYnO2qRFVkuguZXie/XocqtJ73TvsUdCfGs2IfDDp85zL6vgN
	kBd5eUfv1hORnUG4JiaL0tVeryivHUP2IGIU4yoh82aEuVcY6hQYxBq7/WgtwJrwzQuXpQMnQic
	5V80=
X-Google-Smtp-Source: AGHT+IGwd7ID8+Z42J1SO9Zy1uL4i+Lxtbuf4UdEXck4TUUegxCWRLGW2ZAgXkd3v0b7kH0QBxEC+g==
X-Received: by 2002:a05:690c:fd0:b0:65f:aa06:13ab with SMTP id 00721157ae682-6d40d987cccmr161260677b3.1.1725393058446;
        Tue, 03 Sep 2024 12:50:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d5db0f32sm21104097b3.125.2024.09.03.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:50:57 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:50:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] csum-file.c: use fast SHA-1 implementation when
 available
Message-ID: <ZtdooJo0XFaBBoU0@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <e8f5cbd280cc07f68014bd4024d55a740374b349.1725206584.git.me@ttaylorr.com>
 <ZtXAi9KYOKejJmOS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXAi9KYOKejJmOS@tanuki>

On Mon, Sep 02, 2024 at 03:41:31PM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 01, 2024 at 12:03:32PM -0400, Taylor Blau wrote:
> > Update hashwrite() and friends to use the fast_-variants of hashing
> > functions, calling for e.g., "the_hash_algo->fast_update_fn()" instead
> > of "the_hash_algo->update_fn()".
> >
> > These callers only use the_hash_algo to produce a checksum, which we
> > depend on for data integrity, but not for cryptographic purposes, so
> > these callers are safe to use the fast (and potentially non-collision
> > detecting) SHA-1 implementation.
> >
> > To time this, I took a freshly packed copy of linux.git, and ran the
> > following with and without the OPENSSL_SHA1_FAST=1 build-knob. Both
> > versions were compiled with -O3:
> >
> >     $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
> >     $ valgrind --tool=callgrind ~/src/git/git-pack-objects \
> >         --revs --stdout --all-progress --use-bitmap-index <in >/dev/null
> >
> > Without OPENSSL_SHA1_FAST=1 (that is, using the collision-detecting
> > SHA-1 implementation for both cryptographic and non-cryptographic
> > purposes), we spend a significant amount of our instruction count in
> > hashwrite():
> >
> >     $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
> >     159,998,868,413 (79.42%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
> >
> > , and the resulting "clone" takes 19.219 seconds of wall clock time,
> > 18.94 seconds of user time and 0.28 seconds of system time.
> >
> > Compiling with OPENSSL_SHA1_FAST=1, we spend ~60% fewer instructions in
> > hashwrite():
> >
> >     $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
> >      59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
> >
> > , and generate the resulting "clone" much faster, in only 11.597 seconds
> > of wall time, 11.37 seconds of user time, and 0.23 seconds of system
> > time, for a ~40% speed-up.
>
> Neat. I knew that SHA1DC was slower, but I certainly didn't expect it to
> make such a huge difference.

Yeah, I was similarly surprised as you are.

> One thing I'm missing is an analysis of users of "csum-file.c" so that
> we can assess whether it is safe to switch over this subsystem to use
> the fast variant. As far as I can see it's used for packfiles, commit
> graphs, the index, packfile reverse indices, MIDXs. None of them strike
> me as particularly critical, also because almost all of them would be
> created locally by the user anyway.

Right, the only case I believe we care about hash collisions is writing
loose objects, and hashing packed objects from within a packfile. The
loose object write path does not use hashfile(), so it is immune from
these changes.

The path where we read the objects packed in a packfile to determine
their OID is also safe, because that happens in index-pack and does not
use the _fast variants of these functions.

> The only exception are of course packfiles, which get generated by the
> remote. Is it possible to generate packfiles with colliding trailer
> hashes? And if so, how would the client behave if it was served a
> packfile with such a collision?

I think the answer to this is "no", but let's consolidate this
discussion into the sub-thread where brian and I are already chatting
about this to avoid having the discussion in two places.

Thanks,
Taylor
