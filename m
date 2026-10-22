Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643893;
	b=X/QvcFfzjmoyw7QSaTJogCMBNzHbZefJMA5BqXGVWSn4aoE1NRFOrxLJ/TAy/PNeT/X2
	 FTkZETkBVmlTUZScRP29VMneP+GupFKaFpLbU4gFYC2pG5Se9hs3seqGido13PPNeXuw/
	 Tql1wskswV6XthxKe9x+7XAihSB/8XSX0FGQh2MCD+V+gZNJkBfCfyWfP2Pg1co+BSEz9
	 ZRl5G8e1YsKRKLsBnBOYOyBcfZGUXg2klawS8/4fR6XCIU8OIdJNpXl28i5IW/nNUS516
	 H4YC40R2Niw6TUFiH9FavaXIuHvHhZ4IUa5LCpS1G3OM990OWmoIoPD617SFZ5/Ttzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643893;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=5o4fwkGHlRV1iYHIbtvxQeD+U+udx4WrlOfrxQJEVWA=;
	b=cWh9W1mHzFVegO4aoP8Hr8pmFhqwMmJ9gBzGMSOtjW6zWggKPE706wRzFinrqttvh64r
	 Z5sRK3SRRpiOaRSd/scpyb9xm03RU5FmmNRWo12soQxdV93ds2DSeUnWriXHKY8VMVmdT
	 87QoL2hNJuPgqLBEbO5ZXQOriTpxI3BSClBqppT1sTtlCiQ/E1GVVYtifNIJCIi039D12
	 w+DbeABc7Wq7NlScjv3BF1YNt1qbFS5n8YUlGK91XtdoF0K+GhGQfZJ6664x0DU1eeB2C
	 qg8GFOcgA7GowtKMZGcPc+tHGCUkxu263XYWnP00lKMdLcOI82XO2z8yZFMZB0Sacqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=YeVtJ6OQ;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF6606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 04:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DAF6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=YeVtJ6OQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792643879; x=1793248679; i=tboegi@web.de;
	bh=5o4fwkGHlRV1iYHIbtvxQeD+U+udx4WrlOfrxQJEVWA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YeVtJ6OQVhVLAtCjRM5n3XMpPz+U2idguxQSoNVUgeAUQpIgpjcBAIw/8sfuscD5
	 RssC/3Om0qvXOctWq141qaGQyJExwWlwMOUBleVQW7UtC2rMoWGayP0s+rKDDRU2f
	 +r6DdSfGiC+ECQfEQaslQVt3ZQaX9sdHt/gXHdtbkoRpKc3VequZ5Lsn1SNUjd+z4
	 wWnK0y5qJp6lxUcgu7b2FA5iIQmieL3Xxnm59pQM7JFCoMYFOgrOmRc/n+g0H0FHY
	 jiaWOZxhJAtVlJooykd1jDNzxTUKi8RoUjqz4iNE84m6USZTRL5FSGyw3S9zm7xCr
	 JBqQhTFSaNLck96j0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1wucoC0DQd-00k6Rd; Thu, 22
 Oct 2026 06:37:59 +0200
Date: Thu, 22 Oct 2026 06:37:58 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #06)
Message-ID: <20261022043758.GA31562@tb-raspi4>
References: <xmqqbj8tckpu.fsf@gitster.g>
 <20261020185101.GA6367@tb-raspi4>
 <athRc1-tSEVgBupp@pks.im>
 <xmqq7bjbosj6.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bjbosj6.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:8UokNJrAz2FJ3Xch+AOWbHQaEilWopF/gF0H1DoU3qbEr7bt29C
 /tIdqhTNMo1fyj11uqM81vPBKjByIgiYYfso63DJZ/zglVzv5K0er1DR9UtpT5UQQA3Hjhn
 Sc/dqoEBV0m4iJuTsiSp3A+OlAVu9d8sidaA19VLFaqDXOOfdGOPP2HFo+Vf2zePLUqZTSn
 NRNAAvMN+obDLHUc1+Ayw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dGF2ZqyHL4c=;qMVd7tKKGiksd602FvgA7LoeW2N
 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
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:46:53AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> > index 16cc5d5dcb..a19bb27db7 100755
> > --- a/t/t1450-fsck.sh
> > +++ b/t/t1450-fsck.sh
> > @@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-objects wit=
h truncated loose blob' '=20
> >  		cd truncated-blob &&
> >  		blob=3D$(test-tool genrandom one 5k | git hash-object -t blob -w --=
stdin) &&
> >  		obj=3D.git/objects/$(test_oid_to_path $blob) &&
> > +		chmod +w $obj &&
> >  		# Truncate the loose blob such that its header can still be
> >  		# parsed, but reading the object data fails mid-stream.
> >
> > Ah, right, that makes sense. Makes me wonder why none of our tests in =
CI
> > hit this error. Weird.
>=20
> Not just CI.  I haven't seen this fail locally, either.  Is the
> breakage Torsten reports that the later step
>=20
> 	mv obj.tmp "$obj"
>=20
> fail when $obj" is not writable?  That does not make sense to me.
>=20
> > Junio, as this patch series is already in "next", do you want me to se=
nd
> > a patch on top to fix it or shall I send a new version?

After a (very short) digging:
It is an old version of bash that was shipped with MacOs:
 GNU bash, version 5.3.15(1)-release (x86_64-apple-darwin20.6.0)

My explanation is that this shell tries to be nice to the user:
A read-only file sould not be "moved over" by a different file.
I can probably creata a proper patch the next days - or review
a patch from someone - whatever is faster.

>=20
> A separate patch on top is very much appreciated.
>=20
> Thanks.
>=20
