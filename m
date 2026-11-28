Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795839553;
	b=WeNc/2yxqXHD23NIOQLu0hqIy3LrE806brs7BJtZT2TjFRsjqOQqUrZt0pIyyyFSCZMV
	 ORjjxL7y8SuxBPuZce6fIz492mazjTBSpD0TLgNnCuk66bKVPt5fu6LME+0Di6qOGbeGi
	 n3RttdQ2HMrghGwipfm0NajKplPAWhAlTI5D/91OnlPNJalM/ovlJVahRSu6gTZorWPFp
	 n5xwcyPvPDZ1yCFFj54NiWyC/RuAbqutUAOhHe7PHk4F6tv8Vb6HJ+jX+VvC6mDceUyfV
	 gZd8aIuI68SRuE/RTqOPxa1xfyfp8HrCEE6HBtv+qWxFE5BOm4r2hAvYTf4faWezYBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795839553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=octqRmn/pHSG4uHS5OQVmHZplmkgk0ZH9+STlgfzxMA=;
	b=JmsFkA5eJC3XKzXtWmyKD6TJwqce30TBzNKPm03k7tcu9hkLPVCItSPQ8GrN/X/byVm7
	 +N2lQGbWitk5gLWxsaH1hlDdmbeJmc6F/ZoKWLCyaVp40l3wOH4TKPpiTXxJrZr2gWXCP
	 oIt0SkjH1pSYzOP0hByv2BeL9w8ZPc6sCs54HMMjZRwI5TGPlnzAS9EkHYNyaw4CLysiy
	 Aid/tPlIuyJ//heeOswZamB2blB1mKq4R0tG3iEvyDvJa2yniGoPR8qTnuV1gXZzAgO8n
	 Si9PvNfqgA+sGYiETcaHWXqGWFOjRHeCSdTGfZQzG2mfi548JISQ7QJKDPvA2WHbo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XX0+I6G2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Xq/BX4dn";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE8606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 04:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AE8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XX0+I6G2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Xq/BX4dn
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74EA87A03F7
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:19:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 23:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795839552; x=1795925952; bh=octqRmn/pH
	SG4uHS5OQVmHZplmkgk0ZH9+STlgfzxMA=; b=XX0+I6G2NbLW1XIjbAOX4b21NA
	pk37QC02leFdFz2QKgOqOK+arWloDAjB8tUo/cELZYLUF8A8pgJL+n+7CB75TBLS
	eBdsYsHzOwQwC3DUnpVThSY5NhC5JP/acxG8RBdxqBE4DZOq+tl171xJECWIFs1V
	Y2N4J0s8bn6IcjIhtVwY0IVdty+NanNJUML11lxoCBuKQuf2xurZCiKXi/qcs1RZ
	4hU9uklqVRRiDpOUNg++fiELG/OXVAroLyotLk5Qww6R1QO9KIYRE8W7QR97naJj
	uy1ImOIjO7MrhIjVDqyws8aSgzYbI+kXp5BtK/6zcnOEuA2jDy9hYUtohNEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795839552; x=1795925952; bh=octqRmn/pHSG4uHS5OQVmHZplmkgk0ZH9+S
	TlgfzxMA=; b=Xq/BX4dn3429k1yZ9hcYP4TYqN1zyWgfV2cUNhQCvEXGTF/yPDx
	bJWtorj1twcrUl/C/Pn6Lx+GdiKguFoVyr+t/JI/tLbNxjkdhLvmIko/rUq9/m+a
	f1AWebH4XnTYyWRkQn+LfQKh60/bMfh4dZOuwpavfzWRP/d4CCQWJnvUKRBCTt5L
	vnHSxA7m3uaLd4B0I2pb+E8Bb/hkROkg33cp8OpxJlLuOHQkQlbvlBfuYnW+Fany
	mwSnO0A95esvHLN5ek8UE7on2gksmrO4uDRiJy/nL03ibYCiLgy/fSBDZXudAmPO
	U9qUfXRt2HQn3j/EmvyDNo7P3O8FzAdYrPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795839552; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Efwu63IvbHOF5Iw6kobhD0JZKt94cnREnHCWqdLgwJV+nPM
	yMblSfXSpbZ4/uE8dEIBIpD5oGGXbJUbgkrbncwbtvb0yQKGWy+aur2iIoQE75+Z
	UJ2zCSPusHo5KtAvWwAEEQGSzHMz541bGyh9NHuS5sEkodQLB5vme91g2ASBiNKm
	mU6ecdeTCskocRx5CWbxtTIRucU2wPkAjJwQOrQob5tw1OUt98oZQpN6gWtfgPOY
	k7nRsSRNc9wEmKa5H/USvlSlRIz/1Y+udJjgf1enpbdizup/F+qYuzeC9nOYXVjQ
	2u9aKo1F8uwKiLe6ApgcS/s1SCXca4o84y8c1CA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qg3H5h8arkirVQH01/Crs+KL60FdO52a33F5N2/4DOE=:cD/ysb7ThtFPNeIo700dCQlcdjrc/VbhcpuJGcIrIwI=;
X-ME-Sender: <xms:QFYKa5lvMckv_d_LemW7pq0y9fxkJTAjfDmsXRUjwDyC2qDNsQK9FA>
    <xme:QFYKa726igaX6HENAMO6i1wlt9hfiO9LcLvN9mxypjp-fVIFaZbaMddtxSCpNheR_
    ciZdyMXnubxK5cd4pfG8Ptttmm8EybZThQiQkVpxK-V_OeaF5RSpQ>
X-ME-Received: <xmr:QFYKa0pe_eZybV91a12l8ieoEuCR3CoUKaQkAVYvurAOXd20hNs9hooqIFOk89V7xyG8WNwJ2Bo6wP2te_TT0z0Qfo3lFKAn96lAFAI>
X-ME-Proxy-Cause: dmFkZTEpSy49YZhZFXHM7kaJPsu3wZh6P008dGl8AQ+psa4StjLoDeb4qWvsrRYx8U3KzQ
    qygyp6B6nMdatqFXAnPwv/rv3kWQt0cvSDXPDMhHTMp1PuNPGTzGdsLII/hXr0JV7tAUS8
    7B0PT09p4tOKh7Gz4N95VFeOkWgZoMbAFxtkZxj9epRcjNBRFpVqb2HBz+4AEFgLz1NHd9
    CpAq/3FsttOEl3vuVtO2eT0CQ0slfv7+h3GCZjRhBIsQVhP5y5bB2zxCC6aDLMa3gyaL5j
    VEX0THK/iKA9wfnIFA2Y2ExH6CS0kNzPrvKJyDLpumjlVihlMckM4Omzn7GdK1c4Pv06fI
    n/hoOSQWuDmVL078xDlFdoKEsSkN82MSPp9+XJpCw/ojNFXo/uEkhcMklpprqQHXa87Wzk
    7nXH1vYH/I6zzeAGJEDwkzcb4wCPbnKhP9L44865wBAoufzRjD/r9sVB6/QPKtGDwhaNZk
    V2u/LBIodhgvYyCt2fEMMRVFplc0pD3RvP9zc71NF2bujytptUMX6qrbdCL0eTRtjcpvzQ
    zLuK8Vg55QOe9nzuyOvjYIwRi8h3hmZyrDUf3AdoFyQCjogBvWI9u/kZVGgFYdvin8n1ie
    MTU2xqhknuqrbrkKmponBeocpQE6gWQe2cFIOXcanl1TILjSVhol/moVZa6Q
X-ME-Proxy: <xmx:QFYKa4ev7-3Gp_i3eEBw385ucfX5FHvO3wYi4iISoP2FkLB6L5KAPQ>
    <xmx:QFYKazo8djZjhdgX7kVdzQLzroJxL9cTLvXK3lvXez3cmexKqInYWg>
    <xmx:QFYKa5EOgooXXRqRZfYb6PsozFyH4N7EHhxVhcYreMMYsb6l4c3w6Q>
    <xmx:QFYKazuNDYYp-jlcUzZ04Iiv54ACBOzApf715OlnzIUX3ubMdUDrKQ>
    <xmx:QFYKa2rr2bIGsiauaRx6Mu67kZpSVGexAa4kDqghgI3JeOLoFEGXT1tM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 23:19:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v3 0/2] status: report when submodule URLs are out of sync
In-Reply-To: <pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com> (Alessio
	Attilio via GitGitGadget's message of "Fri, 27 Nov 2026 21:27:31
	+0000")
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 20:19:10 -0800
Message-ID: <xmqqmrqty4e9.fsf@gitster.g>
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When a submodule URL changes in .gitmodules, the corresponding URL in the
> superproject's .git/config may keep pointing at the old location. This
> series makes git status warn about that mismatch and suggest git submodule
> sync.
>
> The warning resolves relative URLs as git submodule sync does. It also
> suppresses the warning when the populated submodule has a custom remote URL
> that a sync would overwrite.
>
> The series is split into:
>
>  1. submodule: move URL helpers to submodule.c
>  2. submodule: make URL resolution repository-aware
>  3. status: warn about stale submodule URLs

The cover letter describes a three-patch split, and the changelog notes
moving repository-aware URL resolution into its own commit, yet this v3
series contains two patches where patch 1/2 both relocates the helpers
and takes 'struct repository *repo' (matching the two-patch range-diff
against v2).  Sent before finishing the work and checking if the result
matches the cover letter description, perhaps?
