Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10ADDC5
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153520; cv=none; b=G/7Q1ZepOP6YRPs6u7N2nICYdlWoduIeOAd2FHdOTbm1ngXsXA6xedQAviARIOabpGrqYpg9xCUlBn7rpbcmhvxog9/KmkSv2FT6PAcKLd+kOfQq6qxQmrcfm9+q+VwBp/ES+pnkGWy3AFfvSTsFG7WtNwm1LqTckVHir85usoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153520; c=relaxed/simple;
	bh=6xJvPSUnMU4cLVZ3Q9eyLpWmo2Mu9Yxfww+yFgrUpxU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ik1vDHcRtvEKxliFRV9F2Q+BbLi9pFUWlgXySI4yOW3IIr7FO+dpgOl9W4GClvlYQoAXHxnWWwceZLYalufQO0KiXvN9eblHHDGnwIXSvVfDYysLriiI4SpoLafLwj26DvV/spJUfcwCfIUH0KcrJ68MoN7ZCaYoDjkyNKtKFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hmETGZKh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hmETGZKh"
Received: (qmail 15812 invoked by uid 106); 19 May 2026 01:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=6xJvPSUnMU4cLVZ3Q9eyLpWmo2Mu9Yxfww+yFgrUpxU=; b=hmETGZKhesD70ID2JX07eRPEa3V+m1uyTxb3D/Up6uZWLtZR56rw9m1xQUsjSq1bzARlh27BCXn98iJht0aqeoP3gYurmPJkkRN4wdypD+60dpzmnl06kVRPOLgewkYjHmDx+LVeONWjy8S4vMVuVcDIheQbLBuSOJ8R5Rb+YP9gBeySGWRX54tY0+smnUI/3tXZ2jg1cOCkO1RCHwOUba4lWGJ+S2L+myX+0nOFVmIYrrnpGrzSL7RpsmUq1SxhYDS+E8uEF9zZT2IEhzsruEBu0N7WGEmekldflQ72vsEL7DRnMnm+0G9d8Pk4CSwfnR5MXMCIRh70Ks+o0YUA5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 01:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38799 invoked by uid 111); 19 May 2026 01:18:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 21:18:41 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 21:18:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] small quote.[ch] cleanup
Message-ID: <20260519011837.GA1615637@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I noticed some unused code while looking at an unrelated topic. So
here's a small cleanup.

  [1/3]: quote.h: bump strvec forward declaration to the top
  [2/3]: quote: drop sq_dequote_to_argv()
  [3/3]: quote: simplify internals of dequoting

 quote.c | 21 ++-------------------
 quote.h | 14 ++++----------
 2 files changed, 6 insertions(+), 29 deletions(-)

-Peff
