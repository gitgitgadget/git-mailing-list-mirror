Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125997;
	b=TY/FchCbODziKgSrIozWww27SwX4w2jm6XZoM2pj15TlkpZOg5gCAQ6drizY9o1f3Q7H
	 afx8pjKCi/UYMggFxJmD5Z/9HALAtoG010YwKE/TfOY8rHRKhCx2jPf/M7yiedVQVMGjc
	 bloqrF9fjICWFU4FCRszIftJC7PiuQPZFLfK6gSUc/b8exb//Va1+VXCYP89R/TZF0/wN
	 5W/Yl8Ask3/kyxSwIS96DGieClxaOxjDJ//wdwcTgvsSPHhdHjl0CHPYyTQK7oW3saLxH
	 9YN1R7A5x9N1iXmQH4DqgBZiqvJQVFZI7opkwwQuNcrxaIC0tMBFoRYMA2pTRe51oSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125997;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1Q7z+D0U995Gcql7WpEejmWMdzZoNmr9+s19REd1UiQ=;
	b=EaxYTELRyDL/u2Han8jripPtTSA1OXOKabGc4jO375bGQ4GOkttNIBiglU6+7DSpY1rr
	 SQ2HzALe+2wNhRDsOvxzXb/6LhOWtPX0nivi+zbpVest7QPE71p1QQTyBSE7Y1A20as6M
	 TL8sXEYvoQz2K54+ryvLkq+JqK5amrMNHamhGZ+68SCQWI0t1IpRqFZ7+193YTijUNqka
	 noDsKoR3z7/qNhYim72cznHb/7HPeNWzPxQBtLCn9BU6gAX86K3DogrBwIAYQHfg/M/8x
	 91gng2PnjnH8XzybWaaF0Ct/rEpCgX7HzY/nOQTttZppYp9d98nIBbj3OebQ/+oHnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=T5KFnbaF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GTAIOJE2;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C2606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7C2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=T5KFnbaF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GTAIOJE2
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04E4C7A029C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:06:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 19 Nov 2026 17:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795125995; x=1795212395; bh=1Q7z+D0U99
	5Gcql7WpEejmWMdzZoNmr9+s19REd1UiQ=; b=T5KFnbaFGhkxx1kwKIgVLj4La+
	tQQvmLdUccjdJtPaj29ur7FwGzdq2ol4KTC2se34s/kVsxx6SCPhHAPZklfpjhfk
	BrcvqFBMIBA8R5gOWstkkriFMDhToI0xEUgPjQjT2g5FXJK+YhZ4nwZ1leFxU0vd
	09HNzaY8fCW8WgJRjL4UqWnL6Ap0Y2DXAVY+ZXIKpenvax36damjHUdwRtSKser1
	qIMS0W46Dk9druKuxwBcIknrtBakzKZlgVSdnCBRFtMKvEoeslNCWK8GBHmhZAji
	gdXdYZAALShtJTtbvU2bULuL2i53zNMQiSLrWisD9Eelfs0Is+fGX4hmotLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795125995; x=1795212395; bh=1Q7z+D0U995Gcql7WpEejmWMdzZoNmr9+s1
	9REd1UiQ=; b=GTAIOJE25to8X2Zi0JgYZZ/iOTJMOcuLBc9y+q+sdOSGVuApgbu
	vh1UcdND8dL5v8U1oQHRat0z5fdAiMAsruNBB1/M9IZelGl4tHgjNhJv+qGs+Pju
	c6iriU8ivhipQTNSIKU+JPvn9kijWSJ00ZacxalpjdY1Jkj0uYnWqsHZMhEn4EzE
	jMkjLpM9oubzZos2mpmc/Z59ddtMWMMYEZBrW+ty2CrbAr6Va/qMtZRx3bTws2Da
	hRug7Z0TAjwAWq3xvHhJXaM7p/VDfp4hO056WMzVStig8Zsj+YUgBdmBsEG4buOV
	kuE/8JLT3pF2Uv4n103KpIkzg7u2Tm/MLGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795125995; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lFyCb6SVblv8FsejcJ7MQeaj+ALpLHuifYhQmFwC1tW1fPD
	qxr/01aAhWy4n5gmbBuohWovZYvu8wLo/zyeUpFYTsLjMdS1oWSnfgPVCBh5Xzx9
	qniAxV4vwVLlVuwvWax5L9yVrQQsm+755urNXWdnJiuaRYaU9eQfJ90yDpTICShO
	ekJMIXbTXKawCQ1DotJh+ktn0xLvRIusTXZVjCvW3phfTCou7qQ+7QND+C8ntgHT
	acwJK7uZ1HhwN8pwE/L6CQySnMPSZ31wemqjatyQ63KasIFsu2Zx5xe5J6bYFJLe
	OVqCIDKue5nXewhII8UgsSvLYq8wF/L/uRLXcIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:soJkPRT0PcxtmcIRFGiRChJHxqXJx3gVm3HXVnEhVu8=:9uho60T5/pZ1fTkMjDM6v9Rqlqp/P+pFBmt3pr+y9Gc=;
X-ME-Sender: <xms:63L_avAfmKdreq_SjGgtZ6DwaB743tcRQ3psYLhKc0Nx47qo4fW5-g>
    <xme:63L_asYf5LRPdIwbOEKW0BORnMGy2VGmoFlR740oxRAVlGOd0rFVSZTC3ufGsAjii
    dldh5aEY36aw5PKxlvp128xJ6T7U5A4h-HNpk3XPwOjxtZzmOphsOk>
X-ME-Received: <xmr:63L_ai7-R5vV4AFAN7jA6whYc2ygZUHdnH_Y5xiTzbtd7y4989_gBYah9KoXuco-TIV9XDEUaUnRvEgtQG70DqtvvB6Bzf7e3nOv>
X-ME-Proxy-Cause: dmFkZTFWr0CAv8ukCgYASajltiwTJDPF5laAyf9PKCuZJAA6YlNtqxouh+Nx83eoWCRmlg
    6fOdECShwqZ/cWUQYYQDzCQnEz5WGoPCzxq+bUpDyiJs+R9PcnTUiFo1c6DsQFSmDTlenx
    ngzJZYAiwXqgZ5yUD72RAkkcrdlRTb/Pjo+V4k7l3iKA2P/xDVCIbeEAhmRe4N0Sng6hbH
    C3i6wDuEUpA0VK2r6H17Dj7/VlR1oU9mUJWP7RZMIzDHNiJbxdIhCmpZR5xpbJm3FDX5CQ
    3CrW2dNlEd45j+r6oIGUraqTfm9294V+LpvFjwiq8+RH94msAwJ1f28XY7PpPTMokp2XnB
    x6qGD40D/c/1l4O+5wiIs07vOuy5eTUZ6NQdNn3S7ArWZ7IoRkMd+5m+4w+eeBINrFuWJl
    NNJRgBQKyJOEevAfaGNU9K0aBJWAKrZuqxfHQE63/u6h/27PYU+mvzhn0zcOopImlFzw8w
    H/HiqIazA3vKWTxv5HjyYZPZpAcalkwaGl1Wnw94tQeEK6RnfFWMgmIqJSgGn+xao2yDFv
    BKdfhjMvd3NWDCWI8R7mBWGhVvu0hpRs1/PP9kBC3bl/w0kQGtHbfwpOwUl+1P/WVZe6ol
    jl0ItbiTpUifCbY0fvVnGuk1ICGE0u2irb+Ap26IoMs046ljjo/bMS/CedlA
X-ME-Proxy: <xmx:63L_ata3DYjmGsVMSlrX_EAyocLi4NF4Gxf3z2sxtdH48wqfuQImXw>
    <xmx:63L_ahhHX4MmKGBaKq4HJqBR-nsmWE211ADEiSw_rIWDCj4in7NcMA>
    <xmx:63L_au8ujefDKqPt4srehSVYTebgCsPWuzcDNvECT10TAv2viuhX7w>
    <xmx:63L_asr91EsF1aSzB7hSMRyJOhMvRn95i6QBBXXZRmTR2hMSRQt-7w>
    <xmx:63L_ajwL-viAoU8VeljUP62aRt_AGLvbgRUJDefFifH1tay22ZTC7ZcH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 17:06:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Josip Sokcevic <sokcevic@google.com>,  Maik
 Riechert <letmaik@outlook.com>
Subject: Re: [PATCH v2] diff-lib: skip leading path check for
 fsmonitor-valid entries
In-Reply-To: <pull.2318.v2.git.1795067037014.gitgitgadget@gmail.com> (Maik
	Riechert via GitGitGadget's message of "Thu, 19 Nov 2026 05:43:56
	+0000")
References: <pull.2318.git.1795026168007.gitgitgadget@gmail.com>
	<pull.2318.v2.git.1795067037014.gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 14:06:33 -0800
Message-ID: <xmqqv75sv5li.fsf@gitster.g>
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

"Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Maik Riechert <letmaik@outlook.com>
>
> Since 4f3d6d0261 (fsmonitor: skip lstat deletion check during git
> diff-index, 2021-03-17), check_removed() does not lstat() entries
> that fsmonitor says are unchanged. But it still calls
> has_symlink_leading_path() for them, which lstat()s the directories
> leading up to each path.
>
> That check is there to notice a leading directory that was replaced
> by a symlink. fsmonitor would have reported such a change, and
> refresh_fsmonitor() would have cleared CE_FSMONITOR_VALID for every
> entry below it, so we would not get here. preload_index() already
> trusts the flag this way and skips these entries altogether.
>
> The S_ISDIR() check that follows cannot trigger either: the mode
> comes from the index, and gitlinks are never marked valid.

This is slightly misleading.  S_IFGITLINK is given S_IFDIR | 0755
by st_mode_from_ce() that is called by fake_lstat(), so S_ISDIR()
check *does* trigger.  We have an extra S_ISGITLINK() guard in
there, preventing us from calling repo_resolve_gitlink_ref().

It does not change the conclusion, though.

> So return as soon as fake_lstat() has filled in the stat data.
>
> The first new test checks the shortcut itself by replacing a parent
> directory with a symlink without telling fsmonitor. The other two make
> sure we still notice when fsmonitor does report that directory, with
> and without a trailing slash, since nothing else checks for it now.
>
> On Linux, with 100,000 files (ten per directory), a hook that
> reports nothing and a warm cache, "git diff HEAD" goes from 57ms to
> 26ms.
>
> Signed-off-by: Maik Riechert <letmaik@outlook.com>
> ---

Will queue.  Thanks.
