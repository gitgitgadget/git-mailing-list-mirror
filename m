Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586A52F99
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675256; cv=none; b=MnEDdoVWOHY9Xpp3zi8sVo9woku8mAoEhd2EiCNWVKV5CnLr/7AreyjUR4ttXzbKsB+s0+NYIHPfx2ESxPETL9QBsdydq84l+kJ2o8MSn/vqOuIdC03F/SqcZ/jFsgHOGzQxBp9+X9hDSflOhItPJUx+ukSo2l7Kl5KyNbL4rY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675256; c=relaxed/simple;
	bh=Rk3JeamrdrGeys9QyXEUuXZvgTrzX57lzk1QU6yKiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQsTMuF3IH7eQprfM9RpaRTIKgqKxQw59IY6T5V13cDOF84k2KrTy76RE021MA03y/RxKBuz4h1c+w1Nb7Hjqr3+nARy6AO8NfBjpBq2ZLHZMdxIhTVD/gBjAmS6SZ/LR9N3BG2o6dh0SNblTzQxm5tHKefsiy9AtDivmVy4pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BPZ1RGKd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BPZ1RGKd"
Received: (qmail 10714 invoked by uid 109); 24 Sep 2025 00:54:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Rk3JeamrdrGeys9QyXEUuXZvgTrzX57lzk1QU6yKiJ0=; b=BPZ1RGKdmXXVsXiIlN8IC7ZpF2DhQxinIhf7NHLVQGTqRyj9JkkloDpiETlmeM7ndtLiRJMXSH2ZaI8AuYDidAH2ya6n/EzQgqNo3nkeJ17Ncv39QT3QT9zQ6sIQUCsubgESVb1nTEqVz2m2bwb71nZDew5iGpSJZzMvziBMI+ACiSEyVld+qOuddS+Vc9NELV5Pzyx75CMTG+DOV+tew4cwnKxKtRvCQIVZXYVzMdck8P/sGC8IDfxwyu5MhQqhsVgdp4MSseXf9zoYhJ0SFdRkI5/zqWHad3o4ItmIHpZgM9gJnW2/7d2tmMBXUXuSgQtXbAdhV0vjnKrjYvBTxA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Sep 2025 00:54:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16600 invoked by uid 111); 24 Sep 2025 00:54:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Sep 2025 20:54:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Sep 2025 20:54:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: doc: config/extensions.adoc: line continuation syntax error
Message-ID: <20250924005412.GB1142438@coredump.intra.peff.net>
References: <a6e4e995-fc19-465d-bd7a-c002bc0db31f@app.fastmail.com>
 <6196161.lOV4Wx5bFT@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6196161.lOV4Wx5bFT@cayenne>

On Tue, Sep 23, 2025 at 11:08:10PM +0200, Jean-Noël AVILA wrote:

> Indeed, open blocks cannot be nested [1]. But, the first open block is not 
> necessary as it is a workaround for the missing knowledge of multi-level 
> definition lists.

We've run in this before, but I don't think we ever came up with a
satisfactory general solution.

You can find one more case with:

  cd Documentation
  ./doc-diff --from-asciidoc --to-asciidoctor HEAD HEAD

and searching in the pager for:

  /^\+[ ]+\+

which shows added lines starting with "+". The other one is in the
pretty-formats %(decorate) description, which is included in a few
places.

There are some other hits for ASCII art, some of which I think are
mis-rendered. But that's a separate problem. :)

-Peff
