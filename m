Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312328;
	b=D2QILLIu9qSgYijKzIhGTK/ZN1lgJMluhqw/QuOGKrvQ8l5MA/Fx68dBrLqXFhI80aEp
	 Lrcx7Y+dzIk0suIlRggy6H/73iCw110vJn+qYy51zNGZIpHSXp76UIbFeUuOMeR4Qxre+
	 0tPdAldZoAWTMjHx66kt9fnHQ0oOR+iXwvn1tJgiAv5hJ8Su9JDAbqJ89ctdGRBfjfHxI
	 GnLmsd9DAnvW+n2eCxg4o/qV8Y5v1jre1Ofl1Usr+21Z49pDgjRph9HVp1ct9cKSOdDMM
	 scRM91CQKgMM1N0pJqoQ+CY9pc6b/Tvnkb7Yb5MN03rGPl3C4Z131Vwsw9g9qCzh7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312328;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ma5aggk3P4OA4/pBFU5xRT69hNSHE4ukXGbQgRCOavY=;
	b=T/NsO5MhswXMbl76IacpTVK11OfmgkvAUsjglFwLQsD4rq0K8jxY5IrZ9OrQEgk3E6DT
	 gxj3R6VgT+4ESJH8uLWLBJH3TUfWoDGpNtsTbtbp9RMEWAwLLq1pRpkIW8xatr+kyyE9t
	 gXshRBxvgydGQvgSUgWds1pp1sqgM9KTKNEiz59ymJ622b/Nh2b6hNemcF38wl27I+KX0
	 +GnN7tmpruL0SoxCUmqVgIvSqWl8Udm/2KOxRdxyQHoeKuSkOzPM3svFynTlY71Ddx+fq
	 CT0lYTjXPK0kJjGeEBLhQbLJoqSUUVuLqpapkmOQh07Uwft5fwlicFGhZupakUWUKow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VFkKQrv9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UJGZG3fQ;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C658606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C658606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VFkKQrv9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UJGZG3fQ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EAB37A0110
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:18:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 18:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312326; x=1793398726; bh=ma5aggk3P4
	OA4/pBFU5xRT69hNSHE4ukXGbQgRCOavY=; b=VFkKQrv9PbvaPnP+eFo0Wzp7Yg
	EIkAxnHY2QDn1Zrn6aAnLP3Y47AsbS19LPG+VD0NxLZB8AxP0Mx/46DmJww/0xPx
	VkeMGg/u/8weV2KwQyswfnF3lKEGyukd7PETtd11zPkvH1eDtn6N7mH8sRU5SIVf
	3Wq9kcM4VFWF+DAVmRDHxs5Ylp4n6AeTE6VV6b9hiapMadZWuXicx3d+wVOcKz2p
	T47Wb66vsJrpHL+yfGnzXzPSLaEMJMfEp9aPD6rQQN1QJLwUrZIDrs0r82smSThP
	JN7EffdIG0if8g6wNOJ/Wohj3rcVUaCsCbDeiU+IrKk6V1Qxz4EhUYqVZubA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312326; x=1793398726; bh=ma5aggk3P4OA4/pBFU5xRT69hNSHE4ukXGb
	QgRCOavY=; b=UJGZG3fQ7p3sa4UgCrH444kgI7UMsO7PlzeU0YyTvlsqmf2A++6
	8DbJTvRXkgPlwc8UeXDNhzsigrejzVJKM/OgGDIHCkNLzghJHXfBALcq/zM41HZa
	hyALZLSWwRTWYt96ws9aehSEXkC1TISoYR5QEGD9SZAOEg4bp5TtnufsNYZd0aeu
	4glCwLGFh3sceKQtdVRuphczcIEBxN6r05D2QXukQW1+kxpmt2Xtnh/XE7A+fqdk
	OfyV6Lgma5hubze+nbmFzzdPiJg806W5PA+zwQH745rVWi7Tz503mUNUcyvh42mc
	zcrMmln/T9OvgZmo8zssSlin/cwS9jmiHNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312326; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EXwjcfU/E3/DtGqKEWeXdcrvgXgXEJlqs3gMBQC1orV4E/t
	ZdIWhtPXs3uB8kJyL6h+ZrpM8xvliaGRontqqazvxGbI9/WxsG9JWjfFbUBhceBc
	s8eN4drEizmeeCdVcktbARsKhWktmSOLoEadION2KKLYW+0rGRp284dA5j+ZAgZH
	xuJeNk23Xbicm1TBuB6vZw+IljAc3nZe7TUrpmEcZKnzDIC3AuMVcgoIfnkgKv9/
	30VMMTScfs+eIHr6JDizZKsCdfTBe1usyw2SDoqT1Ct8YdoBOXs0sSkr2AxvG/9a
	d9qRsGiXIDqTqneQ0D1t+Lp+KUr6vyWgCGzhPPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3vFi0dVrkelOW7tzTpQaxWTj5moEF6R+lWZaXMYL/1o=:Nw1KQyjIuhMaYQgXShaGxHMj58eJ2YpDi8t0Qz8kKPg=;
X-ME-Sender: <xms:Rsbjaldn5wOLpmze0tWl2fqfFTvFgN9AAWe6PvOH6V_aPFKWbpxCeg>
    <xme:Rsbjam5rBD5f59j6HEUiwlx9VqTnb1k9q0ByTx-QF1vHnWmdfLU0_zNGnJZfb5LcZ
    4fQv_bQFhdPG1n8s4w0cYsf0Wb-CcY9FyyG9tNehM0zSAmCZz_1SvQ>
X-ME-Received: <xmr:RsbjaoXskRa2wh0_Y66NZdQ578cmZHSxJI5-L2k-O_wTP6T_iHsLkEtUjdQdxXEso2pUzJvCkdLHZYioGgFHhBKmFzLvQukpntBB>
X-ME-Proxy-Cause: dmFkZTGhIZized7KD822xEWTwfPhpfg13+KhqSEVgwbppWeAWFuPM3OGYiHgKsk6PqXz9A
    CElb5B1drA1j7RmUVthjt3vt6tzmROWx9FSDUz7L91exzmag9v56lZ0bK4IOsQk4/vVfvy
    B65K3JMX3N9MRf6ddfR8dokxNxgAbslDHRCA+gcfkN7m/eSv8S4k6hnmW6VoUOsJ1b2YUR
    USd0bUK9J6Sa3I59gyNIdUsNOtRs+bZGfJdiiLrDKMEIPkU1FK9VF6UkzuU5uaQQnDgLCt
    O7eHUj9Jy4A30O+a1YlHnXZ9JRo9fKwKaR+PShw2Mr3Crgr0YqWojT8+0lHqP1UThZ2hMQ
    GTO4UvuIKNL0QiwBobwaoHoxYHN8KPa63HeuwTTsY6bz6RtuCLVAE87/u78E7XOS/YfG8x
    Vl8ysMUP/hsM7SORf5vSjR+iLGTvPhh6JQ4x2KHHU5jh+gGPLUNeBgM0Tjj/g391i8MLfJ
    N/PBnPwfWwH+hayrPdG+iQoCRFaaJV7do6TfSdHs9/1AeHZUxIhhhF7OnQYMXIQkWkvgAA
    S3n8k3QRXoFfXbiODaVuy8XZD3ajf75rw+m4IJy4qehvjgDwkaWu6rDv0F9tYfn1f2xMT5
    i0VZxlPs9p/axbTDWXS5Qdb0K837/0fm0zOut0iuhD70xuNQ96jqETLDDpZA
X-ME-Proxy: <xmx:Rsbjal6iKvtABf0YhQvIXDKYZ7kOAGH8YKSppnp63ih6BDvl9EMTww>
    <xmx:RsbjajplJdjCY0XWCvny0DAGGQvG_-qL8ru6iJw-E_naAYtwHM1Ttw>
    <xmx:RsbjaolUhs2kcACcra8E2XeTOVxyzprS9oP5KVMI_XpzRPyCVQbYYw>
    <xmx:RsbjavOKefyNBgXcveyjVfWIy2BUxqDVSo6pSPmDOqrT8-YUPh9u6w>
    <xmx:RsbjauAVMk6Z0SwxooLt1AB4KGXkKiVuFw-6ebJZSmcHllqqNP8ZEZy7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:18:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <5a1fc2ca-0ef9-41d2-a02a-a6023cbe09dd@gmail.com> (Phillip Wood's
	message of "Thu, 29 Oct 2026 16:26:56 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	<xmqq33ttxw9h.fsf@gitster.g>
	<CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
	<xmqqcxswtqd0.fsf@gitster.g>
	<7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
	<xmqqbj8fm54y.fsf@gitster.g>
	<241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com>
	<xmqqld7hafhy.fsf@gitster.g>
	<5a1fc2ca-0ef9-41d2-a02a-a6023cbe09dd@gmail.com>
Date: Thu, 29 Oct 2026 15:18:45 -0700
Message-ID: <xmqqqzh8ywu2.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I think the command line version, i.e.
>> 
>>      $ git fetch $URL --refmap='refs/heads/*:refs/remotes/alt/*' \
>> 		refs/heads/master:refs/remotes/origin/master \
>> 		next
>> 
>> stores 'master' as alt/master and origin/master, and 'next' as
>> alt/next, i.e., takes the second option.
>
> That's surprising, I'd naively assumed a refspec on the command line 
> would override the refmap. It feels problematic if we cannot override 
> the fetchRefmap config with a refspec on the command line, but need to 
> use "--refmap" instead.

Maybe, maybe not.  The command line refmap was meant to primarily
help use case where the "what to fetch" was to be specified without
colon, so when fetching multiple branches, you do not have to repeat
the refs/remotes/origin/ all over again.  So if you are giving a
refspec with a colon (like 'master' in the above example) to specify
where to store, it is an unusual request to do something different.

Something different could be "do more than what the refmap alone
would do", which led to the behaviour implemented when refmap was
introduced.  But it could be "refrain from what the refmap alone
would do and do something else", and if you take that position,
you would get the "overriding" behaviour.







