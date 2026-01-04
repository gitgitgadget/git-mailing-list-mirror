Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C629AB02
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494531; cv=pass; b=l+Fyr23iHvw9LVgL4bpYAe7DH0PQAYLKT/UfSi12OZS3THQhjUQeYECscomJmC12d5B2s5vvPHI83DYzwvslYheRxiQ+ioV6ni9WCUzShJOacF95u32AhmyP8mPhcrtu4m1OOkbccR/l63BhB3SOtanqO9UtTEvShOXz1NcfC+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494531; c=relaxed/simple;
	bh=HWrXEpqgILn3y+spRA9fMe7TghbKlxnrbuJz56y2gdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/DDQU9QHaO1cY7cTGQ23RWR6S3nwtemqA8b56NF5YpgvQHcrK0z/R8i/z9x9xqIFuowqX8oKadf9HfXnr0o5tFRe9AFt6d1nIs164LkhVos+2c25YJIQFMjrCH+dlBwgo8qRRJ+EQa4oS67zN1DdTfsS1+EjpZAf0Eh7emCy7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=dahSETnJ; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="dahSETnJ"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC0AB160DFA;
	Sun, 04 Jan 2026 02:41:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.107.157.246])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5ED3F161133;
	Sun, 04 Jan 2026 02:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1767494518;
	b=Y5VpW8gaJWQUbiqWkEPDYtYk/9/HzU5MtihSNcZcg7Hjm/oTfR7TAWerAUR5JHek5P/W9b
	O9NaBO2t2A72mqAb2KIIxAJhSDpbeV5cnngWGYJzxF131jkBr1iT6aRekVURG/KLpw5eSZ
	Ui33o6wvRS++Mi5VXkLa6SfFWk2Go6LVrNS0GZEodVHkwTqK5blhFz8z+exwNU7sLCd9Kh
	x2M3XSimb9m2t5MyENCNTztWoOEi8t0uZHpA+kfNJafYxsKXTTxG5pqPYu8pN7zVzC4R2K
	kkLHWPgyygKqLQUAP2XJ5I777YCGS4mr41ZYndoP/Sxlgn7+3tD+9QMx/SbvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1767494518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TIyMUzeIJWJ9X/aw8MSvgqIcQQapG0nqwjBQi4WhPKo=;
	b=pm5Z7taRMGX9IQRe5+VgGnoVR/u0t4r/JOnkdBsU5AIu5TnioQoPmr9BKwn9x8aUvP0nwF
	HwTnzx0WW8ZtlcxgDThgKUJk1Uc+0JAwde/WF1FDnGsSdndt+TuDUxjQcvOcmQMSqY096r
	k6cDCWZXy0ay3o99XEPBVPSiXcmCpMOf5leMTilfgvBQyfnX8ug8YzVTM2y62CE8slWsbe
	740f5evtF8adsFx9ARGzlVB+1tsyOJQZlbFxIL/LgIAOjES1pV9r5Rd1pG8axce3wfqDpu
	DIXiX3GJFs3nCbHGCN7/WhJPq+LyFeiMzNqw9Urx0DeuLGhBFJJCeFiKgsYpRQ==
ARC-Authentication-Results: i=1;
	rspamd-69599c6f48-hl74b;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Power: 63b87edc6dfb9deb_1767494518613_4256986344
X-MC-Loop-Signature: 1767494518613:2948963970
X-MC-Ingress-Time: 1767494518613
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.157.246 (trex/7.1.3);
	Sun, 04 Jan 2026 02:41:58 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4dkMC94vQ8zVC;
	Sat,  3 Jan 2026 18:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1767494518;
	bh=TIyMUzeIJWJ9X/aw8MSvgqIcQQapG0nqwjBQi4WhPKo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=dahSETnJv1TB2MB5vEBp8ZTLrzXfvXuMxvB3HW21R2tuP0Soo8Q3pdF6nR3hnJ2Ab
	 MsB6Nqs3V58yWCfWpddVWyWv+SyDM4Z06Q/LUDufAUdovjb0jSh2L1A8bfkeD6nLNf
	 nuWfj62lJnMgX8N42jN2dKmw4dvm9XO6tBS71xaHHTMao0kYYheCIGdQGeAnOeRyrZ
	 rijivlu9qAT9f7Vwa+d5ceCj+u/acL8Ga9FMqNlTyRviYNZQ72oqDswXNooMCKX8+G
	 DX0j58suiiP2wwGCmFI6LX/n77RHWyiL1ovpZ6EB+Nnwv56H4+abDvZ7Qca98iniNM
	 FqnZ94+43VFJQ==
Date: Sat, 3 Jan 2026 20:41:55 -0600
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: Another look?
Message-ID: <aVnTc8GmqH+5Ui3M@ubby>
References: <xmqqh5t5c4lj.fsf@gitster.g>
 <20260101233839.17639-1-haraldnordgren@gmail.com>
 <xmqq7btyqfxy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7btyqfxy.fsf@gitster.g>

On Sun, Jan 04, 2026 at 11:17:45AM +0900, Junio C Hamano wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
> > Isn't programming always bit of drunken-man's walk?
> 
> Yes, but the point is that other people do not have to see you
> taking roundabout route (or for that matter, they do not have to see
> you coding in your bathrobe like Linus, even if it may be true you
> ;-).

Sun Microsystems, Inc. used a rebase workflow from 1992 to its end
(RIP).  Thousands of developers worked with stricly linear history
(merges were not allowed!).  Large team projects that had to have their
own alternate repositories and do the Teamware equivalent of `git rebase
--onto` periodically.  There was no branching, only forking.  Forks were
kept for backporting and for history archival purposes.

It worked like a charm.

Merge workflows are -IMO- toxic and obnoxious.  I do NOT want to see any
programmer's "drunken-man's walk", unless it's because I'm interviewing
them.  There is no value to preserving that.

> When other developers later need to figure out what you really
> wanted to achieve so that they do not break your intention while
> they update your code to fix bugs in it and/or adding new features
> on top of it, it would be far easier for them to work on a clean
> history.

Hear hear!

Strictly linear history makes it much easier to understand what's going
on.  The only merge turds I would allow are fast-forward ones where the
purpose of the merge commit is to document push boundaries in the commit
history, but even this I don't like.

Nico
-- 
