Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318981922C4
	for <git@vger.kernel.org>; Thu, 15 May 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345814; cv=pass; b=r0V8K1cDZW2LNFhqe0ch8KmG/T9uwBU2BK30Ru6A4Uomu4pkDSUsHP9VxaVuH68QV0p4MOaRr8Z7rw0747U1o5hb9il3EjpjbPC+eVI4zEC0fi6Jxy3A0ZCp3S9YUqyTjDbkZz5zjvHbmi1VO/xrSlUEVbTuEBD3jk38SX22S9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345814; c=relaxed/simple;
	bh=hpsh1GEmtNf7p6Ey/w+8IP+fNShIubnA6hgKWu36DnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5a5lJ9a2/j/vu84glPUaTELLYILozZbJvDqU29Hon/5SsjFQGvih9bvvJgcz7bLqeNsMzSSJtxRay/i5Z2N8YhF9wKSQzojeJpTAKpq/sW2VFAFvZNxVIctdVZL+ESpROgecCVLwI8kfI9vu2lfZzrRyOfhDCxJlcRCFOa+VZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=MkEGzhp9; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="MkEGzhp9"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9C54A2C1897;
	Thu, 15 May 2025 20:10:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (100-112-107-235.trex-nlb.outbound.svc.cluster.local [100.112.107.235])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DBDB92C267E;
	Thu, 15 May 2025 20:10:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747339823; a=rsa-sha256;
	cv=none;
	b=T1xyS+bg4NQoCR6JxbN66nw5u+ZHivBpbMnFDd/coVIfk/gmfdYVv9RWp56gSLpCap93iN
	Bx3NDJEcj8z/CIYC7OfCIbOieVHqgDMSaK8QSxT9pwgp7IGlvlDqS/Z0zODXwwVJjeqXO/
	pzl5OII/mLMT/Gq+VotXTdmqCdd0l5FkoVGuhSYeiNOQq/hVd9w7HqQW9tDpRZhpLjmVq/
	SLZg7cigq2itH+qD+kn91k+Uan3pBA6nrsloBQXHxW1jxJEc+pCm1ZYyx5ucDirn6sZsBo
	jghLt/35/CzrmYcb2m03IsFAFBJ2UN8dBoo5x7XM0ftXs/OjcDyK+pDCMQzHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747339823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Tz5RoM1VYM+hVZkXjS9QHjBJzagfGB0A38wMEQznRrU=;
	b=d6y2XchHfk7p1JzzC31QJXQDWFsk3bJ168VqOXtQeZ7zJuxJp3AhKY9WTi4uDzf8z5IPya
	tPqci4+H81L0V0k8qEuBXcgAxzAN6GNP4VhyRaNJlH+1XuOTwwOcxwZmwF0sUuD5hHEyMX
	2ZyHuXuei2L8RsCdIQe+TpXzE18pc7dBKoQozf2c7kXOK3I5CGgHzMTLTJFGvcBVHAcPNq
	pQzBTCg2UXlpsz4fFgU+nmkKT0doWC1fcZruK60tNt8P7ihxHnwub+vw1h8Lw7nRrcsx9F
	loeFJOSB9CDLgGr9EiHM/bAefTio6ZeHo/lM5KBuIPFdxPn7aguqEHm271t33Q==
ARC-Authentication-Results: i=1;
	rspamd-5b49d78d5-pck4t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Belong: 395a8f903debed3d_1747339823300_2623951832
X-MC-Loop-Signature: 1747339823300:2779212084
X-MC-Ingress-Time: 1747339823300
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.107.235 (trex/7.0.3);
	Thu, 15 May 2025 20:10:23 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4Zz1Xs3cqbzLZ;
	Thu, 15 May 2025 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1747339822;
	bh=Tz5RoM1VYM+hVZkXjS9QHjBJzagfGB0A38wMEQznRrU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MkEGzhp9X2RXQgIDnfymwsnEn5Jay+HquxRvN/nJp/n/JbhwxTjoj+yW+yW9WEo+o
	 /X541s+uEtFfcaKL3CqXhDoNf+5bC4e/xNeMRH2Yfj9bve5mJJigaETFebGwHAvxDx
	 ihRCahVKFsrTE/0lF7sVfQbNe7ewbzx9DmQFHunQPjluPeNmzydLOU8hkjUcfsGP7m
	 oUDdRP8MzWf52WCQ0AZOG8UeIDKEBj1V9MF8ApTTXOM4vuWV9WyUE5SASz2L05jIbM
	 lrNywyrDBkCzkda12ba3yUcbKSWUdlq85ZCQ3QlokGiXaGqBihl42ibRxwSBeBdUDN
	 ilJqOCSFbC76w==
Date: Thu, 15 May 2025 15:10:19 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Martin von Zweigbergk <martinvonz@google.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Remo Senekowitsch <remo@buenzli.dev>, Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aCZKK2/OdrpEUqI3@ubby>
References: <aAgWytQNqtLzg2TU@ubby>
 <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <xmqqtt5pu5g8.fsf@gitster.g>
 <CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
 <xmqqjz6jb6kd.fsf@gitster.g>
 <aCXCgKYpEqxWxIT_@ugly>
 <CA+P7+xrruw=NUJgzV4D6CQbmGJO4CEjhkU_+qFDruD5YMsidDw@mail.gmail.com>
 <xmqqfrh5zlu5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrh5zlu5.fsf@gitster.g>

On Thu, May 15, 2025 at 12:59:46PM -0700, Junio C Hamano wrote:
> For something to be an eye sore, it also has to be of no use to
> those who consider it an eye sore.  The signed-off-by trailer is
> noisy and it becomes annoying after reading "git log --no-merges"
> for a week worth of commits, but it serves useful purpose so nobody
> would complain them as being an eye sore, even if they complain for
> other reasons.

Maybe `git log` can have options for leaving out trailers of no interest
to the user?  Email workflows still will see them, of course.

> Why weren't they seeing any benefit of having such trailer?  Would
> they have found a good use of the information if it were hidden in
> the header part?
> 
> If the answer is "it is only useful to some people", what is the
> [...]

I think the answer is "they are only useful a tiny fraction of the times
I/we/they look at the git log".

Nico
-- 
