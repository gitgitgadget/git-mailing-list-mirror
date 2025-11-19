Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723B24A051
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525703; cv=none; b=o++igmU/n7g3m/QkQvar6Brg12eYXghBeWTy+WnkibmHzmDOGxgzHZwXL2BWR45I/e5zYVzgHsQUkGmph45LsZs6nddn9t4UbCYIvrDTkKVPopV+e2/5LRimHNGeT1GOTF+KWgEMtbc1LgPtUeuQJwHA2JrMSLNvxpEzaGVoBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525703; c=relaxed/simple;
	bh=qQB72Ze0vK+W85w/x7adrV+Epgo4MBJ3c1MJI6pmXIg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UN3llJzUnQAESLdL7MH+IUzd+bpKg/1uj0+j9XGeTSZIh2z1jmfT2J9yfcwfKM4THLT46Fs5uZaCSRE7XJhRjrA0zRp3JnItwUFj5SR0t+ydXjnNSnWBPk++svMEK+lCHmGbePVVEhK/2o6jWyJLeNB/gQEhvPZx3hCg3bQNnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DcI/8eKq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvKmK6P2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DcI/8eKq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvKmK6P2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C2B214001DE;
	Tue, 18 Nov 2025 23:14:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 23:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763525699; x=1763612099; bh=qQB72Ze0vK
	+W85w/x7adrV+Epgo4MBJ3c1MJI6pmXIg=; b=DcI/8eKq42+WqtBAgi0a6IH7OQ
	+TUBTEbeeO10ecgBpn+Z9P5luUI1MlfeY5ZkdHZCq8FJno/Q8pI9EmY0G5/lDJ4U
	7mifMCrRW2lfDh/wzVntb9LKl2CAPXNdO2DdHtQfXlU0FqQ1YjauewudQ6gM/zgv
	FCZaseFULJjw3iV6ym3pY28DeTb5rGazbp7jIm0DIluiDAd+h15T1IrbegtevcPM
	o3a+yckn8tQofH3zcDpY35hnQYxlr/BzTtiFoxlTxeh62H07uE7/y8VA2yNfDxER
	C8lDxjedSbLq7OcHGWZKZucW4avNbCIZ7zhdvfH+Nfhji+QanUN+SqxhNXiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763525699; x=1763612099; bh=qQB72Ze0vK+W85w/x7adrV+Epgo4MBJ3c1M
	JI6pmXIg=; b=XvKmK6P25OgybzG1f+UeesxEpk09vFRJYutjKvC7FJhb2M6Zedg
	vvIR3nLXKlw57Kxw2eTFCo3+UFi4vZY3qsXkwsmqG2p3qz6Nko4sNUmd+uQ35c96
	0R+q1KVIhRpPMsC2qPy51UXUOSpnEU99Aid13ws0o1EkTPkByaxl2wPT0gC7iG6h
	0wNqUPUbqtI8yq86pu8BZuXy2BK4h0NuAREaRkwkAd0jg42NXWTmPUPSDI3g1HES
	hHf1KCey+B2wI45Rryo6xYWVUgB52MWhKnRDQl8bJPXfsr7XU5VvFUPnGjRQ4PvU
	OAQe4iEFnalgYN2E9/Pcb8HMoraU0A6dWxA==
X-ME-Sender: <xms:Q0QdaVXKzjBgoEJHuPjDXZ0DQQFB9GdpaX4Ah8eA7K3q3TKCOzgeVg>
    <xme:Q0QdaYqFpf5uAJoxvmbDlFPfmYT4oD04T0n4SOl0SrLQBRRnYY5aWKS9dO04hzD7U
    AvAZBMJjYBxF88Ap5QRImDno1hXPF4wMDE-KSFydPHOQkVDjOkHdg>
X-ME-Received: <xmr:Q0QdacCvyUXQIkowN8qNbXVtOIyw3mJcjx369aKVmQZDJ1_TAjSzFP2pc90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Q0QdaUjMyEgxjQJrsVFbT3288vqLzOWVGhAHSybVoowqmbOJltkaIg>
    <xmx:Q0QdaaYTKLs4sHmS-nmgjH8Y2LDq7K7NFFV_pHT5snNzCLAoUYY-3Q>
    <xmx:Q0QdaVmSMYX1h7b8X3xvGMkh9cUt_CXobQ819mOx6EKiMK6Yt7vVJg>
    <xmx:Q0QdaQgIHuG7g6HXJecF4ji-gENpPDX2_rfbHEDUsQsxXuET1ffjOQ>
    <xmx:Q0QdaVtVxcQRLBHZUnp4tK9rLU9BslMJ0uUTzkZ0OJEOvsRzaHkWYk4v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 23:14:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v5 01/10] doc: define unambiguous type mappings across C
 and Rust
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
	<8b56bf117289ca3be25533a36da1ea0c178ccfca.1763505262.git.gitgitgadget@gmail.com>
	<9c7a7d09-2cc0-40f7-b37a-befef5339d76@ramsayjones.plus.com>
Date: Tue, 18 Nov 2025 20:14:51 -0800
In-Reply-To: <9c7a7d09-2cc0-40f7-b37a-befef5339d76@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 18 Nov 2025 23:46:47 +0000")
Message-ID: <87h5uqk69w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +== Character types
>> +
>> +This is where C and Rust don't have a clean one-to-one mapping.
>> +
>> +A C `char` and a Rust `u8` share the same bit width, so any C struct containing
>> +a `char` will have the same size as the corresponding Rust struct using `u8`.
>> +In that sense, such structs are safe to pass over the FFI boundary, because
>> +their fields will be laid out identically. However, beyond bit width, C `char`
>> +has additional semantics and platform-dependent behavior that can cause
>> +problems, as discussed below.
>> +
>> +The C language leaves the signedness of `char` implementation defined. Because
>> +our developer build enables -Wsign-compare, comparison of a value of `char`
>> +type with either signed or unsigned integers may trigger warnings from the
>> +compiler.
>
> Yep, much better. Thanks!
>
> ATB,
> Ramsay Jones

Indeed.
Thanks, both.
