Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C394A5C57
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047975; cv=none; b=g6pInnrcv8juysMvtEM7cDDuQGNx8XiQlvzEcmEg1nfcckMvCIwz6nUjP9Xsu2RhkhUln0Yk2ggH7y8eXtu08WBHrqK/WtIlZHUcCzZ2JU1NRdfN3UKOBJ7maVwfZ0Y9hMcsgB4xEPIysSyJZbrvSp9RW3BQW9iAsCKx3fOjjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047975; c=relaxed/simple;
	bh=S2FAU2wPBNEWUMYfg18p+uhg1Wb/wW5bK7dQdcymKDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBRb0c81H5g2AcichOdEya76gNZJ58uAQQbO1w7P743K3CSebfKu36crISHPHR7uvuAJJNUo7Rt4MtZXuSe6zV4KJlHa+57QXghJ35qCM7xU7BlnYzNvJLqbzdpqOpmV5WMASj4Exul0TIzwqtW5asfvGxnSbBi71xbZDCkRCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dL4WFEZL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dL4WFEZL"
Received: (qmail 75295 invoked by uid 106); 15 Oct 2026 07:06:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S2FAU2wPBNEWUMYfg18p+uhg1Wb/wW5bK7dQdcymKDk=; b=dL4WFEZLpk4qLZsriLbewicS5upW07aShM9cToS4kgVfjYf3BhcKGOJMDlRVcluI6kn1j504I1c31gzyWbHO/yMLAVrCoZG8N6ZU0TXty4hTw2Y2c5yqZ/AGoP7huRndbZquk3Oy8os88bd+uZepOFhw4yW+q7yMAvjvm7J7JUz8q7lvPfvpMdM/6icqf0O1Huxsm/ckD+IiknmDpCUZN0HVnQKCzVft07grp1dwHWLZMW/e1eu612d0Zl88/3mqAFW5XSDEUXKunIZWIM20Oeq72F5WHPC6NX4AlVuMMDTsT7rxD/FCGnLem4+onajgV0x4VpdWxlO9CXzkCELXwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2026 07:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48807 invoked by uid 111); 15 Oct 2026 07:06:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2026 03:06:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Oct 2026 03:06:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v4 0/8] ci: some housekeeping and modernizations
Message-ID: <20261015070605.GA2556608@coredump.intra.peff.net>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>

On Thu, Oct 15, 2026 at 08:57:09AM +0200, Patrick Steinhardt wrote:

> Changes in v4:
>   - Make the test in t5004 work both with SHA1 and SHA256 by forcing the
>     repo to SHA1.
>   - Link to v3: https://patch.msgid.link/20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im

Thanks, the updated patch 1 looks good to me. I think all of my other
comments on v3 were things that were either non-issues, or things we
decided to address outside of this series.

So v4 looks good to me.

-Peff
