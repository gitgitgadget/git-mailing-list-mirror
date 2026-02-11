Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAE4AEE2
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795364; cv=none; b=WhFIFjUFxcoKQ9sgPrsxzvIF6V8ikg++DYti28HQpKYV9hxTOu5PT8+zH03Zl9hCGc6dx7o40sXIrvEgqnWh4zAvomRWkSa0TUOP/Ek5H+S5P3FdX4Evw/03LR8w6pae878jhP9sEQrrawDvNk3ZoFyRO9pqpDq7vzvHw0Yx4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795364; c=relaxed/simple;
	bh=xYR1Xa3whcBlgqTEVkZGIRMnGtGiuNZtqY0OY76c7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg8A+UfQVqLek8oxUz1yhGLIeGDQ9lgF8CUXUR/Phaa5jNuOA2aE3SaOfEglKzYUYpkewYSvp0GGHB1ud0EeVwrZ5OLRNmZsIO/edS8ShfM4G8XVu7O8mwjbrkwUKG0xNBqrNhxjv7k3LmRIT18qNqul6dK/paNolLS57PtI0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OuzvBII1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OuzvBII1"
Received: (qmail 11940 invoked by uid 109); 11 Feb 2026 07:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=xYR1Xa3whcBlgqTEVkZGIRMnGtGiuNZtqY0OY76c7dY=; b=OuzvBII11CSbHTPZ4QK+LyiNTgyfF4y4FVfkwKwCHgr6/Mmyhj30PlhB5q/5vU+SlUpoSohE/v4wXIFnixCMLf3gHdJu3f+qql561yl3peQZeT22+7dc4Earw2fh7swGbpUz+d5O+DzUy0LUhg0eHWJFiz9yDJJnhxoDZEeThijmdu/vWTi9nyR9GHfhz15YwoacnMa/uvw9X7DxBpzCG8bCaP77N8Uoa97JCdJ4FObmUx7MbrT8RZuOQW82C95Xaifkwt3fTiq6lT+FOMWooQdShCPOvnB9ITsfSWa9KGiyaPmVE8MhzXYViUbyrUeHKhXniQXZpesWN1Pju4s+7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Feb 2026 07:35:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20285 invoked by uid 111); 11 Feb 2026 07:35:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Feb 2026 02:35:58 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Feb 2026 02:35:53 -0500
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, git@vger.kernel.org,
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <20260211073553.GA1867915@coredump.intra.peff.net>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>

On Tue, Feb 10, 2026 at 04:54:02PM +0100, Kristoffer Haugsbakk wrote:

> An aside but `format.noprefix` is not a boolean like `diff.noprefix`.
> It will be enabled with any value.

Huh, that's weird. Indeed, the code is:

          if (!strcmp(var, "format.noprefix")) {
                  format_no_prefix = 1;
                  return 0;
          }

which seems just wrong. I cannot think of any other case where the
_existence_ of a config variable determines the outcome, rather than the
assigned value. So I would be inclined to call this a bug and switch it
to use git_config_bool().

Technically that is not backwards-compatible, but I really think the
existing behavior is just a bug. It was not something intended and is
contrary to how the rest of Git works. Presumably nobody noticed because
why in the world would you set it to false in the first place?

> Is it standard to indicate this with the existing “If set,”, perhaps? Or
> should it say “enabled with any value”?
> 
> (+Cc Peff)
> 
>     format.noprefix::
>             If set, do not show any source or destination prefix in patches.
>             This is equivalent to the `diff.noprefix` option used by `git
>             diff` (but which is not respected by `format-patch`). Note that
>             by setting this, the receiver of any patches you generate will
>             have to apply them using the `-p0` option.

We usually use "if set" in the config documentation to refer to options
being set to the true value. So I think the documentation text is OK and
would match the code, once fixed.

Kristoffer, do you want to produce a patch to fix the code? I feel like
finding it was 99% of the work. ;)

-Peff
