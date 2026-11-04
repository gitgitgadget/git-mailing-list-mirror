Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761119;
	b=VwxkFSLbYpRdy2WA8yW04zUy91Z3l15+E4KA/RrQLGrPJVvBfQX/Zg1UOQkzh2vaZwF/
	 JNI36wAJth4iUn09nMHhXKK6Zq555M7mZGyRDe5AZuldJ9T/QqczAy+mHYzzAYVN+MgM5
	 xYkSlh9zoTZKRzKKWNEfYTYDN+jdu0wu5ANc2J1+7Q8/lxq7jzrsOgExBU8dJUHZC73a6
	 AuKHHc6SQIzZI8rF5FWKGFtOXVx0PB0BqvWWKa8nqrnMZwO0L/+eBWM1OILn1yG9NN8dv
	 giH3Vw1BL2uLbcjKqPe07OCh3QG1MW7owjZIyh4tCOUu/AZcA0lQNKHwiNqprgyPxLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761119;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=a4rO5VBy3xos7/ea2l4RmwWxp1MbWaL6Cu0i/9T6Mno=;
	b=LjOtRApuSSrj0gDU9QRnyRQwDlWW2yz4wNk8eZ603/mjrjPrWgwcv9B1sW7+LxSYIIk8
	 Jn3G0uKJUboXyoEgDZ7k3N5ONPlm+8OD1E62Z045kzu2I4ftUFGP08AaC6tNs8FoMeDiw
	 0/S2V+G7fSd0W2ccO5u31EFPg+zsjYM83b5MQeCVzL7SDsu1lT0vAIH7Wv7eoCV+ocKc5
	 fCxi00JcNA9X0+FcML5FMZifDImA/vE4sPqM+ZAwbRbCS0WLEqTwXc1T86WgXG6hCJ+a2
	 3bqHRkYmoYQkuVbyFxHTxV/HrN2bJA8ZE+PmeXfNB/RP1HKIiAzxxoyEQAEDjt+98Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=RfJt5OyB;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA84606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 02:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA84606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=RfJt5OyB
Received: (qmail 11495 invoked by uid 106); 4 Nov 2026 02:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jeet5vzsJvUhMf5oZ8Nufd4bSugaabeqVhQQ45AHWbU=; b=RfJt5OyBGYacjnm75vbHfzf1p9U/dW8Y4YphKyJ1Xkp4FwT6mI+SpAn65G9Gzv+d+y12Gsj/PPN1TB516zH7eFCoh3ySCQOEHE51nHVXLY6ef1mkGpxDUAzFcjY4zHBtwDOEmIiPJWktKkILbBSasqcU+HfLgjmLTS98qLfT6P0Icll8umuspPbFoCHja7CGvpvryobrJbk6/8sWKA8EGQ2Y46h2KYW0hFlk8R5Q8OMmI+I42sPGnqWmlwDJQHBhYh5ksE2E8H1Na7XPP5lhEmO8wpRQUO5em3pNT8qYVjyakBKnPj2PT5YMMyBHjLPEBrpRAr5uMCcJh5v5YCIi1g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 02:58:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27494 invoked by uid 111); 4 Nov 2026 02:58:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2026 21:58:36 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Nov 2026 21:58:35 -0500
From: Jeff King <peff@peff.net>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 1/2] credential-cache--daemon: allow a concurrently
 created socket dir
Message-ID: <20261104025835.GB1492379@coredump.intra.peff.net>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>
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
In-Reply-To: <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>

On Sun, Nov 01, 2026 at 03:29:25PM -0800, Farid Zakaria wrote:

> When no daemon is running, two "git credential-cache store" run at the
> same time each try to start one. If the socket directory does not exist
> yet, both daemons try to create it. The one that comes second dies:
> 
>     fatal: unable to mkdir '<home>/.cache/git/credential': File exists
> 
> That client then fails with "cache daemon did not start".
> 
> The fix is to ignore EEXIST from mkdir(), and check the directory's
> permissions the same way as for one that already existed.

Makes sense. This is what safe_create_leading_directories() does for all
of the other path components. So of course I wondered why we bothered to
do this last one ourselves, but the comment (which is just out of the
context of your patch) explains it:

                /*
                 * We must be sure to create the directory with the correct mode,
                 * not just chmod it after the fact; otherwise, there is a race
                 * condition in which somebody can chdir to it, sleep, then try to open
                 * our protected socket.
                 */

If we find the directory already created, then we are subject to the
same race, but it is reasonable to assume that whoever created it did so
in the correct non-racy way.

-Peff
