Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EB20C028
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400248; cv=none; b=qn4ZG4mjFUocW0fVBDroYv7znuJQ9ENGBcPVoPL/0Eme7ldcX0cbzYaOIqWY+5yi421EXtG00yJbMuU289KAmkNAV7JKQXoPBf9xkdStuyhC2R2lvw81PJoh1H5TcorCcPG53yL90bpym2ZwOd6olD0PM78nxL4LFmiZNNlYb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400248; c=relaxed/simple;
	bh=7zLkn5F29L/E0v3V/Y0BZl8CmqEVrpKCcEQSV8Vf2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbG/pqjop38x+bvKRmYzz85RsMeSJM26R/IKi3cja0KPl4jV9IDIPKbM9/AtpaccrhB3u+zWON1gi6gQ7mB2V7GUeto1aJi1Cpc4c56WWXM7RFagkWjL7ceDK2kkrfiEniuGYs+tl3UTxNADyL4NVRjSvd4zrvtkOHhO25h3Fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g7CSFzUI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g7CSFzUI"
Received: (qmail 30249 invoked by uid 109); 12 Nov 2024 08:30:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7zLkn5F29L/E0v3V/Y0BZl8CmqEVrpKCcEQSV8Vf2Rk=; b=g7CSFzUIlI3rrWUP/bJ3qqLXyAOG84sxc7rt9aIs9L2OdJkob/P+rLhJDYCtNSnJ2urcvsa0wMJQMeFlOzgX25rq7FDf0s4ZrNilq2kW91ngGtMuKrL67jHXACjyc+Hhw1DBDIZcjbA4UMf5ncFJ5+LK4yph/s0GWvVn9BY9nqn4buQh+iThEEYOozx06sI0CLCnSYTH1Xa0mF8dlLUovivXviNPkCeiZkqwfljbky5zoC5RUeA61TEerxgM75AyorDQdHKhleFaZMxtYalZEbUfFgUSH0Y6cAF7tEvmKlhbnGWYGmXuvvQR0Sq60ih9YDiVDutBGdduGYEoQI2s1A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27495 invoked by uid 111); 12 Nov 2024 08:30:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:30:49 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:30:44 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com
Subject: Re: [PATCH v7 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <20241112083044.GA3393089@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1731323350.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731323350.git.karthik.188@gmail.com>

On Mon, Nov 11, 2024 at 12:14:00PM +0100, Karthik Nayak wrote:

> Changes in v7:
> - Cleanup stale commit message.
> - Add missing space in `if` statement.
> - Fix typo s/incase/in case/. 

Thanks, I think this addresses all of the comments I had on previous
versions.

-Peff
