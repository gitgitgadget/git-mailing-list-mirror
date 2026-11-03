Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732476;
	b=i9urTbasALOojUc9JCoF/QW5YMDl8IJDlY58dwTreFEelIc8HcE0LCMNF5pmrV0CA2eC
	 BcS9S8vO98Cr3gwcv/t8jEtHy2Dm6MT2Bo+t1G6ADOaSnA97kJWg41Nx4rtK0difee2th
	 CyXmScKxcjXEPemYRWoBHj0/pTjSZav3B2dFSrQJb65EBJlHfNbULCrHOB8wqrRllwe1I
	 LTFZRbI86dzGZTbZKslT86THY8rRX5BSX8Luf5leN4K5WZfFEtRVpEXSPqh63OPK/ZGsz
	 MT6qotkUTEsp7xrmktuD/Qc2T3hdidFjffC+Atr89Ru39S1sqO6l6A6d0O9CJEYQepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732476;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NY8FyFRNCHAwJGw2IISK/o9nvXaLAWr9i8bCikdHkGM=;
	b=hJxHgFO9GURLwGiLtq3pbphEFGhDjlTC+C7WB7oqUjpcpAXCv/uO3dhF9yde3WTqAKNx
	 rgt4feYKeUt7njc/zu/4b1aRG8lz7ZHhFcT4thPcvY+BjfKaa73cQ37VzaeqGgDYpgjV9
	 VwOOdukbdpcng4K+GlZyApsA2p+Fqy7kANHsOvxiXRh1ngHctz3MxK4afEjBG4b05lN+i
	 BO7DbXEQf/mls9CFloD1z+Y/Kqh4k1SUpTVngsRPTzIM4M7kqO5Kc2BuGfK6ksb15d3iS
	 XuFwrjjaA/hOs76gRKQUXBCEBMPrqhb5ma5UjLobthsl737lAhAkf2XA8wkBUb0/w/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f9EbGlav;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EGvkOadp;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A54606D801
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A54606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f9EbGlav;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EGvkOadp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 38913EC05F4
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:01:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 14:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793732475; x=1793818875; bh=NY8FyFRNCH
	AwJGw2IISK/o9nvXaLAWr9i8bCikdHkGM=; b=f9EbGlavTftqcrJvXeTHymUWcH
	ejnKoaq551/FKZ2y90/AKhij0UjUeHWGUrQrnAxvky3hHaPPo3fbupoZeyntzrfj
	0iEwNOlYoX/m6ysD8+OCoaQCLVS3nO4zSoXh3zLZUE0sHWM2xXrYV7UOv0FNnwyn
	XBQDm82JhVGgR+wQowHqF7/tji/gqNCdlkMAiS6mGKkFisze51bxS67Vx8UTWWqj
	+8lSJ0LfTw6ptVFvIlLdIzDacB/dcnUlXSqgFwbYiBWAjVOAYfEH+h0O4F/uVJNE
	3GlspAHyXV55OQKDky2+TfCC43E97kXKaDirNvKQNGpd+G2WglOyEryvcbbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793732475; x=1793818875; bh=NY8FyFRNCHAwJGw2IISK/o9nvXaLAWr9i8b
	CikdHkGM=; b=EGvkOadpq/OT2z+GCipHPMFLqOumcDmUL10BJPWEynGEflb6V2c
	pZSnzoxW+7Or3fXMeurhoTcpXjSRD6h42j7lna34Msde2tHswft3nd/0GZAnTHIp
	16fHXZ5wNnK8vlHD1BcIv0e0g8xOq2xVpN9fR2MVkzRduaPTKnw4zajz974pCum3
	aIJZ+OytoGBrXJ6Ck1Fg+w5UuJW4QNjdEknp79hodM9qyFpofir2IxdcfSenu8tD
	BoGPGp8AEtiu56sigqO0qkx7xUOKfB9Wr9RJSzTih/QmXtvyoSIBUAa5FgKdrnq8
	1C2VwtgicwMlvojLLcUlPFAIAcmso5O0IKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793732475; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hjpvgqt0aPVzCaQFZ3CmCMV+zEb1RcTSkiHNuCNVH5ioxs1
	SMB0HAs83OZ9ybTcGUyGbA/uiBaXxSlZs8n3hSc5n/WVeSn/lMbtzuWYSZNGhZEH
	NgObW63d+dkP+YilAgoPQW3Doj9XesckGaYleJT4AAdSrEZ7uzpE8fshZ9+a7966
	h9tA9Mj5Uz/t4sISGWRK9jdja21p2CSwmUFG+yjwdBQhmCSr4YWxE6tTgnXULomC
	2iy9UyT5GuYGqR2PmgHfcHNY54Y1o2MgQxoZnlVPfJTvwUIdiKzEWze50X/gTBA7
	4ZFcYG3BQEYy28mGcEz0iVare5Yt/jvniFz8GgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zEQiFQUpCU+K4oux6wluEHv8vhD+0IpMgLvro7bWYHA=:kacHqkUhW0xPepFiYEMwKnc272tgUX4sH5jTE9JSd7s=;
X-ME-Sender: <xms:ey_qak2NH93V2EnXUFQzNPEMO4Bkog4l_nahjaFgYMdCPwM7tsk1hw>
    <xme:ey_qamhPMDqpZmA-T1X358qilYRzm5WF4oqhNG-tQCPVzdoOwJuZMkMNuT58iJBDQ
    -3GZIcYV7YaoAnMqqeWfUG1DlZTNan_ayYp9NcY92Dv1FCdOxbTDQo>
X-ME-Received: <xmr:ey_qaqRHR8ZeBmsmFEPTIHLcg2XLjHvO7LIvjxgZYi_1c2LEbJv0PSQGbrSH3cXnHgAINGMjAnSVm2Y1smMZuT-noxYm0nV6O8fe>
X-ME-Proxy-Cause: dmFkZTFXU40AWgMVOcj6xxV1sOLX7hPpPapZs1Ujw7fKDE/6VE8wQeBUumlwJBFJeqMHPm
    2Kfdx6YR2jq4oPfbYMmYVuAV/pSeCJn1REO74rjUqMaHLvPx+uI9Z/OYFmlzNEsmL8kiG4
    T07RVxpVrAATY3pn9T/MLlGKRcsfelZIkTvGFL+KOZeuZUBwp8MW7SK+3GkTNAjlsO6jzp
    Xm5cVY916shJ+kxFB7flYo08oOG08FzeI0L/iXSNH8SrNNmQPEYcJNRPo10GgsJ3CznYqN
    nRlXJvZVnl/LKTEGvrCQHeFr6sEqeSOB9NztATEB/bOYJNF/jBSQw9Fxjlgovp4vjcgnWz
    cVrhgMM48xdBKfxPAF0Dcza/UtKfBlx2UjNjW0ZjdqtcBPDmKTEdDKkmke7Ji5AJGiIN/M
    jNAZ0V8zwSn9ZBDpngYMPxlNRPWi+0VWyuLTMI/8CFEfDAUFXu5eS7FJ4Zu8uJJ2z/Sc+o
    VGYScRwqMJZGmcAop0/cmee/1X9IMt1ApoCmqLvLq3nAr6xRpjFTqWlaPqNwOsBi/X15NS
    Kd2iJ3tkkuIo/8Pw4xILinWjbasJnMH5Ur0Od1CjM2OrlUYehGYoikDhUM8LJfuNWdPCKE
    Qcdjyea3yrkw7BQclDMTHPKTnNJljKPNGIAZXLduCoLOzLzMObQEmtFHihsg
X-ME-Proxy: <xmx:ey_qanhcsaKGufTb5hsXWoTYwB6Ri7MEpQNfrrxs6JRwF9t99oU6VA>
    <xmx:ey_qaq6qmVcq7Z2Rc-hJ_ALLI1uYUzQmhdlwdLP8u3b1zGSlCWM82w>
    <xmx:ey_qakCBv6LmHwHm9TYrIgmPOG6zhOl-noWXH1fF-ZnyzIokGsfKrw>
    <xmx:ey_qahaSfG7-uoGAuvHFPQgogVY_S2zEIJvNDp-CAFXpgjj92V0zJw>
    <xmx:ey_qamqRD1BcDe77sUoKe8_Z3AlrAJDPxAPjB7c4metUd2s5KwaPZd0X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:01:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] add -i: hide init/clear_add_i_state() functions
In-Reply-To: <aum2HcP3BlSDQCGJ@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 11:23:25 +0100")
References: <20261030173956.585250-1-gitster@pobox.com>
	<20261030173956.585250-3-gitster@pobox.com> <aum2HcP3BlSDQCGJ@pks.im>
Date: Tue, 03 Nov 2026 11:01:13 -0800
Message-ID: <xmqqpkwl7n9i.fsf@gitster.g>
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

> On Fri, Oct 30, 2026 at 10:39:54AM -0700, Junio C Hamano wrote:
>> The "add -i" machinery is encapsulated in run_add_i() function,
>> which uses init_add_i_state() to initialize the machinery, does its
>> thing, and clear_add_i_state() to tear it down.  External callers
>> have no need to call anything other than run_add_i(), starting at
>> d51b61f5da (add-patch: remove dependency on "add-interactive"
>> subsystem, 2026-03-02) refactored the code paths involved.
>
> This sentence reads a bit odd. Probably missing a "which"?
>
> Patrick

Thanks.  ", which refactored the code paths..." is what it should
have said.
