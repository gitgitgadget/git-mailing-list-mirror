Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DA40FDB6
	for <git@vger.kernel.org>; Fri,  8 May 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267404; cv=none; b=KH4WB8nCJDUG4qw9MLVEEDA9UOGgAPmnEA0eKaBtG58SmHFaTEwiDjJZCeLthdRQ4nljVSYB8V/S34XmXHjnPHSP3hDDsAbRytWkmY519FWFmPMkhBcY8OiUC60Eh19vSt3YNI1xazbArXsPY0T7pZMUhtPSadv8svfS4vUhw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267404; c=relaxed/simple;
	bh=ZZuqnZsr/C85SQpKqgQY/xY4PPQW3mjr2MI8qY/rQ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APdw8Ygqo6PekrIodrDsIqumA0rmvhaatJld/B3YEgTdrAOIIkwfEYmJBdz0FofF4cCGeHEL5MRzSTn6CAB2QSi73IGereaqg146hrqSS/Y2RIp9SXECF+nbBKIRD6MxhdmSY0goGOl9O3dTsP6j+pE8/dni7ThEu8eSHDQIzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=LFa8kqc5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="LFa8kqc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778267389; x=1778872189; i=tboegi@web.de;
	bh=kekvwnbisVnK1huE4m/WshD7BhWcpq4wJHf3jeqNVbY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LFa8kqc5Dlwpb4ABsFBb5t+Vz2zyETvtz0QithK5e5FYfKDX2G2+arSgKdwwiGOQ
	 QWUYTt4Y/EdZOi2ODyo4OEQ/QuAiIqSJ70sfBODXHfPlQHsI+XHtTrvvFPaW//rHy
	 K6ytXclfRnTbTCa4UVrb20tGegizkI0foOviYZ7vXARV3mt+oNRkLEoCSeDyjjgUp
	 QL3HEncfXUc4SALfSJeS22uN7wsJFqpjZKzuSLn8OLL8Z9hsrUYNTft2Vb//BWbON
	 LHGSRx5oABRFeJkODY1xafl/f1eZ7t7WJ+K7PUudH2DBrJVDOFZzq6Csrx+aWSrtW
	 5ugcEd5826Qr6ri00w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1vSNDb3w43-014L4U; Fri, 08
 May 2026 21:09:49 +0200
Date: Fri, 8 May 2026 21:09:48 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for
 object size
Message-ID: <20260508190947.GA25792@tb-raspi4>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
 <20260505191100.GA12275@tb-raspi4>
 <fa39d84b-ddbc-3943-5cca-078fb18db80d@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fa39d84b-ddbc-3943-5cca-078fb18db80d@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Rbq/dZs772UzqopX8RAF3JGw69JSKOGa2OEAm6pi163ZjTg/ZUa
 /ZHWTLshmnozdTGlqjjXQejRaBtfUZJbt7r7gs2pzU7TcVnWzhx6FYlZre5BnWj80CWsunL
 ua2avoGRgdbH4anPeloI/1hXm7zQKyhZLVd7dvXxdK0tkJQODSP4fe9dVEB47J4EAs+WlJ0
 FjDqoHTunb1eqeN5gw5Qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RY+1Yzch8sY=;udoqibGwjJVRDYcxBVF4J0EJa7S
 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
 tfu28EIovR3439zEFSPcn+wEtShTES1Ow6W8=

On Fri, May 08, 2026 at 09:36:53AM +0200, Johannes Schindelin wrote:
> Hi Torsten,
>=20
> On Tue, 5 May 2026, Torsten B=F6gershausen wrote:
>=20
> > On Mon, May 04, 2026 at 05:08:18PM +0000, Johannes Schindelin via GitG=
itGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >=20
> > > [...]
> > > @@ -524,7 +524,8 @@ static void *unpack_raw_entry(struct object_entr=
y *obj,
> > >  			      struct object_id *oid)
> > >  {
> > >  	unsigned char *p;
> > > -	unsigned long size, c;
> > > +	size_t size;
> > > +	unsigned long c;
> >
> > Does this look a little bit strange ?
>=20
> Good point.
>=20
> > p points to an unsigned char (better would be *uint8_t)
> > then it is dereferenced into an "unsigned long".
> > Then it is masked with 0x7f
> > In short: should "c" be declared as uint8_t ?
>=20
> Almost. It should be a `size_t`, so that we don't have to cast it when
> shifting it. I'll include a fix in the next iteration.

I think I was not very clear here.
De-referencing a long (or size_t) from any address is something
I would try to avoid:
Some processors do not like to read a 32 or 64 bit value from
an uneven address (and throw an exeption).
x86 processors just handle it, using more than one bus cycle.

In short: Please keep the up-cast and simply read an uint8_t.



