Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268B31715C
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776399304; cv=none; b=ikDrtgyjE30G5+i+bf3GztodREgw0GJM7OgtQ49/zL/nM3Y/riMKu0SZBZ7LRD04Sc9N/UxcGuOZ+0LZ9UbE2XgjJGPONvC3bNnwKGRCTjOvBB+f3VR8vxpjQwHDzzdOYyQgLF/Uf+FEJeZoTR54gehSjrNbcaduwLmasPqRCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776399304; c=relaxed/simple;
	bh=Aku53tMzxI+4YLwx9BXrGqirrhudywY985+13lTteYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnJNoLVEWYXf7Ey/Se/zY0XPbfek0zR36HFf0M+rysKUjLqYGl37ew6YQrNO8wFxi8TJHezPGJyVavb5jJWDXaKj4An1+ixWWTYah2kKz+LFSUvCh+ay1bEKdjhHx55fEpaBn2mZrvjxcz+8pI3BQfpIsjUcJbFujPkJaIM01mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=wvnOr5qQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="wvnOr5qQ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDabT-005LSh-S3
	for git@vger.kernel.org; Fri, 17 Apr 2026 06:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1NRMlTllxiWR0g51Esp83GZoy3yNjzVFoZh5P2GpPO4=; b=wvnOr5qQKOwa8BJB/J4goQ2xEv
	XkQWLj71caP9pIFifwNoUhWpcEHMYLZ6uJiA3Lk/SKM7hOHF8bZCWrxs9/pewNPpw7VFpwysh1by7
	eA0NqRk93cKpfRV+f8ylTVeigig0b3+KHQrKQrIqGPWAdWZHg9QMYn79h3yEK6sSdgHfBoHMAgPBg
	F3YlDYD2Rykk1WKo+E7TQGmUSXSVhwnnJ58yME5VKJyRJk6DBHBcxOMslyH0Rk6sq8qP11+IT76wJ
	LlEcnEtPSiX/zJxYCLCwn6hweqj6CCVJ1/fYoFBCwCnNgYdQiDPHU7S6Lr1drHQP042X+oXX01yY/
	/+L5k+bQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDabT-0007rh-HU; Fri, 17 Apr 2026 06:14:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wDabO-0032NS-QR; Fri, 17 Apr 2026 06:14:47 +0200
Message-ID: <d1b51a09-acc8-4354-b5bc-f50a13e7c3fd@howdoi.land>
Date: Thu, 16 Apr 2026 23:14:43 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git subtree bugs (mishandled merges, recursion depth)
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org
References: <26263.63341.878041.155047@chiark.greenend.org.uk>
 <e9611b58-3886-4f04-8f49-16d140ebfc15@howdoi.land>
 <27104.62121.658449.222834@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <27104.62121.658449.222834@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/26 09:31, Ian Jackson wrote:
> Colin Stagner writes ("Re: git subtree bugs (mishandled merges, recursion depth)"):
>> When merges come into play, the task of choosing which history is
>> "important" and which history is "not important" is not always clear-cut.
> 
> I have some thoughts about this.
> 
> I didn't find a formal description of git-subtree's data model, or how
> git subtree split works, precisely.  So I'm going to make some
> suppositions.
> 
> I observe that git-subtree split doesn't record any metadata in the
> split versions of the commits (for example, the downstream project
> commitid they were split from).

This would be helpful information to have, but git-subtree does not 
record it in general.

`split --rejoin` mode *does* record the parent→split commitid mapping. 
But this is only recorded in the input history, and only for a single 
commit. --rejoin actually isn't as helpful as it may first appear.

Keep in mind that no part of history is fixed. Both the input history 
and/or the split history might get rebased. If that happens, the 
original input→split commitid mapping is either unhelpful or misleading.


> Repeated splits ought ideally not to constantly generate additional
> material.  So the algorithm ought to be deterministic.

The algorithm is deterministic. It does need to reconstruct the complete 
split history every time, which is inefficient.

The real issue is this line from the git-subtree manual page:

     Repeated splits of exactly the same history are guaranteed
     to be identical (i.e. to produce the same commit IDs) as
     long as the settings passed to split (such as --annotate)
     are the same.

which means that git-subtree SHOULDN'T change how splits work… but it 
has anyway. There have been many fixes to subtree-split over the years 
that have changed its behavior in history-incompatible ways. This 
guarantee really hasn't held up.

We really need something committed, like a config file, that records:

1. how the user wants splits to happen *now*; and
2. how the old split history was split before

That way, we can introduce new functionality or approaches without 
introducing breakage.


> An easy way to do that is to make splitting a pure
> function from downstream commits to subtree commits.
> 
> If one can run git subtree split on every commit in the downstream
> that has a git subtree merge as an ancestor, then one might think that
> means the split must produce as many commits as there are in the
> downtream.

Part of the problem here may be that `subtree split` is not particularly 
aware of `subtree merge`. All split sees is that the tree has a 
different prefix. Changing this would introduce history-breakage, and it 
would be good to make it opt-in.

You can also perform subtree merges without `git-subtree`. Merges done 
this way don't record any information in the trailers.


> But we can map multiple downstream commits to the same subtree
> commit.  Consider the cases, for some downstream commit D.
> 
>   0. D is a single parent commit that *does* change the subtree.
>      This becomes a new commit with parent split(D~).
> 
>   1. D is a single parent commit that doesn't change the subtree:
>      We reuse the parent's split: split(D) = split(D~)

I believe both (0) and (1) are current behavior.

>   2. D is a multi-parent commit.  Determine \forall{i} split(D^i).
>      Discard all split(D^i) which are ancestors of any split(D^j).
>      If any remaining split(D^i) is not subtree-treesame D,
>      or there is more than one remaining split(D^i),
>      construct a new commit with those remaining split(D^i) as parents.
>      Otherwise all remaining split(D^i) are the same,
>      and they are treesame to D, so discard: split(D) = split(D^i).

The merge processing is where a lot of history-breaking changes have 
occurred. There are probably lots of edge-cases to discover along the 
way. I recommend drawing lots and lots of pictures.

>   3. D is a subtree merge commit.  split(D^1) is explicitly stated
>      in the git-subtree metadata.  Calculate split(D^0) as above.
>      Then calculate split(D) according to point 2.

In a git-subtree-merge, the merge always has two parents. The split 
history is always on the second parent. The trailers are mostly useful 
to tell you what the prefix was… but you should still check the commitid 
to verify that no rebase has happened.


> Do you think it would be worth me prototyping this?

If it's worth it to you, then it's worth it. If it's good, others will 
want it too.

I've tried lots of git workflows, including submodules and subtrees. But 
I've found that a regular, plain `git merge`—with a "merge upwards" 
workflow—is by far the fastest, easiest, and most flexible. Whenever 
possible, I arrange projects so they can work this way.

I do use plenty of subtree merges to bring in dependencies. subtree 
merges work great for this.

At least for now, a `subtree split` does not undo a `subtree merge`. If 
I'm looking to submit changes I've made on top of a subtree merge, I use 
format-patch

     git format-patch --relative=my/subtree/prefix ...

to make patches which are layout-compatible with the original repo. Then 
I `git am` the patches in the original repo as a topic branch. This 
works well for my purposes.

I only use `split` to produce repos with read-only views of 
subdirectories. This is mostly due to a project design quirk that is 
beyond my control.

If I fork a project, I'll just fork the entire thing. No need to split it.

This is how I work, but you'll find plenty of other opinions out there.

Best of luck,

Colin

