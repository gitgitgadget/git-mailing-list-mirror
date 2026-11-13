Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553472;
	b=RxyltbcCClAV2clH2hWICRGjZAWJmtQWXqFwCKmc7V2Bof42yxXyAUkRnM84we9eluad
	 osEkB+ViIseRiCIF8hn8ysit+GvCphTzMoLe/7IseTavIE5q4Aqn4KAzoL5l/G9uezJIs
	 EP7ELhmm5Dc4L/+zwfqZg2b/RJeSAJzMQReT0Hkn+eZaRdjqplad5+1kL3cAS7DDIDDx4
	 SPrswYYjeI08wG41B54nFX1aTk1HSeDy8PhGewMHIACTB9C2ixXNxxxXwAK7Ccd7nCS5d
	 jHkVt4Ds2bWoLVepi8oW3vrxNCF2D39PaLDekxLiBKeoWkwlaApG7SklNwH54H0PL5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553472;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ARGbgyMcA3FnEZRyNX6AvFo3lJu3t3K0euLix0xeeCA=;
	b=L5qzYu4BRi1E+ny6Fa0g5e5Y5Xc2uHvjlnCJzhiagotQLGXJza3phjjwoKnCgHoQF9MD
	 N/hSt3j8o2P6eQys5CP+z1o3g2GDfd6w9nftJMvXP9M39JzcgmM4vnQE05Rxz011mjw0M
	 spWiZ+0DxSFlYeRHHFcI3ammUfMPcA77RWf3aRD7kUOGNVJa+VFFDhDGwmfJzNzVYGg1f
	 Om4yRkgHGxApiZh8jJEqBdDs8Uq6QTQjRd1Ajnk5J2WRGEFoQY9E0ZJoJ9q4MaoDkV4jN
	 EKiP/mShVEjmpZAcyTgxbbF4bp5jfL8BJf/Yo5qXj8DwMctoXpYF7UxbX7FJjIAbAig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e2NgZ2eo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="OYqH0v/a";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FB606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0FB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e2NgZ2eo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OYqH0v/a
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DFC1B1D00308
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:04:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 02:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794553470; x=1794639870; bh=ARGbgyMcA3
	FnEZRyNX6AvFo3lJu3t3K0euLix0xeeCA=; b=e2NgZ2eoNvyN8V7eRO8IIYNDx+
	AxCLNpHKUUFV7W/hFKtjXFen1uJO2KHRWMc+advqCMbWT4Yicq6NoONBp5kV77k1
	FbraxLo0sqT0PNSsnUGqk0jRbTNR1sXgax0sCkoJZfijcetAkgPuToy2odv6qxsy
	xi1xhvyfBbtewQg7x2skHATN9zsVuTk3qG4N6bALLlJ3/PlFsNK8PM82NwPfHOgQ
	1F1nHHIayCpueZuIHq1nRNOH3b9pwcdUpn8McNjDGBtVBntVh+/lX12btZP4mzp7
	oeU7id3eN3ruGkPQBee2w6lceAtQJPLErx+uExveLBjvyK4LpbKhCbvffOHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794553470; x=1794639870; bh=ARGbgyMcA3FnEZRyNX6AvFo3lJu3t3K0euL
	ix0xeeCA=; b=OYqH0v/aZscickZsIAF3DILgh/sKbqwC78m432WdI8K/PJLVrtU
	c3JBxC/XMWeZEB3fBYQdlDNzov99a75vKTBmmEchxsc0/eaKrZyQWws1xMEKuDxx
	L5kp1BqNTjfcMfHYtJUrvxu609zM5T2XJTqEnTPN53k/j7Rp/iPMj1PXXFkFvfv1
	LTJQVI4FxpSFzVhopxeWlXfIDwAbjOUVH8Zygk+rZvaS6IqifLDu/oZT00MSYpTf
	OFPCZCh57uGaV+yIowvhuJ0ZOMsuRP4Kfr80wJn/oX0awyczgTn5rm2zuIUQ6Zme
	Yd0wIeZl5r0tnu/6C8xTGgpZvnrv/F9lWNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794553470; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FKAv4jpbuACF9Pvsk8VWf+Yk4vAJNFTady64o4F60KW0ZFh
	Wo3jsOS5FmCfycwkh9lDPjDYbDlKuODl9cw7C+kf64Pxi7JIhPBDpd/Jwtj9zNx1
	rpo0Yp5Gq/mm5Z0E6BaHZ0eO+SSds1HoUZW5sEmLn5GAhcTU9UCKz2Yfri8hfwPL
	+zenXMLpc0F1h57ZIFIZ2r1KpkJCnBuhUlaA5V935dkLxieh06pvM7V9KQjeB3zj
	2XdOHjeUQs0dVNs4JHkLpn8zP39pvJFK+ffgTGW6EHJlc++thgeirc1aypEx4xMn
	kcy+mQ0RKFnJZQpTUZGAxD8vPA256eRnLrUH63w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mnGVOU8smAJXymyQ35+4CRcZmDVHnKUrIL5ARiOzYJs=:WY1EUKxfLfKdL1CsUBz4KJjPfluz3wBUUek3qUzsnPE=;
X-ME-Sender: <xms:frb2alyjLDyOkL_k2gLD1ftc7fbV8ppy_YUH5DO_88eESbZ9EgO4Dw>
    <xme:frb2asIcwzW5buRsIAihyeWFzbsJGy8Ggmq-DBfbF7uWZmsljgTsQ77m6ZJCeeGA9
    rBB-YTXQA_WwUREy0mZ1lYUtfeqETMvRD-tt6WQQ8z8iA6gxu5Hxg>
X-ME-Received: <xmr:frb2anod1JHXGgqv-2wdXGSGJjxdUBr1Wznu_TjUWvuATYJalL1G_Q>
X-ME-Proxy-Cause: dmFkZTFERa8XBegNgayfHS5W82z7bkoMnwh4fSLfEhwyxqPBVaezYCj9x48cLYSA348LHs
    5zMXHcl640YXonu/8/RXc5NM94yS7XF6SFfhcGmfx23jxTbnVDbVpqWsaO0GxH14Kc5/eQ
    GEbUaeV/HYqguGVxtst0i5EA6zywPTjrsR9dgp1kurjFzyCVO5LUP7BSPA/qT6S2eyOOAt
    lL9d1seyfy7JkQePbWo/kLCAQhD41ji3XxEuD50WXTxWqaABR2WqIMenDp2g3tUQN1goqy
    f6w40K/xe47IeObfHZvSMIfluuCoylqRDD0mNb0QLtmwjeFXkN5Unk6FOhhok/6W/RI/Y9
    aRG+1Xla0isCe07VxtJ/VjbX7HLmuI8c5P6LwP1QmMVVVv+jJyaAMdTI/rj/Wt6RpAI46O
    oXOV71xhXGegAn/D6ieA42HhVxKqak3Xvwnu/qov1OhEEmrZSGCTCIMnUMTvjLJKEP5Qyf
    MtoKMxJddNNhOYzNDHoL3tMrz+7eCc8ah4KDBkv7mNcJP+xA/WF5RRa+ZY7dpv7cUZ5Vm0
    qjuGKMfl/NogqmROTpWmuIC4jua6IYeGBfuoYsgsO9eMcgkeizJptqEBOHMcqC8rTETdRq
    vkUbSIH4Z6uXZL5UrHNqxq0sSIcYnFDfcetLpWEt9dFfeL736vKRmhdZnGmg
X-ME-Proxy: <xmx:frb2ajJT5ScYOjPHY98LsNyh8pz8eiKarUVre_pAfDfqZ1oDr3BZQg>
    <xmx:frb2akQVkUj62sEfIRUBxVOxn8VRmSp345BVZOADbedQj-6ngy0gCQ>
    <xmx:frb2aqt_jdXFj1ELUpNuhiULKVz7U7L3tfOkmAgx2C4TJRIgfJzw9g>
    <xmx:frb2atZF0F8ONQvc61ZVCYPUO4eiVs0dixP6gaQ_2v3Y_yOQMICUPA>
    <xmx:frb2ajh9m-RJbjdB54g1yMuFTfwSrCbMBgiDr3IPAeS-Fgj2U7O09Ie->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:04:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8488184 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Nov 2026 07:04:28 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:04:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Yusuke Hayashi <yusuke8h@gmail.com>
Subject: Re: [PATCH] refs: drop unused `peel_iterated_oid()` declaration
Message-ID: <ava2ejke3jl7Bv5S@pks.im>
References: <20261112-refs-drop-peel-iterated-oid-v1-1-7df1c313e293@gmail.com>
 <xmqqv761j3df.fsf@gitster.g>
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
In-Reply-To: <xmqqv761j3df.fsf@gitster.g>

On Thu, Nov 12, 2026 at 10:45:00AM -0800, Junio C Hamano wrote:
> Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
> writes:
> 
> > From: Yusuke Hayashi <yusuke8h@gmail.com>
> >
> > Commit 5a5c7359f7 (refs: drop `current_ref_iter` hack, 2025-10-23)
> > removed `peel_iterated_oid()` from "refs.c" after converting all of its
> > callers to `reference_get_peeled_oid()`, leaving behind the declaration
> > in "refs.h".
> >
> > Remove the unused declaration and its comment.
> >
> > Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
> > ---
> >  refs.h | 13 -------------
> >  1 file changed, 13 deletions(-)
> 
> obviously correct ;-)  Thanks, will queue.

Indeed, thanks for cleaning up after me!

Patrick
