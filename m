Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D118299A8A
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394004; cv=none; b=PYbV864vI67w9M6fmJMiUat3Z/04ECxBMcnNczVXYxsUveguyG2avsk/S9GsIhMd2JboUJR7lu1YjwQwtBnG2ncpyxhWBTdSe/eI1URFbrB7WQa6Iu1czqKn3W78MH5oA7n2RToHyS6J5MWLCPt9bEgC9XbzPZngxewjHwK9Grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394004; c=relaxed/simple;
	bh=c/aBzP9XF95BdwxGHjWQ+PkEsw2UrStPaqJHRb6/67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff0Xq0FeRpns9gmJKdBOEHLuYio4APBLVuAjAIsJLIQWWjnYcTGY+p7Z3aNdAJK1OVkJBoLJwLLM7eS+v5gPdQGPRIZki40tJygmG3zK/Jv1FhabvPrfFyzQtiIqIC7sxndCtxqN2OWJo36e6iRR48khUvxF7cs4QgadNqOMvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cQpqmnlb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cQpqmnlb"
Received: (qmail 142263 invoked by uid 109); 20 Sep 2025 18:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c/aBzP9XF95BdwxGHjWQ+PkEsw2UrStPaqJHRb6/67I=; b=cQpqmnlbfnmx0dvxE9GjUw7DWXpouqPhONyM+B+h4nLZqsbgwHabAe27L2OHgUXqpn5vHstJRVy4YGOoGiR9Cvlc/t1vkjKpcVEl+G4+cX/q85EIFm7uC0BSk+pJdecfNbTB/dQPyPEe5ZyA1Hk7pyQiSulvzdPF+4bdGvR5oAW9+Jla45GfrH7hZoPWaooAlPJwhp2vgLhvhv4tgWrEQQ9Lcv6sK5VJN9v5vI29HSd2bw9KsilzTM9b0ML7QBB8DbdbvVb9yb/1Qs8mRWJE+Kcwml8gaFm6DarKmKtatKLQBDIGaLzSQuTVvtzRkvQJadlqa3ssaT8vkwlHsjQv/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Sep 2025 18:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 222948 invoked by uid 111); 20 Sep 2025 18:46:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Sep 2025 14:46:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 20 Sep 2025 14:46:38 -0400
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
Message-ID: <20250920184638.GA1010995@coredump.intra.peff.net>
References: <xmqqh5wxxcwq.fsf@gitster.g>
 <83F61517-06DB-402E-911A-E33EE07D54AE@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83F61517-06DB-402E-911A-E33EE07D54AE@gmail.com>

On Sat, Sep 20, 2025 at 01:46:19PM -0400, Ben Knoble wrote:

> >> Best-viewed-with: --color-moved
> > 
> > Two comments.
> > 
> > - This is a bit unusual to see in the trailer.
> 
> This was (loosely!) my suggestion, and I think Peff has once or twice
> done something similar.

I don't think I've ever used a trailer like that, but I do sometimes
mention it in prose. I'll sometimes put it in comments below the "---"
line, though.

-Peff

PS I sometimes find:

     git log --format='%(trailers:only,keyonly)' |
     sort | uniq -c | sort -rn

   amusing to look through for this sort of thing.
