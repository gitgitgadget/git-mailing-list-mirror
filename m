Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811401C5D6A
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762704; cv=none; b=KrygnyUMX32fR1s2VEnWpWMAS/1WZ/dDCj3TFrJgCq2CpmVSsL5JReiVxTCC1C8/I+gISfZK+LkWR82iSKr2p7qJUZckg5D4HVuT8EJwzTDQnJLWlB3yvj2vbnLXZwKJidU1hgvQMSnCsG69HiRgLfPIjHtJuwt5I4+QyTi5c5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762704; c=relaxed/simple;
	bh=G015bvikUmmHyxHyNa2XqS5Bgc3l3Gplqy9itHqB3jE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gF8vwxNT+PByNzEOh6W0AABog8IGUXY4AGesqAm72CmrGXssHmnDQZ8z0c4zR815t2u5r59ELs2vw3K8yea49P2m1KmGNNy4q2xOeT2n9ipJkpY/C6Z6sCSKMiyArbGHlNN0cCBJapFVqsR4xmzjskCkbovFhexRDmLVlP/Fsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=jhVLiNTT; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="jhVLiNTT"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1utBNM-005UrZ-Py; Mon, 01 Sep 2025 22:43:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=rCm2wVg4YLxJurkcYAz+g5wmBfwIC2lLll/Z5WI4vu8=; b=jhVLiNTTvwNrphHvTW/lDQSRBx
	Z9X2DxsfzegAL+BeI8A53Rj3fstA5ZMIpC9ClcKh240B+DepXwWhU4pTk7QN/BLyKx6M9x0JBOAg1
	Npj/fdy98UWLtAIC1bdDr8dmbcrM4qVUzbSFbKJos7A0tMGWzPQEtk977EacBykCOttM2j38bCs8u
	6FVrgOrRBaoA8fTS8+nDVZ8QisSqJUvigBxrLr+LK3xlx4mPx+2qpOffIVO8dzQI6SGWXYJCcSQon
	axUGdeTVv4uyKBgjyp393u+sELLE0iTEIx//+0wJJwA+ut/3u6QQeDGPCsWJY1UakeCRYEIF/6mCO
	KYXtaBfg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1utBNM-0000ta-3U; Mon, 01 Sep 2025 22:43:40 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1utBN5-008ZZA-AM; Mon, 01 Sep 2025 22:43:23 +0200
Message-ID: <ee480c22-0dd3-4c45-a2bd-838c238f1d55@howdoi.land>
Date: Mon, 1 Sep 2025 15:43:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH] contrib/subtree: fix split with squashed subtrees
To: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>, Colin Stagner <ask+git@howdoi.land>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
Content-Language: en-US
In-Reply-To: <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/25 08:54, Phillip Wood wrote:

Colin Stagner <ask+git@howdoi.land> writes:

>> -    if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
>> +    if test -n "$(git log -1 --grep="git-subtree-dir:" "$rev^!")"
> 
> We could drop the "-1" as we're only considering a single commit.

Concur.

>> -        if test -z "$(git log -1 --grep="git-subtree-mainline:" 
>> $rev)" &&
>> -            test -z "$(git log -1 --grep="git-subtree-dir: 
>> $arg_prefix$" $rev)"
>> +        if test -z "$(git log -1 --grep="git-subtree-mainline:" 
>> "$rev^!")" &&
>> +            test -z "$(git log -1 --grep="git-subtree-dir: 
>> $arg_prefix$" "$rev^!")"
>
> I'm less sure about this change. Is the second test checking
> making sure we don't prune this commit if it has an ancestor
> that is a subtree merge for the subtree we're interested in?

The outer loop in git-subtree.sh:983 appears to iterate from the root 
commit forwards… and not from the HEAD backwards.

     git rev-list --topo-order --reverse --parents $rev $unrevs
     #                         ^^^^^^^^^

Since the iteration is ancestor-first, I'm having difficulty seeing why 
`should_ignore_subtree_split_commit()` would want to do an ancestor 
traversal at all. It already sees the commits ancestor-first. But there 
could be a reason that I don't know.


Here is a more long-winded breakdown of these tests. From what I can 
determine:

     test -z "$(git log -1 --grep="git-subtree-mainline:" "$rev")

excludes squashed commits created from

     git subtree merge --prefix subM --squash srcBranch

The --squash creates two commits:

1. A single-parent "Squashed 'subM/' content from", which
    squashes the changes from srcBranch. This commit's tree
    is like the one on srcBranch. It does not have the `subM/`
    prefix.

2. A merge commit which rewrites the tree in (1) to add
    the `subM/` leading directory, then merge it with the
    current branch. The merge commit doesn't have any
    `git-subtree:` trailers.

We must exclude (1) since the trees aren't actually compatible with 
HEAD. (They don't have the `subM` prefix). We must keep (2). The above 
`test -z` appears to do this.


I am *much* less certain about the second test:

    test -z "$(git log -1 \
               --grep="git-subtree-dir: $arg_prefix$" $rev)"

I think this was intended to keep the mainline portion from a previous 
`git subtree split --rejoin`. But if I remove this `test -z`, all the 
unit tests still pass—including mine. There may not be any test coverage 
for this line. I will probably omit this `test` from v2.


> It would be very helpful if Zach could comment on what was intended here.

Yes, this would aid my understanding a lot.


> If it turns out that all three tests only want to consider a single 
> commit then it would be be more efficient to run a single git command 
> and check the output with something like
> 
>      git show -s --format='%(trailers:key=git-subtree-dir,key=git- 
> subtree-mainline' $rev | while read trailer
>          do
>              # check trailers here using case "$trailer"
>          done

This is a cleaner approach, and I'll explore it for v2. Any objection to 
long options like `--no-patch` instead of `-s`? I find these are better 
for scripts since there's less hunting around in man pages.

Thanks for your review,

Colin

