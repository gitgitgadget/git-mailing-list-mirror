Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CB33EC
	for <git@vger.kernel.org>; Sun, 10 May 2026 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778374100; cv=none; b=cVE0P/O/R0r8yX/myh+UaWcd4no7nhVwyJdy4cglL9//i5gRZm4Tq57LuvU507qYTjGpp7AmhkmFMVoQ4DK6Ncj9Sewtwft7pa8s5W6g5M9+3LNQR+fCAMjsiXuS5kyepGDPfcwXyBC49e38mImw9CsutnFHihOHmlfZjdXF2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778374100; c=relaxed/simple;
	bh=W3M4nNON4yxKLpf0mxu5/mtMSwiy+x0CRbvaxA4r51U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCHfi4hvkLhNTqn3bGkvH6p3ZYkKHmpkwZos7i7gSpnj14ktZKlVTXvlsZ0FosHeGX5YZUCZqAswA5JvxMrOR1n008BGpPuuyIC72oOndiq3T06+b0uaeydMaXDUI4FElInxjEWMkZmjwYFbXa3Qi8YmtJAQNjQBeK/guzHn2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=drX84itI; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="drX84itI"
Date: Sun, 10 May 2026 02:48:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778374096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZdo43tE+v/hMoe4DDEtO5QuQQ1F5PfqzsMFPDDiL4w=;
	b=drX84itIzurL1n/dx501uicFFEYou/Dlt60N3cg+SdpleXYf6lkmwFfr2UKxPTYEZq4PxH
	uPvb67pK21fshTxCHV+3IfFwfsu1MnwK9hR8DwVZSWYP26u28mezEuLFSluywYxwNk+1Wn
	Gs7eVtlIkdxWNHsBHaXvE/9CnO1d4IDUs5v60n3+0YstKlRImchwhELfVFdGncuW8mk6Yb
	ZV+yU0zgzGMML796GHfo2GGUtVKs/1uGjG1bTPe3/esPASMoSt7DUO4Fl3KdboQLqlWFaD
	ilbBB8eumBIOx5EpU77j2GeHqjagrJIv11TtQoU9frtJW17o4rohYe+Gpyv+Fg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
Message-ID: <af_UdLh68wcDURf9@exploit>
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
 <xmqqcxz4b8mc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxz4b8mc.fsf@gitster.g>
X-Spamd-Bar: -

On Sun, May 10, 2026 at 06:01:15AM +0900, Junio C Hamano wrote:
> Saving this message to a file and grepping for a tab finds nothing,
> which indicates that the patch seems to be unsalvageably whitespace
> broken, given that most of the context lines should use tabs for
> indent.
> 
> What did you do differently this time?  The previous rounds did not
> have this problem.

Ah yes, I remember retab-bing with expandtab while writing stuff after
the commit message. At the time I must've not realized that it retabbed
the content of the patch as well (and I didn't even end up needing to
retab). Sorry about that.

I won't resend v6 as it will be discarded for v7 anyway.

Thank you
