Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23F367B7E
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835859; cv=none; b=ixY58RXQR+daNNwliVrhi7vOopWyUCdxxW1I+0Ne9efguF6YxgQ6murpiAshwXTu8kcl0HSvMDpmy9PO7bfUu7ddjZ2o1S0HMvqRKfJQsbEKmgbTWhVDXrQfP1wFnDxsG6XjSY3FBmsv1+aVAiu1h8pZ78m+5pO6/c3Jk6BF+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835859; c=relaxed/simple;
	bh=r7eMoCQ8+hV4C68ip8bDAQdDO1ADFOycr6Bu49C0H9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exXwjnl5URfdNULDIIh04rhQSkynmk4vYzZlFArSAiwQ/SiSeFjUu3BK2tNKQO+J69wQUzjGYLi9f1CBcg5Ol+BOVJg5Gfrzy3Jn5YJC6xafas3ckGO0Cu/Tcg2zUN5sAAnitP1L7/GDDvXxpCGbB79BqhkEHKQYkt0ilZCEJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Se9oftu4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5878W3F; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Se9oftu4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5878W3F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05FAF140008A;
	Sat, 19 Sep 2026 12:37:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 19 Sep 2026 12:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789835856; x=1789922256; bh=ZoNAO8w+n/
	Ld7o2juI7n+zuW+EX1AXTmcFz2UMb17AQ=; b=Se9oftu4uEZiHooIqe7bPoi9fQ
	0T37hT26kYtCMSZUvrZEZ5l7S3/vlaMXGbjRhRKY7jeeCoWvdit1efhUxQenjFC4
	cFl2VNpSZvusqRQZ9Qbk18uijSuRC3dUdN2INZrEuH5lDCbH0FU4K9jILLg4/jya
	ukYoGWlsJKmUQ9OpcLGHJpFhG2lV3m7/r1bPmMBzDrzssBbb0pq8Wpz6WQornDZ1
	YFf+CUCU8q6kTFLp2WoKDkwt5S9BaXRjwhzKAQF/M69Qz9Nhg6ezJ9Q7R/am8JUm
	vMP4Um8ECPkjlk5c9ooFf5VYt791tMhogTj1ltOYy+topllEL+UkUevcN0Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789835856; x=1789922256; bh=ZoNAO8w+n/Ld7o2juI7n+zuW+EX1AXTmcFz
	2UMb17AQ=; b=K5878W3F02ntDTf2wjKdwwLQoGh3E3MaJDCfUWGHtiiOwh4XJXn
	iHvuI26vLNYINLCSCWllq4PMSjYO0wEbBVeOTdxc+Iq/4sDeOX5i25OZ+QvGZtmW
	rrk9OzzIywykDqIwhdg3NL4IKorz2vHTHLJF3p9DrvsQB0o/WTSJu0jzRNCLBgqs
	JT713CxU4z77Vs5oYecp/HMHc/XRnKmR6OkYNhrIDp5A+qyZc4WRTw2SSBmr3bL7
	wi5Ntv762t8pWo/GJUPqwBvyKqgZN22GmE4BsCUm+nkrRHpe5KFfVxki2c1LVbYk
	Cc25JxMFZkC7hwetIpX39ZPyOukR6bZu1Cg==
X-ME-Sender: <xms:T7quarIrj6SqkKvKEvisw0x0hUwJoPOW9o-VEogpbYsR4_frSZniHg>
    <xme:T7quaml-IQj9mRIRwraO9nrm8mr60_vC7Ef4R3qE4fMD46p5uq1QcITEuRBCIQzA4
    6ebJc3Z0uJs09c44wSAEvAM4zv_zOP0VkE1scPZXiuNPt_C0VBGG5Y>
X-ME-Received: <xmr:T7quahExH1nu_kgkChYR7kMmH43rLMsOCL_cde5QPxiNy6y_txEENDeW3_ZJS7fsm8u_X8g82gP9kNk_TSQd5dMsH7-c9AVT92QgqoRlF-PU5UWOu-TV9XI>
X-ME-Proxy-Cause: dmFkZTGbCcHPAVoWJQVxXwXEHYOmPAaPjFTBOCitTzIoi+hxaMIAVGyf9AS+OmMvs4EfST
    tzTND5WYv78ngqI6vjHktaHe8jetzEBCaQsQL+kLLa1VP7tcUeqtt96vBZ8v5wB6+yYBWf
    VQKovFrstfPKUfQ2RpaMtQwqy3m3xiu8/yC56ZdyjWWaOlWCWjyYBVG6G0u5RZm0iW9m1c
    zVKvBb+baG2yV8UQsURi+HxqE3PNDGyyWG+O/I8uMVp6I6SI4bAbjqmtVurZxdipLzNMSl
    YhjRk8udUPM2IgWh9QWny6ptvCWQAo6vrkuuB71UmmTIe9CDAjz97nari7dqpjQCkVj/PB
    xekAvzOoPbf5scy51Sn/+irvSY2E0E6MSGgossUO/NgK5dcYDprAWi4QK9+92h/zKC7RAf
    JzseyAo7JkpYwbP4vK8qVgIrENUc+JCRC3sT1V/qdsg93Z7Yl2u2iJ5yq2c1ZUBDc5F4Jr
    b0jyu2kKC0wbpGQ5DyhloJsrMj4/Y+kgvTN3NAfYOXSvyyaZnNeEMBZtJBhOngEbN6mkDW
    krdRUOCf4Z88/vZr66jHRUd60qOTnKgF3/a5WJTJ57mPE6niNSvdpH8zfLA7+FDWHd1yx3
    XufshRPsnxxVYwd5/oug25bFqCqAWkfXCtZsSWYs/7nuouldyOg2WOHHhVRw
X-ME-Proxy: <xmx:T7quauGt09qRPMKyHyykqcPZgkhi8_HHdn39gPUbTN1lEVFL2IBDvA>
    <xmx:T7quamOqJi4xUx9NlSivVvwatxQ1llSF7vV2CsGmjCHVdHf6YG4Qxw>
    <xmx:T7qualH_YFtc5Vq2sr1H0A2MpkbaZWRaNgGnju2kcLLh57bo5pMNAw>
    <xmx:T7qualOFLhhn8xt35xwAj8lIDLSKGZGNLiqPm8du30Sz8bp3vNfClw>
    <xmx:ULquanSu27_-uhbjPD7y43okIGQ0pzFoKUurPHLqQQ5uRafdhO5X9Rc7>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 12:37:35 -0400 (EDT)
Date: Sat, 19 Sep 2026 12:37:33 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Francisco Boni <boboniboni@gmail.com>, git@vger.kernel.org
Subject: Re: pager: consider revisiting automatic LESS=FRX with custom
 core.pager
Message-ID: <20260919163725.TExDduTp@teonanacatl.net>
References: <CAKNeS+mFS_VCs_tQeFb8jBx70FwQLW0LtuqhSk4xSdbWdqDR=g@mail.gmail.com>
 <aq6utXAQA-rRoKSm@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iEa8OJQ0oa0y7jI"
Content-Disposition: inline
In-Reply-To: <aq6utXAQA-rRoKSm@fruit.crustytoothpaste.net>

--7iEa8OJQ0oa0y7jI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> I agree that this can cause unusual behaviour in the case you've
> described, but that's more of the case because it's actually unusual to
> have commands that take arguments through the environment in this way.
> That's no longer really considered a good design; normally we use a
> config file instead these days.
>=20
> I'll note that it is configurable both through the environment and
> through configuration, using one of the following:
>=20
>     GIT_PAGER=3D'LESS=3D"" delta'
>=20
> or:
>=20
>     git config core.pager 'LESS=3D"" delta'
>=20
> or, if you prefer to be still more conservative:
>=20
>     GIT_PAGER=3D'env -i PATH=3D"$PATH" delta'
>=20
> which unsets all environment variables but the path for your pager.
>=20
>> So this is not primarily a request for a workaround; rather, I wanted
>> to raise the broader behavior because the interaction with pager
>> wrappers is quite surprising and difficult to diagnose.
>=20
> I think at this point, we're unlikely to change the behaviour and it
> would be a notable and unwelcome change to do so.

All good points.  I wonder if it would help to add a couple
of sentences to the core.pager documentation mentioning the
method of setting `LESS=3D""` as another way to override the
options?  Something like:

  diff --git i/Documentation/config/core.adoc w/Documentation/config/core.a=
doc
  index 340329edc3..45e1fda2a2 100644
  --- i/Documentation/config/core.adoc
  +++ w/Documentation/config/core.adoc
  @@ -614,9 +614,15 @@ command to `LESS=3DFRX less -S`. The environment doe=
s not set the
   long lines. Similarly, setting `core.pager` to `less -+F` will
   deactivate the `F` option specified by the environment from the
   command-line, deactivating the "quit if one screen" behavior of
  -`less`.  One can specifically activate some flags for particular
  -commands: for example, setting `pager.blame` to `less -S` enables
  -line truncation only for `git blame`.
  +`less`. Another way to deactivate an option is setting `core.pager`
  +to `LESS=3D"RX" less` or `LESS=3D"" less` to override all options. The
  +second form is useful if the `core.pager` command eventually runs
  +`less` or a command which respects the `LESS` environment variable
  +but lacks command line options to override `LESS` options.
  ++
  +One can specifically activate some flags for particular commands: for
  +example, setting `pager.blame` to `less -S` enables line truncation
  +only for `git blame`.
   +
   Likewise, when the `LV` environment variable is unset, Git sets it
   to `-c`.  You can override this setting by exporting `LV` with

I don't know if that adds more value than the cost of
increasing the verbiage of an already long document.

--=20
Todd

--7iEa8OJQ0oa0y7jI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSvlwC4tRNlCF6x+moHOcdGE+n45gUCaq66RQAKCRAHOcdGE+n4
5rspAP9RN4YzXkL65XDrVi1SR12VmM2Y73Ub/cPbU8LO5otpJwEAg0dKXw49G6gT
6FFmGXwK3fEEQvZ0uce6Lv7Do5Dp2wI=
=Ck1D
-----END PGP SIGNATURE-----

--7iEa8OJQ0oa0y7jI--
