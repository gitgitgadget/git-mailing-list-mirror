Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FC2AE93
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409160; cv=none; b=UULTQ8vMyV/X71dA37vTgbSdUmKSO36kyOFw+qquO1zH9XcZ7xVOZIZAUNKADfLGZ1BHRjmpMJSDrJ5m0pHoEe8+PiZXWMm4SGqurWgc/R/H7UVvoZ/aqWROhf70zwfMaluHwTV8BQ+WBGT6BGYcou35EeLpU1kIWIxPcrGMRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409160; c=relaxed/simple;
	bh=cofzQgmthNHhe5SUJ8Z4sU5sEhuNqqAecFVVqWij62E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YlJZrPBB8AO5eChSTo56sUCd5FOZoWDJWXl2OLPa9Ba14WkVITqxjkj8CNPYlg0pwhXWyQuJeuWPfpV/Iu64paf+qXurGWfHdfr3k7YOYLf9qiUuynEtGKr1uaYt/dWnL9ugy0+K6JmyEztusHNBUalt8mzp7R8Th6lqttRefiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JBzVVdEg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JBzVVdEg"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714409154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Sc3LHvjRlZL/G1Ry94qsmsOyOwDmMYFo//JjkIA7g=;
	b=JBzVVdEg6Rk5VVOFkjp9jFaa6eP5WT/j2DsXpjuPOHuPeHaFCB1OAjKTlc3Z/iT5dkuXNs
	0u/HPCwy5JjToQEgtd7Z/qPCJUDWFOQkpab5Px9HkVwB2r34G+Ps3W4O417izjPfTnO6x7
	cjQo6M2lj39MEtn9B7BDCLO7aqbVK+aXNPJvgblGqWnRcsS7WCsd+pz58cQE+GuKbkn66K
	r1XJfd22vxwGbFVGCbweZf0mK+rDGHFlCGcNLiAi6koJpZQIGtPppQ11dSuNvsg1QO6E2B
	V5m9X4cZT+QSnC+CWw5mf+3mhle+gcIWVfhjryvq/W9hBygDFmrt1nlnJFDeeQ==
Date: Mon, 29 Apr 2024 18:45:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jakub
 Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, Kaartic
 Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n?=
 =?UTF-8?Q?_N=C4=9Bmec?= <stepnem@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?=C3=86var_?=
 =?UTF-8?Q?Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, Brian Lyles
 <brianmlyles@gmail.com>, Max Gautier <mg@max.gautier.name>, Adam Johnson
 <me@adamj.eu>
Subject: Re: Draft of Git Rev News edition 110
In-Reply-To: <CAP8UFD1Feotp4ra2tpeA7+iRiqDOFzLsQbzw6mUDqt1Uq1oTVA@mail.gmail.com>
References: <CAP8UFD1Feotp4ra2tpeA7+iRiqDOFzLsQbzw6mUDqt1Uq1oTVA@mail.gmail.com>
Message-ID: <393d03f2aa814010cfaed0d73cf424b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christian,

On 2024-04-29 18:41, Christian Couder wrote:
> Hi everyone,
> 
> A draft of a new Git Rev News edition is available here:
> 
> 
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-110.md
> 
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
> 
>   https://github.com/git/git.github.io/issues/705
> 
> You can also reply to this email.
> 
> In general all kinds of contributions, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub,
> volunteering for being interviewed and so on, are very much
> appreciated.

I just read the main part of the current draft and it's looking
good to me.  Thanks for preparing Git Rev News!

> I tried to Cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
> 
> Jakub, Markus, Kaartic and I plan to publish this edition on
> Wednesday May 1st, 2024.
> 
> Thanks,
> Christian.
