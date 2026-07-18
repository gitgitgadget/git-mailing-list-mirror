Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21778385D8D
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363911; cv=none; b=RfRiH3YwVX6/G2gMUtiGsl4yijFTSQx31/FvQWroOzax0zNHO3M+laXxwxsoh+Y2PKsLS9z6htFeJwS5PrXRvgre73b/iFedjQkes53I7kbPBolHPe9srZpvCUXxpYVfKr+zh0DKGKv/mjbIyVAA1KucAhcVhLzLNvh1zviIjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363911; c=relaxed/simple;
	bh=vgL5k/5q3X63EeDOzCPWuAmbefei7o4qWVPy+QVsdNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTQmq2nCWl6REmQptd3UdF1k5OxV439ygLS1BNzMweScofACIDfhGqVUMQ9A2fQ7oliQkkyVNlIT1YFsCeKFtS9XfqL+DJl9/OjVsZJnct74+9RSikR23CqOaub4ut2IhplgYLOxRCilli9kNZYJQyOw+UeyxYRxB/c9E4QgqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E1pUd+EB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E1pUd+EB"
Received: (qmail 60640 invoked by uid 106); 18 Jul 2026 08:38:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vgL5k/5q3X63EeDOzCPWuAmbefei7o4qWVPy+QVsdNc=; b=E1pUd+EBfBSCdhl1gA5v4irRTzQ8noaxYB0ETFgC/nyfFJqYe/IBPEVCFmviWfRlzdFVfc1iELsz4gvno3fS6XymD0A1mNckgXudy6HX92KmdfWDenaZYFsphGhMUO/YBUl11Ll4j9+TuZHLZjet5h8aquUPVVErefXC4ge8KhUNkF8JoYFySeIJC/SbBFUkDcMDSTFkb+uR7bVioj0/VpYR9wHOC0O4JNEy4YxrmQAwdJ44oi9S0tJc4jgcEP7UMzm4gy/ecLrSBt1XYdehPHK1IrgoU6pqP6Llsj/TC+LY1cbBswgdUK1XujybR/iXNIdhVr7hEUe3WGxl29v1PQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 08:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 107135 invoked by uid 111); 18 Jul 2026 08:38:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 04:38:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 04:38:28 -0400
From: Jeff King <peff@peff.net>
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
	stolee@gmail.com, ps@pks.im
Subject: Re: [PATCH v3] wt-status: avoid repeated insertion for untracked
 paths
Message-ID: <20260718083828.GE22588@coredump.intra.peff.net>
References: <20260717144620.259031-1-sahityajb@gmail.com>
 <20260718081449.26747-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718081449.26747-1-sahityajb@gmail.com>

On Sat, Jul 18, 2026 at 01:44:49PM +0530, Sahitya Chandra wrote:

> - Reword the commit message to explain the quadratic concern while noting
>   that the current sorted input avoids array shifts in practice.

Looks good to me. ;)

-Peff
