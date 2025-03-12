Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61523E323
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788557; cv=none; b=MRyIyLe+eQ+nj4NiVDN2t6qyXfSIqlseQPwPoUW1GfIsBU9Ll+0Gyzc0ynkXlqmtlpwH0WOXNsdUPxfLv+0/4u4gN46QVHB+DRladuPuRX862ipkhuJPcE/AEkb3nMa2ZLGMDmB/EnDvqf3GbRmOsUDAVE9Dctd1vPUpE2LZ3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788557; c=relaxed/simple;
	bh=ZeK506W377aOunGEjpuyzUAyLdlA/c8HrO/OlkuD964=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaQRWrbjNfyzoBTOYgNEq5Yt1UH6Vu9si+fNxm4YD56nxBG4Pq+GO//+Q1l8MKacXVCLCLD1TmrFHtquYeU2HyemFIp3l51/IIRncYZfwSypVrz5bcnOx5SUc/LlYQitHnnvrl7VVDGcZp+ALs9jYV1YTpXaloSrP9ZoLJbEgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XktRT3Vi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XktRT3Vi"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso10389658a91.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741788554; x=1742393354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwOjXWk03DeuKjiwEu0N27AgmK90DRRdOg5fup3c67I=;
        b=XktRT3ViGgAO5k9EStTq6LrlrzabWJ2POqLZ8l38k7NFp6fZclfxFWD4Eyw/DAgaHE
         8yRrUS2UX9usmhcqL548gy66BK2/cJXk6zMejRpI/Ei1cvYLrSEXsDIc+wUB7AMD/VEb
         Y8Ff17kwQO7SDYudhT/uQyfkgHMdHJctwZNCGLW2ekbFGdYVfZCfnT//Sf6uExB/NSwQ
         Cc/2YDhDeup5dC/oN+hVmr3k3WBuQQJivo/mJVJeUXLoyv6ktkh4nbmSvSdX7leQVmcy
         U0URKweZzyp6sKehymyhRpbpX1abwm8T4J2Dc94PoZSLm8Kt6I9iZWGtmNdSFIcrqJp9
         S+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788554; x=1742393354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwOjXWk03DeuKjiwEu0N27AgmK90DRRdOg5fup3c67I=;
        b=mr2qCMnTw/oLmfiK3UYBcNIJprjt1lV1IjG0BgcfRy5pPBvTStWzuq3eY6EHFO1Ot2
         u3gATT/hkSfsCwTTUBNiUAr+OT/TPmhTm2EfJKilB+M+f9GHIGlGKKhHcbVrCLwY/9Lz
         jtHOewLr9yNFrJothRMLAlnz6UXPNno40h/RzIlLMP5xdf9G8Gbd5rW/bmLJyu64Zg4T
         bIKEBKJ2hiDEYNnTQkQKXsZZu4Wk7Rx/l5H69XEqdC32bhsddEkxtFhpcAkYVE4laDwg
         Pn9PCB1ffbaQD8jLe1uZoJofXhlf2F6tUWj3exuVOVmAJBNPzFAACy5OPn3L09j6dRQo
         3lzg==
X-Gm-Message-State: AOJu0YwFwV52kVh6CAGnUA0EQgB23nULrOeUbvNA+D35HE0x0Wzh4sBy
	K6qSBxvb34ngK1EviNjP0KmSJ+RoP3XoJlpnowbuRyxwDpjHT1eL
X-Gm-Gg: ASbGnctV7qDnC6hT2tsxcNRmeS2kKoIFG8YBwYhDp+lIu+hKfWY/kO6RcgTIVeYBgsM
	FfVM7bRdy7yx2+9P7a3mU28k3+r/aekw54c3KwSinFLp5gBFYcaCssxfSeS3Yy5Jy24i5TwWzUh
	ajso1HIhp/GUG9OX8xSoSvamIHqBd7ktLxnhUxSHJUIiMw6Tu9T0CVNAv4cFXv/QDZxY7nnFs9o
	51Nr2yPLej813M+ubKdhozIb8u/G2k6XQuFaiQiGB6ZHFhTGmjIjwf8WasNC2R3n0UmuW4wiSzf
	0EUH6dBcho9DhZxpF60UTlNBgAvdWhYjTIffGHgR
X-Google-Smtp-Source: AGHT+IGEN+/VmzZKu10ETuwdtj6ezzQEshArzJ749w8tPU/Z5XfoLcV1JYDkXMGugKZr17vftCExYg==
X-Received: by 2002:a17:90b:3ecb:b0:2fe:6942:370e with SMTP id 98e67ed59e1d1-2ff7ce70a09mr32820294a91.7.1741788553905;
        Wed, 12 Mar 2025 07:09:13 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30103449c84sm2200851a91.1.2025.03.12.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:09:13 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:09:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #02; Thu, 6)
Message-ID: <Z9GVkw7RqsC03S2s@ArchLinux>
References: <xmqqzfhxfym4.fsf@gitster.g>
 <Z9BM4r2CUG1kF_Yo@ArchLinux>
 <xmqq8qpb4hx4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qpb4hx4.fsf@gitster.g>

On Tue, Mar 11, 2025 at 10:05:11AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Thu, Mar 06, 2025 at 04:55:31PM -0800, Junio C Hamano wrote:
> >> [Cooking]
> >> * ps/refname-avail-check-optim (2025-03-06) 16 commits
> >>  - refs: reuse iterators when determining refname availability
> >>  - refs/iterator: implement seeking for files iterators
> >>  - refs/iterator: implement seeking for packed-ref iterators
> >>  - refs/iterator: implement seeking for ref-cache iterators
> >>  - refs/iterator: implement seeking for reftable iterators
> >>  - refs/iterator: implement seeking for merged iterators
> >>  - refs/iterator: provide infrastructure to re-seek iterators
> >>  - refs/iterator: separate lifecycle from iteration
> >>  - refs: stop re-verifying common prefixes for availability
> >>  - refs/files: batch refname availability checks for initial transactions
> >>  - refs/files: batch refname availability checks for normal transactions
> >>  - refs/reftable: batch refname availability checks
> >>  - refs: introduce function to batch refname availability checks
> >>  - builtin/update-ref: skip ambiguity checks when parsing object IDs
> >>  - object-name: allow skipping ambiguity checks in `get_oid()` family
> >>  - object-name: introduce `repo_get_oid_with_flags()`
> >>  (this branch is used by kn/non-transactional-batch-updates.)
> >> 
> >>  The code paths to check whether a refname X is available (by seeing
> >>  if another ref X/Y exists, etc.) have been optimized.
> >> 
> >>  Needs review.
> >>  source: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
> >
> > I have reviewed some patches for the earlier version. This week, if I
> > have bandwidth, I would review the whole patches again for this version.
> 
> Thanks.  Any topic outside 'next' would not move until the final
> release so it is not urgent (read: if you find a new regression
> introduced to 'master' during this cycle and can work on fixing it,
> that should take precedence), but if you do have bandwidth to do so
> it would be great.

Yes, exactly. We need to prioritize the things related to release.
Fortunately, I have some time tonight to review :)
