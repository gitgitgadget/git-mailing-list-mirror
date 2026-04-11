Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BA146A66
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943736; cv=none; b=C0Hk1bXb0Ha0gw/80q64vS9a9K7cVlWVKxFw3aRYXsXdTaqGwa12r1WvyibSnmewQpGMBBhTjwYvfdc0xJVvLsbu7mnVYnB7rUSHg0cBnkl9JmvCa4X+F2sPDEvCGhWk+oXpby7Gej/RbO1jQzWWfyi//je2loIvfLIbqt332Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943736; c=relaxed/simple;
	bh=BAabzkC8mTnRszvx1N+u+H2+JLPY5MKz5hkrpSj4aLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL6evuQgr2/y7HFobH854j5xu5ApaFXTPgcI0w+WSMJ13ZiLgBG78jw1ZMEPlRpnw9y322h6clxAvVhURgPAgk9Ql9IfUPw5xQWqx3bUEkSr+uwe/IxvAOZeRAIIuX4rE5VmfFiGcOZ7SUtqehPvvsZ9ZJNpEb/FJ3s3gLibFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a2KmDlli; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a2KmDlli"
Received: (qmail 319255 invoked by uid 106); 11 Apr 2026 21:42:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BAabzkC8mTnRszvx1N+u+H2+JLPY5MKz5hkrpSj4aLw=; b=a2KmDlliS2m+H8RCVMNf6dn/B+AACwx7gwwV8UkD1Lq0rXCN9gjL7D5+Knp6FfO+6NG6zzIDcZv+2oGVVALJfED2EjZ3Srds5wsFR+gfyQyFBrMTESDK9pD4Omlgl6m6x6INr5U5W8DWtu4KXWuiFQdo1EXFJiEU7zDOR5TmngjkryE+6zJHv+cDzWk5dTwbcCpqHT996CniminT7Aa2UGHO1Ldu8idl6UhtNc+40Pwl14YMOfq73L53Uo9HEoUMLf87mZrpqIFC67C/XvrqVATz0xY8qxXcatt/vthu/DgHBqCes08g0j43mMwHrl7P/V7lvC9gFMTQQOdl1nvNvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 21:42:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 527075 invoked by uid 111); 11 Apr 2026 21:42:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 17:42:13 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 17:42:13 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitglossary: fix indentation of sub-lists
Message-ID: <20260411214213.GA1563438@coredump.intra.peff.net>
References: <20260411190625.GA754966@coredump.intra.peff.net>
 <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
 <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>

On Sat, Apr 11, 2026 at 10:47:34PM +0200, Kristoffer Haugsbakk wrote:

> But with `make html` there are some `+` artifacts:
> 
>     + Glob magic is incompatible with literal magic.
>     [...]
>     + Note that when matching against a tree object, attributes are [...]
> 
> This is very off the cuff since I have to go now. So I might be missing
> something/made a mistake.

Hmm, I don't see that in the HTML when I build with asciidoc. But if I
build with asciidoctor, I see it both in the HTML and in the doc-diff
output. Yuck.

> I think the first thing is caused by the context already being in an
> open block?

Yes. Looks like asciidoc learned to handle nested entries better, but
perhaps asciidoctor didn't.

I think I've found a workaround, which I'll post in a moment. Thanks for
reporting.

-Peff
