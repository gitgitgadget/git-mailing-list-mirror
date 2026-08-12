Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA835AC33
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521088; cv=none; b=txN1DKhbeAn68lGNxCv0K694qt21z/kz2/eziv2uOPPNsFx0SqMnXzv/ooyd62sdrZXQm3Gfz38/NIHB3BV4aDuuFi9wsOtqAeU993jDojhWOURMsZs3+HrixVdQV/4oO98fxOBuUr8fq2Dmar33nbWT4MV/5NQ4VZfoR5D/iLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521088; c=relaxed/simple;
	bh=woUB1k+iFG1Wxu3CtR38AWxwJrpaIzYA/HufyxeRu+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dG0r0kHKmKGt6vFfcE3UvVhZ27J3PvTS6sw/aJDLNILS7yMRtf90b8S6deLgM71dC6KnimTu/NW7bLXjkI20qMHU+p6e0hRpLKBM3JPNK+5/AYMzhAB6OCjBg/av0q2nRZ6j5yrjaKRkhjtG6Z1nprbig1EX/kVuR53EmrAdjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HT6eUTAa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HT6eUTAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786521084; x=1787125884;
	i=johannes.schindelin@gmx.de;
	bh=OddU0OU6GBZ/mxIir9LbVTT6ZSTVpLTryco7NYJHE6A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HT6eUTAadsmx+AY2u8dKcDlsqpOI6eIVz5PY8yg+slrnp5EoMNresiy+8+G4GWAF
	 r3nUGxS+anw4VV6SjraSGAP0AG28NcVafBJdUn9fFzS6dGeuivJ5T+Y4GB4SBP60+
	 YSsvDHZBC/Ujv6otA37DV3xFqJEWQCQSi9tirxJCPWMzpxWj//CfRJEFhPi8RKo9n
	 0bMg/qE2VYj196mkAC3Vc6Z+6bBYwNly53eN+IaNC4Te24/PkmhPRYlCDVLaK93zD
	 qonWHCDxLxgHLGMoOz7ZUKevPKT4Jfwx8gkDaokTxwW0FBLya3YE6JlcYAbLAADoD
	 Ijp4J3M3UrqOsBYItg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1wmegQ3KST-008npf; Wed, 12
 Aug 2026 09:51:24 +0200
Date: Wed, 12 Aug 2026 09:51:21 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 12/12] mingw: allow `git.exe` to be used instead of the
 "Git wrapper"
In-Reply-To: <xmqq33wrkvmu.fsf@gitster.g>
Message-ID: <bacfe6f4-706e-670c-3466-ccb4d7caeffb@gmx.de>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com> <f822133191c9cca40477fb1bdd5d1416c9fe66c1.1785939999.git.gitgitgadget@gmail.com> <xmqq33wrkvmu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ut2/CU/+x8eUEKPjcnFp/Gq5lKu3sPqER+7Arj6Z1l/6T7geKwV
 kL0eOb8vBuy/KG2ILl0E8+eQd6nBMhdo0ZT5g9yARg2w+K/vSpuuiqY5o3mViv/8153nqf+
 HDnkaivrjruaLV+ysV2a2XkoWteMR8d2EJ/Rd8E/NUXsIgeUxZXjzI6BxVlWGgnvnIJs775
 mIHsxTeOb8OntOEKECd3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ybThqzEeDq4=;FfefgoKV8ym1j+IAHCm3o4sfsdx
 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
 ToD4VmF263qjAG4C2bYCJ9HxUgR41kIVIOXAE=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 6 Aug 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > @@ -3186,6 +3225,32 @@ static void setup_windows_environment(void)
> >  			setenv("HOME", tmp, 1);
> >  	}
> > =20
> > +	if (!getenv("PLINK_PROTOCOL"))
> > +		setenv("PLINK_PROTOCOL", "ssh", 0);
> > +
> > +#ifdef ENSURE_MSYSTEM_IS_SET
> > +	if (!(tmp =3D getenv("MSYSTEM")) || !tmp[0]) {
>=20
> Checking tmp[0] is a sign that we do not consider MSYSTEM set to an
> empty string a sane state and ENSURE_MSYSTEM_IS_SET is about
> correcting it, right?

"sane state" is quite the strong wording for such a minor issue.

The MSYSTEM variable is useful as an indicator, and is therefore used in
many scripts. Git itself only uses it as a tell-tale that a GUI should be
used in `git bisect visualize`, otherwise Git is totally fine with empty
or even non-sensical values.

But it _is_ a convenient thing to have, together with `MINGW_PREFIX` to
ensure that the respective `/*/bin/` directories are prepended to the
`PATH` variable. That's what this is all about.

>=20
> > +		const char *home =3D getenv("HOME"), *path =3D getenv("PATH");
> > +		char buf[32768];
> > +		size_t off =3D 0;
> > +
> > +		setenv("MSYSTEM", ENSURE_MSYSTEM_IS_SET, 1);
>=20
> In config.mak.uname, ENSURE_MSYSTEM_IS_SET is defined to "$(MSYSTEM)".
>=20
> +	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
> +		-DENSURE_MSYSTEM_IS_SET=3D"\"$(MSYSTEM)\"" -DMINGW_PREFIX=3D"\"$(pats=
ubst /%,%,$(MINGW_PREFIX))\"" \
>=20
> Can $(MSYSTEM) be an empty string or undefined at the build time,
> making ENSURE_MSYSTEM_IS_SET set to "" (two double-quotes)?

Sure it can. Just like `PATH` or `HOME` can be empty, or invalid. But the
person building the project has to go out of their way to make it so,
therefore I don't want to spend any more brain cells on that highly
unlikely scenario.

Ciao,
Johannes

> Which would mean we are exporting MSYSTEM defined to be an empty string
> as well with this setenv.
>=20
> It seems ifeq($(uname_S),MINGW) side protects against this situation
> by placing the cflags definition
> =09
> +		COMPAT_CFLAGS +=3D -DDETECT_MSYS_TTY \
> +			-DENSURE_MSYSTEM_IS_SET=3D"\"$(MSYSTEM)\"" \
>=20
> inside "ifneq (,$(MSYSTEM))..endif".  That way, ENSURE_MSYSTEM_IS_SET
> is not defined to "" (two double-quotes), so #ifdef ENSURE_MSYSTEM_IS_SE=
T
> would not kick in.
>=20
>=20
