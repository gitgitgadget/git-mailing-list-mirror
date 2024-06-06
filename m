Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA0E573
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662780; cv=none; b=I2JvKg7wuuFrdoyfiQkRed76E+V7buKXXi7MPFIbOlGPxhwRKbjzGA86wHw4/qZVbfuBtJl/F+B7/9j1sl5RcXE0N8mhzzcRvtv7F3dhD7g2PWUOcP8X29Uuh5j6C0X4jV5AL0Pn/eQ3+yR3DDRwQcZX6o5VWQgFXLuFS8xJTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662780; c=relaxed/simple;
	bh=0JIno6jYu5cJUkCoNIpeVX/0XG7rvZqgq1g9zLjBSyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3l6Ww+sna88mWTkoDGzivD0C5gXv1PJo+hr2Q4YAHcg/Qjgn/bnil94ue2LSyoYmGmhbW5IguIrTDfmgGhEjvszikTSzJNqMOCDFBMCr3sbvZpFnikPEOaSc/ATD19HoNhwjCtjINOVM0d0o0doAAhTocY5tygINogtMjfx180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11289 invoked by uid 109); 6 Jun 2024 08:32:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:32:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6785 invoked by uid 111); 6 Jun 2024 08:32:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:32:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:32:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-i: finally retire add.interactive.useBuiltin
Message-ID: <20240606083257.GF658959@coredump.intra.peff.net>
References: <xmqqikynqdvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikynqdvq.fsf@gitster.g>

On Wed, Jun 05, 2024 at 02:27:21PM -0700, Junio C Hamano wrote:

> Let's remove the warning and documentation for it, and truly stop
> paying attention to it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>                ---
>  Documentation/config/add.txt |  6 ------
>  builtin/add.c                |  6 +-----
>  t/t3701-add-interactive.sh   | 15 ---------------
>  3 files changed, 1 insertion(+), 26 deletions(-)

Looks sensible, and the diffstat is very pleasing. :)

-Peff
