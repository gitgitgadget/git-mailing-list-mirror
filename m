Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2240BE0
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042250; cv=none; b=hB6tdUn11ApH3KpjsWKFjuQi9Bg1iwDuj6kwqBbBpugoqKC29NjYx42rMsC7JCi5lgyuWFCqFlBrR5BMHNAc0xdXVfaz8jT9xKxSJql6eoZXbOvQXK9gTlDf037VVuOwTfQyqZcoDTszXQ6fnfWSfjapaG739BMtpj1AjOuTpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042250; c=relaxed/simple;
	bh=5JUK7Ry0FzXPhcrR1EPf0oeyTUeHrtcg6cI5mVzkYwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnCrwRE4xssj49OGi0BBzFeLgbiGhWlE1nacqzWkBki7DZGmuvHib+a/BwzCGVmZ4Kw6s2EOYsGo5kfX6eq0LXldnO8ixaJpO1l04STJhp2DPHMyjWATZB+5OVXQ0AOLUxPa9Zo5DwdcfKAKZCRJvzUw8+KOuZ4qm+ryX/vVXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L5Bb+RLq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L5Bb+RLq"
Received: (qmail 7590 invoked by uid 109); 19 Nov 2024 18:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5JUK7Ry0FzXPhcrR1EPf0oeyTUeHrtcg6cI5mVzkYwM=; b=L5Bb+RLq8prFWfSAbXi+b9KPY7uJcyvtyxaO/JbsUIieU0juot3I+qHL3BtCl5nuASTp7z6g3ecFtkqABKkXlXWvzao01i++114uPhxzVFX7LpRhl948vLDTg6SVkijLsNmTLeT1Y4NBEjtAvOv8GTAWRt9RDavoUfn+9g5x00ucMLO9wel0YaNQQ6LTJaZZQrdcqV6sQVJs8Ic7CIRtaBM2eI2iPnTI9rIBtLFBHp7Z4c2xxRe/Y37boRhvylSJ2uF80imuiRQoV2cw2zypqrJZ7jjzIvNa8mlcv5s4AUNfJCaVKaX9TdpbMs12H3oMfiUhPV3yEf3Znh7G9t9nDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Nov 2024 18:44:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2559 invoked by uid 111); 19 Nov 2024 18:44:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Nov 2024 13:44:06 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Nov 2024 13:44:04 -0500
From: Jeff King <peff@peff.net>
To: Caleb Cushing <xenoterracide@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: git remote set-head automatically
Message-ID: <20241119184404.GA15723@coredump.intra.peff.net>
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net>
 <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
 <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
 <CAAHKNRF4AnvceiTDLdpNS94yRnoZYMSD0Wkg7V+4YBwSej7NSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAHKNRF4AnvceiTDLdpNS94yRnoZYMSD0Wkg7V+4YBwSej7NSA@mail.gmail.com>

On Tue, Nov 19, 2024 at 12:06:21PM -0500, Caleb Cushing wrote:

> A little more progress on what I'm going to have to do, github action,
> without set-head the ref/HEAD isn't present
> 
> - uses: actions/checkout@v4
>   with:
>     ref: ${{ github.event.workflow_run.head_branch}}
>     filter: "blob:none"
>     fetch-depth: 0
> - run: git remote set-head origin --auto # fixes otherwise the cat
> will not find a file

We do create the HEAD symref in clone by default, but IIRC
actions/checkout does a more limited clone with --depth and
--single-branch.

The separate set-head should work, but it is a shame that it will have
to hit the server for a second request.

You might look for options in actions/checkout to change the way it
invokes Git. Though I suspect there might not be a way to trigger
git-clone to do a single-branch clone _and_ create the HEAD symref. So
you may be stuck with the two calls.

> - run: cat .git/refs/remotes/origin/HEAD

Don't access the file directly; it will break if the ref storage format
changes. Use "git symbolic-ref refs/remotes/origin/HEAD" instead.

(Not sure if this was just illustrative or what you are planning to do
in a real CI job).

-Peff
