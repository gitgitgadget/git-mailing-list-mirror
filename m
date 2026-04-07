Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4633ADAB
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573610; cv=none; b=dV0740zuzAdDyMMw/uoGseQU+5j81YZrNSdlaRNZhqv2MtrtUWoy+0TOamahmGJzIz94iKWUViivlLto6Jj1RVE7HgiDyJzNQqkAmoISNR+1LxdHKKvifsDSWPgI2mDQGosJ4g1o27tGIeHc7sBzw8yw/AGnfwhC9UMixjq8AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573610; c=relaxed/simple;
	bh=rHNbBcMAoIDkvKluZmVQD0Atgjg/iwIOMxR2TDgk9LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxt0uT+fPoO2O6ajnbzG4vBOacmrVrKfBXjx21ohsh/aSCM0bpxfKAqJb5EV75jn926jD/y4mboaQSyVy5eoHKzNRC21r9sXNw2Po+izPwgnbOM5NrnWCRdJt2o+dkJNFG5odt2Gmmxgt0/pqif40LajJqIhXCxZRGbsME8rnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TnPC2P2g; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TnPC2P2g"
Received: from macsyma.thunk.org (pool-173-48-119-176.bstnma.fios.verizon.net [173.48.119.176])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 637ErPK4006049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Apr 2026 10:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1775573606; bh=MEOSL+5XuUn+K017MlRARlJYQ17ZBfBk15ewcT6YTb0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TnPC2P2gsKS7v0JIjWWvYcWkIts94vA/tkgMcd7U7MguBdCn27fTDTeuMyFljWGee
	 byzPwUloZpimgx0OOF5KlYeVZifXt30GeDMQ3BWsJnAsqUU0aw+/wUkCR9b7tRRjLn
	 ezG5h6tLbfaVCX+v9X6nNGhkmfMywy/I/P3j0ws/bSDLMoksfFscVDoLDi8Bbj9Wmw
	 DjtmnvtBeIWUZsv/ImEvdOULEkMwhaVevWoSXpKQUVpit9M/fp7AwIOCOzI6fCPTMt
	 BTkncThCGknXl8kR9KX2oi7sQOwi9rvkWkPtWZs823J6ofYZNq5FEC7hnnwNXj5nbT
	 k/iFjJx/ukzfA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D590462272E8; Tue,  7 Apr 2026 10:52:24 -0400 (EDT)
Date: Tue, 7 Apr 2026 10:52:24 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Gabor Urban <urbangabo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Super repository
Message-ID: <20260407145224.GB81690@macsyma-wired.lan>
References: <CAL=1hhxP08w=pMa39izN7SyFzsv+5HWZhtzhh136ZmG2dg7Xtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL=1hhxP08w=pMa39izN7SyFzsv+5HWZhtzhh136ZmG2dg7Xtw@mail.gmail.com>

On Mon, Apr 06, 2026 at 08:36:08AM +0200, Gabor Urban wrote:
> 
> We have a project in:../foo/Project1 under git locally for a while. In
> a couple of days (or weeks) we are to start two new projects.
> According to the management we have to make ../foo/Project2 and
> ../foo/Projetc3 to be brought under git.
> 
> The real issue: we are told the create a new repository for all 3
> projects (inf /foo/), but we must not lose the development history
> stored in the local git repositiy of Project1
> 
> Is there any good solution for that? Thanks for your help in advance.

So in general this is a bad idea if Project 2 and Project 3 hare going
to be separate projects and you aren't planning on merging them into a
single tree.  Is your company trying to do this because they are too
cheap to pay github for more than one private repository, by any
chance?

In any case, depending on what exactly you are trying to do, take a
look at the two answers here:

https://www.reddit.com/r/git/comments/17wj0bj/merging_multiple_repositories_into_one/

						- Ted
						
