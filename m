Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10037BA34
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687885; cv=pass; b=o6SZjB6ZGFrOFpD58AZ1B/GmtpPz/TcgwWhefhsRk+xOnM1r0r9qcc8lywWhSPi+/bwZf2qDqdvnHKhKvsZlHVchGyAnl4OczdP71lv6pGMVFWQflzljytBiKMOnn8sFwszeuMym4//b3kvpFEHPJcuZdHYqRRKRMoU48N/9U5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687885; c=relaxed/simple;
	bh=VDTklumHk1DV1epgDyvvyh67bULucyPPTultdPKzCiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnxJ5drN76hYYIVLJq2fb/HTthyfK1G+NM7erjsddodt+9rSIp+SDNGTpYlaeLMwhE4zyQSnsPT1uDEym6nnLlfoo6vl1g/UpPEwbq6Ff7su4vKz1h8h8J4NjaUBejfsibyl7alJvTf5kSEy1K5O+MZWMrbMBp7KiOlH3HUqWE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=dqJNq14t; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="dqJNq14t"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14EDE1C1F64;
	Thu, 12 Jun 2025 00:06:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-119-143-134.trex-nlb.outbound.svc.cluster.local [100.119.143.134])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 79AE01C2DD4;
	Thu, 12 Jun 2025 00:06:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1749686805; a=rsa-sha256;
	cv=none;
	b=vdf1vynP4lV8oUXhu36VnsdCAAvBI5RxLsc/dh6MrGSbnE4Zn8Vl7k1lnxmdediBlM//EU
	Q9/WprqrvrGvXZDE26sNNm84rRvV9BmGu8+/MyNUO0sDxpaMs6igxw6H/5s4dNOf0OG5K2
	wIq4QHXDD+SB4M178ZjKj0udqAeWflG+d7+egr33EVyQd+/E8VLd9aIiEvSrmEnbfxilcJ
	SHie7CntHTsfgrkHSQ/IICfF1v6hnlWR9EAmviM1Tet7rIvTgqqDSSY3hplqaEjoKYaXsx
	ttRy6oRGFo+lRs27tXIpyO9+C7aS7CmUrLzhv4GPk8YQNIe8vjdClkILAvlmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1749686805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7KMiQoUjEbe8iA51Jxld3Dvr8e75R1WI9yno7Uys5v8=;
	b=I7m+gHZSzvEmTgEC2C08q4xaOi/QUbXzDx7ITRMZk0aI3IkbcZWO4JVHy/qjPdhAtAG4ZX
	VvCj/DKAamurKYeiTuJDGcbTwF0Dq+ZwPZb7zZe4KofYRDLCSTaU+FX/i4P/9tuikz7JAv
	Ly7ig4rm6Yf5oM6EE9RztSvXrIhuMqZTcdqH3obB0sLsldzmAxFPCA6B9DmaCSNDq42rzh
	MPVNhwxG1keQsAXkMLF8BZ3SYogPikHxzb/r+IKcLp6MiMlFf6KL2nT3KXrK3jczRacAAN
	l5DM1Bl82lNR9Iw67Qziff/asP4MeT0M1rp+MRYk2D/5r/ZlGiuJxi3EFXA7Pg==
ARC-Authentication-Results: i=1;
	rspamd-6c978647c4-wnvrs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Trail-Descriptive: 3a12bc6876f00e0e_1749686805730_1429606846
X-MC-Loop-Signature: 1749686805729:3944657032
X-MC-Ingress-Time: 1749686805729
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.143.134 (trex/7.0.3);
	Thu, 12 Jun 2025 00:06:45 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bHjW86brNz4F;
	Wed, 11 Jun 2025 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1749686805;
	bh=7KMiQoUjEbe8iA51Jxld3Dvr8e75R1WI9yno7Uys5v8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=dqJNq14tss1aG7Z+z1JPt+CQb5iG6AaNxUsXdQYhxL4vCK9XOzDx+sg4PdwwsmHiw
	 S1HkrNVn9k6xTDeQ6It3Dj/1sdpx/bSS+i/+bRF9Xx9fhT4OiuQ/P7HUP0HCa3Hz+8
	 EOH3LP04LKcwAvQlLN7jAdG+jswp4RgBdmG1cauZM9MWb8M9F7BkRey/s4G+WUPBfC
	 AMm+tBTDe/awseRXnpB4qqgBfBVjtvfE3Fo+BWSfmDNkufE53yZcb3eJ1ggp+DSXjz
	 CM36f2ooWsDMNP8ORgoUtF7pG/eyakcFOFTgMzHorTZolQmSunvRLAr2hLrh+eRvJR
	 e4XLPqarL9cKg==
Date: Wed, 11 Jun 2025 19:06:42 -0500
From: Nico Williams <nico@cryptonector.com>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: RFC - rebase--
Message-ID: <aEoaEviYFuQQz04m@ubby>
References: <CAOc6etZm_+FPSgdwXszjqy5VBiQXNStEoOJ7-UF+h3AJhiQ_Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc6etZm_+FPSgdwXszjqy5VBiQXNStEoOJ7-UF+h3AJhiQ_Ng@mail.gmail.com>

On Fri, Jun 06, 2025 at 11:00:10PM +0200, Edmundo Carmona Antoranz wrote:
> So, I sat down and wrote rebase--, a pygit2-based script (yeah, I
> know, I am a shameless cheater :-)) that _attempts_ to run rebases and
> take advantage of previous merge commits to try and avoid asking the
> user to redo conflicts **if they are easy to deal with**. [...]

That's cool, but I hope not to ever benefit from it because I prefer
rebase-only workflows -- look ma'! no merges! :)

I use a different approach which is to use something like a bisection to
find the first upstream commit where a conflict arises -if any- so I can
resolve the conflict there where the information about what changed
upstream is most relevant.  This is the script I use:

https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297

In the comments you'll find links to several similar tools:

https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297?permalink_comment_id=4659501#gistcomment-4659501

git-imerge in particular is real pithy about what it does for you:

| Reduce the pain of resolving merge conflicts to its unavoidable
| minimum, by finding and presenting the smallest possible conflicts:
| those between the changes introduced by one commit from each branch.

But yeah, if you have a codebase that merged from upstream and now you
want to rebase it, then using the conflict resolutions from the merges
makes sense.  It's just I hope dearly to avoid merges, and IMO more
people should do that too.

I get that this message risks starting a flame war :( but it's not my
intent to start a flame war.  And I get that there are cases where you
have to merge features from multiple upstreams and cherry-picking gets
tricky enough that merging becomes the only viable option.  But if you
have to track multiple upstreams and you can help it you'll be much
better off cherry-picking than merging, and in all other cases just
follow a rebase workflow.

This sort of problem (rebasing or merging across massively many commits
upstream) is the sort where rebase workflows shine precisely because
your commits are "always on top", therefore they are always easily
identified as the commits you want to "move" to be based on a new
upstream HEAD.  With merge workflows you simply can't get the
information you need to resolve conflicts, and the best you can do is
"see how I did it before", but with rebase workflows and conflict
bisection you get to have the most pristine conflicts -- the ones where
you have the most local and upstream information available to help you
resolve the conflict.

Nico
-- 
