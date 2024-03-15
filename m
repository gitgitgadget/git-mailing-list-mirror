Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCC17BA9
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487038; cv=none; b=UDgewNtZTXTIDGCGMw80Y00CT0qZNSdpw1xtk8QT57xHTo+cneGn3HBXpdEkuCmUzw2jo86pqwhxi/T5zcWn+89UgXfGahJ93M0yih/zgtv/CZt2O39KpZDUJrWgqdBfP0vl44Q1rrLTQcycSHdSP13kBBFe+lVl/LiATEArxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487038; c=relaxed/simple;
	bh=9tHM3ZxcMhP5adqIfje4TpPBJug8iNSlPFZa/aQ5w2s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Hj2FahR2UGn3Xud3VW5GxGcddJhLWG5fFR7eAt8IVyPGFQqlvBTBLbCYYFIF9XPqLcOuVLyy8gmJsb/8in5MFiMiZ5PZrVDCIbHLkIbPkMHiR9t0s9Qj2bhHmWeeIE5+p/DiQnTV9e2Sm/V8hRRDvvPybUX2DpwT7N/cARFFLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=p97pgcUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJm1lA2t; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="p97pgcUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJm1lA2t"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A3A443200258;
	Fri, 15 Mar 2024 03:17:14 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 03:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710487034; x=1710573434; bh=BLkA9Pn2IaEnvSEYqcZ3VMBf9YtbfsfS
	358F8PDnWlk=; b=p97pgcUEQdQtmD1VDKxNUavYq19vSwqW3L7E7vg1jdWENglO
	7n0wtCkuQANSDrgfWOq7l8YvfwVO0RrTYvDT+3/REcUts8lKEfaEW4OrZFGvBmKe
	MYJQtBwgwvX+XEZgRmW//tRgyT4qcR8Yex1f2RATHlLGgV5rnvLuYG3iQrue6VpD
	jITCAcdVem2PF5gIBbKg7kn3LIR8gXDn+a0765PXipsfN+N9Ozb1+Vl5gQHvM6E1
	SLACX62nDA1y2GiUYdkOzKvi3BGM3Sych5qEmdcWO5DlD1WYTPcoSsdtfWEWjx7+
	fQBI7oY9RnBCYaRxtxML2cNdUhsDRNxDxVMUdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710487034; x=
	1710573434; bh=BLkA9Pn2IaEnvSEYqcZ3VMBf9YtbfsfS358F8PDnWlk=; b=I
	Jm1lA2trSMfy0BbEHQo06ZYypf5wy5xI//4QPWmWwbBIWaFLvcns91VyHvaAjRs1
	XHjFuWwVFmFD02P2a3NH82zu3V1Orn2Z7WFqgJ3GQHv8q1EgUMRTWDjakBBiUAd0
	ga+Mk6YdZgKv/vtGyfrDQC4AAMDHfFf/vbX0aqLmQEcCi+gp2VXgEfq/z3PYhMW2
	hD/BaQ0uz8s2hgLRKhEtAy4nQkU9BZRPfa9UiNv3289SArxRrxqIv8n57XPzrK0u
	L8wKwQe5bYWkQpCuh806hhRAL3CoAMCiSb1Ey79QujpWFHBC5rjDN0YbXRk5A3J/
	YQh0EdyLrxOADcM98F95w==
X-ME-Sender: <xms:-fXzZQqufhPbR0z-ZolqxbH-tTIteG10NdLSWeMbB2QYYJDNczO1BZ0>
    <xme:-fXzZWoye4Kw_kHsJ1CsTPRO09wvvs3uxvvhV6SkdVbGOmDaAqHJSYvVe70rR8Ji4
    dtR-JEDKdI3WCPOfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeekgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:-fXzZVML2JrCz8RC6crdQqzfCTn48HNF-o57kF9JnT1zUD9CbOry3Q>
    <xmx:-fXzZX7QkLf5URhVs_hNWiowsWfz7HiCTLHpnbn4rs5acqW4dIXhaQ>
    <xmx:-fXzZf69Zfhu5miLf-_3qMvyBhttPK_XuhKI8_O37RPcFBy6NHlV2w>
    <xmx:-fXzZXi1EheOuhN-DhCgFhJLBBzyIDTV-4UMFAWejTeTCKBWnj2ZVw>
    <xmx:-vXzZcupezjdPMhyqYty_G3QcXtFvrHex1966JdXSWx0Iyoq6viXIw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7279915A0093; Fri, 15 Mar 2024 03:17:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
In-Reply-To: <20240315055944.GB1741107@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
Date: Fri, 15 Mar 2024 08:16:53 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Dragan Simic" <dsimic@manjaro.org>,
 "Manlio Perillo" <manlio.perillo@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, at 06:59, Jeff King wrote:
> On Wed, Mar 13, 2024 at 07:23:25PM +0100, Kristoffer Haugsbakk wrote:
>
>> Thanks for your work on this. Now I can use dingbats as my comment ch=
ar.
>
> Truly we have entered a golden age of technology. ;)

QoL features can in aggregate have a surprising impact :)

>
>> > @@ -523,7 +523,9 @@ core.commentChar::
>> >  	Commands such as `commit` and `tag` that let you edit
>> >  	messages consider a line that begins with this character
>> >  	commented, and removes them after the editor returns
>> > -	(default '#').
>> > +	(default '#'). Note that this option can take values larger than
>> > +	a byte (whether a single multi-byte character, or you
>> > +	could even go wild with a multi-character sequence).
>>
>> I don=E2=80=99t know if this expanded description focuses a bit much =
on the
>> history of the change[1] or if it is intentionally indirect about this
>> char-is-really-a-string behavior as a sort of easter egg.[2]
>
> Mostly I was worried that people would take "char" in the name to assu=
me
> it could only be a single byte (I had originally even started the new
> sentence with "Despite the word 'char' in the name, this option
> can..."). And that is not just history, but a name we are stuck with
> forever[1].

Missing footnote or referring to my footnote?

My suggestion was to use a `core.commentString` alias. Which might
matter for new answers to questions about its use. It might not matter
if in practice most people get their config tips from 1500 point
StackOverflow question about how git-commit(1) keeps swallowing their
GitHub issue numbers (due to automatic linewrap) from 2011.

> Certainly "char" is an ambiguous term, though. I didn't mean to leave
> char-is-a-string as an easter egg; that's what I meant by
> "multi-character sequence". Certainly "string" is a shorter way of
> saying that. ;) But I wasn't sure its meaning would be obvious without
> the word "multi-character". Giving an example as you suggested does
> help that.
>
> That said...
>
>> Maybe it could be more directly stated like:
>>
>>   =E2=80=9C Note that this variable can in fact be a string like `foo=
`; it
>>     doesn=E2=80=99t have to be a single character.
>
> I actually do think the "string" nature is mostly uninteresting, and I=
'd
> be OK leaving it as an easter egg.

To my mind a string subsumes a char (multi- or not). Like in programming
languages: some might be used to single-char `#`, but I don=E2=80=99t th=
ink they
do a double take when they see languages with `//` or `--`.

> What your suggestion doesn't say is that multi-byte characters are
> OK. But if we think people will just assume that in a modern UTF-8
> world, then maybe we don't need to say anything at all?

Given that we=E2=80=99re mostly in the context of a commit message, an
ASCII-only restriction would feel archaic.

I guess it depends on what the *normal* is in the documentation at
large. As a user I=E2=80=99m used to Git handling the text that I give i=
t.

> It actually does not have to be UTF-8.

Good point. Unicode is more appropriate.

> (Though to be clear, I think anybody using non-UTF8 in 2024 deserves
> our pity either for being crazy or for being stuck working on an
> antiquated system).

I honestly feel blessed that I have to worry so little about text
encoding.

--=20
Kristoffer Haugsbakk

