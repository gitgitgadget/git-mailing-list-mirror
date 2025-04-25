Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6123F296
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574727; cv=none; b=R8qZl/+88WPEBAvFqLwC2aFTuSZ7vK9sx3NhZU75ElYpllVUJxT3e7M38p9b3wDk4q8zeJHDjS2aeW90Ne/dThOgSReEIZLwS61OEaFyXAVTq7Z4GlYCWypMFYM2inLkzHS/W8HJJUfV/egOWS9H1c3tyMi2naYiQLulfhYlSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574727; c=relaxed/simple;
	bh=6ey0mYThLQd2KejaiN2pUOQ06td3McialPrfYqLAEKE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qIkF/74t7MyVJNaBkjGRB6+gvLeh69r+pEWLaaxq3A9QTRUlfYgAhpHH9mYD75xnratoqb9I5rEVgj5M2O634re0qGrV1kvvSLkfmu2twFohDfu9ISWVrc6CqhJHFLp1QuBfbyuS9OYGbiFhIpsymLH9TRGcwj5RMGETfiVq4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NdPVIjZX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NdPVIjZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745574714; x=1746179514;
	i=johannes.schindelin@gmx.de;
	bh=zn8Vqaevt0YHdm60aw50lDB0O0vxKlMVQYXZ7z3+ySQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NdPVIjZXvk7sFjitm5N9QoWzFz217FYh+mX4mSWHwVtDDzqdAxwXW43uq44h9inK
	 zOfzvCUCEyeRaDPEUvqoaT7UlGhasDfJoHtotWCkSARmWlHbtKELXEX0yDCsxtcr5
	 vv4RNgkrHOgQArSnrctaf90Sb7ZNhRgkMEHS4cO82o1k/n809hGBjPa8+DYmtZOrO
	 9gNy6UNikFjZoUV3rJG+eFNQPgT5mJ3if46Y7hi09XWSYK/fh0+4ntj3wcc2y3iyN
	 oLR3fD7H4D1evdG4qDeL0ztMrHGOnlBfv6cFm1Pxx1/hJuny8Ri+VmneTIyo+MTub
	 nqvDycOG7DblRnVzNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.52]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1v1ZKP0HuB-00tlKI; Fri, 25
 Apr 2025 11:51:54 +0200
Date: Fri, 25 Apr 2025 11:51:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, gitster@pobox.com, peff@peff.net, 
    Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <aAtZuU6Qqfag6OHj@pks.im>
Message-ID: <118698a1-33f8-36b5-c7c6-ed44b9e30d5d@gmx.de>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com> <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com> <aAsQwSfr-YvS2Mvh@pks.im> <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de> <aAtZuU6Qqfag6OHj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aacg/U89gKfCexfWrDlVL+Dveq2BS6/7zKeUIXpimvfZcrRpend
 volIe7m3wEx1+mla8vOjS0MazTJSv+HyijIj2fDRvyBSVRSZrysmhtMFFKU/yb8AXoQ69Wu
 Zi3OzUh38n/C68vTlwKaeSQHJJgJ3zlS1rekB3mIkwclpx8bS1Zkq/ZauOEgLZ/mrHQAB1P
 qGPuhs7IPhuA+36N/bq/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:75pE0SZ9Ro0=;pVGHLup4pshMtPK54ghR2pdoFS+
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 25 Apr 2025, Patrick Steinhardt wrote:

> On Fri, Apr 25, 2025 at 11:34:01AM +0200, Johannes Schindelin wrote:
> >=20
> > On Fri, 25 Apr 2025, Patrick Steinhardt wrote:
> >=20
> > > On Wed, Apr 23, 2025 at 05:40:02PM +0000, Derrick Stolee via GitGitG=
adget wrote:
> > > > diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-delt=
as.c
> > > > new file mode 100644
> > > > index 00000000000..db7d1c3cd1f
> > > > --- /dev/null
> > > > +++ b/t/helper/test-pack-deltas.c
> > > > @@ -0,0 +1,140 @@
> > > [snip]
> > > > +int cmd__pack_deltas(int argc, const char **argv)
> > > > +{
> > > > +	int N;
> > > > +	struct hashfile *f;
> > > > +	struct strbuf line =3D STRBUF_INIT;
> > > > +
> > > > +	if (argc !=3D 2) {
> > > > +		usage(usage_str);
> > > > +		return -1;
> > > > +	}
> > > > +
> > > > +	N =3D atoi(argv[1]);
> > >=20
> > > Is there a reason why we don't use `parse_options()` here? It might =
make
> > > this tool easier to use and extend going forward, and we wouldn't ha=
ve
> > > to care about invalid arguments. Right now, we silently accept a
> > > non-integer argument and do the wrong thing.
> >=20
> > I think that `parse_options()` would be overkill here because:
> >=20
> > - This is a _mandatory_ argument, not an optional one.
> >=20
> > - The required data type is `uint32_t`, and `parse_options()` has no
> >   support for that.
>=20
> Support for that has been merged just this week via 2bc5414c411 (Merge
> branch 'ps/parse-options-integers', 2025-04-24).

That's too new for me to be useful, as I have to work on top of v2.49.0
(see https://github.com/microsoft/git/pull/745).

> > But you do have a good point in that we may want to validate the data =
type
> > (even if technically, this is not a user-facing program, it's a test
> > helper that is used under tight control by Git's own test suite).
> >=20
> > Consequently, I would suggest this fixup instead:
>=20
> But in any case, I'd be equally fine with your suggestion.

Thanks!
Johannes
