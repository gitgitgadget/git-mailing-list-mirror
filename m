Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759381EB19B
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470798; cv=none; b=Jo1kn00cvbxGKj8soomH8UUl6MaFUrE15CDWedGxlBxuZLO6HF1VxQ0G28QDqa6CvcSGnVCWDxgo2QayGMujzrwsIKnlWjt/5Vzoo6FvfJMlz2mmedNW3P7o3zrJKfGSQRLou03+IfyfkRJ3Tmh7SBfDeI/nxDEEZOwkybN3Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470798; c=relaxed/simple;
	bh=BuJfyl2IGIBVJHJfgADcbuE0JLlHoJRkLIeApo0bOG4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdTAN5IwL28E1ia5SEh1G/uybJmxN80grbUaILoXRxZKxeFmh35zsouUrtZcsCZxHC1Usi8qRUHtFos4n3unvXNirAYcHic/SliYSTLRCfcuTWyPmAVJuCLHJ1fRhQIkMwY0a/SI548YMvzn56bFVtDyEpLtWZj5wM0lMfoUDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X1tcRLwb; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X1tcRLwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=adsnzicee5dvtllsp2h52nevwi.protonmail; t=1765470793; x=1765729993;
	bh=BuJfyl2IGIBVJHJfgADcbuE0JLlHoJRkLIeApo0bOG4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X1tcRLwbrpVuoiPRDOB0H9/qEwHajtxdEEyPuejp090gZdS4QKugsHT/bNOjx+H4Y
	 TVOTTa6nL+nHrKe4MMSo9efxiyN5b+YVygjCAZGeB9qpTMfMSD9UKGPdWMx6ILjiqV
	 LQdox/Z3D6Ze5vDfThYPA1kezxs+bN0jAvB6jEQ5tcwoL6AzI5QeeNlXKNmu4Z8eOw
	 eLjnN5jNk4LFZ7ONu9CnTXGHgZRc3/HYiN/oyVxxVQAyVBh6dSSfZ33TBXkEH6C7xJ
	 sjY0X/q+NSVwv96BG0fUE/jHcrm8hJqZ2f9or2eDNrBhkFGz37OInXI9Bjycstjtdp
	 ++V8p1Asm9Bbw==
Date: Thu, 11 Dec 2025 16:33:08 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no commit history
Message-ID: <lVqXkS_Nc_hxtxMq3nevB6dCfPgh-qw9A6dLROQqGqN1_iqDONXeGQmp91hGmVTmaSIqGy5QVMC5OuzJmuULP-rUWcqBSv_L8pnLgPjoDsM=@proton.me>
In-Reply-To: <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org>
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me> <xmqqldj9g0pj.fsf@gitster.g> <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me> <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org>
Feedback-ID: 140350232:user:proton
X-Pm-Message-ID: f99d603622f1e94d3071df17a927ed231e24e085
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 11th, 2025 at 14:34, Johannes Sixt <j6t@kdbg.org> wro=
te:

> Am 11.12.25 um 12:53 schrieb Koutsouflakis Stefanos:
>=20
> > On Wed, Dec 10, 2025 at 10:24=E2=80=AFPM Junio C Hamano gitster@pobox.c=
om wrote:
> >=20
> > > The thinking has always been "'--hard' means what it says! HARD
> > > removes things harder than other modes---there is [no] need to add
> > > '--force' to it".
> >=20
> > I agree that "--hard" conveys serious intent. But I would argue
> > there is a meaningful difference between "lose your uncommitted
> > changes" and "lose your entire project".
> >=20
> > To be clear, I'm addressing a very narrow scenario:
> > the user has run init on an existing codebase, staged files
> > with git add, but has not yet made a first commit. Running
> > reset --hard at this point destroys the entire project
> > with no realistic recovery path. This is almost certainly
> > never intentional.
>=20
> I would argue that bad "tutorials" and "recipes" are to blame. I have
> seen far too many that casually suggest `git reset --hard` without
> warning and in an easy to copy-and-paste format.

Agreed. Many users copy-paste their way through Git or use commands
they don't fully understand. That's not the ideal way to interact with=20
Git, but they don't deserve do be punished.
=20
> That said, I have some sympathy for the case. Would it be palatable to
> have `git reset --hard` refuse to do anything if the destination tree is
> empty?
>=20
> -- Hannes

Good point. Checking for an empty destination tree seems to be
the better approach.=20
Refusing to proceed (without providing the option of bypassing=20
it with --force) also seems reasonable, maybe with a helpful=20
message explaining the reason.=20
On a second thought "--hard --force" is a bit redundant,=20
like "rm -rf --really-delete".

Thanks,
Stefanos
