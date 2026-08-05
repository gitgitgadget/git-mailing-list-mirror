Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D538A722
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940072; cv=none; b=T1dWJnbnP/vBOZGji/V5gpBL3+mXJxqL+3RoHng1i0kkP+sB4ku9VZGxPHpTcDOyAibAjcn4AIO+4KiQAW4NqrMzfvaKZSKpfu7SrqP5LZtbYPXsRcewpKZhGQi9VpaXFxp4gioi6uC3VMe8HTHYWMuD56h7m7WUnoajmPHS7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940072; c=relaxed/simple;
	bh=wFuhK3QI6w7QIEqUJeFGrFaHa/lVHIVsB0RanW3f4wU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mXkdWARWb5OBrf8D8W1cBeHtZWvG3zotw3T6FQK/dwwf3wetR5PL0ndK2ND7iC1NTT6/EUERUtHrGqEEOGKBhiBGZdxhSx+yDch4JNA64CEOboi9N6TjXfJcyOg1JRJNRhY+I42M92fsj1FNIyNyYwsrTkPJiY9Bqn8YcISmbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=D33uQtOH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="D33uQtOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785940060; x=1786544860;
	i=johannes.schindelin@gmx.de;
	bh=g/mOU7WE/g/jWpt74WtGOTdmxxhWjPLQdi0uOHGfXxo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D33uQtOH8C0mQPOS01igprG2whkbRsXwqFFBEKrEv/EKUhspNJmQNuZ6SF+n9fhs
	 xFL2bE3/oBKyXp6lPlpX2unMnBLunill1xwqw6aggGkOJpFdYf0UUNlplLGQsvOMY
	 58GA2Y20y2TY8cs4itLXDNSilMwn6hBG9q2Hch8aX/tiZTGbj4sNKBHx/fi/ic1Pr
	 UznnIkMEBWr6yGGQzojNGZencX7evBDa5SrL1pNZXQ6mT9C2w+7kHDZqorwDwFZ4d
	 qNoiZ8w+aMrLGrvSAJiC9SoVjBkvXDjaOw7VkrzeP13bgUzAVdjIxhGtquNB/Qkqe
	 HNonKXUAeCd8UVqniA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhjF-1x4dIb02mf-00ySiQ; Wed, 05
 Aug 2026 16:27:40 +0200
Date: Wed, 5 Aug 2026 16:27:39 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 05/11] last-modified: handle repo_parse_commit()
 failures
In-Reply-To: <xmqqh5lui6wg.fsf@gitster.g>
Message-ID: <7e111d67-1e43-8a4c-d4a8-7ddd923e8083@gmx.de>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com> <f728be4dacb0b9781ef6589a0d2c48009aa31e9e.1784069325.git.gitgitgadget@gmail.com> <xmqqldbdqciy.fsf@gitster.g> <xmqqh5lui6wg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:r04FA9Vfja28PMggiQtlMQoQgML2rQgkm1eJkytGW6+6pSibF3G
 zwpxPmMlBf72cGDfh+bqWrPRlHp4Lk98feCaO+opgdPPm6xeZTbt2y86Js+PcAfG5i0OJ2f
 KScYhj7/R6DZBWMSCBvy5XEyfRaZrp2w8G5ZcrWTjyUt3jgl4AwMMmoidIe4gB+sudGthnQ
 uFX8fTv4XtNut2R/6D4Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tj27YGN0HDo=;BW3z8ZSgmRzAEPWoCg5gq2KhguI
 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
 vbfOiqmWCZkOdthu3lI=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 19 Jul 2026, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > ...
> >> -		repo_parse_commit(lm->rev.repo, c);
> >> +		if (repo_parse_commit(lm->rev.repo, c))
> >> +			continue;
> >
> > Shouldn't this be
> >
> > 			goto cleanup;
> >
> > instead?  'n' pulled out of not_queue may be unparseable and when we
> > ignore it, don't we still want to clean up the active_paths slab for
> > commit 'c'?

Correct.

Thanks,
Johannes

>=20
> --- >8 ---
> Subject: [PATCH] fixup! last-modified: handle repo_parse_commit() failur=
es
>=20
> https://lore.kernel.org/git/xmqqldbdqciy.fsf@gitster.g/
>=20
> 'n' pulled out of not_queue may be unparseable and when we ignore
> it, we still want to clean up the active_paths slab for commit 'c'.
>=20
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index fe012b0c2e..3846244dfc 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -416,7 +416,7 @@ static int last_modified_run(struct last_modified *l=
m)
>  		 * in the '--not' queue.
>  		 */
>  		if (repo_parse_commit(lm->rev.repo, c))
> -			continue;
> +			goto cleanup;
> =20
>  		while ((n =3D prio_queue_get(&not_queue))) {
>  			struct commit_list *np;
>=20
