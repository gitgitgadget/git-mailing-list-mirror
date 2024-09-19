Received: from binarylane-bailey.stuart.id.au (binarylane-bailey.stuart.id.au [203.57.50.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279ED1991A1
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.57.50.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726746037; cv=none; b=YMXlQljPKEf5jqp1CNaNnp+eDKuDcVYH8t3SLoDiP0yPDNluSmFcyA1rPQzZeRx/mFln57vPUnHIdQtEbRAll/rg93fVAd/q5Io/AH6eSuBBr9+lwHAZhDSUVIrwBpRVjEb4GBjna6ZO+ZjR8bRvo8WXytN+zj4K5BUzKuJwcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726746037; c=relaxed/simple;
	bh=5PjoOgr0DXFszmxWFf1dVfkYydMuL9HQSaudJxInEVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9IkAt0Gc1JKdMmmxJBI06d1sy5/O5b6YImZugLitkAMtr8e07I5mYHzidaw6wyicCrEvXGbqjWQxjRMLdXY0LGOlWLGBeBh/66OZt5s4N1DpqliT4BweKYdc4cr6xXcuK2TAn9St5i3EBfoV4/HAjws+YBc+hxKfCxWABrWAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au; spf=pass smtp.mailfrom=stuart.id.au; dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b=Mh4uqXQt; arc=none smtp.client-ip=203.57.50.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b="Mh4uqXQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stuart.id.au; s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=po11skpJ6t2Fh7e2SakO11zBu6J6GAO2RxNvTDcmLCU=; b=Mh4uqXQtGB6YSLFr8/9SKm/H8p
	h14LFc0UXk0B8EWzXjbZhqM/wwnzFpv5Pr4xCR9HBFhgWPMIrE3TxyU7SVNTJlQORsG508pwvGeEA
	8Bj5HSUSXwUOX9CKUf/NK97uSPYymoFAQmORXWTg1+14B8cHbGBTSml34im13/kNRV3pf9il5/FVq
	iSAairyAJTygLvKtQlZl6FLoCEKmBXJRuiZxhQSeYlMU1S8GORDPwN+toxdhG7B1/D9Q6/SD6ngjE
	VSTfm0GVk+AbPa5zJvEv29yCpnbqfo8IiUwXXkb4Hj+tLmlbPBQPyQwzrtr8rh1qNnli+8Ayiu50E
	u+qF41RQ==;
Received: from [1.146.104.215] (helo=[172.27.179.148])
	by binarylane-bailey.stuart.id.au with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <russell+git.vger.kernel.org@stuart.id.au>)
	id 1srFWQ-0006ML-37;
	Thu, 19 Sep 2024 21:40:31 +1000
Message-ID: <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
Date: Thu, 19 Sep 2024 21:40:30 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "git worktree repair" modifies the wrong repository
To: Eric Sunshine <sunshine@sunshineco.com>,
 Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
 <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
 <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
Content-Language: en-AU
From: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
In-Reply-To: <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/9/24 20:47, Eric Sunshine wrote:
> The idea of relative paths has been discussed previously[*] but was 
> never implemented; although they may help some cases, they break 
> other cases or at least make the other cases more difficult. For 
> instance, relative paths only help if the main and linked worktrees 
> move together in some uniform fashion, but don't help if they move in
> distinct ways.

If breaking when moved is the criteria, then absolute paths always
break.  Relative paths break slightly less often.  So it seems to me
relative paths are an improvement - but not a fix.

It's always possible to break something by moving the wrong thing.  For
example moving the .git directory in a normal repository would create a
mess.  Yet, unlike moving worktrees (most?) people do not attempt to
move the .git directory in illegal ways.  They always copy/more copy the
entire repository.  It's intuitively obvious if you keep the .git
directory in the same relative position, it will work.

So my uniformed guess on how to "fix" the problem of people
moving/copying worktrees is to make equally obvious they must remain in
the same relative position to the parent.  One way to do that is to use
the same structure hg uses, which is the child worktrees must all be in
the one common parent directory, and the parent directory contains the
.git metadata.  It then becomes self-evident you can only more/copy the
entire thing - not bits of it.

> [*] The previous discussion was in the context of an earlier 
> implementation of git-worktree, long before there was a "repair" 
> subcommand. In fact, the very original implementation of linked 
> worktrees

Thanks.  The starting point of "linked git directories" (I presume to
save on metadata storage?) explains a how worktrees ended up where they
have.

Interestingly, people (including me as it happens) start out by trying
to emulate the hg approach using a single parent directory to hold a
bare repository, and the child worktree directories.  Then they discover
bare repositories mangle the remote links, and give up on the idea.  In
my case I then tried moving/copying the worktrees as a group using "git
worktree repair" to fix the mess, which eventually lead to this email :)

Others have published of hacks / tricks that try to solve problem in
other ways, eg: https://github.com/Kristian-Tan/git-worktree-relative

None of them work very well.  Going on what Google throws up, moving
worktrees remains a commonly felt pain point.


-- 
Regards,
Russell Stuart
