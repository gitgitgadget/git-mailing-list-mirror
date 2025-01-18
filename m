Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042E4A28
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737200577; cv=none; b=quuQfU/tTUKzSCfq1InL6G5VqJ+c7e/ns7ucYqGGnapZLJrUnpW9zDkQJzvHXlqz/Y4xtoqMvL/604Z79kI8U4MI7aVjVkegoOtLscoJaaxSsSAvS1ayU4wMYnXOAuBw+K3V+11FBbEO7iD95GJXqUT7VCpeycPhYr/FfPy+C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737200577; c=relaxed/simple;
	bh=QTrOdZdRIsyeIaqS9JxtYLKp9LMrUgV7ngACHA90WD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byUPtK46HuXTpnbr2jH9ivCAMTblXHrfJpalbx38Ly0e9++8GtA3yuk5TG8/CidN+jT2w384HIzlBzMsN4zcES1K8DN5a8JogvvkOItKwqUi8qFm7GZ5Q3WOdn4z02/O8xePXgMm8xgwZI+PJ4bcmIDmkx4zrCz2SlOmHOrdXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c75x4p+v; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c75x4p+v"
Received: (qmail 30942 invoked by uid 109); 18 Jan 2025 11:42:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QTrOdZdRIsyeIaqS9JxtYLKp9LMrUgV7ngACHA90WD4=; b=c75x4p+vWaJWcmL/nTP4Lfmk1Tah/j4IDjp6ULohDeP/lQNUn4AbIMnqeIRwnJqHTzkcsUW2MYxNfwjTFzuBTRLhLbv2Z93JKltcEgM/kyMGM+8BomG2/BXUHrn5LhycXRVm8YVPsX0MpdgrpbfXQWvTg+7bfLo7IM2kwa4veC8ROtQHOP+gZPwmUg3b7ovRzUhjnOCLhS1sOIxj05vCYi4sz74n5JBmo02yEqsKSz4Fh4pXJfaTtY4bT4tEg62JEuKLC/AL4Y/VnaO1+ydVVA60IyiAkIs396VqTp+ocNLcT/PR0m1xip0tzmGoR5gkt5UQsfh4+q39WUCAb2zi7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 11:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19796 invoked by uid 111); 18 Jan 2025 11:42:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 06:42:59 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 06:42:53 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Send help text from "git cmd -h" to stdout
Message-ID: <20250118114253.GA3510721@coredump.intra.peff.net>
References: <20250116213553.2563751-1-gitster@pobox.com>
 <20250117213148.3974552-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117213148.3974552-1-gitster@pobox.com>

On Fri, Jan 17, 2025 at 01:31:42PM -0800, Junio C Hamano wrote:

> Changes since v4:
> 
>  - vfdreportf() helper that took a file descriptor has been replaced
>    with vfreportf() that takes a FILE * instead, with Peff's help.

Thanks, this all looks good to me.

-Peff
