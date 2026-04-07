Received: from crocodile.ash.relay.mailchannels.net (crocodile.ash.relay.mailchannels.net [23.83.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693573C457D
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577183; cv=pass; b=IC4zMoXCq+TgaSXIDmKOmEKueTkScVnH+V4K2kwmvsTKxw4ylpvqoLBQ8m7AtMhqeYiCnUFWBxhjGa3iPZaIVNaYLNGRQvgefRi2p0o3AiMs3uDahextbDcjImf51jw0n2cj//lZX6j6zysN2VhEuGemrZjUU5Pb29MPC/xZIkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577183; c=relaxed/simple;
	bh=ERWTCiJU4hi8bzC5Qnx63VsAEop2v1IGrOh3wPc+F2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbbd+At57evCRjdsJeJRlD/yiO6a2miYzxOwjG2uVUF4/Vidr1hU6GTVUnXiVLezfxj3PHzm5sBuR+vNrrBHIF5k1HzUrtpDjiz6iO0NT/imjYWvcWWvT7lZt+tx7uuZ6CulUf+VbetjAMgcmZ3da43SgIyGf44breSm8c0B5XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=CZwNK489; arc=pass smtp.client-ip=23.83.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="CZwNK489"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F603640F0C;
	Tue, 07 Apr 2026 15:52:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.100.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D2CB06409E5;
	Tue, 07 Apr 2026 15:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1775577164;
	b=RYguj7RgCf7cC0Z6zamB+ABEuqOoMyHKIBDz7lnhB7Z6niX0Q9Z3GjFUxjWxmnjdlRmeev
	34vEF7woZC1nqDvQ5OR0O8Sj5jULer+ZRkDhVLSXubFP3gtxHj17edTkHzQn34J3mezhfG
	R3DIgVDLjUmYQvhY+lAsiCZ5L7c1BPmKwsFMJnoUcrselcNqQ0OMJzI3XRNuyMCDHdLhq2
	U4iSVzPCPh8AbMbrPIsXx2PTphvPyulR3M+Kk3EeUDAkIU3qLSTynit7HPhynM/enxSk6q
	A80v5WEtbNanwF2rfvtx2Th81MxUO3sPJnXoMWS/Qp5qaiacO/EEgzvldGTxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1775577164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nYc6ICZiul4sdBHhYTAf25TU8j2WYb4JMcxC762PDYc=;
	b=GE4i3N1+ubnx73FbkOrRSHoRU21zm2w2oh0c/Rh0mpdUAg34Hvp64Ylmno11NEf3EO/siN
	B085s7+PG0LA6NaeQUehUNGzqLa1zXqnpeYNQnsvIBdVd2MpLpksCokrP8pCdxA/iJRAP0
	qs8GXr5tHXqEYpK/2rPko8aqM40SUG9QBazcdxseFAyaU4ZYKodOhPswCnNhmCLXq1SxO3
	sJdAb29XqaYodPdjWUJ9oF1iDGZmpBDmbSyFE+3fY1BrXWx7vLdzVlxYNcJjsTgim+ETIH
	I54ofm4Ra4x4+RInLRld0kzSKKmzsjFRCd43phQol9cOUO73HxUGAiKZhn3v5A==
ARC-Authentication-Results: i=1;
	rspamd-bd48b9d95-bm88l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Duck-Cold: 2c8f885f614a8f92_1775577164181_864895312
X-MC-Loop-Signature: 1775577164181:442791812
X-MC-Ingress-Time: 1775577164181
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.100.42 (trex/7.1.5);
	Tue, 07 Apr 2026 15:52:44 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4fqrLd6kJLz1s;
	Tue,  7 Apr 2026 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1775577163;
	bh=nYc6ICZiul4sdBHhYTAf25TU8j2WYb4JMcxC762PDYc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CZwNK489crkQ1Z+CgloKASWNDlJIqnwx5WJ7zIU07rPBGI8FHfI8sCVQznx1wFzrl
	 nHOgAFBoL6cP6c8mVPHBFJyuPbiP7T92SaDChSsPxyoXaiDZoZrpHoRW8dpfgCl5j7
	 sbfoisXZH+OGWcQ/etACrx3Vl1l5ReUz9jbZrvakV+GTOdUc6nqtc4sfWh2oGkD5TI
	 PHzc1FdR6YP2WbTlP6bPOEuUFXloAbII1mJ4zJw/37QP1Xan0zwZS6U+EGadPZFJuZ
	 p0h2QC14MQr2T9eObk2Vt6q+lEJovGSQMRzmqKewUXFuhZnsNOlkN4NH9ND+3oYQfr
	 hzR3diKd9JaVQ==
Date: Tue, 7 Apr 2026 10:52:39 -0500
From: Nico Williams <nico@cryptonector.com>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Matt Stark <msta@google.com>,
	git@vger.kernel.org, ps@pks.im,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <adUoR/T17fKr+YLN@ubby>
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g>
 <adSO6zPwtFOWBcOw@ubby>
 <68e5a1eb-ec7b-43ca-98d1-ffdf7fef013f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e5a1eb-ec7b-43ca-98d1-ffdf7fef013f@gmail.com>

On Tue, Apr 07, 2026 at 10:55:00AM +0100, Phillip Wood wrote:
> On 07/04/2026 05:58, Nico Williams wrote:
> > 
> > Maybe that's the trick: local configuration for determining the
> > copy-or-drop semantic for different operations, and maybe hooks for
> > altering when copying.
> 
> I think the danger with making it configurable is that you cannot rely on
> the semantics because they vary between commits created by different
> authors. [...]

Well, I said "site-local" and "for some definition of site", and the one
I had in mind is that the upstream provides this [default] configuration
for clones.  Sure, authors could override this locally, but presumably
they wouldn't, and presumably upstreams would check for adherence to
their rules.

>   [...]. If we could get agreement on

That's proven difficult to do.

Nico
-- 
