Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A44219A8E
	for <git@vger.kernel.org>; Thu, 29 May 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748550819; cv=none; b=m2ACkc5IXVkezJe3XbGnEcBLRbPe50TFIhf8a8uv4Whqt7uoubvOK6N1MOWR0f/7dW2SnN1FVvcXEAxcAjbsn/hPE6bWizfdC0v5flXbF54OFaBAZ5WKusx1yg8LAV5VpJ3py/k4hW2DC1yvIRhhRk8NF9Bu3Yy5+NmOUb8CvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748550819; c=relaxed/simple;
	bh=ohea1KL9WldgIdiRZQOT21OefOLUWUtZffzMltt9+S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I96z2a4oeMHCZYSoqlo+vFGBBLNcCfUj7556ygMWZeL+uOtC1k8dPdf547PeyqwbT9TlgJ8/ieokERd9BAwR9A/PzYo+fcIZi0VszurHs0DXVeq+9LLxFVWSceT1exR6Jzu7lrLccRMJl1oLQo5Lexjvj4Tcy3x/tTWZqRuiQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GUP/os3S; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GUP/os3S"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 26CA413F86E;
	Thu, 29 May 2025 22:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1748550813;
	bh=ohea1KL9WldgIdiRZQOT21OefOLUWUtZffzMltt9+S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUP/os3S+zxq+L2Pev1C9j0+nyXj3C8oY3IPjWxdKzSLMsOvPvW0IrHEFLvU7qDtj
	 wdpMEj/VarlodOJy4lygv9g2q3DnFqny9uck/NByAiydCqJ3ncaBrf0kq/lt+Ohe3e
	 z2q0svRpq83BUbVLrz8TQPtjnfAs/mUCHrALwQKW8F7xQ2QuTyjZOVcsUkap4wvsZH
	 aCOsyx+qBcgkB2jwbl88W6eo0DkXLi1SSGHsPjVbEsRJYJQBBASZ8tsW5ZPYxWGW4c
	 mjRHmjONfvh/TkevQjoGGil4adxC2bqgsKYdYaVKJWrUeY+qpE+RjDfHV/kNlYa79t
	 GdnO7Mc3fyVWQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #08; Tue, 27)
Date: Thu, 29 May 2025 22:33:30 +0200
Message-ID: <12674032.O9o76ZdvQC@cayenne>
In-Reply-To: <xmqqzfewpf5f.fsf@gitster.g>
References:
 <xmqqfrgptv10.fsf@gitster.g> <12673686.O9o76ZdvQC@cayenne>
 <xmqqzfewpf5f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 29 May 2025 00:02:52 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
> > Junio, I haven't seen your series about git-verify-* and others=20
integrated.
> > Are there any remaining points to be fixed?
>=20
> Which ones?  These ...
>=20
> 88ce8dfe29 git-daemon doc: update mark-up of synopsis option descriptions
> 914c549ac1 git-{var,write-tree} docs: update mark-up of synopsis option
> descriptions 7e7f47a488 git-verify-* doc: update mark-up of synopsis opti=
on
> descriptions 20e4e9ad0b git-var doc: fix usage of $ENV_VAR vs ENV_VAR
>=20
> ... are part of v2.50.0-rc0~9

Yes, these ones. I wasn't up to date.

Thanks


