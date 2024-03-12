Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525140864
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265462; cv=none; b=We6QpxI1ZDw7T373gNJw9tsI5QOjDWvjZ9FCOJXpbKzAaxEDuhQ6tgkyB9K3SRc/PjLJzK34Er9rKZ4c7CkK9yW0+Im7qnFaZDuUiYP0fqJjmh7lE8bEGiUeXXTE9Cx0BfwwENxIy/BuFDGQnboY7ZdlNEIcsZ84CmAfG+Pe1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265462; c=relaxed/simple;
	bh=Qg5Oip/sksIZOiIHfL7otN03Pd0OWc91bLbUm1VYyt0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IoQclh28yjkHQqExGwyMN4qdjnZJTrapBT6PG37hxOpqLpPD/04W81FJm3GrEsM0FUftAFPfe9OeyEfTHJQSFHSoTdi9HCbKSca+EFvFjTdfaol130Vw2uFP97RoyvYM7N1pcvIoGsQJiQudkpaqIGrzrDwuyNv1oRAfmt+x+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=CPBjDRzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZEb21Mh; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="CPBjDRzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZEb21Mh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1332D1800076;
	Tue, 12 Mar 2024 13:44:18 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 12 Mar 2024 13:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710265458; x=1710351858; bh=aMTycaIzAfLPb36mrDgVITGe+QZQWaOT
	p+JhSY1dO3w=; b=CPBjDRzr5tQO2YPNVHOQViWYWDdDgrfasMtRf1bpIhTzjf8Z
	pqENNZ0CP+7QUiG0YPQCQrr3Etlmm0v+7/6ZEkzzzH+QAklBqxinv5P60/uu6WUU
	LAq3+aMOgYxCWLvfoTwBkkCUJ8UJOoef4hk0FXyVv0TUrLJ0mMzKnrz81NNTOwcE
	PSzgqbMY3fCXZ7yPyQqfQelqr8gouXUaUBwhgIn4AftWAX/7YkV+pfAiOx4BsLyt
	kfDG6Lq+Ivd8z61/h7mI8h71koEKumwPpqYVdeIWnsZzrWSgHFLPOMj13BNOiO5H
	DtqvG5n65+nMlo4hBvtOkAqJCSHFP9Zvanlb1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710265458; x=
	1710351858; bh=aMTycaIzAfLPb36mrDgVITGe+QZQWaOTp+JhSY1dO3w=; b=h
	ZEb21MhLzvN9tFbM2GKPdCwZsn3PULvDdO5FIo0mG1iCUng0xLeA9hhtpno0M/3g
	HwiWJRVlfrWiB6SIH3mtNgcnjaxVrbbxdGr6Y7owsYPkNooJ3ud2E+o0yWTTzDrY
	YC8AXMcuuBYs2sVMBQ72vMgXCtkZgA1ZHKWfS05wD/kuPTqZpqqm6pVv2BQQ62+C
	y4C2vXufBTRQFfq0+EFquDfA7VU7f8Pmi2voftxeT3HuV2aVbvMlin1b+stpR0w0
	2ct3fTdHV+nvhddqqL6otLRBlUIAlzyxl8zrwghZCd6A/XUVRXHQrGozyGFIj8aF
	+KmfOaR6n7w/y0ykyWGRw==
X-ME-Sender: <xms:cpTwZRJtK8_EQgax4GpRKSrUZPGhhfnGC9xuSWlpa_eBepqXU3XRfTM>
    <xme:cpTwZdK4CapWD5wxrZVK9D-3x34vL5jl5a6_eYGjDf_wuxl_Q2ftwBZjkgcdh7p63
    nwp1AuDAFzh-MWnsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:cpTwZZu1KJc8w7BvwHa0gPlxxVb7PWqY9aYGzrxf8J0iYFt9grat3w>
    <xmx:cpTwZSYBRgkHcoPNsefUrhbfd017PRvZ2j4Esf9yVTBn0q6Yl6YRhw>
    <xmx:cpTwZYZlIhePGq2Q7oyArwCEkOKmSqoJm3SlGncN-S8LqE8TRxeh_w>
    <xmx:cpTwZWA6Sg3iaYgRbPGyzRuyYGp8kjbtXVl2_41B8p49f3rkhhk4IQ>
    <xmx:cpTwZXldpvvuVWIbr_cXVIiOtuhLy2BrLfGJGAnmHlGP_SVzR8cpsW6LQmA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3F82115A0092; Tue, 12 Mar 2024 13:44:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73a4cb87-2800-4ad1-b7a2-33c6465fcc50@app.fastmail.com>
In-Reply-To: <20240312092959.GA96171@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>
 <20240312092959.GA96171@coredump.intra.peff.net>
Date: Tue, 12 Mar 2024 18:43:55 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] log-tree: take ownership of pointer
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff and thanks for taking a look

On Tue, Mar 12, 2024, at 10:29, Jeff King wrote:
> On Thu, Mar 07, 2024 at 08:59:35PM +0100, Kristoffer Haugsbakk wrote:
>
>> The MIME header handling started using string buffers in
>> d50b69b868d (log_write_email_headers: use strbufs, 2018-05-18). The
>> subject buffer is given to `extra_headers` without that variable taki=
ng
>> ownership; the commit =E2=80=9Cpunts on that ownership=E2=80=9D (in g=
eneral, not just
>> for this buffer).
>>
>> In an upcoming commit we will first assign `extra_headers` to the own=
ed
>> pointer from another `strbuf`. In turn we need this variable to always
>> contain an owned pointer so that we can free it in the calling
>> function.
>
> Hmm, OK. This patch by itself introduces a memory leak. It would be ni=
ce
> if we could couple it with the matching free() so that we can see that
> the issue is fixed. It sounds like your patch 2 is going to introduce
> such a free, but I'm not sure it's complete.

Is it okay if it is done in patch 2?

> It frees the old extra_headers before reassigning it, but nobody
> cleans it up after handling the final commit.

I didn=E2=80=99t get any leak errors from the CI. `extra_headers` in `sh=
ow_log`
is populated by calling `log_write_email_headers`. Then later it is
assigned to

    ctx.after_subject =3D extra_headers;

Then `ctx.after_subject is freed later

    free((char *)ctx.after_subject);

Am I missing something?

> We should also drop the "static" from subject_buffer, if it is no long=
er
> needed. Likewise, any strings that start owning memory (here or in pat=
ch
> 2) should probably drop their "const". That makes the ownership more
> clear, and avoids ugly casts when freeing.

Okay, I=E2=80=99ll do that.

Thanks
