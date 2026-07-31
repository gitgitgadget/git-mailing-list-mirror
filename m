Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEC3CC324
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498623; cv=none; b=J16tkeuTu4jqa4WkOF2YZwRXJxnY6XLabSI9mxxq+7yCeG2glkvQ1dwXYF8OLyxSh1MLRdP32avjiv7HrEt2hoL29nVYZnnYnPaA1LsGw1/hZ6GibAahlfYbq8hNyRaT3Ps3xg7jsdqSG5AZDTChp6lhHecv4+zNdYJzwuu3hLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498623; c=relaxed/simple;
	bh=jdbqq1B4UG/akHpJT6kgN3DDulaoNNcIXAZY2QI+kIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF+OowljRCfoHiAS4R+Jt5kxde8nddnKbNcUgS+6jb63Ef/RrqgR6nYpGS72sB7/k+UQLZx2aEhpH+ykSoHupvF8C5fIA6tQyPNcPXJL6pxrfXD/e10z4mgCth1vDFJmoRAJXT4+2EI1x9FRuEioIgz8p8kn4E9URA0SbcyRdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=dhy8fxG6; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="dhy8fxG6"
Received: from cixi.localnet (unknown [IPv6:2a01:e0a:b3f:5350:b6e:bf81:919d:c0f3])
	(Authenticated sender: tnemeth@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 61AF413F861;
	Fri, 31 Jul 2026 13:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785498618;
	bh=jdbqq1B4UG/akHpJT6kgN3DDulaoNNcIXAZY2QI+kIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhy8fxG6XMyq0gFNHRp3DIiMXrHHFkxEMKJ5Pp17GSBDRLoU9uJXTVmO3Y8ayjghX
	 xPNZNF8R+0A8OAJmLlFyo8NtITc2J2q8LFGBBCQ/PpeXSfbPMPBTWOSLzqvIgcIqGh
	 bQqCfCiUMGVKDAJKiwTq5wswDvlgJYUVsvMkwqA8XYRvDgATPR74r4Vbq03iXj1dw0
	 KwylnU/m7ssp+WH0x9/cs4M8IfrAATq/VI85xm6sfgGa0jbRnDBa1nVelCCyGvDC4/
	 0y1LH/HWePSlMbmhKoGvAMWf6jfkNprrpxb/Cx78gL0p58oKuERqt0H06wYuK5avgk
	 y9CcxQPMKHj4w==
From: Thomas Nemeth <tnemeth@free.fr>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
Date: Fri, 31 Jul 2026 13:50:17 +0200
Message-ID: <5097209.GXAFRqVoOG@cixi>
Organization: =?UTF-8?B?ZMOpc29yZ2FuaXPDqWU=?=
In-Reply-To: <d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org>
References:
 <6022080.DvuYhMxLoT@cixi> <d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le vendredi 31 juillet 2026, 13:08 Johannes Sixt a =C3=A9crit :
> Am 31.07.26 um 12:19 schrieb Thomas Nemeth:
> >     I have the habit to keep 1 blank line at the end of my files. To
> >     me,
> >     it eases the EOF modifications (selecting code blocks, pasting
> >     them)
> >     in vim.
>=20
> (Call this is [x].)
>=20
> >     Would it be possible to have a configuration option to avoid
> >     warnings
> >     (because I see that as a warning) about trailing blank lines ?
>=20
> Hearing the first time that an extra blank line at EOF is necessary or
> useful. Would the correct question then perhaps be: how do you all

    I wouldn't say necessary, of course. It's -- at least -- my
    preference. For _my_ use case, it's useful. When I move code
    around, and that code is at the end of the file or to be put
    at the end of the file, I find it easier to already have a
    blank line there. That is... Because that's how I use vim to
    code.


> handle [x] without an extra blank line at EOF?
>=20
> That said, are you looking to disable blank-at-eof from core.whitespace?
> Collect all "enabled by default" except this one from [*].
>=20
> [*]
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-corewhi
> tespace

    -_-;
    indeed.

    ```
    git config --global core.whitespace "-blank-at-eof"
    ```

=2D-=20
Thomas.


