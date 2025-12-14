Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3A19C566
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765719004; cv=none; b=NYVrI5q7DmxiX+Qn2Gz+Hg1aSRQ/dTtw/l1lc5viKRH14NfkzNIewfhmJzgxtstkXXz/s7x9sPXA5xd7epx13W6929pXI6q41x9qXdbpJYKFUrzZl5QuX3PJ7azoWZQcf225GmGR4Mx8tuvXYoe5iTRr/7sOU88UhWssr7ozMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765719004; c=relaxed/simple;
	bh=T6/9T2K1GPcrf4E9PYlw0isBNRVg3C70TSMK6NOsYrc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoXub+66GMfaZ0GTchUef7lMdPaxRVHnij5XAZ0j7/NCYlV473/UWxTFb02I2tdfEjG4iM7ZdXlrdtaYx/+gj1H+IfNFYLr1q2mBj2cVJV1IINqgkO94c3O/TBSQxqVGZCvnZ41mzsyBtYmbNHMroJt/uQDdHSleO3YH6jwm9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nrHxV+zu; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nrHxV+zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1765718997; x=1765978197;
	bh=GTbqbv/oP3Xwb2gSKgvo3EjoZ9EiY8GqtRWJxZ2rCzs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nrHxV+zuTptwLZQa5xZqnQQcz0xxmRXF11mjlYzWznElfz/7JW+lnW7jB+egoRAqB
	 AE82FWqzoHchizDH4fN2WTBsOjF2D+B8uMY9SIpFJgYFqvhzFLx6eVfbONxu3RT4wR
	 M+e1PXaIMDVn4qE8wsriWgM4/9Xzo2GAtxN0dA2XJiEN95grcI7zc8H4beeWi4xg4u
	 caM0Yk3qdrHfDS5PbG8fzBTcKatmt1b1zlRX/c8aDGwDe/1V+Setazpkj074MdFWIx
	 ctaOpTgYGOjK2EX+j0Q0ij+OYdAz3TqqkkLdNZwG2pQCTrCTVSvorBIXlSDefDzHIa
	 WYNniS9PQlPTw==
Date: Sun, 14 Dec 2025 13:29:54 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: Johannes Sixt <j6t@kdbg.org>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no commit history
Message-ID: <Ai2bA2Zt8bsexgQEIKg1vK7-SNNhTlsmmFp_gOJp8IKX9dJME7UC97EtqRhAUfD00sFmqRdHg9xgGW82rikrLIDUIswrUPr3RKm-LQgGuNY=@proton.me>
In-Reply-To: <xmqqzf7ocrhk.fsf@gitster.g>
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me> <xmqqldj9g0pj.fsf@gitster.g> <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me> <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org> <xmqqzf7ocrhk.fsf@gitster.g>
Feedback-ID: 140350232:user:proton
X-Pm-Message-ID: 2b26d453c9b2d59fd1167187569773c1ce97a29a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, December 12th, 2025 at 05:25, Junio C Hamano <gitster@pobox.com>=
 wrote:

> I doubt that special casing an empty tree would fly well.

I might be missing something, could you say more about=20
what makes this problematic?=20
If it is about breaking existing workflows: any script that=20
automates either of the two use-cases discussed would be relying=20
on behavior that is almost certainly unintended. Such scripts=20
would fail, but without data loss, and give authors a clear=20
signal to fix a likely bug.=20

> And I do not have any better ideas.  Other than just failing, that is.
> But that leads to nonsense combination "--hard --force", just as
> idiotic combination as "rm -f -i" :-/

There might be other ways to mitigate this, e.g.:
a) Refuse with a fatal error and hint the user
   to remove staged content with "git rm --cached -r ."
b) Autostash with a warning=20

Thanks,
Stefanos
