Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926D2F5A
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460035; cv=none; b=FdQirPngx9XzYIDvVCNqTVID4xjnUfpQBFYQbXj/r7B6XU+f4apNwHmWvnaZH6f4CdWRmoZm2O47ZTKR1+qbRJud1/7PFqRNzXgemyhoOsX/jrH0Wr/cjWq4ANcEAMPrKAqrSxDvzccKnqSnSjVUx0w3UBwu07hDc00nAQNTdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460035; c=relaxed/simple;
	bh=6W6vuMRnPx8I1SrWRSJxWKtK+lkYmulFgyT4QLlW7f8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErN9XH7snmuiES7HjGAUsFCxVX7RPmPzEqqOxwWcv9WdJRgrWB331qfzBmjTvCtpF4smk7wq3HEHwdjOkEXIBjGSx5loAjuq+WQYUkcYdghSk+76mhGrrEyQZqggFoj+zBRrFS2cmJHVzpmQDiBKzWiDva89hfE8xeNEwN0G6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlcL2Kwq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlcL2Kwq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 508C025401AF;
	Tue, 12 Nov 2024 20:07:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 20:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731460032; x=1731546432; bh=Vs1g5W8pW4HeHVS9ftTA9rZQQCOcIELE2eY
	X4ccOyl4=; b=ZlcL2KwqxF+CGf1r3ykQMfV15LQzQ2G1u+r92HF/Y5yLXLHtAG1
	oKUtBjBUIo4CF5GmiUQasioTwUq9Hk3JnemkMMUsG0XhakT7kVRmwPQum6md8k4d
	XUDrRsAdvdBjwL9z+9JUO4D36GyZLdm8ifEYCG3ob4Eno3sVuPRSODOGDFW17TXz
	+tusDMOyObGDD85Zn/bvkuU9jmUfnUK4Bwq50Q1pdwgcFLqx3ZpOv+xo1OY8NNTu
	LRQ//xfE3qrD/Qkg5giYB/9JAhDlP3vYkCFUkTXoI36AdAHYWs63jAZeVPkZa5gM
	E/f12Iog4b48SFFNIvR0u3Pd3/uSt8P/5IA==
X-ME-Sender: <xms:v_szZ-GjKWb5uyq5MZFa3blcWTD2u2Go1KpjXJ0yWI6nNSBWojTOxg>
    <xme:v_szZ_UIWWIB1EzRdVaZO6aoGNUn4hQiaLBg-wDoPkFOGGBatSzEoy7xGsONhj5_O
    S4poTgjWe8hPjKdFw>
X-ME-Received: <xmr:v_szZ4JGMY2iKUE-g9mmFvxVwpgjRShEY--O9JRZcjncE38sqVqNHe9tkF5_eArdIk9V48bA2PdlFWykKEyl8fu-gMIu7cFbhkA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejhe
    eugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v_szZ4E9D2Tz34QYtG-X9V3MrXB3sJR4ATw7teVifu9l8M2UNzDLvQ>
    <xmx:wPszZ0Xa7hjrsZXSGuQOAIrXKbaV8IZw12zDSbg3hUZ0kZH4Oh5t4g>
    <xmx:wPszZ7OJT8QY-Rii9Pgj6VMGhq8CtHSiaphPc1m3FVk1N4wIoawCZw>
    <xmx:wPszZ70ENqkoKC7X32i2wX0ZJkA_9H0Y-Hm6Xd7EcPwqtA_app7sfg>
    <xmx:wPszZ3G6GozKrUq2g0sehBjKYAjhuPFCT52XM4RZPCBvdHr42PFPbJJf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:07:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/3] sequencer: comment checked-out branch properly
In-Reply-To: <fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 12 Nov 2024
	11:20:11 +0100")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
Date: Wed, 13 Nov 2024 10:07:10 +0900
Message-ID: <xmqqikss2b7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 09f230eefb2..f61a717b190 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -456,4 +456,20 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>  	)
>  '
>  
> +test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
> +	test_when_finished git branch -D base topic2 &&
> +	test_when_finished git checkout main &&
> +	test_when_finished git branch -D wt-topic &&
> +	test_when_finished git worktree remove wt-topic &&
> +	git checkout main &&
> +	git checkout -b base &&
> +	git checkout -b topic2 &&
> +	test_commit msg2 &&
> +	git worktree add wt-topic &&
> +	git checkout base &&
> +	test_commit msg3 &&
> +	git checkout topic2 &&
> +	git -c core.commentChar=% rebase --update-refs base
> +'

Can we improve this test a bit to give it more visibility into the
breakage?

I am sure that the internal machinery gets confused because it wants
to skip commented out lines assuming '%' is used for comments, and
fails to skip lines that are commented with '#', but it is a bit too
opaque how this would break without the fix.  Perhaps add a line or
two of a comment to the test to describe what the expected mode of
failure is?


