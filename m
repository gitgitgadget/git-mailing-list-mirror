Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FA3C1092
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370512; cv=none; b=Z3aEZyD2H3UvOjXkJwaqVpH60WuEtCae3pDuURdMTBGH8xIbZYiVo6QHnZfViJYweJf3Wi8VyloL4PyfSF/9n+ZYKgeApoWU9L2O7hVV4UdGM3IeDNPWFHbkCuvZsZtwJtBhyurbFv9kb4tXGWZWiBrNJOryPdS7UVNsUtfkeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370512; c=relaxed/simple;
	bh=HpPq/LfL8sVAoRrVeItdEMh0rfAMKpV+6BMwG1oCWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz432NeW0IV1Jbz4lDKkj4fE2DMRPGYVlO5ZmF+IR8wkLbklX3/UyMXBIOG2meG6f/7ozbIxGk7/FHju5aqQQjsGneboxwmvXP2ec9EjXYB2rL5m99wjwuBmA12iuNUNXwqeYayDNwEOh80CJunUc8EkIdW3s4bc0sels5krDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=nEvXOpGw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="nEvXOpGw"
Date: Thu, 25 Jun 2026 14:54:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1782370506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/Zm3S6fVLOydGgZmjLPXMXrIMezexdRpoV0Q+XSmg8=;
	b=nEvXOpGw8dKOKYj9zzGPJj/MdwHDSGRONIPq4EXY0L9/i9Oq7LYn6eXgI5W3KfphscR4fg
	JTUhislg8wHWaqwkXOBOjdhrSjpmHDnADe4sCo1G1l0GSLTf1Pcyz/5PcdeOQhvTwnRqN5
	arK5STRVykk04QDWUKUXcYZh/LwHFo9/VSZ2Eba61t6n1AOx3jwsmD/zqqVIJFnbyPedzu
	ElQgRLfJR37GMo3cm43Rj1ianoLiwiZaP4doHBkQ+7tBVE6Myignpuso/TWx740dP/oQsO
	r8tknWdtDWpxfSanwxQZHcHQIjqo9CM9+Kbyhxl7SGy+YI+jtOdCMg1kWLF5Pg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/2] doc: clarify review replies and reroll timing
Message-ID: <ajzQwzimL22iPzAN@wyuan.org>
References: <cover.1781714757.git.wy@wyuan.org>
 <cover.1782028813.git.wy@wyuan.org>
 <ajvDuUiDsmyf5LnX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvDuUiDsmyf5LnX@pks.im>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 24, 2026 at 01:47:05PM +0200, Patrick Steinhardt wrote:
> On Sun, Jun 21, 2026 at 04:04:36PM +0800, Weijie Yuan wrote:
> > Changes in v3:
> > 
> >   - Reworked the substantial-rework case.  Instead of suggesting that
> >     authors send a new version sooner, the text now advises authors not
> >     to rush out an updated version before reviewing the larger changes
> >     carefully.  It recommends replying to the review that prompted the
> >     rewrite, saying that a substantial rework is planned, and pointing
> >     out which parts of the current series will become obsolete.
> > 
> >   - Dropped the advice that a topic close to being accepted may justify
> >     a quicker reroll.
> > 
> >   - Removed "how close the topic is to being accepted" from the short
> >     reroll-timing guidance in Documentation/SubmittingPatches.
> > 
> >   - Updated the commit message of patch 2 accordingly.
> 
> I'm happy with this version, thanks!
> 
> Patrick

Thank you very much for your review and guidance!
