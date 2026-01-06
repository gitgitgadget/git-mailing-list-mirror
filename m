Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D90156237
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684344; cv=none; b=q9hOgNoPtAN29eucc2C4aRdlXcWM7mhCe/XxaCh6pNgPUQ5uJYQDVMEPkihKD/ckuQdMiOEZdXYVAhS8rCik4arOFJozQZjYqDmL5+IOC/wzJemGGBLZqMs60WqStfKoQS9LpzX26kj/ZaxP8h0zeO5oyUCBDFl8YFLwtDIJAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684344; c=relaxed/simple;
	bh=OmDSmNu8pSuMjgziqEKJ4ijOY7qdAXLJFqmWfaWKkoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txDWXIG3tUmEF/k8h4i+8nsPcj8X3u3TFwH17fq4Rs+Sn72ESqYspv0KidJ2GR/rCUmyd9xk7vtBtuL5ikXtkeAS7wlI23+eawe1Cy79XGzjCAxD88vxudfb0HsjpAxKDsnw933r+2oARj198YZD4vdMMZTRne0QiP6YLEU+yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LD//48vF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2w9/W0x; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LD//48vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2w9/W0x"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09B777A0021;
	Tue,  6 Jan 2026 02:25:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 02:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767684341; x=1767770741; bh=+Q3IbsLckk
	VJkHFnwcscWgOdRCG87Bve6ISrPkS8M3A=; b=LD//48vFpdelKvvshVsoDal1/f
	azCYe0Zv/ICuXi/b2MHJe3vKI5iRiaupBfRhgMAcLUN2W6MWQwFZiKH6qsB+Jx8+
	Ah2+vA7d1VihVN3sPtUHrLsCFvhcBXLjymDo04JhcfQail7rby7Wp/MCJSaDo3ks
	2UPT2jvXTUrVYmOuEuUkKhMKHj5RMSYXpAKeMoN5lmjfue4t+qZa6XKYkKDY3j1R
	US9gf0cNFH2QXiWhz59rmJOawP1RyTed+QBov8j2wke1aA6YfqrIWcT1fWjCSzNg
	Ne3QL+r6s5Kq3mRb8WynLAWq2QTmMXW/Z6jVchRrKVATZGTLyGjGN4RdXWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767684341; x=1767770741; bh=+Q3IbsLckkVJkHFnwcscWgOdRCG87Bve6IS
	rPkS8M3A=; b=E2w9/W0xsbogTlELomCaFkjryfmps1i+95AO8n55139X5edOl/c
	ghpxskqTD6mdrfqitOjkq7Wf9GY7OAryqryfu6YGdPwHH34eDHtDIIFAeWz3yXQ6
	jDF2438VwBrGLyWVQk1FJET1A1AVSEqpOyY6CIOCJOIzelu81hJ5B7MTqVDaq5qI
	FtCvW11qPle6Wec0evz80+VefDgsgrK/b5UCh8OWLsFMqvSGUeG+t0WdwPK7EDts
	a+6CooVkho4DOCzktmjEMjKFZRLIyuHo/UQQAbkfF5Imb7g/SpXznzwy900e3hfv
	ffF4nMTGyD3PHUe4TmyG4Jt8HARuvQ4W6Vw==
X-ME-Sender: <xms:9bhcaWS1uanhwuXAB9AxyEq8af46yLndkr6cEUfDhzEmtm1b9BgEGA>
    <xme:9bhcaT8krM802yqrJK10sCSJF6lOpYp8gKl0BkRyaClT9WKJbg0pcshlo93cWXMkV
    TFBOyC4fuQWpAyTuRNWx2gXHV_M6gclIC23MkTm23OTYQwvYlbulA>
X-ME-Received: <xmr:9bhcafbKaqqT4vRLr_TOemq3ViJekSCirW5kySu_jBNXhOGL-A2mq0-PYerj14s13KBRBFe7fMNUKUVjX2p_F__9GxFAQxfO8lrn6wBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgr
    sghorhgrrdgtohhmpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhm
X-ME-Proxy: <xmx:9bhcacr0EVOE9S09dtpsZ236pKpfXqRxI8VjXfZwjckQnRcq-myH_g>
    <xmx:9bhcabT5GE4lKPVVV6860N2RysiUNhQ3AWnwiQS2eslDCLicTcOj2g>
    <xmx:9bhcaYrczvGdU1KAe77D0m0NCQVcR4OvhiTGRll78mq4vsBZS54nPw>
    <xmx:9bhcad39OpqK6Gqts4Qb2N_yAfk_PqYcOL9ZGudmQ5sKyTpCjReLeg>
    <xmx:9bhcaUCeRAPvgrIv_rt8PB1TV2L1-IGf9z2gefRSJHH2T3fhKkWFGknj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:25:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4cddcee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:25:37 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:25:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 00/11] Add submodulePathConfig extension and gitdir
 encoding
Message-ID: <aVy46Y9GIMlFCzIq@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>

On Sat, Dec 20, 2025 at 12:15:17PM +0200, Adrian Ratiu wrote:
> Changes in v7:
> * Simplified submodule_name_to_gitdir() code structure. Logically it still is
>   the same like in v6, just easier to read. (Patrick)
> * Reworked the global config to enable the extension only for new repos
>   during clone and init operations (Patrick, Junio)
> * Improved validation of existing submodules with encoded names (Josh, Emily)
> * Added more tests for init, clone w/o --recurse-submodules and a conflict (Josh)
> * Migration command creates gitdir configs before enabling the extension (Patrick)
> * Reworded and reformatted the extension doc (Junio, Ben)
> * Reworded submodule.<name>.gitdir documentation for clarity (Patrick)
> * Added references to extensions.submodulePathConfig in error msgs (Junio, Patrick)
> * Minor whitespace fixes and others nits (Patrick)

I've had another look at this now. Concept-wise I'm now happy with this
series, so what remains is mostly just nits. I think that this series
should become ready in one or two iterations. Thanks!

Patrick
