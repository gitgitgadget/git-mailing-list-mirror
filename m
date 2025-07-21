Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE323AB85
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130275; cv=pass; b=lHUIn1suIIGEMPWsc8mE1LVWfX+iLCjrUKh8nL2d0wPpXbZxzkiF+UZRuPag7KZQUQZInlYrN0zRJSkh2WzHWowZ1IHQQj1IpfPpYlbUu6tOIX11PWxLFXTxjuliVpzZrB6sOvaVLE0oK1sLo/n0cVVV6L+d47tZzaANh16ezYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130275; c=relaxed/simple;
	bh=3FwI2lexIzewZfkRw+ZxVrrOYw0um2ivgV6/yGP4GgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsSPoJllpm4n54mjyrCpSJl3nYQ5MoO/mO8+vWzaBzrlwv5kKWWFIZARXepan+RvAF3f0vO2BYh+OYb9vtE6jim3OsKdMoBrm6Il29ieKrNCP1npWYLqjISXD4Ig6PW/i3BCYbA8DFNrvRHYLATQ8su753ByAej1+96k4H9jCrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=FNEWbc6s; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="FNEWbc6s"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 73D62844C9A;
	Mon, 21 Jul 2025 20:29:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (trex-blue-1.trex.outbound.svc.cluster.local [100.120.34.94])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 25BC28448BE;
	Mon, 21 Jul 2025 20:29:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1753129763; a=rsa-sha256;
	cv=none;
	b=HruVRfeezZLdnfCRQU4DGYF7nAOHp8ldXNATqY+44bK2AfZPkXvcjZ6cl7PkOqtxPJzdIG
	iBou0to0Q1C1k7yXVJgUTYqK1M57U4hlTVJWLUhiUrJdmD6VbAUzsJ+Lkbx7guLuJQ+LeW
	fPgE2Moqc/GYFFr7fXaSJszh/+F8xKcMDUfgo0bPAr3LxwJKRHrjv/cKdP/t0H8BRm2Jc3
	+2eVnsBRmzFVd5N2vz5bZyzNK4DP1aK6xitOgMz62IbIl2VyVQIdlA3M4kD/SDGeKie1rg
	2YV3DJ1xlB12vNo/f4P8hpI6rdJF0WPtVupgZNUEdb+0x6vfyCEXYBiqI6CkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1753129763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NUGB94Q/uJTIbaksSFnSTp2w59V3ekAoZtrk5N8qg4M=;
	b=zwU9WIqKsXdYOIVTbr4VDNh+IuHdaff/ztGetpnKXXQsqVEYXOBH4pjFBfaBPDjvq7x70M
	DiSQmrYSs4r6YYegJXfe1X9v0ui7loaSU5NGamkk/0kvXKKD6Nf/VTaNvTOnjl3vdD7tlN
	FJQVYRlskOL1R5xNkICGOQeTa2e0BZ9ab99ZXyuceWuRPsPVrEyg9aTQsQcKro0tdd19+U
	bJ9CdXoHO43Ci4rl1/589XczohlepA3+RPev0VwukTX3LD/E51el+8SphohdbRdX37F6CA
	dAQVviDBZjUklqhspDvQ1+b5OZF7SCd6EjYXpdKySsCPwi4P36VYT+6sabF/ow==
ARC-Authentication-Results: i=1;
	rspamd-7d4d75f7cc-5kw52;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Industry-Company: 3457e9bd06098d23_1753129763376_246436591
X-MC-Loop-Signature: 1753129763376:547361532
X-MC-Ingress-Time: 1753129763376
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.34.94 (trex/7.1.3);
	Mon, 21 Jul 2025 20:29:23 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4bmBnt4SCBzHl;
	Mon, 21 Jul 2025 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1753129763;
	bh=NUGB94Q/uJTIbaksSFnSTp2w59V3ekAoZtrk5N8qg4M=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=FNEWbc6s6XtQ2IKuE7JlCIgyS1eoFPHE9SpZWcJFmciZwAoQq4XOkzlywCeBanH1s
	 0LL10VI39aFjhHRkKaZnpLHfPHQWArs6IYRNhwJC4wFpkvNN9Gkil3Bo/eLsl3R6Zh
	 QsliCIaD3m69f58LJ7wC0yIJfwkUzAaOYg+2NWiQhJ1Cnw/7Kw9od1XiQJPpoyWETr
	 TmI+DVROJBeKnHzlhD63tW5+QOtKUxa5E6AwnWhms2cLqLkTz3xhO2jyJKxZmbCNXY
	 DRiOx/1Q4oheIl8onQMGlJY4Bx2H0ExD+mlHJKOeBABwuHrDM2yhdf7naY8+aYxBRq
	 7/0ZJds7u6gBA==
Date: Mon, 21 Jul 2025 15:29:20 -0500
From: Nico Williams <nico@cryptonector.com>
To: Rodney Bates <rodney.m.bates@acm.org>
Cc: git@vger.kernel.org
Subject: Re: Contradictory git help rebase
Message-ID: <aH6jIGoyXc5pn8Ar@ubby>
References: <aafa3de8-5774-4a18-86dc-37493228b044@gmx.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aafa3de8-5774-4a18-86dc-37493228b044@gmx.com>

On Mon, Jul 21, 2025 at 02:57:37PM -0500, Rodney Bates wrote:
> The text and an example in the output of git help rebase seem to contradict about
> which branch gets changed by git rebase master topic.  Here is an edited version
> of the output, with irrelevant stuff omitted and relationships made specific.
> 
> NAME
>        git-rebase - Reapply commits on top of another base tip
> 
> SYNOPSIS
>        git rebase
>                                                 [<upstream> [<branch>]]
> 
> In the example command below, <upstream> is master and <branch> is topic.
> 
> 
>        If <branch> is specified, git rebase will perform an automatic git switch <branch> before doing anything else.
>        Otherwise it remains on the current branch.
> 
> Current branch is now <branch>=topic.
> 
>        If <upstream> is not specified ... (irrelevant)
> 
> 
>        All changes made by commits in the current branch (=topic) but that are not in <=upstream> (master) are saved to a temporary area.
> 
>        The current branch is reset to <upstream>,
> 
> Current branch is now <upstream>=master.

No, that's not correct.  "The current branch is reset to <upstream>"
means that the current branch's head commit is reset to the same as
<upstream>'s.  That's what resetting a branch means: it means changing
the commit that the branch points to.

You misinterpreted "[t]he current branch is reset to <upstream>" to mean
"the current workspace's branch is changed to be <upstream>", but this
is wrong.

"Reset" is confusing, so it's no surprise that it confused you.

>        The commits that were previously saved into the temporary area are then reapplied to the current branch (master), one by
>        one, in order.
> 
> I.e., master is changed, topic is not.
>
> [...]
>
> But this diagram shows topic changed, master not.

No, because you misunderstood what reset means.

Nico
-- 
