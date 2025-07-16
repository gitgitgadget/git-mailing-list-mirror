Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C011CA9
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641222; cv=none; b=RNrbbtf7yEy1xfvDubduHpzBa7oIGxjKFyZR/IdtLvmBQJ87hkTfo6/8hJ8VpE2BjIiHaJpXXzmvyfGUutdg5KBMQ4Vwp9o6/eyRNT69lHF4P2jEDGW2d2s6SDJv03UDkOtTwvCCKT04ai8+FRjAORKfcbO66QstzUYsuGdv5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641222; c=relaxed/simple;
	bh=mdkb1BGeqWjMRaXjJK+faCfvhwDxqjNZMrcKGgdGZ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax2zD4pdjANQGc4sYXl7SxlO0oxkE0A1VaN5XqCCuuk67xZXeE3dR79Fl/JloCbHZrpfd9LI1jsOJ3noENFIu17HtLHwAdRIbvQJKLNF3Yolqcjj99u+0IUvBVHcaGoQY3kIi72Gy8BSVlAxeeuWiJznVjIl4oZVklLQyfJldmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=clT/526A; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="clT/526A"
Received: (qmail 409 invoked by uid 109); 16 Jul 2025 04:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mdkb1BGeqWjMRaXjJK+faCfvhwDxqjNZMrcKGgdGZ14=; b=clT/526AufI/jmdSL2DKyzaJ2Jry5by+rS7rW+qIsnLxoCciddcA1qJ6CZRg/L/FEhpfPPMUq9zFIKBTm3GWovqqcXNI9WiMD4BnSs7ADecx0IE9QCqHvo0OCFeECCdgiYsoqxkLrK5ZBAUSWLdWkjQQJaRiVd8s8wWszmEnUxx9fSHUTYhOz1mOm1NFpK3G3w/iVPMjOuXwC8W0qOX2/uqGyLg/6PjmvUcJEjwHXFJuccx9WT3REhvzxUQ+x5Eu0/4FUc4UCBPL83qJN82S90uYM/25vdBGLgiTrP0gJktl8Ulv5/ryfmEUWNZf0cYlBQyY3iAZm8juxF0NlVVA1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 04:46:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9369 invoked by uid 111); 16 Jul 2025 04:47:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 00:47:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 00:46:58 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
Message-ID: <20250716044658.GA1396022@coredump.intra.peff.net>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752587571.git.phillip.wood@dunelm.org.uk>
 <352f80c49b74053d611e7d64991fed1c16d857a4.1752587571.git.phillip.wood@dunelm.org.uk>
 <20250716043827.GA1395459@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716043827.GA1395459@coredump.intra.peff.net>

On Wed, Jul 16, 2025 at 12:38:27AM -0400, Jeff King wrote:

> On Tue, Jul 15, 2025 at 02:52:50PM +0100, Phillip Wood wrote:
> 
> > Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
> 
> I was lots of discussion about grammar elsewhere, but nobody seems to
> have mentioned "Guildlines" instead of "Guidelines". :)

s/was/saw/, obviously.

Surely somebody has coined a name for the law that any statement
pointing out a typo or grammatical issue is vastly more likely to
contain one itself.

-Peff
