Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA96339361
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524017; cv=none; b=UJoFm1ZuhuPVOXTIr57bPegWB802Qc96HzhToRzJpdR1qaoqBHgkhTQlyGwFTqoMe54hHT4WJKnYXB7ye8doppSJXsVdM+918fo0zxpXqpeCpzL++lcHXNw0LSC2OJvOAr3QQ0X4PNFYhMX/VTjqujwwEnHMv83V1BHSrccy/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524017; c=relaxed/simple;
	bh=z8gAXzsjiYuwEvy2X3pbY3xT2+f2t99yWuM/YIPdRrw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fqlzrQizabWQJfbtZMAf7PLeu7H5S6XMccTnntDiZBuHX2rhOYl4nRO4fJqutUDFqAvpWxAsEB9t216/oF6gqGG+SnyOd9r/tdGPNDEWbIUJf3XOePmur9+/tDWNPNXpvN6aXHEN7yW5iS9W/H2j2LGQ0TLtN490ECs5+F8mLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HOgE6GDr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HOgE6GDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786524010; x=1787128810;
	i=johannes.schindelin@gmx.de;
	bh=rVFWhHzmeESXpr19d73c02yF9ifDl35SNs+BK4QV0Nk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HOgE6GDrM/tIaovyVsqXdv73YmeyflUpJV6/QEMA42Bd328WWSbmvVkCTVyLAGPM
	 yUhI6dhxmSYQGiex6lPothG9E024mX5ScKnBbwGNjc7Tc36BbjRBkYEFlU9e/DJFB
	 I5kNErLzy8A+9gPme/B2SvsGvB6YL2NXxCskOzYI78kdUGG8kOGulKmvq36GCIAgw
	 dR1uOJnNsMyCypMcdZBtaWOxp0yYYq9pn55rDxHABJMs31J/hCkegZQ3anMhT+y5r
	 Tk4MvmJCl5RUkH8ngAzql6w5jVmwdvW4sgNq7N1JcWVyon/JIVPGBjioK8LqIyMeY
	 2tdtt8HFKZxEBovh2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1wM0He1evM-00RGhR; Wed, 12
 Aug 2026 10:40:10 +0200
Date: Wed, 12 Aug 2026 10:40:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <xmqq8q6ih924.fsf@gitster.g>
Message-ID: <21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de>
References: <xmqq8q6ih924.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:4BzLNoiTFckT3bUiD5PR3mtR2gEyYM4KaGF4Tl01OhRVDRW89De
 FVRcz2ihxPp1WtWMuOpbpLWn3/maxTh81i6V90486BvHZNKcshg2lNI2+zBOSmCg7vqmXdh
 uy8Bud4ImnsvFJ+KqUdw0NS3JsdU4gSR7ZMVv9d8yBFIDTJtM04hzmdzIiDc/niU44ul53p
 YY18ayqrWdyu33+iYTdIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x2BSz0b7SII=;lRKtz0WMfSDsyGOM/L/ZwS8N5KD
 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
 8Z+pAWK+Gkqu82MA==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 6 Aug 2026, Junio C Hamano wrote:

> I am doing more "git checkout -p" (selective revert of local changes
> out of the working tree files) these days, as well as "git add -p"
> (selective adding of local changes to the index), and what I often
> wish is to have _both_ as possible options in a single session.
> That is, the local changes in my working tree often fall into three
> categories.  (1) One that is clearly good, (2) one that is good but
> not yet ready, and (3) one that is bogus and should be discarded.
>=20
> "git checkout -p" is a way that is very suitable for (3), while "git
> add -p" is a way to deal with (1).  To (2), I say "no" in "git add
> -p", but there is no easy way from "git add -p" to say that the hunk
> is (3).
>=20
> My current workaround is not to use "git checkout -p" and instead
> (e)dit an undesirable hunk into a no-op hunk.  This is serviceable,
> but with two caveats:
>=20
>  - The underlying 'apply' machinery does not see a truly no-op,
>    context-only hunk.  You'd need to pretend removing an existing
>    line and adding the same line back.
>=20
>  - (e)dit applies the edited hunk right away without giving the user
>    a chance to proofread and approve or reedit.

I, too, often find myself in exactly that kind of need. That's why I was
*so* disappointed when
https://lore.kernel.org/git/20260325075055.354709-1-luizedc1@gmail.com/
was shot down unceremoniously. I still think that would be a good
addition. I even opened https://github.com/gitgitgadget/git/issues/1828
and sketched
https://github.com/git/git/compare/master...dscho:git:add-p-stash-mode to
the same extent.

Maybe it is time to revisit that verdict, and see whether there is really
no way to accept that clearly needed functionality.

Ciao,
Johannes
