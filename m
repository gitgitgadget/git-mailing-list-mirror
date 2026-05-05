Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155133EF0D4
	for <git@vger.kernel.org>; Tue,  5 May 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014816; cv=none; b=H9EHhAcNBsaOmcEuLtlurRWShzPQKbR3dnEdhTZDKxuLtBV7q+SLzO/qO4IIZpXo2mRZod/DjA3FzSEmkAsriQ66j1gKOZoUelTnutldFJMwzcnOGebt6O60iuOEDIJcYia76Tifa/fLOzJk77hhIzNdLkI8fX3AKo2TAmw/0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014816; c=relaxed/simple;
	bh=Cq8BXn/ht697HBwH04YVn9PXGKeu0K5NXgesoMMzObg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZFXalv45XbcLvhXuljeVGz1YKnhVTOopYOnMtkhZzOZgQky6x3kwyPKBO+NGPkJlU+lr8sBcEHF/t2Rt0NmNa6kmKIGgEhRjb6huCgXxdJRRNkwmwzjH3pwDyftjr287wAxzv+R4pv2utp2kxkHc6I4k68A9xggkHsiNcOaBIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tr2Y2dwW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tr2Y2dwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778014811; x=1778619611;
	i=johannes.schindelin@gmx.de;
	bh=fEqSN0DIrdsOYcwF85U2pssVZSi6SlVuAjubgN9RakI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tr2Y2dwWzKhctt6aDFqvhFXuJxD2LKKmbxb6EupAhf9I83w8PQ6Pku+t5pz8L/LU
	 5heG63lMM4PPz+gzwcPRDoZJY7iw1d3rf6OqaOyJvw6YTMApzutOAdeTBzxoiC3vO
	 /ghD7XCL81/CN4Gnn10j605tMmXVdElh/N2T8I66qwIsoNjpgLImT35SoWi6Zr2J/
	 CSXa7X9OfhewrqHCZHbGaUgw6+yBpVhmuzpFwod1lKdLVjmyd4cI+FA3rd2dGtIwt
	 BrhXqtSNL7m3dTsYM52yJbgFdufewBHj/DskoOYHiMDGdETemMR0rMr0oBbwbmVO2
	 obVdYVE0Mxb0sbVtuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1vYgIl0KUY-00aLPd; Tue, 05
 May 2026 22:55:01 +0200
Date: Tue, 5 May 2026 22:54:59 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Derrick Stolee <stolee@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/11] test-tool synthesize: precompute pack for 4
 GiB + 1
In-Reply-To: <a382fcdf-a9c9-4caa-8be4-163c7bcbd64b@gmail.com>
Message-ID: <53431a2a-a0e8-1dd1-9ebd-cbaebc769a39@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com> <29b9a74e915e6200ac2b4d98e446c1e73964cbd2.1777914508.git.gitgitgadget@gmail.com> <a382fcdf-a9c9-4caa-8be4-163c7bcbd64b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uaxL00hYrrxJZQUPR1ReP8jFRF4M4Ew9BdCt4PCZ12XErncSnBN
 nhtz/xoMg9NisDB3DyFL9dni2dnXQWjzW2X/uVj83PsWfymOY00U6zL1QtlPead57wmREfS
 L7k4a6RPoFYCRhPlAQ4if0jdAe15XkNU9w8cO9krF1sD1CMhUnhthlrDpgP6va0Or+8Tt+H
 LF9GxFJeSf3pxDnWeyc7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f8qR1kYC9xQ=;VTl8zZ1+bPPgstGxC6xf4afBNei
 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
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Tue, 5 May 2026, Derrick Stolee wrote:

> On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> > Benchmarks generating a 4 GiB + 1 pack (3 runs each, SHA1DC on
> > x86_64):
> >=20
> >   generic path:   88s / 81s / 140s
> >   fast path:      14s / 13s / 15s
> >=20
> > On CI, where t5608 currently takes 200-850 seconds depending on the
> > job, the fast path cuts the pack-generation phase from minutes to
> > seconds, leaving only the clone operations themselves.
>=20
> Are these numbers accurate for the patch position in the series?

Unfortunately, yes.

> The previous change replaced SHA1DC with the unsafe version, which
> gained similar performance improvements. I'd be interested to see
> the numbers for both enabled at the same time.

The problem is that in many (most?) cases, the "unsafe" version is the
_same_ as the safe version, i.e. SHA1DC. Only the `linux-TEST-vars` job on
CI (and most notably, _not_ in the `win-*` jobs) has a fast "unsafe"
version by default. So if I build the revision as per the previous patch
on Windows, I get no performance benefit whatsoever. That's what my lament
about not being able to link OpenSSL was all about.

Ciao,
Johannes
