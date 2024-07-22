Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704826ADB
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641110; cv=none; b=C4NLPAlr9rifL/jIqi3uyMxwyJZmwTN3xYus1nDDzATKTz/cY8gHFw0yoV78jSpdRVsk22exvSyBaIcVCjUyJtiAscevGpCM5veOfzKnIl9vVe90nyaj8u2F4sKoYuj7SQR4trd9hoAbFQFmTQFDo9olRjlm26SKoe6OiozVPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641110; c=relaxed/simple;
	bh=odMwNhRPKEjeKJYNbgtYjPSBmLpELBFYmR+5IDBcPsU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u4nFwltLAnTq7AVTiPak+6QMsnBufkKkcQSyPB6C/D8IUVUdPmBGoIANmO+/vYzoSwaw+s7p12qpB5bgauN7OA8vEV2cCuSIWETkxbTGvQKHn6HHGM3pmX5s5HXk8OPIGioqkP4PMqKtdupbt9ule6W3ZfB9eQvJB+U/5Xkkh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BtqzWHd9; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BtqzWHd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721641102; x=1722245902;
	i=johannes.schindelin@gmx.de;
	bh=odMwNhRPKEjeKJYNbgtYjPSBmLpELBFYmR+5IDBcPsU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BtqzWHd9oGslrbACHBYRYEq8cf76Ey/9uuBAWS7J3hTlmRCjPmkCsa6Jdyqk0taV
	 1+28RbGVgaMF9dYqhcFOmIjiekMbfQ7rYL9Q4iymkuDr6z7aWoDDjraY+GNU9LzyZ
	 WH19jw9k6iznsNZX98La5PKUH1u6h6fuCQQkPVKfSN/2WJ9BztBjj/LWRndS5tsQU
	 HhHRAwGAPgYPFQYsIrBjS1SmVr/raD+lwZtyNefCJK0/h3VauDvEJpf3T1Dd0FrjR
	 75HxzqJkW2clnBZ9/4bzDZEtFnLgEL0vKahZaKKm54bkNuL+WKral5AB9swuUD0r6
	 /lwgiVTImRGGSdj8FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.58.232]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1sRRmf3kA4-00HAJ5; Mon, 22
 Jul 2024 11:38:21 +0200
Date: Mon, 22 Jul 2024 11:38:21 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dragan Simic <dsimic@manjaro.org>
cc: Junio C Hamano <gitster@pobox.com>, 
    "Schoonderwaldt, Michel" <michel.schoonderwaldt@sittard-geleen.nl>, 
    git@vger.kernel.org, git-security@googlegroups.com
Subject: Re: Request to Update OpenSSH Version in Git due to Security
 Vulnerabilities (CVE-2006-5051, CVE-2024-6387
In-Reply-To: <25ce4ec25b054cfbf4c540663c6b6c18@manjaro.org>
Message-ID: <a658fd0a-59bd-c162-874c-cc5b9926acd5@gmx.de>
References: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com> <ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de> <xmqqa5ipxjdr.fsf@gitster.g> <25ce4ec25b054cfbf4c540663c6b6c18@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gd+EFQoxWa+uX0FLspDPY0ck+V74kxn3XqksWg4K0lucjT4Ol20
 cKNfUnsNTfQOA9eOo6q+mQuIezuQ+ILtDoxdU+AiZ2a3DbzXRrzh5D/5pb8KsCzd/2qzy8c
 0nCzPQ/ZQCL34fgX8odi5en0dIQ/N5psmMKLj2S77mbhpWQ/w8AxPut0OERovsGlTECQICk
 29PKDQEfQ2ozXM4gmHntA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JFs2ElyPhbc=;fl78nabMJHG4Jf4qljcEoPxwMr0
 FlY17q0njS+bpS6/v4kbbCrH0QuaJ1qb4s9GAktkFuf0oERXaGoNwufwLhMONDPoLv9L3yLUt
 T3eKf3ud/pnbgk48mpYKNGYl2NMZtPQQi9QxbgPGRBSsAi8ZUD31Ul71Nn1iIMyZ+kbK+7erD
 Kvg81p4295FfHDjDyMDMqSclMrn3xzCwMPt9uT1lB9LZFlH/ArptJJ0nJY0Dmviu4EGpNEVlt
 jrlHP5oYjdQYRhtcEYrsXJtNH1toB2Omjnj07w7c+OZ/dArV9dDXl892Q0CPhrH9Y2rYkzIym
 yhDww/u1AuH80iYofjXc7LWpATfvZWalfhtMDlznwn+NwbQ9OmUK1sAP4eXhUKzx4CMoxsJR5
 Adn6kFZQvdLgxGTZYgRFWpRTf6LwgYnh7TRX97Ggveqt3apoFGu1ttctWszyM/+5wpebG5ILT
 FZMQDKMSLfgPP+8L92U9bxSAOzxJnbAIt+DrS61nCkxaPqSR4kwyUxkAJfjBPGu2GOjM6Nh6O
 AM5lMND0QIdfdQphbZdY/nnW4fF8UNsFqdslOu683Vl1g3Tkl4zSqJ+tREzRfGunND1MvZUaa
 TefIpi4JfT6/5PtYqUolGQR9RGrAQhwccJ529DZXSu3XlNdLFtnDvdCfVx/wMjk08grG4zAIU
 Q9fbmOW+yAmPJbfC6QdJK9y7M370OwIxXUbgUNMCt0qQuNBH2fXQ0xbfVLsm0hYNPH16FUNz7
 QAlD8z63iBEChqlmei68WvKfyn86IdI0PqdOJl5XplE9ESB7fNnl/lDNoqmqxD39f2KuDssCD
 /QSzNnAHoH2BmsqYo4/hqEOQ==
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, 10 Jul 2024, 'Dragan Simic' via Git Security wrote:

> On 2024-07-10 19:10, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > The crucial part is the `sshd` part. Git for Windows does distribute=
 the
> > > `sshd.exe` binary, but it is in no way used by default, nor is there
> > > support how to set it up to run an SSH server.
> > >
> > > Git for Windows is therefore not affected by this vulnerability, and
> > > therefore it is not crucial to get a new version out as quickly as
> > > possible. See also my assessment at
> > > https://github.com/git-for-windows/git/issues/5031#issuecomment-2199=
722969
> >
> > I think I've seen in the past another inquiry about vulnerability
> > in OpenSSH, which turned out to be irrelevant in the context of Git
> > for Windows for this exact reason (i.e. "sshd" is problematic but
> > "ssh" is OK).
> >
> > Would it make future confusion like this less likely if you stopped
> > shipping the sshd and ship only the ssh client?
>
> Not shipping sshd.exe would make sense regardless of the associated secu=
rity
> issues, because it would prevent accidental enabling of SSH access.

There is little accidental about starting `sshd` after generating a valid
host key.

Having said that, `sshd` is not required to run Git, therefore it should
not be distributed with Git for Windows. This PR addresses that:
https://github.com/git-for-windows/build-extra/pull/571

Thank you,
Johannes
