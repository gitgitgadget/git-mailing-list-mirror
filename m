Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403770;
	b=X0/oqKkbLtm/yK8KlEAzKFGWsZ+gr1rQwncDnISPgNW8iySP+LI5WhYlwyJgeqE/CbDx
	 DuxhnQmm3qTceekpb680yfGZvP3Yx8Xp7X9Bu++Gqj8hv16fkr3gQ+gInyptv13//HxdI
	 rUBxJYLhD5eoW/SolJgFtnIaIEFJFcvkJPL4irujYTTyPc+t5XhhxPcj710sfUNnBdvj+
	 zdmahIUGsf9donYtAgNx97BTrR/7NaueFTFR50D8utzqcEE3jfrLXmpUGjJZEuz5+v2Mx
	 o5v7SdGDRXq32I4QAzJJZSbaKUmJjLenQyicO5ibg+b/5j7Zi4ki1OuCXZ1175oEvzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403770;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cfNgEQZzE3y0fjjaLla8WL2DV2XFsw+vUynXT6lNwUU=;
	b=naDjWKAcPNeZAg4GU+vCETidiMSWVIgHZYi7nR0EF6JI1gI2Hp0SDOgEnwi0PRjXKZXX
	 ATQePS9QQjN0OJFbHwJHktE1ma+7kDKODAZfFfAk/OMvXvGt07o0eFasZd2IjQuH+1hBM
	 USUh/v879ZOt3LRj7TIywDusM+QhyzLRXiY11S1PdcKoOEYyM2z2JLDwQAawtq7uk1OjX
	 F/VCerXmuwTCoyrLZ/MWur71l0VjWJ6X0tZ25hGsWyCfAguao3n9H5cSgbhK43/YlylCg
	 QxrLHp2MnequwMAdqhtSgiWEXFb6y/9OBJ++WltPl6/s6BEpHffiKz4LCH4uhm5k/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wtDNwJX+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kcDk4FZR;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA16606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wtDNwJX+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kcDk4FZR
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D5A77A02E7
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:29:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 08:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794403768; x=1794490168; bh=cfNgEQZzE3
	y0fjjaLla8WL2DV2XFsw+vUynXT6lNwUU=; b=wtDNwJX++HDD5hWqTbzusBNg3+
	rqXKRjSMeIzHj8pBXYuXJxi6H6WRswsgzN1AIY0Qn8obZM+egqNXo7LkEyid30X4
	SnSKkJ/vKm+GLPZ8HqqCC3PCo5J8w86T1y3pHpU6K8nf5aHpOE0fMJtWpub4u3gH
	NrkZIJbGQLVnjZGTd2jFPuzSOjocnyw0JrJ3VUODq7IpoGSViRb+O3qpaf+3BXIN
	3juKjqk8SiPawPlWndOR5gy4U4TZOR7tnEil+U6kGrvYW1Cm1TCSBBUMUWh7dlCT
	h7sa6CXkhI5cV6AGHwCW64MviFXpYwRW2PmWdTUQtHjf8mmZDcc+xZLnHfag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794403768; x=1794490168; bh=cfNgEQZzE3y0fjjaLla8WL2DV2XFsw+vUyn
	XT6lNwUU=; b=kcDk4FZRobrPFHqm+r3MqseiuZRq5xl8icYiqa0HwmqvpFusShw
	flvoUoKo1FRx98eXS+xGDi+dg9Dr3C0kbHsKW3/Iz6a7ZYkAryhdKE4UiBapYOO2
	M5GilaO+nFWdnrCHynrGX6rEkcRZex7ep3+9JH2dlvHpsSFv/Y07zOExTx5wdTha
	fZG3IwmvI3d9AW6uVbXYOR86I1oarqsJsXMh0qVGCgVRon9umjgPN7xZPikqGIPc
	YovvS/jPR9lvS7yCmdT8ZEdZaBziJVKeR1sGcZ2Fj3WsGjJ5MGQrDFKvYnAVdtCc
	e79yzAbhgss+KfDoPDB58mn254wJln6B0cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794403768; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Q/BBOPO1IaccnjrluJPU+ye8NEOsomYtI4Is6L8oJq+pTzo
	rCKQlCRmTUGYlnwbH4BfpfrPn0xK6aEGl5XUNwR/766WOsNx6Bb7R7xmY6R2Ni1a
	FoIM1FmyqyrMaql7Edp+08WzIlUKX4hvpnEPTujTpx6j3427/Ow0x1NSWcXSf4jJ
	YTuYrTdN0W+BuM4eZiI+spAwUCGywqqWI7vrEZiypRosO9kHwNXgtMrIUZn2cvnz
	h2n2xwhfeBrtw+SHGNdvUJV1xvFanCJrxXb3Tw9t0SGSCeaLitVuFn9Hdw+1ZCI6
	KF9DrgOb+H3coclBhuDv18S/yT6B1f7O43cuYsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7MElQvqoHSlc3V95OWFdd5NEN8IX4hnrKA6R1vcJZR0=:ZKeAhVPqMjOgTlRTLRh/A5t366TKj9hFyZJLPELdKIg=;
X-ME-Sender: <xms:uG30aqf-kvg0p12-xGLrXZfz3pqzHIPOOj2IVyFX70ExJf20_HfLRg>
    <xme:uG30arFdgZZgvryvNIUZOhf2yCXoDAH_rxgOyuXmq0iWUKiyOUD1jKp4rVB2Ar1bv
    -02Fwymgwj0VW0bY4Xbu62DKhkDWUfRD3DPVVNMl_eTU0oZxo6i9WM>
X-ME-Received: <xmr:uG30aj19gM_20ObWiQu_ePoeQNS40EvLalOLlmdZCx4REcpfecww6cE_bPvSUWUFnLdgEg>
X-ME-Proxy-Cause: dmFkZTECNR1j9BoPR/VQ167t8mxHtJNyXqcMZ1wc3WY2TZLeKE7Tn+yU+kDcXM5+761xsU
    /SZ77WoeG6xjvWJ1qwvUnATFMh/nsWKUDCAy7fOg1BBbvtaqod4cmhTKRLokgt0C8e2mr/
    rhE1/GGYCvV+WfNH5n+OelIQauKUGc0yeRFqiz6nz4GQAzQoOqaOdc2gOyIxLPb2ln8dqo
    3qzQr/GCRnss8ufISOWPZ7kepMLPvsUDsN6Ww+GG35UBYkLcBVUTld+WYVzS3tJ6b1PgEu
    a0uUzNVPj0jdzppb9HQfR4JKOVE5xEnQD7tj0A2I2f3mGjsdAGpg+jngSkbi/niExpu5AJ
    q2kfLum6SVwSgbRH224QgzcoGlcXgmXA1Rfp52yT8ETqQiS7SRKe2Y8jfg75QB2NTzxCF2
    IK2UYTCWijKs7CZw/p2jWIizVnRfg0crqlIV6PlUC8CrHyAW76rpSC/glK/r6VMOjJTiuH
    SBS15byS0foaMHA+YUrFthQn3/onW91nGDINjGV+Ytjh4/TKOdl1p0nyCl02uRbukIPgLA
    zFjti7Pa0uKHe1vrc9YnNzmW8u8PNYmP/CHqxieyCGa6vkh2fvy2bcd0Fx/KHRLiFQyKeF
    CR9bmPEuYQMJPLZdJ3QdVyAoaF7cgApPxaTQWfv6Z2pa1Ervjm+03T691YHg
X-ME-Proxy: <xmx:uG30ajlLF6qR-bwOAlz6so0vfkf32fKJ4wcSXPenSrGg6MFJMyJcWg>
    <xmx:uG30aj_6IVXxX7waXwY2JUtBJbsHvDav3XQWtP6D_hODGfJ8uWGbqg>
    <xmx:uG30aoqAXB4kj8g1dCQ6KBQ-N58CeMdQtU5IirYoYTzBmWW2iC2MwQ>
    <xmx:uG30asn-T4o1Y-SxzORmH1wzpJ18Kr7nD_I9iSTQbcnjHyvgd1F4Mg>
    <xmx:uG30apdQlNUy6ji5tCgyM0QDq_y1WIA7-q1LN4FN21_KGM_LRpN_k4Dc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:29:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ccaa954 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:29:25 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:29:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Justin Tobler <jltobler@gmail.com>, gitster@pobox.com,
	szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <avRtsm5VQpC_g9yN@pks.im>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <cover.1794078554.git.vmiklos@collabora.com>
 <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>
 <avRG5r8DPrS23Nmk@pks.im>
 <avRicTWUWuyOuUNP@collabora.com>
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
In-Reply-To: <avRicTWUWuyOuUNP@collabora.com>

On Wed, Nov 11, 2026 at 12:41:21PM +0000, Miklos Vajna wrote:
> On Wed, Nov 11, 2026 at 11:43:50AM +0100, Patrick Steinhardt <ps@pks.im> wrote:
[snip]
> > I don't want to make you (Miklos) responsible for delivering that of
> > course, I just want us to align on a fast path forward. In case we don't
> > revert we can help out and contribute such a default-disabled toggle.
> > And if so, that would also give us more time to fix the issue properly.
> 
> Yes, aligning on what we want would be good. :-) I'm OK to replace the
> last patch in the series with a patch that turns this off by default,
> but then how to opt in, would be be fine to have a new config option for
> this (similar to log.follow)? Would that do what you need or you want
> something else?

I don't really have a good sense of how far this patch series is on its
road to getting merged. So how about we first land a single-patch series
that introduces the knob that we can merge without the remaining parts
in this series here?

  (For context, we deploy from Git's master branch at GitLab, and hence
  my desire to have this regression fixed fast. As said, I'm happy to
  help out with that, I don't want to push the whole burden on you
  here.)

With regards to how to opt-in, I can see two ways:

  - We could extend "--follow" to take an optional parameter so that the
    user can pass "--follow=merges". Same with "log.follow", we could
    teach it another option "merges".

  - We could introduce "--follow-merges" and "log.followMerges".

I'm leaning towards the first option myself.

Thanks!

Patrick
