Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A814B96E
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404193; cv=none; b=tga8AkwmCiJktiO4VNbySwBqZnRrb3GH7hUJLabkpSEngn4aW7jNz59Y7JE9msIWvBYnKxEwQuXjXgzo/X1i3+Vo48/nkIUyllOe2h11OciOlagQ3cpql+8cjLsDAOVEbgN15LZdy8YIQTtVp7Y+zpTjhM5q83yDZ7y+MCaT7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404193; c=relaxed/simple;
	bh=bQh9BP2py1XRbThLivMoQuAsWSqb9es/UvWfGoNWWc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDO+VDYZS42dzkyRvZQCeH3GXc43M5dUBXTh3JuUGwlAJpishi35dOwOVMYAlJiHhDlc79kZAKMAPHSe5xMFw/KrVEEmirdnmdhbInqmgfOALrYRQp+U7BAvwqGB6gSoANSfAy4LnUddLtr0edHVw84iCUlDZtspn5NgtzOIWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=igy0ZWvW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="igy0ZWvW"
Received: (qmail 23647 invoked by uid 109); 8 Mar 2025 03:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bQh9BP2py1XRbThLivMoQuAsWSqb9es/UvWfGoNWWc0=; b=igy0ZWvWN/P6TwO4TIU6WqMCCx+/EpX5Fh0d7Qpo1gnA6e1mnZjdjpoGPgKj/xmbrrpLWOUwNaHdcHVAK057Ke9Be0oXPRcmbq5W0v2dLbzxwJSNrm4zF07cDs0TgQzt7rHTJA802UDr8O9DUuCTWOX+a9aBYo3L0K8jLZum/CifTyt4U9hbh6WM3IWAkUwjv0T46uOXs40AuprWADxiL4YoPsRqCHyJPT1Kv33nKPslXyPmMVEDPh3z6GacDGSYUMGxzPlewlTquXzUhu7PKO6Mc3Rm9F+mBbSgrsiCwXCfO34ic8yuKxZo7QRgOhftYkb/l724AQGLa9WlT5feZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Mar 2025 03:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22716 invoked by uid 111); 8 Mar 2025 03:23:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Mar 2025 22:23:09 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 7 Mar 2025 22:23:09 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250308032309.GA584028@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307225444.GA42758@coredump.intra.peff.net>

On Fri, Mar 07, 2025 at 05:54:45PM -0500, Jeff King wrote:

> However, clang does implement this option, and it finds the case
> mentioned above (and no other cases within the code base). And since we
> run clang in several of our CI jobs, that's enough to get an early
> warning of breakage.

Hmph, this might be more trouble than it is worth.

After correcting the problem in the refs code, the osx CI builds (and
only those) now fail with:

  run-command.c:519:3: error: code will never be executed [-Werror,-Wunreachable-code]
                  die_errno("sigfillset");
                  ^~~~~~~~~

The code in question is just:

  if (sigfillset(&all))
	die_errno("sigfillset");

So I have to imagine that the issue is that sigfillset() on that
platform is an inline or macro that will never return an error, and the
compiler can see that. But since POSIX says this can fail (though I'd
imagine it's unlikely on most platforms), we should check in the general
case.

So I don't see how to solve it short of:

#ifdef SIGFILLSET_CANNOT_FAIL
	sigfillset(&all);
#else
	if (sigfillset(&all))
		die_errno("sigfillset");
#endif

which is rather ugly. It's only used in one spot, so the damage doesn't
go too far, but I don't love the idea of getting surprised by the
compiler over-analyzing system functions (and having to add Makefile
knobs to support it).

I guess a knob-less version is:

  errno = 0;
  sigfillset(&all); /* don't check return value! only errno */
  if (errno)
	die_errno("sigfillset");

which is subtle, to say the least.

-Peff
