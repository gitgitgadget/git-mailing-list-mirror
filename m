Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73927A445
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759524; cv=none; b=UEtSCozMIru++DubLltPfx/oFkSjZX/3O7+CU0Yhr2+rTLgloUEfXz6WfzD97h0yY8lqc7XZGUEDFzgm19QjI7YxffBy8+ZszZ7CjykUBufErrZ2zWiW1EM7H0GXl3HNSoKFUVfCokj7Wq9u698Zix1vpp3tCp+fif9E/EDRAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759524; c=relaxed/simple;
	bh=xwX48H92gPZ8ZxjY3YgVDzaOjbXYX86l/Ozx0OuKcBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYjgTNcLjO0sYa74Nen3aD7CdgmBlk0Xk9E5gWYWc6qyV1v6IRcl/XvAYf26sMuKln3eIBBYrQnb3BTi3cUwFBIkf9jdC4JnOxrKEFvuzU/7fT4zKNm/eKx6uCXAE/Mw/n7s4YI72wx8iRhdnpBI97Ngt9uKPn0XNCDmEyukUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZrG6MsRB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZrG6MsRB"
Received: (qmail 17702 invoked by uid 109); 24 Jun 2025 10:05:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xwX48H92gPZ8ZxjY3YgVDzaOjbXYX86l/Ozx0OuKcBs=; b=ZrG6MsRBwV7bfO/+FsVbs3JnEIyLbMABInuOlK/aaVH99Cqq1qOJ8l6DP9B72UTyOPijvuflXaB3l+/dNGLOj8bWASkMYk+SPn1s9uCiIN9CzzXXVKz+Tg4tr/53KH/lbGUt7yW2omoO1DwO//DesBCRq9YoBl+HM3Noa3pZKQpeE7p60UVqm8fNM5aOQreVONA7cNkQeTZyaBynCV9VackdazY+srwcPwS81R04IprQTjOLDs5mfqVrikRxv62R2h58oSCqJRkyZVmqjliWGA2vvTm5ZYbWWF9ldx+irgFMsca5OWpBBIDU6ON3dkyH841+PZ9zQzFakEBaTPYaWA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:05:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29192 invoked by uid 111); 24 Jun 2025 10:05:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:05:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:05:20 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7422: replace confusing printf with echo
Message-ID: <20250624100520.GA636332@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105542.GA654412@coredump.intra.peff.net>
 <CAPig+cSLJ57+ZU1TreHajAqbQwBD7TRUt3bxRDTcHCjS88xmLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSLJ57+ZU1TreHajAqbQwBD7TRUt3bxRDTcHCjS88xmLg@mail.gmail.com>

On Mon, Jun 23, 2025 at 01:59:48PM -0400, Eric Sunshine wrote:

> > diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> > @@ -180,7 +180,8 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
> > -                       printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
> > +                       echo "[submodule \"sm-$i\"]" &&
> > +                       echo "path = recursive-submodule-path-$i" ||
> 
> This looks obviously correct and, as the commit message says, is
> almost certainly easier to read, but I was more than a little
> surprised to see the patch since I thought this code had been fixed
> previously[*] and had some discussion around it.
> 
> [*] https://lore.kernel.org/git/20250403144852.19153-1-sn03.general@gmail.com/

Ah, interesting, I hadn't seen that one. I am happy with either
solution, but IMHO what I posted with "echo" is a bit more readable.

-Peff
