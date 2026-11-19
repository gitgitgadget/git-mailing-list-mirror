Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117486;
	b=sUTxphJrM5aHlgKjtqi8+5qQjGj5B3LXOI0jfWBbBSCq7bXqje7PpK0j7jaJKOqoLoU5
	 xjNUtwm1T/ceqSBDbrZ1uGg8rXjXZBSVXr7jM3g1GMDzWfGt9EzX9DGz5wm0yuByFdawK
	 SGCNEYyYoaYZF7b9eMjkGQLqPi3XTDSO40IIi8QqNYrN7wxzcH4MRXhFJsm4AP4nDqUWG
	 Cjaby/XpP7+Eha9qxX6upXHglZciZVlqLzicSM1ltm4QNoL3/3ohGpfSzm0UDQjUSk1sL
	 YIcx41RcBVdc+zretJGEtUy8rOVJS6DhNTwd4R0kIeJnid/4XJr7p0JdTmIK5DN4juA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117486;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OdKCL8O1jKimm6yuHeGDNt8E/BWJA8ir7DTdduEByNo=;
	b=BX2qS3/bLn3oHFMFKrgPaFQFqQQLU1uWy2/XIEIYbzlMYPjP9hZIN/jLuloWiO5yshr/
	 A5u/QjGc8Pv2dwO9c5WvxQ0z18SCTIJUpF9fCFRILvC3/BPimtUxExaYIJv3T85jIGbUY
	 l9RtnqHvq+tJJYG/GJ2T2py9WjHce5i6/ksCI5M+mZ0dW+ZnFFLsTBGxK9UvJxOwIx4eA
	 famWMU/dLv3OASKlKdZwIQ/1NbiBxngpyX0U3fmDQwgtz+x4N20dEht2/eN7yN0kMBlzk
	 NYpsjIK2S9DxJcTN1y7Wjoeafwd6LsF4cj6WOMEDJwvE+MBFm3L5KZOa+83t9M62Ynw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Aotu2Mxz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ia3mRU7K;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBF606A32C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EEBF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Aotu2Mxz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ia3mRU7K
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74F117A0051
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:44:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 14:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795117485; x=1795203885; bh=OdKCL8O1jK
	imm6yuHeGDNt8E/BWJA8ir7DTdduEByNo=; b=Aotu2Mxz06kNY5N8HtPMjoW/uY
	dT+82sjxaQveGrXFMYBljEtDk5C5kfg6yaJSBvqjLMDnTtP/2qZJUnvoVcRZQD7l
	G3Gzv2MgUzn2OKWWHzQ1dUsuDvu/gn3UDk8LSEzeEmg03PrRCyls+Px+EWb0G1N2
	nIn2F2RTj8Bw2i9JAUvfz26pySvr7cBQJrkkn8TdMXnHxTX+eQHvoEbR1owM9JyB
	6MbvlFQdi+PAosayCP4UMXbjYPD6+gNEoLbyFsB3g3iOgxs066K/eQolxmWb1yVI
	Rrc3n0aMU55vIYENh8lt7xJvB5K0DrsgDGjZBjvz+7UzqFoTMQiAKnYoV/bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795117485; x=1795203885; bh=OdKCL8O1jKimm6yuHeGDNt8E/BWJA8ir7DT
	dduEByNo=; b=Ia3mRU7K4LGGuvoJXUoXri/Pt9ixdJHIMP7WyY+WCwnOdY1Zroa
	09QqnY6ofXAeiEZLllnCrEvwdPQie+7APFekA8eGeb9XlFsxLJQXNha6zp8OGD+h
	i0CThUkiMmJeOv8nzMZethyzZ2eXX0JxcZX8uqIDFtSvuZ2ig8KpzrL8QI5hYyLG
	WBFF8P5Mzy4GV74GDi5pxZjtUM0nZlevjE1g52azuhLuNJxc2YztSLeXW2JggyXd
	cS9vn6L2M/wn9pRLFNOwk1Pllr1bRlVuupYsTJPQa7YIhvUuyGORjJyIcBIwIxOL
	XZCr6rBJ4I5B0B10RjV5hCY6gU+3o30evnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795117485; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YZ0kQgTkF6TQ7EBRRXBPyOxlGFv19dLt2cktYLPDCAN7+Vj
	ohFnC+t/hdrOMR/obBpl3lorAh160EGi4iHTb3bCb0kErBJRovJjNVjrdauUX3DN
	PBvXD3ONTvwm4ecISYdADRMnFqa+9fOcKUKPQTez+kfksEqD6ufitJwM6i6lNQIa
	Nd/KMS1NOGkwG7l6iZ2YedTuCIzzmrDpcBM3JuaOrajgm3xDbVo0Hwj+iImDx1dX
	Ee+H58gzee78zv/HuTpXEBSkPoZnFdYdtmofskqYcerCX1v4rcf6eAHpHF2rDBgw
	p7gaJQB4rL8Yky8EmYMLru6TLRgnLmC3mPdFPfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:htYeBEgUrt8PH9JMHUL2HkaF3wqbxO+1m2D21I3Mt+k=:uUVjMuZTcSjMdfi96b1RDiWwQj8X2Qfo94wuGxTAYOk=;
X-ME-Sender: <xms:rVH_aiWPcOPIJbF4lzpO5cz9KC89RJELhCF_u9EFZgUO7GABT6jdNQ>
    <xme:rVH_amAodrVI2a8YAZbz23VEBFvOKT9xsvjKDavpUH5a0mXETDwGjWLyiLlnUft48
    gVYIpOKvjGOQlNowSvGYVLURO_GM9KIr32BAZPCEP37K4TNsKhjRlI>
X-ME-Received: <xmr:rVH_ajx5kxgagedAz3eS66KDYMrO3iQkQxaNsgRCPuPCymnpU_kwYHsSzyurGhXuCqrftKpu9bmuU78JDQzvRvRZFPGeEF6YKSeT>
X-ME-Proxy-Cause: dmFkZTEZrjkySkEiHUNB6DSMNfpWQ3PnJfmTu7bAyL+99ZPmuy0THCNAXvi0b6MUpp6J5b
    wCdA/dZIzsizixUvIb71MW2xKt0jJtQQwimrzd+ACV/H9pOr1NSGZnACmlEZ59bAnmh0ss
    lgtJGF+B01X0Ok63e90DqfdrNZKGRlTdS6jDyn9TlTgLZA0kl6tW57vfOarOuDcjDuhu/p
    c3hFtGIpB4voRNkI8ENSUlwb4FJ5RZA5ag+S07yMnEvY8WaOqDJlbOHb2RbmKcDNreo2u/
    negErtR7fV3hhZKXrDhqFchadS4N9gn7mZQGy+v+6TFcB2wj8dBAQolTW3zJO8x22C7VjH
    ORix4VSqWaM1v7VQFC0kYHUglRDbaVbrtRJBC5KItpciMZbQFdfojg+gwwvTQ4n2hFXxw4
    J7+TNz8SJYSw03ctVvq2e6/nwzAqbR9slSdyYjkwKDLNay8QQbdWxV/zZ7x6zYnXmfJunI
    In/l1nLyVV67KgAtLtt3nH5Em/5eqIdimCxxkJ8Cplc+jzqG9y5ODvccNej8oQ/f+DHEoI
    vu8SFGGn7bVI2FU2w9D/XcPBme6kkVI2IFUomk+wwATA0mcc3cPShlbiEra05KPrUy7UUz
    vV0b7pNpt2oWyj5K6GWURAV+mXUyHrCkAfV26PDnIbjIbxNwGzfQrOvIOqgg
X-ME-Proxy: <xmx:rVH_ajAK0an0eUKpJ_UcG8RTKd9qjiYQlsmE_Eze8hH3o9ok9Q6Tag>
    <xmx:rVH_agbyyYvBCvEGCiZnXqdRfjL5csBg05xJoY2mtF-vNdDfAQcI3g>
    <xmx:rVH_arjxhlBPEcbvqJnaoxEvpb8-C7loDHn5wGRl8UXRJBQ9oQkf8Q>
    <xmx:rVH_ai5FE1ppqTqy5xczVVoZeGzMla3jWWaGaIKTiwt5bjfGdM7sjA>
    <xmx:rVH_ajWSOXuDO8pt136_ZRd6vqQe_3PPdwSi8YkXFyWPmVRFn3KDEVL4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 14:44:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 1/2] repo: add level of concern reporting
In-Reply-To: <20261102-b4-repo-structure-concern-v5-1-2d8f37b70b75@fastmail.com>
	(Mark C. Chu-Carroll's message of "Mon, 02 Nov 2026 11:32:43 -0500")
References: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
	<20261102-b4-repo-structure-concern-v5-1-2d8f37b70b75@fastmail.com>
Date: Thu, 19 Nov 2026 11:44:43 -0800
Message-ID: <xmqqwlq8wqqc.fsf@gitster.g>
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

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> "git repo structure" computes a set of statistics
> that are useful for diagnosing performance issues in
> a git repository.

By the way, I find it very troublesome for this feature to squat on
the name "structure", as what *this* "structure" gives the users is
not about the structure of the repository at all.  You are giving
various stats on objects found in the repository and nothing else.

From the name "structure", I would expect that we can learn various
things such as:

 * How wide or deep are the trees the contents are being tracked in?

 * How many branches are active in the repository?  How do these
   branches get integrated?  Into a single 'trunk'?  With many
   maintenance tracks?  How many?

 * How are the names of these branches structured?  By topic?  By
   contributor names?  Something else?

in addition to counts and weights of various object types.

And more importantly, we should be able to compare these structural
characteristics across various repositories and projects.

Hopefully it is not too late, as "git repo" as a whole is still
marked as experimental.  Once some of the subfeatures in the command
prove useful, hopefully they will be given a more appropriate name
and UI and migrate out of the experimental "git repo" umbrella.

