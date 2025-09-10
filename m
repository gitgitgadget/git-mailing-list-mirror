Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21F366
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519404; cv=none; b=Cg0F74oY8TvVqH6/pySMl+ffSYDjbdEeQc8ZAADhs0h/ifl/JyVOb66V26g9Kqtu7Ijz5gNJ0p/XkazgLjCHnG/yuozVernrpUfxYFOV+uUUq2y5bllc8+5Eq8VUMLNgjfZFCVgSuOnMY2/gZbeNhhFrxIieSNI6b+4WVFQs1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519404; c=relaxed/simple;
	bh=vGAHCb1LVfSqdXGxRVEfLKrEZildYLJjOk39mXUsL/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfL55GxY32PmkwmBFeKIJW8Gszdfpg5r/aYNVnlvIOG5kohrc7QtynJDUQ1G0dbeNw0J3zzdCyAD2OP876qNj/MyFF2Mc3RIrsFSURrl1b6PU+iDhM26ra+zmirH/UuOkIECY5t+OUptGugPdkU6K7hHp4sdwE8lft+5bI4Yw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NoRZsawT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NoRZsawT"
Received: (qmail 41735 invoked by uid 109); 10 Sep 2025 15:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vGAHCb1LVfSqdXGxRVEfLKrEZildYLJjOk39mXUsL/Q=; b=NoRZsawT5LQzXvJvNFXQ+oRZ/rEQktfz/2kolz8xLpH2gWpm4Xz0zov1/FimNuxC2QRNvKN9dhiHM1F36fzWuM54bUJUe15XBQCKx9hi/cotVxSLpB/GymQ6vBuDptkWv/gGH3mFH5fYA9vR6xrGsUE8crLq7Ft+tcoCym+AaGz2aVSuuPOWOl5mMDxEuLelJYV11k/bRVISdOv3TTeUGUBZVaGrAazfKIUlFDxm10nB53bYNNXA9cRpQ5SwsblBKjFv8nMCF/SNKOicI42eordS2+X/FJyH5GKVwwAqNtB/mI4dOq/XAzOz0WVOmqRHQySp4W1X+UgtLTAYumYdnw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 15:50:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67892 invoked by uid 111); 10 Sep 2025 15:50:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 11:50:01 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 11:50:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
Message-ID: <20250910155001.GA1134782@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
 <xmqqjz27ti6i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz27ti6i.fsf@gitster.g>

On Tue, Sep 09, 2025 at 02:44:21PM -0700, Junio C Hamano wrote:

> Will replace.  I guess we can mark this round as ready for 'next'?

There's a small leak issue in patch 2. It should be a small fix, but
worth doing as it is caught in CI.

-Peff
