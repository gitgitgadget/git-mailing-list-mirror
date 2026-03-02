Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447130BBB8
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474170; cv=none; b=NZ6eqWlkyZOLCiu6PBAbl+7fVvRh/op0vr2Z4X3tVHKj3L0fvA1uAx7jzTvuXVWYYoSWkd8A7hkNy9O97URBdG4fA8dLHd/igXQm/Ymnv861/jzp38yHe4JN3xMKaiknOO8MVXoPwrJ1arfB1fDMh4KsWvw552NfhD2IcbIz07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474170; c=relaxed/simple;
	bh=+3RqwG0m77Ci9I60hnf8/d8ilFW6l6lOdSHuh5JFx3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdUSJ1lDeVf3IJJ8weuA/Wmg8kOkO6pFRhEZAM2VawXidL7nGA13mEfGR/bvttc9p8+foF1AxWoCEd6jnGMl7I+zvmKniTv33dPxYdPPCTGMtcrgARw2JIPkPfbzQwm2Uykj1XoETBarxBoIHAlnYPK6IBAg2StfZsPIOIjGL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W2XwABai; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W2XwABai"
Received: (qmail 28805 invoked by uid 106); 2 Mar 2026 17:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+3RqwG0m77Ci9I60hnf8/d8ilFW6l6lOdSHuh5JFx3U=; b=W2XwABai1tYI/JeREjM49cZrp10BPDgpKUu3WUyM67AIGVEEKE2QUZUgIIMMwfRH9h1EAEei9m0De5SbF3lOXgNZvNFpab99RWmQvm9RLQSq7vQiHKeiIiG1ZnbE/edfkIq/H8P9pC6XM2CdWaIqItZWx+dtBva8dlDDxWJ0ERfH76GBuRC7VvsxiQlUW89mgUZTPGSeIyasfzYJDIKl7l1Phwxb2CPAHb1QNClw2bESfn7UQALTyQDMYhpBPMtv3mcSHUKsO1xE0aEINkod2jo98MMxbqy3B6zTLcr+rravp7KrKCRHQSbPMbMFnjOfP1wEdx9NqIAnVnQpRIDuZQ==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 17:56:07 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333770 invoked by uid 111); 2 Mar 2026 17:56:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 12:56:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 12:56:06 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/4] for-each-repo: test outside of repo context
Message-ID: <20260302175606.GB28275@coredump.intra.peff.net>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <6e9d4f3029daa2c0068bb16939b943e7ac924222.1772465805.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e9d4f3029daa2c0068bb16939b943e7ac924222.1772465805.git.gitgitgadget@gmail.com>

On Mon, Mar 02, 2026 at 03:36:42PM +0000, Derrick Stolee via GitGitGadget wrote:

>  test_description='git for-each-repo builtin'
>  
> +# We need to test running 'git for-each-repo' outside of a repo context.
> +TEST_NO_CREATE_REPO=1
> +
>  . ./test-lib.sh

Interesting. I was going to point out that this won't do what you want
by itself, because Git will keep walking out of the trash directory and
may find the containing repository.

But it looks like this should be enough due to 614c3d8f2e (test-lib: set
GIT_CEILING_DIRECTORIES to protect the surrounding repository,
2021-08-29). Supporting this case wasn't the intent of that patch, but I
don't see any reason why it should not work reliably.

-Peff
