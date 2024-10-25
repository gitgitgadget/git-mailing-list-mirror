Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193811B78F3
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890697; cv=none; b=gI/v4fBKjP1gtvGanQf+Mw5x1DfK1OZdyEDvKTSJWuQaylPGbP7phjTZ+Abyzq0tM0wNMnhGVPY2fyejH73P6cODfVnEESj/EuN2rTz+Dkrco1mQfVHHfRZDhjYxxnX8JzPqRNFK8o/PLDAMTjUmz6jMHJEPkOfO44dSNAQEvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890697; c=relaxed/simple;
	bh=ZvRJD+0pk2FhzXg4pxpxtg6QO2dc86dueIKaHKk/bXg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0N53Qq6ZWdIyj84v+ZzLgvWT+YO1ZwW8SaKyDePBcoPsc5TQD1Zsq2E9yw5nnZReVBZXaDgGrUPt6hcMntmpEbWChvB+yv6/xWDK1dmXfLlabRvvAopdfZDP4CReMGLH/IudRsqHr4UzXVouJ7V5IWZnEbZRItEw+91jhOsYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aedG6nlg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aedG6nlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729890692; x=1730149892;
	bh=dQwLlrx3Xqv90pJ+AdRhVr5NK+AE+9TwSZjQyrVeT1I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aedG6nlgAppeByV/WsR5l5/yAl4+Lc0+0hMozLcwprLv/JGe7GuBTXxSLJRUXNpty
	 6GzKKDsI8ZO8VqasMbm3jweurku4vmuNfxgApGku9V3wi/LhDwigNhHQXLQhnomeRx
	 Q3QLqeQeHnXQNduBwcmmm6aGAoUSZ2l4rVwHmBRywZXHD73z5tpQb3p12YUqp99zvp
	 hzaTcXVxbmEWn8RmhFodSckM5qWSIe9HPU3A5bItEXUrV94SLhH+nGwy9JDmVPPTkc
	 9QMdS6ZIRLz7muikF6e5LfTzSibL09uiRaEqFgINAG/97Ous56rmo7E3UrOcp/ESMs
	 X6dcn6wj1vagw==
Date: Fri, 25 Oct 2024 21:11:30 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <D5572ICCKQXT.3UQ8AJ2GSUZIP@pm.me>
In-Reply-To: <ZxwIEcUKMELmxeMh@nand.local>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me> <ZxwIEcUKMELmxeMh@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2ee466a731128554f2210a2b2f45452a69726013
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Oct 25, 2024 at 4:05 PM CDT, Taylor Blau wrote:
> On Fri, Oct 25, 2024 at 08:57:17PM +0000, Caleb White wrote:
>> Caleb White (5):
>>       worktree: refactor infer_backlink() to use strbuf*
>>       worktree: support worktrees linked with relative paths
>>       worktree: optionally link worktrees with relative paths
>>       worktree: add test for path handling in linked worktrees
>>       worktree: add `relativeWorktrees` extension
>
> The previous round was already merged to 'master' a few days ago[1],
> after merging it to 'next' and saying so in this[2] WC report.
>
> I'm not sure if you intended to send this series as a follow-up to the
> state that was already merged to 'master', or if you had intended to
> send a new round of changes not knowing it had already been merged.
>
> In either case, can you please send a new round based on the current tip
> of 'master'?
>
> Thanks,
> Taylor
>
> [1]: 8e08668322 (Merge branch 'cw/worktree-relative', 2024-10-22).
> [2]: https://lore.kernel.org/git/ZxLI06smvMuf%2FcT2@nand.local/

Ah, I must've missed that---I was in the process of working on v4 and
didn't realize that it had already been merged to master.

I'll send a new round based on the current tip of master.

Thanks!
Caleb

