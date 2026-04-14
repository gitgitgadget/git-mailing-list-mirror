Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9F1D61A3
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204818; cv=none; b=tk5h5+nRNHOqcE6fe78eudb9XfSgX3XFK/J0XkImxApID1HQe9HQdnUjDnrWHs89UoAi4jb9XhPByD4fIKKs//mJ78OGUh2J3smLtIqL5Oei2BAEaM3xRaB+WoBxmlRtxdHieZhwJn9KwUgriShBAy0iAxy4TdmAH1xIdWQCaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204818; c=relaxed/simple;
	bh=npvwOZpzLOXejnGDa06oVXyTM/8ODEl7A2ONxbkZBIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GANQ63MSK4d3xn5xKs2zkcxbNdg8ZBzvOETCD81+BLavwHZkb7fdMQeWrQOnjOILZqJeGQyx4feDD42clcDcP/HCs8T/4ZH2fsi3nZVxL3tA1lcWrWPI8lzLjcCOhqXkZr1GQjVnBt4w7yMHqjy+6YW9GFIgvNGVexhRN24AXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Aw3XYImG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Aw3XYImG"
Received: (qmail 350725 invoked by uid 106); 14 Apr 2026 22:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=npvwOZpzLOXejnGDa06oVXyTM/8ODEl7A2ONxbkZBIc=; b=Aw3XYImG2aqAyIcF5p18YCJsHUtnXgW9/O3SVnicF52XpVz2peTb7Ien2fCNKkoOWcCuG8xabIkkYvLFB1OgLAH0zGy5m3rFq8dOMauJ9ulyyeUH3xGnw7arX2Qejkotj6OuPaZ6mm0+XrLyH8OZmu/QUUiJZQG65jXu6bS/N81ZKXU9DauS0v5A8shnOqQFoGkSd6CbLHxpJWqrppJ3VRwQfIvxL37aZvkoecYatoGG1+lBVSCO9jcuc2GdPEaowpokpIC+Kz9g0Fp4tX1op2q0kIptjUPFv0nyx7WiB49Jbyj+B3MaR8CkT0Dd4Rzi6QETSxp9uU22p6RF5QOv+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 22:13:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587001 invoked by uid 111); 14 Apr 2026 22:13:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 18:13:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 18:13:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Paul Tarjan <paul@paultarjan.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v14 12/13] fsmonitor: add tests for Linux
Message-ID: <20260414221335.GA3483791@coredump.intra.peff.net>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
 <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
 <f85983ca93761bf6cec115d680af8c7d2938505d.1775710775.git.gitgitgadget@gmail.com>
 <ad6hovxCkwMTG11U@szeder.dev>
 <xmqq5x5t9sxl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x5t9sxl.fsf@gitster.g>

On Tue, Apr 14, 2026 at 01:40:38PM -0700, Junio C Hamano wrote:

> diff --git c/t/t7527-builtin-fsmonitor.sh w/t/t7527-builtin-fsmonitor.sh
> index 774da5ac60..dfa06395f6 100755
> --- c/t/t7527-builtin-fsmonitor.sh
> +++ w/t/t7527-builtin-fsmonitor.sh
> @@ -60,8 +60,7 @@ fi
>  
>  stop_daemon_delete_repo () {
>  	r=$1 &&
> -	test_might_fail maybe_timeout 30 \
> -		git -C $r fsmonitor--daemon stop 2>/dev/null
> +	maybe_timeout 30 git -C $r fsmonitor--daemon stop || : &&
>  	rm -rf $1
>  }

Do we need to put it in curly braces to avoid interfering with the &&
chain? Otherwise a failure of anything before the maybe_timeout will hit
the "||".

I guess in this case it is just "r=$1", which will never fail, but it
feels like we should model best practice.

-Peff
