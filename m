Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651016;
	b=3UAnkkHFKbwMn3DUTOCEUIjpnRU4ne+Dk6Jjxftncv7YMNC4/4X37FkEATy4pvp6RfTB
	 u46UBCQFDss4pyjThWS98eIDqgfX5sIYpHZuvV/FQ2o2D4vCmrnBK281WbfKz3gbJWhGX
	 TkB0fwhu2AYitDtYaRPYZeqNEeHXPWqp0pP1ybraorxllkC3q3QrGL5PUJVqk99uElGyc
	 hNPsNhU0FnIQbKJMXXbqlWikLqWmhtnhgvP8DpIPM4Ft49BKpCDB3uqU4WmF3Xg/Rrd3e
	 H0k1HOC/4+7qJy6wI2KLESH5R8TTKIcTZvF+5YGnL4dCUI3HBPy8LFq8BPGjtmwX3Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651016;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Ypt2jKveDfNBHUocz308CJrlfPbRiGbxu+cVAarqnAw=;
	b=yq/13XY4vYXxWCP6nKL/1IOtiNkvelwAm7D4HCnB+2MCpxvtKFrHJ2/VETLwFgCkhWjf
	 oWB4RbkTvWtPzEhzMX38sGUnZTDKMPtxEUlnEyUmWyKDvcV64GtSMgXVrIHrDNMM4zrWF
	 i8r/5+gk7Jgz1ZE1ojDXZSOCZASz8WHjwL9FTUjzzeHWHkR+BzLUNOAXkeZblvGonar9l
	 upEek/8rG93wdFcuzGCrvQyVa/4jnQdZHkX1wzs4X9OsvBGo27+MWWGmvXi0OlUQkTrrd
	 SoISLXIKqsmHXgSVRw+q5CPBZXHICyiPdAvUbpn40Obd6pivfDXnyAzILS/UEqWr5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NaTlrzS3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ILqZBHBs;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63144606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63144606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NaTlrzS3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ILqZBHBs
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C78B7A007F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:36:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 02:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792651015;
	 x=1792737415; bh=Ypt2jKveDfNBHUocz308CJrlfPbRiGbxu+cVAarqnAw=; b=
	NaTlrzS3D1ZDybIqH2dsf++ZNIyrr18Zc7R7cYA7XmsFO6q9kgkQSwX0wjpoNJ+n
	LoZqWx2lF2jNEbxyZrT0pwqEjRFjDq8S2xRYw33S7sEJ57Qly34QcSDoq0QhMWey
	OZAgA+eq9nR/DVBexuqXSmL0Sf56pXW+YCgAFW/H8TgaH0hPk5utqrTuN+Y9Jj3O
	5koCADlVlCjxgMzpmN5aLNcTr1WhL0adPGjNYelZrprKliP2O6lOYQzR48wyGn6f
	slB3cRoFTstZpzxl2738FKW1e//sUmwu5LSWz9jDMS3Y7QRNlppepPOItOPwSbFB
	eOUrwO/LjsmCdx6EBmihQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792651015; x=
	1792737415; bh=Ypt2jKveDfNBHUocz308CJrlfPbRiGbxu+cVAarqnAw=; b=I
	LqZBHBsWjPsEexWBqzNZwXH9Pk3p8ej/DQhBmfEubyZOMXDmaP7B25C+Nv/j+gQ/
	zfws2AuPWul9j3lZtV6ac4jsSby8YlSZWHvDjBiBGrQC78VpqkSrZAXd7yizxh2S
	N2h989MYhA2N9+YNUCKsZhrerPYVeyETyXA/Z4knrY5vhGDu0JCu9MjLCdP8GdxR
	zH8lydvAfKmzMxVsfjZN5NB9IcVqRKjy5rEW2ypAcnbMO7qSD8RbB6hs6AMkREL0
	CGI1HU55pfiHALQIBov2JIJ57y5O6WoDYw10arQe9o/GcEJaIi+zqeO0HUQOaVkI
	SAKT24NUMdlYvDaIIjbGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792651015; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hLeke00J2V3OoyyxqKKs9CiSsrjKgpESxxL9lJ6s5UckEer
	DHgyQBLglYCQmo9LkskKNk9SSM02vILD47fY3Pe/VA68kAaWoEEbBJE9ql21AOzW
	6nySGrW4qJcmtULsSzUKnYrsC/q9/5FSR+upPiif9ugOlgm4GJcBpdZGiWTwJJ3S
	L2Me5tS5f1KTaHbRvWxhnqT70523FLHm73ik1kTl9AciZ7uEKKYLx5rfc4nfIBjq
	kC7iDAXOoh1JrKOJ+romlmIFUvRflaM0vLIUFjmpxahdGzM4N3dIMctO0na/6JP9
	Sa+Qjvj3Hm8W4Evb2f7Hkv0sEN+GmLSQy+gM2CA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JXDREJA6OmtMAW51d9krKvrGozqdFv4TG3KeHkvLQRg=:7i/26beHw4uDZmJMyuzKGMI9aJFoMTaQ2zuljhFrR1c=;
X-ME-Sender: <xms:B6_ZaicUbpjLFfEjaKVbnRm11dqwX5JpoenxCx1MsawdDZyjKaOWcQ>
    <xme:B6_ZajqWv-Sh9zoFHliLPKypiKAThuPQqifVyOZQ2dfk2NiJmd49W_Te3BEF7bLoj
    uo-ZMu9xrpl9x4qOg72DI4qxmAsg-Vuw96cUeXMpff67ZQkOqyY8zQ>
X-ME-Received: <xmr:B6_Zag4bgYRZUIZ5mhtof7y_Es7rG237DglVgbWG8IqFSefXU5dMdLAGBkIEdYEYaMUlfg>
X-ME-Proxy-Cause: dmFkZTGxJsE4o9kZcBWS1HCqgEcBEnUJzO7Q+xkvMUTlFPKkoiGKBBeOl/wqQTS6imW7Rl
    X0YjQbdHRhYgHZrtNE9vqRE5PJ/lU2yhCDLCrsK3W6kQiaSG1MHPeentQHHaprGuR+r3LJ
    Ix7Pn1b2VNRRwN+2R/cdj5/g0C+t6YJgVm1v4Tk8977O4SNP3kCLH/zdODr7SsOeaSFgFc
    RYL+HoA3OUtaDry4QwQVwKJGMoluM0SGVEeii72SOeS7b8pbZza7tCMEBmjFhpOlbVHsTF
    1j+ncu8EiQPL3CG92gfrx/OQMzREGpBcX0Ikc4UjGLz5FM1RY8waSYoRmFrYUIolBzABPO
    JzKZBhdjGFxp6iOOX+JV4fvkPJhZsqynQ1wjMr/PQkwLls0v9LZbgB4bjweSfh/BDYKDmt
    fKlHfGT1pec04+CY5f/49MBWqsXbzPb0fvzbKeWqJwOXLSQ4fU1yKQOukpxSDo1+br2ZZi
    MnFfW1leP9vlwtzEoq09SxFhh0LbvadeEsiUreic4AIdXYrnRnyTHLwTt8MHjoNLp+hzBl
    ONoes6/8Poo+j/7+iO5Gj65skRwmi4tMiWjD9H0gwJ+5ssTl+FxnwNoobxYjRFIIKz2s+a
    h63xveMBNZziZBTp8v1Zw0v9jOl22F0smkmfsLQ3mIbaliDW2kdaZRwBnbXA
X-ME-Proxy: <xmx:B6_Zapqc-WYtSCHv9DacfpgBDfmYeRGtPdvX25KMWiVeYW6EQ8zFyQ>
    <xmx:B6_ZaiiFU29HYIZ0olBdnS5UeJtpkdW8kvPkiRkSr2gQXXqPk3g8TQ>
    <xmx:B6_ZajIjo-sKQfh7IecUQ0xLFb4XZVjSmjal99gwZSogm1KZqEbQ3w>
    <xmx:B6_ZaiDy_yGs8dqZ9wAqYQwSOInUagH5zZkDh7-pFqPFrfVWgdvrxw>
    <xmx:B6_ZavTbkNSXe2W2Hgp06_W1j_SlqYQ8HhGH5ieFo2stBSa7HKZuf0bX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 02:36:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc9f341e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 06:36:53 +0000 (UTC)
Date: Thu, 22 Oct 2026 08:36:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #06)
Message-ID: <atmvASAoaCIpc_ca@pks.im>
References: <xmqqbj8tckpu.fsf@gitster.g>
 <20261020185101.GA6367@tb-raspi4>
 <athRc1-tSEVgBupp@pks.im>
 <xmqq7bjbosj6.fsf@gitster.g>
 <20261022043758.GA31562@tb-raspi4>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022043758.GA31562@tb-raspi4>

On Thu, Oct 22, 2026 at 06:37:58AM +0200, Torsten Bögershausen wrote:
> On Wed, Oct 21, 2026 at 10:46:53AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> > > index 16cc5d5dcb..a19bb27db7 100755
> > > --- a/t/t1450-fsck.sh
> > > +++ b/t/t1450-fsck.sh
> > > @@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-objects with truncated loose blob' ' 
> > >  		cd truncated-blob &&
> > >  		blob=$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin) &&
> > >  		obj=.git/objects/$(test_oid_to_path $blob) &&
> > > +		chmod +w $obj &&
> > >  		# Truncate the loose blob such that its header can still be
> > >  		# parsed, but reading the object data fails mid-stream.
> > >
> > > Ah, right, that makes sense. Makes me wonder why none of our tests in CI
> > > hit this error. Weird.
> > 
> > Not just CI.  I haven't seen this fail locally, either.  Is the
> > breakage Torsten reports that the later step
> > 
> > 	mv obj.tmp "$obj"
> > 
> > fail when $obj" is not writable?  That does not make sense to me.
> > 
> > > Junio, as this patch series is already in "next", do you want me to send
> > > a patch on top to fix it or shall I send a new version?
> 
> After a (very short) digging:
> It is an old version of bash that was shipped with MacOs:
>  GNU bash, version 5.3.15(1)-release (x86_64-apple-darwin20.6.0)

This release isn't old at all, it's from this year.

> My explanation is that this shell tries to be nice to the user:
> A read-only file sould not be "moved over" by a different file.
> I can probably creata a proper patch the next days - or review
> a patch from someone - whatever is faster.

But does that explanation make sense? If it's mv(1) that fails then Bash
is not involved in that decision at all, as mv(1) is part of the BSD
utilities.

Could you maybe provide the trace to see what exactly is failing? That
might enlighten us.

Thanks!

Patrick
