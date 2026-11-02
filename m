Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608951;
	b=BuuUvjed8ctcCfMJOr1dklAXMVfT19b+4IZcIG1XTbjtuQI8WjF6f0Sffqta+GgsUULz
	 8/YLW5ryXT7Diq/0EQh5noXXCdsh51WhTJaOMX94amJckh+tWt2qdw52kE7dWNQsgkxSk
	 0FAzdTpMwumaklcuedeiIzZyv6BDZIXu0U3/i+9YkJB0GrL5JN+2a7KGQq3/wOBc9bIVi
	 ekzi69YEb4YCob/0hrLjDW+Dr7X73xNq2fy1SMxIQGbTx2rWfZXMCBNVEi+rtpVRzdnit
	 vLc2rdmWTT/Jh7x1gshH1KyMFRC7aydZH7CW7JUjVVonAX6o/W2ETHgvZcAh9qQhTug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608951;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=FWEUFzeUlmnsQgV6jjicSDGjrbvVoxLMCsLmv0IA4cQ=;
	b=SjkjFrPMs5fTTZTRamVJvJ4G00tE3ZcD9q8Ffd7JsyyZkslr5+ti7nl2EY18kY1zUfF5
	 wwUErBx6QHsjwic3A2p56KX2Amrhvg9rysZC+zvMtEkvwv96511dtphlHXOLTPgltST7L
	 rIq7W7GQ4ppOG3zmDcfuKiB84hKmKUMcle6b+iHHZJJ77Kd02o7uAy1DK1YqLckjXk+VS
	 ml9ihQ+u0JNhqeoiPQQq8VPQd3gYr6b5HHrDI9nOC8D89I/BSLNNtfy6z6j4clvn/AlIz
	 AnHw878H1eps6LWz/uvQRPII/muY+mUGFdWvwNdS354p376anKmmbOZtm708LMJ88JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=b+20SkZs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="x/OCoGoP";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82296606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82296606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=b+20SkZs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x/OCoGoP
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABC967A00FE
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 03:42:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 03:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793608950;
	 x=1793695350; bh=FWEUFzeUlmnsQgV6jjicSDGjrbvVoxLMCsLmv0IA4cQ=; b=
	b+20SkZsob8n5n2Qt3kuZevYyOEbCOY7ZBoJVglN5AR3l7FUg2Ei2EH9tgbAnxs2
	IGaP8OI9xo6WobgLbs/DBL6ssCDiQSMyIATp4KndX/7mCSiv0/XUZll9gXA4U84f
	PvKOq2X8dRJ6V0aKMhkxkihZQL3yj9hCYgIEQ+ST3AO28A6cSwf4SG2RRH8HEIwN
	rH2P2NW/Njvrg67pnL4EX0vEmhuT2gFQe3pHdT8ILrslbNdQxgbRQmuu5xHXgEjd
	nEzH1a8xwNj1ROgvczs1y21ZDVxcyk5w0+ixnq3AtvVN6oRXLQne9BfYKQ9QUYbn
	6/r/8SYu9KwlQCYbVrcq9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793608950; x=
	1793695350; bh=FWEUFzeUlmnsQgV6jjicSDGjrbvVoxLMCsLmv0IA4cQ=; b=x
	/OCoGoPJe7uuoxlHycJyljU0ueAoggxWuKE8rI62AOKvHNz3yyGfhDVYQsu2A4Tx
	at0x3+8BxnG5KA9fG9i7tAobcsoYbczzXnMPh8S6FaYWkkoLX1+wKLoKS+xr2gME
	62PEIVwFXy7ORwJbIHxRWhWW8XdwZUlvsoQ7piJvr3r/OHXvqdnbqmpzMru2np08
	SBo5DmucsSWfWmlcOGyR/ggRa8XoKtWXacBETnod+gWPNY2au4VSuTx/uD0aLH6I
	9WBM+l5MEpjbKZe86l8WfqnBJ0QQjxEgSqiNm8AXrsgpDOMhi0y7aHbXbmjR9zkX
	TNk/4FFOCKG3+/d/Ew7pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793608950; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sp/hrj/NetxoSYtaHH6MrERu3vVk0fH/IKS/7A0FCV9+Keh
	7pRoDYxvF6xGTNFVdfnK3bWQbU6zz+RZfJh2A1w2Lbldi8AhcPNx+vzJ6T4u6J23
	k8CXwKulEOZpUK1gcG6xZg5Uoq33QKVAZibNvHDFbRTZROsUUvMZSNG3D4sxmlDD
	SQa2McYaVgx+k4dE+gA2NBa8LbTMl7AX8pWrXlPmaWDLB8ljx0ufA+WtF7a/mJtm
	GFW5M/FLVFibcMW/5qlvnzvw0E4/dqmodK/QHWgxOMVj0VKS+rwMIeQ0JcXd9IMM
	j/zZ9vtTDmue0/Yc/4WbqmtOY9dAtpJHzykLJzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YDYIOYyVHJ10XfUac0I7pl3wZ+OhXepRId+tszduiEA=:zW1WXk1lgX3H1YOBClaFxOxgvy3ZU+upXIbCvnv6dXQ=;
X-ME-Sender: <xms:9kzoapzFHAQsyW_QUqb71xBZjhLSVgpWakKtblmxSH10uYUgWjGyHw>
    <xme:9kzoagtDbL9X_iaS2Bfd9xyC4dkUOaVCDTwqzvtRmAXlg9zDUTr-Al5HidH0joMUi
    10SNuTN-L5XzascGTRS7MsiGyw6oBPjsBd_jeYEwK_5PgJimK421a0>
X-ME-Received: <xmr:9kzoagt29lEasB9Wh5XkZhfsTzD56ABBZ61lGMfRoNiCIreKeGdOuvp2e3Pf-euL_63HYg>
X-ME-Proxy-Cause: dmFkZTE4WLiNQLn6csX2Xr8wrsGVS5v4LUrlUEL8V27SN3qu+a0C2G0zi78NodM3xcqdQz
    I5u9rnAO0ORG3oYy1pzb/QuYH/E92VKnV9ye+KXVGjU6B5PQTz7Ah2CSc3LZjRhLkjVChY
    PLKmDtgILJy7hKY6WMQbzISVCD95IcKKU/k/TdiEfyJ2GG7LuwMnTptDJQNeT1djmsm2Vd
    Z/CPaGKPfUHTXWsYNL0lYYU+7GJowMZlmdPsOH2hSapAEK5L3z7938kK1YcJX6ckn3d1lg
    pdrFL/GOplhpvC7wHyrm2isYoY/7vEFUcFqooB+9Kv4XsUMGqhBzkKJb8jlNqcsQMDdYEf
    +PxWUXKGiUXt19aT51IbwxHCh1D9Lq42BCqBrJ/cZaj7oOy1CueFxfPxX4WcNGpkDinn33
    X3K21bK4DaGN7i/pmzFK5Zv6b+gZVqrxZF+xxrpzm+r2kFmbbJC1sr77WK40j/x4fsr+IC
    oSzO6IvwLtA1InRqxPvwzhwL2OZlQFWqo00LDfJoY6CQhKfFnUnOv9H75pLAXVdgI9SQHy
    tkFAV5iakMfKO/8BbojsgwpSxjzbWSVbaFjEh1YJ4Kl7WCxURVYX9EsFd/lkmT/f00sLa/
    kKR1M9BWKcW6BuqkVPDsa9sWUVXJm1K5RezssDnzzDo8dWQ9xTnoJxMz24rQ
X-ME-Proxy: <xmx:9kzoalOo7JgzNx8fsp_XW07BUFqhGW3gTvZXkuXJsz-MPhvupouUOA>
    <xmx:9kzoau2440xcpDaj7bFcra9hVw_02ZvRYAwIs0Sl7ELSevI48scDvg>
    <xmx:9kzoahMsKGDfRYsjBr-lIaSD95ULcnf9M1wu1yNtDRuf5VuIGhRO1Q>
    <xmx:9kzoau3fCpJcoB25M795VIliz6pG0AyDoj1RZNJMYgK39-_9AyrZIQ>
    <xmx:9kzoagsJfRrW4OrnIrvFHuSdfsvThN0sWDKo2asa4v2MuCdxlGNRxUdU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 03:42:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 028a932d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 08:42:28 +0000 (UTC)
Date: Mon, 2 Nov 2026 09:42:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -i: hide init/clear_add_i_state() functions
Message-ID: <auhM8Y8mkRMJOdjH@pks.im>
References: <xmqqv76jxl22.fsf@gitster.g>
 <EDD8FC7B-91B4-49CA-AE6B-3475E03EF786@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EDD8FC7B-91B4-49CA-AE6B-3475E03EF786@gmail.com>

On Fri, Oct 30, 2026 at 05:35:20PM -0400, Ben Knoble wrote:
> 
> > Le 30 oct. 2026 à 11:30, Junio C Hamano <gitster@pobox.com> a écrit :
> > 
> > ﻿Patrick Steinhardt <ps@pks.im> writes:
> > 
> >>> On Wed, Oct 28, 2026 at 12:57:51PM -0700, Junio C Hamano wrote:
> >>> The "add -i" machinery is encapsulated in run_add_i() function,
> >>> which uses init_add_i_state() to initialize the machinery, does its
> >>> thing, and clear_add_i_state() to tear it down.  External callers
> >>> have no need to call anything other than run_add_i().
> >>> 
> >>> Make init/clear_add_i_state() file-scope static functions, and
> >>> "struct add_i_state" type as well.
> >> 
> >> Nice cleanup. For historical context, these declarations are not needed
> >> anymore starting with d51b61f5dab (add-patch: remove dependency on
> >> "add-interactive" subsystem, 2026-03-02).
> > 
> > Thanks.  I did not notice that I gave a backstory for the other
> > three commits but apparently did so without digging into the history
> > for this one.
> > 
> > By the way, I queued the patches sent to the list on a branch (I
> > initially made them on a detached HEAD without keeping a local copy
> > after sending them out) and tried 'git history reword' to update
> > this one, but it seems it does not honor the notes.rewriteref
> > configuration variable.  I wonder if this is a known limitation, or
> > a deliberate design.
> 
> Indeed. I believe it is a known limitation (one I would love to
> lift, but will probably not dedicate time to produce code soon).
> Still, I’ll help in the usual ways if I can ;)

Yeah, it's a limitation and not a design decision. I'd be happy to
review any such patch series, as I'm also a bit short on time recently.
Meanwhile I've also created an issue in our bug tracker, so we may pick
this up in the next release cycle.

Patrick
