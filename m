Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904593;
	b=ZIZWstJzn75aR48RtzaF7UrMCbwfAVWazpJQhrQPEmLFFPOLKe4HVILf/gexINwAI15P
	 gEjJ9NM7NDifQUGLxJheZGHDuFfOIa+/gf52Dhik/iVEIv+bMoCkHb7+Oluei8JprlUXc
	 7MelUrFUHx21zV7MbQkbipwcbz7/HT0DVwzyzk+7ix3ac9u4H4aSlvNLbZKLT9efYQJwK
	 Gike16RjTwsrJHvZT+Xgeod3ODnH9yDcVJuyNtAH02A5TeAtxiCSvcFHYrPUlpgO0Yoea
	 Ttk9SnXiEBgibBy9B8p7bSeZwzmy390KyvlG7cCDqmRVi4EQ100w1U/JvawAh9NwYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AT8CpSStfTAiLDUJtZqpiwfbQ6pYtmS9GAcHigQxwps=;
	b=EU0UvN6HZP/GOy47zwodGsX9LQTno1fSTp+iv/+7KqJYqnpgpAWQVGoLUZczKTK4q254
	 NOR8Um3MDK+Iqwawk8xcuVI8IkeZOhIvep46RtAXZOkIOVIcqdfP1r1alMzLh2e84wtoP
	 gLwy6hD2m1PEHifn7QIaogBOL3urKXhWwT5PnuE+NpQRCRMlHK4Lgsx2llOo4Fzd3DDkC
	 4Azp8af+AtBSrJYnwlGB79CVve1dmrHt6fcD9WhRvj5iHjry7EjEOosJffB98kW7kiB1h
	 wi99xK6SrFKbX//JkpQ4K510X6KTl55GWr6BD37GQ6fDAS+5CajzfYN8PG9u/xrjZog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="Q/gm4VL9";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T2VFqib1;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54320606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54320606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Q/gm4VL9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T2VFqib1
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 673E314000B3
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:49:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 05 Nov 2026 13:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793904592; x=1793990992; bh=AT8CpSStfT
	AiLDUJtZqpiwfbQ6pYtmS9GAcHigQxwps=; b=Q/gm4VL9SiOTjSDMJqSW27hDgg
	WcILhTsaejN9UPePyMjYrTzv00awxDptW5OjKc6m6RYAZ7FD6cZm46+R4L1464TR
	R8OGIEJRpnYsNGIgjzsIWknymh6e3D8nhq8N/F/zgsLqMEx5dUL4M5ZLGkmrmBa6
	cjrQPgMGk8H5bhYrFFLuky3S8gM2KlbgZ7kPjs/pa9jfRq12gfRo/Ifd/idvXiND
	Gj1QJev1oaFT4/FUYw6eNWNNYkCVrMaPPn6wL/v/yqRdafwcOFQMeDCaq2cpVjl8
	s0M7/ixwnau0CgLenHmPR7K8Th0AlesD/ocFysyQS/OSMDmSv396c5tY/w7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793904592; x=1793990992; bh=AT8CpSStfTAiLDUJtZqpiwfbQ6pYtmS9GAc
	HigQxwps=; b=T2VFqib1Nn0Klsc4KGgcwtizonxWwYDK13EWzhR5GDh3P9oLcjn
	yQFfKcvUX+wegUAsTP0S9m/ncQVkZL3lXvl5VcoiYLGc21uiW2mutW8JqQxIa5em
	WkqxSIzYEYrItrWi5lFyszysBx1xrGCtYpr7PP8BJVguwGnDg1XS4/cuwlyWjGjk
	ScwditxLMx0FYddtFxCBJzvu79h4uEwcFAJAOZCBnQ5mhexRTTqGEEYhvHdqQgmI
	ydCJAjORIt9+KFK9H6SehgLwIjGV1m4VbP0Y7ei/E8vLjCPCSI1Ivkfns4AVd9rP
	/1QdjzC+0cTpxQxZElCKPAQewwaSHmN9Xfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793904592; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SvEGJC06pDndJorfLWaAK4hnRJaYHN5noG4L84r5ilu1OQV
	ZKEagGGsm+S0AkA2x4NVK+A8Qp4RoRmVvbZQTAYrsKg6Zgkj5Pe6z8uwSRKJ7HHa
	CSmhpeXDAbvvlvv2DMhcBBZqTmakeeIdUHIfvq4TUENevLO8cQJUdsqRmtuDslmK
	uIcVImAkTIFWBXx+lwBvMY9iBlXqerUAAYFWfanzzBz9GNpYeFnJQWMCkVnXmGHJ
	gUfGLTQdVAKwVmrQVd2qJK0WDau1rhapDHlVo042EAhYrdyLFar7Fm/W8mo1jrOd
	BOOX3fVqFdTwTAh3DakfIRFvYOkz7icZ+qMNXVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:y7/gx+iZPKRmmiT0ObvDCuMJqo7uKMAgqb6kA4eS3YU=:Sq4N99uCsrWYiPQ+IBXR20qsbPZQtngXhSLvCRDqu8g=;
X-ME-Sender: <xms:0M_sajM0p322kgEgKr3qTQ6Q04sbbsHWmtKKBJH3n9m57UiAXHyUlw>
    <xme:0M_salYD7cOBz1Tyy2eTxMfo_Dl1T9IoO7tHT51nKa1fRD9Vs1IY_HTGDwFmHj8LL
    2qoek5EdHhTvuBEngfDlwLSWFzHulIorePnqn1hO9uq2vXFLzuXuA>
X-ME-Received: <xmr:0M_savq3rziJB5BUCV5JBX_reWjR8i_vkN2wfO6Rr2qGjRwnObHYcB-1gqc1ZfG-mVx7aLzx1aFvBATaNytlZFepnlo-vhGEHt6z>
X-ME-Proxy-Cause: dmFkZTE3cf/M0J1Hk1kIATIA1POX0EsBve8aVRwzUUGGCyNHCwSBKOE4bQvKcx/5wqfSL9
    4UPGw1CQqYmTPPIH2Ci78eXXuMUxMo191C3vW6vetzAi+NQ5gTOq2LK+uNDJp/j773Xz+L
    rZ4jtH8ome1Pq141fIBe7jh8jeQq0M+6DLfqQhY9Vu7lkleeROVR/dzjLeo/dQbJvbPSgG
    23BidnWC9qRsmvAc98Mzz8XcyL+Mh11MO3ysGjLmf9ddPlolT9LLp6lSr0S9kt9l7VJeY9
    73NRJDq4TbtlUEEF/7ZaXQwPqXU+PZlDFEcHQIy4dVHqrO4GMwM2YNnuvSJ20ITm+clmP2
    k+EMNZeTaFVGh/u194EyMeFEW8x/x5AdfkCnHWSQc7ttGSLMSeOWAk4U7SgHfm2FUDDn/f
    WaqYlCBxEfJPmqK8DZsz7bqL0O++j06E500XfG36QsKkODqNMnB0GlArytfFE6LJmnYT3B
    LA0x5gicXnrwPHRJhwVin4R71pleW7YDu1TLRd50H6PB2SlK+SripzL4fiKCjXt2NT5xOr
    f51qzOvBrE3OZRAW0Ep3DsIPjQU2lLWzibYONBJOIuWmu5GYPH2zuUm3vfGq5DT+04bd+k
    2DZAWI3PX+G8VQGj/9q4lojz5s8+FA4rISXdiYsZrCabLuMpKFO2eMACFtpg
X-ME-Proxy: <xmx:0M_sahZ1XlF_ehqc0P1w6tDCnjDAGEw1YqL-DR5X2f0EUH452UK0Gg>
    <xmx:0M_savQZE_Ee2M1eVf2fVm3AwCTzKfDxv48p4g-VYhj9gFhmecrTow>
    <xmx:0M_sag7G9F0NmqeN30bo28kYifaSmEnXnUtIyhPVBbdzxG8iN290kQ>
    <xmx:0M_saszx4xG1Bvpxf-VtiTzatVdGQUdyJcKS7njtB97aJcXOP8vkQQ>
    <xmx:0M_samHzNurCkE9WSPlZtJh-kuT9uZoqcwy2lDjZNfGrp3Cn4JBHk8-8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 13:49:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2026, #02)
In-Reply-To: <20261105072959.nzvWu%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 5 Nov 2026 09:29:59 +0200")
References: <xmqqmrroxdzs.fsf@gitster.g> <20261105072959.nzvWu%taahol@utu.fi>
Date: Thu, 05 Nov 2026 10:49:50 -0800
Message-ID: <xmqq7birun8x.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> 
>> * os/rebase-doc-incompatible-options (2026-11-01) 1 commit
>>  - doc: git-rebase: update incompatible options
>> 
>>  Outdated cross-references to the 'INCOMPATIBLE OPTIONS' section in the
>>  'git rebase' documentation have been removed, and a missing one for
>>  the '--onto' option has been added.
>> 
>>  Needs review.
>>  source: <20261101082230.141688-1-omri.sarig13@gmail.com>
>> 
>> 
>
> Reading <xmqqjyncxrur.fsf@gitster.g>, I would have expected that this topic
> would've been rooted on the v2.56 tag, but that doesn't seem to be the case:

'master' has advanced since then, and this is not exactly a "fix"
that is worth the trouble of including in a maintenance release,
so...


