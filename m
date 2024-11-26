Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F72260C
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595633; cv=none; b=a/Mo832eUmWTbQfu1kiMf3oJSSzTPHK6Y63g6pAJ2j70hzKDC5sjpyoBjP3x6p1yqwjRswrIAx4X6OJrbQKNceVi0DeCrrlXazV+kgwUM6fYnvvYLwl4MbVpkDcoV/tLoCbgRElNx/zqhZlw7LiRUE4OoXjg8rmqWLBBy2PiiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595633; c=relaxed/simple;
	bh=lv25iVABS7kgiBJoMRiHxfIpemCOKG6uIS0kQdgfwLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJyIh1P8nKSACSXW+kM3MScJo6duARNLp3OgSlIGEFFuAwWMrJKfpTI3GxBOdW+OMtdaUUr1iiaemuNUnjaPz7IWuGS3c4fKxRcyyWLoJnx+O2pjpkomsfhFy0Ggf98NNYhHTB3goaykC3BlEhozo0+6AApAAVjnXUlB8kGURZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFbJcfgQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFbJcfgQ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 211AB11401B8;
	Mon, 25 Nov 2024 23:33:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 25 Nov 2024 23:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732595630; x=1732682030; bh=ygtCYGndNAQwFQGXNftUIEWGbxnMDbKKjHH
	J9RwaHtE=; b=lFbJcfgQH0z4PFn/2PgJH/CB6/Md0vtRJp4fEo/WhG0hKgRRHiV
	EHuwFHBTnV3qckBeYRxKVjkKEVq5QulisWda4iRYla9vREW6jhJhRGduWurkFNLz
	xDz9DcWQLfLjNpusHBsI0y3YLQ4+KRmEi5pWdWEIGSOUejca8RGeTDecgOXlEjBM
	Gui5monJvEGclIMwijZUHykJiLUwhnBia/Op+Na9KyZ8lunOuv6eyYXzboiXwE+q
	TcKk6zIiMuj93GUeclsYsQ5DqEl+oyGUsHhJ0ec52iSw7z8qTHJPf25/HIY/E9H8
	PPiINCzCFwCVtXybBxSfx0zxTR/nqg8dcow==
X-ME-Sender: <xms:rU9FZ_cUJtwgs3LQrceUQP3MzgYTJrZNF51NALvgJhUPIQ29rxLITQ>
    <xme:rU9FZ1PztsBKMNknLeq0Yy5HC8ePXwCBg_w759lSkyCjOhgCCI9sC8NNXvyYwbBAf
    q7qJPMVbA2vMC8ccQ>
X-ME-Received: <xmr:rU9FZ4iEZq5tYKWtFrWGVuMRKCzBLGxSZlRlsmYO4ASijuShzseE_bswTRS8rBexyAT59kWU-9Y8UXtk81WIPpIKTieTOXjo0_xVHeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgvthhhsegvshgvthhhrdgtohhmpdhrtghpthhtohepug
    grvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rU9FZw8K_L6pmkoRRGr-Be8mLzbe5P6j1YC9wR0YK-1Ode-l_O45-Q>
    <xmx:rU9FZ7uGcUbHnnZQ9lhxBX5vbirbQidodfayibThyH-sxTQVyl07tw>
    <xmx:rU9FZ_H7rNwAkwE8wXHv4AB1ZEhFWkr1_hdSuNG2wGAmUyMUkG9IPw>
    <xmx:rU9FZyNdyxLNxwlMEY349LbuV7ERp_IFwtKte7Meem9TQ0hgdQVmlQ>
    <xmx:rk9FZ0_4X7BoWPegkvBadAw7IkGE62km7ya7iF93-bgUlwMyi_uyyinF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 23:33:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Seth House <seth@eseth.com>,  David Aguilar
 <davvid@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/5] git-mergetool: improve error code paths and
 messages
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com> (Philippe
	Blain via GitGitGadget's message of "Fri, 22 Nov 2024 19:50:17 +0000")
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
Date: Tue, 26 Nov 2024 13:33:48 +0900
Message-ID: <xmqqr06y1umr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v2: As suggested by Junio:
>
>  * 3/5: moved the error message to setup_tool itself, and adjusted the
>    commit message
>  * 3/5: made the test more robust
>  * 4/5: adjusted the error message

I think the above changes all looked good.

Let me mark the topic for 'next'.

Thanks.
