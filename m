Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333F402BA8
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365527; cv=none; b=LJVbLClyFdM/2WCzF17jhuqek4xOfTFTOR1qWpjl/+8i9UW9jnQbs6JUUWtBwOWVRkpVTltnFb5B+wYuJbFg54uVImzcoiZ16tvqBqrh7No32gosVfitPF4FB3QVG79BezEKIzeMeguaraDg+kKGEGGkYyiKg0yrr/cIWTBirQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365527; c=relaxed/simple;
	bh=nVPLkZvkucalTMWv+eUQYXbLxQCE7ti6mVv6BVdd/UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbSNL0v5jo2c3NmPddEDqeNW7XIj0pgYuA/5ZjtaPqSCKSLm9yNp0nxxZQ0ehvGlak+pG5vRa+/FnpYtXIBIOZiTgsYMujFTj9S93lkrfEcuVc/ZAyl62qV4kr0Ce/791aE4es5n3fPEkFn/uUf9tvdvvU3SHCVKgXKm5brLPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Rls3yjaD; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Rls3yjaD"
Date: Tue, 24 Mar 2026 16:18:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774365517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQX9xI0AbCEoDOS54yKL61Kp13IDhCxKEVCe4JJ+JLc=;
	b=Rls3yjaD0yHgrA8w1vpVltE/0LDbENht4HJtpZgEO6g/Y+oo+BiGaJmZgrIdXSscfo4Hk6
	TyDePETXcKJ+p5GrDXYl2VjdtrUJbJQ198W6mq6DxIakrPvGoSjhnYRQUkJEIOCwZQku6S
	5HtILyv+FSkIEoxsRZtTLHJdOMbFxXJzmm1P63+6+AVQoho+RBWGwMmTgJ9UwYCPJVVpaE
	RMeUNvylAqwbTMZOVW9jTm/YFHiqVqa7St7vdgVjAbgqV9cz5vN1B6C6IysdtyhSbtkJ4z
	at6EiHbqBiYNGogs2oW9MkpPZiVfxHbU/X4qMFvdbh/XHfm5OfzOFhUQQ1I5/Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] t4014: fix call to `test_expect_success ()`
Message-ID: <acKqvI0EhaORjoD7@exploit>
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
X-Spamd-Bar: --

On Tue, Mar 24, 2026 at 03:52:30PM +0100, Patrick Steinhardt wrote:
> We have added a couple of new tests to t4014 in 6005932d95
> (format-patch: add ability to use alt cover format, 2026-03-07). One of
> the tests has typoed the call to `test_expect_success ()` and instead
> invokes `test_expected_success ()`. Fix this.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> this fixes a test bug in one of the new tests introduced via
> "mf/format-patch-cover-letter-format". Thanks!
> 
> Patrick

This has already been fixed in a follow-up series under
mf/format-patch-cover-letter-format [1].

Thank you

[1] https://lore.kernel.org/git/5d061d6398bae368a7cc95700b5df44854d1d8e8.1774284699.git.mroik@delayed.space
