Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083131;
	b=gnYaH8k02VvmG7drnYhpEzPJR7B7kjoVwXdx6xFDR/QZvenR7+BuOMukOCA+x3MgoN+r
	 z5xmPtlBYTIaepvy1iXYFBNwQD4Vs83IrrIzFgkZqoJkRBb7EKuYLrYq7P8o5Fw9zZKDr
	 DcECBULp1/bdeCkTWqrZJO1myoTDc8iJgjsNFWXUOz48egJwYpMJnJF+K0bHdK9oioUMF
	 1rgAZmhKp52cZoVishfFWmbDmTu3962lDqjs43ae9iSJ/LgjRrXJYrI/diYUmtFc7ixg9
	 mhiQxgbJg6zyljgGu+REW4nE6+oXY0l7lBW5fdbVxob6jui254jh02OorncuDmrqrMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083131;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lryUmWkDmni/zCrsmgTSb+jjfF6MmyKYWYeBRaiFRH0=;
	b=NgbDvu7HhND62VdecM9DJ69pY5XWGgsa4srnRKnU/em2W8oAEWKy2dmtvBDqhb5zJdGT
	 242RYXReUX5jFFWfuzLhN621tuD+37Y9gbp84/iXPZtxpchNUfhoQk7BSd6dJfLvIJscO
	 aOB4p/mm0Wf19vagSLa2pjgQQVvEUXWptCi+wxVR3ZdCiDGcAOKGVOv75ICsSsl8nPPTa
	 9eVNp3G9NNs8igWfhh6zkIjia1g1P8/LIwstHbog3GlxtE11EUbMdKOt4FypP8IAe/iHT
	 GLv/e1yWIbcF8eqihz+2WDeYHzu9tCBqwEpbme+HLgrsnXqkWeGfVSskVHOyauwdz8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JEYMkC9C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SKPkGnBI;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB573606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB573606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JEYMkC9C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SKPkGnBI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59F2F14001C5
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:12:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Nov 2026 05:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795083129; x=1795169529; bh=lryUmWkDmn
	i/zCrsmgTSb+jjfF6MmyKYWYeBRaiFRH0=; b=JEYMkC9COEZn8dhsnSGrvDdQvj
	UZi4VqPt87TyU7ZH7GEPy12WbqfnPFsq40wrtjs5dGnJUE9g85DyxpY2QF+bxS9u
	GcIBykn9moJ1D01iBWYjGEijFAOg+ZwS257CFAaLRwX1/jQbGx1oztej/iXg3ziW
	mLJDRaIhrd84gk/lt+fzhHvsAI1F8gHEIVd/YLf2SFR0txa5LwGXXGUm4j1hE8Lo
	3VrjHn+oZhbBYEHr6Sn8QcmitHYEp/muzlcRKLFogadTp+bMCDqnhMo33zGjX3jw
	fBovvr5AAzmREgcpxN8EulC6qceMhHznJ8+PCI+kBc5bmuAOPmRqB99ESQIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795083129; x=1795169529; bh=lryUmWkDmni/zCrsmgTSb+jjfF6MmyKYWYe
	BRaiFRH0=; b=SKPkGnBIZbUESVZcw/IYjkONgq/g2WI7msKUwwsx4E0Dw3k1Vri
	wLtseHMR53iyWd4YqvgrJiWuQi+jbMBDD27tlMzu2m5jwNTKdHzNPsXBFzmHfT6y
	5V2ioBlHNEGgStQNlXKeAqoBasKni52CH2nToeijLK/L23BJa9SOpPCxPGoybKym
	idzLSyUDRJ95XnyGurxydVLPKYBPjyXYhLTisu8px3sf6XnpIQUWj3hb2DhTInBz
	Ps0gB0/vcQmhQglEvlYRmB0ZMVMcdbSqUjJdjtbt1FnHzdpr4i+6l+Co4fcFLzqA
	9IbcY4Jy11wWoCdZJIisK1Hb9gDA2Do4XAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795083129; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FScGzedy48Ntcfq10e5QIJA8Yi3Xd9LzBIg7xndLIxMgbMr
	BMeK3gpuJnrJtBo7iv12Bx0QBjj86tN2HfxbElIBKoKVghKGKKLcyjxDr7Ku7ngR
	2+fjuD3bY5bGrk9FnfSN24LIKcIFdpLEWcioFJoQ0pyiyXfdeTKc4B+MOO275txs
	ljnIywN987izMHB9YXfOlbCKvQvadxqWIMAd46jxn/hGMJd1uhB02x9TX9lnfHq8
	ARYUGfMcva08VDVnB55CCtP3ZH5rFWjxDGkLkikcHEPjVjMOQJ5IAbBVK5bYKoQg
	bUWECqYfewrSuJ/po64qHiUR3ovtET1bCSpFHWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZORBF2QagNDAxvOiGbAR0cs/u3HqgAJ+KAdUaFCToBc=:aSu3dF+zOEBGYZQki36BDpOIGbCg6hsUJpDqgvIVc2g=;
X-ME-Sender: <xms:ecv-aqVW2GWqACqnJNtPYwu1Qahk0dH1lp387AP0z8CrAVpAR2gn_A>
    <xme:ecv-alodej_Nanr11BeuRPDNMk4l5CyBk-XVKvcwMf0d3JS2QCWrl-YL5knvkHs6o
    uCg6chX-6R6q5pDWv5ifXH-AUIRaMEorkbRCTRa6YkDiXvxVlVVIXY>
X-ME-Received: <xmr:ecv-akkZ4mtu2UwM2pr-Iue4h7YmevaNza1shXd-057BrJ4Rqr9D7YLe9dCZ9g-NH_qsrQY>
X-ME-Proxy-Cause: dmFkZTECyeg1aWG7hrj0fCMNc8UDPOKzhyaLoCRfwNP3zaEvaYdhwD6/HfMyHp4C3FVlPp
    lnTV9aBajPfZk4yjQLeXJ5NyDQMh/QKZoegir0uXvHhrKB0WgCA9KwNwM1r90uxKKNsx6w
    q8dqOIO3afhS3HFKfE1huX2NTWNnhMIR4zww624l1pgQie+sGu3DJAPtONpCdmlJK3f3a9
    2qFRcSZbagzinmhkR5sQjzipC0iOPLVfwsgqG1R3n6ZHq0lnDpSmiVmDoC7+r74NNxzqRL
    mDaoMSvLwAw5Qpky8uFadR0DPeFKOU1dV3Uzk2XzqPsrFfFS90cwYg0i1WmFuAyJFHc5B5
    UW9BogrUjbZZ/WLlWZYelJ+yv2wmn5FbQ8cNpLN+54PgmF3hbwqnCVzWHZ/benhgfP5b4Z
    xP4QQ6HtUh26nHquW3hs/tD/KmQTiXNN3VmhLBBhQC1NefWwTNE6c85K2OAgB9Nv9OeYED
    +P3Cmku+TTj2go8VzBXTmmcIeg//14H0ZRZxtW2fdj+1yNbMm6QH5yo4CO0nRIZ0NjMEZM
    g9s9+NfnUJ5+ow2WXFbQniQO/DkSNNrokXf6dYI7YdQ0kIcP5ud/pYHZco0sj7sqQz44r7
    k+8nSfSmsZBB1p7dBGIh/XjSWB41QNvwWZAGl//HtlCIMZuEGl/H0eyh1sQA
X-ME-Proxy: <xmx:ecv-at13MSSBHjwPnI4YDf0V6ksy-HvxNekdfTtnJwPfrVrCSglSDA>
    <xmx:ecv-apQluyipQ0tdds0qDTseHJ7Hydy7sqSQ35Gu4zQ1frRjt8GgyA>
    <xmx:ecv-auz1mVgDyxUv7NiBf-9TjTWywD5RaOacHT3KJ2wxhj_mNGKRSA>
    <xmx:ecv-ahAO0-xObjp9eQnQZj71oUCFSIJ5W9MsfeLd_M0ThsbobmwlMQ>
    <xmx:ecv-ain9Cx5xIIdN6g2k35NPINuEbt5WhIipdGHiOU4UUQXPpnFGpV97>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 05:12:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ded48703 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 10:12:06 +0000 (UTC)
Date: Thu, 19 Nov 2026 11:12:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Message-ID: <av7LcjLcTocYH8b-@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
 <cover.1794984184.git.gitter.spiros@gmail.com>
 <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>
 <av2pBh7vLj5DVDha@pks.im>
 <20261119060524.775205-1-gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119060524.775205-1-gitter.spiros@gmail.com>

On Thu, Nov 19, 2026 at 07:05:21AM +0100, Elia Pinto wrote:
> On Wed, Nov 18, 2026 at 02:33:12PM +0100, Patrick Steinhardt wrote:
> > Phew, this commit message really is extremely verbose, and I eventually
> > lost steam reading through it halfways.
> [...]
> > So overall I bet that this message
> > could be condensed to half or even a third of its size without losing
> > much information.
> 
> Fair enough. I will cut it down to what the diff does not show: why
> the cast moves to write_object() and what changes for the user.
> 
> > These casts here make me a bit unhappy, as you also have a patch series
> > in flight that fix `odb_write_object()`. So you'll have to send another
> > patch series after both have landed to remove those again.
> >
> > Would it make more sense to defer this series here until the other one
> > lands?
> 
> Yes. odb_write_object() is changed by "use size_t for a few more
> object and buffer sizes" [1], and parse_object_buffer() and
> fsck_object() by "use size_t when parsing and checking objects" [2].
> Once both are in, write_object() can pass the size on without a cast.
> 
> 4/4 depends on [2] as well (see my reply there), so I will hold back
> 1/4 and 4/4 and resend them on top of [1] and [2]. 2/4 and 3/4 depend
> on neither: 2/4 fixes a bug on all platforms, 3/4 a false "SHA1
> COLLISION FOUND". Unless you or Junio prefer otherwise, I will send
> those two on their own as v3, with your comments on 2/4 addressed.

Do we maybe just want to hold off the whole series until the dependency
lands? As you've seen, having a bunch of similar series out there does
not guarantee that all of them land faster, but rather has the effect
that some of them don't get any reviews at all.

That's not all that surprising, as reviewing these kinds of series is
a bit tedious. That doesn't mean the changes are not useful, it's rather
that we are short on reviewing capacity.

Patrick
