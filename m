Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA556B77
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352276; cv=none; b=ucnY/ZoIIfLwTv47BGjX+6+2u40jh4mmdZKEcSCqJGk/X+iXcDFaqtUKOYehg3fnArpoEgkbHmvyORcdunlA0zjp5EAWxy982naT21RKOHGWH4quXDrDpa2dgQp4b7DjVdAVTwJzs+fRciRrd1MppfiAHIpx85beSRUOt5oKmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352276; c=relaxed/simple;
	bh=C5i/VZya7+b+SsTsXMRdozzxRiZQUtecFuLWNsRtN2w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oyEmsj2UJapAX3HomER35Nn5HW1IqQeGD6pW6gp3eLj+LtJDKH6dLn456q9qmlqOUynFxHJK7WA0K4D/j9b/OU1a+ggfFO8vcvOlHCESeWsysimUYaaTvOY6K+uFBIGaW4QcIGTdYs4Kf8eCukallk/nz/1kGqT6EVS07C1bE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=F3x5W+Q/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=om2Sifa4; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="F3x5W+Q/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="om2Sifa4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id ECFAA18000E4;
	Wed, 13 Mar 2024 13:51:12 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Wed, 13 Mar 2024 13:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710352272; x=1710438672; bh=yPSsrkm9oN0oXYAZg0xP6RcYRPJYozhN
	u/mirnB0xBw=; b=F3x5W+Q/5bHKkGrFZWrDR2/f3SU9uhvY7TNB/a+cfiLWdBSX
	CFNvlEtKxNTi0XnWkUdgt3BKs4Xq69BE6VkmOKbR+s5LkgRjuNNL3hM30tDYFwYh
	DQPdD9GLQL/71YHV/nxZRNFPVCcqY1Nkl34nL/n+JRIsMaphTMw8ShHoHb4ekvog
	B/hW2j/2FUDecCYiHJsfsdj3+Ufj8nBcEn1UG0eBfYn0AkETz2kYzzJRDeuss6fw
	nP7sCmg+ze8QsPUQoEipwbtncCxI6DBAzHEuT89g5etuAnWbvfIe874tyQiTn8Jh
	/dV1ay9ZQX8NlSpuu+vOlneyvMF0Zp2FPJFHhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710352272; x=
	1710438672; bh=yPSsrkm9oN0oXYAZg0xP6RcYRPJYozhNu/mirnB0xBw=; b=o
	m2Sifa4MQNH0vWsWjTEFgarhUnwJFDCgpJKqPAXzHyHVhFa/U8gEUlKutI+31oky
	8GJyzA2tfdeATe0uWmLtLpZV/ShIC4AHj7YvKKy3jFrQLx8YMl76FvNo0qAtaIbQ
	LSVzsCk7gbByKD5oapt2/ipROmIj44p9Wm5EZ3DynLKpGZ6pUs5BzW+s0vzKZAaI
	IwNxiHFq2UBn8685MyxU8T8dMPKmNTneQ6NvloI9UOldNtnwuLlabVjoSAW/qdiO
	2Gv+NjsgIHPdF+tqxxUjDVARM29m9OA53JLmdfPj8XHCLIsYqz26ASUYl8pqAJyV
	Byy/2KRKxe1LqqukLdSNQ==
X-ME-Sender: <xms:kOfxZQ65Ai4uq0dH8C6yW5y8aVX4s8FFwavioehC-sUJ3WycWV4kKBg>
    <xme:kOfxZR57SQ5Abvoa7zR-JGQXLF1btynEVf0vLIARPA3nK1JiCUNptX7bjE2UTE0B6
    MTh5bQKt-0yb32mpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:kOfxZfe37pT6lOfpyAEDnBJsP3LBip5DwUHt6z9xg7kstbOIJWzEzw>
    <xmx:kOfxZVKqg_H0nBB3n8WO-k8gVHynugOOGUuRj8XOb070UcZD0HVirA>
    <xmx:kOfxZUL18HtRv-r-ewmvq1dylTUBISyW76eCOfdS8qbMtkRGSR70VQ>
    <xmx:kOfxZWxVsBdK60y42pV69Oxx_ULwI21PwJ46BnkJSPyhR7nDpukTHA>
    <xmx:kOfxZbWouM_EQxOTb2kvzRHQSe30Djikq_CCY2dlXxLywt_-IHcVRnRDmfs>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30D2C1700096; Wed, 13 Mar 2024 13:51:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <929692bc-c5f5-4dca-a96c-5b95603c3d26@app.fastmail.com>
In-Reply-To: <20240313065454.GB125150@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>
 <20240312092959.GA96171@coredump.intra.peff.net>
 <73a4cb87-2800-4ad1-b7a2-33c6465fcc50@app.fastmail.com>
 <20240313065454.GB125150@coredump.intra.peff.net>
Date: Wed, 13 Mar 2024 18:49:52 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] log-tree: take ownership of pointer
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 07:54, Jeff King wrote:
> On Tue, Mar 12, 2024 at 06:43:55PM +0100, Kristoffer Haugsbakk wrote:
>
>> > Hmm, OK. This patch by itself introduces a memory leak. It would be=
 nice
>> > if we could couple it with the matching free() so that we can see t=
hat
>> > the issue is fixed. It sounds like your patch 2 is going to introdu=
ce
>> > such a free, but I'm not sure it's complete.
>>
>> Is it okay if it is done in patch 2?
>
> I don't think it's the end of the world to do it in patch 2, as long as
> we end up in a good spot. But IMHO it's really hard for reviewers to
> understand what is going on, because it's intermingled with so many
> other changes. It would be much easier to read if we had a preparatory
> patch that switched the memory ownership of the field, and then built =
on
> top of that.

Sounds good. I=E2=80=99ll do that.

> But I recognize that sometimes that's hard to do, because the state is
> so tangled that the functional change is what untangles it. I'm not su=
re
> if that's the case here or not; you'd probably have a better idea as
> somebody who looked carefully at it recently.

Seems doable in this case.

By the way. I pretty much just elbowed in the changes I needed (like in
`revision.h`) in order to add this per-patch/cover letter headers
variable. Let me know if there are better ways to do it.

>> > It frees the old extra_headers before reassigning it, but nobody
>> > cleans it up after handling the final commit.
>>
>> I didn=E2=80=99t get any leak errors from the CI. `extra_headers` in =
`show_log`
>> is populated by calling `log_write_email_headers`. Then later it is
>> assigned to
>>
>>     ctx.after_subject =3D extra_headers;
>>
>> Then `ctx.after_subject is freed later
>>
>>     free((char *)ctx.after_subject);
>>
>> Am I missing something?
>
> Ah, I see. I was confused by looking for a free of an extra_headers
> field. We have rev_info.extra_headers, and that is _not_ owned by
> rev_info. We used to assign that to a variable in
> log_write_email_headers(), but now we actually make a copy of it. And =
so
> the copy is freed in that function when we replace it with a version
> containing extra mime headers here:
>
> [snip]
>
> But the actual ownership is passed out via the extra_headers_p variabl=
e,
> and that is what is assigned to ctx.after_subject (which now takes
> ownership).
>
> I think in the snippet I quoted above that extra_headers could never be
> NULL now, right? We'll always return at least an empty string. But
> moreover, we are formatting it into a strbuf, only to potentially copy
> it it another strbuf. Couldn't we just do it all in one strbuf?
>
> Something like this:
>
> [snip]
>
>
> The resulting code is shorter and (IMHO) easier to understand. It
> avoids an extra allocation and copy when using mime. It also avoids the
> allocation of an empty string when opt->extra_headers and
> opt->pe_headers are both NULL. It does make an extra copy when
> extra_headers is non-NULL but pe_headers is NULL (and you're not using
> MIME), as we could just use opt->extra_headers as-is, then. But since
> the caller needs to take ownership, we can't avoid that copy.
>
> I think you could even do this cleanup before adding pe_headers,
> especially if it was coupled with cleaning up the memory ownership
> issues.
>
> -Peff

I haven=E2=80=99t tried yet but this seems like a good plan. It was gett=
ing a
getting a bit too back and forth with my changes. So I=E2=80=99ll try to=
 use
your patch and see if I can get a clean preparatory patch/commit before
the main change.

Cheers

--=20
Kristoffer Haugsbakk

