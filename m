Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDC193064
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434407; cv=none; b=KIngBE5WxtH3pXNpWMvLKm3C/iaOVglLo/yzvcVs3U7Cyl1G0sJg2bxOgdywq8tJTPg7hp+TyiQwlyo3LmPW/Y8mioMWjlK3DHC5EYMRcZmePdsR9GJaiwZBifd4wMLlNpxM1fplZGQzHdk0MdzoUdpqe5v3lA2ejS4wqg+3Gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434407; c=relaxed/simple;
	bh=Vlqzz5E81vbmoTOvp8w0OB4DBNyIz981BExG8nFLKKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNT2urse6u1p4vcb5dMU90VlkQaw72ei75QDX/Gl76Tda82+3JHqu57FPiEIhNQt+gGmnT97xCTDR0yKKCsfkI5eXMRgaNnUgrhSC+gXgWaNSnjtMz9RM/bHin+MNYQ4pht+kNsKAdrwEZDYYjnfNI+iAaE2r6eAEt4TjY+ITz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25553 invoked by uid 109); 26 Jun 2024 20:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25069 invoked by uid 111); 26 Jun 2024 20:40:02 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:40:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:40:01 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] allow overriding remote.*.url
Message-ID: <20240626204001.GC441931@coredump.intra.peff.net>
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
 <20240611075137.GF3248245@coredump.intra.peff.net>
 <xmqq34pjxzva.fsf@gitster.g>
 <20240613102409.GE817573@coredump.intra.peff.net>
 <20240614102439.GA222287@coredump.intra.peff.net>
 <CABPp-BEaFUH2QaAW+9B904cCN_h8oyxTaSDMkK=v_yZua=A1kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEaFUH2QaAW+9B904cCN_h8oyxTaSDMkK=v_yZua=A1kA@mail.gmail.com>

On Tue, Jun 25, 2024 at 10:44:03AM -0700, Elijah Newren wrote:

> I only managed to find a few typos in commit messages, but I looked
> through patches 1-8 pretty closely.  I only skimmed 9 & 10 -- I don't
> really have an opinion on the remote helpers.  I agree that the issue
> you bring up in the patches makes sense to discuss, and the route you
> picked looks reasonable to me, but I don't feel motivated to try to
> use or understand the remote helpers enough to form an opinion.
> However, I'm a fan of the cleanup in patch 11 that your changes in 9 &
> 10 enabled, so if everyone's as ambivalent as me (and 15 years of
> things being broken suggests everyone is likely to be as ambivalent as
> me) then I'd say just go with your changes in 9 & 10 and call it a
> day.

Thanks for taking a look. I do think patches 9 and 10 are the most
controversial in their goals. But for the reasons given there, I don't
think anybody will care about the direction much either way. And
certainly they are not making anything _worse_, since the thing they
disallow is already broken. They are merely shutting off the option of
"fixing" it to match the original intent.

So I stand by the direction I took in the patches, but I wanted to point
out that if anybody wants to be extra careful, those are the ones to
look at.

-Peff
