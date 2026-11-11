Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433924;
	b=GjZtiXjLWOH8lJGAchhpAgF1oNji90PSozeo8Yi6R6c8bubklSUgdl70wdnWyBQV+iIk
	 mZFhOoNdYKJm95xQJPDOpuxFbFS2dR+TTP5H/T1WgsjJ8R3jaZP/m6lwhc3VvB+H/qvdG
	 rWlLxLs/xcgowmAuP74M6xV7AQi2ECBphhmQsy9mOnNFLc40FRwX68E8eTP5/2mc3mnR6
	 fY65NbP7aKI1yZUo8DuK4aZB0/v3MC9HJ51HvCUEq8fQ0TNs+umHMw+KNa0hHOTfNYYaz
	 vUWpOKFu80QDrtLCPAj80MrwNqvYhzGZgjtzFm+9FJDgNCcqhBt+JxsANvYm9BfZb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433924;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Gib276m8PT57HdMNxqTIwTyuFC4osR60xjZja6kOzJw=;
	b=CdTXUihy0Df0+hRHWWyipszRQ1dRQmk78ikBNvVNuJ8seehaxLNiiIW6yB18tRZ4841O
	 4PZrBuJLi2R60alRr9OIao6YhfwApJ4Vmv4RmQQf+v80N+TtfhbfeAe99jAGFiSEyjjnw
	 1Zj7zLelThdFaXwZvBmiFhtifrOUCXTod4kEFafftOq4bRY+D/UWO7FV01VBfoqh9ypFw
	 xpb6ZWuH7vmYoDY3Pws+UrDsXWoMdt1tnIbHCX7sM2mwN2b3NqvPWUHKuzCcW57jJo00p
	 Ywn0WvPrkapeLPFmvOsy/iAF087GI/oeLsyBCP0O+tQPo0o8/v0u4/UX7DRz1NyNKWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YfomzILT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KB2GRBCv;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152B606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 21:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B152B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YfomzILT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KB2GRBCv
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A5AB7A01D3
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:52:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 16:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794433922; x=1794520322; bh=Gib276m8PT
	57HdMNxqTIwTyuFC4osR60xjZja6kOzJw=; b=YfomzILTeCisDCS0lm1dmAO6wl
	LEpQmQJcOnQ0RKtmBpIqSzsadgNc6bBCLMsGWDh+j3KhyTsswuJWcvBYTGdQOj5x
	OxLLh6eG/WNCGns+0pf3YNf/EhZnpZORKv8aqLbTrgO2CpmTgLf0ITgtwF1R8IKE
	p2gqNXbBG/LUPJW8aaRYmdsMua7I08HhjBUP7b5GSDROJKX/+Des2G4blF/DSzG9
	GI5ZwFU9L0AwmBVjbYRFsvWOQ9k74i6eRhCQ5WlkhjJA9g/BVl1zo+D0CtYi1qQ+
	BacPrmfigVlEJgBOodkPJP3UYuKTg5cOA5yk5MjPhNW6/p90ZCuF4/acBlFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794433922; x=1794520322; bh=Gib276m8PT57HdMNxqTIwTyuFC4osR60xjZ
	ja6kOzJw=; b=KB2GRBCvmsVCr9in0nlcND3Wmk0xb35kDC3G+mJxUV6lqd1EGa7
	YBbCYsb0RbZsK0nATwtj8QfG7a7i//ZvmvlgLoNtlH2wWVjSEXAdGkRYHASiu7oZ
	EH1KjBdSGZE0ZMhhqF79e9bWAMT2F5RGESiDbDiKFrYBBgOrVTZHxyCArgVpAMJW
	4RgQm09VWnIYSr0pyru3W6G9sGRaT5o+DgfbcNvzqpm6LAW2hASAn5PWsPljTclO
	7lUC2FzZfepR3n5o3SSvK4JAC88NJh+nMW2gMgCNx1iFaEe3Z9m/+mytMYShnCFt
	CE5i3otcpf9+qKU3ncPj5OddYWU1QxztGVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794433922; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:D3CxzZqtKW5wUGtrlCv2UdflzIVmvWZOVHwBMoOd/InMZFv
	ugPAulKOSt+u+XsxomM02mnl1dijonCoXhJPZDQ59pRodNw+IflDjRCviPlWULS+
	UMl9U4E2uw8xtszwbw4hNN1QnZlZx16P27G5NI1LAGZO03T6EDSQDrTkMeU/e9Oq
	VKY0h+GCzmuF21Z2NCyL5je6uA+Ds8J2C3bTbuOwr8YU9/N31GAs9ubLSLwxPPV+
	Eu0IKZYreu1pyIAZCh/A9L86FvshbdtjQ6OXeJohiQ8yP1qE6ZiMQ/COdNlovDcC
	vmk8Px8oSdVHXlW1JEpwIN6EYHD5NtvfhJVVZTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EdIXRpeEEOemP5WtCrcGmxm0mz7ku4D16Tjnq4V50j0=:7WLW6PMbUMwJcvSeu13ipWqLGxGjyldJms6laJ1Rkxk=;
X-ME-Sender: <xms:guP0ahkWtWWtJGC12be3JuPC6KjzMkX8ttRxKpvilI3ykHiLjyQcCg>
    <xme:guP0ar7ZaZtdb331_Y1oUpFCRj3TNV2b7Y3COsY9W8WUctt0NFdtl278dGfshxmhz
    mieIGObmq3A5jQ4_Mc4vV1GcYZqLa_rIj2ONh8SN7AoiGlHpzJkUwEt>
X-ME-Received: <xmr:guP0at0nZ1hDHkSm_kiLzoKfRgogMxkMT5r7z5li2_3UQ-nvivg8HdwYIs86RZnA0jSO8PHGQoG5XmUtBVNDQqBr9hWzy6JUJ_CG>
X-ME-Proxy-Cause: dmFkZTFL7HTDAYp0IWO4cTpnVXZK3J82hZjsXPAR+8BDfWkyZwywKN+s1/binx4C87I1kT
    gcV4/dFE2K+wbFxu86Foywy+tdtZY+D8E8/GYMZN6L4aUDBa78UpWsazPnw2TmFqW4QmBZ
    EdZwNjzDeutItsiWsj35Jk3YwkwQw3bg3/hM1HKac5pLEsQQtuGtPHKhoTkKaSjsnHWtcX
    EowMLRbFnseurJAvYmIwyH0XDkZJ0d+Rf+HUToj/E9PYUPygev8Z7qFdNxQEtnmLSVlLgl
    PdBw64Qn5MB3O3K+IpjSU7AoYk6/iYnIW1sXMIzZVD/rictnWdB9MIZ6PjH++wddn5zIev
    JX+WvHwKSaah1Bijl3Q2oBehckAvZMC/Eq5bARqpamw6bkFAjTxUHSB98+uyhRRapjdjhV
    9Y2q+RDzuL0CGhK2U02D+uD7cT0BCtCOMOX+OuoM880XxTKI0eVhHduzswfY6S064cSX8T
    y8EM/CXtxtDoNp4iS5SMTl1zHa/wswaQ81BbV5FMaxMz29AfXeN+8PKWq8/i8UMf+Ut89V
    1S6E5FpfgXrum+YNDCpex53v3Gt8CBJO+Fj2FGkojruGxEgwNm5g1wUaEyHpVvA8eDzgqU
    w7tAxgz/bxVXoya1mpGg4SsGuSdVHS/b5rO0pxognPZyaxl+x9D86PI9juQw
X-ME-Proxy: <xmx:guP0auGkYSwgEfMDQFAkzGYdwKLFplPCYAKhUQIN-UCmn0UwrbBLBg>
    <xmx:guP0akjoX-V6LSz24ZzFV83PsojlOOjRbC0KPckRgN2Xomi-ZPt_Ow>
    <xmx:guP0apCUnkc-N_AeOeCmzpvm7mpuNWGcJSdRwyqmG5McjdeeeLTuzQ>
    <xmx:guP0auTxgU91piFullWF8yxDWjjWAieWROFJ7ajbpajiyED43qVXyg>
    <xmx:guP0amov-a1hC_hbQhfyJKS9P4LuEsP2t_XidFER1xhRvrxNjIzSBw9G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 16:52:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Tuomas
 Ahola <taahol@utu.fi>,  Jeff King <peff@peff.net>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <pull.2293.v3.git.1794427993457.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Wed, 11 Nov 2026 20:13:13 +0000")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v3.git.1794427993457.gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 13:52:00 -0800
Message-ID: <xmqqik23m3y7.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> The top piece of feedback users always give about man pages is always
> that they want better examples that are relevant to them.
>
> The EXAMPLES section's structure has remained mostly unchanged since
> 2007, which was before we knew how people were going to use `git diff`.
> Update it with ways of using `git diff` that are popular with Git
> users, gathered by asking Mastodon users for their most commonly used
> incantations. Keep the example that was added since 2007
> (`git diff AUTO_MERGE`), rewording it to use the more familiar term
> "merge conflict" instead of "textual conflict".

Thanks.  Will replace.
