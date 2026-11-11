Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433537;
	b=SoGJ8FpNa0RUY1etGIFDKyUuVT31pOqfCK3ECbqK1mn77IrhD072u4oE6LoKMnNGaCV2
	 l0vDVtBXMJQv+H+P9TnT+7jmwQdE2SpsCwLrfRI2SsKPqJpMHVkm6hlCpW7E/RQb4pZ34
	 MzFIRJc7ATKUqzquQE4IQZ9uXWeSPpWV2Nn/2Z2fR5LIgVKDGWzPZa063mALKmCT+1+Uw
	 6FUReClRpa1PA0G4zybRUe0khLXYxCdPGcOCw+s72Y4B3MheI64iccgrm6OXj8VXRKuSd
	 AS4A0bSiRWHHZ7fPXOWcMXQ0wGnfB5REASkmzHirllBiIhvOXk7/r+0rf3lxLo1O7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433537;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GNWrq7fRdrIYLJXkd1tgHjU2ITvsBctDnDdsWhGLoxQ=;
	b=FcKIL1Emb5+3qr0mF7pbMwxDySb+911y74qbE8ORIDVxAIt54IECFRI9IcpAWY4uVUbj
	 FWZevJU9+ZRo9xWwuvlx+8Le3RWlitjaM4zf6GO5hmz/bF2troT2Pqoq51UolI2WjPsx8
	 +BkdJdpJGicc0HjrG8/o8OpU2cwb3Rp4x075/eC5LjWgwkSTAqV/zs2eWu/Zl4J3RYPgj
	 IoS0rR3N+26N3q+gWv4bLNtve1lkTuAB6z6/1mHec6sxPMZT+LkgbVEbtcLH2efA5BOWA
	 bCf8/3s0RqHv70PVxrErAk1r1gpKNOb+RkJGOQXqX5QmpUegHBY8DPwkI/29Zt5RysQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=qa8JeHg9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=30VsDYD6;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DC606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 21:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=qa8JeHg9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=30VsDYD6
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C778AEC05C6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:45:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Nov 2026 16:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794433535;
	 x=1794519935; bh=GNWrq7fRdrIYLJXkd1tgHjU2ITvsBctDnDdsWhGLoxQ=; b=
	qa8JeHg9/EseILkgUKZVd2/VU+ygY0MbK139C6qeITiikpIiTW1kR74tpCH6g98L
	oUY6p51PTE12QQ4t+cc5FJxcE3C10p67G3egS4xCpObrbhU7RbcFShPEGMJI2EiB
	hQuPlM9Gozu5ih0OBnZSDOcT35SUYfIFVlkNLW3fC6lxmev4+CiR10/bHo2FtC4Q
	XUk3YbBZgQKF17tV4rWbPm8QjomkNCMMmZ3oY2Sn97PifyWlE5LHqZbC55gWVVPr
	/sRgdbvKZ7kdxAVp/y3EiPqQxwQ/WN1FWxfWs2C0H32xJ1qYB85WZtrPLoP+PqWT
	Ug+eKNHNFep4ARVNPyPQAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794433535; x=
	1794519935; bh=GNWrq7fRdrIYLJXkd1tgHjU2ITvsBctDnDdsWhGLoxQ=; b=3
	0VsDYD6pb8rz1lD59wzDC5MsbLEbyxrQE2Yr7MtRVAthCB1sKxuNzkNXZGmCiQYy
	PEpJk1mdNZw6RmOTdldMspCUjrYc17ENXmGm8eznmXFquLqYfmOAo5oUom1je7WU
	54KfpKkaJEIt2cS2Kk8Gw471v6E0cTuPbLyPe7URp4tQHcfPI7RYMDDwFsysx1CZ
	bGDYp0v/XMFj7nEoLMSrpFO2LK0xwyHNJd3B7BtvKBQze/XAvrzTD2fz8i5S9Sr1
	q3bmi+xmjdsvdibdBMqHNf+np4vMCPKajk9Hpqjvo6RACdl724Bvi9M+zmR8/OMV
	Nrev0/Ood/oQta2WnWAkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794433535; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:I15Tv0abUAlr1bLsYHmEZ6721rkutKpNDtvVrWInA7UP3sK
	YNGDdevPNFFE4e7EiAiMUOWRAepzlBy3ZpOnBp7AxgLLm1Gcb8WSgMmb6JFdvjTg
	uFGa0RLT2bgEyOxyPPkY1yS2NOIfhQvt22kIqn1Bj+rpBaGkMp8r2zRg//qksEPS
	ST2C2C4h20m2S+PN9SJ3nGqve8vrX3lzec8NSnlhBX5ikA0THWeiPtpb7lM8wUf+
	vgpKXH+F7AdAoS1NOZLTM6XFgxhjyKT1bXUwxa1mtopYUYZZ/Ykx9GAia2F/vyNR
	jNmaJnoYepVUjiHASIZorQ471Ps8fRvPqarFGdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hXuDvR9y7f7fvAqbzAHPHU2AYlN7aiDinBR7WGd6EHA=:XMON27srmoYrToC3vmhzrgR56K7oIZKyQko+GUkDuZM=;
X-ME-Sender: <xms:_-H0arH_UKORUxADJ6IMWlcgs1OKnANElltfJp2_JAHQ3W70-w0Kcg>
    <xme:_-H0avPKjp9nrCgB7mZh54_TBzdLM8uSuP09pJvhOX2_cs_-LZ86AYsSk2Q8w1T1I
    PpafgdlRxWLIla8iYHmfajTgW3fqiDTIhQktq4z_r3b_lc1nxi1MR-B>
X-ME-Received: <xmr:_-H0aldOOa-yCzjfK_UdBj48KDiQhVltlKC_mPB4vKzPO77cB7fSYjz_LC9a8I97H-UF85b-JNdbMq1x4g-5qdySp7K_LWnUXcH3cC0tS9cIUxu7ZA>
X-ME-Proxy-Cause: dmFkZTFM+gUlEAiEdzRu5RRcTZwtkFgLk37Ns37sjLqx368urZ+3usB2wimweqTijZiidk
    S/BsPqIi5ccjMqREWpXIMKeykdFBSnC+onfj6mjLK9Dhnm/t2ljKfV0FfWAQCk7ED3I0Cc
    DfdFcndTtXOqclAJakWzT8dAGhEOQEUmCmOCGgGs0gQZsCt2D1waV+2/LzbeYcU4mvVIFv
    KtlupaREEK/COe8tMpKeWjwNRIxNwL9Zi1yVjyU9QJVmt9K8a24jXd/xQ3HAUC8QavjYGW
    mZnnqzw1oc0tJuykw+K21mRl8LxglBeds3x8u1RQP5W2882AS4OGsiDn88KHWtpFgHf8Gh
    QM0T4yPRL5D18OXQW6e/41RqA6kE2sw/+PgxBHbh5M2yqLTDr0KrmcNiEPESgzJ2aSVylo
    ABI2QwKruienRMSTEsv+SlRNoKT04uuyicv8jOH+ACyTmBC/VqCNTECa8qi4px1XGbdj/1
    Kvxapd247m55UeYajkO4AcOgHEB66+NtQgdgIDBJ/R9er/0y+EJLH8BLZzxmLw9iaTyGWa
    J+ERisQZHghowStA0rY5diBBgcan+0TtraWbGI7qqI7G5hNcl1MyVszQW8QrFqTGPyJfYI
    EMkhMnY1iVeeisdjIoiZ3M+POhQ8BzkFUyWad99yxPBdnfBVBeQ/xT7kXwzg
X-ME-Proxy: <xmx:_-H0akuvnUfGEQHUeq266jOw2ZXiWDYb-tYbW9VMI2BsZIgHTVAeSw>
    <xmx:_-H0aunB2gG0P5uNTX5CVqzCsEI8hS62EvGUXTUut5dbT35IxOO-xg>
    <xmx:_-H0auw_JCnKwpgTpWK1eI8F5h7c_y93SwJ9IK6r8nwKTEkNK2VJJw>
    <xmx:_-H0aoOHpgHYoMVFM-tSsE51fBbIuljaY0J4OnpOYAyxBWinpUfEFA>
    <xmx:_-H0aj_9yJrrdSmX-5ucYGkafkf4kJKIQg1qKRDZ0UjLIgZcdmtvxXIe>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 16:45:35 -0500 (EST)
Message-ID: <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
Date: Wed, 11 Nov 2026 16:45:34 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Here's what Junio suggested^, and here's what v4 has
>
> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
> +
> +1. A branch, which is your current branch.
> +2. A commit ID, when you don't have a current branch.
> +   This is called "detached HEAD state".
> +
> +It can sometimes be useful for `HEAD` to be a commit ID, because
> +it lets you easily check out an old version of your project. For
> +example, a data scientist could use this to run an old version of a
> +data pipeline or a programmer could use this to figure out when a bug
> +was introduced.
>
> I do not personally think it's worth focusing on "the state from which
> your current changes started" (even leaving aside the "what if I have
> no changes?" moment), in part because I don't think that's how most
> users conceive of HEAD. Other than that detail, I think the first
> paragraphs of each option coincide.
>
> There are some quotes which use the "it's the parent of the next
> commit" mental model, though, so we could include a comment on that?
> It might be distracting, and could make its way into some kind of
> admonition/aside if need be?

Yeah I agree the "it's the parent of the next commit" would be 
distracting unless there's a specific reason we need to include it.

I agree "the state from which your current changes started" isn't right 
but I think if we reinterpret it as "the current commit you have checked 
out" (which I think has the same or a very similar meaning) then it'll 
seem familiar to folks and might even help.

> The second paragraphs differ a bit, with Junio's containing some bits
> about clobbering extant branches and not needing temporary branches. I
> think we could work something in there, like
>
>      It can sometimes be useful for `HEAD` to be a commit ID,
>      because it lets you easily check out an old version of your
>      project. For example, a data scientist could use this to run
>      an old version of a data pipeline or a programmer could use
>      this to figure out when a bug was introduced. By detaching
>      `HEAD`, you don't need to worry about clobbering an existing
>      branch or creating a temporary branch.

Thanks, I took this language. I left out "clobbering an existing branch" 
because I couldn't think of a reason why someone would clobber an 
existing branch to check out an old version of their code.

- Julia

