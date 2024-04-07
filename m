Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C763BF
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452141; cv=none; b=BoPdDNYE79Ngs9+Xuqg+5SrHDxNY5pyBcwYvamXe0XZZ0E6TvVYXY3xs6/Y6n4QOmXx8sU99xD1Ezr4ITN31jylxLl85DxxLYXZhPGOGrqTGNap4dcPZ6TZwN+CkRcz6KBGT+SHLYtwVXv0JWrom5t0XFiJbUJbfdxa8nPwUDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452141; c=relaxed/simple;
	bh=aaJw9Ind56U1LHu+a6IBnwTN5otDghqAUaX8IQdSLVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piUEXHt+1DpRTFpeJFdXRJaSDKTHV4Vo6ea27MISjryoy6Xk9CpzqdgK2zuo083ealq+dpb+KchoX6VypPd62SoCKe2xu3XO4zS6lJmTAE2xsdtCALTptf5JBvm9fu1tGJR+4yCtp+o7jbL2tG5O3YIRQGmAugfRUceAnV40MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7513 invoked by uid 109); 7 Apr 2024 01:08:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:08:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11360 invoked by uid 111); 7 Apr 2024 01:09:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:09:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:08:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH 0/12] git_config_string() considered harmful
Message-ID: <20240407010858.GA1076556@coredump.intra.peff.net>
References: <xmqqttkeicov.fsf@gitster.g>
 <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

On Sat, Apr 06, 2024 at 08:56:56PM -0400, Jeff King wrote:

> Subject: Re: [PATCH 0/12] git_config_string() considered harmful
> [...]
>   [01/11]: config: make sequencer.c's git_config_string_dup() public
>   [02/11]: config: add git_config_pathname_dup()
>   [03/11]: config: prefer git_config_string_dup() for temp variables
>   [04/11]: config: use git_config_string_dup() for open-coded equivalents
>   [05/11]: config: use git_config_string_dup() to fix leaky open coding
>   [06/11]: config: use git_config_string() in easy cases
>   [07/11]: config: use git_config_pathname_dup() in easy cases
>   [08/11]: http: use git_config_string_dup()
>   [09/11]: merge: use git_config_string_dup() for pull strategies
>   [10/11]: userdiff: use git_config_string_dup() when we can
>   [11/11]: blame: use "dup" string_list for ignore-revs files

The cover letter subject is wrong, of course. :) I wrote it manually and
ended up squashing two of the patches at the last minute.

-Peff
