Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F417B400
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995086; cv=none; b=DOpENha+DpIUEfqezW/jPKKRFtIkiFGRLU18e6Hw7yrtR3D2hNk2BD3NMniBWwJoU/+RKBG8Z+a9akCm1zmSCjIEGQKINw0DgbTcj9g8uA9+SPh7bGtUcyOVwaDMD80rMs5acE3GMhjJnis7Qnph9ePzBFnnZVldufdVUauxHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995086; c=relaxed/simple;
	bh=RHOKDkLqsGCfN+Y1WUhWowgf/Ea4WjSV8DV0ZsGdwfA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=WT0FhWNk5MZOf3dF/8zLvy+GqSf4GlcVrGhu8bQ6oBc/lDreOqx4y644DufCpf517P3njBr/g3gg67Du3+VH1CsfAZBzv3z5xAwrtoPXM69tv1h+FsQ4J2U6ey1N1K+2aj7CBEIoJnBp/HTS8Q05FVU2YPO+8g77IBQDmgT6CYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X14SrwM7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X14SrwM7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f47f07aceaso18976535ad.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995084; x=1719599884; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6k2hxRVQN4r/HSs3C5UkMX+oSv4YGL8AqE8k2pDBlE=;
        b=X14SrwM7ZI9NVCdk5vSYkJ1RB2yqd97joo9oQeSxGs91r3btN+C2kYuJyp5MCRm4Wy
         zfgKoFPBnPLCDwLyXgcyN6GCM1z0Y2pnVeAt/KvrplIazOQf57J5Z3rJ7QVWDjoafSrU
         N9fXbjU+bM9bS05AsWF3W2utv20bfKmE8gHAW+eV7zVhmgaKlfzoOcevjc2TnyXdpv3E
         5e81gEcEADlLusPo+QTUHK+moUIrORQ4mtWNeXmLpNcGKHx1Cs3CaitwXKCBuyGR/U4R
         9tTs35auJB0u5x3o8k5um9ss+1ruk7Ju5pRVJ23jNOyoMsHWk9dDOmhI+W/LzltQrj/w
         CfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995084; x=1719599884;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6k2hxRVQN4r/HSs3C5UkMX+oSv4YGL8AqE8k2pDBlE=;
        b=vvMDYNyc3ui4SUqK3tMYn8AwgKb7Xho27aKgUAXUCaqjkC37NX+jWhAlYUSe3o4qms
         UgxcG36wNXRDaHndqKeR5e7+fCSosDEgmWHUprF9wGVGxidrC/H1AlRGgA72jXdZEekW
         burPfbSdMeGh+UNeRKFJf/C2cCbSxO/utQYIHTMvONXgLSqTvK+7duLGCtK3b+7QjKqb
         NjdJsVuIevlqjuDlVFnS77zHXjNK6P/xu1j7N4a1s7tX8y0vI8HUBnwcSU4RodRmu/8L
         jQjQnrXLam89JSzTMLBZClqJ5XziFLZm2123DoftPhilyVdgZxxjm49flq0HmHYTunWu
         9WoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsX6GEfu/Ab3UOUg62RMnZ+VYr/+chkPiMrpxx47FW/wgu6t1Owh015iXgHAppFa20nl+uml6A3LjZ90rH7xSm92Fd
X-Gm-Message-State: AOJu0YywbtcjT/zfXod6Oi7YrLnEI/geu2v+zYCOM1atw688F2izM0QL
	GG2MGm7teaVm5I9qJoCgUuOG5Pkv4lYQNom30cjTaD7HNREoJoWc
X-Google-Smtp-Source: AGHT+IEMDPA31QT4vJVin2StAPnb+AqRbPBaEGTrJqe49aRLSH+22pqw6Mag2EvAUz/TXbGjpE+xFA==
X-Received: by 2002:a17:902:ee94:b0:1f9:923b:259d with SMTP id d9443c01a7336-1f9aa47c7fbmr73192545ad.67.1718995083904;
        Fri, 21 Jun 2024 11:38:03 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb589dsm17061175ad.269.2024.06.21.11.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 11:38:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Jun 2024 00:07:58 +0530
Message-Id: <D25WWD6D1KLF.YET0CQPHSAAL@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 <ach.lumap@gmail.com>, <chriscool@tuxfamily.org>, <git@vger.kernel.org>,
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to
 unit-tests/t-hash.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Jeff King" <peff@peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-3-shyamthakkar001@gmail.com> <ZlCWcpcUkgUMWJYz@tanuki>
 <CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
 <xmqqo78vnrba.fsf@gitster.g>
 <6fhpz4aqq7jr6ca2durig7e5a37g6ndzjjc2v46kjjkldohtja@tu7cdo4tu2r6>
 <20240616045259.GA17750@coredump.intra.peff.net>
In-Reply-To: <20240616045259.GA17750@coredump.intra.peff.net>

On Sun Jun 16, 2024 at 10:22 AM IST, Jeff King wrote:
> On Sun, Jun 16, 2024 at 01:44:07AM +0530, Ghanshyam Thakkar wrote:
>
> > On Fri, 24 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> > > Christian Couder <christian.couder@gmail.com> writes:
> > >=20
> > > >> Can we refactor this test to stop doing that? E.g., would it work =
if we
> > > >> used git-hash-object(1) to check that SHA1DC does its thing? Then =
we
> > > >> could get rid of the helper altogether, as far as I understand.
> > > >
> > > > It could perhaps work if we used git-hash-object(1) instead of
> > > > `test-tool sha1` in t0013-sha1dc to check that SHA1DC does its thin=
g,
> > > > but we could do that in a separate patch or patch series.
> > >=20
> > > Yeah, I think such a plan to make preliminary refactoring as a
> > > separate series, and then have another series to get rid of
> > > "test-tool sha1" (and "test-tool sha256" as well?) on top of it
> > > would work well.
> >=20
> > It seems that git-hash-object does not die (or give an error) when
> > providing t0013/shattered-1.pdf, and gives a different hash than the
> > one explicitly mentioned t0013-sha1dc.sh. I suppose it is silently
> > replacing the hash when it detects the collision. Is this an expected
> > behaviour?
>
> The shattered files do not create a collision (nor trigger the detection
> in sha1dc) when hashed as Git objects. The reason is that Git objects
> are not a straight hash of the contents, but have the object type and
> size prepended.  One _could_ use the same techniques that created the
> shattered files to create a colliding set of Git objects, but AFAIK
> nobody has done so (and it probably costs tens of thousands of USD,
> though perhaps getting cheaper every year).
>
> So no, git-hash-object can't be used to test this. You have to directly
> hash some contents with sha1, and I don't think there is any way to do
> that with regular Git commands. Anything working with objects will use
> the type+size format. We also use sha1 for the csum-file.[ch] mechanism,
> where it is a straight hash of the contents (and we use this for
> packfiles, etc). But there's not an easy way to feed an arbitrary file
> to that system.
>
> It's possible there might be a way to abuse hashfd_check() to feed an
> arbitrary file. E.g., stick shattered-1.pdf into a .pack file or
> something, then ask "index-pack --verify" to check it. But I don't think
> even that works, because before we even get to the final checksum, we're
> verifying the actual contents as we go.
>
> So I think we need to keep some mechanism for computing the sha1 of
> arbitrary contents.

Thank you for the detailed explanation. Then I suppose we should keep
these helpers (test-{sha1, sha256, hash}) as it is.

