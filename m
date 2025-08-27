Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895452773C1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313288; cv=none; b=pZ/hhMt7vx+Cgk9R3Y99MK8E6XPz4lSJC10t5Tg5P076azaamB3fUDUxFSvJn8beYAsRREaywDzI0C8ecNePjmM7YS4UC/iDwyq+IFs5LKjQxCYSmUFZrqF4vzsF3u2tfEV/w+XRg1a2Nt4or6MPgqa6+3vN+6hHaMyY2NFJg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313288; c=relaxed/simple;
	bh=Mg9YKfhOTcYZeAFPxQtFgctErtNEXYEaQ4lXiRpXMl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CC0FkW/zmZkgpVjwiYMf3A9a4xUlSuH5m6+QcyeYFJxmD21QmwkjOssof0Jv78V9cjLkpU2Mmp0QFfCmwqtKbgZLMvvFzR5TGGpkA9O476G3rEqwXqwjGxl0ulR1zohzWeHnfk6ZKMrC7SJIUxAVyAySrnabEJZ9gQnSt/g6AKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XxpZKUmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGzd5ujJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XxpZKUmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGzd5ujJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC7171400167;
	Wed, 27 Aug 2025 12:48:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756313285; x=1756399685; bh=3B31dQEJpS
	SPbZk1W67fy+sOjgz9FXmUII9qR+YCfNI=; b=XxpZKUmVVc7OYT7c3pKy61uv+/
	XqdP1RVr/bYQGVzaNB+AcznTEXaaW7Zwt8YCWPLqTjAKjbV7V+CajuDPeR430awG
	St6+x3Cq2jlXOmlfpTC2XzwZHs1+BNwgBMMWDhHmiY/3zPFlc2KTuE8g7bBFYSug
	Neb3p0q284T94H2dJm6xdVts8FF5vuTcyl0MmTAhC0+nmeYW0bfsg73W2+foYq8U
	8A2EplCLyFPA/ZbLOcsiSt6w5/jGuxeH08Om/CnW5Uy8LNASdsF3z9GnB8I4Swmc
	/rebJC7nhS8yDG2+NTydnGcrqbwTIzeF1c122EccdP/NW0q1Ktim+kr6M1HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756313285; x=1756399685; bh=3B31dQEJpSSPbZk1W67fy+sOjgz9FXmUII9
	qR+YCfNI=; b=GGzd5ujJFA/lyGwU9dpNbKWrtQAL1JIpEwaCxjO4jIK8IpiTyOw
	ytDhJSClYy96bkwGxMU8u9u7V00pIeJVKJFhePpmFVczEbQ8MKFnE8cJuEdrDQWv
	h9cfE/OY9Gm3cbMjKIQTPEV9D6cOHbTSlDc+NipowfuvkAVRI7KlddDpfX5I8lVk
	YflB/H1jlRdZL2WM/FgTeCSRx2go8ymJ3rx6vBgriGjkApo50il0BZdX0EdeJZsj
	Ou8M9FrOtuV3+TwxIzoiy7Kkxajd6o35XDdyn4So7EXcu3mzawOO00NlISgK0alv
	BnAmpf6ogrWAUL1Hsv3463I/lRR6TOgcXoQ==
X-ME-Sender: <xms:xTavaKl9WzpTIw6wYxMXp-JaPl6untOjt1xrT_JzP60Ux6yDYvCAGg>
    <xme:xTavaMZkkN92CniGbisCnWVHOuIPOG7-1mcZ1EJXpgr9DCbJnKPQqmv98Hv_RXpi8
    QCp85EbePG9TdANng>
X-ME-Received: <xmr:xTavaFParF7rjne1yg6ud5lNQes7OPgzMzi_yIb7nGd55B5vlRk3oltSIvPLMXTovfn_lbpj52lPjYUWu29d-yiPHjDX_yAB7EexO4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:xTavaBa9hIevk0UXp75ux7m57k_ardzAPgtJMDd3qd4zJYcSiiqdNw>
    <xmx:xTavaD2URKi-RvnfK5Ix9Zmn0rd_G4kYtRT-D5QUWt7Ll96Wk1l0wQ>
    <xmx:xTavaHf_iFil5fvX_luNDrkmY-044sL7Y4MCdZEuFWrHrFUJAfXRYg>
    <xmx:xTavaEGWupYsRt-GIt2gj3vJe3ZO57tNzheLxBLiuxOpyLGwNH_m0A>
    <xmx:xTavaJ-OWnmBLUs-4E0K0rW0N-rMfb-dQ4-zUEaifulPrtSM3t2QMdwA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:48:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/4] whatchanged: tell users the git-log(1) equivalent
In-Reply-To: <xmqq5xe83e8q.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	27 Aug 2025 09:45:25 -0700")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
	<xmqq5xe83e8q.fsf@gitster.g>
Date: Wed, 27 Aug 2025 09:48:04 -0700
Message-ID: <xmqq1pow3e4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> -	if (!cfg.i_still_use_this)
>> -		you_still_use_that("git whatchanged");
>> +        if (!cfg.i_still_use_this)
>> +		you_still_use_that("git whatchanged",
>
> I spot a whitespace breakage here.  I didn't check if there are

Sorry, I read the patch backwards.  You are fixing an existing
whitespace breakage, which is very much appreciated, as this is
immediate vicinity of the real change of this topic.

Thanks.

