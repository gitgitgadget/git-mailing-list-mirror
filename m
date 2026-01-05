Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A32320393
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584194; cv=none; b=s96o84l643bz9PwQxpBao1/KFExmsuUBfA/uiY725852+epOngSJcqaMfjMi5sVOk87rqYc/rNDL5er4LjW2ob59sOLCBKePMURFLBGDe/NUCwPyOHEJKG2LkjL/mxR4JDJdEgzU9AWMJ3TShQ5Csfsi2IWy12LH9aF08clFIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584194; c=relaxed/simple;
	bh=+pE1PFODYOKR4744lXoRWVvJepC3Ta9EI9CiquSOR0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnbjJHMeUSA+KDZdTNO+yWngZaHy5QF4qpuKsoub9Cuav//EcC93aPrzZPeNmSMg42OEJn8pmDkeoKC3caYKX1rPrjYPo996w6Vo1jTKTLoWP4MWItHl8/PPO0f+nCVeRf4YHMRtCSrvRRijDT0Evie/N4Gz3/YkXYme85okBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=VktcT4kO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="VktcT4kO"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vcbOF-00EjUE-KM
	for git@vger.kernel.org; Mon, 05 Jan 2026 04:36:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=w5J/2K9U/0rUzflVkcNj+zSVcEOfEiyNuugcXtntTGc=; b=VktcT4kOtfetOiyyfGvvh145ig
	KDMDV/kBtVPNdCe5xH66kGlV79diobJ5us7+Xq2QtbkbRBQlrvsjRVm3ADak5dBCLPdu7FNxYuSpA
	VTmSYqQFTmktj48I51oWzjMgQKDf3NuFpbwKcM7UIHOk23sghMiBSxz167h1VAHNzx4CSPcJxojGo
	Rlo8IlhWFw++jnCUA2h/Vs+eOmTQLlVkNHDlD+2huEALha69FmazlXvLFJsh5csZ4gFKNQCr8QVTx
	0Ytww96gBMJ12FRwdGqol6bb5iDaiWXSJcyPzVGUNCO1/RJIGrtmcBAZVhf4uzGix+Sg/zNKaNRM2
	ZxqeevqA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vcbOF-0001Cr-70; Mon, 05 Jan 2026 04:36:19 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vcbOB-001Dad-OH; Mon, 05 Jan 2026 04:36:15 +0100
Message-ID: <4a9c1a5f-336a-472c-af1d-7011fad776a6@howdoi.land>
Date: Sun, 4 Jan 2026 21:36:13 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Git subtree regression
To: george@mail.dietrich.pub
Cc: git@vger.kernel.org
References: <e25b4d76-c1b5-4b6b-ba77-e1e2f7243ce9@howdoi.land>
 <20260104142733.2334796-1-george@mail.dietrich.pub>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <20260104142733.2334796-1-george@mail.dietrich.pub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 08:27, george@mail.dietrich.pub wrote:

> It does seem one component was added differently, as a non-merge commit, which seems break things.

> ```
> # Create a LINEAR squash commit for subB (simulating cherry-pick of just the squash commit)
> # This is the key pattern that triggers the bug - a squash commit as a regular linear commit
> (
>      cd monorepo
>      mkdir -p subB
>      git -C ../subB archive HEAD | tar -x -C subB
>      git add subB
>      # Create a squash-style commit with subtree trailers but as a LINEAR commit
>      # Trailers must be in the last paragraph, separated by blank line
>      subB_short=$(git -C ../subB rev-parse --short HEAD)
>      subB_full=$(git -C ../subB rev-parse HEAD)
>      git commit -F - <<EOF
> Squashed 'subB/' content from commit $subB_short
> git-subtree-dir: subB
> git-subtree-split: $subB_full
> EOF
> )
> ```

Yes, this is very likely to cause breakage.

Normally,

     git subtree merge -P subA --squash

makes two commits, in this order:

1. Squashed 'subA/' content from commit f00...
2. Merge commit (1) as 'subA'

Commit 1 updates the subtree but does *not* rewrite paths. If you `git 
show` one, you will see that it has files like

     subA1
     subA2

and *not* subA/subA1.

The path rewrite actually takes place in Commit 2 (the merge), via the 
`-Xsubtree` merge strategy option.

`should_ignore_subtree_split_commit` tries to search for commits like 
(1), which all have the `git-subtree-*` trailer. Normally, these commits 
either have:

* no parents, if they result from a new `git subtree add --squash`; OR

* only parents which are also "Squashed 'subA/' content," if
   they result from a follow-up `git subtree merge --squash`

We can safely ignore these commits—and all of their parents—during a 
`subtree split` if they belong to a different subtree.

Of course, that heuristic doesn't work if the commit has been rebased 
onto other unrelated history—which is what happened in your repo.

I suspect the best way out may be to remove the 
`should_ignore_subtree_split_commit` heuristic entirely. It is mostly 
useful for repos that use `split --rejoin` a lot, and the check itself 
is slow. WDYT?


> How the first two commits show up as verified, unlike the other times when I normally do `git subtree add --squash` and push directly to main, they show up as unverified.

git v2.51.0 also adds --gpg-sign compatibility to subtree. Perhaps this 
is what you are seeing?


> It seems you also need to add `clock` as a remote and fetch it:

Ah, thanks.

Personally, I'm a big advocate for the monorepo layout. In my 
experience, it makes almost every task easier and faster.

Colin

