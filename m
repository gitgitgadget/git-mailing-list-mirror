Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748F3FD141
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558410; cv=none; b=Md9kr4Tyqb4+Cmt/HjvaM9vqKdhAWKBdykGWJMfPrldg9a5/+r4KAfb9VdkZoSzIXwbQjx7ISu8CK6PnDWeZRoq61Y8MXTrRlXQtmZvmbWldrDpaefzJhVz2wr17z1KIq/9fDpuX7t6QWs33T13dm/gzbjx1n5AO4A3RN1Td0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558410; c=relaxed/simple;
	bh=4uLxIAfCVMN5C/KiVE9R32en/q0T87JpA3OcZYGFCNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGSDK0WNcStHR8SO472r/A28vIZ0JBodu2Oa993EUGBNyA/s89gmvgjHulAieInyMQo+DFQPv2W6SrAYctpu6coATSbheauFQSO4hJVj17Qw8b11MyFblJeh1IUw/eAUar/VzZr+IG00vBYpq5hIxWnVNR656hPGEi5Z+8AV5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=kvao6R2P; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="kvao6R2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777558400; x=1778163200; i=tboegi@web.de;
	bh=4uLxIAfCVMN5C/KiVE9R32en/q0T87JpA3OcZYGFCNQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kvao6R2PHhJLzFF68ohHVhAE/0CJc3fegNUKJ7siP4S3zVRYBP9Rd7164jfpKVJv
	 xSbWLYwVMrF2EMOR9wJY+4gLkHRkb5IIPFaiuHd6PlCaCVImMeTMuMxDo+ElB1bAc
	 2ARdrTIb2RCICh5WH1Be2mPbVDFf8bA5hwLzalBrsyJtJqla+A3+b0i6/581Iym9Z
	 PRX+Wk17hqpNb53J6zZC0Cg688XVTcJ1yt3EhomclLCi5f6wSPn7nsNnB9Uy8vc2t
	 NjAOrw3xd9m4oc76wXhJWWxNwiQJMUEVCoAyMHlV0mP7mEPr0CsaJwWuJB5XnSHna
	 kwvIH77PZCmCLQPPug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMpCS-1w1tEC3gBA-00NmPI; Thu, 30
 Apr 2026 16:13:20 +0200
Date: Thu, 30 Apr 2026 16:13:20 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/6] index-pack, unpack-objects: use size_t for object
 size
Message-ID: <20260430141320.GA6659@tb-raspi4>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777393580.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777393580.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:WGKT1XOW5w3LgxUAPqDbDmxrS7OYLpoRu3nxvmXOhYRp5TKHPfn
 cpwEwY3ujQ7ShJBpAzgYeA/ax+l7f9JOLH++nT5mg2Gj5HoSCtNH1CRY39UDuT0LPGTjKBX
 OFz+CTAF40sxd/6Ki0DnTJp2ZU2fsjv9y0QWL8ytK2a53Y+Y1DY1d1eD5hk5zeTcN3rhZvb
 NLWUGNX7pRk5QUW8q+DzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bF5MoUlhACI=;WpkW+6hJXLSEJYTLdPnJy5Cp/IK
 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
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 04:26:15PM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When unpacking objects from a packfile, the object size is decoded
> from a variable-length encoding. On platforms where unsigned long is
> 32-bit (such as Windows, even in 64-bit builds), the shift operation
> overflows when decoding sizes larger than 4GB. The result is a
> truncated size value, causing the unpacked object to be corrupted or
> rejected.
>=20
> Fix this by changing the size variable to size_t, which is 64-bit on
> 64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
> space.
>=20
> This was originally authored by LordKiRon <https://github.com/LordKiRon>=
,
> who preferred not to reveal their real name and therefore agreed that I
> take over authorship.

Good to see things moving forward.

See even
https://github.com/git-for-windows/git/pull/2179
which is probably obsolete soon.
