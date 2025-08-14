Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310262FB98D
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192193; cv=none; b=FELKdEPObOiwr9E8JtzYYzmDvgQSoWmwP6iMXw58kPbOWbY6IKQM8/CC7wORLAVnFQaO3zL16IMJ7LqHgUUoq+kefizLgWbrV7QXSLYEy+6OAZpsEkd+eNX6QWk29Go9Y5hzY4u2yL2otkI9lUwOVjBopgKCvDvq0OZIXfsVKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192193; c=relaxed/simple;
	bh=Atll5OZcv73+Q8cmLYdaLKSY6C/6Hm4TJWqfYPgKU1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNLHTHdyaUkVckA4jo/IPmnlHz3PRc3TljnuSSMwZg0j2trel6/viJtKoZ8RdDZF/jLbUV3effKV19lrTF+TctC1i5ZDRJ0RA3l3Fy+MmEMNQQh/iJyW0s4cFEzXJkXXgUHT8xddDy8eU3vm/U4SAC1bm4MKKn0x+ePEwwdoi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Pk+K+P8f; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Pk+K+P8f"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:68bb:b9f6:cc49:e4c7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 32788B00565;
	Thu, 14 Aug 2025 19:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755192189;
	bh=Atll5OZcv73+Q8cmLYdaLKSY6C/6Hm4TJWqfYPgKU1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pk+K+P8fDvuyroGf9HKnwYgRocDzx0EQ525MK4qkxopZYZ839T6yuo9HullbZWqyR
	 4LINnwLTIkF7/vGLXTjPHqJP6wdopKfRIclejvYV5CZoHaq8XuMs3sbzG0bIOtOK+D
	 DY4l1B2hGhyNhyjaDrNElaTZSU2H3q25dYIG34TG5wTpk9+olwS5eLDS9xrOAR42pi
	 uTDos+vhjAzXCDZYpzqkQ9Aom6ezsBxJOFvYnVfUMtgv8cHW/JUGu2fMmWqxCk1cn6
	 SvfI4nhVdHbTggz0SoaoRbhOhFyZtLkQV8y7TwPyCofvK9/FIzPGcH4/GEDwfyPwhf
	 KyhcwP3eRe+sw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Collin Funk <collin.funk1@gmail.com>
Subject: Re: [PATCH v3 0/6] Introduce more doc linting
Date: Thu, 14 Aug 2025 19:23:04 +0200
Message-ID: <2794218.mvXUDI8C0e@cayenne>
In-Reply-To: <xmqqldnl50bc.fsf@gitster.g>
References:
 <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
 <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
 <xmqqldnl50bc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 14 August 2025 18:34:47 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Reviewing the documentation part of the last patches, it turns out that=
=20
the
> > majority of my comments are related to the latest documentation guideli=
nes
> > which are both easy to forget and almost trivial to automatically check.
> >=20
> > This series implements the automatic tests for basic doc rules. At the
> > moment it conflicts with "[GSoC][PATCH v6 0/6] Add refs list subcommand=
"=20
and
> > possibly with "[PATCH v4 0/9] refs: fix migration of reflog entries"
> >=20
> > Changes since v1:
> >  * fix a small typo
> >=20
> > Changes since v2:
> >  * extend range of check files for multiple entries in definition list
> > =20
> >    entries
> > =20
> >  * extend checks for new synopsis styles
>=20
> This round has been in 'seen', hasn't triggered any false positives.
> Let's mark the topic for 'next'?

I'm OK with this.




