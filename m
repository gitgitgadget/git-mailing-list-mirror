Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009146;
	b=BnHJRU+SWN3II8jVygyJR20f/QrCsj7PMCkCFImg0qYaKEdKcaRyq0LbM8DZMmIpdjYT
	 /YTnZZ6ku46o37hMYmxmMVptgDr1glaIAu1ueG7KNuzHvxpqXlUEMf5FvFEO13UML9/ye
	 k7EyOgTiZkAGthVaY2ugjhqYmVdv2qKvJCNaGPq26FN+Mv8tKAwXfBLjRgzKu5XToRQR+
	 ovNjS4uB4/+I0Gzn9mI5zthp6ul4e3w+eWRhw5KWW2npIHWXRaa7kSanoeUPO8DBZTZaj
	 a7gN3TcLfo6wUuEJKqN1jD81C3n61LeVdF/oicUO4QIEN7MWzqOAp6Mb4F8z3BhieOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009146;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZxvngzvcZclnXKjqgL70ovziNluhARgCYaGqpJmVr2c=;
	b=c5nnWQ7Kut2SE4mrN7DB++oxzmOsm6jKnoDJTcZgqiOvlW/2UW+YstRwdNXL9RoJVwOY
	 C3QfpFQrc58WnpIox9gid26/rPz6xY6KJSY0ivA8wqQzoUcoj/skA78bpwigKwYdjZfu6
	 wHSMqwFGJ9naeijWYaoYVww789PVzhA0JR+Q+oQT9wi/3Aon4SIX2sZ665Xwkro1Xj+Sr
	 Fb+n9z4EjQaNj1kfcYLSaimdHVKmfrtvT7XEhbQ9fLs8Rt9jti3gUVtvYP9t1esMNkzOo
	 Z7TX0QDP0nN/VLQ3IDXgm6Uos2pW7AqkwodPqgwy4tiKECOcO5PUbJqnSb/m8hlLmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sIxlqYo1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=skEh1ouT;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719F606A324
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B719F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sIxlqYo1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=skEh1ouT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 00F471D00212
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:05:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 06:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793009144;
	 x=1793095544; bh=ZxvngzvcZclnXKjqgL70ovziNluhARgCYaGqpJmVr2c=; b=
	sIxlqYo17y1uiHf/7cHHqqvB+CC7/QMwa2hv3oa21uykwkbw5//zhMr8ZxEraqht
	r4doYNtdSWQDgdzLGdc61A9+ladtRAGMVwQb12hFGT2wNZq9IFTo8E9VA6DyeERe
	kO0UmymHkXASITrUDJQYjxtq79o0VhidES5/CYARuV5Kv0Gl7u42Wlx3FpJRmj7U
	RVRe/GiAZkYN2iSygrKTTjlCGrHAfk+87oVsnuKIENhlcIzo7vUSLZ4i9Ic0pYs/
	2x6h2DqWglkPVlhO3i5KSOv9vIF/N4FXV3wyDAD5DExWQKp4m4C3nRIehDlTkURG
	Z1s1/b/iEbbIDrkBBZjxtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793009144; x=
	1793095544; bh=ZxvngzvcZclnXKjqgL70ovziNluhARgCYaGqpJmVr2c=; b=s
	kEh1ouTbCkpWoCbSBoXQ+iUxBXDBvtC4A0MCNC3aekIBerrdYLNwqi74B9lkpz2X
	dHpEGVb2sOKrbtQc/zIlTleFGO1FzGErgVtGoK9REldpDUVkngNkHihpIkpByoTg
	//ujqnDcn/0HnaSBWpCACiG7L1wjyqP6gS99Wi8glq7ggBGmGj1RwG5nKx50lCFl
	f+AnsVaqcorwd1HB46vlM1j19x2zpIueXHW+zLj3EOhEAkleT9Hw4y4fj8OSJgtZ
	0rzhxjO6lOHZCdMw/Eyg0H1ZWNLZsToZrFSoZPIXx4P517iHk/zY2iqC/9ptac5b
	HNDA8eOyPDdUyHlBKhpNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793009144; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X67YDqjGxwJzDLU6o+BR+R9LqV5pIkuuKRYpnkSjXYiR1sB
	1o5JOkL0xRZQgRWBEIVQvi9bQOKj2CGFti6iOwX3HF1PrC6VUWjM4SV604KmcLhG
	QCZ/YF0D80b3hlX5uIhzvHtSCbDIUAqykTdh3pumus0pxg/PdYKzwGebwKozLpVf
	rnJ44uh+MZ52mhCcAtosr77TZQs73Sdr4h5BSmvr9fVkFk5+ws6qdVijvbwtIh29
	AtF8706qUwWpPpV/UyajJWDQl95oqw3S27qgNl3dvg/xjBebQASwFbl0VIwZ6kFy
	zCyMMxm3xG04SJXZiIF5WlQRzpOoxZXc/mgdOLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aaGWi8jAIY6I2aL8M+alRrhh986dD6toKxMoCXhd98A=:wMmuRz8pCbC58H9klCwgkiv8V/sDtsmI6y/FiecR+kc=;
X-ME-Sender: <xms:-CXfasGmzPCu6mRv1-qbdl06hwk_PRysKl3GFgIbzuhfqUk-LfheNg>
    <xme:-CXfasxdsi414NOdi1c2zF87sZE-UOg69ZIYuCnoeSmiRljAmq2qBneXRl5Caamyz
    q8J3dT0AOaz99rM-4jlCzejPli3KGQFyvyz3WFJBWzDQRNxN1e4FA>
X-ME-Received: <xmr:-CXfajhAxbY2P8vmhUtvogO6itYOA344x4DhaGaOVJsi2m2_G05FRA>
X-ME-Proxy-Cause: dmFkZTE6NkCz3jxiE8SRm6ZDtGTkCeyIPpnC4SV7nnKUqnZN88r4J2Rswu/T27/dr0HZs7
    +enwG3lO1S8D8EHxAYLCAPQUXm9bJ80DdjDYwJ/NZ4jskD3QaeaH74QxtlmIP65W97RYRT
    3U9XH/X3WJs7EL2kVmmcb7p6EA9Dp//UbwNQg7/Igt/3wR051mCViHCRv0j2dVxelsO6Ae
    Z9nF8PoLTeugzmHi9P5uUREuWqgvgpKHfBEPeps0pG3JO1W2vL3Fwy+/n8Klo4USAtbl+m
    mzbAzI+uzq8JisqmYI8aNQfhPx4zikoLYGhVacBS9vsxfnlUDnHgubTkR9jfmpQVvsbjcf
    VWspaNItOLqBrQBkb/z1yg4uYgPNNMn8c4yc7t020TiS+aQtWaOfv5Wk7oqQgSbRpRSqB5
    bh14Nh485QTR0skYOomRHNuaJYxRf4hGPDJTxa4T9mYcLA5sTe4BtWIpFfYUtc2iBQdkoa
    2ISU1ayF1AWGblHTDnLdBCroNeDx6lxythNQidnmVZOHvKWs4jMWQJUHzlUgUXaLXo1NxP
    0d975qXcEgCHnWOud5Fj5RbqxWC70r+YIjoayFKt+vpHxyihTwyhGEF13OV4Wyhs64slX5
    7qajwVcNKAsBdLmqTlcPedpbsNrIAsP7pPUoDHNftrbHsVyqXtptCFe4+asA
X-ME-Proxy: <xmx:-CXfanwrGbYg0FT5io64NftAwJHWXAdVBIxR_R_4_DdNgN5fHA6KqQ>
    <xmx:-CXfamJnei62ttt1pB0eV6MZT3lTNzGg4-j_9CZ78GGhpGo-dilXrw>
    <xmx:-CXfauSR6Rcut8h_rGHc_seXVB2Lyj7FVRwl3xlRr7rVMldOEUvB2Q>
    <xmx:-CXfaur_iKusmHQEYZ4aWwGkWUnvZfIOVGsiumE-Rq6O3VnRqO1HoQ>
    <xmx:-CXfatMyhqWYI1LRhAemLamCoM3TZaYgxTt4afu7JE5oDjTzIKcL3bPR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 06:05:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0514fb2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 10:05:42 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:05:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/7] setup: introduce object storage extension
Message-ID: <at8l86Eiz73QSAe_@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
 <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
 <atzFrKoU/mrhq31L@szeder.dev>
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
In-Reply-To: <atzFrKoU/mrhq31L@szeder.dev>

On Sat, Oct 24, 2026 at 04:50:20PM +0200, SZEDER Gábor wrote:
> On Fri, Oct 23, 2026 at 01:49:11PM +0200, Patrick Steinhardt wrote:
> > Introduce a new "extensions.objectStorage" extension that allows the
> > user to configure the primary object database source of a repository.
> > The value is a URI in the format "<schema>[://<payload>]", mirroring
> > the format used by "extensions.refStorage":
> > 
> >   - The schema identifies the backend that shall be used. For now the
> >     only supported schema is "files", which is the existing object
> >     database backed by loose objects and packfiles.
> > 
> >   - The payload can be passed to configure the backend, and its
> >     interpretation is backend-specific. For the "files" backend, it
> >     allows you to configure a different location for the ".git/objects"
> >     directory.
> 
> Please justify why you want to make this configurable.

It allows us to already start testing pluggable object databases and the
object storage format extension together with a payload. But more
importantly it matches the semantics that we also have with the ref
storage format, where you can also configure the location.

We also have some use case for this at GitLab as a building block for
migrations. But the above two reasons are the more interesting ones for
now.

I'll adapt the commit message.

Patrick
