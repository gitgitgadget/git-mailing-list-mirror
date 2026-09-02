Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0C4AF9F7
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388865; cv=none; b=L52Q+Wn4+YTUFSH7LPLeWdmsKQWAVXZNwRyy8xku6cEkmC1Apsw6k2+XxqYyWgzN2E5Ysfb2TPOW3doSximzFC3Jwvq2RQGs/2aJf6Jam+2ndpYAUf4V+lBNahBgrkMmmqir8JCS5P6/kWN2WHfv38WGmjyxnWYwD1kmxQ8w9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388865; c=relaxed/simple;
	bh=R/6Gf2Qwx6ap0/1r4jurryD/XodjKOor/msnW1xgFQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfeG/yWcdcnIZHYyuTUg60Au5xpgylXJ0tcckqfnoRDBMcFykK5fowXpduqaTQf5aFyaowns2hs79Xpa8zhQ/FUcIQ7wzs3DgIwOCDWi1VPkocBUcMPYOYYS8lJ/vr6i6/mDd3lIuB2IPQKRR++YlEwzYxRex+VC3slwkEod7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kA7gMK3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4d5i3dY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kA7gMK3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4d5i3dY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BA1E7A012B;
	Wed,  2 Sep 2026 18:40:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 18:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788388856; x=1788475256; bh=jG32HiIbfN
	LBUTD3hdNhePC+EtGe777OpyXCk8iESbI=; b=kA7gMK3YxAqEKfR9xmqCvNWvwi
	xtgUwNYUcvishAzAVfSuiDeJoT4H1NnVFsHFwQwrjPtX+IwbOIwkULgcvflQ01fb
	vy2n+e45yt891cDWMTqBAc1jXwruADkdp4jbovnOnakelwp2nSUu+u+Cj5QjWPzL
	J4pOswoCmJLOKOw6bbqwFAL0srhqjzkaZA2jj8QHi9RgMT0yUWSkl/750R7m0Sri
	nsafVBP/IaIo1OASNFiOCiKzlAt1+1Xy88LGHDnj7NGEGV34Ukm0Eyn4j2OSMpxy
	WbjavcRBR7BSYoI6mNtVDF/92Q5zglS2CX42KanFZqVjrtcL2tw90b/qKA3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788388856; x=1788475256; bh=jG32HiIbfNLBUTD3hdNhePC+EtGe777OpyX
	Ck8iESbI=; b=u4d5i3dYxJ8wXNFROEroBO+PYHC3eEKX5FEOKDcaEveGqQMJhCp
	N89USeLI3hTVfrZTKSRlhSFrBO3vXZ9ONBKEul7qtcOveQGMQzfcWA+eTijdZkvP
	BISS5WN2JDKb/jHeEmNVJZD4oDmQpA4l0o0YkLd23Yq+ciC0rbbaQ/ayGQHnTGZw
	oixE/CsYT1Ht5VWwPGT52J5RfFF6XyJ2YAk7GG/UzDCc55UGgizEo4Uf726EXKmP
	A390RLFQahPuxZ/eBRDE35ATS5fkbrQC8DP/JkUMH2vSBmyHuJF3HfDfh5CIUC2Y
	gApvFYnISJE6hZ2/jkVpNqN0fbVZkg4dEUQ==
X-ME-Sender: <xms:-KWYaoWyT_f9xYtAR4W6o43n84ukfaQdj-vNPTERZdR5IBtsuPa4ow>
    <xme:-KWYakB4wIHrW7NrXWQBP0PCRSp2HGNtt8F94T09tyIrTUWzB_8Qg11mqGHpWd9lD
    s9oP5CMXQ4brL7xI44mU0pxxeGHIczTgQrsesAzjAAf_XbwDW1wa_A>
X-ME-Received: <xmr:-KWYapy7eropQ9kMnEiBlfKvSOQ8w47_G8P_35EtDDd7bB1WVarXmNn3fEzCAK3SUJp-leah2FhYmmZJ5yLA3NK0FTureLaGZQ>
X-ME-Proxy-Cause: dmFkZTF+FxHuZAT77/whGTJfOPlm0Rr86Snxx4ZuY7MTgMjVOSKjiHbKlcBDy2ToK2+MKL
    f90zNcvZdy5AtTrXlMKn7GKYg8JNwJQRkCNUt28RItrti0Zp3X3rsjSyhZiKaCDkUtppHM
    7gWmMOhTatt8jZeLaSC/65eVzeC0Izi85UFmp9iqLYWa2XNSSeBjVf+OUST6GFXfQytqWh
    STu6l0/h4z+bNyvd3jnH7LzmW0adAfzHYjwDPOgK2TmjcR4iuTVHARLmp9rHv/6F8HoH8I
    5+PNsIuuuzlX4DmhGaOtm8A6EffslhvYb/HyB2olUKws0oeij/T92Ash8S2T+6e9C9D6n4
    9TMJAGJiuRn2gutKoQs1q380nCCMstpJopbkN1aygadf1KTPIarrja2sG05dN1Dj2CR6Ho
    ULDI5F2YYk8iqqiDvHUSjtaezWwOaf4zyzWfLU+0R0soOR8Xf7obR+QN8+/VDz0oePUmv2
    nyLKNYFI0nOhcOhw9vBC5D3HP8dnD7RiuGcILiuFrszlgesa80E5RzdRqPiMIvJYc0FaBL
    DXrIEljuwrM7mhpevS/cTgjHWPSPBGnDN1o+t1Ns5OyCqgO7jiockE6UdHrOtUOEqfPWGj
    ZuPrpKsWOQ+MrfxYsQUJBqzoqQe6u7eqfV+/t0McNAcNqoAeRwmvPHIR3i1Q
X-ME-Proxy: <xmx:-KWYahCNas-RdC6L3wcXrbcm7qHNc6jYpsTWHC2fFLL6O9NoK-BEow>
    <xmx:-KWYambrO2CHVdy0zeBNypyLqdTHEmmXNPE_Q6yFLbX-cUQERFUJtw>
    <xmx:-KWYaphfmk_DmXWLiri4BpdxaxD_Hxjm5hLQjuWkc7qcLqJBtzAefg>
    <xmx:-KWYao5NkPST6iWaTHVzWqe3U5Ei_5CBUtOEWnMP2BqhzLZGwW_6Ww>
    <xmx:-KWYaoDy3rsogrOFsR-kq-jNaKrEbFUduS6_Djyo20g_mOb_f1fL60ME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 18:40:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] checkout: validate stage and merge option
 compatibility in checkout_paths()
In-Reply-To: <CAOLa=ZSQs5umaTxT6RKQJdnnAEbK+AHgj0n5yiTM0jsbZcyiig@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2026 04:20:53 -0700")
References: <20260828225206.310500-1-gitster@pobox.com>
	<20260830204835.1040408-1-gitster@pobox.com>
	<20260830204835.1040408-4-gitster@pobox.com>
	<CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
	<xmqqld9ksw26.fsf@gitster.g>
	<CAOLa=ZSQs5umaTxT6RKQJdnnAEbK+AHgj0n5yiTM0jsbZcyiig@mail.gmail.com>
Date: Wed, 02 Sep 2026 15:40:54 -0700
Message-ID: <xmqqo6efff9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Sorry if I was unclear. I was stating that the condition udner which the
> check runs is now difference. Previously we checked `opts->pathspec.nr`,
> but now `checkout_paths()` is also entered for '--patch' without any
> path spec.
>
> Having a closer look, it seems to be okay. Because in patch mode, each
> of the combinations is already rejected before in `checkout_paths()`.

Yes, that was why I did not see what difference between the code
before and after the change you were concerned about.

> It still might be good to have a sentence in a the commit message, since
> the guard did change and the reasoning why that is safe is not so
> obvious.

Perhaps.

Having done this, I do not particularly think these changes and
refactorings are all that useful.  As unit of reusable code, an
entire command (like "git restore") may still be too coarse and
callers would want a finer grained control out of "Git restore
callable from C programmatically, without having to go through
run_command() interface", which means the caller has to still
formulate argv[] array in order to call them.  These 8 patches may
give us a good starting point, but it merely scratches the surface.



