Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB811DFD8B
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077221; cv=none; b=fndN5QYXirZFE0dxABiuCyCx+jhp7r7s9rZBKIDUZfDduLqv9CFgyqiSm1GI4g2TJgx16hnnMypjrxOJH1OBRI6m8bkgOwQ7zJvGSQ/pZudLWZy2/93fE6DRSdwUckgdwWA3Zh838ICdk0DlQfRCwzoe/fHVrES+2d8p35LhtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077221; c=relaxed/simple;
	bh=kPObWwLA46yUss4vKoznQv63PtQX66D5Wbmi6gQXf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbGOLjdBSO84h1GwqVfHaAvni+pJLvnPgVpbZPmAIgegTcsd8qvK6ovrFTlAes9c3UBXVBTEn25xfyw9HEYw0fWxXdygosJUOWopxxNWK0HE2mcTeK2mfMStmVu13YRK1Ry3lML1i1nlVs4UgL+xyP0Lso8pByAYBVSHRzDnzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H7GbH8e9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H7GbH8e9"
Received: (qmail 10330 invoked by uid 109); 4 Mar 2025 08:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kPObWwLA46yUss4vKoznQv63PtQX66D5Wbmi6gQXf0o=; b=H7GbH8e9lTdq5QvWdhhYfuZGLet0pBJqzudyeCwRVRj6oBMJQOz6s5fD+xaYjinmIjC7GbxSgb7ZZSf7lWojsU2ir/+8eLvB3LlUaD54RjAEAzri7TpmBx2WqQuvYij01jnxe6sCiRH3goEAJHfUuzHP0KNu12BSeiT2O2sZxCKV+kXJTFUhrWp60RVMBPMx+tioxq/GNcf5YTiKGt9wXrdQIQRQOc3tqGdfXac2Ai5/wbx9qmb0TqOWQ9mtJgzlOOJcYfzDp99O8k02LLH2VRWjkacX4OBNdErPFDe7jf14ujZ6PJCarRLs8+NjKq0N8Kx435OyKonpsEBXoL4Ykw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 08:33:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23481 invoked by uid 111); 4 Mar 2025 08:33:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 03:33:38 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 03:33:37 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Michael J Gruber <git@grubix.eu>,
	git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
Message-ID: <20250304083337.GB1297837@coredump.intra.peff.net>
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
 <Z8GVAjwZWOM7c2fR@pks.im>
 <xmqqseny40kx.fsf@gitster.g>
 <Z8WFcaEtMCD5C0EN@pks.im>
 <xmqqzfi2xl5q.fsf@gitster.g>
 <20250304073010.GC1283943@coredump.intra.peff.net>
 <Z8auRqylLYuwalAA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8auRqylLYuwalAA@pks.im>

On Tue, Mar 04, 2025 at 08:39:50AM +0100, Patrick Steinhardt wrote:

> > Some examples, assuming we just suppress reading Git config:
> > 
> >   - Without an explicit ident, we fall back to constructing one from
> >     system info. So if a unit test ever creates a commit, it will work
> >     fine for most people, but not for somebody with a blank GECOS field
> >     in /etc/passwd. (We do look at that field for reflogs, which current
> >     unit tests already do, but we are more forgiving there since we
> >     don't pass IDENT_STRICT).
> > 
> >   - Other programs we call (e.g., imagine gpg or ssh for commit signing
> >     or verification) may read their own config based on $HOME,
> >     $XDG_CONFIG_HOME, etc. I don't know if Patrick was including that in
> >     "sanitizing the environment" or not.
> 
> Oh, yes. I didn't mean to say we shouldn't sanitize at all, I rather
> meant to say we should sanitize to values that simply cause us to do a
> no-op in the relevant parts. That means we'd:
> 
>     - Unset a bunch of environment variables where we know that they
>       impact Git.
> 
>     - Set config-related environment variables to read configuration
>       from "/dev/null".
> 
> This is in contrast to the more involved fix here, which would be to
> populate a temporary home directory with gitconfig files and whatnot.

OK. I still think you'd want to set GIT_COMMITTER_NAME (to avoid gecos
dependencies).

And I'm assuming your "a bunch of environment variables where we know
that they impact Git" includes $HOME, since we are inheriting
dependencies from sub-programs. It doesn't necessarily have to point
somewhere useful, though I wouldn't be surprised if some programs
complain if they can't write to it.

-Peff
