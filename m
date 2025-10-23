Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FA3D3B3
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256209; cv=none; b=Pn6+sbacEURKLJ1c6cTOmmR6lkebiLQZA/dpKFCrfaAoQP4yg3QYVSUBy1Hu2UzmqdvAstBl81AP3w8YrnA5C5zw1lkxQVQjikpHr9jQQ5E3RTFnccjuEJwFDWQPk3zJNsL/NL41ajgZUu5xfI0ST9VZ0GiTnK2TjKWugYg6WWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256209; c=relaxed/simple;
	bh=ce/LMxdbVspq2KY00aCfDANNwjNqW74v/DjSIkUTE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhQf1QHvjXoBIKpkCrwgiFuTOVaYdiZA26wSOHEf2I5HnRgcHmpsGApI4AzIijJ8+ty/2mTwWK/wHXyzmH1TdiAX/XtFGDKdWKrZHU2uucVwa7mqCeN9K7WvJnsAIMifxD8p4fcLzZWkyz6ms7DdPwirI+24HeKukto+fEy/nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OJWUymvb; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OJWUymvb"
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso12199525ab.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761256204; x=1761861004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUvDUJx2PxoOupTdqzTi3hsqWvOlel998ghUlFhx460=;
        b=OJWUymvboa+Vqg684xnt2ySP6rBUaT+97auemps1x/Zc/njwQYMuX9CU4s79xQZE3F
         eKxg92Gzrw/BHOUacOXN4XcB81Fw5SBURlvAZ9OnnkSMICKscJ5wR8I0NqfPmdTwreML
         zUkJZGVHZqiaKmiYrP/4Mi34KDLLXSVUrkJI70zjTelOItJEli5uCrII0JMDw4i0DI/3
         0sreb0+btRmUnaH1C48VtFIlxjG5WpFRbennP9taZWy/wJkuHEdQVCPIqDG4dbsdWDrI
         OhLDuuFrjAa/PO2vhpARydgw6P7m36sCamE/rDfJLTvu4ZCb7AH7uFE3PaYvqfK1Ftsy
         t1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761256204; x=1761861004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUvDUJx2PxoOupTdqzTi3hsqWvOlel998ghUlFhx460=;
        b=rzjU7N+yL4dbB9iuRNd82JWhjO/woXjf0F1VhzvS1cH/59GVqoLf18yqFJ7g6Dh4rn
         EakBH22ZVGqdTmZO4mxv226T/HAVfOCIeXAisepzYmm5k48DLpwcZs8tapcIVHqp2EtH
         NL11tx1JWjQDxWPqe8uya86Sr6KpRrHHysspidKqF09QRnV4BM7EwD0eO8jOrkZXgitm
         2GaHFX0Y1yPUgtkwv3vIhfUfk2XQnTbGM0cIB4c0rZusE2J90Vkh1/zf76/iZ42Gllhy
         r0oXA6C4SBFY6u0US6mHPe1gBEJf1yNHmtROnfys/QrYQM+9X6noSaJ4HkdVYMRTzGY1
         bC5w==
X-Forwarded-Encrypted: i=1; AJvYcCVqXY1jjBirw5hwdtQ2i4HVpV4/7ZI/ZyGaAI4G71Gg0ZraMMTdP5RH+xaJqNu+ERam1N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6Ywc7zK/9xE6njKr6aWmMwnWpzgmtw3tQ3YsWWuw9aloKiuw
	kPH9PPXiiRqCZrDk+pG2xWwVC5yR44tkf8vgI9wBgjJx1PCGoenBpKgrBgdXxPLan0E=
X-Gm-Gg: ASbGncu6Hc4jHorHQZ822JqLCMdMFRZ1qn9kMguhgJTkMB5lFX4/254DcKuONGu0Qn3
	0ZLRXHYZVXV96HEaSE9/Rx1dXBalCzKuAsy323nXvrRkHNXuhngf2O06JA0jdY2dfBsCDCp+wKF
	noJp6Q6j3hsnGalxKFeKMVLakrZqKmjP9mDTJSeBkZGGyf7yULdLLIM5J9bpqShgNnK1tG0q7Oe
	2Q63X4+e1mLCN3feO7TAi4yinTavfzp5V8fmxfzT1W4cQirLdowdPIHN68ZJchTY2FHAzpi+wM6
	np73LTXR+MTC1hwIK54QwYGYPvF/1dHx8KOGrt5artZE6ATGcqoAhmmB2eKpdCRNGsZTbbRFHJ0
	qM9cOOXHIZqotTBW1k1tbsnJPjrei/12TlhOfiuqthAt7niS5i4wNOK1c8H90mpvFHbOMrad1bx
	H+TYvsIR9H0A/EUY3tswkoJ7cxGC3Pa45HRQ2cKkr1Id5cYolLcpBDySjw1Giy9VPyRiZZprciK
	kHFSQQ=
X-Google-Smtp-Source: AGHT+IEFqXPfeWzb8m4/uzCJVIU+Ox1jM+450nO1a8U7E1SO3+4CoOsiLTIWRKvAmyUjo28gAFOViQ==
X-Received: by 2002:a05:6e02:2382:b0:430:ca90:d0b with SMTP id e9e14a558f8ab-431ebf6c927mr2789995ab.26.1761256203916;
        Thu, 23 Oct 2025 14:50:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5abb4e4c935sm1408767173.4.2025.10.23.14.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:50:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:50:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/9] builtin/maintenance: introduce "geometric"
 strategy
Message-ID: <aPqjCiVbM/cFkdzi@nand.local>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <xmqq7bwlwoml.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bwlwoml.fsf@gitster.g>

On Thu, Oct 23, 2025 at 09:48:18AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > The series is built on top of b660e2dcb9 (Sync with 'maint', 2025-10-14)
> > with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH??? play well
> > with other topics by preemptively including "repository.h", 2025-09-29)
> > merged into it.
> >
> > Changes in v2:
> >   - Make the geometric factor configurable via
> >     "maintenance.geometric-repack.splitFactor".
> >   - Wrap some overly long lines in our tests.
> >   - Link to v1: https://lore.kernel.org/r/20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im
> >
> > Thanks!
>
> This round looks good to me (I wasn't very careful picking typos and
> minor mistakes, but the resulting code overall looked sound).

Yeah, I am happy with this round as well. I left a few thoughts
throughout, but none of them are blockers from my perspective.

Thanks for working on this, Patrick!

Thanks,
Taylor
