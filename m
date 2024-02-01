Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9D7C6F7
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809613; cv=pass; b=rLSaK38PHAm4mGMEGIvP6tl2hUu4cFIXAQ5iXiMCJH/DBE8wt1zdmC5/u3dioDQLgUy3AGiwIVvTVeFZ7jvKpNSoEDjfkYKRZlnDFgmrCWOtp37PJ8aL9waamprlenAuG0hRmEzZd0JWmFB4Fjg/62D+1pCG5lhzw/1ww9bCCdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809613; c=relaxed/simple;
	bh=2ULry9k5qvLgXtafNDywBYEnsnjJa2R1oey5JxMhoso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6NvPHyvZmevpkOo254WpZRq1SX1ub32ZdPRCm9ProshOO2wA/xXV2iduWfs7VrfuFNJMCtRYE82rG8xYBnQTWwE4Xse8hmR1X4XCqPY204LblcMckEyuwiuIH/RhCEQCJx73ppiUYMW7gvtp1Ex2pMkNUJS1Dtjd+VnaW1d17Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=D4CV6uXm; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="D4CV6uXm"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8FCEF903D5C;
	Thu,  1 Feb 2024 17:46:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1C1E5903DC2;
	Thu,  1 Feb 2024 17:46:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1706809602; a=rsa-sha256;
	cv=none;
	b=fL4UyqR17K7N9IcOry+P2nAWRZoCVv8oayBH/jlZuC8BIy/mNj3tc82+6XoX4J7SUp7axu
	31Gz7xKfScjRKnk+K9EtvrDH1xz9UUrQplqTZJxcvLIqz0WfCcqunTdFxHIJ5L/4mAOCTN
	obWC06oz3fQmps7de0dBC02wqPMMmHNFyDqmWOmgC8gPOAONvYQarRfW3OUqBVWiQHu6BM
	QOajLahmCf41ceHnLNjAKU1O6v6TVOxEwSwzmsxEumMxvB7vnbjpMLry9e+cXzVJkXQtd2
	FKakJB6E7+t8S7e1I5YxY7z+9nBIaUV4jqtbLynVK12f0ghnxV6E6VRLkhReSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1706809602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mh5AmsyVTC3ffVCe3yAp/2s5vqubUb2Ej58qY/3ZrBo=;
	b=eHBYxxlB+N6v/zrMAVWAYHHbHJjnkaclPseBULDaYkajreUVkLQ+yJUwLX8M+Ji3/Tvzkk
	1c0j83UBmbjrkaJzMNd//oE2S2jVXzWx6oAqt9oN1b20SBQXDEL/RyWe/qjjhbBQDextsO
	muvduGmAD2J/IIVlLvXcJIXDFCkpE7mRa2+JGGG+QVkVDHG4ClwaaA0KS377aJTWD+2iGJ
	4OUrZy9grlftThbKqnMnUPOLwG04zghxeH04P26DkKJ0H6bjIdCenfGTAS78gyDo2DcJIf
	h6eU/pPnYLHOPfMTILUaCK0r3vQkCPLuXbCH3N+FJ90YyEZpXbwKahRNTMpyyA==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-7j9w4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Little: 2cdc777716c90a9f_1706809602357_2862307471
X-MC-Loop-Signature: 1706809602357:3048038301
X-MC-Ingress-Time: 1706809602357
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.38.211 (trex/6.9.2);
	Thu, 01 Feb 2024 17:46:42 +0000
Received: from ubby (075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4TQmYY2ntQz52;
	Thu,  1 Feb 2024 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1706809601;
	bh=Mh5AmsyVTC3ffVCe3yAp/2s5vqubUb2Ej58qY/3ZrBo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=D4CV6uXmw8fyzzFMk/CdYglbSfK2+E6cbBC0irJWeUIzGKubGb+YdL8REGU0s/dWa
	 NDh2IoF1QTdqod5LsbXZqIb0HMUtbJIhlvHZO4xrWCXK56PShajoG0Cm7CRUEGgQhC
	 G45S8RROypY2x06pR6JzVZ8OhrZ8/O7b0oiQQp1c2Gn8BGYTSCzF2t4NEyjKJNsTBR
	 jWPyOaUeQBEUh0V00f1i4gGBCpbiBaRtiXcYiF68rp0JouJ/Z5fvVNsWbN3Ya3W7nd
	 aSra1Jd8hy1ErL7QjXgsKAAekkeTnxdorwve4k0Sdaf4x8EOmqnDrs1asPSGabA2xO
	 T+ASM/05KF3PA==
Date: Thu, 1 Feb 2024 11:46:39 -0600
From: Nico Williams <nico@cryptonector.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Hans Meiser <brille1@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <ZbvY/01kebuFagn2@ubby>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>

On Thu, Feb 01, 2024 at 10:39:04AM -0500, Konstantin Ryabitsev wrote:
> [excellent discussion of e-mail workflows elided]

It would surely help if the e-mail interfaces of forges were not
terrible.  But they really have to be as good as the mailing list
approach.

I envision that the "issues" and "PRs" could be webmail-ish thread
trackers that auto-close on prolonged silence.  One could open issues/
PRs by e-mail, close them by e-mail, etc., all e-mails going to the same
[forge-run?] list address, but still have a forge-style view of a PR's
commits, still have a forge-style code review web UI (with all comments
going to e-mail too, and with e-mail being first-class, not an
afterthought), still have a CI checks UI, and still have a big
rebase-and-merge button for maintainers.

I.e., forge e-mail UI as first-class equivalent of forge web UI.

The forges tend to be run by people who prioritize users who are not
heavy e-mail workflow devs.  It makes economic sense, given how few
users demand e-mail as a first-class forge UI.  Still, it would be quite
awesome if some forge did this.

> - How to avoid a vendor lock-in? [...]

Assuming some forge exists with an e-mail UI on the same footing as its
web UI, and also good enough for kernel/git/... devs, you could maintain
mirrors on all the other forges, naturally, and always fallback on
e-mail only if the primary forge disappears or becomes too expensive.

> - How to avoid centralization and single points of failure? [...]

It's all forks, all the time.  It'd be good if the kernel maintainers
maintained non-forge git servers as mirror/staging/primary repos.

> - How to avoid alienating these hundreds of key maintainers who are now
>   extremely proficient at their query-based workflows? [...]

The only answer is to stick to the current workflow until some forge
provide an equivalently first-class e-mail interface.  New participants
just have to get used to it.  IMO.

Nico
-- 
