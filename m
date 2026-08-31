Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83838D
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156051; cv=none; b=r4CV3EXPlgRE3f9j8f49yfGel+jS3lbs2ae5ka+1Dr44iGEHoCyCGbf8me/Q7pT8nt+eB/QXdD3pqnR2gV73fG40f0wsr2Go7GjKOExeYkzBBF+aWzQdd4zNoxD2qhTlM525XzAI2jmXhGW3/Fx4uGc0V90Mg2E+G5Vei2SkupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156051; c=relaxed/simple;
	bh=sAPU+Ca/BNAjqDyX4DrkPfXCeX2XS4JmN4zxAbuBF3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnvTgwp/bnS5bZkdDAd2IHiSn5M5skuPvUTH4qnglpNZ+cX+dU2J6MiLACO7/NW3EoUUXy7CW9Q7B1ODjEAc3wuQPsWovFMyMHfWvp1tQ1YtjIHX2PifVTdaXp5sDj0dEWkFqcCUDR7OzRJz/2w9zKnMFupiLPZfpcb9axwtr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCcif46t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfwsZGFa; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCcif46t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfwsZGFa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4E3D7A0136;
	Mon, 31 Aug 2026 02:00:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 31 Aug 2026 02:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156049; x=1788242449; bh=afJ3lX67WY
	AB8RombVZeMO59skwrHC7vYc/zLtOmeu8=; b=nCcif46tZd6B9UszukWZ5o5LQt
	suQeY8kX9x/HJ6qALtHe3SbtoEefcxywuZ5FtrE/UhpcRReMCmCJUzoOUD+e82ez
	HBjuYcL80h5JNlzNcvaMiGLI3x/QY+nKINqh/dnG+KDKTHQbuMiZmWErcOwX9sY5
	/iLbzphJxJIVqAvdVx2Ddc+LUp1fxDa+AV0K7yHC2btMYFlT+6AlQEUYxhtW352m
	GaFsHDgTpZA4CRJ1slyCKQfD6O78lfm9pD4ErpKhnGjysWf4DdBi2YwDtqgKZryF
	maBFg0MbGl0hgG1Gl6BdLfBpQwcEQYS4e8+R70j+Rh+q9z2R434nZSnTYvHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156049; x=1788242449; bh=afJ3lX67WYAB8RombVZeMO59skwrHC7vYc/
	zLtOmeu8=; b=YfwsZGFa1biGXxeD7UuWqwVWV/OZq5Z8Wbh/BTqh89Vl1K3uD6U
	+HIDnXC+LbrRntmkonBvekePE5o79ra4Rn+PqOT0gN6rH000lU+75vzvFVYPjJW3
	IrcGzUZEkyaudMwWFi6TtvrXE5cRJIPbXA/jMg8ufdPbO2G0gQXOZwwnFuikon6k
	svEiSrJOoOJVbAuyPQQFGyPB155l41owms5sQH6fxPmGku5dJCvSSRXBEdFWyuaR
	T1neSPxaShVUwUCEwRFXUM9sO8pn96uFDVm52cbz0drepyd4EcAtZMtHo+zyN5Ce
	7PQ1ciWX7dLg5+qMootYDW37qGGQ6CPKymQ==
X-ME-Sender: <xms:kRiVajcSNUtpdo7tpEzVVxmKYlHtXfGnPoFRWY4jCO8IwJZcvVeXtQ>
    <xme:kRiVavPKPQneHWRvi4RGHmh2gmCfs79cNAYqJ1Lfw7kLrtN3WZToC8IpYxQ6WW-nV
    wxZcAR1EWmnrBvYMdJNB-0FQfSSVhwPolMzOp42b4CutCqmAIG-Lv8>
X-ME-Received: <xmr:kRiVaqKx8nlmG8qT38suFq91J5n-BRWNau1opV7VdRRabekTJE1wHDXCV3j-undP_e4PVw>
X-ME-Proxy-Cause: dmFkZTETdnV+1Lx7Ywt8j7HKvcjJOkdkKoWrV18B+EQCxVJhhDFWuf0TIfyoWy61XFEGT7
    wxMP6pcLmQqHTHV3VytQjZWjlKOT5+tlWigTUBQ0EJ6/B3VIGb7fPzoGNtP5c1My0YAudW
    foC2eYYSV7PtnbA98NQJo8Qna7lOcO52LUnTvBdv1IwVjxMWKHArQeH/cMwb2GbBqX7JFi
    8FcT7Nn9e0T1tbwttQaKZW/IQ/dcPuntggzDWrsSksUL7LGXEvsLP17x35RsvQlDbeyAF/
    mhBeTz7vGc6+8NQo+lXdTOk0n9jNYhukJ2xCEAdqpREftLRWyW8B8y9zm3/DV049ArE1Na
    ck5938Nqn/zREoGFlgoE395BpnpTsC37Y65X51UxvqTpFNhZKrTMXFaaovI8b+qTKAJLu1
    EdUAhOot6jdtS9wOfSZh8UiNmI95nKT6XwhwYU9iGNIPYGxtCpAfWmlfEq2C2pT0WbJtwX
    jLP/FPCsw0xkbPA8x1F63si0wM0rhLTYJWFCae7LDsgr5pDgMaJlZj0hLTdZVYL23QH4nS
    Uvj9G1eWem5EBZWCSNPqjsF52DXF2QU63XnJRsWRE83cAK0qj9KsKIAZ7E6lfRTzDjeYX1
    IAJywzZ+EcKCfTpChgTukMTAiNWxofpxm7S2pLRAz2X+Lq/ffuvl9WuBdS3w
X-ME-Proxy: <xmx:kRiVagF3H11iAHUq5YvBhLOozhe6lsIiIq7J2QyFjUk7YYbdiRhQBw>
    <xmx:kRiVaiQPA2gtYHP48mU7BqkmcUjhllGeLeBHsg5y5IdTnEdZWkpRlg>
    <xmx:kRiVasG1r9NNwd9VvydWf-4VUsHYx_Kfcplc27QuDyw2mCwaoICh-A>
    <xmx:kRiVau97nMbCSH7cKB0hLy3Rl2OkCU8S2lp30FewjfmGD1BE_KbF9w>
    <xmx:kRiVaqMYGDXjzNFeSHCprie2M3Ku2mZRZ3l8B4pqJAYZIXZPg3Y8YEfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:00:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 258bff76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:00:55 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:00:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] builtin/fsck: move bitmap verification into the
 packed source
Message-ID: <apUYiv36xvWe-oj7@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-8-b756de0bf24f@pks.im>
 <CAOLa=ZQwhpPMrgeLW8W0pezH8VFrqDiiAfet3G_jDRQDu_KQUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQwhpPMrgeLW8W0pezH8VFrqDiiAfet3G_jDRQDu_KQUg@mail.gmail.com>

On Thu, Aug 27, 2026 at 06:54:51AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The checks for bitmaps live in `verify_bitmap_files()`, which is called
> > by "builtin/fsck.c". These checks are obviously specific to the "packed"
> > backend.
> >
> > Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
> > this means that we now properly honor both "--connectivity-only" and
> > "--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
> > instead use the generic `ERROR_OBJECT` bit.
> >
> > Note that this change also adapts `verify_bitmap_files()` to be
> > focussed on a single "packed" source instead of verifying bitmaps from
> 
> nit: s/focussed/focused

You can actually use both spellings [1], where "focussed" is more
commonly used in the UK. Anyway, I'll change this to help our American
friends out there.

Patrick

[1]: https://en.wiktionary.org/wiki/focussed
