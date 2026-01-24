Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD23EBF1E
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769239704; cv=none; b=sQOdv4dV60CpMRb+IswGys3/uyffwuE8+PHo6hcvBZCmpw4sneEmun/C83jtdfVbshD2O/d5U2MNEOemmFbL8/pxcjXmz20YjXwOgD/8NHkOIQkFmIMKg1grk6KerpZiMQhPBXL/6ZAy+qoT21Z7u4FSRXf0rLeOfGoX3l5SePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769239704; c=relaxed/simple;
	bh=q29SaUYcln6pTeuxPVqYjP0ajyO8/mBJTKxgXbaui1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep5u9tIef9fYem4kX4P3L3dEyp1akZLKOtJrJFy5KBh2G1NHn60Ap/5veFYl3tctcn6jDA4ddaLmyiiEppjIs23+gi3S3uWUCRCfqwbZ3++qRjKDNerlpZfsXjFh9jGnL5VCDZmA1DmMbPje8eIK+cJHtrrSvhg1f3iMn55tOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=byjXPUPl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="byjXPUPl"
Received: (qmail 144684 invoked by uid 109); 24 Jan 2026 07:28:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=q29SaUYcln6pTeuxPVqYjP0ajyO8/mBJTKxgXbaui1c=; b=byjXPUPl4pJ8OsaUpLJecfNI4d/5uPlNEipwUKcGAIS1vnDQOB5TM1BLJ5ZPCee4j0H47B/AVYop1+DbqrBC/2dQtTb139Z5oSGfm4iMomQSo0U+O3eOEgaljTL9Z2LF9jyaaA4Z6UdD/5sul5pjjvntny0Drgm7uPmgHjT0xJXxN+ClwtFWHA97y/dhts6xWgCc/EB8thHMH4ioBANCLEFpoWsDpes8Q1VFFYwtI5ZsXaGKS9HAUKKyofHyhjioACcAjBgvfqPVtpOLwVVebkO3BY/IFoLNMYJqRwbppuGg5Dtl4nEp0KxbBzDo7uo8PqJtHPg/I1sqH4Q3p3t3zg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jan 2026 07:28:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 273723 invoked by uid 111); 24 Jan 2026 07:28:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 24 Jan 2026 02:28:19 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 24 Jan 2026 02:28:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Klaus Sembritzki <klausem@gmail.com>, git@vger.kernel.org
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in
 za, and I am 1aa
Message-ID: <20260124072814.GA3455597@coredump.intra.peff.net>
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net>
 <xmqq8qdogdmu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment
In-Reply-To: <xmqq8qdogdmu.fsf@gitster.g>

On Fri, Jan 23, 2026 at 02:36:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> >
> >> $ # My initials (ks): 1aa
> >> $ echo ks | sha256sum
> >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
> >> 
> >> $ # 50566750337
> >> $ echo thinking | sha256sum
> >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
> >
> > Oh man, I've got deadbeef!
> >
> >   $ echo jk35252822 | sha256sum
> >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
> >
> > What could it all mean?
> 
> Sorry, but I have to admit that I completely lack humor receptor
> cells.

Probably because it was not that funny. :)

The original message seemed to be looking for Numerology-style meanings
in random data. I wasn't sure if it was serious or not, but I could not
resist either playing along (if not) or trolling (if so).

But here's my deadbeef brute-force program for fun.

-Peff

-- >8 --
#include <stdio.h>
#include <string.h>
#include <openssl/evp.h>

int main(int argc, const char **argv)
{
	const char needle[] = { 0xde, 0xad, 0xbe, 0xef };
	const EVP_MD *algo = EVP_sha256();
	EVP_MD_CTX *ctx = EVP_MD_CTX_new();

	EVP_DigestInit_ex(ctx, algo, NULL);
	while (*++argv)
		EVP_DigestUpdate(ctx, *argv, strlen(*argv));

	for (unsigned i = 0; ; i++) {
		char buf[16];
		char *p;
		unsigned char digest[32];
		EVP_MD_CTX *copy = EVP_MD_CTX_dup(ctx);

		p = buf + sizeof(buf);
		for (unsigned v = i; v; v /= 10)
			*--p = '0' + (v % 10);
		EVP_DigestUpdate(copy, p, buf + sizeof(buf) - p);
		EVP_DigestUpdate(copy, "\n", 1);
		EVP_DigestFinal_ex(copy, digest, NULL);
		EVP_MD_CTX_free(copy);
		if (memmem(digest, sizeof(digest), needle, sizeof(needle)))
			printf("%d\n", i);
	}
}
