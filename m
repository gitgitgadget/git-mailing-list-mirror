Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4026E710
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753056; cv=none; b=JDv5Ye4FzJyGpGda8HkkYypL9IpgQgAEfCEZ1BXX9S6j5L6W0bT6XtiGgoO62yN7FpOBDr+klLasQM4uK59OFhEVGZ72WkxuSVbOLpVFn5PurmkzqJ8FE3Kv5KhqaJZra0XaCP1rGKiHgT/ztBLoLw9GMZ9v5u3RGbVFpjC1BNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753056; c=relaxed/simple;
	bh=ngaS8GXcsz1r+hy/UfdeLB6aIjnSfeOikgpMVnSmi1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TONWKkVtIn5WNzn4nVbPQoCXPMHlYoPisGE+P7HBrN2k+ecnHrkwVbNVVFnoOdz6DggSCd1txB9bbi9aA/LrVAcY0FUQaDAO1TLOH3busIhY/CDkpeZXD7eyeBKR0jJXyVhYcAXJCWdYWDTtNzKQVj2Z5MC7q8fbcpcKS1xqXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uh3Qh2Ck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w+0g7XPG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uh3Qh2Ck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w+0g7XPG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E08B1D00135;
	Tue, 10 Feb 2026 14:50:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 14:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770753054; x=1770839454; bh=7U34+9N0gt
	jDr3KCun1Tj4rhXNsi7avQnoFBKceuNQI=; b=uh3Qh2CkBowHoBo0TVGCKDZuq0
	50vnG5CQ3QF6PUc6VEEU1Xjgjqo7pDa79nHRPuFB15GCihpQ5KuaBxiWrvO5ltmV
	anysN8WW9gHR5J6oWoL4i+zgiIo+UlE/YpB+H78uKhBshzqgsjboXOhvXUHgws3l
	mPuX1I5xFFa/p74GwuNqpNtW8+D2/5mTv402xU2XLWN5J/45C2tfiSza6OcGxQeF
	J6dKkpieayngC9XipoRXXCM9beavEW3XsipDU9AJQ9Eh16ioeiJ7ij7DO063bxLN
	DY5+m7MjsxhBQC/WRMN99dhIJix4090cwtLiVIboUr18AIiE5flPotL9uJuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770753054; x=1770839454; bh=7U34+9N0gtjDr3KCun1Tj4rhXNsi7avQnoF
	BKceuNQI=; b=w+0g7XPGmgaWSeOnT5pn2mUS8PKeCDhtQze2sjqRJnG5oLDrgIc
	/Uz26bBJNVbBjfPDgU/pMqI2E1DvVd0VXJ5lvym2dBqSl0qqIF/uE2I633wJqlVi
	L31axhKIOC5O9oQwJFYfe7ljSbe06ezbXatjO0kjDgLtgXS6gQDJVyxuBM3b2ril
	AmjYBftuWWC9YWlU0E/RMyVb4y5guPzU0d1d4yXMN/cIWcw+uj3AaZHHD5c9ypXV
	UFOP3ojyq0cpRSVdDmo3VUDt2yWt/x/kqTXhEQheglNsKgFxvKh2wYJ9Z6vcsfd9
	7fQBLW2K5qhMq2aF+AuKRQ3TkXJV8V39zZA==
X-ME-Sender: <xms:HoyLae8KTkZ-bbnSl32pA-_e9QvHfrTuw5dB8433TUc6GJe6KlsKtA>
    <xme:HoyLaVsikMb2mOBnZR8tMKI_Csqm5GIb-Qt3lyBCLZWGyKd2wnwnQD9WtwfduMAhQ
    EExvmSsPdvqHyQwdK9cjscRiL7DMpyMejPAzpkugL1oxP6AYIZEFw>
X-ME-Received: <xmr:HoyLaZBwCg4ir_lcTlBY_2N9ZtoEvpb-zbuwyCLhNiQaBL73AjgHQLHjluq3Uj79qRBe4ZsDbODeJjZqXvAJ2SaDL1o0_Ke5_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HoyLaVVbc9l3iHY8TamiLN0oGOJJCt_hi-GqQKBFy81a1_Xxi4_x5g>
    <xmx:HoyLafB2yc_tV-hYdC8fE0AUsIktGM0L-rR78YXTXlHRNdIQe1sVgQ>
    <xmx:HoyLaQ-SeY0ssm0JG2Mbhmh9rjKFs8K4J3iMldayu1MlWGY0zP4FIQ>
    <xmx:HoyLaeG9u6UxL6nFtyAqTDnlD0rhZLSTYABY1g8w0fDkuMqJ-emZuQ>
    <xmx:HoyLaQaKwNhCqLhFhOBHBVXl8OSQxrSmsF20gzMVQvUtVPZK-aFzBnln>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 14:50:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] osxkeychain: define build targets in the top-level
 Makefile.
In-Reply-To: <pull.2046.git.1770746461307.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Tue, 10 Feb 2026 18:01:01
	+0000")
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 11:50:52 -0800
Message-ID: <xmqqpl6cxtr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Makefile                                | 17 +++++++
>  contrib/credential/osxkeychain/Makefile | 65 +++----------------------
>  2 files changed, 23 insertions(+), 59 deletions(-)

Nice simplification overall.

> diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
> index c68445b82d..ddb29f0563 100644
> --- a/contrib/credential/osxkeychain/Makefile
> +++ b/contrib/credential/osxkeychain/Makefile
> @@ -1,66 +1,13 @@
>  # The default target of this Makefile is...
>  all:: git-credential-osxkeychain
>  
> -include ../../../config.mak.uname
> --include ../../../config.mak.autogen
> --include ../../../config.mak
> +git-credential-osxkeychain:
> +	cd ../../..; make contrib/credential/osxkeychain/git-credential-osxkeychain

Let's not write "make", but stick to $(MAKE), perhaps like

	$(MAKE) -C ../../.. contrib/credential/osxkeychain/$@

> +install:
> +	cd ../../..; make install-git-credential-osxkeychain
>  
>  clean:
> -	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
> +	cd ../../..; make clean-git-credential-osxkeychain

Likewise.
