Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0878313531
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689986; cv=none; b=M2yCWIwsuLhEFz8ZvkkMsoGvaR32gzcwLKOXGXL643IFVLrfY2AvJEPAWvoFUOziH2sLl8pDfjS/Ixl9k6MGagJ+xFr+IydEAfRVS7WGCWqOnW6XwDfj99QeWfxh5IdHdI6arRnTDI+SVBtUSq+oO2fIDcdebVh49bVeoxRD4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689986; c=relaxed/simple;
	bh=srgehixWD8QYJ0pzJXHFBX7UfFuFflKuzY4fSKpjTx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvRX6PKuCJJDKbOsGWUARWUTA97YEuUL30qD1un2+ZyZ/4IDAQoqfenm3bQZaO/yhvcRTLVZHUZoBpzWqRiad/htwp/bj6Dt0q44r2hnF5OXbABzvhsjrBcEUyza3njUaz14QGIRkxX0XkC/ZiUZWGFHazi6UT2+lDDnH8xtv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQi9jYbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQi9jYbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1150CC4CEF1;
	Fri, 12 Sep 2025 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757689986;
	bh=srgehixWD8QYJ0pzJXHFBX7UfFuFflKuzY4fSKpjTx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQi9jYbnV+qdc0u6Ev/jJ54oivvSkdtbpKFrmkdELk8+q/1TsTLrqMXw8dQrGzZZC
	 r6VcQQpCkZqduO8VTTb7KmybTVLCSkV8/idJ1PBmaIxUkMbqtHZ6Ck1EXap6q+s7zz
	 5O3DgiZfPsiLjJlbGDWcZahszxWd4MsTGyx+pRv0=
Date: Fri, 12 Sep 2025 11:13:04 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: usharerose <ushareroses@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [DISCUSS] validation on git config user.email
Message-ID: <20250912-curvy-owl-of-growth-a84dfc@lemur>
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>

On Fri, Sep 12, 2025 at 12:13:07PM +0800, usharerose wrote:
> Hi, Git Community,
> 
> I'm a Git user and curious about a specific aspect of Git's design
> regarding the 'user.email' configuration.
> 
> Git allows any kind of values without restriction when setting
> 'user.email' via 'git config' (e.g., `git config user.email
> "not-a-valid-email-address"`).

That's a valid email address on the local system. It will get expanded into
not-a-valid-email-address@localhost (or whatever domain is configured with the
local MTA).

> I'm interested in understanding the design philosophy or historical
> reasons behind this 'lack' of validation.

This may be insightful: https://e-mail.wtf

:)

-K
