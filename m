Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8492E3715
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640711; cv=none; b=BGCX3/1JQUxKLpvrzWz5zA1ZoXkkRaOZ1Hd10fKpohCDmOHg5hwrRijnxJeE53QvKQWbadNLgChV7HQcf1gKSGDAYjcWugbKwBWvfSOlhH/dIz7eXW8FHNJGGOtI3HKMHyXnojOekE3xaN5E9wWoi6NZZ3NPuZab+C48TI7Qjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640711; c=relaxed/simple;
	bh=3X0EqPGp9H0odp36wRP/8kf++rJ9ZVGMSNlux/VtiLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkJXbakVmxg9K+XExmPYSge8J/dx+zdWT3mgiDQ21ik6iXHM0PhI06KLzvVGKPJus9mUkhU8g9QywUQUHE53NkgAN3eiWjwD6q+X3tZ79Q+J57aD4Xg0us0qDsYurcBdKccYi4gVXe+qN1PJtpuQ0Fw3veBptTkJ2SaFZQ+Hp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aEkQQvgX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aEkQQvgX"
Received: (qmail 32690 invoked by uid 109); 16 Jul 2025 04:38:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3X0EqPGp9H0odp36wRP/8kf++rJ9ZVGMSNlux/VtiLs=; b=aEkQQvgXCM/54qS3CokG+yOqECQcy5mHSudxjaHp7B8G0hC4oHdws9Qy4XNuoWMqjwHc2CHZzUNRO3CDssC8XpjKNIyqwVjlD8/w+tzvZ5Hdvs50rMcOjcFaEhh/2FBgmmY7HfnRorFQgHDTigHwYZucfj1YtRTndrZN/2IWD/F3bSgY3vR9JX1t0hl5EYrx3flgno1vmjrUaadAz7CTEZHLXxQ75eyTL3+CrYUBzQH2PXJOtHz9S17W3fv8t52YzrMGg4XTeIShmHadsLNJfCdKCPTcAsDF4vd5nCPIIwXIHybYYZNqRK16RQKPZo8tBAjm8pIOtDwisK2hd5iQmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 04:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9212 invoked by uid 111); 16 Jul 2025 04:38:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 00:38:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 00:38:27 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
Message-ID: <20250716043827.GA1395459@coredump.intra.peff.net>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752587571.git.phillip.wood@dunelm.org.uk>
 <352f80c49b74053d611e7d64991fed1c16d857a4.1752587571.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <352f80c49b74053d611e7d64991fed1c16d857a4.1752587571.git.phillip.wood@dunelm.org.uk>

On Tue, Jul 15, 2025 at 02:52:50PM +0100, Phillip Wood wrote:

> Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool

I was lots of discussion about grammar elsewhere, but nobody seems to
have mentioned "Guildlines" instead of "Guidelines". :)

-Peff
