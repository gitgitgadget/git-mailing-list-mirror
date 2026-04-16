Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47503BA248
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349871; cv=none; b=GR2bw+f3BidTW9r+Ov6Oez05vUI7leTu07IFWGiIBd5+QFpvKfZrfgVshoSxXb3/OfdYM9Elzs4Op22+Nqi6vgHlOA14dtx9hwmDTQXvFG+jpuUV6G9JoYEU2PbtqMBVHw489ui37PnySnbJxGZuluenlWHbGOKHUd60aU53YSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349871; c=relaxed/simple;
	bh=nvJSMguOGNZLCYDyOshKv0ezKeF9fRz2qCjeZCL+GjQ=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=oMwCHRls9hFPgu4NPooxyxGLbdh/k2DGYdnqLrTeRqMgW6nftS+VeWAF3/un9XV5EdUhyQDvQUsnBMlr2eg+Jj2Pp9Zrh/bpT22FAin93XdkMoUeB6kHo3G+XzmAF+0rcQlIpqOzLClyyy+N8w68Ss/xMEFv2UjYHgwWtGnVbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=Af0WZ3Bv; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="Af0WZ3Bv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=e.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=HjIHLaXOD1s+NdBj0TkjNdLRYFz1ostv6tLxYOamijc=; b=Af0WZ3BvAD5H
	UDJv2DLWNp0k6acIR9A+YBpffOhqx+EHZEseIlS3qXZnwYoqqTkGbWy1WnY24RcJIV6YsNGILuQiF
	vd4hTQRTEV8citsVRY23Xj3Ifq1qb6vwJE9r5AownL6vWaz1QIdD+80HXNgR+kLRaJ+yGgSS7DpnA
	4gZcVhgSW3vtHipesk86ape6IDNFgOQXQrWNJIGL8ft8wj2llRIRlSGg68FcMHcGyUU094OSb1cte
	4nqW8ZF8/zR+C7HDMFLOH1WelZ8WPQc8zN5YghcJKlx21VpeRs2PFLWppc5Eg/bZaDZu95KT9RL5E
	uU0ifVboxuB7tw35jEx8CQ==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wDNkH-0005hD-MZ; Thu, 16 Apr 2026 15:31:05 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27104.62121.658449.222834@chiark.greenend.org.uk>
Date: Thu, 16 Apr 2026 15:31:05 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org
Subject: Re: git subtree bugs (mishandled merges, recursion depth)
In-Reply-To: <e9611b58-3886-4f04-8f49-16d140ebfc15@howdoi.land>
References: <26263.63341.878041.155047@chiark.greenend.org.uk>
	<e9611b58-3886-4f04-8f49-16d140ebfc15@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/63/6398e3c18559ae9fcc00a4cf06dd3d8f.pem

Colin Stagner writes ("Re: git subtree bugs (mishandled merges, recursion depth)"):
> On 7/17/24 11:55, Ian Jackson wrote:
> > Actual behaviour (git 2.20.1, Debian ancient 1:2.20.1-2+deb10u9):
> > 
> >  Takes a very long time.  Everntually produces an output commit
> >  which has most of arti.git#main in its history.
> 
> Even with my patch series applied, there are many more than a "few dozen 
> commits" in the history. For me this splits as

Hi.  (For future reference, that patch series is
  [PATCH v2 0/3] contrib/subtree: reduce recursion during split
in the other thread.)

>      9a2422685e6cc05625f47a1fe709f1908f31fc87
> 
> with 12307 commits in the history graph.
> 
> The reason for this is likely e7b07376e5 (Merge branch 
> 'rs/subtree-fixes', 2018-10-26), which was merged around that time. 
> Previous versions discarded too much history, and that patch series 
> added more merge-base ancestry checks.
> 
> When merges come into play, the task of choosing which history is 
> "important" and which history is "not important" is not always clear-cut.

I have some thoughts about this.

I didn't find a formal description of git-subtree's data model, or how
git subtree split works, precisely.  So I'm going to make some
suppositions.

I observe that git-subtree split doesn't record any metadata in the
split versions of the commits (for example, the downstream project
commitid they were split from).

Repeated splits ought ideally not to constantly generate additional
material.  So the algorithm ought to be deterministic.  An easy way to
do that is to make splitting a pure function from downstream commits
to subtree commits.

If one can run git subtree split on every commit in the downstream
that has a git subtree merge as an ancestor, then one might think that
means the split must produce as many commits as there are in the
downtream.

But we can map multiple downstream commits to the same subtree
commit.  Consider the cases, for some downstream commit D.

 0. D is a single parent commit that *does* change the subtree.
    This becomes a new commit with parent split(D~).

 1. D is a single parent commit that doesn't change the subtree:
    We reuse the parent's split: split(D) = split(D~)

 2. D is a multi-parent commit.  Determine \forall{i} split(D^i).
    Discard all split(D^i) which are ancestors of any split(D^j).
    If any remaining split(D^i) is not subtree-treesame D,
    or there is more than one remaining split(D^i),
    construct a new commit with those remaining split(D^i) as parents.
    Otherwise all remaining split(D^i) are the same,
    and they are treesame to D, so discard: split(D) = split(D^i).

 3. D is a subtree merge commit.  split(D^1) is explicitly stated
    in the git-subtree metadata.  Calculate split(D^0) as above.
    Then calculate split(D) according to point 2.

In fact, 0 and 1 are special cases of 2.

Do you think it would be worth me prototyping this?  I think at least
for my case it would produce considerably fewer commits, but until I
try it that's just guesswork.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
