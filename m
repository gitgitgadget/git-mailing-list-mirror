Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CF2236FA
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593127; cv=none; b=jLq3IlaBPu8oOWbaFr9OeajC+qW1hc3x482pTu6PZYoroeU6c5XdyQcv+wh/UvuT7eVcLahgpd3qV5bDbt9j/znXcMPkZiWwzuq5sCL7/qcAXXmSfhpZ7879cDRrrrL8dMZEzqCTe74bI+b951yQiAZdW1hnIeHH+9Sc5N4hvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593127; c=relaxed/simple;
	bh=vZ6lXWxKZv/SDdAzNOJ/k+a4cq88m7xkKGU5im5TX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFOF1Xfsd1O/GSgNPIa1BFYHa03TNM2f8NXsFwT/UhSNJ39vcQuqVIe52N3DPrCemyJabVLbNUL9jQFJgT+myJPQ88MExNYIzTtYhXBsa/B4Ipf9dWLEYTS6o2mPmrRWCarsEwRcLqX/2065bh9GLT+p7kHhM2/tAXhf6jxv5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=LPd7LKMR; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="LPd7LKMR"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4c5jb43htTz83bJ;
	Tue, 19 Aug 2025 10:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1755592544; bh=vZ6lXWxKZv/SDdAzNOJ/k+a4cq88m7xkKGU5im5TX10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LPd7LKMRV0OJZg1bE4s1O3uISjPoZwUPPuE0mEOKHUZOBEe2P6/SGJeE8OuKIggS/
	 YGetVsTTbg7CPaAmP2f+IgM9vP9amblhp9qdhTKK8M5x2tXQ5nHklmRrK9EkwdNOD/
	 kxQb+3gSARhw1lQr4g0N8NS+hSCaus/9fGtd5EiUgHoYhdxc7e/kpHLhM7ZzbqCT5I
	 1JsRsCPomLN1GkiKLMkjjxzjKsR6/KXA/eX1uecZsSH+nq9B7bT8aBA4SA9gJ5BCMA
	 BoPEObnF9l5YGfy/C8nkAz+hIZO3HZDCQkUtrmODt99Q990zdEfki5WxwNLEV53sjZ
	 /UM18uuXy3mOw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4c5jb43KjRz4xVk;
	Tue, 19 Aug 2025 10:35:44 +0200 (CEST)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4c5jb41TRcz8sbs;
	Tue, 19 Aug 2025 10:35:44 +0200 (CEST)
Received: from [IPV6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414] (p200300cfcf29c5002af12c6eb5fcf414.dip0.t-ipconnect.de [IPv6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id 83AE1100308;
	Tue, 19 Aug 2025 10:35:39 +0200 (CEST)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf29:c500:2af1:2c6e:b5fc:f414) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
Date: Tue, 19 Aug 2025 10:35:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Graphical tool to merge and reorder commits
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g> <aKQws631-giQS5Qr@pks.im>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: de-DE, en-GB
In-Reply-To: <aKQws631-giQS5Qr@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175559253986.12871.9071075585196180141@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 83AE1100308
X-NC-CID: TdHZUY81sI6wfMP5BX4DHXCZ3u++TD375YE2oIPo


> I might have something related to that: I've got a patch series cooking
> that introduces a `git history` command. With this you can say:
> 
>    $ git history reorder $COMMIT_A --(before|after) $COMMIT_B
>    $ git history drop $COMMIT
>    $ git history split $COMMIT
> 
> It's only intended as a starting point, and there's additional commands
> we can eventually think about. I'll probably send an initial version of
> this series later today.

This is good news indeed, thanks for your feedback.

I guess some "git history squash" command would be useful too.

This is what frequently happens to me:
- I commit some code changes because the current project builds and tests fine.
- I start the "compile all projects" process, which takes about 1 hour.
- In the meantime, I commit other unrelated changes.
- After an hour, I realise that a silly mistake in the first commit makes compilation fail for some project.
   I fix that and I trigger a "compile all projects" again, which takes 1 hour again.
- In the meantime, I commit yet another unrelated change.
- After yet another hour, the build process notifies me that I made yet another little mistake, and yet another project fails now.

The commit history looks like this:

- A - B - fixA1 - C - fixA2 - D - E

I only do a "git push" when the 1-hour compilation process succeeds. Before the "git push", I want to reorganise that into:

- A+fixA1+fixA2 - B - C - D - E

I know I can work with branches, but branches make everything more complicated. A linear history is easier, especially when you are working alone. Besides, it is not often that I make such silly mistakes. ;-)

Sometimes, fixing something in the Git repository is so complicated that it is not worth the trouble, so I leave an "unclean" history behind. For example, sometimes I have fixed merge problems by manually overwriting the code with the final new version, losing commit history in the process, in order to avoid having to deal with Git's idiosyncrasies.

Would it be possible to provide a "safe" way to do this "git history" operations? This is what I am thinking about:

1) Start with the messed up history:

- A - B - fixA1 - C - fixA2 - D - E [head]

2) Duplicate it:

- A - B - fixA1 - C - fixA2 - D - E [head]
| A - B - fixA1 - C - fixA2 - D - E [attempt]

3) Try to clean the history of [attempt] with the new "git history reorder" etc.

4) If successful, move [head] to [attempt], and we are done.

5) If not successful, drop [attempt] and possibly leave the messed up history in [head], because the cost of fixing it would be too high.

The first duplication step is what gives me the peace of mind that, if I screw something badly, I can always drop [attempt] and go back to my original state.

I know it would be better to learn Git "properly" and do things "right", but Git is often not very user friendly, and there are other priorities in life.

Regards,
   rdiez

