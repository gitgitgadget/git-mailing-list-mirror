Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADF170A11
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569925; cv=none; b=dZO8hWTG6RgekqmSRZtAJORvyxBq3p/7ufYuqY0pMlnPYIjbme/t1uz9yoZyyeLsdOJpOGngn9iiCXc2pGuo7PAISZscsRiUAL4M0wXuuVrQI9g7SM0kgQ2rZGZJ06yP5Mp6fdhIjbfPx/r7XEwbdtieqXp6lJiR1RKnCDAMIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569925; c=relaxed/simple;
	bh=keJcgaFP6W2j6nmdrSGFqQ0FeIzjdwRJyTd4PNo+AA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ssf8wnYC7IoYmiKDkXwKAjM8SWBnmHNCk2mIxiAlPbiA6QewPmSUlmEVGtPtWMkVbc5BT8bnAae4cGUWC8r9u64r2qKsQBVOxT/9nSt5xuS1iDvWKIWOxRGXleBp+XTZJ/0g2/fQ+NRSdafILRGwhE5invQM/FoJrSKNruL5otc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OcASJnVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgtRdeSZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OcASJnVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgtRdeSZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 313F511401B8;
	Wed, 22 Jan 2025 13:18:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jan 2025 13:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737569922; x=1737656322; bh=MQQGsYBNaO
	ejspDXR5kuvQF02XahM5hjdQPcK/Hpd3M=; b=OcASJnVHf4sT5+78tZmnbOr7kP
	u/77g3I6iUmsXoYKphdX3g+IZDi1yHjalRPmpkyHdWRK1tlrBrKBe6I1H21fwUZO
	iaZun32zepYTcA3g92tYimGoijqMscQUPCOJOgfT61Zoou4k0wn84VaDNrgM5gob
	F6971QbIzyaYh6XkzHbGuPJ5I7GfKmPHuBxBBbk6QsVJagQksQJ8NSS5nX5twSU6
	qDFwraEvo9JUQs3e2AkVcArKa5fvd7hkFyN3ADH4RzNJjc119GfX6BdkQ2fHIu0F
	Wb4qT3iFaLJuGlZuCojgqgntVkGlchNg2wlbjO4C40bUmWDI9TV6NuIxSleQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737569922; x=1737656322; bh=MQQGsYBNaOejspDXR5kuvQF02XahM5hjdQP
	cK/Hpd3M=; b=WgtRdeSZrvgcLraY4yuo6tnsI1gvswD1vvYZZVyaAJFaXqUWpKB
	+MbKA0mqqMFfz7uU1ucbDWA62hMQ+/9UO48agEgwbEAL47Q5lxA4v7+ffl/s/wxo
	HsG/EjCR5eF/RPQu9vdy1aDqJC7KLSpyHetd0/CLipFYzjE/I2c/g9JTGGkQp7qn
	iCOHQNxQ5PL7yuAZ/cVxiPwK4HLSzLKXIbEWciFjFDJOmnWa4samP0Us1mngwOW5
	iUBoPCuoeDMUsBbnFN50AudO6RosKLa9atc0vZYnc+MqxD6IoztoK66A3yqeQzsR
	bdm3qFqYqGSq05XjrBF6riltbZHvcCUr9Bg==
X-ME-Sender: <xms:gTaRZ1ZS3C_YYzilZDMba1HUHzXWQvKRBxco5JMY92G4m49mVt0T5g>
    <xme:gTaRZ8ZuBhbdJ912Ml1W47rtuXn2MlnA6NU56XSpH-PbAyC6WxzYCTkmhZoxiCRFC
    A2A3iq2_-E0-61DkQ>
X-ME-Received: <xmr:gTaRZ39mK_KP6MBLc_zo9o8Fkp-srktcDcXl3Lsf1WmAq7xHH9WcIDJzPSJ9YnnUk_Txe-o7pVFjufYFl5b0WfS4fBaBdT-_Av4e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegrugestggrnhhvrgdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gjaRZzoqiP6TGDiRrfAFymz-gDQRQ_DC8HfCzr-B2Sf7PcBn3g6NOQ>
    <xmx:gjaRZwrbpSsxft4fbD45YhYdrs4nxDq42oSX7lLow0DC6jfnEgMjBw>
    <xmx:gjaRZ5Tbh7IG36DP1YrrPANRQTGzF13csTeKgaHIeiPE5r_bVng2qg>
    <xmx:gjaRZ4oHLUrUxxx47tnCSIIArVYXXIkT3sRrFCv6hSdq5Zo7Ddokpw>
    <xmx:gjaRZ1CmpkCKA5BSwz5DZBP9arMYvjoPriatozkpDs6QBS6EsIjrfT7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 13:18:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>,  Adam Murray
 <ad@canva.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where
 no value specified
In-Reply-To: <xmqqfrlawwd9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	22 Jan 2025 10:12:50 -0800")
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
	<pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
	<c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
	<xmqqfrlawwd9.fsf@gitster.g>
Date: Wed, 22 Jan 2025 10:18:40 -0800
Message-ID: <xmqqbjvyww3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>
>> This patch looks good to me!
>
> Thanks.  As I punted on reviewing the tgt_perf part, it is very good
> to see somebody else step in to look it over.
>
> Will queue.

The test part used broken indentation and also the use of
test_when_finished was careless, so I'll touch it up before queuing.

No need to resend.

Thanks.
