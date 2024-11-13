Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984A33CFC
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537086; cv=none; b=QlpHF5cvXyS2rzPs+zNvPTWnsZ8wU9NgxMAE+7fPo3pi5TKWqqNrzKi52WIs2ELUj5G0L6YWYVIEWfiQttv0frCe4TiOqBiOlTpg/LPyZz3m3cRZlyukxAiZ1G6vo8hbcO7LuuD3X3i41g/ZpogrUp3rx71YqQmc2Ar/3z+7HTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537086; c=relaxed/simple;
	bh=Qnezk3ba6aXxKzvx+ZNyjmMLiV5kOxqM/SRuI3bd41c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jX8FLu9w/byoUKHYGodFbwlDeUdHGu1NrxS6fVTS5uiK+dJqyps9JIYwP97orI+/7xb3Q7PmdSKMBix4DdmmlSEPntWgJJgBCugio0EKYbHahy8I96cAyT1kf9ZXtlpIDyqE4xVQD6FsrdQvs0AaWdioCsuDclmp36XXQsOagY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShMTyGfo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShMTyGfo"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CF5C254023D;
	Wed, 13 Nov 2024 17:31:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 13 Nov 2024 17:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731537082; x=1731623482; bh=9rQWLKoJ4wSqB41sqPYRzymh9ZGlLyRTaUD
	oHJOL/VM=; b=ShMTyGfoNR9OoX7C1wt40TpoMNM2OxuH5xciFAMkoQj1NGRMbo7
	aLR9zeG01xP0kmC5N1Gr1r7W4FRexAtEawsqurzSK5fCJlo1rMsyM6mHdFDDQxkd
	ofezS0CmwHOvmE+SprULWk69Yx7FK8CcAfm+8GadBOWoV8GQcPWC6ZWp35adcJeZ
	NQi91w5QeEZjkfaHJgtQo8+cCKiTdplizWHCmJ1Afzow50w+NziIRg6/YdPB0Hmi
	cvQcmz+C+Pk6L90wsqZgq7zgW0TOF8Yyk5FBXkivB9FPHa1fw5DO+DImtA0bPcEe
	mNujVamtT2Wr03ADSXkuZiZj17wnkyHu/cw==
X-ME-Sender: <xms:uig1Z4ggxO34ioi5ikjkF1oT8oC5Xg32WveMnLJgelPGM-WgGQxamA>
    <xme:uig1ZxAmEqf4-63J2flBJCa0sxeRtE5s4y0LnFJxe3F1HNN2SEnBNK0oRwlOkF0hY
    ExArF6rWh72ldb0eA>
X-ME-Received: <xmr:uig1ZwHtDF90jScIUxytft0HhtEZxWGusXpz2-DSP0DQAoHAr41zjPw3J8Sd9XUqgjxWttnUZE3hgXOnXKDRCKisbvdtz7_kfTLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhfjhhlrggsohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uig1Z5Q7P7UHhAiQYjvcz8GCExuIyj81Bb4qlxgEJbcyy1svp_7uYg>
    <xmx:uig1Z1waJ3xClDvZYZ3edUMnxJwQrXVL0vE0dvJLV2CMG2LoFiRTEg>
    <xmx:uig1Z359C5QHWOxTiZ_FIKQA7-2EgWKguXGOECQ8nhwfSpqvtCu8GA>
    <xmx:uig1Zyw0acIJl9F2mthCjG6WkTo7M-2Rt9025O8C8HPtBRaBFCNuPw>
    <xmx:uig1Z3ucRJquTU3pqqTqhO_rwCGbPJMDBjkEGJW6_fIJeyTskgwL86AQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 17:31:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: =?utf-8?B?44G144GY44KS?= <ffjlabo@gmail.com>,  git@vger.kernel.org
Subject: Re: Trailers Containing Underscore or Dot Characters
In-Reply-To: <CAP8UFD0_+=5xmw6y5qiO22KMZhExLyZ=5HRjYphLD66vt0LLNg@mail.gmail.com>
	(Christian Couder's message of "Wed, 13 Nov 2024 22:57:34 +0100")
References: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
	<CAP8UFD0_+=5xmw6y5qiO22KMZhExLyZ=5HRjYphLD66vt0LLNg@mail.gmail.com>
Date: Thu, 14 Nov 2024 07:31:20 +0900
Message-ID: <xmqqa5e2ahqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Date:   Wed Nov 13 08:28:19 2024 +0300
>>     Test
>>     test_hoge: fuga:
>>     test.hoge: fuga:
>>     test-hoge: fuga
>> ```
>>
>> What's different between what you expected and what actually happened?
>>
>> The one for `--trailer "test-hoge: fuga"` is finished with nothing.
>> But The others for ones which have "_" or "." are finished with ":".
>
> Yeah, that's because '-' is allowed in trailer keys while '_' and '.' are not.

Thanks for responding.

I did not offhand recall seeing anywhere in our documentation set
that defines what a valid trailer key looks like, so I went and read
the interpret-trailers manual page and did not find any.  For
example, is this a valid trailer line, even if we know '-' is
"allowed in trailer keys"?

	-test: fuga

Is this a valid trailer line, when your configuration adds '-' to
the set of separator characters?

	test- fuga

We do not even have an entry in the glossary for "trailer", and that
probably is the first thing we need to fix.

