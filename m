Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268C133983
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205995; cv=none; b=QT70o6oUtFI84DskWNBCrqv4vXwpKIs8WMy6vqf0eecMvsWO5ar2XIvddGtmWf61IQcKfVMFoWIJwgp2Bw6crJ0coX2/+tZ7epvSZUBkEA9JVfhl7r/mKWYEpvxFOaVPtuz4L1JtFUpNoY1F6eU5BN/ywabF9eYR6UjpmnWeerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205995; c=relaxed/simple;
	bh=yxk2yb1cFO/VYOvTX4qczlXXwxxdYh0ROYv5stSgvsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/oqKh9+CC8uO5tsgu3pBUNHq2I038137QBVXNNWIGqFaS8VyDi8jK2PG5U0h67fN2jqDV2qR4jri1pvRBz7Z9xexPMR0mQQDlSDcMXzS0iIglO5WA+vAetXfElAfCMng07jLuLlGrppKoMbsJDEaDo/SKVqDO7w90AQFl3NdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17115 invoked by uid 109); 25 Jan 2024 18:06:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jan 2024 18:06:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9161 invoked by uid 111); 25 Jan 2024 18:06:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jan 2024 13:06:26 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 25 Jan 2024 13:06:25 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	=?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>
Subject: Re: [PATCH] ls-files: avoid the verb "deprecate" for individual
 options
Message-ID: <20240125180625.GA54488@coredump.intra.peff.net>
References: <xmqqjznybfp4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjznybfp4.fsf@gitster.g>

On Wed, Jan 24, 2024 at 01:10:31PM -0800, Junio C Hamano wrote:

>  --exclude-per-directory=<file>::
>  	Read additional exclude patterns that apply only to the
> -	directory and its subdirectories in <file>.  Deprecated; use
> -	--exclude-standard instead.
> +	directory and its subdirectories in <file>.  If you are
> +	trying to emulate the way Porcelain commands work, using
> +	the `--exclude-standard` instead is easier and more
> +	thorough.

Sorry I missed this gramm-o before, but should be "the --exclude-standard
option" or just "--exclude-standard".

-Peff
