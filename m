Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CF14B094
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738638304; cv=none; b=D6cU94U0f/PMx3I/5CnH7SZYVR3kDvaGqjktq8kSPufUQUAJIv0vLlPo+82HxuPBJ8rPib6+v9O9XxJJtPGzhAWKuy/0pO6ft37789v8kaRHjG3T4p2R7QdApNDFNyR11QAds6r+17RbKRytt99f91EaZMQUKp0IdvmDmX41Zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738638304; c=relaxed/simple;
	bh=S+WkFyUKIG9QBKOQDbyW0MMJmXTcmBVfMZMa9pUEqEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMegZdJFfRPnni4L7wPuQnFUJtmtKrTIKPwYd4YZHEpvPZgchNbzfXIup1srEtJHc4U3hZymbPhMbjLTM26aqhKkKHCl21tE947JN+gBR7W+9MQYa0AAJjTPVClO0XQ0fj+qzKaU2B5nJIhkiOpkpHAAtH0RX4XEnkGs3sOBmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KYoVn7v6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KYoVn7v6"
Received: (qmail 21913 invoked by uid 109); 4 Feb 2025 03:05:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S+WkFyUKIG9QBKOQDbyW0MMJmXTcmBVfMZMa9pUEqEM=; b=KYoVn7v6w4Sr7hNiv3CKS55JyJo4rA6GdaXUoZ/0oeEtwvkW7g9pLRhqvPyBX5p+f+uPC4C0wzVmLGU8lp7Fe6m/txgpzG39YGYDR8t7LUM2IFfqxzpSc8RHNMC+j56gZ2Hwt/OrxK1BWOvNwo6Pg9jxAW86T6flqk+rHt5KXHTYZ63p2dFBomJ6UfLcjDG/TXMaA2B1u1S/7hes2Srkxccvgork7jeMn8Cfq+sy00qKxBOfpBwgB4mafuK6Ej4vtIlwi7VvW57DepKLn81xXyXrUG2VmV8FfyjsOJUpGWFp2hqUIvZyBPxQ0C3OvUS4h1oi7ubMAdFaQnqR7Pz3kw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 03:05:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30376 invoked by uid 111); 4 Feb 2025 03:05:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 22:05:04 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 22:05:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yongmin <yewon@revi.email>
Subject: Re: [PATCH 1/2] help: show the suggested command when
 help.autocorrect is false
Message-ID: <20250204030501.GD23954@coredump.intra.peff.net>
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
 <20250201213319.153109-1-davvid@gmail.com>
 <xmqqpljyzlmb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpljyzlmb.fsf@gitster.g>

On Mon, Feb 03, 2025 at 02:53:00PM -0800, Junio C Hamano wrote:

> David Aguilar <davvid@gmail.com> writes:
> 
> > Make the handling of false boolean values for help.autocorrect
> > consistent with the handling of value 0 by showing the suggested
> > commands but not running them.
> >
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > This is based on the sc/help-autocorrect-one patches from this thread
> > and is in response to the open question from "What's coooking in git.git":
> >
> >> On Fri, 31 Jan 2025 18:51:33 -0800 Junio C Hamano <gitster@pobox.com> wrote:
> >> Looking good except for "should 0 and false be 'tell it without doing it'?".
> >
> > source: <xmqq5xlu4bt6.fsf@gitster.g>
> >
> > This is what it would look like if the answer were to be, "yes".
> 
> I obviously like the updated semantics myself.
> Thanks for updating it.
> 
> Let's see what others think.

I like it (including the new "show" which is even more descriptive).

-Peff
