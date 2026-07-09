Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698E36405C
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637013; cv=none; b=RC0njAajEExHoOZ7bXtwQcE2u3yBCtLiZDwktdrbwvVMumEbDeyRLhiRQVVT7AR1xzg+1Bd52lin0lnNY48ZVIw7A8FNPxHhlepAcTVAl/eG8iMHzIygpjKV0Y0yXz7fhcpQ1PcLAl4aQncmV6wzHZO3U0sfjYtURggjEjJ6rXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637013; c=relaxed/simple;
	bh=1MJH3I32HlBmrL4vZdqnVMbkzjbaT5rqJ7y6xi/b4SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZggfiHaspcQP0BDrtSYLbyQOCACOsN2LiKXR2d2qTqQyo/RW0IQM/gRjeOkhR5/uNTZo9UJWN9VrKh7F3SqVcwQlxficgpPeZxmVWz+wnnfAAU7jSo7DG3yvdY7jfwS7Mg07lqU2/zesqUrl/C1no6nIvkvN2HZEUEX2R6c8nEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=neyR5QCJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="neyR5QCJ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1whxSi-004CQZ-3J
	for git@vger.kernel.org; Fri, 10 Jul 2026 00:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=4ytWG4C4D77oq2wQlIeHkTFNqJjtUTWCXIRO0IgBv5g=; b=neyR5QCJv8d5nzzk+Ed7yOwZxu
	0rQTVe2DG+Q/VfI6swkw7IFF8noX/+/fnPdj8eUWuStEsRjbHA5kBKAqqwR2J848CXfNPOMzlkFm8
	M889Znyabz2LBGb7bKR6DEKaG+ImIGb7YZeGiDVSyC4ecd4/re+dbU7mr6GGdui+R/DUAAaNFLBnm
	r/AM7iv5EDOT9CofHUXVKS+pi4MR/ccEKwP7FdYZ1SPqS4vgyUspUoxvCpfWC+wMp9ndu/Ve8KHdV
	aX+CoNyJgw9isGN+Odbcti/fV61HVfv3U0DwcIVnLLXBiQIgxexRPxuXGfSnrx7XaoYQQ/KMb+nmF
	/HF7gqFg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1whxSh-0004Pu-CT; Fri, 10 Jul 2026 00:43:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1whxST-002cDo-UW;
	Fri, 10 Jul 2026 00:43:06 +0200
Message-ID: <c8b81987-ab56-4d6b-a650-879b84597a17@howdoi.land>
Date: Thu, 9 Jul 2026 17:43:02 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
 <9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
 <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
 <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
 <27215.27575.968985.583226@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <27215.27575.968985.583226@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 04:36, Ian Jackson wrote:

> Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite"):
>
>> I think that subtree merge should only test the top-level project, as
>> this patch does now.
>
> By "top-level" I think you mean what I've taken to calling the
> "downstream": the project where the subtree is in a subdir, and whose
> top-level has other stuff.  In which case I agree.

Yes, I think we're talking about the same thing.

In retrospect, "top-level" is ambiguous. "Upstream" and "downstream" may 
be as well. Within git-branch(1), the phrase "upstream" refers to the 
remote tracking branch set by

     git branch --set-upstream-to=<upstream>

git-merge(1) is consistent with this.

     "If no commit is given from the command line, merge the
      remote-tracking branches that the current branch is
      configured to use as its upstream."

git-subtree.sh doesn't really deal in "upstreams" in the git-branch or 
git-merge sense.

Less ambiguous language is available:

For merge commits, there is the "first parent" and "second parent" (or 
3rd or higher parents).

For trees, there is the "root tree" and "sub-trees," like `git ls-tree -r`

     -r     Recurse into sub-trees.

Both of these deliberately ignore the dependency relationship between 
the various projects and branches in question, which can potentially get 
messy.

>>> +	if git rev-parse --verify -q "$rev:$config"; then
>>
>> For subtree split, should we also test for this file in tree you are
>> splitting: i.e., "$dir/$config"? The answer might be no.
> 
> You're right that we should consider this question.  The answer is:
> no, we should not.  Briefly, whether to use the new or old algorithms
> depends on whether the downstream has adopted the new git-subtree, not
> on whether the upstream has added some optional config.

Very well-reasoned; I like it.

Let me ask this question in a slightly different way: does RIIR subtree 
honor config files in locations other than the one you test for above? 
That's

     ${rev}:.git-subtree/config

which is `.git-subtree/config` within the root tree of the rev that is 
being manipulated?

If this is the only config file RIIR subtree honors, the patch is 
probably correct. If RIIR subtree honors config from other places, such as

* the working tree
* HEAD:.git-subtree/config
* HEAD:./.git-subtree/config

then consider testing for those if appropriate.

>> Subtree merges can be performed without git-subtree, via the `-X
>> subtree` merge strategy option.
> 
> This is what I'm calling an "unmarked subtree merge".  My rewrite is
> not going to support this user behaviour.  The problem is that it is
> not possible to reliably determine whetheer something is an unmarked
> subtree merge.

Thanks for looking at this.

> Combining manual -X subtree merges with git-subtree --squash merges
> could easily produce quite weird and wrong results in the tree

I haven't tried it, but I think if --squash is in use, then attempting 
an unmarked subtree merge will probably die with "unrelated history" 
warnings.

Looking forward to v2,

Colin


