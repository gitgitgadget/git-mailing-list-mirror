Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142D63B9
	for <git@vger.kernel.org>; Thu, 29 May 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560524; cv=none; b=h3JNn9yGmPG38E1bV+Byp/HqcXQMTlmLw+jjd51QCfY6ThxtRxzjxDAl1S+TWwmfvrh8UpweSjtGfyq6SlqgpNoft29he4+qwZ6xed/q5LYJiOQXiryLFoBN2ZKB0WSUoNj0kvhgEJ1Y6ISIXs8QsphkTzxahFVRfjozxhz9zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560524; c=relaxed/simple;
	bh=by3ym/uMhkbICLJXyBFPfBeRv2ktdD1ZvRxXKSuMZ0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOcL8prTiSFUoIV6+r/e0/Fvt9H9q4xK9p2+QSjlkyAl8iUHNWJJG/cCOtQldguFaPIiRRlxj/Khq3+xA5I8hUSw+DTGsa6NrwfmIYBbYVo+27u+pFk4nIA9/uYHQTEiWfUbbJ7peN/oTO58WV4WtYyxGvoq37eXYA5scC6AzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dqgbt12k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCr19U5M; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dqgbt12k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCr19U5M"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16E0411401EB;
	Thu, 29 May 2025 19:15:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 May 2025 19:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748560521; x=1748646921; bh=uZ2R4/ehrB
	jdgXrde53xO8K2tdmfvxK2YPVUS8IKnT8=; b=Dqgbt12kj7BGerUvMmPRe7RuAu
	qzsuEpIXPTobpTPeYm/ezy5t4ZPbSLUAkkaBK1DIwGe/pl5TL6SZVNgdBN5hDljR
	+TE7RYaBymttT/lJ7E3CSKIEyXrI60+AUi+EshmxyIPfs4IPISR9D6GqEG4Rj6t7
	/d5UeIKMDGZDCvDYjOgmccgeaVkbj2M0f7u7ULB6qZHNuKemncjhGBvQb0mnf0FY
	ihdO7lk2ddB2RKDMtc9DPU3t4tmclUDVcQEw0yCp9gCH+NlwLcNcRiO0/XGdngbq
	qoCf7f6/dKu17gPCXVgC1wDgxn36HFnxissmvq7nIbZ5gGSrF4iz85F80DyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748560521; x=1748646921; bh=uZ2R4/ehrBjdgXrde53xO8K2tdmfvxK2YPV
	US8IKnT8=; b=dCr19U5MEOCGLYdblypRNLkzUPU126q9IIi4LGUcH6shHfeAMoO
	IiXDeiVWfas6B/1J6+xJjuPxIn0wqYV2Vez5BJ3zuc9HHD4H31JFYdRBjAhx3aJx
	7Q6cegIZYbnmhboBzzlW0fxqGWe8YIeOUd7eMAxXA4h+6PATvasd3RACZUUbGf9/
	B1TbrsCoEOSne4BwjB52PUUt1LLiTsEl5i3NLrDXSHixa4IvJas46vnsngXiH28b
	EkZPgr0e+MmeADGuT+3vfzq17fN6iVi00CGwSXz5ZFu3Cc1OPYlIbx1G8iJMW1fW
	szHPn2/nlOEiJf42mflTqiqY/MoGjrVdN7A==
X-ME-Sender: <xms:iOo4aELy8J2bIHTwaelzhuerfZUpWuVWU5QglMZfy8rIIhT3TtSbUw>
    <xme:iOo4aEKODJK_GjwtTrubn_Xaj3zTSlmOlINu4NvHl8wvY-tQBuV01qpKjQSBJxgUb
    KFsSLQ1kgStSX8Uyg>
X-ME-Received: <xmr:iOo4aEs2YM8722KfM99IKHEtKJalrsKywpR4gyC71E8NXOCOdW8a4TGurFZifHXkcqFz0C45NJT-RwpIcCKlYjlyK8_k1HQwZnrmTLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjeegvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehprghtrhhikhesphhsphgufhhkihhtrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphgvnhifrghrrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iOo4aBbsxRg6MOnBq-e6Je2mNQZFsS3bZKEhViDW4UarO0nMb4UlQw>
    <xmx:iOo4aLYN7VKtWfT4ZS-CoTQnfQV8L2ZCdARzFYbGWIJIcmnd77jrOA>
    <xmx:iOo4aND27kHwgNkgQUKjJqCtYF0fxmPnHyH-wgA28lCkYNWSxMuBQA>
    <xmx:iOo4aBaI2x6NqHe9Dj0lMZnbI9oVAU5kkFAJ0h825On634l3T4Jzbw>
    <xmx:ieo4aLrSGpAyZTdVmTwvwp68nOh5gH8sUrJfKHilrthfV09Ln7ITAjM5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 19:15:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrik Weiskircher <patrik@pspdfkit.com>
Cc: git@vger.kernel.org,  apenwarr@gmail.com
Subject: Re: [PATCH 0/2] contrib/subtree: Add -S/--gpg-sign option
In-Reply-To: <20250528130116.21534-1-patrik@pspdfkit.com> (Patrik
	Weiskircher's message of "Wed, 28 May 2025 09:01:14 -0400")
References: <20250528130116.21534-1-patrik@pspdfkit.com>
Date: Thu, 29 May 2025 16:15:19 -0700
Message-ID: <xmqqfrgnhuuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrik Weiskircher <patrik@pspdfkit.com> writes:

> Hi!
>
> We use git subtree a lot to manage our dependencies, but recently started
> requiring signed commits. This patch adds support for signing commits to
> git subtree.
>
> This is my first submission to the Git project - you don't have to be gentle,
> but please let me know if I can improve anything.

A few things ;-) starting from the log message where you didn't
quite add why we would want to do these changes.

Also, I think these two should be combined into a single patch.  We
add a feature and make sure the feature works correctly and we also
make sure that the feature does not misfire when the user does not
ask it to trigger, all in the same commit.
