Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617754;
	b=s/917o2ne/sSw68Q5Jku+ePWgJt69bRd2OxdNKHyTT1lN0OLZbM0qyYTlvaAonsAiXYn
	 YvjtBLyFPMWC8Qy3lDTr6fahVgltVHsmwmauix8J0lh5zBb+qicndBCn/xFCNKG/tuSqE
	 1wUYr9YcuK0g/qvTH48TJT650I7t79YjYD6RQlOOIkJgInmZalCMjfclSCy/avr+XKHRZ
	 RXeYBr/3jVr/V6LcoNRnvut8a3AVK6dGZDQOUceTN9l5/3Tvf5+8fcLqonCaW6tYL7Z9g
	 JZM6sY9XYWg1rzPk4X+TU5ro4BWyu13NP54+PpnWLXS2TPkaeLZ4nC6ZgRqBUEzVhrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617754;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dTcIcHvi2sP7IPclBjKBlGSRMSPa7UdDE1maazrF2/g=;
	b=MnwYa2j6Xno3JFjl9o2GwYNZuacTzDqRPYZuuLjdAZlouQbMBZx40k4Znb9IJrWI+Ewm
	 s1K3fkJZTy4srGQ29GK2pOAhcqVmAjdXUnATUHy9goziVm2EGEXvMkfdyuTZEhv0vz5hs
	 XxCcnTisop65CjdetdFdhd/jxQd3RnByeNPYVvwsFaFYWXo22NkG5WmHiNWwCRBDVw+Ey
	 iSknuvBvhP84/x6ULc96VEkACa5uP0a6wSNGXFPt91JPBW7QdsI8TPN3rbidRHqUi08lx
	 4WWwCjS7EBrUaMI8dbn5j0L0R00jyuheeBnW6eyIM1TTMORy7PJGJcZbB+apKlj/l7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EhLOE8yl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ntyaWEzy;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9C606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D9C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EhLOE8yl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ntyaWEzy
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D30E77A0129
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:09:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793617752; x=1793704152; bh=dTcIcHvi2s
	P7IPclBjKBlGSRMSPa7UdDE1maazrF2/g=; b=EhLOE8ylZiNfMK4zh8qtlnU/1T
	HcY7NHbCLkAp5wIhwrd5Itxzw3qHuOxgoPcmyK7qBZ5KSHTcZMcioO63adACBhE7
	EgotcSkSyAaLcghPbzDhn/A2o1cF6BcfA/LVZrC/JPhUe8UUMyRTQS5OA4ndtaMq
	7RqFpYpZYeg+ES8TVInM9R4TLbpgLX+Jl1WPohHLRuAYwygz0FUM80d3kLY8Jkex
	80FFqcUd3YSXrC0VsA5oP0DhHoVeplpfMEHiMjIeEgD2cOJGAVkbU67oMDUOFKPW
	1YlEovKOBB+p8ozIqSSHj+oO2gd9agiN1A30ZMfjT4yYlNbsamff6ZZyhY1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793617752; x=1793704152; bh=dTcIcHvi2sP7IPclBjKBlGSRMSPa7UdDE1m
	aazrF2/g=; b=ntyaWEzyzfgsCu+Q/sPUMhAUGjjvfDkuLiSWnAboBIESj7/M4RF
	N0uJTX5aqvtqwBLrz/SXbSwZysjBzJqyidEw5weVMUPdQaFZ5bWbkQj1G3wVrx28
	YLQXgMMZKX3OAEgdVXHAkLYj+Y8H+Cw5GdVN7YNAlte9X35MEQFGyRwDfVs/2NuZ
	F7PlVPyjzGeivvdp5xrPXUndgqRAFrUFSl10aHqcEzkJsh9xpzNfN7H4Jd4oog/7
	1d9SWezb54D1zJ2U40pVzeXGlvPFAxbmuhDrbsHID2zA1GlIB3qQzhuPLyRlzsMN
	8r5EH2YaQZz2E4FQUJF8MBJaCopqBzYQqnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793617752; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Mbvky9O2CMcE4Sl+tfOpXf90/ViWvVH0hyLsKKLoCte3tgV
	NZN/MvU5D5yAUKMTtecs+HpEw/V276ych5ROUcZzERL3xv2X7JsUCEgW0QM3cCVV
	+DHGGRTx25VEwXz6iv4CovTS56/dC9r98M7OIaE3u6I4xzpraqf8SqcJMAh5h3xR
	1HTGd+KkBih0tnCbazRPD4qE4lZyTeHIdtyJOmnXnUQ+3GHaw6Ahe0yrjHAbpgP3
	UaTzjvWl6CG7YwKzzuri9y2J6nEtP57YkFkdGsTe2BWthyTl880gvsjc6nRWuTUL
	xQ+Md4XZC51y5f+LGujyolpWpVGgL863WmjV9xA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lavMv1rUv9QKOgbu+lwhkIG9wU6md0++F/ZifchaRXA=:m75gT3utbPgyT8dAQtx7+yHcFy4Prlu0/y0okJuDZdo=;
X-ME-Sender: <xms:WG_oagdqlaT-kF5oFnys5XVKxOSxk4KY8yQjOr3IKP9ewuFogevkdw>
    <xme:WG_oal6wxRgmXwyPgJPhR5QeIirfXSwp_rk_5wz8ux65TNnAAkpiuYnRbm9DF3m8q
    5njKHu-2A9iqf3Nqcc9nZS_qyXgE53dJDpnaCXizFkv9EzkXTENxXI>
X-ME-Received: <xmr:WG_oarXmC4yMHFdVogrIdn_N94B5d_jKeJQOX5H6iFzsgTxgoQlCrDCLFYJRenBUSPrheg>
X-ME-Proxy-Cause: dmFkZTEliNmjYhuHiW++zM6ENhStpR13SBCkkmBi76tKWEPWFOp1VExBKqN0hBQEf2iqIC
    +fPmkzt0+TiKf4mRqnYcShRKC9a9EvYpFdHV4ixbdw6YsSy9CHywb7J4E2TuD+69DKwXU6
    ic1IB1V370TYVnxAsyfR5sUdrSSc07eKb/eTbU0Osn9JQj1vEKOOI+HOIe+q80i/yZ8Fyt
    GyiUAidGqImemaFt5wClOYzTCnistoIjbIvt6kS2t/rb06/6Aze+JZ3NtwhMVLIQ+KKAFr
    9K+HnrgFlnW37QxnD31Zm+oA49CJ/AsJPWVV5KfK27XyfQLUnP/eA8vG5bZUv9Mxx++kqm
    +oENlyltN0zJXFz662QAEihg/DHd5hNXDUNd5UWzx53T44Q2M04/kWeN2gCDn1lXN5QqvM
    xFDxVaxOdYVr3So7UncPS4a3muSBIdSEzi5GdgzTkYatjlGgfK++e1F0aLmjslGzttYCE8
    +401B4Zm5YcNJT8zBTBOc6ATJIO11P761liGyocqMrtzzYBbwAVQO6fV3MV7UAJZH+cLjm
    PfZm82Pa2QukpJK8LWT/4GL4tnk5HvUMGRiaUu+hPSJBwWeZATAeIIcEXod9zuja1TGRES
    0xClKzssvS1KNdo5t5tC6FDDxE5OORfGTu+7LJ9SP9Hh2qn/AOv8dkRiNo7g
X-ME-Proxy: <xmx:WG_oas5IIduFJ0pXcu-qWjT8HcYIygOyW8Bd1D4YfwS5AaH5vI_njQ>
    <xmx:WG_oauri8lyThePwjzsULt4p2xvmI50UqneVWP57_m92ARzdNXmtjA>
    <xmx:WG_oann4MHY1vLshdyR6eoHTC03Lstp5751WNR1d_veBnUL7KIi7Ww>
    <xmx:WG_oaiP4ql0si2AqfEdgR5DNdG99Bc3NsuECfL6cFPCLeMwNTR-StA>
    <xmx:WG_oalkb5rzrUfg7Bd-0vSR7cqD95pQoLLf8nnRqbN_IxN-OCUarWyql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:09:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ded04973 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:09:09 +0000 (UTC)
Date: Mon, 2 Nov 2026 12:09:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] convert: use size_t for text statistics and ident
 counts
Message-ID: <auhvUm4VwXyWNhsE@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <cover.1793352943.git.gitter.spiros@gmail.com>
 <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>
 <auSDKKHJONZjx2LX@pks.im>
 <20261031101619.172770-2-gitter.spiros@gmail.com>
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
In-Reply-To: <20261031101619.172770-2-gitter.spiros@gmail.com>

On Sat, Oct 31, 2026 at 11:16:19AM +0100, Elia Pinto wrote:
> On Fri, Oct 30, 2026 at 12:44:40PM +0100, Patrick Steinhardt wrote:
[snip]
> > These paragraphs very much read like AI to me. I would appreciate a
> > human touch, also to demonstrate that a human was involved between us
> > and the AI that tries to understand what was done.
> 
> You're completely right. I used AI tooling to help draft that commit
> message, and it definitely shows. Fair cop.
> 
> To clarify my involvement: I review the code, check the cases, run the
> tests, and take full responsibility for what gets submitted. But the
> wording here missed the mark. For v3 I rewrote the message myself,
> keeping it much shorter, focusing on a single example (lone LFs), and
> dropping the heavy-handed explanations.

Sorry, but is this reply to my ask to proof read what AI generates and
make it sound less AI generated repeating the _exact same thing_ that I
just asked you to change?

To put it bluntly: behaviour like this is what will make me ignore your
patch series altogether going forward. It is frustrating to me, and I
only have limited time to spend on reviews. So I will much rather spend
my own time on patches where I don't feel like I'm talking to a meat
proxy, because I'm a (somewhat) social creature that prefers to talk to
humans.

So please reevaluate what you are doing here.

Patrick
