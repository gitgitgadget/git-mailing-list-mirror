Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EFAD23
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731285476; cv=none; b=QR4QYwAtbWsvIFGH+WN9R1rUUrzCOFbIYJsG8tGnkzitbZYUpYVb2b77+PeFSAUHF0OTrXnbg/aj8+hixk+DIjgJgFsTu0wqjGzHX367qPjdbYKHdxd5BLj7NhVzjSGoVc8aBjYlgNznWdJidonNcMSaFCB8TUjt7dfPsOZHcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731285476; c=relaxed/simple;
	bh=1tm5W9tHbM3CZOI05/4JCAACA4zcE1Y0eMGiVigd3oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M55Eug3b4zl9GAOBaGKxHyS/2yMvvvtDcQCOKMVnk4OUbqQZISLq82GJasfD71L4VIUlrrYN5y+F81P/JQhe9Li4fytclduQCGNkmpO3D4iSaWauFoFz5fAHzlrcA8zVgjaAGNF2K/OH1U3quOAXAzKloJ6ckdcetmtu6pHMCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RBi+9rRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UI9aBnhC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBi+9rRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UI9aBnhC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4656011400B1;
	Sun, 10 Nov 2024 19:37:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 10 Nov 2024 19:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731285473; x=1731371873; bh=n7nf51uzT0
	hgliMbTy+jfuOvVf/ZPD5xwxmly5dQSdM=; b=RBi+9rROZLKpzeZt5inYO0hJER
	4e5Md/W+0lFLpHtLBoF4mJY0eUOwmBsuYZR6ZnbrNXs2VPCChL+UBjuLO0CKsm4W
	Gk01wDQH5AKxEFhWs4wdJsDsdG7LVlIOma7uO1xxAmQR6Ct+peAw+92wmQ1rtlTw
	e8rS2PVxgqrThhrk68SmyoPJAoZ1uVphd2r6LFJjXsMTUuwG/tocjZgDrmZdt2WJ
	fPIGC2NFleuJdQzKg1bn517A/UkRrGr5upVvc4TZ80lbfas9AUCmqHEnHuWSOVZ/
	eA+rw6B474GJQsm/AvMu7AVumg5yo8TUy3JyV854jLfO0Drf8FtQBS34xH2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731285473; x=1731371873; bh=n7nf51uzT0hgliMbTy+jfuOvVf/ZPD5xwxm
	ly5dQSdM=; b=UI9aBnhCiRvZ70RDpKDNnS6tf2l5Hvv/1ATkU6xgeZz9MNgdbZ7
	JRbBeYI9M1v/Eh26XvVL6w/7K+T3RQsjBlZ73WxoI9NW9RD7wi69as8lVX9R5oT1
	1k7i9Oy5hUN9EaIJvKLIuOe1S8Jf3p4zPmXDwjsnNjUKANxKrE4HxAa5IQbi9NvQ
	ux8aHIdlTp4gzovrdn/rsim7sKZO3J/yBluABU/f54HDCXnLDv5ofR7FDM0Tq5qd
	tRTOvI6dAxm1zPRaHCcPzUi4en7tNTvmsnzJXANVHbso1Yzk4UNFDwFhaEBwIIQJ
	pOExFM3bhRKni6YBWhCtdsJPKb/V/oxgZEA==
X-ME-Sender: <xms:4FExZ546zvv2Os12JOOoYyTeMOKuwJhImOCF6QsER9B-UYawHR89fw>
    <xme:4FExZ24FF9V-sP_8OqXd8aBuYLupVLVxiLo-0KTLc23fV6LOD5ZNv98OJoeqb2q7b
    veXSDnY0IAIgjMBJw>
X-ME-Received: <xmr:4FExZwd8dsYd6E9Qg0x9GI2uaS4HZ9vKsIUuz6qa3YWBB8Y-xKU6Oh66GieY3jhFlcknu9ZMC31bglZfh9YV4Y8R-AFbtpL9q4SS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:4FExZyKFOKGmab9EPy7eLnLqJMb1oc0RUg4QKYCa1z7NYqPAgNUFfQ>
    <xmx:4FExZ9L_SOC03bdz-UpJscOps2vwlDC3P4l6ZeVkMWcav39cc8Rrfg>
    <xmx:4FExZ7w0aoe2nHyJaK2zD7Bq9gBPKGAPkRZtWt0FkQ2RCfxRGke78Q>
    <xmx:4FExZ5Lthitom3Iur203pI7P4y04Ag6Hmes1Uyj-k8UVyaxhbg2iLg>
    <xmx:4VExZ1-D1wZ1USzRu4WAleiyse9cvkB2OTkj0ld0ZB-OAr7WPIIDzBOV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 19:37:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Edward Thomson
 <ethomson@edwardthomson.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] reftable: stop using Git subsystems
In-Reply-To: <23i62zyglnqknm4qf2lxmdcthrhhg5vsptfqohtmp327mrwsji@h2tutjzrl6jh>
	(Justin Tobler's message of "Fri, 8 Nov 2024 11:39:50 -0600")
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im>
	<23i62zyglnqknm4qf2lxmdcthrhhg5vsptfqohtmp327mrwsji@h2tutjzrl6jh>
Date: Mon, 11 Nov 2024 09:37:51 +0900
Message-ID: <xmqqr07ik3kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 24/11/08 09:17AM, Patrick Steinhardt wrote:
>> Hi,
>> 
>> this is the second version of my patch series that continues to detangle
>> the reftable library from the Git codebase.
>> 
>> Changes compared to v1:
>> 
>>   - Fix a commit message typo.
>> 
>>   - Document the values of the newly introduced reftable format IDs.
>> 
>>   - Include "reftable-basics.h" instead of "basics.h".
>> 
>>   - Adapt `stack_fsync()` to take write options as input instead of the
>>     whole stack.
>> 
>> Thanks!
>> 
>> Patrick
>
> I've reviewed the range-diff and this version looks good to me. :)

Thanks, both of you.
