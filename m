Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59838F24D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116011; cv=none; b=rkAjI5uve31ALVnWGwFmpuYxaPu7ux85cP8EGqHHg24R1DIU9+ZVUEQ76tzEr6m813SR3DaOuRr74Sfe3huZAuMjKhIqfFKHKi0PX9O6vcr/vhgl8nW+Obmi3MLel/6e95TwVb5f4hH5QXKV8xlHjxsFiEjxtlDoS9Vo62ywybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116011; c=relaxed/simple;
	bh=MTxy7lIrSyIg0XqMusBVe2xIc9ewH2H7aIE0OsZxuVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMuL1uwnkE2kfosMQTE0XOvN9Ty4zi2nz5GT9gLQSOLoGBqxy7SLKahFPTL0DGUt0HBQHKw9jA/noKvONRqPBhHhmRpGi52WVUeDB5k48AVoEyLgfmhw7RPmslDihumCUKdphBAVNJZUEhaD6YLG/ZSFhWNqRTfLMH0nie12aQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hhP4M7R6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnJLsI43; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hhP4M7R6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnJLsI43"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 01B9E1D00037;
	Mon, 22 Jun 2026 04:13:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 22 Jun 2026 04:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782116006; x=1782202406; bh=ICoE5xNRCr
	ErmuxOpIIsFtSTN6nT1ZovEL4DSUphl2U=; b=hhP4M7R6i6pwq5LoMzZjzBnoOJ
	iCG5pT8Zj+o1DcaxgKP3jLjWfwrrjmfSGIjkZI3ZIxrmzBn2reUnL/MGuppQCcZ5
	gIGYCrGFjQcHqxPlhtbvT890n2E4FXK8C/rhg5x4ZIDdtoQjHDnGHivg/4/8inqq
	D7oXYsvFy0Z0Tto+KtWAlfFrOiFshasBlV05XdkW43KkscCK6IzB5JzjgBNVsuzi
	ikvRRt8SzDlo4sNerh4ABECgG8GmXQK3b+9vOZldKBdn/ZxI0AhmlBlLiXA83JvB
	F/HRHvjN2O22qQlg1itrtHgqRO8NMweJ9ADjLIxDaKUM2STVBp3sJg8p6e+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782116006; x=1782202406; bh=ICoE5xNRCrErmuxOpIIsFtSTN6nT1ZovEL4
	DSUphl2U=; b=gnJLsI43bBe9OqNRMjxaIHWG7qc64VeY43JyORFukNIfZILOS/9
	wG1ZuX5fUCVsezNs1N9DMERDX9u5s7vMO1MvtyO1mhUhmjd6e9MI/fpc7Vgydi+l
	S+eBohVbZoeHtFtahkQ4Zd0etJg7ivf/4GRU0HfUt4AjLF7SudVrSlaEefAdKW1Q
	MI78wo0atrPmSr/Cvad/cbaDFd2BGxMxP/rtaff8Dhj5vzgtQwe5AXGqA+tVojF2
	Pm+W4t5CArL/OGQH8pumpmtxj6JRwwTXwOGuW/Rw4eHdM94Hp0QpmWMH2jmLI8AI
	QzBdWM7mFpDBh9+y543QGYyTDTHXGB2u/0Q==
X-ME-Sender: <xms:pu44agJ7T2ideWuXV5IV0yd5kZB8SDxcP5qNdn0g4DDR4AIv0qpkBw>
    <xme:pu44apebINhq6ZLggYdFQT-m7Jn7HlaEGG0hVjWVUwdb1iAOaonJPQKT62vFB1yeF
    6O9NLZnY0M197uZomSWE13_p6bPyVj1Vzq3HlOSW_kCQfqg55QEYQ>
X-ME-Received: <xmr:pu44an-4VRmu7vTVLUCGigdfJiq1niSFlTJnnMfaidBBburPUsfWTlu5dj9cJDUeKRnHW_GELVyoXlyMWN_ra8iTE00xrmhVgOxX85WWqA>
X-ME-Proxy-Cause: dmFkZTF7+mBNRPCQ60dRjcuBMaeEKlO4PfjPIt6u/r/Rra/yQ9KzOhiTvfo3XMPdEbOVd6
    2gBGEu1SaE5MwSVY/gkzd3CqOAY0s8cF6w/wSl7WSDyjAPS9hCMxKyml6pEXVwFdGeoW5B
    Togxq5MvKuhZL795WKARFbVpNeB0zXuN/pvQJbjOY0xvBH3/mcZUv+GjY9cTYPVZ/sDtE7
    Aoz4cPpgSyzNw8/xl0+Ds7/BTEIVJHn0Y9f+lUZfHI5KlZyhPnPLYGFr+UuLep8wicvse3
    PjKHGm0R9ajubaZj4aVnZyLgW5DccKvjwpJ7hZeA9vocQbdH39k+y51J8U2jmZKzLDTCg4
    mK9lUGtq6l3lEd+yOi+B8f7CCQW7q1juzhtmqqfpwW8d/0o8cYClwvshWdsfb8It79rP8Y
    XK5lwZlgR8OmxKTy0Yh0SsnGZfHlrc0Gpnun7iiSXO5vyIzOoY/QslUOGQ61GB6Iwn2nTY
    rCB4BSaTm1hXESK5lY5ekPB1nIHxMjRHoMi7byhlFuXlqjphQi+Plavz3geoN5Rmmo5ozg
    fTavsgaX1ohDLBi99AywxX5kgZNmC9hlzYOMy8KxwyzTePg1w5DVzmGqciY2u3amPufFZk
    xKMmkWALwR1vr9QIRlhPuQPUgfpgIiyyJyIqARggwOIm0a5Ya2tbhFxV071A
X-ME-Proxy: <xmx:pu44aurGhZMXQH6N3QK7Z-_VFom8yKFQPEIjsCUQAJDIocPJHsFe5A>
    <xmx:pu44akBkbFoQXHaWe0Qvq_mVmU2N7ilhL0rG6pqj-CMrBhSmDzea4w>
    <xmx:pu44aowzBsyJbLiyn_22RvrKkCXP4HmhmU2LYTNu4ydn7yFHVG4QBA>
    <xmx:pu44ap2WR0kFMxBhPNEdtnp4gbv_Lon0yp61prLY6moe70bIZSY4ZA>
    <xmx:pu44anSaoSHiW1TqaLbp5ZS7CF4daYfRkBViLtDJV_C7Rm_bBk6A0TyK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:13:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bd6a63e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:13:24 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:13:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <ajjuoS5Qc3K0nCRl@pks.im>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621174934.GC2206349@coredump.intra.peff.net>

On Sun, Jun 21, 2026 at 01:49:34PM -0400, Jeff King wrote:
> On Sat, Jun 20, 2026 at 12:00:24PM -0400, D. Ben Knoble wrote:
> 
> > Autotools-style builds permit enabling USE_NSEC for cases where that's
> > desired; the equivalent knob is missing from meson-based builds.
> 
> Seems reasonable. This is not changing the defaults at all, but just
> bringing meson's options to parity with the Makefile.

I was originally wondering whether I should recommend that Meson can
auto-discover the availability of nanoseconds. But your below remarks
make me question that.

> I'm not still not sure if turning on USE_NSEC is a good idea. There's
> some discussion in Documentation/technical/racy-git.adoc:
> 
>   With `USE_NSEC`
>   compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
>   members are also compared. On Linux, this is not enabled by default
>   because in-core timestamps can have finer granularity than
>   on-disk timestamps, resulting in meaningless changes when an
>   inode is evicted from the inode cache.  See commit 8ce13b0
>   of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>   ([PATCH] Sync in core time granularity with filesystems,
>   2005-01-04). This patch is included in kernel 2.6.11 and newer, but
>   only fixes the issue for file systems with exactly 1 ns or 1 s
>   resolution. Other file systems are still broken in current Linux
>   kernels (e.g. CEPH, CIFS, NTFS, UDF), see
>   https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/
> 
> That's the most succinct description of the problem I've seen, but I
> have no idea how widely it still applies. Kernel 2.6.11 is quite old
> now, but I could believe that other filesystems (especially network
> ones) still exhibit the issue.
> 
> So I guess if we wanted to go further it would take some digging as to
> how each platform behaves, and then flipping the config.make.uname knob
> for ones where it can be argued that the behavior is always reasonable.

Yeah, it would be nice indeed to figure out whether these concerns still
apply. If they do, I would argue that it might even make sense to remove
the build option completely. It doesn't really make sense in my opinion
to have a build option that nobody uses and that is subtly broken when
enabled.

> But that's all outside the scope of your patch here.

Kind of, I guess. If we figure that this mechanism is still subtly broken
then I'd argue that it doesn't make sense to expose the option via
Meson.

Patrick
