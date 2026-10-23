Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765996;
	b=3C0whrCR3IcpRU6/JQZ60r/jNiLiB4EJ3U10EQ9RbB8WwpH1YRF+niirt2oUOYWierae
	 UwPR3rDBsTQ2Y62IL3+MGMwVzzX+CVKDK55U+mYuLuhXhKSb9l0YL3R4HWh+VVggNgaQY
	 Kw3rZ/kctQu3xyGRUgmZEq//BqIbsD0ChI5cF7Y//aymUmIBhEiNvW64bL0ZC+qh6NQRu
	 X2A5U5SZxxjiyfq0Jy5gyDTxyqbdLRCto8tKJqHnPZNoOJY9lNGLPe9Eq2zD78qUHdIIw
	 t7nRVmJAUvvzpZUjXlECI1ke4KZaEMlvaUY6FGTItURwWZhv17aR3cCfrCin7aVH1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765996;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=czRGt+G5lVfdwWttY8aRL3Ehgb6vnpiZVhgwjmFlc94=;
	b=DbX/+eGl3efnG6acjafxCQ5nWFwJoEPL3s0RRblO1SDuZt6QilVLVKgrXQIit+VMZ+rS
	 hxpp7hu6NzzPa8wRV+WyrFmQ6btD9HFRNR3IsXwbEvnkFx4p/YIcfHu0yUvVgndkQXdZX
	 ZoJ6412HVJQJaHrm7vc/rLaR4v+B7nY5DfOGoJxvvqQX1zwU9XJUhTe9PbSeNMtSMCAIW
	 /26O3b34VL5wnpJgnnnaW4qG9r8Ebk3bOtNRO9NfwhSod1QxLhBEIbgaqT1jTsVpSKUh+
	 ht2XXk9HhhgUgJOoMj3qrMlNY0FnXUGNXfbBDZ3IBZ1amnZv2f7UDRY+eYx9NAIx6uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="N4AHHf/P";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cNpGwjWm;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F867606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F867606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=N4AHHf/P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cNpGwjWm
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8213AEC00B6
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:33:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 23 Oct 2026 10:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792765995; x=1792852395; bh=czRGt+G5lV
	fdwWttY8aRL3Ehgb6vnpiZVhgwjmFlc94=; b=N4AHHf/PmK3thmMX153iAXzous
	rm73cSthoIcAdiGyVLi9y9NA2mtP7HlX/TXCKuJTBcouvNcAi6Rw69PUkNNwU7Ac
	09uxxlUnRDUdhXl8At0eEfXPiLvyL6bBcUwYYSODKRxdtCGjX0z1DMUpccQnJKEq
	NQy8AAowlgPTY+6357BYsjhk8DCM8KfyM7ppnMW1jzCLNxLiHftq7ThZE6BrJ+ve
	mXKJYZ2Gr244FgXbTit929VQD6Wl4ylk2u+8OltmkvyS9X2FLsx9/AyApj0XjyBn
	8EXdzkbbswTdES3Lvf+eAwPCh6ZRLPeCANAISFVtvQHF/G/OvkuJU9KRADjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792765995; x=1792852395; bh=czRGt+G5lVfdwWttY8aRL3Ehgb6vnpiZVhg
	wjmFlc94=; b=cNpGwjWmKP23RjtsP1PLu2x/xPnUR9kCWoQANfOggqb5JUoJQa/
	G9fwIMK4llRoTZkgKE/eXr5YkTYd8Pu2I9zPh8h53qea4vwqeUbsU4X3lS02DGjn
	kO9F/rGxFn0e8WlFlvRL+906PciPOfUyNrpC0fX7DO9icBm/6Zmg1FYi/KhIOOIr
	7naP8+Eo4SfyL56ILLS0hm5QToSZnzSaiC5VrYfyv4CueIM/EaZqOyQd8z23u1h5
	hTnBWgEkm/7c+X+IK3wiu5ZyQaNR8tkD3dl9ejZHssmDoxk1SeTQvndO8R4iGgqR
	jcfI4xDa58BWwuqKTtp8dF+QNyot4EXi8RA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792765995; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hmENIw3EIIrgiQjI2cUnHL+PsgF25Ar6SYsR7ag9J0Y96Pm
	RNcMRaq71733Henc54p8gTVy9oQbqASanaOFdghiYNAH9vGLh/pD07Abj0nlog53
	VTGeXyrpNOItqfxjD/7W7aHcPwfvf0Yq27gx3MTV40dXGpe+bIRT40mRU8TF7Vps
	FV4xLD6r7lr3NUVJWQvD8UyUsqQyfIUGByXn+xqV+QQZUMrgxsP+vT3uPQRQdxML
	vHqMj4/4JGobjSPgHXo8hWwhhFt3X055EJZZVf/KNQEPdG9VYnCrN8OH1RbU0DJB
	GVxUkdTyHb0K/NTmPZ8rfZubGleT0M9KapLg0Hw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mTalxV9Nnddy0wjI9V+0vg5diirxmOSPj0K2JspDf8Y=:czRGt+G5lVfdwWttY8aRL3Ehgb6vnpiZVhgwjmFlc94=;
X-ME-Sender: <xms:K3Dbamq9HbLz7z9EK1YSjbUQE_q-JIVtc5fm7XpSDd7sAJSm2jPQ3w>
    <xme:K3DbasHZYMpzuhypsMdN8aRPJiDMJMZIPzjVheUT3i7oehDTzTAbnJLYRhNEVcgXJ
    KH6NWPn9puc5Ow7uADvpimSDCXWutiYsi0qXlhy_6rF3Rr36DhgPw>
X-ME-Received: <xmr:K3DbaoklSn9hgCUtaltY8srtf9ezP6UAKpmBaAdFXVo-L-PC8y9lOR2PcrmP7cgrSxyUP8Xn_9VRtHqYgw7fYj89gz5hAomb2ehr>
X-ME-Proxy-Cause: dmFkZTGJSKsBF/laPnnaeenxxqCurG2RC9+iVFJSX+TSU42Q/89wJuoaVSf1vuXHezy+SR
    GfMWHNIM5xROykVyvVlSKYeSeVygaqroxNy/rqxK/Gvt0hZjNVfWFV4h/3OJchnRhdTQqF
    pvjcuFb/qBxBAh6DL2JZKnwee9nfJ6SFexRVLzlpijwq1y1XyApIigesBZJXtEPtoyjJdz
    MO4c28cIp7H/ypIrH4VUN8ijiZPHN0hhiQidstdZp533vyRe+CdJvFL3SImYSxy9X2RInk
    6ry2Zo5Vj7mUVzxvdNgHymzh4ymEwKxmsT90E/i17COTs3U2XLTJDzwI83nV79Cb8UwzQL
    plZUFIdA9q4zk743NxSsdSBEv42fGel0q67ZJoFHvTftyeumjOMMKyWRuiRPUddhybl9+K
    +p9u0xbNQRl8fk00OMenZ0iAqiderD3WRrosT1E/OSHOPVLboSUZk3M6/hn+BJBLccSe6T
    jNGxDxtWqhebnkAGJqorJNFsho5rrPVLpuWQHuHXjrR/rmoIPuDqZ8O4Zeo/04YrzimvdM
    ornB8U0oTRlk8pWLV3/SniStWo+V43/jhihMco5ekdJsDVTREHqLWbrpGJiM9VczUt40Fm
    wid5kcTUnahTJKzWfvDP/+S4u14egabphyGERgsG45Iz4m0gZEqy+qaxykTA
X-ME-Proxy: <xmx:K3DbavmUYSFhHY7sW_-FtfzeckFUNHCRxE3tQ_gD3QcS5VaQ5I5UMQ>
    <xmx:K3DbapufUZBkVyP7baE0nWgo-0uH6h1Q3-s3Q603UJb2fDS7iSrwWw>
    <xmx:K3Dbaim4m1_VoRyi45KblOLHGHw_EBnMn2nRiFsrB2eSZcP3IXGiOQ>
    <xmx:K3DbaktJYV4xgYKu0szSgLhKWmhE2FP40oR9nMxM1OZCbhC3dGR2LA>
    <xmx:K3DbakM8uRGZTvK9Vfd801pplzyhUuZlcWJYT3hUYCYwkfedgi9gLdL5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 10:33:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/2] MyFirstContribution: discuss then reroll
In-Reply-To: <attTXu2sSy93_wyq@pks.im> (Patrick Steinhardt's message of "Fri,
	23 Oct 2026 14:30:22 +0200")
References: <xmqqa4o94e0r.fsf@gitster.g>
	<20261022211404.380904-1-gitster@pobox.com> <attTXu2sSy93_wyq@pks.im>
Date: Fri, 23 Oct 2026 07:33:13 -0700
Message-ID: <xmqqcxt0bi6u.fsf@gitster.g>
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

>> Relative to v3, this rewrites the "responding to reviews" section
>> more tightly, shaving about 1/5 words, without losing substance.
>
> Is this me or is there no v3? I cannot find it online, either.

Ah, v3 was never sent out, but it is v2 plus the "ah, did we lose
'state your plans' so how about incorporating it here?" we discussed
during v2 review.
