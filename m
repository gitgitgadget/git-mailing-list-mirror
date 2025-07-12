Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9AA59
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752317814; cv=none; b=czBIglJp9jHMmObitpmC8lQp9+3psXT51Fr6dHJaAqtBDv0dZpYb6LwY5+Hq+desXdlo8T1fVj9yLKeTZX3PFTtDrKZwDKN1GaAYiWzByb1P3s1C5QAX7U+nftmFQtQEwVcZuXN/VjW56qxJNZm3t71RvUaky52vwie9R0oLs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752317814; c=relaxed/simple;
	bh=9PF8vgNqWTmtmmZjL0R28Nk0AyRMylJA1qd4ATiUqes=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejVeYCjsFNzgXYCwWIlhBBoHTmLJw430MERIME8ZLot/CUSBqP7T9CMMwpAJvdK3vOSIaWH/Hg9UJ7EoDx27goLGArFLrjfOq834wxkPbRzE1Pe39fiGEggfHWTNms9qvPLy1wvcRHWayc8Gcu9mnT4EsbC4N12YFB5BviALAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=A5T8LSW4; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="A5T8LSW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1752317802; x=1752577002;
	bh=DWcE/73YRTrcOg1RRtxLDXqqv/WwcMCmettKNwXWNhQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=A5T8LSW4mxfF8e1qgItMeKkEAzAIURKYm4FBMQ8sc+K02StBHZEG1bBZUkT8uYgrs
	 MdxJsWxBvF11XBMNvXMHsA6LLQHjUfu78aMCAqz0gEjwF321bScQaYJoRK90h6nHkf
	 U28sqRw9BzizyqflsWGbkqT86OqY0TS9LweDJYbvBZN4CToPogXxsn40+c6stSE5vK
	 y22hZcbEs/ud/Uuy3sNzpLlnoIkGyABrqb2B0G+Zp6KeztysMfa3zh0cbnZvR0gwUA
	 bbJ+pNuhpQ5zKAim0oXtvFG4NAhVuVAgza6YVV6drDoKpocNvx0fzLXogj0TNSmu3Q
	 SisVlRqe5KKng==
Date: Sat, 12 Jul 2025 10:56:37 +0000
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
From: Jason Cho <jason11choca@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why doesn't git core.eol=lf work?
Message-ID: <hmmjz8ewCl8dl_K4NrydJHLRzLtjs8vGanKXkbJjDPgaaZvj9HzyzEkrY9WlciWgx0iNlcWPhwGpl1E2gxQkRpG_10KgmHDareAH7LQj33A=@proton.me>
In-Reply-To: <20250712103030.GA30568@tb-raspi4>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me> <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me> <20250712103030.GA30568@tb-raspi4>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 91ff1a40529ee9226635e6fbedc2100cfc50159e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> But now to the real stuff:
> It may be that your file had been commited with LF or mixed CRLF into the=
 repo.
> In this case will Git not change CRLF into LF at checkout.
> What does
> git ls-files --eol license_header.txt
> give you ?


$ git ls-files --eol license_header.txt
i/crlf  w/crlf  attr/                   license_header.txt


=20
> Beside that, I would recommend to set up a .gitatrributes file
> and add it to the repo.
> echo "* text=3Dauto" >.gitattributes
>=20
> git add --renormalize .
> git commit -m "Normalize line endings"

I am building a tool to analyze codebases, such as which function is moved =
from one file to another. Different line endings fail string equality.

Admittedly I can make a local commit to normalize all files. But it's best =
if a simple config `core.eol` can work.
