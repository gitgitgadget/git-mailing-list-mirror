Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B031BC86
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062792; cv=none; b=CsN3KF8Nk5AM1i1ywB4dmfbxTRRemwPMY5va9ey0Y/6VppdH3sWp/Pgj6t0KLsnLgFOITTQQbPt1+E5HfVDmoLIw1sliqy+X67MP0wB1iWMxRisO/1NBxr1LaAyeMhl6DH94zKvYuhKicq/AmLZry2oLTjVZkxQeMwSMPrujQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062792; c=relaxed/simple;
	bh=fthWppYe+OgHLkXc4Hze8pFaWTC+ghQSI7VQv9Vr87o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDETqD3m3a2hNU44sTCCa2HWr1AXWTp+J8o+YfJ+1qkJza7AZijS3x3O+p7CR3fJLiuQQZ/qbndMgb8YzGlXrn++I1Whm+aMZQe0TVFO/mp5v/vU8R09Jce7ANrhQeq5qboAwHooX+4l8LpuiEFJuEcJmNQqo6FsZ3nqqGQ6DPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B2EJK1Py; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B2EJK1Py"
Received: (qmail 103048 invoked by uid 109); 16 Sep 2025 22:46:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fthWppYe+OgHLkXc4Hze8pFaWTC+ghQSI7VQv9Vr87o=; b=B2EJK1PyjxENqXsReRPA3bBe/JKh4mKm+kZWZNKzeJRXUhuWpVwvtBwbIgYOAunDsq7rhlNjcXDdP19T9QwWxvWKr8rBcfT/LaVMtULXu1tX/Rh498Sp8Bo9P7SKIvRgFPlg6clUCP0aYvRekyh9sArO5FQX66tr5gYto2SL6eVz5OxduVyczvj6g7+3DWkEElsZN8+julU9ReAhV7UgUksfMxaIx++JVPyamK1vpKaQvSyyw9cUV+rUmoObM3hbtigi4FvqnvzuhXIYxBDRl/DaTQ308MJZdydQivejBqp3tW1Z4qr+K+zwOtPN4N44rCc8eecEplwZBnbTsnk3Lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 22:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 168110 invoked by uid 111); 16 Sep 2025 22:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 18:46:29 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 18:46:29 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: t5564 seems to be failing on Debian unstable
Message-ID: <20250916224629.GA1182621@coredump.intra.peff.net>
References: <aMnjKgAcad9_I7qK@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMnjKgAcad9_I7qK@fruit.crustytoothpaste.net>

On Tue, Sep 16, 2025 at 10:22:34PM +0000, brian m. carlson wrote:

> I've recently noticed that t5564 is failing on Debian unstable like so:

Try:

  https://lore.kernel.org/git/20250827080702.GA3572995@coredump.intra.peff.net/

-Peff
