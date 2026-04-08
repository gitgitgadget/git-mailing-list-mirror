Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF035CB6F
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668201; cv=none; b=gSEsDgJqkCuW7kco9IdDhSX49ZVFNV/gkL7AWfzgzhntycipvG1MZNbMJKMKIuG42uEmjGJ/MO4N8N8Wi1alCa4cEspwk91Vabx86RnVkQXzJvZP+lP/6X7QD9ToXegvsHJDbrvr0ok+FqYNgUmDwtqQVPTU3AhhZ80b7H6cXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668201; c=relaxed/simple;
	bh=14DECcFGimsMGgBJepTJE3n/riqQPFnqhuUq1ma7/JI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDfuBd+k1euTqwGA1ZdhRr5fPPXm6oFSgU5XBjjhDgDfXR+SkVDl76U5OmugAXu79IRs8oxDBBV27cd3zskMpZbleRLs0GSGAlu38qPuHQjlyvIc/M7I9OqmWkSW8a7/68Y/EV5ZAi69Y1okAsPPwYOPG5GnGs2g+aN2zE2oe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CD8jJJZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUO40fv8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CD8jJJZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUO40fv8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DE921400019;
	Wed,  8 Apr 2026 13:09:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 13:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775668199; x=1775754599; bh=bK4ymEd4p4
	89WVk3Qyqr/O6yZAtz5RsLQQ1yDDEhj4c=; b=CD8jJJZANWaSWtcjF1xUwfZcsG
	6IwVarZlNZ/TBis0mt/MlJBU23Grw0r1KeaMnnMFsFTbiJPKi6SffSQyobctyWSi
	aljgn9qIO+ucQ2QpiGJiqqQT8ABb3kNkuUkrsLTQBkAsHhxEBXFwkKY0kd4lT2TD
	QN0biNSMECrRlEyLLP+3BSGJ7DS1lK7Zq8k5otqMtFN7DdCUDEHAGsSWlTYRtMPc
	y7V5Mz8md2a1f9t2nMqWzGj5vEKrnbiCLJ2173LnlQrEn7mNB6Qqttlxy8nE7py9
	zbeSM6WXZ/fh5lMU7W1xu9QWVVnd1keNCQpvR+BBugu6t/bILt3l4hehFZEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775668199; x=1775754599; bh=bK4ymEd4p489WVk3Qyqr/O6yZAtz5RsLQQ1
	yDDEhj4c=; b=GUO40fv8zzIQTr2cj3OqHZFPkUuwWTWkFd7x9lwvY9jMjVG29dJ
	Iv5oFQi1++tIwHa2R6kkhmcDUzLo5daVEvdU3m6x5Y+ZKSVaAqK4YpXwrg3dw8FQ
	tNC7BJVYPrb5cS7W9/a4OX+zXJIx1S//fMQykIuv2rN2krLaji2MT6ULSZgg9qkm
	CgMUHQ06zcBhcLY/gODNttV/uSGSNI5r9fZBGBGz4rmN187MTD+X/gAa5c0cQHzx
	WJ+HgZAX+0eTRRzhQxHSq7PS/n+OY5D+XkxIjdKD+AjGNoaOcCC5HbqLfxrsEuJc
	ytEICI+azUHQUCZC28c7Xr1/Z0lyslwTK5g==
X-ME-Sender: <xms:54vWadrJbP0yvQ-H8Xxo5g3Xjo79yKkxJi4GXimtFyz47esOuAHh1A>
    <xme:54vWaTUPFb0523v5jzcMPYz8f7WcI1ak4LqJs29MTNOfhB5MplKt1atLIAYJV_rCf
    I9naUnIYHtL6BonJ4gPFKBb_3WpVavXk5NnI44uaXp14h8_wapLHg>
X-ME-Received: <xmr:54vWaUByQLGFK8qt-XQu8xWlk30jSOCf00ys3lTQyWP6Fr25OKJfj0vy_MQJuhX7xVL3d81rCCBMQ4ffX4deAZrmGcBF9zdeDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhrhgvhi
    grnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgefvddtheduheefge
    duieesghhmrghilhdrtghomhdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:54vWaf2UAxZCh0nDH81p7xqdROQjjcmBKZ96O50ae6QkQqNLNaKxUg>
    <xmx:54vWae2ME71aq_fkQ8riNiBHGeDahBIEcrM1limCgZN0X0o444_tJw>
    <xmx:54vWacANnBEi005ELVCXTgiioQZ4ecDpVWgRjSvxmwJ4P2Pgd_5w6Q>
    <xmx:54vWaV7R1O5yAQwOQxnYfoVKS2VIdwMZHOAqvhdUfT_FwY9mVpUK3g>
    <xmx:54vWae6xy1Ov1eFhPYNZKkfM_TPml2VrNZSpZHeaWabcKbSurUvks1Yx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 13:09:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  a3205153416@gmail.com,  bkkaracay@gmail.com
Subject: Re: [PATCH v5 0/3] refs: reduce reliance on global state
In-Reply-To: <adYV6NK93Kzg1EYG@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Apr 2026 10:46:32 +0200")
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
	<adYV6NK93Kzg1EYG@pks.im>
Date: Wed, 08 Apr 2026 10:09:57 -0700
Message-ID: <xmqqtstlz8d6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Apr 04, 2026 at 07:28:37PM +0530, Shreyansh Paliwal wrote:
>> Changes in v5:
>>  - made the commit message of patch 1/3 more explicit.
>> 
>> Changes in v4:
>>  - Dropped patches 1/5 and 5/5, as they require further refactoring and
>>    discussion. I will send them separately as a follow-up.
>> 
>> Changes in v3:
>>  - Fixed an import
>>  - better readability in patch 3/5
>> 
>> Changes in v2:
>>  - Made struct repository the first argument in function parameters.
>
> This version looks good to me. We bail on some of the more intricate
> pieces, but that's totally fine as we can still fix these in a
> subsequent patch series.
>
> Thanks!
>
> Patrick

Thanks for this ack---all of these iterations somehow escaped from
my radar.  Will apply.


