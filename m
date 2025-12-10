Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848330146D
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384989; cv=none; b=Sa+Sggcs0tH7vhzyOuS6yB1q5NugSjf8NX5OXUNBxK8vDsVG0+03NHJcNA5CLHVZR9npE+1Qcr2twoD1KbIJi2bdUHFiJKmz1+L/9PYJvNb0PbTUGoBTfrIxHQq6ply2/2jiytobh0ca8rYajzf2O+Zi9iezY6XIzyXGVzzfJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384989; c=relaxed/simple;
	bh=t72EbDWhXdJoJ0B7S1Ha8wRGKt2aUhkIlH1Zp7rwbRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBvE2V2WoyGxPmQ3MSNg2p4j3M5JXdrJffEmIJgfOHZUCJtu1xL/U+BD2bQfkeAc3kC6OArd9pu2qMySVtaf9z2mOcNf3YpC52CponbgeVW+W1Tx+RUjgHXtdbYuvQjjwFr6zcW3YSSFaQlmxj8tAL3wU00qAXXYX/2Nk8fqA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=BKGf9uSv; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="BKGf9uSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765384977; x=1765989777; i=tboegi@web.de;
	bh=Z0ygdS/H1bStm1Mn0RrpyMzoovhHFsdDK5iBR25iaf0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BKGf9uSvVBthGhHgqJRUF1QfwTvOjahhZ3uFHam6hKfS6wpLiO4/6Ke+Ad/8IZPh
	 x8785vdzyfJHZ4YmdpK9EhRmIPW1VfeW0jvzXYudr6vVl5NmmGQyY23tGrAJwXvnI
	 Pz3gKZbM0U//7LeKySYGe3XhOncHj7b33tS+Gzg7IBQ9TBbhZWA/OBMQsTlIavzdi
	 iMRGBFh/3mUjjVTdklmDeb7ZXW6kZ+dsQZ3U3isl+zFROp5maCDLjYJe35Z/HmjSb
	 4DdCPbEdc+WV9oshBYph0kjYdnMe8MUvoF91fCrlG81PGxRYtjg2sOzJnnqVRQ5nm
	 cL+xh+9RDLLVirZeMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYX5-1wDFlI15WD-00rbtZ; Wed, 10
 Dec 2025 17:42:57 +0100
Date: Wed, 10 Dec 2025 17:42:56 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
Message-ID: <20251210164256.GA30949@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:jZYEtCEK3JPtXnu/L7Gf/C9BVInWwuCbRZSqCqjvsz3PIhvJ6WU
 Us/KQk/vc3un4gECSzZZRWIYoOZsqzbZtv6NVfdlpPfjKn2ymF9ZTRUVoz1s1p0JsDq05TH
 jPHCD6FencAHRcV9uvN3VtrRcwSfgcWsiIuYCsuOF2G9TnN34OrwGIndr2UqqdHab81M29N
 jL6t0DGZOpFLZQ//6ukOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VSo08ISTYYE=;2nNkNfxEaQahhV6FHL4YXSwI4LP
 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
 2NDqAZh1YznDBGyvLsyf2M43OPeVE

On Tue, Dec 09, 2025 at 08:35:34PM +0100, Ren=E9 Scharfe wrote:
> The library function iconv(3) supplied with macOS versions 15.7.2
> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
>=20
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>=20
> As a workaround, use libiconv from Homebrew, if available.
>=20
> Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  config.mak.uname | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index 1691c6ae6e..1b305e38c6 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -182,6 +182,13 @@ ifeq ($(uname_S),Darwin)
>          endif
>          endif
> =20
> +	ifeq ($(shell test -d /opt/homebrew/opt/libiconv/ && echo y),y)
> +		ICONVDIR ?=3D /opt/homebrew/opt/libiconv
> +	endif
> +	ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
> +		ICONVDIR ?=3D /usr/local/opt/libiconv
> +	endif
> +
>  	BASIC_LDFLAGS +=3D -framework CoreServices
>  endif
>  ifeq ($(uname_S),SunOS)
> --=20
> 2.52.0
>=20

(Probaly a stupid question:) Does libiconv from homebrew provide UTF-8-MAC=
 ?
And does t3910 pass ?

I just realized that I am building against libiconv from mac ports,
since years.
Digging into the Makefile shows that we have a switch:
NO_DARWIN_PORTS
(and another one for FINK)
Does it make sense to have a switch here as well ?

