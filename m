Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446175;
	b=PzuPIDv8W+/8vhb1uGwvfh+bTzAPOPks5QsdLECuqc1BevIdGqhrLIZGuKMWcRnXhUSg
	 fnumx4Y5zB7QLJTRMGthZ/3GveGcnKAWrezvpNthIREWmSWnTzR0QOuiIyCQz14NXx34H
	 PndR0ymmr5Z4DpJji54q0Ih6wh/xRwsksazEM0Qebnkv05wH3VheSKkScOPRBv2YcbY+g
	 4KpXdfuk5HwN/aLuF/S8qp4R+Nk4QLk+Nr0uFFm07FUmchT5F7ILf+a5DG7T5giqgcWI+
	 vgxEYlegJMcRXdDh6bTF/i4NwgNl1P9eneXLuTDOTdeY7EdjMCX9IAYCz2uzXY0A5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446175;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DQMJevJBeMwqzs12TV80pOHKAjv+dj6QPFJcNHw492U=;
	b=AHGspvkccyFMP700hknu7WLubMTRvdrpRHoO2fNubdthXFMJxhhiBluHALFISNhb4I/Y
	 7u/6zOLFdtu3tl4+pvTsw8Q5eiMmyKO3hjpCW8N84oeWAnhm/d5hRdYxXu6BTe/I+Fia5
	 s9dvjsd5YPMYBSyRjJwStjEM793MALNl1MI6lXr4vypCYsGUjYtKnQsVDLpwnccvalQk0
	 kjpMoJxb1+KbWF4pwJzptF3OLhejXRCJu2Whaxe0+TzdIE8y0wz60ayVZ1pyX7pR2yGAl
	 vYDaxUFB1x1LRYbh4DrpPlkmllwm7cDZ10DVW5vOenebHgDDQGKi7r74zuqpmgWtmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gznwZoYC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="T8bXH/0o";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FED606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FED606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gznwZoYC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=T8bXH/0o
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B241F1400093
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:42:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 17:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792446173; x=1792532573; bh=DQMJevJBeM
	wqzs12TV80pOHKAjv+dj6QPFJcNHw492U=; b=gznwZoYCDlgWD7lg99Gq9iT6Kq
	7bofFTHQZpKLRsZ7GqvSyhsJMEa1QYkm5cuyRtOEy1ELy9g49IuaAp0bFY3vQQv6
	lEpx9248WHXkRQm/g433AJW5j60liLvSwH9+v27vCOA+tBx/XpWDONEtrMpDw7f1
	k/DHks7YOHGVzEhfQ2cAZdI8QmfVUlIRPyvpDRiEbFFizUknk7zi6wOFUiAckGKl
	0rdpC6MDAy7PFJeHRlZOG3Xer0C3GhGxJhbBY4D4hin3Ub/O71hbOgEZ/DpJMQH2
	KLAh9NZnm9H8vblJTp2J66E57kIifst00woKzOZiHIGMjuhw9qQ571WVZ6LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792446173; x=1792532573; bh=DQMJevJBeMwqzs12TV80pOHKAjv+dj6QPFJ
	cNHw492U=; b=T8bXH/0oS1A70n0W+VjpXc63RUhTdFZjl7zofi55S2z2mJMU6RY
	pLi0wO0u+vlEF4ZKJ3CZZwBmV3YUWGaHYtd7NRo3Bks/0hPFrjRKaWd9eDEKHOfA
	9pMUlB2876KhJ/pMOp5FmdCQS4IdcK8lsRzfrcvdW8PRl/9xxzK0yZCh4MQtuYXu
	qwnryEcpKw9XJJFTCleJE2aD3+doAD6Qon4YBMTX3DMuYNv2YBYP3oC8Eku3XpH2
	GWZrIfGEA3H2Advel6CH2WohxX0xWeBlgL/9N+XYgCP7U9jKGhzy49/xksghWCH+
	4ujGi+vEfd/m8iWvjGppqeU15uDpEMU/evg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792446173; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hFn0LuLVW3M52R/ASNOejowTDACE7QCK48zls1CNl2u3PtL
	ypw0p3B6eRn3x0u2w1i1/1kg4uqGgq3LAUeQnriDx86b+hjJdA9xwLQSk4CwpO3S
	TB6Q09WA/9AFmHoIgd9FB+gct2JSggmfJicMooz4hcA4p58kY8s+C9/5z5jnjK5q
	dJ6NO7Ue2L1xQ6vaXPnKoPQBjUQRTQPj93rh8oK6Firy63cDS6xPFRry6von0YLb
	+y1O71t3sDFW38XTxOStK35aNIByiQlAk7IOD1HzzXuUiSuU6MpOvzakzv5R1Fad
	NRDklZFSKOo77/OJ154Ci179kZ/LTPW1H3xPxlg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qhSo+0T7PXhZOsyatGoUWbt0FBoWht+c5RmgPcISiSE=:1GI6nkRiE2qvpkx8gYFxqzn9QVdM7aDqQ96aL1HFNq0=;
X-ME-Sender: <xms:3Y7Walnrb2Yl9wbH1qxPxPeY4kL8J0A9bnSR05KVVBL4gbs_A56kZg>
    <xme:3Y7WansRUmrqd6iWVN_u4somihIq7cWgassUS8DRr2U2irCU2Jc8rmkUkN9gNRDeh
    xyYnO-LSLrcbyY5F39FTfgXDukbGiWY6ZcB5lEpleA-MD8RUH9AnhI>
X-ME-Received: <xmr:3Y7Waj-GHGseYOt9LxyN4C8a3g85UF3lH091IQ28VrxMi76F7zJ8Xbsq4K7V_vA_tQGDItJjhzPhl3fUvoh6v3_S5kG_yrEkx9Q6>
X-ME-Proxy-Cause: dmFkZTETU7WR2V6KPCLm8puxGeMjzllLiLCI3t484TYSsgHkbuvulYsfS9gPkEeQDmBroj
    e4SKJMBG/YbngYftzccn/Jn/cLR31tp7e/0v2jYNtwAOwZbSHPR1DQzGrk89kJbn6QiIZA
    TnJcA1JTET7ZL0+iGxZb0iqApVa4gRFhb0lpNmU5ELAmMCEBr/iIvugoy9nrkm73MUzkSv
    nMwJJbhhQ0G0MVFaareqDhLn+U3Oe3cNJt41+InVRpaHzWpDu3JigOhNvRrAop4gb4OlQ4
    xRsHPWcaxnorUwjZI2S8jQfyO6gaw85cYBSJgoC1DtNBe+E5wzjR1klcTMQQEFZnjMeVBc
    sV/NtC6V9oLelLwy0YbClSIxCK3HHjGIhaVLvtQOLG5ENTd9VPNdPfWziY/93ygKTZlETG
    pd7Dbf3eHeg3JeV7BXORP9lWHwqCVLEgIzTOAZj4WfG7NsXAQd5i9glH0XXpim1ChGXrrt
    +9oXpin4bbozBkL7lq8URsSAXSJDljDu9FyFc+78akCEAVD1GGU5qvCcZOADSQXFGTotJM
    iz20trH7QZE8rTMNd5RsMAq7yaSu/lfxtfRRSOhA10R9lrW+7MVKiHJIRyGb+KFrgNZGT3
    TOkSK/OO4nMEMiO0fwrEwzkPMyp7szOz9g/LtEvpL7LHc8Q1Y0mBM3NOqhVQ
X-ME-Proxy: <xmx:3Y7WahPtdiVJ_WKF8VrM7wqh_0C091ehX7oQeRMEI8PVt3Y1DJOwww>
    <xmx:3Y7WahHAOwkYsd9GIEzKK0KFt7ZOIj0z4tMiNKgVhF0xp4cnKxji0g>
    <xmx:3Y7WavRmqG4Smr7A8WQFIYESkeMmvS07imWbv-Vn2thY9dfOAeIZqA>
    <xmx:3Y7WautVXEH6S0j_O9AaBumIG2oAJAA_I_Uf-sV2Uw-oQ_JH5kMXYQ>
    <xmx:3Y7WagdFpmIJbpTWL1JNZ_TAZdu9G4QzoRDteLMBNBIrvrPHKzYxmdXC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:42:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] status: reword message for a missing upstream branch
In-Reply-To: <20261019175722.5223-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Mon, 19 Oct 2026 19:57:22 +0200")
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
Date: Mon, 19 Oct 2026 14:42:51 -0700
Message-ID: <xmqqzew91i5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> The message was added in f2e087395b (branch: report invalid tracking
> branch as gone, 2013-08-26), assuming that a configured upstream that
> cannot be resolved must have been deleted. But "git clone" of an empty
> repository configures the upstream anyway, and Git has no way to tell
> "deleted" from "not created yet".

I am totally with you up to this point.  This is a great issue to
tackle.  I am curious to learn how you would solve it without
throwing the baby with bathwater, though.  Let me read on.

> Since we cannot tell the two cases apart, change the message for both,
> including the "deleted" case that has been reported as "gone" since
> 2013, so that it is correct either way:
>
>     Your branch is set up to track 'origin/master', which does not exist.
>       (use "git push" to create it)
>       (use "git branch --unset-upstream" to stop tracking it)

Ahh, "does not exist".  Clever.  That does cover both cases and
reads reasonably natural.  If we wanted to have something short that
we can reuse elsewhere (like inside [] in place of [gone]), we could
say which is "missing", perhaps.

Do we emit "git push" suggestion unconditionally (meaning, does "git
push" immediately in this state always create the "upstream" that
does not exist yet), or do we have to check if "git push" will
create it before saying so?

> Only suggest "git push" when it would actually create the upstream,
> that is when the push destination of the branch (what "@{push}"
> resolves to) is the upstream itself.

Ah, your flow of explanation exactly matches how I explore the
possibilities in my head, given the thinking of the author revealed
so far.  Excellent log message that is very easy to follow.

> This is not the case, for
> example, with push.default set to "nothing", or when pushing to a
> different remote (branch.<name>.pushRemote or remote.pushDefault).
> It is also not the case with push.default set to "matching": it only
> pushes branches that already exist on the remote, so it would not
> create the missing upstream. In all these cases only suggest
> "git branch --unset-upstream".

Indeed.  That sounds like a good way to go.

> "git checkout" prints the same message, so it changes too. The
> "[gone]" shown by "git status -sb", "git branch -vv" and
> "%(upstream:track)" is not changed, as scripts may depend on it.

Does this refer to what wt_shortstatus_print_tracking() says?  It is
_(translated), so in a sense it is a fair game to be improved.

