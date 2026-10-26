Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001773;
	b=AKrQ7E/bjjEo20zEmS7TNDp0V32wahqYzwazkdNOp0tw0QplB7BgzKd5zM6hgiyrmK+T
	 exCQZQWCEQhwqDQWo1QWwTEBo/h/mO3sm3PnBhFuYlpkaGF3GxeEskDaJEy2uV+yvQIPK
	 v1W5bcVEApAKdCmr3/EQtnGmREHihxRymsd5+f5i42lz8B+XiUTYPFeuiT6llmjJD+kU2
	 T9H3g3hsprjhp1DJnNdDzC2Dxk8KHSGeMdVIJUA+AfuZmAl18JGdPhubSsm5xGWv2XMeq
	 XwIF1JPxjqSbIQWhKPRHhLyCleaHqsg9oI9bCc1nAANwXy6eEWe9PkRqSCUO/UZnqcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001773;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nhPRHCQtB27vU9CHUjnCluxIcnNffG/SqLtudm5jcyg=;
	b=J9dIDUeXNvzvCnVGCDN4DyndjxNIda1Nyhh8ydYLJ633O0Ad4bpFO+TTUIRHMvwID5Ir
	 z9qEkW4oM4o6driFL93dWJcgvpFydvrQJ3i6StuTSEcWoT+VqE+MN/oHyoT6GFICoXlhr
	 sh7kndlMN1A2EYgdtTNxfes+ZZrgZZAYz/IRa3MmP5QXFkSVhF6WO9V1aHPYmTIgua8f/
	 5cgAONRHlV4Kd0ZvZ8Yk0ZngfRUrkobmmqTFg8aVM4faYTpP41vzTlQAtAanUTxQ5h6m7
	 c3EEK/5YBDS4wawIe6LzwpQstlssGbd7TcfMpwqiGtk8Q9wprH95fKNowooBMHxLRXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dRThpdvH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="P/eygwhf";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A3606A320
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8A3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dRThpdvH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=P/eygwhf
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD3BE7A01C8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:02:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 04:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793001771; x=1793088171; bh=nhPRHCQtB2
	7vU9CHUjnCluxIcnNffG/SqLtudm5jcyg=; b=dRThpdvH7Wp/7Ez7KtXwtPFIDE
	xJT+o8Im56NILPqpBoGg3/lG44VdcKb24i1Sx0h4do2Lr/X2QiG52TA8q+2kc+5V
	elLd4foNGivY3+8o1eHOpWxc1ZF+QG05NWxXpLUMIthWhxLjtdfSwBLdWUIbgzJP
	iDMJMvGxxcvnC+yht3xEYhOtTUG+rRFPTd5DfIEoRghFpf2E0zja3e1jmikILg+/
	nSr9jV0KwKoxcNwb22OaOTrKwaQgNlTxMuduDC1pcau+wegcRx3J2UtjYgpr5neE
	f30181kKsk/g0J7VxyDiKEueCc3miklqZeoCl7NPgmet1K+8PvW5Bo5npmtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793001771; x=1793088171; bh=nhPRHCQtB27vU9CHUjnCluxIcnNffG/SqLt
	udm5jcyg=; b=P/eygwhfV9hroTncBFjRFIpxQEPUl3V/xSviMPB8V+bezRVwrYi
	UjzGFzQK7tgw9EVF/fiiCvNUNpRFAGOmNSUXrE9qNAciPgw2JvRrdOMfpRL4sm51
	uyeiUIMf06KVXDlYinp+bVwPuxs/q23oEAaSntdJ3yru2sheIW+LTQl48OzuGBU9
	YHjK+hsi8Prf4BGPTgbuv/9pzLZhVaorZd9GgjZmmlJ6oZLMxoK6TIVkR8tlRGHw
	Sf6FUcmawAPX9REh0OBvjMxK94FpuV2WOwPUMhx9MrlnfngweIJxZQG7HTipHiPO
	AXH+TzUVBoRdobvowC+wzHa9ccR5912xx+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793001771; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gnukAMwyQr6UjkP2RlgBkPaF/d6Yoz7cQqHLlPklrjBAoGa
	W08Eph+aGQeuzbwICSsN1HnYMelmxfUxmNeDBeoaBnlwme2Rhakkv+tp4cSnBWRR
	aLJ28OcImtZwNRSZrxmPav8DKLaj68+Gdwv659Vj/XtKHUkL6u2g5TDNKdfx2MBV
	gaRTpNbVZJttTPom4ilqHonnnHdwBYRCj+Vh7C+3YQ4jSJcGrRmRl0Y3o+Vh9Hal
	5sDzm0n5idXPatpGZaiTL30o+acB1ueUcSfi08TjGrDSDOFjIq9H+lOi9F8vhyrT
	4Y48h1GhepM77FCac6xGi1OWLiyJ2EOk/D+XuzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fZQYt+BNGGnGQhqFgdqo+ArbpZi7u8lB4dlA5zTi/wA=:0h/auKwcoIK5eWocF7Itkp2Ij0YG2zZcWWPYBX+sS0E=;
X-ME-Sender: <xms:Kwnfau-KnHrgCOIGHgx8bnmUnJ-zZkMscsEFvYfIf1ECCocSrS_HbQ>
    <xme:KwnfamLZn-E92LufmqDLUutDAqJgHxAwiADPg8279-a34uXw_rU3HczRAlsj878iu
    7HUeCdQ3M-5Cc8rjpdtciQyHpYYuGLUExvzVDUAKecoLEg_53_roQ>
X-ME-Received: <xmr:KwnfahajM0XeaQex9JhHav1GAiousRFDiqXLW4Mo3msF_msTQ6ylCA>
X-ME-Proxy-Cause: dmFkZTGv9a12ry3fuxU/m5C4dAKlfkihZWi8A/AIACokQv5iyV3GmcknRGFgpHBgAwgDJr
    v67yld0coKhpsnewnM7dUPeSyhx09VGAZGcLTawFOk+9F9S0OYgrafQh68kWCbhcF0ij+Q
    qGFGI9yWadkxGnbFVr0STqnc6MiY7TBAmdk9dsgSMu2hUAEnZJQ8jAv4A1jrRFlJh/ZEme
    EtWmt1JJ80qXnT3lBdzxYUMPZe1sICknErr476PID6BkbWmWaPnutaaVczWdLjBi1G4doh
    j4ToG5/xb/Kn1Vqw7L9yRH94loHEgPnp9mfjqqaP6Pfr5bfrMvwbIpZqhCTnMKxR07JuSw
    2Cgp+MriVMnJVU4q+ehsnZp8RAjXez/+206xf9TzQ2U9fQaQU+Fhasu4cr6kAFK7gVmx4I
    xSxyNn6BI2315n7WSsGF+PwUwm4tjRQxpmvyyx/0+zJhayVUnTdDvwzbYp9MuvBW2rItsM
    z2xVIzrDldPldIKfSiZYbYDB0vvmtawXBRjac5B+lfsJq4vaRWnh4SCTxq+uUiaYe9g03z
    I01gGEuEvE9vnU2vfixjL+8tL9J3fAC1xzv7wvVxsUoQMu26aoZ1+DNgs81Tprm/Bbo5YB
    PHxWD/XLN6E78lAll4aiJpwv17rgFD1LnkkmZR0V538fAUXWJ1CxxMKXk0KA
X-ME-Proxy: <xmx:KwnfagK4lDDBlirAEm_lyiawZY4u1x_ghRe-6izJm2GC936ztixMSQ>
    <xmx:KwnfanCg3RRvxgliS9iC_Gd2m5gE9aNRPTgm93sblrqgLnFm5-Aq8g>
    <xmx:KwnfatpwUxK7GoQ0RfMt6l5w1AD9Xs_oT_dmjw34_cvEiiIGxtCAyg>
    <xmx:KwnfaqjytUe4MUYuc5XntZKE8L-ohUq4BzBnAzAqSUKDdDb-P9E24w>
    <xmx:Kwnfasn3dlFlh_QXAITvqoWhur1jm1AAVFvpjgkTvinGpl_coD4la0EQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:02:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd436edc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:02:49 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:02:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
Message-ID: <at8JJryJieygimcm@pks.im>
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <aqeTas30Vs3aGE9D@pks.im>
 <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>
 <aqen3lVdecDqo89w@pks.im>
 <CAHwyqnWL24G2KNPxhiems4zzU2qEjZE0_jqrJuHXCuYp4FUR-Q@mail.gmail.com>
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
In-Reply-To: <CAHwyqnWL24G2KNPxhiems4zzU2qEjZE0_jqrJuHXCuYp4FUR-Q@mail.gmail.com>

On Fri, Oct 23, 2026 at 06:48:39PM +0200, Harald Nordgren wrote:
> > If you look at the pipeline though you can see that almost all of the
> > jobs were skipped. And in particular, macOS wasn't tested at all.
> 
> Here is a rebased branch where all macOS tests have run:
> https://github.com/git/git/pull/2402
> 
> Would you have time to take another look?

Sorry, I seem to have missed v2 because I wasn't Cc'd. I've responded
there now, thanks!

Patrick
