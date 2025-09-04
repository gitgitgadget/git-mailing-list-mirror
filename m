Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486C72618
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951826; cv=none; b=i+p6DKmIDGMiTCyYJx7PbDFMMo9q5YjtUmpIjYs7LpAvCMTnnRP8CPMo7Vm6yIFENw7MnFWlBo6jL5O9L+NRdvW6IV0OYuH0AZNawHGKAKOm7PV/XpoeN+MtN+lAG8zny7xQgLMdM5JYD0CTSk7ZkgK1blNpGHX5n+cVRJzSYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951826; c=relaxed/simple;
	bh=1shQIzWoJJ+HMyfaxURHpdlc9I/KdxnkdYtQin6RQq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=js4tWJnkKy5b2SHVQAO2O6zeJVY2P9ShaYE84bOd7I5STKbX2XSNtFsGcQrcelWN4hMyaBKkNzy5QvHhE6SLtMAW+PYQdDzpHjelh8BV4B0YYOyyPKISVS9/GnCIRnLjJigA32eU6k1zJ2u5IjHYDNLrZwTH8slm55sz8hizDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=Qou21c1p; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="Qou21c1p"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1utys6-00D7eo-DP; Thu, 04 Sep 2025 03:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=LtSb4mvYkH9hcfEkZShYFHEmBEbiKAAoOMXBEbLqI8Y=; b=Qou21c1p8Y7zOBUcIKEzni+LL7
	ADHdLsWBtmhB/AWfj8Jl4xUs8Zym8/T8IEAak+lKdT64Qklqg5mie1FgL3Z1XuGnvMIoH7rm62mkb
	nXjaqoex49saRfa9eskLzDUwm6mQaycHqvqnY3I864AUNHmm4uUR8SiwgPt1ps90p89Il9iUcjgK7
	MWbFbb2iVkJF9Rspl8w+50i2om4vmPOASb1ZNOz6UQAlXNKc/iH+u2HHgP+Kj1xtJBcJFbi/kWBf3
	92+Mp07PR5iXP5Fict7HGpXxebUpcBuFoYl4rd+zV1NhMdmQ+pWLCXkD+Uqcl/WKLS33+Kyt0o6gt
	gclBKtSw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1utys5-0002jS-IE; Thu, 04 Sep 2025 03:34:41 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1utyrr-00FuUo-0C; Thu, 04 Sep 2025 03:34:27 +0200
Message-ID: <b8bf66c1-39c4-419d-ac78-e5f847d9ff90@howdoi.land>
Date: Wed, 3 Sep 2025 20:34:23 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/subtree: fix split with squashed subtrees
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
 <ee480c22-0dd3-4c45-a2bd-838c238f1d55@howdoi.land>
 <773ed81e-34b4-4116-88de-7e4307b6c679@gmail.com>
 <62b50f7e-7ee3-420b-9de3-6d9df611b6b6@gmail.com>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <62b50f7e-7ee3-420b-9de3-6d9df611b6b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 09:57, Phillip Wood wrote:
> On 01/09/2025 21:43, Colin Stagner wrote:
>>
>> The outer loop in git-subtree.sh:983 appears to iterate from the root 
>> commit forwards… and not from the HEAD backwards.
>>
>>      git rev-list --topo-order --reverse --parents $rev $unrevs
>>      #                         ^^^^^^^^^
>>
>> Since the iteration is ancestor-first, I'm having difficulty seeing 
>> why `should_ignore_subtree_split_commit()` would want to do an 
>> ancestor traversal at all. It already sees the commits ancestor- 
>> first.
> check_parents() recurses into process_split_commit() rather than the
> loop that call should_ignore_subtree_split_commit(). I think what this
> check does do is prune some parents which stops check_parents() from
> recursing into other subtrees so the check is in the right place.

I agree. In the original patch [1], Zach indicated that the check 
results in a significant speedup for rejoin-heavy repos. The check is 
clearly doing something.

Performance improvements may be possible. Instead of looking at commits 
one at a time, this operation might be faster as part of a one-shot 
HEAD-to-root traversal:

    git log --grep 'for stuff' --format='%(trailers:...)' $unrev..HEAD

Commits that are deemed "uninteresting" or unnecessary could then be 
provided, in bulk, as negative refs to the `git rev-list` traversal.

But my plan is to make the smallest and most portable maint-2.44 bugfix. 
I think that non-essential performance changes are a task for later.


>> I am *much* less certain about the second test:
>> 
>>      test -z "$(git log -1 \
>>                 --grep="git-subtree-dir: $arg_prefix$" $rev)"
>> 
>> If I remove this `test -z`, all the unit tests still pass—including mine. There may not be any test coverage for this line.
> I'm not very familiar with git-subtree but I thought this was ensuring 
> that we did not exclude the ancestors of a squash or split that involves 
> the subtree that we're interested in.

It does, but I am still having problems finding commits that actually 
trigger it.

It appears that `find_existing_splits()` in git-subtree.sh:459 filters 
out the commits that the `test -z` I quoted above would otherwise 
detect. `find_existing_splits()` searches for a previous --rejoin commit 
to use as an `$unrev` stopping point for the rev-walk. It searches for 
commits matching

     git log --grep="^git-subtree-dir: $dir/*\$"

in combination with `git-subtree-mainline:`.

This is essentially the same test as in 
`should_ignore_subtree_split_commit()`.

In --ignore-joins mode, `find_existing_splits()` looks for different 
commits. I experimented a bit with adding --ignore-joins to some of the 
existing unit tests, but I still could not find any instance where this 
`test -z` makes a difference.

That said... I am inclined to keep this second test. The bug I am 
patching is the result of an overzealous prune. The last thing I want to 
do is to inadvertently prune commits we need for the sake of a 
performance boost.


> I wouldn't be surprised if the test coverage was lacking.

There don't appear to be any tests at all for --ignore-joins, aside from 
option parsing.


[1]: 98ba49ccc2 (subtree: fix split processing with multiple subtrees 
present, 2023-12-01)

