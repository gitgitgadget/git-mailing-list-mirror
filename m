Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEED51C35F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159380; cv=none; b=OzmDVVbRHkt05vPptbOCiCTTRccVYs5E6jlPw06QXJ7qE5vlKHp0h2NYAdxI37JsdnZdtg3wDQPfevHGuvQ7n2/fUSd8nJPl9rOsMe1ZBX57WE7p3tb1ieHTh9eJvULWvA4rz7Cq29VUCSmWIPClmZetRB5dGgyuZPu0cdpnkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159380; c=relaxed/simple;
	bh=6ZyttlDMFZp6zd3HqDDxzujKxOoar+QrwJJdQxNoBwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbYchXVciDJHc0XO0aQzJdlQkN5WxM2X+3T1AgZVkORcexowvanArgbukijZv5YtAo+QvWqi6ANU/pVCSTkUEBfN4u+9vInqfSXQPHoZwGLunNrcz/8FRpp+2H0tq3xbsTKBSYKHLwOXNdRdkeGSOoeAXBMSuouvjNnmbX7SDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dDrlvInu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dDrlvInu"
Received: (qmail 35772 invoked by uid 106); 11 Sep 2026 20:42:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6ZyttlDMFZp6zd3HqDDxzujKxOoar+QrwJJdQxNoBwI=; b=dDrlvInu/eQm9EHvcgzViF0LSBsm++VqkKQ8tPV99WYek9UI8xv8ds9lLZv+2cMul3mEZQ72fRTsl+EYEj/PlyCxaHLo8c9Sow/A/S81QwWpBZCrdi7GtGYb9NgAVqc+vcngU7cOYXtvDfs9T2YISMS+2aRzslOH7DD4vUSBOlaUFHK/m1IGxi3r4ktuwZiLtVO8tXkFQr+uQDl8DUpDZWuBRwkmv2nVcDkwxaXZgH5V5uqGI+bmm+gsfbj0aGZj+mAPDje4txkeABQZkuQZXLVhC+9lyu6nL5bp88i2wN6sYw99aD+yvk2psGqc4+xy6pv9SLyZsPVS4D9kc0OTXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 20:42:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 176026 invoked by uid 111); 11 Sep 2026 20:42:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 16:42:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 16:42:54 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <20260911204254.GB1622087@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
 <apfWhYF6nmcFGKE3@pks.im>
 <20260902090146.GA1791728@coredump.intra.peff.net>
 <apfzihj-1YAhn5lT@pks.im>
 <20260905140217.GA3914642@coredump.intra.peff.net>
 <20260905152300.Zo2Zl39n@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905152300.Zo2Zl39n@teonanacatl.net>

On Sat, Sep 05, 2026 at 11:23:00AM -0400, Todd Zullinger wrote:

> As none of the CI jobs are installing documentation against
> any RHEL-like targets, this doesn't matter much.  But if we
> were, we'd need to install the 'epel-release' package before
> installing asciidoctor, perhaps something like this:

Thanks, that's good to know, though I hope we'll never need to use it
the information. :)

> I'm happy to see more Asciidoctor support.  It seems to
> produce moderately better output than Asciidoc, in my
> experience.  Though I admit I haven't looked closely at
> Asciidoc after development picked back up a little to add
> Python 3 support and keep the project going.

Yeah, I think we were ready (mentally at least) to transition when it
looked like asciidoc was unmaintained. The dual-tool system does
occasionally introduce extra work, but I don't know if there would be
downsides to dropping support for asciidoc now. Presumably the biggest
risk would be losing support for some platforms, though in general it's
not the end of the world to pull in pre-formatted pages on such systems.

I'll leave exploring that for another day.

-Peff
