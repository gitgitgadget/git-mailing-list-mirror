Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792978377;
	b=2KyuIztnzyrATKWn2PaulOFSeDXtDRY32iuZKUvnG4+4TiqkE+IwC45NB4D+cfoTQo9x
	 DpJ7OwXpoE6/OOaaSoNKf8pfzowbvdDrF4iBkSweSTL5zUiS1J2ouBO2lHsG8uBWKQNv2
	 xBcNfM3KqCjEQGeWagUl7f1P+lyxIm+mt+gX8uOwYYH+Q8FoIu61Sdzj0H/Q2dUzwada3
	 XoVxndGfbo2DNIOwtJJAtTSDiT14nTyQEWcUTBUGVHYQw3TM7uas8Er8PpiHz5cVRvusA
	 mbdhgYXkRZFjFRY/TTIS0oxlpil15EZTyhFomRprb30W2J60KZwbX/jAHFvZ3Tffkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792978377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Gbh6dznelc2donhPYY5Wl3/5QXhLdh8tyImfmbd4rQA=;
	b=UOnelFhXgQVYiH9smVrCASAfMdeBN5YM6rhGzu/sK5EEnRjg0GMwPYaeWdhCxScHVZJD
	 soSquiN+6OXiUMh8+Q/8PtSWiFlIuMyWeD7qRLPi8kofoLrux2zHch++rRp62IBfUUXnU
	 u37j8+f23W/DSfEL9weBcdYobU/SjiMubvRfCeNV0A4YxZ99gRuJsSu14hOjiWTGVUcAG
	 Jz7+Nc3tto06oB+rmNIKPCXrvGlx5l91EUwaRjTTwcYMnJWgytkoP3h08X3RfM7CzzrpY
	 2C328nW1kqeZUcGsi6VZrLQvN39Gx7BWt/XEpYzLRoDV/D1JpGaxMXMMWb+TCsAO+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bp05ZvtW;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25482606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25482606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bp05ZvtW
Received: (qmail 32011 invoked by uid 106); 26 Oct 2026 01:32:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qvm/AxXaNN+E2+fPp5YPb6zA/Rx+X8J6JTqnUXXUcdE=; b=bp05ZvtWohrxnhaC1VQYNH+mcHDXeMsvJkjxihsmi92x59Oxv8qv4fBbFDs65y8iRszMaTG3pgfq0W/XEc5cjTqsqqPdUvXJUIqVbSxX/ckTmlFmBdYTNyS/WASm8+eeYFK15IdiIvQw2huFypid9g+N3Gq96dOR6anuYZY3LOdxQqBH4k2CvX1XgJKbcnOvK5xp6Rp4gvZZVaozpWYky160bye5h/9RugD5oMUziyzcVvfTwnTEqCprmKGZ3QBkYCdCSeUZBNiqek0G/L8SypN7xqudbqx+RooCs5vXR5EafR4yEP8ZJdaymiUbXxYoYT9IzfApk2usu5rTJqQMQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Oct 2026 01:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 251970 invoked by uid 111); 26 Oct 2026 01:32:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Oct 2026 21:32:54 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 25 Oct 2026 21:32:54 -0400
From: Jeff King <peff@peff.net>
To: jyotish kumar <jyotishkumar725015@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Discussion] t1006: testing %(rest) with object names containing
 whitespace
Message-ID: <20261026013254.GB3575069@coredump.intra.peff.net>
References: <CAGjZMyRqv5RsLF4Vo439zy4urfr+R=CTwuDzmYjiemauuZan0Q@mail.gmail.com>
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
In-Reply-To: <CAGjZMyRqv5RsLF4Vo439zy4urfr+R=CTwuDzmYjiemauuZan0Q@mail.gmail.com>

On Sat, Oct 24, 2026 at 12:17:53PM +0530, jyotish kumar wrote:

> While exploring t/t1006-cat-file.sh, I came across the test for the
> %(rest) format atom in git cat-file --batch-check.
> 
> The test currently contains a FIXME explaining that %(rest) is
> incompatible with object names containing whitespace, such as
> HEAD:path/to/a/file with spaces. It uses test_expect_failure for that
> case and mentions using the resolved object ID as input instead of the
> original object name.
> 
> I investigated this test and noticed that the run_tests() helper
> already has access to the resolved object ID through $oid. I tried
> using $oid as the input to the %(rest) test rather than $object_name.
> 
> With this change, the focused t1006-cat-file.sh test passed all 423
> tests locally.
> 
> Before preparing a patch, I wanted to ask whether this is the intended
> approach for testing %(rest) here, and whether removing the
> conditional expected-failure logic and using the resolved object ID
> would be a worthwhile improvement.

There's a similar discussion here:

  https://lore.kernel.org/git/20260219152407.12160-1-deveshigurgaon@gmail.com/

I didn't participate there, but I was the person who implemented this
crappy %(rest) behavior in the first place. ;)

I think what Junio noted at the end of the thread is important. The
limitation of %(rest) is documented and how it's "supposed" to work. And
the reason that is the case is because %(rest) was added much later than
--batch-check, and was stuck with the existing semantics.

So IMHO everything is working as designed, and there is nothing to fix
in the code. But using test_expect_failure seems weird to me. It avoids
the test suite announcing a failure, but it is not really a breakage to
be fixed. A test with %(rest) and an object name with space should
probably just be skipped. We _could_ run just those cases with the
resolved id, but the point of that test is checking how %(rest) works
with the name, so I don't know that it would be testing anything useful.

-Peff
