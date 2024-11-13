Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EA33F6
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463300; cv=none; b=sG4jfxni/c/8pR9JM+3WWiti5vsT6eLmvXBF5jW1FCmZIDV6FD7GwuDeBs9WGEppG/3sAMdrJwoYGd6EH0kZEFBBmvGByr6Xe8PwHIdgZkNV+GgS5mS41vR3jfWNx89CnXFnRSuBT3rNOW5JMexZbPBFBV4YqZ0hE3V0e/8LUV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463300; c=relaxed/simple;
	bh=zXHof88xDPid7Z0wtobeYhAnt8JkjCnn/I7S6ZNiMzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4aPEOOJXaYl1vlsjdfBCqecj+BcTU4HeFCyzuJ2BhRXX4EYKzMINQp8pY7Cr+V61wirEs9smRAB3heWoKp2/lT+Jg/oGEVXpXmWoYNcZ6FxC6COGH3cj+bNpmpGASwW+h8SLUg2H6lAT1PhMA/XfAK0SWi3ZtDV7SJmo5heOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNozgbqA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNozgbqA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39C6D254011D;
	Tue, 12 Nov 2024 21:01:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 12 Nov 2024 21:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731463297; x=1731549697; bh=Tg1e3YeRaqNOVbDxeSrH+RWCpfZSol9S8a6
	JaRFf2no=; b=cNozgbqANv3eXN9ONiVgWIAoHdByjlu58c+q7eTSN78SK9PUa35
	5GV/Ej5Y4K0/m9LZXM3Z0oFmNZDcWK8MbYnTA7EKL1zr9BZ3Ck23g9jd0OlWW8ub
	c4ko3JZqy5VaYmAJsJ+wg89DWRZ9adgTtoKF0Y5TMIIcgL4RT6y1Of9nDPfK1QzW
	sxJQJGo8Fl8dpdos+KqYiLyYLePXXIhwhEE5Xj6rhXc/tbkkOWJHfbrukhwSnU6d
	s6xTIIzE+rurUNm051Bifx9D8wyTHV1rITSghYRc8Rv55q1bC0/C9Toi5GLnEofJ
	sPHvW+Y0EwsUv3UxH3vqL4F3u3xZjin92lg==
X-ME-Sender: <xms:gAg0Z3uGe1ZAax8CH4vrKwqt9V5qb9FTmCHHWWSjQWr_k6Gp85ek9A>
    <xme:gAg0Z4fgxLgKf9oE1N0VFjbyCBPJjg09SKtXJ3WIox6Mv7ELVqt4zvNXoELyKFT6C
    IypP8p0BPXp1CndmA>
X-ME-Received: <xmr:gAg0Z6w7YZNu77_g2BEHpFf0vNOQknIAdVoRxiwFiXfndhFUVF1ErDUyipHed6zpx81LWZiiZJ79FWuziC6sloMqMEZJsBiySQzb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigdduudcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:gAg0Z2NcdouoK7iks4e_22qRH8FO1HJkVmOltyoqO0Mr0enaLWospg>
    <xmx:gAg0Z38M7vnvCvowz0Ndpi42LZ6MGvMorCW7HkbQxHxUgRAM_6-yPg>
    <xmx:gAg0Z2UIkHEpMx1hFzgGdMpk9owuJMq0-09VmXWLXYuEPSUubzbl_A>
    <xmx:gAg0Z4fil4cp3c-MaJrVhm3USgKcyHGiZwHWMMwWxtJTk-mRiTi_uQ>
    <xmx:gQg0Z4OaU8OXhQ8oUWF9bX8jcSMCrbG28ve-EwPll64F9glMnd7rXNg->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 21:01:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Seth House <seth@eseth.com>,  David Aguilar
 <davvid@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 4/5] git-mergetool--lib.sh: add error message for
 unknown tool variant
In-Reply-To: <74b83caa1e5c1a63248dd4dcbaf2cf450f9cf32d.1731459128.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Wed, 13 Nov 2024
	00:52:07 +0000")
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<74b83caa1e5c1a63248dd4dcbaf2cf450f9cf32d.1731459128.git.gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 11:01:35 +0900
Message-ID: <xmqqr07f28ow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In setup_tool, we check if the given tool is a known variant of a tool,
> and quietly return with an error if not. This leads to the following
> invocation quietly failing:
>
> 	git mergetool --tool=vimdiff4
>
> Add an error message before returning in this case.

Makes sense, but ...

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  git-mergetool--lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index f4786afc63f..9a00fabba27 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -263,6 +263,7 @@ setup_tool () {
>  
>  	if ! list_tool_variants | grep -q "^$tool$"
>  	then
> +		echo "error: unknown ${tool%[0-9]} variant '$tool'" >&2

... I do not understand why you strip a single digit from the end.

    git mergetool --tool=nvimdiff4

says 'nvimdiff4' is not known as a variant of 'nvimdiff', but
wouldn't it still be a variant of 'vimdiff'?  Of course,

    git mergetool --tool=nvimdiff48

gets a vastly different error message ;-)

Saying

	echo >&2 "error: unknown variant '$tool'"

may be sufficient, perhaps?  I dunno.


>  		return 1
>  	fi
