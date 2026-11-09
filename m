Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200967;
	b=mdsmrKwTPlbZZmNrYKUoO7Z85U1U3YegMJ2ruOtAVJkDuWdu34EWM2hRmtAwoj8Mmr+M
	 5f3f0pVKr7sl9vY/XQ87ybXJP5kTIouN9AN6qfQr0FAaUpvEUJ7Mlaiv5IwkJUBWmsJWn
	 kNz+h/We+qoOgbooRVSNg+5GdKgAz+kKMzbo7/gRFNaBSxgr3lCM8kI8r/E4tqfs+5DYh
	 w2lQi3Um4djxoujTYqljzQwVbMrJC/w5GZymoO9gcBqxyzVfQyEmnAo17CzIv0JAhTDuP
	 RXRj8gjx9V0ZuBXQ+Md1oayhJLL715q2ycgNqAaEyZprVJrtYNguSvbq92Endb2Raww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200967;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Kb6lG6qzR7TVZubWFpiJcdHMUizGhm+cJsEyg3ra07E=;
	b=EJXzUBWv2h6oQcwTz5/rh3LMvG+JCYy+jh2yIiJlsSj7ck9oQroRcRsyvprLeDs5AdnD
	 p+efXH/R8tBs0Kf0D88RBS5LNuDkCkI1XdYA24S1xYqep3dMJiC8RRNsSWlSM4wmvQYSm
	 GNsfZDhkIE26tYwTt8pflapn5RH11q51j2dgnvmp4ZXn+99sCPDeXo/8BvvtmLFBOSArF
	 KNh1zqdDU6p1NHrkZJpetx8+Da3dJstiOU4h+LTPeeHTXhFJiA/iR8BMG2A5jnbsII/4c
	 fol3DG9Mp6maVm9OKiRZTEiUhCA0Vdc2LhlZ5Bs6NOt33sCupPY8UeyxxhHrDtuGA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TKDov0Ij;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nkOYwdVJ;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740A606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 05:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7740A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TKDov0Ij;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nkOYwdVJ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9673FEC05A1
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 00:09:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 00:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794200965; x=1794287365; bh=Kb6lG6qzR7
	TVZubWFpiJcdHMUizGhm+cJsEyg3ra07E=; b=TKDov0IjLSbpV78h9wDvKqR61s
	lFEklKJaOs/na2q9E5xixR/kX0mI2x5LecfpcXHrPm2/rgbDByyDRSlRSSkad1za
	n98XLpdIR+UPRMiZbVIeLLb5iT5XXq3e5XePKZpBAsOpyXcJsOgqdrfr+MJ38xbT
	UMtU5Tq86fukfU79GARy6S8OsqU9/o/1SJ3ziWuQ6PXATTxxAr23wE4aMwEOXNBK
	gJLwOuTNSlq9hs8oDPhicJX6bXf4UC6dilMmbJGrAsvCwuvpwXv28zW+Mc+ro6Zj
	h3bsQjoBfN55602EeiRnjdWcoFn7sS4f48Z4DLBkauXWuiOsB6JG080Jl/1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794200965; x=1794287365; bh=Kb6lG6qzR7TVZubWFpiJcdHMUizGhm+cJsE
	yg3ra07E=; b=nkOYwdVJvge4X86FY+WSUYw+D0NvEIB4NUW2MW4SSXpDrkOzbAE
	leDlqVnxvnLlaUhoy2U3NNZ59o3HRnLBCwPWqD/qTYW6hfKU9SqXPAfrequJxPD/
	lA2FUzXhwkQvQwrXCwOT0Jho490ZsInM/m7gxx41i3enVMbGcupcr12n1So2FMa7
	eDshTRViCZPPpFe4SU4F26rRRyGP8gzZvur+lQTg4k9QXwkUsjcPIUh5WvuHNiIb
	qZh51LJVrcJqBc4v//5pJkirwPr5h4ywrpR0DCvrDRz7DLwPeSn702u4cR+SZChg
	EU9cpHLurJrrYXI4lM9pq2AuVUIKTsG/avA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794200965; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JNzCBLAfFQCYjcdVqsNanF7WgoQxZ/ixWCg3pZZxVP4ishH
	8PNZUG/JsMZ8F+fleeQc7OykOW9TTnGRVQXsGLqDrwioYtnlXeSlH3Q0370N4JNx
	jmsQpYewgR5RfAtlYRB3TxR9C1KcObZ65YcAAkCAVXNAhUARBEgyONi/zVZjsi9i
	l5+uWBVvfnRKHENffxGK3wv2zebHcNdfzZgaUzWceUWI/wDfuIcg7tJfZPiybwnH
	B76W0AV/EPRXo6yzXzh0ErTJTPk6zHlNn93s9fSpcMzSUNNZzm7/lxW5duTMw7YA
	ccYvo7xN9S64HPBVNP7sQLGlL5c9rhCdh+xd8PA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EbmeV2t36gXCsYGvnhtq8oFL9jVRdRWvhVqy4laIGHA=:josyS8FTIWQwBZfIzpDIRBADzXtUN+XUmPksZChd3Y0=;
X-ME-Sender: <xms:hVXxavvx5btZszqRuYy-xxCg1N14ee949iECFhDVaNnCfqKiQ-6gZg>
    <xme:hVXxandK4rhgD15ma6ksQI1JoyUNclJ_vEFBD8IZdMHcmycxCCDXKlVnofqLup-0C
    JLpziMIiOUOncsDpmyyBVGEzTjwtReSLYaEVNC2Fhq-nOq4_OcRsBo>
X-ME-Received: <xmr:hVXxanys3kwjQYd_os_Scpf36mzL3cMM6Wecu_zkMk4qIuOMRkN2hJtUx1SoT33CxsbpeIZjlJrgUTqocq7RUv0hZODr9AfznIqO>
X-ME-Proxy-Cause: dmFkZTGhwpSKgxvTbU03dk2bvS9tbOiW402Fayy00gH9VvddtiTY5tIUWCDPcWTZyJPdwI
    uoswjEIYev7OE06vuoEhrPBm3dh2zn9kemJQzxm45uvAFkTvc+cgc2/AHqUN21y5odWOYD
    f67KLkvYGacAu/lM7mFnxs+Qh9K8RovNhqAMOMuvQw9608IhOP112XMeQeCpWMpahCw5qv
    UgsFaCgGT0ooWc8jMfeicEtMgWin6zak2NH/ufVr8OoB96UgdZAJ7xlkGhT8kj9ZMj4SIE
    inHXQSvsuSkyzpPUmCYtrqrdB6FKywJLv36ZpwU5ZfhFGCqkhEpMVh/bWZfTFz9HqHmmXY
    FNSbGmUgwLAhZGGEmFyCKsDJNbDhuddb07IeIYtV7JcB4WQq2To8cPVp7ekVODzXkny9DR
    IVgXV8xMNyFHUKGAjmfUj5+sO2JLuBsXCj3cdR6Od+842ob4l85fPtXYyqIHH+B98K8Aqm
    lvqHPX7gXtNK0yAIjLKr2WfJ5bi10d23c7OOIJpF3IP2xtAm/o15tGQ4GxdEKktVvhAuA5
    3jvj9x+pKxxNdn4pHdIQc7CTKg58LfFw/QyOqVsbU8vEC1k0Q/v0IM1YPtX9Ry7tb3XwMp
    zEp4I2gsKxk4Xas97tN37MLtBfDYvlNxZpNRKOg91OloDWSKXi9Tux80TzuQ
X-ME-Proxy: <xmx:hVXxatHmNi0pZPYw34yO4a_U_d_KzwJIxICW6_vLDnnDwnjPIU8shA>
    <xmx:hVXxarxCrUdrxF0i5-m4eIRMJV7kC2qDzTfMkeY5lltyoSsu7ERHGA>
    <xmx:hVXxauufoAocl5yq3LEgSe88tZP2FoJ-FWS-Hm_c1ndi1GxdAVKTtg>
    <xmx:hVXxao1MoJTIfup_p5VVvcqSjFpNCEBViQYrGjzLIDSf6n12jK_PvA>
    <xmx:hVXxarTF6_2WmvQhR5HOkRv6HPf6_f0Z8aCNj3n9BkIAX8ImKRqk2l8o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 00:09:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v3] doc: describe promisor remote fetch order
In-Reply-To: <20261108195518.943-1-husainsitamuwala21@gmail.com> (Hussain
	Sitamouwala's message of "Sun, 8 Nov 2026 19:55:18 +0000")
References: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
	<20261108195518.943-1-husainsitamuwala21@gmail.com>
Date: Sun, 08 Nov 2026 21:09:23 -0800
Message-ID: <xmqqse1a1th8.fsf@gitster.g>
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

Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:

> Explain that promisor remotes accepted from a server are tried
> before other promisor remotes. The ordering was introduced by
> 8808e61fd3 (promisor-remote: try accepted remotes before others in
> get_direct(), 2026-04-07).

This iteration looks good.  Will queue.

> -until all the objects have been fetched.
> +until all the objects have been fetched. Promisor remotes that the
> +client accepted from a server's advertisement are tried before the
> +other promisor remotes.

Christian, perhaps time for an Ack?

Thanks.
