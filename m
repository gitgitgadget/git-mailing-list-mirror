Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FF21A443
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750366529; cv=none; b=ISYFUaHZVpFL+4x1s0Xb6XrgE8fCEpPjUovJqaGCIOo+ugLE+GXexS3EZNDvjlXqt08oMPFjz4L+6F0MfiktzwUaLUkVF9VNfXx95CxlZOSxSSgGd+ok1eNvOQd0Hg8gsYv1svEytly9i7GT5Fex5JDDhFnl8cKuN35MJq/ZMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750366529; c=relaxed/simple;
	bh=RywnX5QsLSKNn9jRPtdpo3bf7e1ln0YwAGlJyc4Ww2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If+3l3LJ93szAvao/J6mGnH2MO2ozSO0KeJBmjfzaB+Iv2ZB4ETutcbg2ITv2cjqr9z/1rPuqK/Ti4WS8LvzkuCPEXOmht00wDoO6mH2Pf0E/OizWyrT1e20RTg8yFanAQxPvj4rPB6bq4JuvB6ECgFTwUJIjAzj+WSiqjWKC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XhNNA4HH; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XhNNA4HH"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:7da4:fda3:31ce:17c])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id D7317780507;
	Thu, 19 Jun 2025 22:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1750366525;
	bh=RywnX5QsLSKNn9jRPtdpo3bf7e1ln0YwAGlJyc4Ww2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhNNA4HH4i4aIcLPu22aYhXJBAZpT5P6tBfLipANlPeMH4WHunvoE1Xo8qvoieapE
	 x3nnduIPTokp/0Kn4lRACyy3Xiu9h8drn2YISMKXpF6oEp3lXkRM1s7gFqvVg2toJt
	 yeiTtw63tmAidx5CDzFcBQ5E/FEujOB94uOIlTUVSsr6sRJjXi8zAA/SjxsgEJGoa7
	 rnl72u4800xay67tvt5nWyVVCmSX1c5y6iRiOzaE5ijPLu3PTI2kmRZFmWLjgkbcee
	 +iLxd9ozgObeIaAEx6FRoqddat6JB/y9cx/fSjWRI7LxIRtHealorelxDre48T1zbh
	 2gm6J3H/r4xrw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH 2/9] doc: git-log convert rev-list-description  to new doc format
Date: Thu, 19 Jun 2025 22:55:22 +0200
Message-ID: <4658957.LvFx2qVVIh@cayenne>
In-Reply-To: <xmqqh60ccymk.fsf@gitster.g>
References:
 <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <ff22d0f1adf823ea3baf3ad3ddbf25add1187ce6.1749373787.git.gitgitgadget@gmail.com>
 <xmqqh60ccymk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 19 June 2025 03:24:03 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > -A special notation "'<commit1>'..'<commit2>'" can be used as a
> > -short-hand for "^'<commit1>' '<commit2>'". For example, either of
> > +A special notation "`<commit1>..<commit2>`" can be used as a
> > +short-hand for "`^<commit1> <commit2>`". For example, either of
>=20
> It didn't look like there are huge differences in the rendered
> output with this change (and the below hunk) ...
>=20
> >  the following may be used interchangeably:
> > =20
> >  ifdef::git-rev-list[]
> >=20
> > @@ -43,7 +43,7 @@ $ git log HEAD ^origin
> >=20
> >  -----------------------------------------------------------------------
> >  endif::git-log[]
> >=20
> > -Another special notation is "'<commit1>'...'<commit2>'" which is useful
> > +Another special notation is "`<commit1>...<commit2>`" which is useful
>=20
> ... or without, but semantically the updated one of course is more
> correct ;-)

I have a special setup where bold and italic are rendered as colors in the=
=20
manpages, red for bold, green for italic. The dots turn red with this chang=
e.



