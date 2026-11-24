Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535769;
	b=eMEi28f5plCpZzxho2EJQF5APJqRagXYF8HcUeiPz6C0e0lE9SO4wdITI7F+A0doNZxE
	 AAPR0svSvgqvVto3uGoaapRLFAs1HnPh6BbIEVlXKkTSOyFHtFqmFCUTJ8i0CALNiJF8S
	 +AHXnqBtH2DI2W5DPOW0JPa8cM/IiUrKRwHwhXRMEFD46sn3qXcLjwipPDrnSn6wtl8D/
	 A2PYF6I0YNbulORq7WtF6FI6f9Oc5KR3nt2KzcgHVYvYZ6vjNsqsYJ5Sj7s/98oj6J7AT
	 pwM7Ik2PDJmbqcpPj7lOYKTXULHxKy4+iIfSlcz32toB5QHz4e/OnZOvddMSQQPbr9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535769;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pYsySVygj1zDAuURCjgSUME8zKVDBkcuM77Ikn8ZLqA=;
	b=5gn2yABdRYx0L5wnzHrzP0z2P5P1GfmZJkezjXAstPsQAC+sz0N/kTbnWGlUQGNhU7I1
	 HS/leqV39MSNjVDAlANvuiiWXOk9WlFKONanwtYaXRNkg4nqe/+/OQtnWm5LucHV+zxA1
	 iOZdJVML1uYCMk4AgXgA0x97yPvRmHy1CTNOs4H7sPak5kFGiKt42p113Mp35qst+TnKP
	 /ZhyK7wdeN5fRU5BWb9swoD5ygv+9PeoJW1tBaFLR3qfQbn+rlFMxjqwTKUv7ZI8x8zCT
	 x9kc8f0Cag1JOlsogCfZdSHjWSbke4gPnHtdmTlhrIwMfMTLeBBew+lZ4msXzzWGCyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=EPNgBySM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u483L4qe;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98781606A329
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98781606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=EPNgBySM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u483L4qe
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 969181D005D1
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:56:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 10:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795535767;
	 x=1795622167; bh=pYsySVygj1zDAuURCjgSUME8zKVDBkcuM77Ikn8ZLqA=; b=
	EPNgBySMJudepGbqtE8uQzwmCmec4w4EHd0y8MbepV2Fpyg+dw8KPygp3KKGxkrS
	Sq45oUOdQW1w8oF2easK7X8twN8jFd72SP/skO8AXdbOk+dunbjvzW1i3sAgaZ0z
	IJ19SjCQWurjLCcAI+EgAuRftxgQ7TLNikoKc49ko6YjaMWCBl7+xmjoJIdXVUkL
	zgjNEzh17QUfu1N24H/jgEBYQmA/b873zxVX6Z1AIcy+k3rivTyMKkbSZ5QZi695
	0XcPYrnl2qnDB8dXONQscvZMQz0Rp8Y/yLmbAheHC/uvWBLkoy3jYN5yhXY/JFYN
	e8AI8sJTdT7c+J4mPSH1kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795535767; x=
	1795622167; bh=pYsySVygj1zDAuURCjgSUME8zKVDBkcuM77Ikn8ZLqA=; b=u
	483L4qeocAMJyK/18Z+/M+4WGEJBMHdNLB5irh3ANPihxJzakmdxM85vYf675WZV
	9AtDbMIl0EzkZTC0zDpio0y+U6sWQXXm/Wl9xyCBsyimTYO9vEXwNhcvzSTgkQ9n
	1tCd42wi0kJlpdezmsYD8OqMFoRS0Sv+Us9/U0FxW8636g39bA6w9kVA3YvamTkw
	DtMiNvY8d/yG/hv/cpL8WvVfmBNvbAHDU5s5UeFQ4AVrO2+g25OqLYKXYjG8/u9/
	wx1N14oltskElompFeBRfOKb5wpqr4N85zSeiDXtprRYxZBpvoLF7Je0HovZTYeu
	ZUwR1LSIf9A6DnrLldBVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795535767; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:If/XL5kwZjLMymO9Iu6Ev6cioJ9ZYxpPrEqMwhl/t2Z4ORF
	HK7XNmxw8MvwZWuld+HP65C7TEAX+GPWJ+muPJ6xYFPHAzlBVNSWYkC3WoH5atYF
	kKAKoAqqtoB02P+hr7jgeDpLcdox1itLQOM3hkjVd/CbNP3f64OSg6AipWXWd9U9
	TpYJka9IK9+vA5xmCeXas1aef3++00+rbpA7CGNmPDNxZNXO5htiXPuK0I2I6VdW
	R4lmymkPzfvM7JaU4mMkp9250P22GJimmvZ/Nx+hZVk/nbWXA79IcXwWLJZ0we4h
	eUE3DGWYOi1DC9ezOhcDRqNSGlGwCiGhCaRUwRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aisPB51O8sEF0vMHoDmbJfmPwzM1yASrdfmPBlgl+Gc=:mpN6EtXFFtJM3/Xz0S3ahytZvTClw06C3Iej8O5YF6w=;
X-ME-Sender: <xms:lrMFa-cnDvsGZsKPe5WF-ax3qMV0cZQuHbXCrWQtkpjYIM_oZwHPSg>
    <xme:lrMFa_NHAxv6nomeK-tBIeWWS0YIM_CrGxuIfTx1xS9sZHCbNIb2T9PJeKaggSl_p
    W8Gvm6cQZSIsyw1Aw6uHhkLqCidQFppkODETLz1M2iA_mhhDCm1rM0>
X-ME-Received: <xmr:lrMFa0gC-O7p20V27KOKm7ljPPj0_pQxlPyWi-QQuKjiAhkxLNqw_4Z7krWo0ABHkRFelyyjTQet39XB0-hmqdMPPjhFrw-v2X_aKL9KX2rs2_sxsA>
X-ME-Proxy-Cause: dmFkZTGHiAwyvI0CQ8lKscbBKb8A07DXdcleTJo6FE4iJ4G8MWJc9w1XNslq9nc9/cxePN
    B19CYlhqba65eUsy65E8EAxWY60UYbmXH+RW01Kkmqetpmm2cZ78cfjC6JDqynXcRMXGYe
    jC6CxZaJ4o6KSLpmkw9oPZJZ04p1UZiZF0DkduE0P9FLJ7n+/UqkDb4si86cWySXWFYqXy
    MHfdIE8H6/3o4qiasvbaB5lzIsMkgoHzSqvoON2uReWiH9HPzUUS1gOU8+cB9NzLCiQCMT
    XUnLcd8b/FKsNtiGLtXqSbNGYHT+YeWCFLtpgZq/pFChA0SpanFMJQgKBszlVfwWQ9CWKF
    b+9jp/kYFKckKzXFxhk5+3UJvdlck6OjtC4J8wXS6onbZU3lcImPhph3dSPvzE0xJN94gr
    MpBGGs7+oYnOjsAsR7HOO+GbTerlRcniIlDbJ4traTRgNCettoKilEHj6bzQOLUv4ybu8B
    /ITF4n/2+a35PHARit7vPugxvzcJ+u+ziv/N1b3fdATY2/ox6YgzcF8QNJSGujAJMuzygH
    pQVztG2b8vH4t7cd6JapMIft+gAcWfjtlGz4vBkJHsBRgA61CkjsgZJ2F8k5rh3FCNlkm7
    qA+vG5VJYZtuz6hKlHsqCI654hpyYtLjnStYgFnB1AKufWwC2lqB4XURUDzQ
X-ME-Proxy: <xmx:lrMFa622JfV3yijRLR_TsJrfyQUEb8KZXUxXRys1x3EiMy4209AAoQ>
    <xmx:lrMFa2hr613m15pOSEcclqTESDR3kSLUFvBvecjelhWkTYSVMmvHZA>
    <xmx:lrMFayd5MgJy4BEPr0HqO3hYDl8r3lbHiLwjYTWPcCQQ3O6LRRL5Qg>
    <xmx:lrMFaxmzNVLwWSBoJRWO1DD6hndKEItNT6KE3t5YE6bZ9nyOgEPJGQ>
    <xmx:l7MFa4DSka8uIu1NDwYjY01HwWMqxyK1LIqq6TL_j2GjO-rEyVF6hhYX>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 10:56:06 -0500 (EST)
Message-ID: <074bd710-1c32-4fec-9ddf-97157bd498b5@jvns.ca>
Date: Tue, 24 Nov 2026 10:56:05 -0500
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
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
 <CALnO6CD6vu1ed3jw4oDceV4n0+zdsOaJGqSHhgaeEWsgGk3owg@mail.gmail.com>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <CALnO6CD6vu1ed3jw4oDceV4n0+zdsOaJGqSHhgaeEWsgGk3owg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> 1. Introduce some imaginary characters who are learning branches for the
>>     first time and examples of workflows they might use. Test readers
>>     said this was helpful because it helped them see different ways
>>     they might use branches.
> This is extremely helpful, not least because of what it does for this doc, but
> because it sets up future guides to refer back to well-known scenarios. In
> particular, I'm mulling on a triangular workflow guide, which could feasibly be
> one component of a guide to collaboration with remotes; these characters will
> have different things to say about remotes!

Cool! I think probably we'd want to re-introduce the characters each 
time (and maybe even choose different characters depending on the 
situation). For a more advanced workflow the characters might be different.

>> +Step 8: Create another branch
>> +-----------------------------
>> +
>> +Now create a second branch called `add-animals`. We're creating two
>> +branches to show what the process of working on multiple changes at the
>> +same time looks like.
>> +
>> +First, switch back to the `main` branch. This is important because
>> +normally when you start a new branch, you'll start it from the
>> +current `main`.
>> +
>> +We normally start from `main` because if you create a branch called `two`
>> +while on the `one` branch, merging `two` into `main` will also
>> +merge `one`. Starting from `main` keeps all the branches separate.
> This feels a bit confusing to me on first read, if only because the "two" and
> "one" branches are hypothetical (and because we haven't covered merges yet).
> I don't love to keep the reader in suspense ("we'll explain why we do this
> later"), but I do wonder if we can give a better demonstration of what happens
> when we stack a branch like this by using the example names here?
>
> Perhaps we can start with the idea that we want to keep work independent
> ("Branches are a tool to organize your work", "working on multiple unrelated
> changes"), and then after merges are introduced we can revisit the stacked
> version and show what happens in that scenario? There are pros and cons to
> stacking, but I think covering "branch per independent idea" as the norm is a
> good way to handle it.

I like this, I'll try just saying "You'll usually want to start all new 
branches from the `main` branch
to keep your branches independent from each other."

I agree it's weird to talk about merging since we haven't introduced it 
yet. I'll take that out.

I think stacking is probably too advanced for this beginner tutorial.

>> ...
> Here are the last handful of sections, and 2 paragraphs that come between what I
> see as major sections. Here alas flat text bites us a bit: it's not particularly
> evident that step 13 + it's merge conflict note form "the end" of the practicum,
> and the stuff afterwards is (somewhat) back to the introductory concept idea or
> examples.

I agree the last few sections are pretty messy, thanks for finding that.

I've reorganized things for v2 like this::

- Move the "merge conflicts" section into a note
- Move the "3 ways to think about branch" inline in the step-by-step 
tutorial, after step 6 (next to the example it's talking about)
- Rename the section about workflows to "Examples of using branches to 
collaborate" to make it clear that the `git pull` section is a 
subsection of the overall workflows section
- Add a little overview at the beginning explaining the structure of the 
document:

This tutorial contains:

   1. <<intro,An introduction to branches>>
   2. <<tutorial,A step-by-step practical tutorial>>
   3. <<workflows,Example collaboration workflows>>
   4. <<tip,Tips, GUI tools, and where to learn more>>

"Tips, GUI tools, and where to learn more" is still a little bit of a 
grab bag at the end but at least it's laid out at the beginning now

Thanks for the review!

