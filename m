Received: from mariecurie.slightlybroken.com (mariecurie.slightlybroken.com [116.203.185.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134E2905
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.185.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737286165; cv=none; b=bTr4z71s4XRyn0wOqBk+eFpsO3YZAfjdI5ar0szROMjdomsbO9BxzwTpHeDeJGBpJ5pwFeWYp/Z4ucJj/z6fTYv9I5KErut52SYbvsb5LC3Z2iuEgZBMjSCoHz/cISgsQLgD7dissTxlgqn9nfkdbxM/JKy5fpzC09F+HTxMVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737286165; c=relaxed/simple;
	bh=E5ppgMwio0uQULsrPZEw6zWv65woLvFa4S0Gqo/fKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7WMTeW+7xzWvSUYF1CUPWZDS8jKAB80k6Q2NJKh0+zZVakmhE1CKzvKBrhsBkSOV53qZS57cAY5PWZoC0s/fti4WQJV+pc5os1lxnlK0bJzfJbMzLgPYDRyr9jd/jH5Tdy+wWt8WIFtaVTHM6EzEvfKlxODfTCoPsGUQ9jEObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space; spf=pass smtp.mailfrom=labrat.space; dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b=OYq4KTlb; arc=none smtp.client-ip=116.203.185.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labrat.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b="OYq4KTlb"
Received: from labrat.space (46-126-49-17.dynamic.hispeed.ch [46.126.49.17])
	by mariecurie.slightlybroken.com (Postfix) with UTF8SMTPSA id 6C1BD6303B1A;
	Sun, 19 Jan 2025 12:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
	s=201904; t=1737285683;
	bh=E5ppgMwio0uQULsrPZEw6zWv65woLvFa4S0Gqo/fKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
	 Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
	 MIME-Version:Message-ID:References;
	b=OYq4KTlbBQ3bJX7+Ju0XdfJrruEqdePkzb/5oxSUqD6ZA+rysnslJRHTFOZyT+7Nj
	 wwD7zvFNTWRhYLLZXq/DxmSG8pt1wa1M+oL/ppsPvS3cm+41AwOasdBla0+JmtmI/o
	 NNqreqR4++7NuSn2FGtV4otXiOztvROT6mzAaxgPS6/WTuV8U/uQ6rSXRqkTy4ci+3
	 MHUy+haMP7KWIB6q6acmUKq/M0EZAG9WtvSmTkaNG6TyAHYxVnOvvKWKKEEI/sjl14
	 xo8Vk0paoxlknWUmsw6XkQJ2U2zQ4dzV3PDqD1V27r49wRGaxxRE2Z4cKc0kRz1GKu
	 uG4K7bjisgbvg==
Date: Sun, 19 Jan 2025 12:21:20 +0100
From: Reto <reto@labrat.space>
To: Tim Tassonis <stuff@decentral.ch>
Cc: git@vger.kernel.org
Subject: Re: Erase a commit from a git repository
Message-ID: <lyk3ps7h36bld6jh2uptzzdxpikjdjxnhcenc22rpaqobzw3ct@u22qnfbquwmi>
Mail-Followup-To: Tim Tassonis <stuff@decentral.ch>, git@vger.kernel.org
References: <db7ea8df-2f37-47b9-828b-67b8d3068232@decentral.ch>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7ea8df-2f37-47b9-828b-67b8d3068232@decentral.ch>

On Sat, Jan 18, 2025 at 09:50:31PM +0100, Tim Tassonis wrote:
> As this sounds like quite a lot of manual work, I wondered if there is an
> automated process for this?

Sure: https://github.com/newren/git-filter-repo
