Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FC31A76
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528809; cv=none; b=kQOAKLwB3NsSwM9qhN9tUJylFmPxqueeajjG/73hW7qyQWKTf341ZR6aeBGx6eTlL5ZPnQQ5IY5NtUyfDCDoTnHvwj1QXzyiNDqfjEMYFCy+WiL1E/S31+9AfxLz5v8+cNtU6gmoWXBKw4WbbDJTYrJiWbcJvp0dnY/vu68W4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528809; c=relaxed/simple;
	bh=lq6iM27Zcl6tX0yYQpJYVoKnA96AztfB3wSF9Pt4jRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdZkYV9jcxvOuZiSj2eaO7mbs2YOfE2dNKdb2+cS8RDaE3nRSM2ZsiwjyOnF4L0maAlfzzMQmcaNmcS3lVIFLbX/sMSB0V8oZSrpIO2tElv07v/yoV5eQvg1C6EfzlwNP/FHDwxogEYrc08mGcYnQxzOUcFmJZ+RPQek8pmUbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21734 invoked by uid 109); 27 Mar 2024 08:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24457 invoked by uid 111); 27 Mar 2024 08:40:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:40:11 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:40:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Steven Jeuris <steven.jeuris@gmail.com>,
	Steven Jeuris <steven.jeuris@3shape.com>
Subject: Re: [PATCH v2] userdiff: better method/property matching for C#
Message-ID: <20240327084005.GE830163@coredump.intra.peff.net>
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
 <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
 <xmqqfrwc8yhq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfrwc8yhq.fsf@gitster.g>

On Tue, Mar 26, 2024 at 02:38:41PM -0700, Junio C Hamano wrote:

> >     userdiff: better method/property matching for C#
> >     
> >     Change since v1: I removed "from" from the list of keywords to skip.
> >     First, I considered adding "await", but I discovered both "await" and
> >     "from" are "contextual keywords", which unlike the other keywords
> >     currently listed, aren't reserved, and can thus cause false negatives.
> >     I.e., it is valid to have a method named "await" or "from". In edge
> >     cases, this may lead to false positives, but a different exclusion rule
> >     will need to be added to handle these.
> 
> It seems that this has seen no reviews.  I somehow find it doubtful
> that Ævar or Peff would be writing too much C# to be familiar with
> the language to judge the quality of the patch, but can somebody
> with C# background (I hear that its most common use is for
> developing Windows applications etc. there) chip in?

Yeah, sorry, I have never written a line of C# in my life, so I have
been dutifully ignoring this series. :)

-Peff
