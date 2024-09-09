Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA601B1D57
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865724; cv=none; b=KGZ3acvm9xefa96wtuvFB9qQ0cf0qQnIdw1ffE01GZYUYddA2oYrjpm5lwVabdAURHWd6TrnHJnxWh8gsrOpfyrUP1yUUbVdXuAZWE+5AbTmypo+iebAH1Oc5Qy8qWvWOgGk/Ekmfz21GHlhR5ty2SM2PbrB+yJVodeB9/q5up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865724; c=relaxed/simple;
	bh=bRnPTY9IzyKcvNpOeteurXjzoPuv8y94PnjgL8kJ9E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP/jp6dLZwkhMpX9U4SXeLA2qDUbQO+q65AgFyF5wYFD8yVoFHCS8LaizOdpJBLhH+bnW5m1XSvy2LTrMvTGXRIVGWLStHSpWLHZqYTUWF9BxII2ovONzy5JuY7kY5oTuRIYLVR73TiJItZcfrlprkQWu5fLcilvXXFcBh5TTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25385 invoked by uid 109); 9 Sep 2024 07:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 07:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17731 invoked by uid 111); 9 Sep 2024 07:08:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 03:08:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 03:08:36 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
Message-ID: <20240909070836.GA4050065@coredump.intra.peff.net>
References: <e3339b4d-dab1-4247-b70e-d3224bab1b6b@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3339b4d-dab1-4247-b70e-d3224bab1b6b@ramsayjones.plus.com>

On Mon, Sep 09, 2024 at 02:23:48AM +0100, Ramsay Jones wrote:

> After more testing, I removed the RFC from this patch and actually wrote
> a commit message. (I wasn't sure if I should mark this with v2 as well?).
> 
> I was a bit surprised that this went unnoticed for so long, but I don't
> use 'git credential' (shh-agent is all I need), 'git add -p' (vim works
> for me!) or used the help.autocorrect=prompt. I have used 'git bisect'
> many, many times (of course), but I don't recall ever seeing either of
> those prompts! This goes for Linux as well as cygwin. :)

The patch unsurprisingly looks good to me.

I think most of what you are describing in the commit message is all the
normal and expected benefits of HAVE_DEV_TTY. :) But I don't mind erring
on the side of over-explaining there.

-Peff
