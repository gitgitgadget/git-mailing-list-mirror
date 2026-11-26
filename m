Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722991;
	b=5kxyY8nGD7TbiHB+XTjnC4iSPonJ0ZUn12LE6R9wbA6+5ZlvVIt3wbjhmqt95isDoj68
	 lDgirC6J0YdT8BVHqa2Pi5tXt4nCtcpBNR1fDlxwCGIqz0nE+VCIn1otFA78K+FPFIgjR
	 H9zcyFGBFIeQU1IRstcsgCZ3BgwpZ7vNAwbQqHWJvDv7TC1N4pEkr3OZ82GyzGGEu+iJo
	 6P80vU0E9nZgpXZ8HgEJxxqJaziu7UDI+VV0klHCkPi+I49tfsE+BAZNzE/Il8dvMn1OS
	 IxtrbZo7h5fQrBKhJcx7/24jxsw+gJoh1I+KjpvmSsjTy9ZhCJaEfKvV1Xo91H9oZnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722991;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ix27d5S/XEsa1ehrk3IsLffKtdJ+4MngpE0kzowosFk=;
	b=FEqvB78SSG6VolRqtN09ZZev0sBYs5gyAo5FwrXJhV5prO5lNHLcQ8aYW1g89BCUnNEN
	 Nn+iPHxSk6oAIpqPAj3QhMx6WOr5Jh57pJAVlFsFe7sCovA5+ZBNV9UtRNLrv+sGt6gt0
	 1rfaluvNer+8S4BCtXiyLPbb8y0ImrwUPFEdigh5OF7zBT1BwU1GR9a71CCbjZSm6QB0s
	 UGz6jh2hl2lAdmEMIM23LwuojT797DVWxljDst7IezuKZFaNHm6+/1NnWy2GXUBNOU4bV
	 QnESeF2TYx6w14fMh5TxR9SRzGw6DZjQt98u6U3oo48kuGCsXejTR9ptFnlAl/i825Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cbhR7zx2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rXnA5cyu;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC4606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 19:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BDC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cbhR7zx2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rXnA5cyu
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BD1611D0046F
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:56:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 14:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795722990; x=1795809390; bh=Ix27d5S/XE
	sa1ehrk3IsLffKtdJ+4MngpE0kzowosFk=; b=cbhR7zx2qhWuo6Tvej29eCck1J
	xdvQO38Nb+xsBhAbWk30qsogbjRA2/+Gpfw95e2lfRdn4tbQVBcaQwp9rwQrLQJ8
	n9BlfAlIJ5BqCkdtJjGZ82tn1gmZqhPJV70Fv4z+QrhCzZ/+IrhfIKro/ND5yWe0
	mze5erdlOAm3Ycq+JZ+/B+wUwubl5JqWegTw6qNLdTbJoR+wn6jxcM2AvXwG0087
	DFFXUqpznLDFCoYAIdJGKOXL2qt21cE9W13pLA0PSB/YFHNU8VrRLM3/rFjCUUUg
	hQ97zMt57DeZGshylr+Isu6+cwbeVmli++5p2hu6dQcCJptQ5+Qv+MgoNFjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795722990; x=1795809390; bh=Ix27d5S/XEsa1ehrk3IsLffKtdJ+4MngpE0
	kzowosFk=; b=rXnA5cyuKETO+q9DNSyxEMfSh045zSPjWBcvoZqZxjqtiAEHvut
	dvwCWITzdBj8SWf6DmO/UPp0IdsHQfok62FwHm7ALS5aEsLP6ps5kxQv2EuXNwPx
	zfnq/NeM43+cX6OkLAgQqWs2MXHRtBN+ShBwNvmOwLSokZ084GDAGqo8buEpNqBh
	KGq2DhXmGQg1kfY74GV6zvLDP3FcQ4CjoxS1y6jXiV/8STO6U8cit5HKTo9sge57
	ScJIT7WTv1oobq8tdDDU110421teYpTuLi9LWCf+eWUGs2xia2tKMGYCoxErB69m
	Re8SXzmiEJnTh5HBaf9MQ3QzKhTtIIoNe2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795722990; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WAr/b7X/ILNixHvLfclgXinEeHJ1cTJM9rLB1SnrQDS+hqW
	wv6MV6zkRuM0tq5H4EZq2hxPhF9wQYNkSglcCsfO+BHOLWLdN4OIXxrkMAqGuV8m
	8yNHFxeHtVHKWEJu4Ru4KXhENzkCXIfEuwGhPXvwpTOjfl7/pflarJ4acgkIfUkC
	5bsNW4TY8BeUxfVJO+/EOVBafQsoEWonU4EoTbDvHq7av46R+bM+2qOVWlesic/M
	spDuj++H7j7dR+4C6Wl/dc63YClhQsRQHK5m57XoyGGwBAWQRin012Xh8U0HZM4C
	/uaH8RWslh388rEfnddhu9mu6e8vWRygVPFPm4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DTdS5W0VPN1ouJglrECCjTcvWxgWSnxnkegtIyru/xk=:jl+T+xxCOyBhdqd90gP/hRJP2Ks25X8oKI/T/w45jAA=;
X-ME-Sender: <xms:7o4Ia3jmXmnaChBwCsls6QaGFczMSrkVHpBANhZS1z86hVdmnj949g>
    <xme:7o4Ia7CxRgo8bnbOMrUAiF_4nRDlgwZyZjtajzusyDRRrRoSgIxpcqnO3vYefVzr7
    M_EykO7CALlVBC03-PCpId8Eqc4RkPm02FC8Ewpv83mGomuRUMiO4g>
X-ME-Received: <xmr:7o4Ia8HV578g-GWykS9lhlaQIzV0fJKlgEMfXcKNPVd3Le6mgrCsSqJ7HrOMtDxFY5GYk80aDgtDJZLXQr9cKLyee48KbBdUm1B9Be4>
X-ME-Proxy-Cause: dmFkZTFzzAeTXC5NeqLUWIHoB3u3KHU5THMXNE1jkyJCWnxP7aYIzY/i4d6Qo0owyqbyNo
    G+mZdlm0u7e4D/9JmpuZ7BVFWmnTRQ+eoXfdMk+6sYsWB+7sjK/5mFKuHr9V2WIjDoTVAO
    cV+MehwNXQTM6ORkW8Kz3k8tXvMUFf7nYjNBEF3kH3l4cVpHGD6vM4RBNDaAwPXSzFb4Sm
    yyjmXRFkFu2L2Jl6KSa3piQWO24WFEJo0OKpVjBpPDf4LuOwI2MXLNjYRMKn7MXkwd7wwk
    cY6VBnItl7TBq5q1vkW96IxqVdygBZUvrpH6D+wyEm5wsX0ueT4X2NAm44Ld6zQQJnkUfX
    cUxTbr8cPecoS8iQ0HnNttD++xPs/fnpkd++hPvm7vkfKFgQF527+zRbbpiLr367WKj2Fi
    YFCkeeg+cr/pcjbhyGi69YJfZ+yj7KRPN1n4NY44pipaw9aKcpv2uSAidNrVzzjv6PV/n0
    5wuaEi3aJJ9DBfCsYGLN6/W0zrmH/QsSDwfkYSuCocCuO8WvXk+q+46JwWBMM7DFvbmuDw
    K6bM2TMZjr/9l0aJcGNqILmo5Igp4Hjd+We6W4TWsZoUiIsMpq3Mwf6NDmpLAvgix0cU6e
    WLbcJvtAjDAyNhMtywnXE0fJdV/zqyxq9U3D/gXCgKLTclD28YrIwyp6H50w
X-ME-Proxy: <xmx:7o4IazJ3zUSJEY_ChtXPZUz674nUjY0bCqsuB4P80nahdjifflOTGw>
    <xmx:7o4Iawni689qnw0obkT2JER84bqd6XroysGXJfWvbk7r4It-FgrayQ>
    <xmx:7o4Ia7ShZfES-5HA25HvZ4XvCJcY3XS7QLsZm5yO1ke_0zginujAzw>
    <xmx:7o4IayKlaMntm_WsU-fb0M53VF9UZGuAFj6KjQdIJ-6W4bQ4zX3z4g>
    <xmx:7o4Ia8Cwoe6zDm4QJ3V37L6H1OE3svJGqMnEYfAsZDQm44I-haG3l7XF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 14:56:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 6/6] packfile: skip closing packs marked as do-not-close
In-Reply-To: <874id3sjfj.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Thu, 26 Nov 2026 16:26:24 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-6-19beb83b145f@pks.im>
	<xmqqo6belyp1.fsf@gitster.g>
	<874id3sjfj.fsf@dev.null.iotcl.com.invalid>
Date: Thu, 26 Nov 2026 11:56:28 -0800
Message-ID: <xmqqzeuvicyb.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> When closing a packfile to maintain the maximum number of open packs we
>>> completely ignore the `do_not_close` bit. That bit is only set by
>>> git-fast-import(1), and as that command allocates its packs manually it
>>> wouldn't add those packs to the list of all packfiles, and consequently
>>> we won't ever try to close such a packfile via `close_one_pack()`. But
>>> that feels like coincidence rather than proper design, and the result is
>>> rather fragile.
>>>
>>> Skip over packfiles marked as do-not-close to reduce the fragility. This
>>> should not result in a user-visible change in behaviour.
>>
>> Hmph.  If the only user of the bit does not care that this codepath does
>> not honor the bit, perhaps a simpler alternative is to retire the bit
>> that nobody else uses?  Or am I reading the above analysis incorrectly?
>
> Before this patch, there is one user of this bit: use_pack(). This
> function might open the pack to mmap() it, and close afterward, unless
> do_not_close is set.

Yes, use_pack() may pay attention to it.

But my point was that use_pack() may pay attention to the bit, but the
bit is set only by a caller that does not do use_pack() at all and
managed the packfiles itself, if I read the description correctly.

So isn't it an obvious and simpler alternative solution to remove the
code from use_pack() to pay attention to this bit, remove the bit from
the interface, and tell fast-import that the bit no longer exists?
