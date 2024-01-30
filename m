Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE00381B0
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594091; cv=none; b=NzxOTQERkBzQ+2aG8Dos4DZpn7qabCxKQ+k6ryamNEXYSRYX9O4CVify8RppWiN/oKsfR63ieexLKRnSVRo5xeUsbsgw6pJqo5NZpZfHsHQFNuaZPkUuDFcC8YcAafwz+GwMSo0affrolT/5vI35ik6J0ezQgPRj1JGzdY7lJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594091; c=relaxed/simple;
	bh=m7jMlqGQUjiW1+A5QU7nHRHCU+nHJwCyT5Vyk9xjQVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+1fYnGfJRZFTkRoihqNXEyvqN46r6aP8AtXqGbdOS4BkU1uzhsJXwbAmrLdG9SfAsQarCZA2FNQsc5GjXdTZnon5ePqaUoLgKUWRv1B5rhjzsx8WxVcvUiE9kByutTbfOR6TwVsvCOz3U4Pob1JFvYcnTB1dEATKuNGHXo747I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8773 invoked by uid 109); 30 Jan 2024 05:54:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:54:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29277 invoked by uid 111); 30 Jan 2024 05:54:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:54:51 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:54:48 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] mark tests as leak-free
Message-ID: <20240130055448.GC166761@coredump.intra.peff.net>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>

On Mon, Jan 29, 2024 at 10:04:10PM +0100, Rubén Justo wrote:

> The tests: t0080, t5332 and t6113 can be annotated as leak-free.
> 
> I used:
>   $ make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true test
> 
> Rubén Justo (4):
>   t0080: mark as leak-free
>   t5332: mark as leak-free
>   t6113: mark as leak-free
>   test-lib: check for TEST_PASSES_SANITIZE_LEAK

These all looked reasonable to me. Thank you for not just fixing them,
but including the background for each case (e.g., leak-free as of commit
XYZ, etc).

-Peff
