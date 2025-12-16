Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9E3396E6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912325; cv=none; b=YkrenqkMH3COXw41RlpzO6y3oT4vPn66tc3BeUfrITvlzj+hd/aXujSXMFUh7iTK5I3vWlPoNRSKSXB76A2O3bd1ydSfXCM3g5eGWp1sOr9RYLURDDJiDep9RJipGVn4WmpK9nZRUw3gT0XHPvQME8VQvJZuuVxlvmm8ghJCVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912325; c=relaxed/simple;
	bh=bHPFEYZm5l97Dkib8MEdyGjBQRGsqkn1qeIop2jJpQs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aWwUWrp3y/Vsg/EwFiBfQWYwCQ3nGW0+7tNAvK2Dg8EY7PKo852dwAzNkS+mm3a+/6SfBf5dLWNBbQbu5zHbGzSaw3C66trbEiBYH39ah/W0UlckctM61w0+mQEMSeTCWEom8klGT6/QJSP/8/nOP1CLHsSDo/DdUciX9tIF01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=O1Fv4J2g; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="O1Fv4J2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765912320; x=1766517120; i=l.s.r@web.de;
	bh=W+EraQt9ufmDHaAbfVU+GgKxNYbDITITJq5lqTjUASA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O1Fv4J2gs9n8TWw23C/DM+7OCT+u8YFc+IHnim23+3ls8O/EoH6uO2QxIIF3g7lK
	 lSjIntQ4kmTd2UMFT8h1SipikMbKvpad2bVROYa1vWq/Tco5lKiCKLp6LQdMcHF+H
	 Nd53pzTuWsBBacGB3lsTRDxHxQT4bUKZfJPmF8O8QQ4MfavnhvfOl+SX24CORWygA
	 kdPyBqT8j9dbgI5WGaQbc8ltlw61fMO9WWLcozh2YZC9ndz0Bv2Pvz00kphMD6Iri
	 T8k7pHP675Azws+WFROLJiifzmnu3BAyd52jdLPGZfeolLx4vqFH4Zzff8U/7asmw
	 4cjnVestC8WVNaUo6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1wDgWZ1OPz-00okKE; Tue, 16
 Dec 2025 20:12:00 +0100
Message-ID: <d2f033fc-222a-4fe8-8d24-6501e6f7a4c3@web.de>
Date: Tue, 16 Dec 2025 20:11:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] macOS: make Homebrew use configurable
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <98695ef0-b6bc-4929-8581-2ecb894cd604@web.de>
Content-Language: en-US
In-Reply-To: <98695ef0-b6bc-4929-8581-2ecb894cd604@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTOpOt9G7wQH3SCwRQ9elV6lKLllvP338n+SBfS4jrl3eyn3r3u
 smSuhXZpITXHvp0vMLPMOHFeKyXNAMZwozjjGvz62zDikdU95PdHjsS7//RnaFPkC68+9XW
 j77KkKeD0Z/lt4KG1vIlp67YuTqAzfmqCFcAOdJXyEOR96JT8C9lbU83T1kCJDaKtpPGI9w
 wdSAwCzr026DU3wq8Z0TQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SE8r25ZLaqg=;QdVcRkOSNQIhok9uZ0Jzjv2AU0M
 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

On 12/16/25 7:53 PM, Ren=C3=83=C2=A9 Scharfe wrote:
> On macOS we opportunistically use Homebrew-installed versions of
> gettext(3) and msgfmt(1).  Make that behavior configurable by providing
> make variables to disable Homebrew usage (NO_HOMEBREW), to allow using a
> non-default installation location (HOMEBREW_PREFIX), and to control the
> use of the individual items (USE_HOMEBREW_GETTEXT, USE_HOMEBREW_MSGFMT).
>=20
> Precisely Link the gettext keg (the opt/gettext subdirectory) instead of
> risking to link random other Homebrew-installed libraries as well.
>=20
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Makefile         | 28 ++++++++++++++++++++++++++++
>  config.mak.uname | 28 ++++++----------------------
>  2 files changed, 34 insertions(+), 22 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index cf3f4b585f..a97e9e4d7d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -100,6 +100,18 @@ include shared.mak
>  # specify your own (or DarwinPort's) include directories and
>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>  #
> +# Define NO_HOMEBREW if you don't want to use libraries and commands
> +# installed by Homebrew.
> +#
> +# Define HOMEBREW_PREFIX if you have Homebrew installed in a non-defaul=
t
> +# location on macOS or on Linux and want to use it.
> +#
> +# Define USE_HOMEBREW_GETTEXT to link against the gettext library
> +# installed by Homebrew, if present.
> +#
> +# Define USE_HOMEBREW_MSGFMT to use the msgfmt command installed by
> +# Homebrew to compile message catalogs during build, if present.

Do we even need these fine-grained USE_ variables?

Ren=C3=A9

