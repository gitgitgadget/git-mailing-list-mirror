Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAC2848BA
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774069398; cv=none; b=gv7n6/E1IrHksjnCqUYmAUS9q0ecdFeo629NVioMCBu2OHCJpV1yIbqI+LS8fm2Z0z1mJYgLIIsu/LHdfsIlz+8/qvHzFA6hRAzSb1K3BHbEYn+ZZ5owDUqv353ZXkjy8cr8ivTMXEkRCkNai6ZOTmTk7Yb0YVG1Bqpbdka48zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774069398; c=relaxed/simple;
	bh=ZnGgyBglofrjP14ript6WYUkeY+t6liD79LPqVnpKd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJ/YIwLvMUYT74KHEWShxqOk7lEbVDRlS1A7Yhu5zaPrpBX9QD/tifwH0xN6Kl9nkRnPKV89EnDMX7P0AjOKYAtGmGgCn+0QJw+NEnzzU3SIeTDWlTC0hnnqOC8JDkUggYQAkTAi2TvIi0/6ykdXuTzcx3vsWpPTSvY/jn7Bicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ShzSUZJM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsBaeek5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ShzSUZJM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsBaeek5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1C6C7A00EA;
	Sat, 21 Mar 2026 01:03:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 21 Mar 2026 01:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774069395; x=1774155795; bh=P/cePaRudJ
	A0CMYaDOXN9HhV2LCdT3e0qBubpBh5lWU=; b=ShzSUZJMIXOz9cOxMbepbTkzp2
	vvQKKZd/1v94ltW/UfTUJUazNThNvVW/bYcRJkJgrwYY0YzBohavMN2Gj6sBcWLX
	PtkUBLFHT+6HDV4+5R2OxVxLFspbquHaeIxfQ+nnSMEUk4sDf7xzwj2gbEqdHDes
	DGf86DNE7mJFgj3Ffib4wV4xdPpw9h9BBQuGzO2AwcegKdn4UWoflewmG4RfTaYy
	RKHoud7HZR6RLfuXPklkyaB+iM+6/zUBXKXg+1OvoCED206ZFNCvc5DsxqALychW
	CBQZUOzZ9G4HWKE4grvxua6QQVs7DBjtUxIyMRfm557Tt/T0i8m4/EcRBHoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774069395; x=1774155795; bh=P/cePaRudJA0CMYaDOXN9HhV2LCdT3e0qBu
	bpBh5lWU=; b=jsBaeek5lnawR/JQCgEfZhOWLwoJEddjIlJkg+zLBYBSQ+qVpyT
	f7B1Hm+Nn+8CzhrAyuQ4xSG1spzF54bDWebyvGO8QQYLLQTPxZtpNZgZtC+MzAwK
	tD5ae7/sGdZDrMU982/KeyoeiJ3J7gXgEQH/rPgzYngYKpauXZiFAHwmmDE5y6GL
	pXvp5A1gzUIfxa72c2uVpZsgZxLm4qMSTmI6ZnZldGY7p2ITxBn9rj0LoVTdzY+l
	A/FkPtiC8K0TzuGTOmqZRC3+/Rcu9sTVcAXoQyWfadLXsJU4cuOgGRe4PZQ+FBc3
	eOAizsOamiO8RDac4hPoidBo29TngHN8bbw==
X-ME-Sender: <xms:kya-aTLkSBe4BMrozpcWiRrOF9YcNQTEpLyNEfRGe6Cx8jEvkPzT4g>
    <xme:kya-aeD7Ujyvu-upuE4xpvmGticRPAA96hIk4V06UET-ZftypFC92CxyvplGYQW5w
    c6sqYQa_3oMFuMoDBAAasE2fXZq6LFO8VR2KT0PILOt8OztuEn60Q>
X-ME-Received: <xmr:kya-aUARM1MNxbxqbvIgJxj_SJ70YNtcBO9nqOMdklEpzg4CIbunkoyBlESDgU7SnmryvKawAH_Rf5SdBmQJjCIXybBp3rDV6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kya-aYAC3zrIi5NNxRlmKbx_nkbGOPPrVIb64ml2tQYG9tNk3FRT7g>
    <xmx:kya-aXrNSPDKfUb2hHpcTQdhYXPMfwkr-In7R9NRpS-ydeV9CDUZTg>
    <xmx:kya-aalyD_SajO0ORecu6oFhzOhEzicx0k6NVIm-f1kXKtKGrFficg>
    <xmx:kya-afzvnGPM1BYON8RxeQovraTkVC-pvpX_okECXzOsXg74mJQIRQ>
    <xmx:kya-abSEaQ9cpfEJNrpzwDtxb_rZhlIH4ymAsOgHExpnKffzifz_48eG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 01:03:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com
Subject: Re: [PATCH] backfill: handle unexpected arguments
In-Reply-To: <xmqqtsu9dc9m.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Mar 2026 21:42:13 -0700")
References: <20260321031643.5185-1-r.siddharth.shrimali@gmail.com>
	<xmqqtsu9dc9m.fsf@gitster.g>
Date: Fri, 20 Mar 2026 22:03:14 -0700
Message-ID: <xmqq341tdbal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if this is a good idea.
>
> When parse_options() finds an unrecognised option, you would get
> usage-with-options help, so without explicitly telling the user
> "Hey, you have an extra argument that I do not expect at the end of
> the command line" and giving only the same usage-with-options help,
> the user would not know why they are seeing the help message, as it
> is totally unclear what mistake they made in their command line.
>
> "git bugreport" is also a command that does not take any positional
> arguments on its command line.  Study how it complains about an
> unwanted argument, and follow its example, perhaps?
>
> Thanks.
>
>> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
>> ---
>>  builtin/backfill.c | 3 +++
>>  1 file changed, 3 insertions(+)

One thing I forgot.  You may want to add a test for this.
