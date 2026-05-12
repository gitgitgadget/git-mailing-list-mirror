Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAED3A7F57
	for <git@vger.kernel.org>; Tue, 12 May 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576581; cv=none; b=q3lLGcGHi4mSviNxAxKpWbyWuCK/juLqu7s/+oQ4yYum8JDdVeNRqabdP80ambrPxuBAq7HNvg7blOaUbyE6ylqYTdV+040lAvnOX3xQ9je9p1xMh+Bq4bkSvkr2j4lwNbP1RIxXfEL8hM8ShddoBVh4jGgAk3meVi/i+JESjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576581; c=relaxed/simple;
	bh=0Rq5dAx2StWi0Tu5r3yXoiK8oIC27usvp+RK4YpLiC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq50eYAYtZANS715/asBpv9qy09vRpT14FkXcsga8K/jvVhgYS27WF/SNj4WJZJMQQqKmDBm6vcfDVeq3OSPPd1yJE49RW1U3K47zFfW63YTeXeJxQxo/jMiCIgmIxWQ7Qn7xUm0xP9kQCLXenhxRjQwUt+ns4bC+SNZrsMQhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HOqGmbBj; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HOqGmbBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778576575; x=1779181375; i=tboegi@web.de;
	bh=79uE4y4n98D5TY0nNa/nrwpYvEftNxXgGIby2pkbx54=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HOqGmbBjDRl1/fdFO0OxGix7jgLjiZIsThZ9ugyzD86w5/bNg16bdXXkPtOsCTlh
	 4PmMe2NazVGJAvLu8AT77S+GdwhLaV6Lf6Q18AlQ/GET2eVeoddyuNJfJahriilNv
	 buLCn3X2eps/iJVAz6UNslxTKebUXpBzFwkXEQqtLxaE936mUUZWnt2P4hshBA/8t
	 zKehSsiIytMfR7vE/VHsbRrmPX674Qv+Iav3JsoE99ABMGfhgodNw/sJudCRyEk2I
	 /DIhS1u+XZ7JEQr7F1TkUSEuVsNiGpv0acLBXBdAjNaBWUwJcAKd/YrVG8Bj6vWD9
	 i+Xenew3oc+vTyVVoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1wR8m72EG8-00EckZ; Tue, 12
 May 2026 10:57:35 +0200
Date: Tue, 12 May 2026 10:57:34 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>,
	Matheus Moreira via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
Message-ID: <20260512085734.GA26769@tb-raspi4>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
 <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
 <20260503172838.GA22957@tb-raspi4>
 <6c0a1601cd379bcdc87b4fe3b854166a@matheusmoreira.com>
 <xmqqjyt9p9pk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyt9p9pk.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:OQohWHHfzovsy9NCOsbnlPUuI/5Q/EBfGsj0XVkRF2CJbu3xnx4
 Lhf8wxHFCwFuHQKoa0wM4clfMM2soC6TJlE1RAySbmy8rIvNQwSKUwhH0cl5fEKxngxj5fY
 qVaIzvIUBlTjyyjePl7yn5RTiAjIMhZKoj5WahtsJvS3PkD+uXd/9NvRaXdggLOPRFi6uyw
 /MwwCSsmMCIrxvvd8pT1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dzkYX87nnig=;c6i73+2muBEtr4e0QeY5j0R0vwY
 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
 A2
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:50:47PM +0900, Junio C Hamano wrote:
> Matheus Afonso Martins Moreira <matheus@matheusmoreira.com> writes:
>=20
> >> Reviewers comment: Nicely done.
> >
> > Thank you!
> >
> >> More a question to myself, may be, about t9904 (and may be other part=
s)
> >> I have in mind that the parser learned to handle
> >>
> >> file://server/share/repo
> >> correctly under Windows.
> >> I don't know if this needs to be addressed here or in a follow-up com=
mit ?
> >
> > I'd be happy to revisit this in a follow-up. It's been a while
> > since I used MSYS but I do remember the fact it rewrites paths
> > internally. I wasn't sure how to handle it properly in the tests.
>=20
> So the only potential thing that is missing from the series is the
> above, which we are fine to postpone in a follow-up series?  I think
> that is a good stopping point.  Given that this command is new, it
> is fine that it has known and documented short-comings that will be
> improved (of course on the other hand, we are not in any urgent need
> for this new command, so we do not have to ship it half-baked).
>=20
> Is everybody happy with the patches in the current shape and should
> I mark it for 'next'?
>=20
> Thanks.
>=20
I am happy with merging to next.
