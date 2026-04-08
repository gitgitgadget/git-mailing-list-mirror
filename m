Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F164C6C
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686496; cv=none; b=q0U0/VSwwu/HKel7xqVl4/AteHeIaDbzCMqMhMz8vJPEjilNugd5EZAmsqFlbIc35UbfSqmViX3foIoYUbCgg/+0EsJPtGi24aU/GZzawf5ZLW4NAaR6tSCrQ/TY225CEsd0z1RiwuwNqf0jDQFA0JFqmP020FZZngNGtMEG6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686496; c=relaxed/simple;
	bh=rIs++ILMvFFb/vqysLOnlzbHdhalqALhEKTbybrGVZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoFYygz2s5pz7JNc7eqjqtNKVgD3vOd2jg3etl0LKpHyzEQwJcPcMK/yytkWBToNBvzC785k/5xmK4A+LECiKlSiaZbdwDTMGz5gToMJWUgP6qbDwCs0Fpl0v/c+ggbLEGvpCuvTpzcCZCS591OxXYMRtftTDHixVSMXHoV9VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nb85p6z9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nb85p6z9"
Received: (qmail 286136 invoked by uid 106); 8 Apr 2026 22:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rIs++ILMvFFb/vqysLOnlzbHdhalqALhEKTbybrGVZQ=; b=Nb85p6z9EpZIVWfVXn8hvPiYVIfuspkcgnHQsXLXHxC5SXKLsYrAhjUSL2xbEKNS3rnJcFnkijytyt7xU9PL2bgxrF//xS5eL4pSluBkdW2F15cmmYtF7Wl+10fZCHX+oRdHsiQ1kFXA3HYcC1JOo+c3fO5FZhqhqlsmfbjLjsfOE2/5WBAKqerADa2f9JFvnD9cql6a3tyzxlgUOrTMxNqsBf3vX9p5ctwu0e0J1ubQDYXNXDk3U4sV10k/VXR4TpmnUWp/mbUcGGRY925S9aZ/l8phYb5WftLR1HNm6QVrzLs+XDCKmDZ71kxwe2/LFtJfhR03Qpgiib9+W0iNUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 22:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 469636 invoked by uid 111); 8 Apr 2026 22:14:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 18:14:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 18:14:47 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260408221447.GA2873736@coredump.intra.peff.net>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
 <20260408041716.GA1324339@coredump.intra.peff.net>
 <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <014801dcc786$9ff5bf60$dfe13e20$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <014801dcc786$9ff5bf60$dfe13e20$@nexbridge.com>

On Wed, Apr 08, 2026 at 02:36:27PM -0400, rsbecker@nexbridge.com wrote:

> On April 8, 2026 1:40 PM, Jeff King wrote:
> >On Wed, Apr 08, 2026 at 12:25:47PM -0400, rsbecker@nexbridge.com wrote:
> >
> >> This is also impacting t5608 and t7700. Anywhere where writev() is
> >> used, seemingly. We went through MAX_IO_SIZE issues years ago, instead
> >> of using ssize_t as a basis of how big communication is. I think
> >> writev() is not valid. It worked on Lunix, but had issues elsewhere.
> >> This broke the compat layer.
> >
> >I wondered briefly if the problem could be that we're violating MAX_IO_SIZE here,
> >as our use of writev() does not respect it at all. But the only spot that uses it is
> >feeding pkt-line packets, which max out at 64k. So unless your MAX_IO_SIZE is
> >smaller than that, I doubt that is the problem.
> 
> SSIZE_MAX on platform is 53248, so yes. We expected git-compat-util.h at line
> 696 to be honoured.

Oof, that is small. So yeah, that is almost certainly the problem (and
explains why it only happens for some writes in the test suite).

-Peff
