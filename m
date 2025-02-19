Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7771ACEBA
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981109; cv=none; b=qieu0uA2f83YOAS3p+reA0Ij65Vy6/zW/RUR9mq60JwwRWRpnoJnLrLHs95xJQdbC/+88Stc2hvGbDYbl3wZ/oGyfwl6RTt1YJc1RTtn6aG8mMB5MYdi/Qr6Xo1DW5HuNcLAubgTkDt5zI4+6yXleySr4Q+Ercl7owLxjcfPggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981109; c=relaxed/simple;
	bh=KHtv2D6qrNt9fMmtnD6MMTw5lj7xL6MB+LbR7byZrJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sjrHtt7fSoRgEWjtWN2s57eao5sMrRYaEXEKrAEQW7gyd3SjLYKKuhTyUIsP53yoep+lL66Z6PXcI9Xevc8z2EGkp3lPTdd48lbrYLa95xMks+p2OZ/p+ifoYfIQtFGCs1b1GN8TSDI5rVEMmH//xkWhKiKKgAVDlgIIZIkFfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNPrvbNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HH28rLR9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNPrvbNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HH28rLR9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9BF711400DB;
	Wed, 19 Feb 2025 11:05:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 11:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739981106; x=1740067506; bh=XvbQbl8laM
	kbO46vKvNm0X/A38qq2V7Y663hgfKgJ18=; b=bNPrvbNVR7X0u/ooyWuyQkjOnD
	5oPFlMN4I3j5ChvZpwh51gjlkn1x4Q+QNv5UCPFcwgfvyU/h3sCC9K97FWDdnec1
	gNufnRp0rBC9UndJjrtvpPjTp+hUxg//nq4m1r4ZGtiXbVuTh9FY2e8zlawuNL4e
	Fd6hfbbxhpkHVmxUMRB0GRa5aolsv8l6y4GiHael4l8Mqt7upn2oaY4Z0tRuWO+y
	jxvA/CdHZg7YMWWjiKK45Fm0T5unRtDBJV70utXIuSDeGZUHq/2Iolr9kOs1+0hv
	QcqAhvuXFGnYG7lgUJvFUNKM9UwVoMNA/pZe7NCFEDiH3bruiens9oT5ftsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739981106; x=1740067506; bh=XvbQbl8laMkbO46vKvNm0X/A38qq2V7Y663
	hgfKgJ18=; b=HH28rLR9BM7bqmT9XBMz2derPW484xRvaLWstI23tsl1feUV6Xv
	8AlkoAEEyNK1E5W0pCS/XdLM4fxGYqAB5EJHecvj7XbUnoPiSBsVgOnfffah2KXI
	ICkUDKTsayqwXdWNodQrc6hReOTdXzNQEvCVBnzkGcf9cY2/R+xFl79EmvuvQ+fC
	odSkxJ3fz9dsiNo2QVmLPxaFCxkNiQrXzmvhzSvE21tngAMOOv+MZlB3dQPg0NWc
	I4dtOK1IzvdXOaiX5C9RSJwmadfgNI55ZFDfp/O8+8Z5bOFYT/eo7+YdeeVc14js
	P5vQlwRfvZG0wLv5XhMSMsKkFs0b8l20Zkw==
X-ME-Sender: <xms:MgG2Z3Hcv7AeoZk4K9qwGVK2U6D0bhsFW3igieblnyKYXC51vk5-Wg>
    <xme:MgG2Z0V-4B8oTxI8knScGmceSNkiPcxrSR5iALNotEmUIZm5SAH6y1G5N4-fg1OI8
    -yngd9wngM7P3tC6g>
X-ME-Received: <xmr:MgG2Z5IZBHlhJmoWrUQ_YISx4MMK_aan00KDpa1xiEpmgObZC38s_GzbtRu9wbrIH5Mzh5N9tmM8S7vu2_ptjpsHWi6hcsatI25777k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphdrugdrohhlihhvvghrsehmrghvihhtrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    esmhgrvhhithdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:MgG2Z1F7M6nnFXPEuGsopYQjpgc3TKGPFm8Qo8DSNOZ2-VEm7oNcDA>
    <xmx:MgG2Z9ULpnQHZoE3PH-DlV52fBhbzUhIZ8o5zuTv9jnPJHuT63dIpQ>
    <xmx:MgG2ZwMEl_jsWFQR0f40MtndcLKJ-PWIObmmvj1xRxZVgNG-AsnKRg>
    <xmx:MgG2Z834SEUKdHKr3CSQURfBarXS4X_meP-ck0eoMYRIOooRsOj1NA>
    <xmx:MgG2Z7fbW-I655zx5RngHga6BsfOakkOraJJvd2xceGQrrVzDJxnt_33>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 11:05:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Peter Oliver <p.d.oliver@mavit.org.uk>,  git@vger.kernel.org,  Peter
 Oliver <git@mavit.org.uk>
Subject: Re: [PATCH v3 0/2] Fix Meson Perl version check
In-Reply-To: <Z7WFpu6QEBJXwAIH@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Feb 2025 08:17:58 +0100")
References: <Z5c4OzzHWOo30Hu6@pks.im>
	<20250218153043.63535-1-git@mavit.org.uk> <xmqq8qq3kqyk.fsf@gitster.g>
	<Z7WFpu6QEBJXwAIH@pks.im>
Date: Wed, 19 Feb 2025 08:05:04 -0800
Message-ID: <xmqqo6yxhqdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 18, 2025 at 11:12:03AM -0800, Junio C Hamano wrote:
>> Peter Oliver <p.d.oliver@mavit.org.uk> writes:
>> 
>> > Suggested comments added.
>> >
>> > Peter Oliver (2):
>> >   meson: bump minimum required Perl version to 5.26.0
>> >   meson: fix Perl version check for Meson versions before 1.7.0
>> >
>> >  meson.build | 17 ++++++++++++++++-
>> >  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> I wasn't involved in the review of the previous rounds (so it was a
>> bit of surprise for me to be listed on the To: line), but it seems
>> that Patrick and you polished these two together, so I'll see if I
>> can add Patrick's acked-by/reviewed-by while queuing by waiting for
>> the earth to turn one rotation.
>
> Yup, this version looks good to me, thanks Peter. So please feel free to
> add either my Acked-by or Reviewed-by, I'd be fine with either.

Thanks for working well together.  Let me mark the topic for 'next'.

