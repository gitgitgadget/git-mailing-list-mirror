Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE43174ECD
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347575; cv=none; b=VuUzWlzfZxvzx5lQQE0XQ49S11XvTyxb31Fju2ewm6WNy7xNahnXlQjRGwOUHhFTD0Be0VZQa6N86P/8uJ5UjlTi4g3C5CSGSaGn4/PxKn33LbYB6yOkDtwx0gkOeO0gzYe4T3+DmWOlN6qvZ/hrvGDyrcL0BqzzOxGak+OYw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347575; c=relaxed/simple;
	bh=RTiYeLHmoMd0TTFHjzX7F8uG3c1JEIxDaLnNBiTCzsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoEuTE2h5FtyT2MtxQPLIkKDiIhdD49ADGs694W0trFetEJ5JUGWv97zUSY0Vyhane0mnJz8SyrD/p0HZwFCA9f1xNvEr9HuoIQTrkqsJV7/dDI9f/pXFarhYg2HgzRz0Q4/g4thJOIQ26OsX8TLNQZtYL1QK5VHRTNhiLL/i+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20203 invoked by uid 109); 5 Apr 2024 20:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 20:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32234 invoked by uid 111); 5 Apr 2024 20:06:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 16:06:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 16:06:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
Message-ID: <20240405200612.GA3700619@coredump.intra.peff.net>
References: <xmqqy19rtygr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy19rtygr.fsf@gitster.g>

On Fri, Apr 05, 2024 at 12:13:08PM -0700, Junio C Hamano wrote:

> * jk/libcurl-8.7-regression-workaround (2024-04-02) 2 commits
>  - INSTALL: bump libcurl version to 7.21.3
>  - http: reset POSTFIELDSIZE when clearing curl handle
> 
>  Fix was added to work around a regression in libcURL 8.7.0 (which has
>  already been fixed in their tip of the tree).
> 
>  Expecting a reroll.
>  cf. <20240403032045.GA1559972@coredump.intra.peff.net>
>  source: <20240402200254.GA874754@coredump.intra.peff.net>

I think adding an extra commit makes more sense than a re-roll, since
there really are two separate (though related) regressions. I just sent
out a "3/2" patch in that thread. Hopefully with that on top we're good
to go.

-Peff
