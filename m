Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEB314B9D
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775331937; cv=none; b=uu6/eiMFUdtW0qQrfiKfk7j0WI3N6RZSQT6YJYhCVXr7axBeMithsMo9carU9888yDaJH+i1ip1E5M38+uziMLYuoMdJjvC/tQGjYjW7DcaK60RxSLoauRT+zfBb+6QvKhbVqGWUaQW7nULI6KBAbDyObOBWO8hXYUqc8gKY1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775331937; c=relaxed/simple;
	bh=zjKwmGPADaYc8Sp4UXmpN1qBttTRm3tIaEZ1vqhIhaE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=geyaqDS5igyeROUDt64Kwg4d8XN94MgBlZR8WQVXyUEK1bzOhgQsdrpOjnESQZzUYfGAmDO/8SxZPcf7hiizU/em5HAYZeOLZBo4II/U5P0cBTXUba7dBFIz6vshZdq9Sv9ny8Zq70iXAu7/PCEaLog+Y3SSAVnY2y6nNjjaqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MfW8glGX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MfW8glGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775331933; x=1775936733;
	i=johannes.schindelin@gmx.de;
	bh=zjKwmGPADaYc8Sp4UXmpN1qBttTRm3tIaEZ1vqhIhaE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MfW8glGXiBfotN6oqnRgKmqa9okLtt+ehcaeQo86zn5g0V2UqPvkpxUhAkwK119D
	 21/FPzQLYeHw1TJ9/qGU3bKDejvNrBhfquaaPIm7NEYSsAz6OvXYdMDTNK2KkJHch
	 mlSyiezGteyFuKShPbOQD3ILvRy5W/DmEaPoYiOPNl+KtC+cdxES/DFJ3AUcnePQK
	 wEGIhEB5yET/JLIk3Bysa4W4jQ81I19co7yAbVx6TTS2OxgcPcwsgDYLAIgKRT8oX
	 yWvy9FIh4ee86KgFb0AabaMlT2w2Acaym7ULxkgzvo0vS7YYRQ0Tb+t4zbUTjy7yd
	 J0jkT3r+10vcXoZcmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1w4SEO1Z2H-007akb; Sat, 04
 Apr 2026 21:45:33 +0200
Date: Sat, 4 Apr 2026 21:45:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 00/17] tests: access bare repositories explicitly
In-Reply-To: <xmqqeckxqld8.fsf@gitster.g>
Message-ID: <dcb8c6f1-1410-9f04-c389-6f69ac4fe842@gmx.de>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com> <xmqqeckxqld8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:us20gdhS6q1aH7uQl3okfdd0/ihQSgLUvKpGYQu5xFwSaaSBozS
 Okb0l/AAsNtaKlJKa3voWVg/atfrlSNIYeN9/QYwJA6umKXVHMHRCoyI3GvSiza69jAkkDO
 uDr0yV8h/HMG+dXkSzovm1ai5tCx7JK0lYhAEj/JACrpYz3v5jN/dJPp5q/QhgIB5wfK8Fy
 ptTxFgUXJeOPHxcI+2kOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pzd8HsaUxys=;XglSv5U5pc8iWcmKLN/eTCKZslF
 gkKSBKlhWl3fZJdsmJc8YqK5Uem05ca+5WLOwPw2+rVvH0R5xD8GyQ6BftVhi7qVahVD/M89G
 gnmj7yuqXs9iJoOm6s+MAxvRe55IuwBSVvjauwkTdEbAQIrSJH99CCgss0d0+SmV2QmyLl6N1
 gvw5ouIpeI/JuO0EpGCtdHnUF+3/8A01Xb2zLNoF3DhIH5U4TNJ6lueeS4TgXMWqFIqBoTMlo
 hK1K91wP8adGmOyy+PTmne12AXBLE7eXFT796/wPrMzB/okHjvKnAoKi2P3aqr7hTsws+EdY2
 xuyVYq07AKIByEaC4a2XsIgyH4HsuPeC8QmWyNeKCEZj3kANPjDsyyZeMxJHGvVDObnwTDAn1
 1lQKO2dO7tQYL7K8K5w5+P0EzBVUbIM9Ck0PKl5dx9OfGkWK5JIocyFZOz62f01heXwzbwNFx
 CV/gEmBQjPGOTLrxAKcQLAGRBXq9J4sGvq7vFuJ5yOE6dvAy8Abx0y2NEFRhb686RwROQvFu1
 nYQjp0bS82mvTSgZBx67gfYMDfGRUL2a2nr3QUVxDk4wPZ5kKCuJ44RZK5ThrRXBM12oqVff1
 15BzBrumkkcTFMR8niZrOI5A7P9/Xg7TOgda4g3QY+Zsa2Hh2iBsr2QbvXaQpXRz0vq6TZwFO
 30GiGuPgXlTqUHwQGg8ORfyHztbdgJVAbyp7O0LnM618O5Lx9mMGxcX6KxaRo8Web3rPdQ0mm
 6R0DIf2YCcG0iHz9SLgyrhDH9GAPCAwRBOcnKYIyRoXWTHd+bvzoKsgpmdXO4R0oKcIb7rWtJ
 rAWTvttO/LIGdpBY+e7IheoqXnR4xSsXsalQJlcRoXBgFho71ULJkNVg/wxozVNq7FcoVPqU6
 Z6CbqiiXUt0Y919NnuGoQ/vlgJWYf5tVTZNtsS+FGFhwocs87eM9vzFO/rJY7JgGkfkuMKE2d
 j//WkSemzfVdzhLjuI/kfp5He9qfRNncEvhuIGqIv+qpwRSYSQfHAYAk7gXggXNeehGjDN6En
 2n1jJHdCzfH6cUKNCcl4x/6/hnEXUdtaCj9nitrjJeP/mZoZbGZZCpjaC/AzZyAnMFJPqRBaN
 7COQr5BDCsakJv8M+ZDZIZYidUXAmr+MmD0ucxMYigOQiDUvG95HIE2T2Jy9o+/6J+3M0Ka5L
 JVDt5DIBKnXGMbT342MWJdqGxsn3dNeB7L0uz+nQLjd569WS0W4lfdYkKn6cHNphXxL30RWMa
 SHntd7dPvyd+ECUxcAZSIIdUfvLY2xFKBdJR2ndGKckYocDSBDB/LaShIcnviMnf4LLr74V/W
 OFzPTC9ergxySbkXak5zlK4ifeLHohm8p32TZkmw6RgUd1BMgCtfZuGbhJDmqF5p1v1y97tzm
 IqIxm4RuX9tZBnKZDBFGpW5OEOoZll3/jK5Ap0jQnchtT/eQgRYRoK7zvF5wkT55P8mvGig38
 AV+47PF0ZiNnJCI0e+2wRzG2SqnyeyoM1dgL5sACJcm58sgDPAKqdbKUEJHtOxtRjjyvk3FA8
 wMe5vB4kqNnSSS8Z6kKCMEPZTHAV3tdnymuZ+YXfQExPQ9YgAJT9j0/mfSBAFRSGGJct9/JZu
 EX/pdeXkL0GOTqBL2Nx3iXRUGPgIMHueT6ZxInVywBbOXkMneQHeTYGRripMtZc+fDvKEZEWh
 tirq+ivx5qvEuPVRFbmiyntC3kLjRpXEj1wPxGt6H824rUqDIYDk7Dx+KdNX4RphqnsNJ4OWs
 XC5MScboD9K9tfOi3hZDIv6Fijq1eimC/BRlGGy6tqrR/1xr8+SyvGC/qQamNK44onTOhefTL
 dtQduPBfKlvDYRcJ4Y/NrwWjc/wclTKyBl0EaSqq6N2TV21uGwWKEURlNgRdX9ZuGdN6E3FWP
 g5HCCMM4uO6a/fAkbp0cLPdfRmeQLbkvYYRIwdNwEph5oFo3+hXu1D69ZVT3mZMEHbOPBr+DL
 4ClMZRy6fc+g69QDy2QDDXefTRM1c20nlAZsd4ObEffTor7HU5RsWUfrGpxNjRqarKD0F42L8
 QIOYIIOaydkRAysl6W9e5ANGNqLGcb1saVWMKz6psm3SoOLE0rbnBPK3ZudxZik3VunhyzQ3M
 bGqVbUTKWlO9tIUDFS4wm9VrSyGgFngJ2HZ8HLMYFNLARz2EdBUJQhTQfClwbC4mQREXnlDy1
 btv3LoAExGpt//g+XlO21AaemqJO0Cw5dpyfPu1OIDc35xRdas87mNCiRcka/yP3emP+YmuM9
 goOk0afLtbPJdtramZDj9nF1Hdsu64OsCHhwbKgArYdQDj4ZnJ3I979X54blJfIzGxNvVbZve
 ep18BrMipSExUov05fbfs/Xn4I/1203g6cbBi1UKi6XkIYD5DfKlf99p+CxmOKh+GRSp0GlU2
 Ffws90T+uDqWgJthE9AdhWAnW9XQNseOf7OptM6WsFAk8QRC0UhGgSecIFVc6AFQs5PG8MvWX
 VhWyyeD4OpSFVuufqXlUpqfDovgaG/UEjZmLWx6MfwPXjlvETJtYOyhUVcHcvevm0uffcd5Yk
 kbkxeAenBtcvcVKmVL2UywYvQOyh7Hie/iakXiXQX2CZii2WDsGfs6dc0fOhm7UHIW0bif4cZ
 LlTYWI7VarseRoD8z3IuVytl2nowId3Vke9F4M9RP9cu2O+nIsOmIW6xp12VlJ4INusjHabOf
 Qy0h4mC5X5aNK9o6/vcuHopyPqoY55+rAG2twiBJI9+pWyThG79adwt1W50EwHSqMvsbUHdJY
 rmUfY/Gh9C/O3rV2lxYiKs4VSvxK+4E0LL5sEINPdXZDETNYzt5MPoc8oWPvQqdKvFO6mpKii
 wsBMJj1heFWFXuztGIF5zrpLkaWvrulAPxUVSBUAKHfwENc+y9We6HqV/9gpDVBTTDZwl9Np2
 ZV48ImY/5+xIh392wMBe+0DmnGLVpF+m6A5Xw+u5dEbw9n8kA5X6BgvIq7oRfOsfLV0+HrvDQ
 pxvinvhCSWPnQJPyPs1Axq5vgCgThxrsnvbMGVwrEN0Z/pUkZOQIf/OxxMehLPRRDsEMsfL69
 iqVCDsy1pgjDuA2y9URZLWgLwkCOKQPl/H8UKPD+q+jwucBdoVIWN4FCh3q/qs3dWs29KyOrf
 YkiFW/3jKGIc9eRLMxe5fv9AYMUy2TuybxLDpv9Ki0Inxmjy0tzos4uyPLaESizJLsM0Lah/4
 h5+hgasDHqfY7+o3mZ0eQstUUQydN9WKiMzJFHfXptclZs/dCux4/pQTRQgq68CWE5g/7ATOZ
 /XJZzW3JpfzpGSSCAtB+CeLCQ/oEceFnnxgK4F/jegOEjQdzSAdf0cWGBiICIFzKtznFi1Od0
 Y++7Z3FsgE+UlcNxHGV4UXq7VhtNKLBIyrhaOFhVoJW+w7jmh5d43O4hpeLfBuWCdn9Xz0DRW
 OgyAtfY4Y6oCh44jYHTwzcviM+/p5nsjhxiNZXlbXlNWnoNeA0ci45x2umE95Zzw3b12T1Eoj
 O0zvDSyqnymz+Q06Ngqy3Rnq+I/EsD+PruwCnR0hw7SU89TKJGOfFA2hU9SzSYdN5cqvULE3p
 AudSPWYOtJl5fJhjb6F94qkHmenlgbBkdUreRZQTvm82pfBBxZIkseRU1gVibPgMrB7p9uRTx
 U2ogGx0u7HFIKNY1cg9982zYyqWQz6mk0kDMf9dzsxdg0hSeb6HnYGe7l5VhBCxCM5aMH1IAu
 WuKUSbWFeDX5d7nj01L+QvFNj3NGVdxTqgL6jwA5Uj4lrB5Q//5F13q4v9CF83BekHZ9B6kat
 BEgmST3LDLb8JTjhn1FlQLkzFEuQj8BmKJYhCpepT9PlGE4O4gLwgMU66AtCTKjnHpsAURbt9
 uR0XwKTV3nLRwO/b9JUQun4WPbmVpU1MTiwsH4jAiu2xy8f8EMZad0DGt9t4b24bqLPIQQmMp
 bgTaaGr8vzk5XTsIK4LuFpMjfLXOK1w8eNvCiZ798an/wG0Eeq+w4Mnh6p04xB9bNUjXW/oZu
 IdhbAXq08dpAqt0+ywm84sp9RhMfHMEdnK8IFblClcx1laf6j2IK+okc5Yzzn+fnIdzul290a
 dp9v7eAgmqfGm+jbm5WGiClcgEY5LXqFFHr05OB8Iqnsqh2qn1mDnH+6pl12S0LmcfuwwEzBc
 gRuADbsiCzicbi4oR9VNDk2ds6MEED7MtvWabqu/9mcqhIhJLpO1/lK6iNJaQCfMJTxwadKKM
 M273VPi+bvSdOEf7aA9pxkK8yW5KzfBNIzYBciWQrVI6jyN7/uNLLkmAFtsjbq2Qe1csbMV38
 1xdExY4FmE6iqrjVGgHmn0VryKX+BSpzJhnS7T2AKh4pX474Gwsmru1Tk7uZO8UBGTPC/Aagc
 3hpkw8PIgWcHVX/kxDFvpC8eUVQHuQxOoQZZqm5hiFiKtu2Cp5q62FXZn6iHRd9oDdMZyh+zC
 hVKCjowAF5INvCdmIKlxJAnolYfruBxQ89HkBqfcJIAqM7xrjcBiOvjXIIOuHYV6sBJwwOIWd
 k8S+R6h1XvuoT8t2VhD/eKttH+VdcqRyvFTXi1cSBkhc0XEnLnxzATLRFunY+iYpTSD+Ik8+2
 vSNnWtosXuxkAQ6burh6Ga5apCuhVAeTcDWQZCtTPQEkW/8K+WWZQAftjBMLEGO7/ByQPk/o6
 0Fprs+6C0yvsoehqoS2IFnUGqdXeDAzb2+DsMJzgIuhi/ttWKKRoNxikiiooBLj0sXnEJwwjH
 L9d5mDbST+3taZs4TbFntHnBZjVDSuWmHTxxcg32VLFPi5nfWRg4l6f9qW+iud+J5NzsuRjtc
 dzMKwC6EFqf76qeGT4VoBZ9BicxX/3cpK3XfmFFx8tIzCQeoNn8GeXFYJOVC7G8fleyKIjNsS
 P4iiWMPdQyT+XHmSMvTFqTiSJHZhJoSt3WEy/KIOzxYT5TsW90JRkUk5wNbqlbbfEwGIUWhZn
 C2tDbaux1T54GLQNieZAp+EhvD4Z5XkSqFibQL6vpL7a/o1fEcniGshXTtToad+i8IabAMMZa
 V+LE7paUUHk6nSiC95IFb33oytRBle/TpxnloqhiOJF7Qn/o553ZhywYBpWz4vDIpeXPrvRBd
 B95xr77fzUvL4lQl2WA7u8knsWmCn6OPezDqCYiECj3L0qytgiLqHRHrILzFIZReZg+9hfb61
 DWjhQN8HwwkT+9auby7tSPLc0qxwuBl/XBoTsyGa4gkL1Sr7mFDRWcY38MpUOOoO/tILJifVX
 uN/LvswqbydwkG4xBIWYCUsJTUV2xjF0U8fBPiKjq+0tZJvk/q3pgDG0+zzZTZxLmpksteNkV
 B7+L83nzPpnGNwLiZy2pKel4/RH99cY9FT4P/fPa1a7b72e5Yd0RldrpSdO+8VTG4w7WPqo0/
 chQo8xk7S9L
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 2 Apr 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > The safe.bareRepository configuration variable (introduced in
> > 8d1a7448206e) allows restricting implicit bare repository discovery.
> > Its default may well change to "explicit" in Git v3.0, at which point
> > any test that relies on implicit discovery of a bare repository would
> > break, even if the test subject has nothing to do with bare
> > repositories.
>=20
> I do not recall such a change for safe.bareRepository discussed in
> the recent past, and I do not have a strong opinion yet because of
> that, but if no such change to require "explicit" comes, we would be
> losing test coverage with these patches, because these rewrite the
> ones that rely on a working code in implicit cases?

Note that the commit message says "may well" not "will". Precisely because
such a discussion has not been had in the recent past.

But yes, that discussion has not happened, and I was quite surprised about
that when I recently looked (I prepared some of my code for such a change,
assuming that Git 3.0 as a natural inflection point would be the time for
8d1a7448206e's long journey to come to a conclusion).

> Shoudln't there be a patch [01/18] before everything else that
> updates Documentation/BreakingChanges.adoc to propose the default
> change?

Well, yes and no. There should be an update to BreakingChanges to propose
that default change, but obviously it should not only be a documentation
change: It should also adjust `Documentation/config/safe.adoc` to mention
the intended change of behavior, and it should introduce
`WITH_BREAKING_HANGES`-specific conditional code in `setup.c`.

And, crucially, it should pass the test suite under WITH_BREAKING_CHANGES.

To do that, a lot more needs to happen than just the 17 patches in this
here patch series. Most of the additional changes are quite mechanical,
and can be validated relatively easily despite their sheer number. And
only at the very end of those changes can that `safe.bareRepository`
change even be proposed. The eventual patch that does what you ask (but
not as 1/18, for the reasons I outlined above), and more, is:
https://github.com/gitgitgadget/git/pull/2072/changes/435e3505e7997a25f457=
77a6ba436899a793c59c

I plan on proposing that patch in due time, to start the discussion
whether or not it is a good idea to change the default of
`safe.bareRepository` in Git 3.0.

Ciao,
Johannes
