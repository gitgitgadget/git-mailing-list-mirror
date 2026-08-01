Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232930567D
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572476; cv=none; b=Aus1sLvSwIIClkEomLx6FnClOK++RjdHw3+VZmZd0U1p3Uetm8wiHXMllM8nLYs59Iubu5Li689GqRdJeK9xa9jDI8A2qUP7/2uvApEbBMVWdC09iC8hB+8Tt2upeSaNaJBJL0IUiU5MjVd8aA+7TUHKpOR5unQAivVGUq8nw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572476; c=relaxed/simple;
	bh=Kgktd/LDF2vQscbQD51z7Jr5si6G2NspVSNilsAzCAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vbk329MmutMLGK4zdBBLLkQLr4QSuTX/jS2wc2bqqnwHjIjW8zzxvX9Oc5kyqbS8JQLni/iWD8MgpN8KiEvFWDGp+vVsq6h952i8tbH7K3DWNsoxL3bMY68r09Ew6KL6HZzZktWgkATangA6POHGqN1jt6gyRCTcmiMWdO29FSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Fte1vKzO; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Fte1vKzO"
Received: from cixi.localnet (unknown [IPv6:2a01:e0a:b3f:5350:b6e:bf81:919d:c0f3])
	(Authenticated sender: tnemeth@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id A396C13F88D;
	Sat,  1 Aug 2026 10:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785572470;
	bh=Kgktd/LDF2vQscbQD51z7Jr5si6G2NspVSNilsAzCAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fte1vKzOleeiLUETBhP5OGbKijiwvcP3oq/cF6j8ge4FfB0vC3bjY7YSWHd40q1uk
	 exIWGBihE7TA6D2mQb2ZJ0Sxy35CHlU/eIUMM/vNA8BsNWSYW8QH0W+7tcOBJH5xqC
	 a5MLEuZHsjSYhOIx2gW/6Y/XjljpoqOlNMbDXGMsZlB0qlfhukGXaRu5XWB+baQb/y
	 4JX8DB93wRHluTH7rSfEQhKwmHjuTD5fCFv/7ryHZXN8kx0tHIULb9cW7D7Rsgu/cg
	 GHw1aUdawL3d7gIoumoxwX3Fdk4nFyhaNQAarYohWPqKuv1QXGsKQUy0j/xMU8F2dh
	 ikWqyGPMBNzKA==
From: Thomas Nemeth <tnemeth@free.fr>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
Date: Sat, 01 Aug 2026 10:21:08 +0200
Message-ID: <2851117.mvXUDI8C0e@cixi>
Organization: =?UTF-8?B?ZMOpc29yZ2FuaXPDqWU=?=
In-Reply-To: <xmqq33wzc7uy.fsf@gitster.g>
References:
 <6022080.DvuYhMxLoT@cixi> <d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org>
 <xmqq33wzc7uy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le vendredi 31 juillet 2026, 20:49 Junio C Hamano a =C3=A9crit :
> Johannes Sixt <j6t@kdbg.org> writes:
[...]
> >>     Would it be possible to have a configuration option to avoid
> >>     warnings
> >>     (because I see that as a warning) about trailing blank lines ?
[...]
> > That said, are you looking to disable blank-at-eof from
> > core.whitespace? Collect all "enabled by default" except this one
> > from [*].
>=20
> Ah, if "I want a configuration that does not complain when it sees
> any number (including zero) of blank lines" is what is asked for,
> then yes, 'blank-at-eof' would be sufficient.

    \o/

    Thanks to you all :)

=2D-=20
Thomas.


