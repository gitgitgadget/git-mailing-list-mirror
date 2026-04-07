Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8473A3E65
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550200; cv=pass; b=geUsdg8L51ZX7es6GLdImaQU9FA68TCTRVt++hmolTanJ6ng+ryEO8HaBfzUzkVCNeQU/ZbtLbJ9yGFsT/LLU3wHopIQ5gS0K/R6GZ4MCAwvrcpEtVaWd/UOFQmyaQiqot/aV+rQw6lhLkhCsGyGDpmj8/3lK3DNP9el0+KoIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550200; c=relaxed/simple;
	bh=oRmhKWwZijDCpIyprJt0ekLEw9++vfGaNLIfs4/sEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN1EfjKlHsSlp5JiBPm95DNcCFcDn2ArQcYt9C6/2mcnK7mtM2z8aQWpX1KUb2eF+0YcByzNVN3ERT4YWHjrf8NtVRyIOLYbsXAPhRhc1Y5TV/nG3WRXF5V+IDDMtX2/ZaTuDjBlTcrgnnvWhwQm4mwcMGTKzskVYv931AVsGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=bBgNhgl6; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="bBgNhgl6"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 36FE79215CE;
	Tue, 07 Apr 2026 04:58:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-122-210-181.trex-nlb.outbound.svc.cluster.local [100.122.210.181])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C3D00921F50;
	Tue, 07 Apr 2026 04:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1775537902;
	b=EAj/kBzxVIgU4qQIUFP4qrAmePsHQnekMxwII0p0G/Wrwh2Th7q/MdPZOvZ3Y0m3LAhJur
	ptAfrX/aXzV6abGq0CaXnFR6uAkPihIGaX3o/l3X+nFGzCdzU3se4cpmqTITC9LQUEYF67
	Y6UK4Hr6M/SNOhlpAqjZAkwdHAtfE7TpPlAGgf6KImXVmgh5Yef6aGyD+IrOQJT2KhE6qY
	LllkJ87evKTb9vX5NrOLWna92MXkdVowsdjlU+5fgm8bvLldPibScZ7akNwusmIp1c7dk8
	HSWbBJd+ePDlZTycUaxHjh3tzdpoV2vQ4nZYP/akbzF6XixdCaBI2ebNps+xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1775537902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mvvx6+dopzaJkIpLgTSXzUaF4OTTve/D2tD6gNEsDEU=;
	b=KXe0LuD1pNudmIyHV3apmKMo9NllSBuy3p89IeflaMEXZntb7er9MQxmUO4PaBESjyx2UA
	nntrqsf9zd+7PqRv1gWMAYUGt0mUcK1bReUiAq9bPGkIa9JtD3EUM52zf5srCGF9vMvgLT
	wypsMHBgOM0YmZE1DImATbhB6KD+XNVk3sPwbmGrYVtj1PvoJNquZeLbytP2GBaQIAMl6M
	HGhnetihSejrhCbr1n5I9JsxZNbT4RlqrYqW9uS0Rn17vYA1T2tJRiR7ecjaLYv2y3OeKs
	Clar8sPKl4K8C296THcJEqFBry1FynbcjderjZYtG5D2YrsB/k1Bf3hPrqwmLA==
ARC-Authentication-Results: i=1;
	rspamd-7d86dcc447-dn2dg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Scare-Whimsical: 44a1ba34193f56cb_1775537903101_2607731562
X-MC-Loop-Signature: 1775537903101:2517379958
X-MC-Ingress-Time: 1775537903101
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.210.181 (trex/7.1.5);
	Tue, 07 Apr 2026 04:58:23 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fqYqd2CRQz2K;
	Mon,  6 Apr 2026 21:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1775537902;
	bh=Mvvx6+dopzaJkIpLgTSXzUaF4OTTve/D2tD6gNEsDEU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bBgNhgl6r7Y+Exf3vm0Atv+1PrXhwsFw82InddPhdNftrPf2QYQ4fu6pflY2lHEQr
	 GGfr5qyD97ytLPNm4Q1+9zIKGLhxp3EnZ586Koqsk2Ep+uVh5UJmO6BSuy2MrcSNq2
	 VtQgfYS9mwhQhKJhSY6eRYtxv3clux8bx5+438iQhq8b9VWb0c8Z/yLPl4Z5XyTKof
	 Sw8MjI1YW6n1lUHtHPcj0IQmEbOLP4/wXlrFxOqwIqaa5Bj4Uv56N+pHOka9rxVxb2
	 5T92c9ye9rzrFnV76G1FErGy9NVUYPNTHlmtU/M/Tx7UbVuaMg6Jpe02ynwiWsHOGj
	 cop9YxH1wufsQ==
Date: Mon, 6 Apr 2026 23:58:19 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <adSO6zPwtFOWBcOw@ubby>
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzor76nh.fsf@gitster.g>

On Mon, Apr 06, 2026 at 09:09:54PM -0700, Junio C Hamano wrote:
> Matt Stark <msta@google.com> writes:
> 
> > In the discussions on
> > https://lore.kernel.org/git/Z_OGMb-1oV0Ex05e@pks.im/T/#m038be849b9b4020c16c562d810cf77bad91a2c87,
> > it seems to be that:
> > * There is consensus that a `change-id` header provides good value
> 
> I doubt it.
> 
> There are multiple people who wanted it, but as far as I can recall,
> I did not get the sense that they had the same semantics in mind.

The less semantics it has, the more acceptable it might be :)
But then what would need patching?  So it needs _some_ semantics.

Finding the minimal acceptable semantics for this header is the trick to
pull.

> > * There is not consenus on what precise format that should take
> 
> Format is one thing, but what it means is much more important.  When
> is it inherited?  What happens when you split a single commit into
> three pieces, which piece, if any, among the resulting three will
> inherit thee parent's?  Should rebase, cherry-pick, and replay
> behave the same way (IIRC, rebase and cherry-pick behaves
> differently while propagating notes).  Etc., etc.

Exactly.  I remember I argued that cherry-pick and rebase should have
the same behavior given that rebase is logically a script of
cherry-picks, but others had strong arguments that the two should not
have the same behavior (something which is not hard to implement if you
make the inherittance / non-inherittance an option to cherry-pick has
different defaults for cherry-pick than for rebase).

That the value of this header should not have a format imposed -- that
much is certainly the case as far as consensus goes, I think.  Basically
it should be site-local, for some definition of site.  But the tooling
can just treat it as opaque, perhaps with hooks to do any interpretation
of those values.

Maybe that's the trick: local configuration for determining the
copy-or-drop semantic for different operations, and maybe hooks for
altering when copying.  Thus for example splitting a commit (something
jj supports directly but Git doesn't, unless I missed something) could
derive or create new change-id values from the original using hooks.  A
hook might do things like create child or sibling problem tickets, or
might only qualify the original with some qualifier.  A hook might even
interact with the user to create new change-ids as needed.

The risk here is that this could yield too much configuration and be
more annoying than useful, but I think that wouldn't turn out to be the
case.

Nico
-- 
