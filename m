Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491091FCC52
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539705; cv=none; b=oaTueCenXeOwtKwO/Cuy/eL1kcdZxQPHXhyWp4HRaSLAM3yxIYpyQoGofEoV7cejU8HjihpKIuZEg7JB3lWmrms/bqhEuntPrEO/YvOE4AResrmTgYNV8OTLWhx9lDUvGv84FtHKKcY948IcdQf5fNJ35xIlN6HWX+YH2+j0CmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539705; c=relaxed/simple;
	bh=v5/kc6sDC0gQDRL03cVHSyzUYdPTFwHUDoKnPYzyoWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMNnaV72bo9dvGmR4k4DjA1Nt5ue7TR9vpblYFE3SPSnwizrXbKcBHGI93zHpkb42myKKR60/C5aPnsO+CfieecfucOuOqDJZZgttRJ4yC/GnkxN0URDo8+17KqA2mXsujQ/2BCJiLKHfQiavXzswtr3DvU6b7d/wCSUVp5lq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0RMdvQI9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0RMdvQI9"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3a97a6010so55615227b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729539702; x=1730144502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5/kc6sDC0gQDRL03cVHSyzUYdPTFwHUDoKnPYzyoWw=;
        b=0RMdvQI9SCBxapRS21P88BmZxKKlYHKjpfBHKPBx0tCwaBxzIvZWL84m8DLNYjK1OD
         3e1RgONoV3xCmoDW4QQbZ0ee78x5LtioWnYNbSERv1vb2lQgB6MiV15BKZoU7MxC48S2
         IOKj6zyouQG91q3OqulRzwiv9gljwuPdCVaOry11xFHsTwyNHxkjrJzFRllB6O3VDnak
         8Yr7My3YxSV/KsE47J/2ZvvbSd044SUhuV9WI+OBmu0QtiFMcJ09P250rxu/l7gMiDnY
         vNuuKXVA5QgjOGfkNmDeihiWYup7IgS/k6SaTqEgJU5JWrQ6yF7uyRuFzrucAR2haFwN
         ahsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539702; x=1730144502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5/kc6sDC0gQDRL03cVHSyzUYdPTFwHUDoKnPYzyoWw=;
        b=NB6PTuoZTHdVTtTmG3ej5Tu+1osqt/lUgFH1cYMJm8ZE3Whh1J/xtAG74u7ZzfHcuq
         ICVPpfufmVW7/QiNkk/gpL7wQD1smU3ZDL1ssZeACxS58/y/GgXZ6EEpH09ceWDQbfZG
         hfdC1sG80kktNKfAcnRGVL1WCMg/hjQoYBdQ97hwU+9Kxvp5kUDJ84rehZ79gUZvjAer
         4TO1xfcph5Gu5is8VB5fiplhQMv4vL+xT9lQ6ec7lFlCk2MGNukTfEPcY2vcLwdJwuKH
         gasw+/V4hUu6qIwYdYlo1PKNpGv9ulwtc8sCc5TQr+fOQBCxd1SCRN4kJVeDDNW6oSvU
         OTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6PwalTCtIlyd5+J44M4EP57svX1RtwJecZLNuvIAx1kUwGPVGYW7dT7QQwEFk3+CvaVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWbvKhGUFNKdtvZGS81wuwtijPKohpo6TDU14v8vMCUorfkx/
	nLeSAGrL/KlQaZB3Fa4u0yWfnkGv8bQsRJPuzevc3n4lHgPYwHM8pCdBvCr2VrE=
X-Google-Smtp-Source: AGHT+IHeTKjUQPB5W5+cRc7dirUO+NFbaDSvMMi+2ZYlDuPN+r3ORjx+ckVqoTXmiHWCZm5xVqHUbw==
X-Received: by 2002:a05:690c:d8a:b0:6e2:ef1:2558 with SMTP id 00721157ae682-6e5bfbdb7a2mr110501947b3.8.1729539702176;
        Mon, 21 Oct 2024 12:41:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cee7f6sm7797397b3.105.2024.10.21.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:41:41 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:41:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxaudJWlJbEJ3LeO@nand.local>
References: <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
 <20241018052448.GD2408674@coredump.intra.peff.net>
 <ZxHylOLHaxP8crom@pks.im>
 <ZxLKLJCgiA3oY4Nr@nand.local>
 <ZxX4AsMRoC0Botcj@pks.im>
 <20241021193024.GF1219228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021193024.GF1219228@coredump.intra.peff.net>

On Mon, Oct 21, 2024 at 03:30:24PM -0400, Jeff King wrote:
> On Mon, Oct 21, 2024 at 08:44:01AM +0200, Patrick Steinhardt wrote:
>
> > > Will it take us another 20 years to resolve all of the portability
> > > issues which Clar suffers from (but git-compat-util.h doesn't)?
> > > Probably not 20 years, but I don't think that it's on the complete other
> > > end of the spectrum, either.
> >
> > My assumption is that we'll iron out the issues in this release. Our
> > "git-compat-util.h" has grown _huge_, but that's mostly because it needs
> > to support a ton of different things. The Git codebase is orders of
> > magnitude bigger than the clar, so it is totally expected that it also
> > exercises way more edge cases in C. Conversely, I expect that the compat
> > headers in clar need to only be a fraction of what we have.
> >
> > I don't really understand where the claim comes from that this is such a
> > huge pain. Sure, there's been a bit of back and forth now. But all of
> > the reports I received were easy to fix, and I've fixed them upstream in
> > a matter of days.
> >
> > I'd really like us to take a step back here and take things a bit more
> > relaxed. If we see that this continues to be a major pain to maintain
> > then yes, I agree, we should likely rope in our own compat headers. But
> > from my point of view there isn't really indication that this is going
> > to be the case.
>
> I'm OK with that direction. Just to be clear, I think you've done a
> great job (as you always do) of responding to the issue promptly and
> keeping things moving forward. And you're right that there is a good
> chance that we iron out this wrinkle and never worry about it again. If
> that doesn't turn out to be the case, we can iterate from there.

Yeah, to be clear on my own position, I agree with Peff here. I was
merely suggesting that there might be more work here than we estimate,
and that it would be nice to take advantage of the experience and years
of work that have gone into git-compat-util.h if that were the case.

Certainly you have done a great job at responding promptly to any
breakages, which is greatly appreciated by myself and the project.

Thanks,
Taylor
