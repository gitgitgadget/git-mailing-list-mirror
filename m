Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FA378D8C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087264; cv=none; b=MeHEBUtvq2vKYgE4KIo/a2Tu3f9eefoeJoHUySd83xm+4vGUPKu20WFHQe0loWuJ3ND9OmhzYWxPsGorIJzn9uW0ugaQ7DtFCBdZlUKZr/UeLPBSgfWhLwfQYxCDrpEqQWk4RmNBUeT8bc7dhCtM9Vr1fOLP1yiI7txGMp1mR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087264; c=relaxed/simple;
	bh=NY0UKV89Zilq+8aP6l+YYiofJbNzzFTLo3FOs0JlLpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKUPHsseqc13f3ubUoCUp18pAchtIauKwqglkRRlFg8DI/JGHw7OcfDfKsDFxrVStUKty747RDn4BkJxt6IIxKXouMxfVOUspBynw4hehohcYOB/mtSXNT2X90HfHjvL0UWclKcyurGwr02ChJ98bYzcZsPGRelg4iUnTWvhP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=BeeNXjB3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="BeeNXjB3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wjqap-00161B-OO
	for git@vger.kernel.org; Wed, 15 Jul 2026 05:47:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=k7Zbx6dosBW8ymNsBBhpv+52N/B5L4mVScu6owqD8CM=; b=BeeNXjB3j0AmC5kgjGXxq6pkHE
	Cpk0C0IVbEjq6mI3nlWAr63YeITyBylyYEMgdI2sm+uoojoogsZ4VUKDqG56oyd3JrX8+vkivbg3N
	vWtyvQSIIGUUC8kpsjZ5K3vOdXEdiPK8Jamdx/ncs5CvI1IVWoZDC4CGLVYDfkyRtkDjj5BnQbv/X
	ToX1iwNXEG4PMk5WZhFJVSN92jYIhaQooP9+IDvf0nTDT7IKGpJx+SJV1t34QJpWR3gjza1yUh6Jx
	OCkaHQaabKed1GWAedk0FFgLEpWyHbrtxixvgdB+uJF8X3QOJZlb6+xz34d5RPAP48JoaWAN0V5jE
	YHIZoN5g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wjqap-0005ll-DW; Wed, 15 Jul 2026 05:47:31 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wjqaW-00Gtpt-Ig;
	Wed, 15 Jul 2026 05:47:12 +0200
Message-ID: <b2e0142c-f8d3-442d-b3e7-63233ab88a17@howdoi.land>
Date: Tue, 14 Jul 2026 22:47:09 -0500
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
 <c8b81987-ab56-4d6b-a650-879b84597a17@howdoi.land>
 <27216.58259.815175.923629@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <27216.58259.815175.923629@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Nothing here impacts the patch under review, so this is a bit OT, but...

On 7/10/26 07:20, Ian Jackson wrote:
> Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
> 
>> git-subtree.sh doesn't really deal in "upstreams" in the git-branch or
>> git-merge sense.
> 
> I'm using "upstream" in the wider sense; here, when you import a
> depedency you're downstream of it.
>
> I want a term that talks about the logical (even, social) relationship
> between the two projects; and it should be one that makes sense from
> the point of view of the upstream.  Talking about the file position
> within the downstream tree doesn't make sense from the upstream's
> point of view.
It may be useful to differentiate between command documentation like 
git-merge(1) and tutorial documentation like gitworkflows(7).

The man page for `merge` reads like: "So you want to merge THIS into 
THAT? Here's how to do it." The banner-line example is merging a topic 
branch into master, but the "social" aspect of this is not front-and-center.

Other common terms used in merges include "ours" (HEAD) and "theirs" 
(MERGE_HEAD, "branch head," "commit [that is being merged]").

gitworkflows(7) discusses the social relationships of branches, 
including the "merge upwards" workflow. Here is where we find more 
social terms like "upstream" and "downstream:"

     The merge workflow works by copying branches between
     upstream and downstream. Upstream can merge
     contributions into the official history;
     downstream base their work on the official history.

But "upwards" or "upstream" is merely in the direction of increasing 
stability or acceptance. This makes the terms "upstream" and 
"downstream" very broad and inclusive. An upstream branch might be in 
the same repo, a parent repo of a fork, or an entirely different repo. 
The repo might be yours or belong to someone else.

Branches are branches, wherever they are.


> I think the dependency relationship is inherent in git-subtree's usual
> use cases: suppose a project A gets merged with git-subtree into a
> subdirectory S of project B, so that B.git:/S/ is a copy of A.git:/
> 
> Then I think almost invariably, this is because A has B as a
> dependency.  And A has B as an upstream.

"Dependencies" are perhaps a bit beyond Git's usual scope as I 
understand it.

For subtree merges, it is possible that "largely unrelated" minirepos 
are being collected together just to make them a monorepo. I have also 
used subtree merges within a single repo. This is handy to keep a 
subproject isolated on its own branch for reuse elsewhere.

For splits, it's possible that history is split just to meet the needs 
of some other build system. I've observed this in the wild with AUR. 
I've seen multiple AUR packages stored together [1], but they must be 
`subtree split` first with aurpublish [2]. AUR users have been on-list 
before to report trouble with `subtree split` that I inadvertently 
caused [3]. They may be very interested in your rewrite.

In conclusion,

* Documentation is hard!

* Consider focusing "command-level" documentation more on mechanics. Use 
very specific terms like "branch," "(sub)tree," "merge-base," etc.

* Consider using "upstream" and "downstream" in the context of the 
"merging upwards" workflow from gitworkflows(7). It is not necessary for 
these to be in another repo or even a different "project."

These are just my recommendations, and they're not relevant for this 
patch series.


>> I haven't tried it, but I think if --squash is in use, then attempting
>> an unmarked subtree merge will probably die with "unrelated history"
>> warnings.
> 
> I think that's not guaranteed if squash merges and non-squash merges
> are interleaved.

Probably true.


Colin

[1]: https://github.com/christian-heusel/aur

[2]: https://github.com/eli-schwartz/aurpublish

[3]: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>


