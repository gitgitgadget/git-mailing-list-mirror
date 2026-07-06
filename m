Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E333DEAF6
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319043; cv=none; b=R2viFBW4HhU1FxYHkFut0l828tVg540++GYa9HWjKRKok+dn9e5xXekWS8OF3PXrCiuik0su9zQosOHn8AwLDhWUgBH82HNjjz4iYGRHwT6ydYSBZrTYu8oZb91j0MCJRL/pIPuQ5BetXqk/z9rQRAmCM3lXycqVj062fehUaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319043; c=relaxed/simple;
	bh=7GsO5VM48npf5tI9Lgt9esRt8WdIqlB/CxZPkV1tvYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRe0MJboHeHsZK/1mXGUt7rk+q0xv831NGVmLIFX8KdvLcVxL1ni6GzCsX1o0uJ+IrqR9dAOO5MfxT+QZJB25b8ivelzHnWrfCqVL6ig29pG0qIo8u2DhU0aFZaZMH+1ZBnWH7FxsR3FD997atisbjIGpI3wO6l007Hdzj7WFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gf7xtMja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYmM3CyI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gf7xtMja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hYmM3CyI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C3D77A00DD;
	Mon,  6 Jul 2026 02:23:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 02:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783319035; x=1783405435; bh=FdrKIdLAB/
	th1ZaQt2GbyrG0HZIATngjMZvBAjUDZYM=; b=Gf7xtMjaBNzmxF5ZAT67iiwpWs
	XDvsQzX9cAYJmR2IMHP5Uy7uEWsWv7JlYQFautJTqbPLqscX0F3II1Py90rYbLA3
	9HShUfV8DTZWG50fRkowsvr+SqcRFQqTnMHcXX5/D4VeNz3WJo1602zgwAGZOWgy
	MY44h7Yu7sz/hcbu4dZSritPIfIuq4cSqI4GH8OMysNURD0Gvmoz7gEVA4IAqz4O
	dNTMyi8EEcIH7cf1fU/lAtkVeVBXgraplGqtVUIpvBCpQ/qMj4CVJCD2rbCfsx8n
	lUAkUOXlmO2uu7yc2sDgb1j6LuTg3ORlevcLjNBEZNKe5ZtfYpVzAw5CKmJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783319035; x=1783405435; bh=FdrKIdLAB/th1ZaQt2GbyrG0HZIATngjMZv
	BAjUDZYM=; b=hYmM3CyIQPAPj6nE8OgJWWncw5K8xFxS3gaCmBBO4MgvXKBrFPp
	CSvUwWUuG2GOb9aOVzstGnPmn2r0tt5WtKzEFU2ssSWzeaHnapsW/ba37+bav6rh
	Hh0FSR0FALxATWwLgEwbL2Lt201rK6Cn78lxRZ5+iwKyg0ML1KtqQHzzBwnZDajy
	MCb4PN8eeG8OIyKkuzRkyrMTBUAgmNYz+5Av9EKL6SGvEkRCAS7DxQPERGjjP57u
	uXgkWYiZXbQqShnwESoWobmRDqgYM/k47VJfUzuvBV9exdRCn8kZqcCXDv0ksBqi
	WLsEZZGMplez10E7+bEWrRlLGlRGYyUQJoA==
X-ME-Sender: <xms:-klLaia_FVVgc5A8nIeFQEqj8joe0QsOy5rMoKZCP4EHS3Wrk-LNjQ>
    <xme:-klLasRtMwrl5FFDwqPRiROtyHcIjzOmj-U93ZUSAxvZCgD1FWvWWpo_EqQWzAAj9
    wFy7NitLRTMC9rpg5IkERyRRpsKNpqJ_hLWGrC-x_czpSo8Psv5Uvs>
X-ME-Received: <xmr:-klLalRnRlhIgjJMBddWd6khFjrm5uBgPSyUJm--4yURzZstppr_FeJP5YCH5G0Kr8vRprTJoIB1Rl6e2HqNbn2FzKvSQ4ahhBTriAgzHvI>
X-ME-Proxy-Cause: dmFkZTGV4KO5gsJMUGnh3RULPMZU0Ww4bujjMzwuMNAzfUcjyAxB1d+qlV7w6mE+ATcsCL
    PFnfqO8uy2cJVX3w0MafhZca0yyJTpLf7j7xw/VJoI9jCkRJgwNwJWV5sCm9npJdl6Jxtq
    SXlTdN8mORlIo4O8Mazi0AmTkx0f9LtbWZs1vcnw7Rwmyv8or2zh20i7CXgLYzhr7ui6C/
    cjKwaWPmVX5wbhIsfRPGn0vfrBGMa6lNUHtFGLrcnuclr/S4HzWJkRLBCoBEM7U3HYPq/G
    R4l0EGYPlodg7OrfZzY+bMc5BgorEhl3Yy3HoVvFfygcxQrif+WL3WGFyOFtwo3w9qwAef
    0EqA9T3/ZJZVp7o8H8S5mwBQVIb6YTA7XqPLIEaLZw5g9yEDDlYA20SiKQcOU/7BpGEDa9
    Hote3dXHIEFYzVHwEUSU0VdjK5DpeP9zmxSkUSz4lE6lrP13lwHccRasSf1zD2qy0J5fAj
    Z7Uqb3q+iYGR6t7FmdifggqXh5dxJiuFWN3iuprsS3Cl22qricpXF1e1zS6bD835sdneYa
    bOj+AhVu7x2UZM+/iMD5N4Mu7b5EjEAhDWWnOIcMDPO9ez8F31XtnoZb+0FAqEU2zOO8di
    24g/1xJZP+cXIlcoxixOaP3/4VZ6buKlc7+vM10fEBFVwC/0+nQAr/LUWslA
X-ME-Proxy: <xmx:-klLagSh4HUnjPdLTp6cghoelwBYDyr65qDtsPEFllhNTyaX6JPJUA>
    <xmx:-klLaq7jEx4-SoBRoRhR7rQwsEsytw4TwTBk0s4rJ21vkRMJ8GwqxQ>
    <xmx:-klLas2eankRlc9FAbeglnPecM-_vrgh0ow8IFh73XGHsBq4rlkYJQ>
    <xmx:-klLalATR_4zyCLV6OOtROIlxcRKtBhawfQ6-TKj2effoHo3QtmiQA>
    <xmx:-0lLajvQ29QICt0wXaWdarHtnlZ04map4n9YslatKUMYNioQpxrgwpak>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:23:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 364615c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:23:52 +0000 (UTC)
Date: Mon, 6 Jul 2026 08:23:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/9] t0021: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Message-ID: <aktJ9R4lRhWswWbt@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
 <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-2-79076a7e0c62@pks.im>
 <xmqqse60ht57.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse60ht57.fsf@gitster.g>

On Fri, Jul 03, 2026 at 10:36:52AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> The subject reads "skip EXPENSIVE test that is broken without
> SIZE_T_IS_32BIT", but we need to add prerequisite for 64BIT,
> wouldn't it be more accurate to say without SIZE_T_IS_64BIT?
> 
> That is, the test is broken with SIZE_T_IS_32BIT, no?

Ugh, it should either be "with SIZE_T_IS_32BIT" (which doesn't even
exist as a prereq) or "without SIZE_T_IS_64BIT". Will fix, thanks for
noticing!

Patrick
