Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D72255E4C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794672; cv=none; b=onTZylYsoX05u+UFzve7Ao/18n8EwzKFXkrs0EAu6nttC5p23d+qbmq5+dOspdKGftjg/6t+a/8jOgvr4/YDJgyxROVzJnwWSF5cj2v/29VB+Zw/WZw58EL3X/6GW+NiSJQH1kV2+Mu/Q1uIIIRTycj6C/9Je494SxZEjsJkYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794672; c=relaxed/simple;
	bh=omDWhkY1Um1z3KXbyqc2sNUy3DryhU68Q6aJ6PdIQM4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sezrsIgPfGXbrIEo/c7o35EigXvPN6dkOQYZdH2eZYArnGXwvWWu5gUh5Zt4rI7NKhwv6Sgnrh1fr37/4MMv5EtkDAWV9c1gKn7/lezpqZpILEfGr6M32Embfs0Gvp5GO0qzLe+uhfvKI6K985a4klsj0PfmQ0RwIC7iGbTnxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=J3I0jzc/; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="J3I0jzc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741794668; x=1742053868;
	bh=omDWhkY1Um1z3KXbyqc2sNUy3DryhU68Q6aJ6PdIQM4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=J3I0jzc/SgbDF+u8u1Xlvut/+2rboRg2yvRpcEhQNaLaWrmx7Iv8ZjEwrem6JD8Te
	 HdQMNWp1M8xa7gjKMQ2nKeV+raoOr+LaGHSR1kI8retSUjBzOFfN/u4hoF1xhXAHFK
	 hPYvYoOqtrSNnudn/4bxp4pU9pY6hfXISPlwhEiChSbebhvKsqevRXxQCFn7sKqXlc
	 xmW3IdbH1Vsi8tl0Lvv2WmEMSfO4HaEMwV8cj1ZTWn+KEQtvm5/3/EK+SIS5R5g9In
	 qR7qv9Wpq5dJ6JesWInDjhuKmRq3bsWdzA4LPy7DOV6v12/hH00gCLZh9hlHgu1OZA
	 0yW5C0xWYV+Dw==
Date: Wed, 12 Mar 2025 15:51:02 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Jason Cho <jason11choca@proton.me>
Subject: Iffy output given git diff --unified=2147483647
Message-ID: <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
In-Reply-To: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 2b6384503e95bdada685d16f109f77fbcaea8fd4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> $ git --versiongit version 2.47.0.windows.2
>=20
> $ git diff --unified=3D2147483647 1.txt 2.txt
> diff --git a/1.txt b/2.txt
> index e53eaa1..1130481 100644
> --- a/1.txt
> +++ b/2.txt
> @@ -1,10 +1,10 @@
> =C2=A01
> -2
> +a
> =C2=A03
> =C2=A04
> =C2=A05
> =C2=A06
> =C2=A07
> =C2=A08
> =C2=A0a
> =C2=A00
> @@ -1,10 +1,10 @@
> =C2=A01
> =C2=A0a
> =C2=A03
> =C2=A04
> =C2=A05
> =C2=A06
> =C2=A07
> =C2=A08
> -9
> +a
> =C2=A00
>=20
> $ git diff --unified=3D3 1.txt 2.txt
> diff --git a/1.txt b/2.txt
> index e53eaa1..1130481 100644
> --- a/1.txt
> +++ b/2.txt
> @@ -1,10 +1,10 @@
> =C2=A01
> -2
> +a
> =C2=A03
> =C2=A04
> =C2=A05
> =C2=A06
> =C2=A07
> =C2=A08
> -9
> +a
> =C2=A00
>=20
> $ diff --version
> diff (GNU diffutils) 3.10
> Copyright (C) 2023 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.=
html>.
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
>=20
> Written by Paul Eggert, Mike Haertel, David Hayes,
> Richard Stallman, and Len Tower.
>=20
> $ diff =C2=A0--unified=3D2147483647 1.txt 2.txt
> --- 1.txt =C2=A0 =C2=A0 =C2=A0 2025-03-12 16:04:06.947099900 +0100
> +++ 2.txt =C2=A0 =C2=A0 =C2=A0 2025-03-12 16:04:27.131732400 +0100
> @@ -1,10 +1,10 @@
> =C2=A01
> -2
> +a
> =C2=A03
> =C2=A04
> =C2=A05
> =C2=A06
> =C2=A07
> =C2=A08
> -9
> +a
> =C2=A00


Please see the above command line output. I run this on Windows with git fo=
r windows, but the problem should apply for other platforms. The version of=
 my git is 2.47.

I prepare two files, I run GNU diff =C2=A0--unified=3D2147483647 1.txt 2.tx=
t, the output is correct. Then I run git diff with --unified=3D2147483647, =
the context of the second hunk is repeated, which is unexpected.

I investigated it and found the repetition is due to an overflow issue in =
=C2=A0 xdiff/xemit.c.


> xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg){
> xdchange_t *xch, *xchp, *lxch;
> long max_common =3D 2 * xecfg->ctxlen + xecfg->interhunkctxlen;=C2=A0 <- =
----
> ...
> }


The documentation https://git-scm.com/docs/git-diff doesn't say the range o=
f --unified. Even if its max value is INT_MAX, 2147483647 is in the range.

Can you guys clarify the correct range of --unified? If my value 2147483647=
 is in range, git diff should output a diff without the strange repetition.=
 Please fix it.



