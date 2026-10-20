Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486250;
	b=lMZajmlQ+7wQLpWKDpqfMhpAJbdemqAw08SvSWJBTP7EYvhDrBWWrtSCKBw9aoSGnpYJ
	 +FUHOgqmuedFc/RMI8qZ4wXhepjJ9x9S8QmKlzLkz3rioGeorzod75JwZ9D1BIkx4CMt0
	 OkO4++/Ka6L6Sc5ve8/qCtsueiCJJL+UOReJ5ftxtcCc9LtxcCysccmjp8zkMIuJplVxD
	 A4cYij/icE3cFq0eiznGAtil39JPqMANOuEpEMSQIwQE+CEvepnTmNDsHPrb5dl9P29Qc
	 h8BpWoWBkuqVNN5bSoJZUrymbOKpnyyq22qlQ3uDAerndB00T0+rdhaiYOAhWX/q7BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486250;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7vSvFIHp5EtCw6Kn521W/jSSaRywSMMLGkFf39iWRDw=;
	b=XVdmq+ZNFCJfblluVTO62UTlfbNrvnUK9RzkRc3HrpaeeufSRl2h8tWSJUCE6A7vREID
	 nCTKmBdA6LygReVVINCNCcLLQZPdMNt8lzFqs2jJBUhsgJBp1J5nshnyBIwkMbZxYkVWk
	 /u+1nBFM89BZj2k1aWxYVZ9wdLKf4uMLjTe4RCZGuOsyEvZZkjXG1nAAp4qapPaKqZj84
	 b5kU6HD5Q1GLXXfBcI2lV0uSVNu8/srpnIkJS6HtJFzCe/WnDTDckYmoZVYWYlI8iBG24
	 wBOoPlbpXmPEXBvSyE1JPGBH8virjbIcGryzCM5+SZrw9G1HJSjbdkkVY5XLi85xxlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ImdE3JJ2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dlvgNfHP;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C2606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F40C2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ImdE3JJ2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dlvgNfHP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48AF31400089
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:50:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792486249; x=1792572649; bh=7vSvFIHp5E
	tCw6Kn521W/jSSaRywSMMLGkFf39iWRDw=; b=ImdE3JJ2VR5/9+x8crf/rSvRa2
	N9js9U57Eo4Ar8LpA182J5IKu9AnPD/AUFMnchfK5OyLkrLOPcCQKz8NRnvBj5lQ
	xqYHTJlC69JkhB1XrXHWJ9ccdPp/iGDPLVfA8+XOxOJ6T6sPvksFef6z9+TiJtNY
	zC9vKqKN+EUMODCqN+dbONXSYTC/20e8UTgyOJAhgKnlbhniSkEIT9cON6pGUV0v
	F3gRT7I2scNa7kwMMAbmFsLdTRWOxmtZlsbjcLJ4+z8sH5K4rP2xn2XVJCZy6HuY
	vk+IjfoUfBpzVvlAMkJ6HEYWO74faqJBAeViU8Zc6ytTMKL2wHTFQbVk2Rbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792486249; x=1792572649; bh=7vSvFIHp5EtCw6Kn521W/jSSaRywSMMLGkF
	f39iWRDw=; b=dlvgNfHP+X+14Y+h7C0iiBT+PAhsew2yY3higjtg30Q8icJ0mYY
	A6yQhnM/Z4qPja1QvC+sJVYaccGomtvBnEvZ29IHqo5JYfw3DH8mj6PH3SKM6Uuv
	lJU1PcR5fwgyykiJm1LHff0pf0WR4SyUoR3/hJUxY4w3kp6PNtUEGvuhLXvMCUY5
	R6TRWSY8n+ScsLl8rWWiIx4GIuML2TV28VpGZBvBQccHJUAHAUZdsurI6S2f/UYJ
	ch5jyvTduig4YunAbbRIm+ppeEjBk4khSBhy2VKYYXRl0Dwf8FAChxZyZMv7/pcE
	/a53wZctbMZGzvKWAe8iNvrwDqxBymaM/FA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486249; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bOKUl1lzc3PGY4jhjjd4R8lxlQW/9Gt3fewlVawHt1Qx03a
	vm8lgibagSJssYD8BUlEYtNyd/FHbf8zPZ/N+tESEbprVYUJOmWdH5CHq3w8E8jt
	XMXdBX/mkz5rfKWkLDoaopjwA+PJcgc//ce85Bkb4sqd/yvUeyNEohXoiVG9AKPE
	RbyL2fAuPPbl1Xb04K4xpFKQCCpkGiHIsv4+WfRKj2OewMSZ4TT3s9cOAPfDHykG
	DZiOMkPMAQA79HR/TezcVrcwkBag5glIaLyQEWCqhtemPYZfZtKoUkbsF14JrTo+
	HP8qTGmYMU6QHLNosvFhB/0nRbTIHvn2mvj1g2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SbB8Qi0yV0f4yZUwLE1fAJhyWRhCK/nOyAZvXEkkl2E=:D9inh/1ynsSE1oWxZazd7ctRAx4ehQl72k4Javqiqkk=;
X-ME-Sender: <xms:aSvXaitbccBqrVW05qF0Z_Qe_QQFmusAkIrU3d57d9laFeGvSueYzQ>
    <xme:aSvXatcSZPawzpZYIABXWQT5oi0naEaiGbWotm89y9Uva9mqo1-u2NKzHuRaJTTjV
    1n03i_hUlT2ync9wVloymL5-rhdrXWfJWVC8Y1Ty1wgkb7KiuUH74A>
X-ME-Received: <xmr:aSvXarYlBtYh7L6azuvgqW8eeO-n5GT2LT3-rm_ya9eHRskPPhabKzUjEEz5s-aSEUox4A>
X-ME-Proxy-Cause: dmFkZTGyaZQ39rK1akuxCUNvIMA6OA6DCGh1rQRWWcux53coNVH5usfnMeLyUGOtVlo3n4
    snitkCGk3D/EPmerPQMUge1FXtDL20f2qlhNKcjzGt3hvNnrRtZUgJ9Gc9HNJMVUJW0qgX
    U7IxE5u9PlXc90OHU2PkoTmg3VIslEIM1v6MBN8d1I8Rfbnek/bZ6gvXu156VZycKwAkUt
    ixI81CvPk3dO++OofdsIRbumQwoLBVov5ujORScq5y3unfF/1p/mKXhNg0C16PyUSOQPJa
    C1A7nGnwEbcUT06cnNFBZ09GD1YvfimDxy8Ny0NfWzSDURmVJaK9iqG18GC80mwjWnJdHA
    36yQX1aGmMgt7lhLBL4EMixRfvKY6x8u8nZiF0mQmfGnGYUJ4crPqRVCxqjxmZ+GpgvoQy
    dPNJRLmH/LaDJwNn0LV/F6lVZvar6JuUPYKcNlrYlLsLqck+TWOo3Xt9plSf14jWRBqMAs
    jKTApSrybE5CEapYceZ316gbAZt0mDPd0AJt3KWhrbt73mIV0bhvA0b8CgsmoeQUr/GHWO
    ytsYaKQWQqYF1XZuQ+kiNxp540XzvrTbbsJW6qrHKS1URLrBUvL/Oy8OKFHKohWSshxxzA
    ekUKKneMpU3YnBoC6bj7jI2O36JgXYEYRe/xBUOU+vTXl2Fc0mVkDWzIoeeg
X-ME-Proxy: <xmx:aSvXaoXbIWbJJ2O95H2_33lcHQOaPAr-cHjUanOxWv1lMxI_cbHguw>
    <xmx:aSvXalhzBoZnMA9sSW7NvWEDLy4VhG2M60bSxNdVIQt9-jMRuVKJRw>
    <xmx:aSvXauUXGB9v79D92KIXE-PTeTiPi_HDWU2xFYV0nO1l1HMRxzcceg>
    <xmx:aSvXakOdalu94RfAU4b6Jf0AJdhJe8527OecyUiCetHHqhdy1xDecQ>
    <xmx:aSvXahu1d9DcBDNVrJ-q69g3q0lve8hyctJtwnLs7CvxEXwDGEFWywe5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 04:50:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51a952ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 08:50:47 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:50:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] setup: allow overriding object storage format via
 environment
Message-ID: <atcrZHZkvitoFJMR@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-3-143a5963b77f@pks.im>
 <CAOLa=ZTbYQvnKBodYm4Bmk7Veb=tt6oDJwWqb+AfXdiuLxcdrA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTbYQvnKBodYm4Bmk7Veb=tt6oDJwWqb+AfXdiuLxcdrA@mail.gmail.com>

On Mon, Oct 19, 2026 at 05:34:39PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index c7c464d3a2..5e7c25e42c 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -869,6 +869,32 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown b
> >  	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
> >  '
> >
> > +test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides extensions.objectStorage' '
> > +	test_when_finished "rm -rf objstorage" &&
> > +	git init objstorage &&
> > +	(
> > +		cd objstorage &&
> > +		git config set core.repositoryformatversion 1 &&
> > +		git config set extensions.objectStorage files://objs &&
> 
> This commit does test the payload for the files backend. I do wonder if
> we can make a matrix for tests
> 
>    {config, env} x
>    {valid backend, invalid backend} x
>    {valid relative path, valid absolute path, invalid path}

There's more to this test matrix: GIT_DEFAULT_OBJECT_STORAGE_FORMAT,
"init.defaultObjectStorageFormat", "git init --object-storage-format=".
So that would result in a matrix that covers 30 different combinations,
which I feel might be a bit excessive.

That being said I do add lots of tests especially in the patch that
extends git-init(1), even though they're not layed out in a matrix. I'd
propose that we go from there and extend these tests in case there's
anything missing there?

I think the one thing that's missing is exercising invalid paths. The
question though is what an invalid path even is. Right now for example
we use `safe_create_dir()`, so we won't create leading directories. I'm
not sure whether that restriction is a sensible one, and because of this
I shy away from seemingly casting it into stone via a test. But if we
eventually start to create leading directories, then there isn't really
any path that I would consider invalid, right?

Patrick
