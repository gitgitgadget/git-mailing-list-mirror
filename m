Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511E405F7
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728116; cv=none; b=ZoV3lncvce9rtHvn7hSOQbXuwqb+EfAAIXp6hbiTK8NL2mhc6kMSlsZ7fmdNJRLNPzxDT0TZm6kLlG0/X2S9XgFskMfamqVcARCS+sOkoNVbH3EPUG24P3VdkIZ3zVXG7SOUJit7OqH3pFRJGK3NYxEGJyY+Rqx00N3B3foeisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728116; c=relaxed/simple;
	bh=bQD3tJ7c1P17mPJQ+EfjKVKEkBT8aNWYYi/p5iaQiX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S89z1nTGa5KmQoURrQBSb68Et5HkLXoua3FveBIVFwfjMSqkkOUptKJX9O1+A6+RbbGbUY6b+vKK5+wiueHSdQ4N+u4jIn5j4/5+uAIlVvW73aphDiZ+1JfmofxHeseWpIRmojxVQ2O6w2O13LQw/i1FL1JdOZenmDaZykKAwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qlxf/MCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i7wfLYec; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qlxf/MCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i7wfLYec"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC58625400D6;
	Sun, 16 Feb 2025 12:48:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 16 Feb 2025 12:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739728112; x=1739814512; bh=bQD3tJ7c1P
	17mPJQ+EfjKVKEkBT8aNWYYi/p5iaQiX4=; b=Qlxf/MCtFlowAb6t/3OJPYPlZL
	Qv5O1moAdEbPIlD1tNJPbicgXUznQgKFDte0JD9s6BL5dkM0YZNbeNYNsMvP7djl
	oFE2IZO0rc5HoBpmazZopjS/V8TtS7aIuCc24918utJeO6TIOfBHM5hIGYfjtZlW
	1lqCU82w9SV+6o+THcj3ub21tdJwaGqDVKlwiTXfnRGonkeHA2eiWUvfg54bo4XD
	pNKHePwQoqNRJ4bh80LcR/v+FwZ9OdyvH8GEdOLd4Mb8IM2/dXJl0len3HyfMbIP
	z6WuYpw1NkPNVC/Y5UQPToXJ40vTyuyMUQNvIR2vzHjRG1pMGUySPQ3tmWqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739728112; x=1739814512; bh=bQD3tJ7c1P17mPJQ+EfjKVKEkBT8aNWYYi/
	p5iaQiX4=; b=i7wfLYecyOiVxyRRrG6Z5fJnDPG/H65+t8QTon+Vunwyk5AlkXN
	RCeoesd5feWGMV6ivQhM6GpZNn9GeYUBrCiUXNKA+k9eYw06Zok0kzJCJOSx1Iyf
	dLbsh5xWJo6Y8ccgofiuTGNB6TEnPe/R/S2mIdc/KiNtXR4v/HrABgatR+5MQjRc
	frnTKdSlUIu52a65b1Jm6YBzXXVFl8kScTifRIQ1JISCTDPxPlWPo9LjVHjMOg4A
	vuTVYrkECJViraP/XecYAHJzaViecpppXSGvNL+kw1FxNvvorJjQ9MJ39GDetCXn
	n/Ro+FvnoBvwQhIEgf0a2t3GOUAXR8QBXDw==
X-ME-Sender: <xms:8CSyZ9D7EJxhMOigtWHhdlM43ta_oKJa5qb4a0g0Z1tI6wpaG42nww>
    <xme:8CSyZ7gzLoHp14Qab0sPWJI_sHsscY9avoAHAPnlDVVL_6Z8KdQuWYCzN0abFUbQt
    L3B2dwskYmT8Wq2HA>
X-ME-Received: <xmr:8CSyZ4mtI7h2PGM0DC5scbJLwf7P-ZN1jcdp84Y1UihijLhE0qv3tx4DP0NvIj9RoBd_J82KvY0sv6sE0OiEaxwCNAXh7JQXWFiM_CY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehiedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrggrrhhtihgtrd
    hsihhvrghrrggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghk
    khgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8CSyZ3xlSYKtssdjwppDIMudwcZPS-Ba6toyK5vTQhoQvBKqQg5T5g>
    <xmx:8CSyZyRiAb3arYG0KdcehYbTks10EXkcZnoDO1Ly_7tSLbsZqqAOQA>
    <xmx:8CSyZ6a92elpgTyy4Su-HdnlK3XxLQ_4CYsw92YUUei1jQ5PuplDsA>
    <xmx:8CSyZzR1vm0Hsq3HaAcBYxrc3pNik2Zzr6EDAgVzdXW4qJT4AYI52w>
    <xmx:8CSyZ1EKLUKOvXYxII9LpJmvARiizkzLBpOcN04Jxs2BfmtoZ_GadX9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 12:48:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Jialuo She <shejialuo@gmail.com>,  Git Mailing
 List <git@vger.kernel.org>,  Christian Couder
 <christian.couder@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: Git in GSoC 2025
In-Reply-To: <59004310-f270-468d-a248-c83c97de4a1f@gmail.com> (Kaartic
	Sivaraam's message of "Sun, 16 Feb 2025 19:23:02 +0530")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<Z432QXJb_TfzNBa2@pks.im>
	<c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
	<cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
	<d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
	<CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
	<a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
	<Z6Xmrfut7jdsVAfg@pks.im>
	<fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
	<D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
	<59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
Date: Sun, 16 Feb 2025 09:48:29 -0800
Message-ID: <xmqqikp9zspe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Ghanshyam,
>
> On 16/02/25 18:26, Ghanshyam Thakkar wrote:
>> I can co-mentor this summer. The 'Machine-Readable Repository
>> Information
>> Query Tool' project seems interesting to me, although I'm up for co-mentoring
>> in other projects as well. Let me know if you need any help with
>> anything else.
>>
>
> That's great to hear! Thank you for volunteering. I've added you as
> a potential co-mentor for the project that you've mentioned. We
> could discuss about the allocation to other projects based on the
> applications that we receive. Feel free to let me know if there are
> specific projects you wish to co-mentor in.
>
> Also, feel free to share if you have any other ideas that we could have
> for this GSoC.

It is great to see that old timers who have been dormant for a
while, as well as newcomers who have been around for less than a
year, to be running and volunteering these mentoring programs.

Please keep the community thriving with more of both old and new
blood.

Thanks.
