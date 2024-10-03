Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C212BF32
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989366; cv=none; b=tyvxnYF73xTGEsp/aR8Sa3ZBb7V+dotvOsbkzVCOgXxg5EyPcob3pgGc3ATvaGg7HD2Te8So0nIHDPjomxXDOWu1KDhakicPF8J8ykzzR0G4NeiqGNTzVnRVQxYV6DzGrrceRFKydYRvMXCKmw+po9Wxayfa7Js7G2jR1l3rWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989366; c=relaxed/simple;
	bh=uz9oVRCQDxLJEhGhHwMxm1OFIb+uli9wNYU3epVQMn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI9/JqnFTi7d2ppex0fJKUZqRJmE8OPHdLRI4r5M32cdHfXr+hMARTfjX/xe8YJPw6dVBhOLXxxZ4Gu5uUzxQNqtGcztc5dspLOzuhJeuF3DsZ6vjFshRUR8NpV6szRb+lnHWhLFs/EIGKE0dtXp+20On07vqMQzOlH0c2hqwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1swSy2-009p8y-2R;
	Thu, 03 Oct 2024 21:02:35 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1swSxx-00BFm4-37;
	Fri, 04 Oct 2024 06:02:29 +0900
Date: Fri, 4 Oct 2024 06:02:29 +0900
From: Mike Hommey <mh@glandium.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Fix unused-parameter warnings with NO_ICONV
Message-ID: <20241003210229.g4yzbs2xh276xmdk@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
 <20241002200140.2123584-1-mh@glandium.org>
 <20241002220118.GA2892418@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002220118.GA2892418@coredump.intra.peff.net>

On Wed, Oct 02, 2024 at 06:01:18PM -0400, Jeff King wrote:
> On Thu, Oct 03, 2024 at 05:01:40AM +0900, Mike Hommey wrote:
> 
> > The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
> > some non-typical configuration lacked annotations.
> 
> Thanks, this looks good. I tried to catch compile-time variants like
> this, but I was mostly limited to what we build in CI.
> 
> Out of curiosity, what platform do you use that needs NO_ICONV (or is it
> just a preference)?

I'm just using parts of libgit.a and don't need the iconv support so I
disable it. That avoids a dependency on the iconv dll on Windows.

Mike
