Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773923;
	b=whym3xkAWh/vjy/rCgdWPG1VL+MaCz4rlz0bhYLeFogz+3MhplW6129uGxmRuG63SZXC
	 BY9FAseZE+pHoGME2q7uX93kfbwwt+xmgiAoaDX6zVHqKVKxx/61GHJv+LotuySIdteBF
	 YPehPPC1NL5Z1tAAwhE5byAHB9q0gGPincpFXe9z39n1ZwNDwpMSwK1gUyuegYaHiJzY8
	 UxYbrtyLrEJibPug2KxuSgrIrseQnURgtIG+rWQ1qqxYqF+JSZlTcdfFr/vjyNBMuENpM
	 LlFgLbZ6YCsb2s7mfoW0xY8ktrlSEf7Z/b7hLJ70m4zHaGJjJeF/S5x7x2+ojJDSe2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773923;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vj77j+s5yK0YMclbQ8MGXwRxks4A2TZRvUC+dYJgiTg=;
	b=N/9BIVmaPtUL07eNZ3VjgqKaKAnI/oSAxL+slZiwJOj91oQPtycLzh3RDUBMXvVLEOR5
	 1MI34DkTsno1QxuSPMzWik1BaVaqAMjaEY/Y5ex4AGSxswA3eCfn23BWAzYKNglCwJ3m4
	 SnnLqqF8ZvNkieB27V7HKlfGhBy4nvI36w8goCs+V9KEh6Golpx0jD6cu3RotlG666VEl
	 9UJEu2i0iN+7gAWrsLE3i+jVokG2o1BWGSnGAr2psMsk92fj0TM6dMKdtoJueGDkh/9Sy
	 dQKhK8sGwZtLESeN/Nyz8QH0m1rfMgfnlkkKRyq/Q9PzCxa5qrunD9WLWEmZdF07WiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=SwgecYSv;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3F606A329
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A3F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=SwgecYSv
Received: (qmail 12285 invoked by uid 106); 4 Nov 2026 06:32:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mO82G0NAIOdOK+hQ1Euz+/oiiGHjrnK4L0xRnNLY6Tg=; b=SwgecYSvMXlkpoKarNYZi42XAu0PeZ3N85X3m4uLFduADpc9vcSPRDSLeOjmMcy+l47PvR8darbjd/G2aFdWj6moQpJuwe7hyb3HZ7NnwCM/lJ/NIcWMksDbqPy4JHzmO18JeYGDEVpQPUuxDq23YwRYXVY9dS4KGgy0jkDhWvS5QKehK6daIEpe4/DoX1Enf423hI0h6kqiystTzXKOg+z2mW6edJZxQV4ocaqPLHhGJmpAOQHnlOaYRd0pEs+W44+8afsZ0gRAx3cVDBwqBe0aE+MHillxiMYXmaWl8wRK+VtrOCgph9NlQLvZYKPuofduQIzoaNdrPphjwlJoZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:32:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29571 invoked by uid 111); 4 Nov 2026 06:32:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:32:01 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:32:01 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
Message-ID: <20261104063201.GA1543013@coredump.intra.peff.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
 <20261031020318.tLesiElF@teonanacatl.net>
 <87jymy5uek.fsf@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jymy5uek.fsf@gmail.com>

On Fri, Oct 30, 2026 at 10:08:35PM -0700, Collin Funk wrote:

> Nice catch on the NEWS entry. Sorry to you both for the extra work. I am
> at least partly to blame for those changes.
> 
> In coreutils-9.12, we made 'env' and 'printenv' quote their output. This
> was to make the output more robust in the case of whitespace, special
> characters, and in particular, newlines in environment variables.
> Specifically, any program that parses the output of 'env', without -0,
> will certainly mistake environment variables with newlines in them as
> multiple environment variables. See the following example of the output
> before coreutils-9.12:

Though it created some extra work here, I think this is a good change.
There's another spot where we use "env" in the test suite that I was
looking at a month or two ago, and I was mildly terrified that it would
allow variable injection (though probably not a big deal in practice for
our purposes). So I'm happy to see the situation improving.

> In all of the cases that I have seen where the 9.12 behavior caused
> problems, quoting only when standard output is a terminal would have
> avoided all of them.

Yeah, but then we lose the injection protection. :)

What a complicated world we live in.

> Note that some distributions may have also picked up the patch adding
> the --quoting-style option [6] (I think Slackware did, not sure if
> anyone else did). But that hasn't been in a release yet, so you probably
> don't want to use it.

Yeah, I don't have it here yet. I do agree it's good to have, as it lets
the caller be careful when they know they're going to eval the result.
Though of course it creates its own headaches, because we might not be
using coreutils env. :-/

> Sorry again for the extra work of having to investigate that behavior
> change.

No worries, and thanks for the explanation. I think the revised code in
git.git is better for not using "env" anyway.

-Peff
