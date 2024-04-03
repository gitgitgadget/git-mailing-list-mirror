Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27764433AD
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140577; cv=none; b=AdeIEOcPRPkGSNt8JWYdQmRjFOIZ4cUh8Jfri33vFbnbZC8A7TiHMAj7fHvk/JqvBxxqbD0uMuMyOSZnUO0Or93ZZvrKSlVrvpqh0zVvph43ujx//PJDsSovkYiYYYbBvdz2PoGQD8cTuESGAj7nDCPdcyuffMdG1MnM9ysTCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140577; c=relaxed/simple;
	bh=fxEjKRcOezJ8CT3pufVc9HJoB/ZxuCa0MUtGaMsfLec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h05TI5dTXqrB7FjzPIehKi53Wn4QjOAJbT59Ho0FoC8hoXJUCJLdaweOFaeJUhOvs5Kq3GrgN1UVdrc+RT3bye2+FpOMOy2rff0CrOjYF4mv6bwi69Qi0izvXL0Lbus4Avs5I2jxsIjEvjI4YqQxjA/41lo+wqJ8hix1qzS1RKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne0prN3w; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne0prN3w"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dc949f998fso4085469a12.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140575; x=1712745375; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kiu9+rcAww+EnAd8VsRjBeEh0KHVMmCIie7RhuRhBLk=;
        b=ne0prN3wB61OIJBL4Rwy4Mx9J0VyEmrTgA1J6hpMapQckdXpfaIMFy84wf25LqaeXU
         k7iZHGEIyzfLJpUbKuocaiQOnTORDRZaxLPlkVHTLggI3j9ZxJOxU8Fhd/hA8BKqqoji
         biach7SAls6ZEBM8SPQtetFm2aPZrmaibMxShCl/T8hKxG86oKxKSvpEJ7EEvGOCe4TA
         J4wSI8Z9Bq55cwaP72WKAPn5csLM2Z9Kv44IUk0sbGVORsJJ+czfPcZBoru34IiBs9kQ
         YLvx6S8q+E2lNepV2VZKL2XbmlYlLTB1tuomCY0AO2+BLqZbAUhOt9HFDpAhj3ND/s8R
         0PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140575; x=1712745375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kiu9+rcAww+EnAd8VsRjBeEh0KHVMmCIie7RhuRhBLk=;
        b=WChvX8uhccOCUEGLz21YIsMY0rnWuubMVOTgVhczlC49aQIP5JOigMuUO7xdRBSdLe
         p3ids6u0zG693ULFrfi+Lg7X/SXXBiiqGjm+J73spUOd7s1qu5T5DWEXZyQHkF5MusWT
         5aJGmHgJUZqS1T55gmDLD51iRgVRywgD78t458O4g+ye4vMKVCxZRDd3gZJgwo4K/Rj3
         FQk8rgr74JTa+vJh1t+WJOyd7a5SJFGlkTPZjwabQYfwxiN27K0+5JqQ7q5itKSP8P2r
         VFxgVyzYDt6EslILkP3CgQnW075e3NyhcCr3zcHWU347pXheFA4D/KVnhVsKLabqC0vS
         S+XA==
X-Forwarded-Encrypted: i=1; AJvYcCUZD2xKAHuGNC7uKoM6ULySg9VodjKWLtt9sCMcUB8usxwoqYp9nbXugil1i6TBgVjDAUEkSDVauCigWU8vTvSKmLjO
X-Gm-Message-State: AOJu0Yx4zraKWHSPU/WuC3GVtEhhCu/M3gsZfshpSEfUBPQGImkj4Vu9
	/TQe2DofvxWMmw0WedWm3aLRYBZvbESr4ju0vIBSHm2wxXiQFztZM6N+fZi/65JP5rVXYrWcC2A
	lhpeftLt1qNNzmDsAYUA/8lG4NZo=
X-Google-Smtp-Source: AGHT+IEizWLoaof4ksLJsixA846pMF2S1RRJVHUWuz6kYU3Ta3F5e2scRjiz/fgNDN0Q0dCSzpMV51W8jpUP9jnWnrw=
X-Received: by 2002:a05:6a21:6d8e:b0:1a5:6a5f:b0b9 with SMTP id
 wl14-20020a056a216d8e00b001a56a5fb0b9mr14673639pzb.48.1712140575407; Wed, 03
 Apr 2024 03:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 3 Apr 2024 12:36:04 +0200
Message-ID: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
Subject: reftable & jgit compatibility
To: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks again for taking up this work.

As I'm browsing over your patches (and realizing how much of the
arcana of the format I've forgotten), I hope that I did not make any
errors in implementing the spec (and/or that Shawn didn't deviate his
implementation from the spec). It would be extremely unfortunate if an
incompatibility between CGit and JGit were discovered after it is
released.

So far I have always been able to read JGit reftables using the C / Go
code, but it would be good to systematically test this, ie. generate a
 bunch of tables using JGit and check that passing them through the C
code (read & write) leaves them unchanged. Or perhaps check in some
tables as golden reference data.

Josh can probably connect you to the right folks to help with this on
the JGit side.

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
