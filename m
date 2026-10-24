Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854423;
	b=WSmPWAVLg+gYlmG8yv1EaRcimYY3uPP7OrmXAVV2w3tyxp+hA4ezeXtUY59Xb1DuYsII
	 ynSid3r3/FLUksaYBpMf5ZklCHM9uuyqe3TmMUgchMoXRqF/Qojw0urTdxacDWYnkMurk
	 Sdp2P/ghiQ5/YK4t8O05AwJygmvCBQXi2irHBiqGnAvBjgi+hOcBtnLZYlUVdaBRL6kZA
	 eFA5vPNKpbMo5qXsvgEA/BeHDhqMcPE/R2WUh4Jf7G8yjbTHt5gYrZhTVzorPdtFGTRfN
	 wxSFpFzBIMYMJDoxAVh/GqF8Vf7D+uKA1Oz9LX44lZXfsp2q00U21Pl/m30t5TenqHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854423;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XK39aJSe+b8NNtVT+t8QiJA4/k5e/f2MwYFSBal5ZdQ=;
	b=PYN1EcnmEJJs5Y8x5/EIdRIauz6/AG2/LIk9n5nCY/ML7bPs3ADl2Ofs5cX1RQY/c5i/
	 ogOgW1ki43Qophaey0nBEd+/mjRzB8XlxGYEMvCPC6SXul6WBwc1kcJ6ohhHh+g7aF10G
	 /B2eT0GYl4lOIzL/WdlmRUy71VLh2J23uhoChD+CkG2oEakHYFe0VBStC/rx/L5GnCfxi
	 VtO687p26OFe8o6kqaz1vI9smKsbXqs31om2NivAaLcHnM6E6Fdcawhb1kHFUXQDo77LP
	 QTLQHLncQYbN6Rmx9JQ29a5uXR4dJfXm+MW8CSoH9xz3++QMWxaDeNNtkQgO/e2TnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=glfxjCzt;
	arc=none smtp.remote-ip=95.215.58.8
Received: from mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D1606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 210D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=glfxjCzt
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hFwXZmO1YJb4EMUEMGxy9u0tFwN9swJ6dRQv4JRD1TM=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792854420; v=1; x=1793459220;
 b=glfxjCztLudlRexusvPC/Xr8gKhwnbp4CWdvrfctGbZussb5TADPa9FaarWMfkoav/6K/sPz
 hZasJYRtBkDJ4sb6Om3d5vl3Vt6w/B7GloyTxpTKhCKqIyy5gSkLyGjVfYrPrR/lCkWNPhd12dg
 HcdP3u1xacO/xeyc0Sjem+2AOaCcik8fAYEQM170Os/VvCCqi1dV7peaNmFhEHLzqEZfOEGvCUw
 caLDTYQiwBKjiq549OGG5LfqP4Qqb/eX6eHM19SjqBHyo1MmavjH0K+N1/+Qz6TBUzInKqRItmP
 51LyE/SCO9FT4TgHFwtxjq+iNlvO/0LieMKyAJ4rvSkfQ==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dbd1486e3a41c326;
	Sat, 24 Oct 2026 15:06:59 +0000
X-Mizu-Trace-ID: dbd1486e3a41c326
X-Migadu-Flow: FLOW_OUT
Date: Sat, 24 Oct 2026 23:06:55 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tuomas Ahola <taahol@utu.fi>, Phillip Wood <phillip.wood123@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atzJj546SPgoRAby@wyuan.org>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <xmqqjyn7171g.fsf@gitster.g>
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
In-Reply-To: <xmqqjyn7171g.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> writes:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> [...]
> >> I previously mentioned "topic count", but commits are far easier to
> >> count.  So instead of requiring two topics in released versions,
> >> perhaps requiring five commits would be easier to implement and
> >> explain.
> >> 
> >
> > Quoting the summit notes:
> >
> > } * Emily: Have we used a voting process for something like this before?
> > } 
> > } * Patrick: We need proposals and a vote. Who would be allowed to vote?
> > } 
> > } * Peff: Active developers with a track record; perhaps a threshold such
> > }   as 50 merged patches.
> > } 
> >
> > So it seems that Peff's proposed threshold was substantially higher
> > than what has been put forth in this thread.  Any comments on that?
> 
> I do not know which between 50 or 200 is more appropriate, but I
> think these are more realistic threshold.  FWIW, I made the first
> review comment that pointed out that the bar set by Emily's document
> was too low to cross.  The "2 vs 5" you are reacting to was merely
> to point out that commit count would be higher than equivalent topic
> count and without bringing "2 is too low" topic again, which I
> already gave an input to.

Oh, so sorry that I was misreading.
