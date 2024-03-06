Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A4612E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685234; cv=none; b=do+QkS7dJe2jK4mCExCEvgDSIVVsD9oc9edwhK2XEW3XHmaavZpb7FgBfapvh4tt8zPSMm7XftxskiZ906ypGe5//AlMWZRBTn3VxsAR6JusX7xDDBof91xXQeUXI28yG+r4/TNhib/T83CjFeXvaNhTx0LXE02EIUl7kYCG5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685234; c=relaxed/simple;
	bh=5dzSbaH3mNsh6KPJqFS1QwUXngskFFyBLTM+ABcenKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLi7Rvtkm1RR0JmGQjJYkvAMweh0HqUdgJ48nJ+0RUW18QHjrC99dFBYk6J0ukhSw/6lvofJz5H0PcbBnj5l7bOYBIQTpvKJ7i2sIKMUEbXyCYKE0Weq8z42DDkqU0+jJqFqSyModCw+Ycha8Nf4PNlVWeAcbDcscaq0K3Xxo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22432 invoked by uid 109); 6 Mar 2024 00:33:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 00:33:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30115 invoked by uid 111); 6 Mar 2024 00:33:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Mar 2024 19:33:46 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Mar 2024 19:33:43 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
Message-ID: <20240306003343.GA3797463@coredump.intra.peff.net>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>

On Tue, Mar 05, 2024 at 03:30:35PM +0000, Phillip Wood wrote:

> Hi John
> 
> On 04/03/2024 22:51, John Cai via GitGitGadget wrote:
> > From: John Cai <johncai86@gmail.com>
> > 
> > For reftable development, it would be handy to have a tool to provide
> > the direct value of any ref whether it be a symbolic ref or not.
> > Currently there is git-symbolic-ref, which only works for symbolic refs,
> > and git-rev-parse, which will resolve the ref. Let's add a --unresolved
> > option that will only take one ref and return whatever it points to
> > without dereferencing it.
> 
> "--unresolved" makes me think of merge conflicts. I wonder if
> "--no-dereference" would be clearer.

We have "--no-deref" in "git update-ref" already. It is probably better
to stay consistent.

-Peff
