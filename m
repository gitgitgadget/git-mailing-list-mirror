Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAB3BED1F
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893093; cv=none; b=CoA+F6lnzG0UQ8mTDiNWSlHZA5kzcU34a3Jr9LN1Ybcp5TDJHVIxlH/tZex3zORpV76Z22oSqLj5kjaOTVUxoKj+5+sxVoZq8Xbha1o0bym1RrT3JQAqyjvoAgWYRpAXr7GD7/2o2t2ByaYnz3GSCgnAs1PrsxJYoTW4sO/qGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893093; c=relaxed/simple;
	bh=7Nw3Huxbn8FBV6gfQKkB9Ab1GSiSN+Xc88mVQEaXiZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBGGoOhoK+74k0PEQKKNNW+10PpBqQQnGmk+EjBL0inWPP3MKAMX5qWQWy/Eplhg1f02cZrsqTA8UlPXT8mAKRnwnf7xzMpGkZgx4w+zdiGaP4wiRZt0zPTPmVojReqjZwdKL7KLrYggewEfVgzRa/Vz1FZ5oksH2VHWUh5OdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQDxGiV/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M82OMV/N; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQDxGiV/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M82OMV/N"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 00E8BEC01A0;
	Wed,  1 Jul 2026 04:04:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jul 2026 04:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782893090; x=1782979490; bh=QSci20/J5Q
	aRIJyGR+qwqG0I1P7VydjzCXzWx8hCqMk=; b=EQDxGiV/SRVDEmOMayIuWmaN2L
	TybmkyHmMemAJW+Tpej+hZWU8fbRJCpMTFEhx6Y7UwigOtjNewz7UOD79ph6lfCV
	jeEKwyQn2t5cKqdgcle4YkVsA6K4gVjidutC0aCKY8Ck8t+yF85bn8UYTB2pZqpL
	vxw2i2s0vRAIISE7H2YW87XaHEnWGbmoX/EgkOWG8z+MJSooNlF/mxTZLiz69rjs
	2H9J83mCU5CTVsKnr0IptfOWC/pddClLO9SYR5VqiV27pcvvn+JKH5m5dAAwQn0s
	tt1VxAq5sfzlZX4RQBmTiVG29ulkgE7SEAxT1HEi2qWWpO96sQTm4D9C6qNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782893090; x=1782979490; bh=QSci20/J5QaRIJyGR+qwqG0I1P7VydjzCXz
	Wx8hCqMk=; b=M82OMV/NTuue5eudOtuexJFCWC+0K9pi/71vG9EyxfFtYf/w/l3
	rSi2gw1RNxIgfyH1GUsz8sCKH3vcJQJy/PbESGN/gsVxolinLiRtCFpn3wfNUVqW
	Itx6tBsh0G7AkyJ6V9a2X8nBqJNXCKm+57rbV+0te3h0kJH+mVKJSv9bEYJfy/rj
	XLN7S2pfQbbPAVsdj1QhUEWi9VNtiis3judTT3/ComfglrkKykiO4d394Fakfax+
	Ek4DnNaUwMp8w0whpm+/mAeZpaSMqPXYYXo20SqM3kgVSt2AWbPAdtFIn9VRBjyr
	8IoP5i+xA1luvCB8KzyDUBRQDjOT4G4W4yA==
X-ME-Sender: <xms:IspEalHtCwFawQRXc7AMNnLCKr7OxfEYcKpgQtVMuK7Kk088EfOFAg>
    <xme:IspEahO4I0khiTxHiTRdR2g4TgEbPa6CZzTosVGGiLynOkXomR90usB24RhU-Cg_U
    eiOvG0sCFxopaRDJoBXiP-FmN7EQoM0Md0Wb9NMN3ZiL1UeKr45ow>
X-ME-Received: <xmr:IspEavcELQo9G0IhScXxiWg9-Jaq8c3znssAsDGW-UcXyc-Tu7xt4VnaB3cuCm2bxD4JCkZvHk1qXC3vUTkF1TSD3Q4Zjbt4CtHzwCItUV0>
X-ME-Proxy-Cause: dmFkZTETTv/kyPNwuGDjqmyK/6aq15svtYeyLvEozEQ7OClSgbAXI2igZrRlz2E8lERlYk
    g2zvU28beGsRyZA626UgbtiCHaIjDtbD5/pW1ov0FopWUNk8jzzSS3gPqsOEbkkjoXmaEr
    N1YK0yQ1qx6g5gDJo4lz+DIf7PDhkIgHBifCXBxilWyhS49vcY/WKjhk3cQZR0YaKR8LDU
    oUbg2b515xDRb0YjOzY3miECPkhj9iW3UxbEYwqiZNJqwHsBH/duwZn4y+b3p10ZqIOc7T
    a4AhoOaIRz+yPmTcISiWA1lQPw2AjLsJiy7/pjpvfVCt1rjNYeU0D1U4na5xKxTuaV3LhR
    2gIM+lvDAVeEgBLzmlLJv4yLo3y5nVb0J1B4PN8tbLkQ0Hd2UIfD168dhSUC5XHJu7rZHu
    LMY9lLf5xrz+lN219LEuw5d3G5y0XYC+F5VXKzAlU52ak8B5NsVqCSilxvO8pPxsW3uWVe
    +DD0UvJB1W4+SAcisfdHvxlzqjaWqb7nZn2+nNkWuLYJn9OxnOrgAoHXN9oLM+ICB2aGyN
    yc0kplJGpX0wUyiUL3O3vpHhUjYEpgY0gUbf7o7u64VnBSE75c/P3zQyvV6jZcxt/7+BQr
    pv1PKAT5NkoUtwwRau17VN11aS3kwB7pQzm95plorTRrRxXp0R6WkwrQcCsA
X-ME-Proxy: <xmx:IspEamsx9hI5jDAJk6AFkrkChbwuq7Sv4AJvGGr1nvgM9TC4Rjt02Q>
    <xmx:IspEaonp8tD-edlFxtK_CJHtBfd5PqQKkLzINUfE_6Epg2DNJG621Q>
    <xmx:IspEagzfhlH6z0AMils1t8YqkBhnNkcorTZupfzH1cRjvRvv9MHVnw>
    <xmx:IspEaiMIG0BA0u0hj4nJXU08Bx9BgRl3QImqsRm5cG8prGxRBhZRBw>
    <xmx:IspEajNNB4Bx33cskDkGfnjdPILGumOI8G5nBC-cD94F3eq_XJ_JHSiI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 04:04:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ccff038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 08:04:48 +0000 (UTC)
Date: Wed, 1 Jul 2026 10:04:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Bryan B. Lima" <bblima@usp.br>, git@vger.kernel.org,
	gustavoscorrea@usp.br,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] submodule absorbgitdirs tests: use test_* helper
 functions
Message-ID: <akTKHfKPsP3-Rn31@pks.im>
References: <20260630020220.1559190-1-bblima@usp.br>
 <xmqqmrwbsybn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrwbsybn.fsf@gitster.g>

On Tue, Jun 30, 2026 at 11:00:28AM -0700, Junio C Hamano wrote:
> "Bryan B. Lima" <bblima@usp.br> writes:
> 
> > Use modern helper functions from test-lib-functions.sh to provide nice error messages.
> >
> > Signed-off-by: Bryan B. Lima <bblima@usp.br>
> > Co-authored-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> > Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> > ---
> >  t/t7412-submodule-absorbgitdirs.sh | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> Welcome to the Git development community.

Welcome indeed!

> It is rare, but it happens from time to time, that we see a patch by
> somebody we haven't seen on this list, and the patch looks perfect.
> Very delighted.

Sorry to spoil it: the order of SOBs is incorrect. The patch is authored
by Bryan, so that signoff needs to come last.

The patch itself looks good though, thanks!

Patrick
