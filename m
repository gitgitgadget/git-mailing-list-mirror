Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80D18DF80
	for <git@vger.kernel.org>; Mon,  5 May 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452784; cv=none; b=PinesOLEz5nFeLSpMbKeg7y1LPXbZlj4de9B7Y1ejjlRLI5WBdpQ3Q+etc6fUJUhiCJoF64P1wBco1oEU7hpLis1fYwYBbtykrvKabf5m3vKEL1mvhIPac+cI7IQSPdfogyp6Gz0dOf1bwINJSZXElJ+ZLwrR/+foKtC8HtD39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452784; c=relaxed/simple;
	bh=B8F84qnGp0kWbO6Drexh8dRe47ieL+zyLK/Toc/QgRg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tczuQHtvYasADg1OU/f0sY9QMmhatt+I7xe5gntfhQ9tKI5jLrW+0TDrjKHjNHHThK5tPD4BG72W0dI4iQXF3i1rexL/dkyyibLiLTPCrJXruK393//IGqtTvfFdw/kvoNlwyZB/puzU50QcMIS7o9gLcPyjCGWUm2yz44UDK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FxVXN9v9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FxVXN9v9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746452774; x=1747057574;
	i=johannes.schindelin@gmx.de;
	bh=B8F84qnGp0kWbO6Drexh8dRe47ieL+zyLK/Toc/QgRg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FxVXN9v9WJdoW4kqlFKh48owLwgWadQHpACsPhN3W9PyZNF+xvq9Y3/inBwFWf2Q
	 jCG0qJB7h4kk60IU2uFkh/8DI6+vIZIyFkxyh4IoxCz3HvrbdlOwKHNZVcSzSSZid
	 blozGzQnOaLRaAhcRMwii245nNGztRx5gSDN+XvzDeKjAExAXnB+P3rBxkMTNCZMF
	 1tA0aEWXVFkh/VlXCe+n1TD3LjkpPwpYDcNfnckDtlMtK6ZAPB1iMY+0snpyE7ZfD
	 yBKTjYAUhWGs8gMV1nDKPriaO+llpbyZQ/DVTKhY+zCwXkiGe3p7108zvkUQMs6TN
	 jeC3FtuSGtriDr0yYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1uodTf2LhF-00o707; Mon, 05
 May 2025 15:46:14 +0200
Date: Mon, 5 May 2025 15:46:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 2/3] contrib/buildsystems: drop support for building
 .vcproj/.vcxproj files
In-Reply-To: <aBi8KQWP4YAi6Gph@pks.im>
Message-ID: <ddcbbd1a-dd36-a115-aa77-d5bd3c210cd7@gmx.de>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com> <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com> <aBi8KQWP4YAi6Gph@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UTjqklH+4VLCAfeISzVzbTRaUn8tNzM5X/xJv8D8zZxJjCtVdJX
 fQ2yYWSA0CKTcufYqIiReSAu8IP8+3+Uvikpmdq1jnpcQQmy03fGyEY7gAnmO6VIxAS/ZJE
 IzEg4O3aRagIK4LLOM3Y8V1KHh6UOZsxbJSniW18zS5SUY55wkGNx+UVQE7D7RvMPcvK1Mo
 q9wQfB1JH2uUyQLo9zBWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ew3UvbytX3c=;Xh8qHV6rfzz0QDM4swYFmHGqPte
 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

Hi Patrick,

On Mon, 5 May 2025, Patrick Steinhardt wrote:

> [I] wonder whether we also want to get rid of "contrib/vscode", which is
> similar in spirit. Both Meson and CMake can be used natively with
> VSCode.

I would like to avoid that, as the `contrib/vscode/` files do not even
have anything in the way of building Git. Instead, there is a
configuration that allows Intellisense to find the symbols' declarations
and definitions, and it specifies a little bit the style conventions as
well as common terms that the cSpell checker benefits from.

I use this on almost a daily basis, so I believe that `contrib/vscode/` is
in a _much_ better shape than `contrib/buildsystems/`' Visual Studio
support code ever was. For that reason, I am a lot more in favor of
keeping the `vscode/` stuff.

Ciao,
Johannes
