Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644809;
	b=qsetPnl90UQ2opjmshqP2ECZl9+5G8gikGLqCOGFBjUXaSYOUFZf4YTPlIRi48tVHBSr
	 6SVUk6PnFxjNAiop/KIl7CFviW24Qpu178Zzt257UbHp3dadp92hrMYfLHpS4RQLh6oSq
	 yPuXvoYTiE5W7ZjZ3tmOCYiTLrfGIArKaZfjFcAl1nXcOmoY1BTK82gn+6GA73VjqnZnw
	 As9SRdSz+ge6ozsfHZZnweGNoFok74x9RwTH0bpYVEFPiFQB5F01Lf9y5cBz/vtFjXx6n
	 lILln7NrR8jWSCsQnpKV/taDmQYiTzLGQbcJfzukQzJEttOW7ua6KBvYZTu/Cd629fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644809;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wge3W3LAoemyDni0yHCgfVQlSbZWFRCSf5EtKFqDyW8=;
	b=KD6voJxAZ1LSaMImrXLcQdlLqnIYhS/DGDHyEBzooDjIZ9hv30S/E/vi3yAigo6kL1ah
	 rJvs7/LCycrLbKgGQ7+l7KSkZ/KGTPKC5C3/9426UrvymDu1VVVh5nt0rizgek/9Xd5+g
	 GQN4oaZ1J3hxyu9Y+1Sm/t82kCPKd0dMUFtSggssfSRtKr04URsDd68WvL9jFVn3KAPbh
	 OSHhjfOgwo6catFJm8xpaMj948U4X9c9JCo6mkbAI7hNENCpN2xR8g6fm+5XzZK8d7eDi
	 R7mQpR39/DF2ZR12JtTh+OJv7vb+f4mQkxF3dQfRUrvq7rjJ6AEkee/WyDJZgF3atsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CHZY6fYs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JFLCuiC9;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD358606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD358606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CHZY6fYs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JFLCuiC9
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F4751D00152
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:40:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 13:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793644807; x=1793731207; bh=wge3W3LAoe
	myDni0yHCgfVQlSbZWFRCSf5EtKFqDyW8=; b=CHZY6fYsk8k7Oci/sdiafljJmU
	sL5QZZ92CYLnt6zos54w0p8zDFMGMR6OXRPFMuHaTUbJulDrM9uevfQNQySOSWl8
	OQDY+OqwNlj7ttRJqNEKTEiW98TuNCgLTvCBANTByQPu5etOwsV96+OW8NcqakW6
	kU1YCJOrMXRmi5/B3O6rFhCxUmEJHKdo+5NYD3kiRABDqVOIZ+8lcbmr5vZS39hL
	5PWLlyIHeJNj1AcmFP7X8SJfO/uUGfYXD+Z3uniKtwb6gQhJKecc2RrdXaBIQRfJ
	wtvtO409ELS+FLBjtgVxBvADWlCFFe4AGRGxlxw7x61ivxVXKFkWev3mQkxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793644807; x=1793731207; bh=wge3W3LAoemyDni0yHCgfVQlSbZWFRCSf5E
	tKFqDyW8=; b=JFLCuiC9MInXo9cP0QTU9VwWogSg/rH+Np5loxkucm5dJeEkaUu
	pHQYszmT+pv88KoE4kAxMZXNbhcm3yZ5CahRSbMO691HDHGI1I635vtxG6Vj9gcN
	ZjT0NYiUN/Vhj7eCoGumVNO1QUrfBPOCFbj+bMlcjCdQJcbiHT87v41wVstAD4Ui
	Law8uiP09eVMi5Y/u1/KOeFfd+/euO/tzfg7MGeXJeDwH0/wOjfw9GOXQS9dIp2q
	S/o7c4KKiWO531kufR1bjIkbNNx4NBtjSPzVaJGA01vqi2563aGZ3daF3e74czg2
	SEHvxyJ2E8taz1hMOAjo3ZQlektpo6QqEbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793644807; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lYZSnbEjDq9Tl58EMPsXorkyomXkrgFNUQ/ObgTFTbv/yfJ
	e/+lBklz2JlSFVVuggbCpLUo14l5bxMkstn/Uj/ojopI4ZekxrQ/e6WJ8O/OYQdJ
	luvLtGfOU/EGf2FjthVkqw1l2MvPNztTKpBawIiJbHOxfF27SLxWrtrShVXc2faz
	6ex7Ozf09ubisjblVP0ZPzAhoDXfagwqNS829hzjXZiyxFD0dD0TnLsOSdTDe3NP
	bETOLMLF+Y5Lt6sOCppOO+xWRWDMh69mrTL0wloGEsqPHyn4+97Zlam+4wa2ZDnx
	ttNKwKdnPkblQlahyHRRF0WnsDor5Mmv9oBWFbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eL6g+GHvrebY6XnH+270w/8/k/31WTBJFTjh56n3ulw=:P9+XeOWsnh4ZQr2AfYfygR5KeQ9RYxOkxbw6akp77m4=;
X-ME-Sender: <xms:B9noauuo-FBvG7DjZRbZT5_qhXByIFwhL8q2ov7TVjhuIooUaNJcqA>
    <xme:B9noalsSFWMS1VP4X82rgJlW6sBfMWM2BbSGi6AHb3WL3sLoOqLkQK5QtCHSkj3XE
    CdPmNlfwlI5WTLNmOR_0YwSbdGRyQKak_Cew9ZJvr5tFADDc_LuEDU>
X-ME-Received: <xmr:B9noasBunt_JSNhnlLGs3De5cJ5HwlL1MLeX7D-spderVP-UrUFQX4EqmcrrTo-2RPp894mIdFz5n6RP_LWyQYFZdIl_bV2_uMZ_>
X-ME-Proxy-Cause: dmFkZTFdwfhPs+EJ3JpdCR3HVenCqEcpxPKDo8jff+oB6aWzN0lJZSgDTL2KjtddUlwMDC
    NVjBqzTOcArZ4RpkxCOW+PClYQaQm4IuUsGhB+651dXvM0jCgc11na8TzYZhcvenmOrbqK
    lCqovryDMa4EuFsA8ZnvwE00ItO3EBJgqVnsPbR/XsTQeHZUbSHVm2O53kcO/D32q4cNUl
    J8dYZ1P+IT6YGshXi4y1s9blNM1vrTvnX6j6N3KgDabRnE6T+dyRaRM1Sv+jtf9C6NFhgo
    qb5vlnXfycOxS9yHM/Wgd2R7URhvvMkp3PAJkWp22hsZ1ZJiFsCdH8JQUNDd6sHVQ1iMPO
    LxxTUL2aQ6qFGwQ6nOCZ3WmTq4cvCNJKohhLtDFL2StaakrpfPjhCkiMRa2EYmWcG2LIZv
    l99oer/+iEmQfmXLPSSBcnhWKmnZ/S6IxZj9yflVGnXmyM9z19f6vV+W/sDGcnIBV+cIW/
    Ppx2DruQ0enRWPz2L5HFwuZgG9c2dfwsp+PyJCMpkWofGyN6wNXyXl3twEHWiXH8qwqaFE
    KB6BOKJWuPDem75ML7LbJIOAh1we/oc05fug7ZT/z1iXXa24WJ29Edm3HuqcOpubxPCsxA
    qoZPHs2UFTsctvhywcRdopnwhjRO0uUsw4IFma71Lq9KB+q2VAxTadAoejqQ
X-ME-Proxy: <xmx:B9noavMVpbWasHwRzEctccosZrDRPnZFVNGEv95PN2trA_MROyHe2g>
    <xmx:B9noatx-u-bUBOTc7ToviYOnsgrhMgXzeJmm44JglrrMq06gAZ2cFw>
    <xmx:B9noanUL7L6fKfGinQWN7icicfi-FAaEvtaBweO1pvzCZq0csUTDvQ>
    <xmx:B9noanNagtbBGtGtHLKLNQIhI6j6k_p2aqkX9WPxLn_8tb7ronk4fw>
    <xmx:B9noavjD1jehPndyS6PTbARXGjtWCX2_9QwR2vBo7aKiORn4gGRLlFqQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 13:40:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  GGG <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
In-Reply-To: <auiBFhXI_xiBTPbg@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Nov 2026 13:24:54 +0100")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
	<xmqqtslzlhbm.fsf@gitster.g>
	<CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
	<4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
	<CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
	<auiBFhXI_xiBTPbg@pks.im>
Date: Mon, 02 Nov 2026 10:40:05 -0800
Message-ID: <xmqqtslzhybe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ... part of the review is also the conceptual direction
> that we are moving towards. And that can only really be reviewed by
> someone who is familiar with the project overall.

Well said.

> What I would very much like to avoid is reducing our standards just
> because "carving in to AI is inevitable". I've heard that argument way
> too often by now, and I don't think that it's a reasonable stance to
> have. It is very much not "inevitable" that a project must move faster.

Yes, I very much agree with this.  There was a release few cycles
ago where I blindly trusted AI generated reviews too much, allowed
topics without human reviews to be merged to 'next' and 'master',
that resulted in quite a few immediate reverts.  I learned from that
episode and am basing heavily on human reviews the decision to mark
the topic for 'next' these days.

Thanks.
