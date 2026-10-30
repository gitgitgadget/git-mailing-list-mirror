Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374249;
	b=3Mwxv+iJLW5a5g7iIGI/ahlNR9mpPsU4wkPC7YE1RmFRc7XMMruTTLns926tr7AqrX4i
	 j6ad8ZpAQTki/hHSDwcr2wsX38iRgZMk8UexQnlerwildfD5NOvWumCrFas/oOlJ/wPQM
	 FghslzRQq0MTjclXtMfNrdCZlNlD2WrEmI5jY3g/2hWwE13MCidcMQTbYHEZeFRRBMMZZ
	 1djyuqcCSz4j+pL3F25F3sffKzAw40bF9gNtipnQ/Annzyn6Vy7tOcM5Vr8juOm0Qu4++
	 7LWGifkeZRjMTOToJY+jcJlLfuZWc6DN6Zhf9YK8pXBgZks95uNeFBlaNa0HlGiSGUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374249;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4cWKT+8yV/YXMmuE1GG/tJt5OmMOOkyNkIzEVN7T+us=;
	b=H321y00+aINisbwQ1WVXV7MN0U+lLuI2Yzz5FHNxFwr8wneAnZywH6Wmzgc+bBVqYcq9
	 6dA6YB5GoN7tN8Zt3uyrCoaCoB2g8I0FIqGg34FHmqT+bUrFanJfVX/nlu2ROv04qqI6+
	 cCgzswrbEaM18RfB+47xmU+TmTNAOFjX+03puYP+P7+Imt9XrPspfmIVoU4OT63LFhSYV
	 dk9jZwkYCzwfZkc+e330yNT8/1okkDZrue57GZY2YDhIV2MK4fKOelq7bY5caBBSuS+46
	 IjzBrhyImTH7wsO1MnKyvU9LnjnQKz+HjrBYZf7sh/Y0fS2CAEy5QKjJOkniUgMmU4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dCFB1hUy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQMDcr0Y;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93086606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93086606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dCFB1hUy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQMDcr0Y
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DFE771D0015E
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:30:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 30 Oct 2026 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793374247; x=1793460647; bh=4cWKT+8yV/
	YXMmuE1GG/tJt5OmMOOkyNkIzEVN7T+us=; b=dCFB1hUyu41TmgKRe0bcA/impz
	tkscOTw7CqIpO7EkyKuj2SDIH4BqEscafrFUJ6t5ArBYUNySyu2fpYlHUtEKY+lh
	ph+qxRIVZRUGUQQCgISQ/Shxel9WfmYKm4F9mbKx8N0PBZU8AkQRSDmfxoOa7ozu
	RKQw3llMm0YtyUgjhDG7j5y+NbifwP8m07VU6VXbxoSpLAxVVk0grhMvwaG60UwX
	VLTX3tmH2sh1Wh+E7m2uD1xY0Z3Fr0ivBbIpUSx4Ibe019nXotLbyNpPGJHku+9J
	OeTFZOI4pQRsQz7LHSqwvz93KtwNnqRG0rw/J6EWcYeO9VoYiJKrgsOlNQsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793374247; x=1793460647; bh=4cWKT+8yV/YXMmuE1GG/tJt5OmMOOkyNkIz
	EVN7T+us=; b=fQMDcr0YIG0D1hJDB7s3EVL6eci9Z4OGNNb1KY/YlTydWDZthba
	RwQ/zs8XzsMmkQ2xWSUj/YwDpxaqBwsrSBcGTnkZnimCFERAq099h1aMyTWmr0S4
	DAshsIGSEg4iolM0szGvkfzTkW3Cn/QTZcfQCX6+zWH9Phd/34CFNj8weB/deGyi
	RF80m3LSZl4o4zx/j2jlTxQsARBG8SQR1I/d7+WMdnUfxobMpIbHxU99x9ktFi+e
	Fn2UALLO+ZyOAOrB6ECCVtq7jD/Idtli69aeEMfBNKEhjDMMGC7l+BvOaFeu4HK7
	3lgShnmh0DStOTmP2SZlTQJhHFY1AL0m9Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793374247; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:U64ANAJMv1r5JXUkF/22Xu1u4ZYKdbzm8JwPJGdBNFX9Btj
	k4XRwiL4x0yHQwKR+Jvk/whUsBLDfPrZ/RlebXEnMmjsXThO/P0hAqsbz6EvVOZt
	n4L10h3Fs833IK5KGqMeCis0b4ZdILdLUqYr0iWhmsDE5egiocmVj44NG7KBDx4y
	a3xjo3V/ThdVVEf59t0GCelxhmcY0rpfNAcPSUWZlSSu/MYFi3AsBs52vioa8P8K
	HN3lCq5tMXzEk9eLhr3ZXwnbX/CjA6y7CDoOC+iXI4Z+Gxmb56S/N9mLGfUf7GLD
	IXZpbSacIMYVFCOdIVKa8OjJRwNvM7mcie5e0ag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hEJdtDuhEyTwtjcOAHUlPTpQU8UHtcyn4Ao+/xssuog=:IPiQLIxFqwNVAb8oNi1QOTobz/VMa0QrL5T6/Q+eWt8=;
X-ME-Sender: <xms:J7jkarKCxFuKdnF4uj2i3U4WIk_VIKVXc_OtwWFkWlGAilGyEJTxZA>
    <xme:J7jkammJASr6bK-Hcex5jhcZUw0adHbdpaZJlbdKluYIkg5braB46dHcBfwlrGPOm
    R-WoV3ECSeR6xy0I1FabtbMof9IvYsygOeWocZx3R90NAhLpv65sg>
X-ME-Received: <xmr:J7jkahHgZTPjXLHDOuhbRB4gAOLliDwcpigxmf6IHfROA9CZFJWKRg2QUyqfDragr556OMqUZ5b9oAMM3Z8jYJ8d-e6J4xRjke5p>
X-ME-Proxy-Cause: dmFkZTEoFE/ObT9ar8JkbpeL7p6cAFij3c7LhDnZ+4eV6CoNqGQfTDJbM60f4jT82u2CDs
    /+DYBQ4wn+S6JSydBUDak55KF8lHix2FTriEw2LonUuzZKh71G4xfYN1ADe5cfCsTzHQR6
    B3GzVAnb5me36wu95jG/oFIYiRlWGfmtqfwlGQ7Xa8ypHU9iJJ3wOGLsYUvUa4vJkB8XbY
    wLleUkSpYooLU7CXN+wip/D7ZttvQfO00EV6QKtYgBGqbuKmjZSIl5WsiUC4ISUfDk9brZ
    vvN8U735gfAWWFklUNQK8YP3+b/IBuLm4fer+Et4tuDyJGWxUJrDPKxgf/uCxw2DrTwgAL
    V9HIyt/GIEQM93Ygvr3RYWfcFQR1wMjk1aaOwOX8JVrnNg/hqv2FNL5Z6t5xTL3hlbwdaZ
    EYlm/JJQJjbvm65Vp3aTYaldl6xPZt+BgHWLvmfQPOiJ2p71xRPddlaB2K3VNv7O3vfERD
    g8t+6JElFDmNukdHHeE98wOvFO2UoIW+k1HiMK5T7QkDoVCehN4BIANGp8OzM89WWYepvf
    Hp10cY7n7gebWD3YffzWSFmbd9/V/M7FfWiSzCi9JS79gFQ3Qf3hAdf4o61Tu6Ea/pRvkv
    b6vTXa25ktJvrsnHD2AvEGzcZSRO6gCgbzsR7+dvGnZUwYUcgovkEYHkhO4w
X-ME-Proxy: <xmx:J7jkauEwJqDywe916G-sLVpLuDlx-uIXM5mStq8QZlFU-PC_t7ewNQ>
    <xmx:J7jkamNx-heSxF2aj9V438d_GARAqVVm1svtfnIbQ-sy2SekTDEddQ>
    <xmx:J7jkalG6VqNghscuVGo67nP9T_SoiHm7vNsh4tRNRACQ3kPphc9aXw>
    <xmx:J7jkalMk0eVm1AxJgbgDFqL4oaykRj-p-5vBJIE8jkMhN8ha9nkIxA>
    <xmx:J7jkauvf8v2ais6lQ0vVasJttncdPqAg1Sst9ptF4k3c6xL6zvy-pjLM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 11:30:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add -i: hide init/clear_add_i_state() functions
In-Reply-To: <auRlfDXPhp3RjNyk@pks.im> (Patrick Steinhardt's message of "Fri,
	30 Oct 2026 10:38:04 +0100")
References: <xmqqh5i58uo0.fsf@gitster.g> <auRlfDXPhp3RjNyk@pks.im>
Date: Fri, 30 Oct 2026 08:30:45 -0700
Message-ID: <xmqqv76jxl22.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 12:57:51PM -0700, Junio C Hamano wrote:
>> The "add -i" machinery is encapsulated in run_add_i() function,
>> which uses init_add_i_state() to initialize the machinery, does its
>> thing, and clear_add_i_state() to tear it down.  External callers
>> have no need to call anything other than run_add_i().
>> 
>> Make init/clear_add_i_state() file-scope static functions, and
>> "struct add_i_state" type as well.
>
> Nice cleanup. For historical context, these declarations are not needed
> anymore starting with d51b61f5dab (add-patch: remove dependency on
> "add-interactive" subsystem, 2026-03-02).

Thanks.  I did not notice that I gave a backstory for the other
three commits but apparently did so without digging into the history
for this one.

By the way, I queued the patches sent to the list on a branch (I
initially made them on a detached HEAD without keeping a local copy
after sending them out) and tried 'git history reword' to update
this one, but it seems it does not honor the notes.rewriteref
configuration variable.  I wonder if this is a known limitation, or
a deliberate design.

Thanks.


