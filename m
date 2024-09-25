Received: from binarylane-bailey.stuart.id.au (binarylane-bailey.stuart.id.au [203.57.50.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557415B54E
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.57.50.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256711; cv=none; b=DGqC1U7VqlwYnfF/Wmxinyz1HGmHBlJyKM9aLtxP+6yUpqsyvrUWalg3YM+NWl49m08BR2RslFzjpuPyagMBHEejlAvJyfqlUDZklOrFwRYYQ/hgJZwg/W5MYm+zyqaqsMlEcAfk7Gaqb/PHMiGyzE5xE5W/qcOywBP/zEPHn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256711; c=relaxed/simple;
	bh=DcSLvlzv4t9Dybj96wZQiZ37hrfvUun5BwHa9EQJwpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMmUQ5v2p/qD2Cfi29InDYsTVcQaoXtqvleubEwZ4DwHsWmbli7CS6EgMQVdrHrPA7PSwv3X747lBko7wKxFHeAHMxPzZlGRXaAkd4xzTiaDU5K93CZgegtqxEE7GP1Ctc7n/uXxdmwjd1lvhujoFIgQoYJ0Tsx9M8uDfzoLmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au; spf=pass smtp.mailfrom=stuart.id.au; dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b=vXKn0ZhZ; arc=none smtp.client-ip=203.57.50.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b="vXKn0ZhZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stuart.id.au; s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+NhZdTfyfkXrBNbDI63/Cjg5ZW2fINM/2ICBtorrU+k=; b=vXKn0ZhZ2nvXgU1pdfaZb/7UDP
	igIijCDDwnLpTAPpwTmFBkV5chI0d2OkknTClX5HMvo8n2YByMS4ACh2J+8rE5mhBJIoUL22xbJpA
	aaauyLWul3AJdsXYnowhJM/vRkB5hAvS242axcy6VgCzkf256Za7RZ9WxnO4X/DRS9ZI0+2uYwMth
	4Via9llaaaQjM6FR4qePvxaTV4kXkvcDJorSNaHuN6PKACDJqBubWb32MdqjyqXv8w6/9yIio9pfi
	rYply1GJZxU6Sk/+jFMDrYedyqVoRl7ZLwQoY2UCdlYSD9BKixtMvlahsymhZhatNyfZHhr4kk4WJ
	fGbWAd/A==;
Received: from [1.146.104.215] (helo=[172.27.179.148])
	by binarylane-bailey.stuart.id.au with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <russell@stuart.id.au>)
	id 1stON1-0007XI-1E;
	Wed, 25 Sep 2024 19:31:40 +1000
Message-ID: <b9f55058-354d-4a61-ac3b-92ea56026693@stuart.id.au>
Date: Wed, 25 Sep 2024 19:31:39 +1000
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
 <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
 <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
Content-Language: en-AU
From: Russell Stuart <russell@stuart.id.au>
In-Reply-To: <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I missed this reply.

On 24/9/24 04:52, Eric Sunshine wrote:
> [1]: The discussion begins at the "Also Eric" paragraph of this email
> and continues in emails following it:
> https://lore.kernel.org/git/CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8SGW_Q@mail.gmail.com/

Yes, Duh's comments pretty much sums it up.

> This intuition perhaps arises from your background with "hg", but I
> have not formed any such intuition.

Not only from hg.  You can freely move the parent directory of all CVS 
systems I'm aware of - hg, svn, cvs, rcs, sccs and yes git too.  It only 
breaks when you add worktrees to git.

> That's a very restrictive and limiting organization. As I understand
> it, one of the design goals of Git's linked worktrees was to allow
> worktrees to be placed anywhere, including on removable media or
> not-always-mounted network drives. (Yes, you may be able to do
> something similar with "hg" and symbolic links, but that doesn't play
> well with Windows users, at least not in the era when Git's worktree
> support was implemented.)

Yes, it is far more restrictive than git worktrees are now.  It 
simplifies the users the mental model of what is going on, but that 
simplification comes at a cost.  I only mentioned it because relative 
paths in worktrees would allow you to pretend it works that way.

> Can you provide more details about this "mangling"? Although the
> use-case you describe was not directly considered in the initial
> design, worktrees hanging off a bare repository became an
> explicitly-supported use-case not long after worktrees were
> introduced. So, it should work properly and we know that people use
> worktrees this way, but we haven't had any reports of mangling in this
> scenario.

Phillip's reply was spot on: 
https://lore.kernel.org/git/87afa860-52f4-414a-82da-09e7eeac1301@gmail.com/

> By the way, have you seen the patch recently posted[3] to explicitly
> support relative paths for worktrees?
> 
> [3]: https://lore.kernel.org/git/pull.1783.git.git.1726880551891.gitgitgadget@gmail.com/

Ahh, now I see why using both is attractive

