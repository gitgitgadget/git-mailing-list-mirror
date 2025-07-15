Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817126FA62
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614873; cv=none; b=fakfcAlJLzn7IsBOBwBBCt/AAAsm0dAyRbGLZXim/QCgFoeaS4f88SLoNlRhch3ROiAtv0JvJ+DCpEaz1dZciV9c67XHjPdi3a8M/H4ezcdD6KSNuEnEB2I3ZoLcvGDzCoYlQu8pdJuiWb+8Zp242Kar9EzU9r4W+ZRTb1TctEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614873; c=relaxed/simple;
	bh=r5Mg85Rf0pqjzraKn4hCO5D65k4fmo1t9+N42ZsyOuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBBADrlkdCG2TjOQv1r4QlQ0ztzgj+kBncnMZ1fE1cWXm6d92qyUpRyUU21o/e/QA6PaZiuINIYv6JVc4waEJE5tl2wI5aPENG1RchyJik9XvdWtZe755PZagfF5z4LQ3C6tYZPRcPrAF67LucMC4kyvI+i8qXBYKuq/HhDxpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EqHv7/ZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPCyORdq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EqHv7/ZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPCyORdq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A5037A00AC;
	Tue, 15 Jul 2025 17:27:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 15 Jul 2025 17:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752614870; x=1752701270; bh=Ymg/0blwiF
	oBUWdGeXWFkrAw4hcs/u2PzzQnuwMK+cU=; b=EqHv7/ZFEi9zfYohHkyxtxC7+m
	0TMhiMEVC7/lvAiGQmn0cLVK9dKeUcLjnrvpwO0RgOOUrzXctjfNp2aWr3QvlouT
	R4odM5PnOrgoMjfCeAORk+vJROV+e2D1M8Ov3inoOOxZR0YXuCgV+hNl0Or5AYqM
	lVni5ghy78WSLbMk3favQBX/lt1C6c8421HGWPNiYh/lnSxRDEKdD5I86kzSR0jQ
	4plUXyHQCiDlIpvM4MQRhPVj/81teQLpBqEZdQKRmrbawPecypGaEZMzvd3S8ZUw
	Jboclgm2qucKDxTmxGHgGjBy3JYRdptRZkQJgukdQO+uxNme14aY84/FnDuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752614870; x=1752701270; bh=Ymg/0blwiFoBUWdGeXWFkrAw4hcs/u2PzzQ
	nuwMK+cU=; b=UPCyORdqXuNdIfo75M2k3nxdoJsyXbDtwhwUz9dejctPvrwoQ21
	H7XRPSdVkjFslBzZuTwSCdgCsO0vzycpqd1NV1zsp9PvU6cBhXsim7JKq8HXR6bv
	tP4/BdCEIUGond6P9qVPWvqMchwirSNAJXJC+OG8yDbR/Z0yhCXaiiDqNT4QjO8g
	4BDaF/dMluFi0b9Vc9sVJ5uc0sbQbIeEl/KS6nMeAztUO3xNpg+xT7R5bCw4Sjy7
	smJeZzCfgeob9g48WzxhJTVOwEgzJiQRLYEdAosCsJ4ObQqQLOyuVaB3ZIH7rx9c
	dJKzfSf+IXOIKRL2T/qo5N35zDtbp+lYFAA==
X-ME-Sender: <xms:1sd2aO0-6EUc3QLK0kZWpd-qL4P4TKzRvlClVimj7l8sChTXaAwAcw>
    <xme:1sd2aLrG0WJm6K0EsS8br1F0jWH7x_-DC1zVIoVLdasNPSyYIRYNZ_H9zOD8duSop
    F0t_tIYtTtJXNsxOw>
X-ME-Received: <xmr:1sd2aDfHdOSiifjP0gTVMLW_gww7TqhxiSierg4oWkLd6y8DsxXnof1tf6HuOd1p9Oo_6o_4iV7csqt6wFm3aZyhEjNLzH1hVEBWu0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1sd2aCpyqTYiyHuCNjlj54MDmN5JNIns1sn1lKHoGuKj0XZ9mHRQ0Q>
    <xmx:1sd2aMGlBXykxN1DFFsqoXQ8GYhZ8hpXxJphhcdHlGOkAYJwT5Gkaw>
    <xmx:1sd2aKsMKpVUysJUBlGbJ8MUIYrDweyjkNOktuwMnmPx9qE9rpXlsA>
    <xmx:1sd2aGXtGV08dcqk1b2bBEQF37dThNPCfoMWS0weKEXsGMvZwFgZqg>
    <xmx:1sd2aIFY8USxDTg-4q3rLMfX_6szaapGcbcdWUTz_JfXdpmEtJSsGxDg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:27:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] test-lib: respect GIT_TEST_INSTALLED when querying
 default hash
In-Reply-To: <pull.2011.git.git.1752605874596.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Tue, 15 Jul 2025 18:57:54
	+0000")
References: <pull.2011.git.git.1752605874596.gitgitgadget@gmail.com>
Date: Tue, 15 Jul 2025 14:27:47 -0700
Message-ID: <xmqqv7ntf8ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  ################################################################
>  # It appears that people try to run tests without building...
> -"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
> +GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
> +"$GIT_BINARY" >/dev/null
>  if test $? != 1
>  then
>  	if test -n "$GIT_TEST_INSTALLED"
> @@ -536,7 +537,7 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>  export EDITOR
>  
> -GIT_TEST_BUILTIN_HASH=$("$GIT_BUILD_DIR/git" version --build-options | sed -ne 's/^default-hash: //p')
> +GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')

Very nice.  I very much like the way this reuses what we detected earlier.

Thanks, will queue.

>  GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
>  export GIT_DEFAULT_HASH
>  GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
>
> base-commit: e9779f64349fbcc8d177d055208039877316e652
