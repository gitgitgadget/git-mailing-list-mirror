Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393840;
	b=T8T+5ONWiZExWa5AO0ZRPwZ8HcGTlqrfQXFhsK4ScyiIv9Hyl7pwOJ1pkg0snaBWlTqS
	 T0roAQuysQUDya31OmI+okTDNRRxXjXyMHsDWWiyOTS0ISoOtY3fQnWyGxrdEL1qIpLpO
	 Loa+NG7Kxox3A8VEYTdgu7kdMCXv8LjSzenNhGCSCF6f2zoFuVWiBnAjNlTxEygKWJN9U
	 Re3VOXJFIkk2g0jy+6iv0qLJtooWVU6jHmia1VLNxLuTolS6dEkwqXcqEmxNcSwleQDMC
	 5jaJdLUKBsuVqrG/zWcYBl0bd4cn6RSJGkrECWov1F7JjK3vJ27F/qdKWnr9TNetZNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393840;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=QAAZ3SJx7adu4DGPw7/twXTw0Sv/PB+mIH2rUHAUl+8=;
	b=MqXlJU2HDiG2Y1zeByL6SNmCxePGY31m+jYJ0ljj7XO3D39dh69/HwaU2W1RjxetAv28
	 TUwrzB5+N7Q7pzmuaXpvJUfgqSJx28NAqax4XgcB9rChOUyPdP5wr35PA6PwDSFz2a3GS
	 BsLaN3rPNtS0gd+zbTvXYEss89POG1IULgzANaZg1jzmXr5CqfrgMokpNnBCYEAM+ZNPQ
	 D7kMBLvXESvTkYEeRePsnONsmVUX+juOhd5+i852pT4cJpVMdxYunxKdFBOdG79yM3ZTp
	 59mAiL1gBdGSQhp1MMYBDH4uw+5J0xczqkuGHf+vN/rXGs8baxuiTDWrLdCLUo+Ih1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xfYHURQG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nw6M1jK3;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA30606A338
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA30606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xfYHURQG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nw6M1jK3
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C136EC07EF
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:43:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 05:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794393838;
	 x=1794480238; bh=QAAZ3SJx7adu4DGPw7/twXTw0Sv/PB+mIH2rUHAUl+8=; b=
	xfYHURQG+XxmFvon7dfquJtyWC7dmI8dYQZonpFrrfUQxzUJdYQ0UQjfvEH7V70j
	iPnxsKwlY1T3/Ne7pgMLz9w+MeKmbyCYlL8Q73AJBX+KBx4/1Hin/+GWICIDC0xb
	nEkpkev36jLIZIYNQ/RneB/Spe+DsMCBOeb6158UNeHqh03wFs/zVM/4SkAMEIWx
	tNrxGoW70W9ctnBBkU9p1mIQPcQ4e08kdJOYyvYGRhC/+P+u8YQWD1heVjMX2hG6
	oIXihYZQ0FNs+1ylWvQaI3B/oAzA0PqhkBglCribY6OCXfNDUdjqZWgvEXHe/wP8
	0PyNHMsNHGGRx3GT2RKEPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794393838; x=
	1794480238; bh=QAAZ3SJx7adu4DGPw7/twXTw0Sv/PB+mIH2rUHAUl+8=; b=N
	w6M1jK38vVw2xHA+SRKZmEskXCegvDQgwGYq6ty82CMf7BWyl5XgYrQOOq74yRWg
	ui7cCCPEBSdzzJ8nKTSoLptMoq8dCfuhkYTF1lY9FDGEeqEyVRHNfkqGW7QC2gqi
	rm7fn9SqvIQQ9NWn/zRnwmt00cXVM7I7vYL8adQB5RRu8MQEOkadDwT0j+jmUYQM
	j7B9Oz/Ly2RMt8RRJaB2sQZHD/qqSfXTSV+zQ36sem0tFM/+IKf8d0lmmEHH+0/e
	JzYDu1V8E6I8AWpeB9RSlWvCW2DFeXL+UA6UJGSiVfMYX/KvJi7DHW3GlFeXFoIf
	mq+uViIzEPL87FSpD6YkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794393838; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BUeTnNHxQLGRcGTjK4P8PSKoFwyVBKWnzkyiw7mf9F+uClB
	ACVMLs4iFoy+PzPLtAHOWk+JPJAEJQSPyaK0o7jztW2t/1tcO8ymJk2VG9baNhzc
	58ti3jHmtJJn3odWzFmngSSLA9h8eA+QVRoQXkssA2PQgmb7g22LQDPydAQ5dfpr
	xDVIRJiq2huTUO6ctpaSmhDza+pTgc7IkYIyHiJvK7L3KWuuqRLvQt7H0XyILOSv
	EUIETbJ/As+maUmZcFzhYm3JAoc6m4mzHmQq6ghutpVCJmFEe4O4rMb5bO142bwY
	DLxcPfbRYo/Z8DUDqLDb9V7g+dUCv9s+YhCybGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YrEvav5wY6PXAPDTfNhmPiRZTR9lfpzOXUoiV9vNRxA=:J0mk2knQTYNREmhy/Qg2bW5Iuye77TjBo6YA2k+/aHY=;
X-ME-Sender: <xms:7Ub0aoxsG7n0WE4fcf1jT9ZE_5gwewQht9RkmXMorYe-JLvxs2K8EA>
    <xme:7Ub0ajLmbwi3yXBt26DNvPu7Kw7hYoPwd3P6JKb4feNahzhBFJ3GdAF_ZyWU5qKzR
    JN97DlWZNxdleoL1s5qorwXpxey4O-cZNUQQYYqO9Ly5WrGEKBURQY>
X-ME-Received: <xmr:7Ub0aiqCoFWx-0xnAwf9s0JrfJhQ0NAaWPoUgIxy0GY8hM-v5eOpcHEzcAfjJKW2JKKPDg>
X-ME-Proxy-Cause: dmFkZTGYVjl4N0v499DQ9dpOxup5NAfIOt9obbnz13NMQEGJ+cyoQDSbwc+BE7826X8PXV
    k2T6D20pCy/BzoLh706uvVMFE9WAVwX43w2eMok5mLSQ6bfJq0WbYU2qfYQK6CfIGX0uer
    gqdpccMrojVWzOyGWOaZkE/PptElmVk3rd1YUrpF3lvM3f95TEesEHt/vUMCDNq8TqqBhy
    BtztKAiSB1C/FWPG4w9Bw7D3u915sxsWIHrJN73aHLpZZOlXzZ7IaL8c39PD0hnPFYM9yu
    ikk+wRf9J5dQ+fwfw5Ud7Yi1PREtGvc4f1dL7r3XCmAAJJ8K+ns8TvlmEP8xKXvy6myTW0
    TGTOZg+kDkwNpxie5pK8Y0drVRA3kU1j2J6AlnWQHJFeq9/PiyGhBw1agWzdBl2jl4sfE3
    85j4iawncO5qBawP9Q3AVOBsl3C094sjh4VOuMU4KgLdFtPm/k40KUqQ7IBszNpj3XgZIS
    0juQJzjHnRch9WL0XkNJnUSh8fy/2VXEwPMm5pJnyOs9hnzH4UBn+Yx0TtMa+S63MhHqU3
    eWuvqaGuh/8mkYM79Mz6EgwAC5NF3bGE7LlDxrmgIVJISS2QUoav9SjYg/s5k4HFMIN5Gb
    xb5D5VopX0p9c1ioP69zYN9kSRX4r8E5nmyMjBE2zUROLHP77Ib6D7Iq9DUA
X-ME-Proxy: <xmx:7Ub0aiJSopqG80rbKG2eR8_AdjAe4vk55P431YVbRl6ax5R3qSBa7w>
    <xmx:7Ub0anRBVRUXR5hVR-gDkP-SLxCck3qBmXzBZpd8Db1bxPdpX6Zd6g>
    <xmx:7Ub0ahtwB6E02pU3gyTCbQy_xTwx7kepr0Z0wsCKiNBjsrB_Sg9Nvg>
    <xmx:7Ub0aoZFAFgiIXHcE-mVSCnGqZiDu2Wn-nBDg_yi7J0JLLRh6VK_fA>
    <xmx:7kb0aqhV_OsOZnXTna-9xYHT5P3o1wEhLBkJAKVMH1BIJP_wIE0UXuAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:43:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78e52fa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:43:53 +0000 (UTC)
Date: Wed, 11 Nov 2026 11:43:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Miklos Vajna <vmiklos@collabora.com>, gitster@pobox.com,
	szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <avRG5r8DPrS23Nmk@pks.im>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <cover.1794078554.git.vmiklos@collabora.com>
 <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>
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
In-Reply-To: <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>

On Tue, Nov 10, 2026 at 06:40:00PM -0600, Justin Tobler wrote:
> On 26/11/09 09:03AM, Miklos Vajna wrote:
> > Hi Patrick,
> > 
> > Thanks for the reviews of v4. Changes in v5:
> > 
> > - The fix of the old 6/6 is now squashed into the speedup patch (5/5),
> >  so no commit in the series loses history, and its test is moved to
> >  1/5. While at it, I simplified 5/5: instead of two passes of diffs
> >  against the parents, it first finds a parent where the path is
> >  unchanged, and then only diffs against the other parents if they
> >  still need renames to be followed. Because of the squash, the
> >  range-diff pairs the new 5/5 with the old 6/6.
> > 
> > - 5/5 now also follows renames when a parent has no merge base with
> >  the parent where the path is unchanged, e.g. a subtree merge of
> >  unrelated histories. Added a test for this to 1/5.
> > 
> > - 5/5 now also follows copies, not only renames, when the merge dropped
> >  the edit of the copy source. Added your test for this to 1/5. With
> >  this, the linux.git case takes about 42s, instead of 37s.
> 
> I'm a bit late to the party, but I decided to run some benchmarks
> against linux.git to showcase performance with 304812ed33de (log:
> improve --follow following renames for non-linear history, 2026-06-22)
> reverted, at the regression, and with v5 of this series applied:
> 
>   Benchmark 1: git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33 reverted)
>     Time (mean ± σ):     23.493 s ±  0.645 s    [User: 23.001 s, System: 0.389 s]
>     Range (min … max):   22.748 s … 23.883 s    3 runs
> 
>   Benchmark 2: git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33)
>     Time (mean ± σ):     335.883 s ±  4.866 s    [User: 333.773 s, System: 0.577 s]
>     Range (min … max):   332.296 s … 341.422 s    3 runs
> 
>   Benchmark 3: git log --stat --follow -- include/linux/rsc_table.h (rev = v5)
>     Time (mean ± σ):     38.688 s ±  0.379 s    [User: 38.081 s, System: 0.415 s]
>     Range (min … max):   38.250 s … 38.923 s    3 runs
> 
>   Summary
>     git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33 reverted) ran
>      14.30 ± 0.44 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33)
>       1.65 ± 0.05 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = v5)
> 
> While the fix in this series does improve the state of things, it is
> still overall a significant performance regression that I expect will
> result in increased file history timeouts on the server-side for some
> repositories we host at GitLab. Rename following for a file's history
> even prior to this regression can be expensive for large repositories.
> 
> While the original patch and this series do improve correctness of
> following a file through history, I wonder if the increased cost is
> ultimately worth it in most scenarios. Maybe this could be something
> opt-in with another flag instead of toggled on my default?

Yeah, by now I'm also leaning into this direction. The performance cost
is definitely way too high for us, so we need a way to disable this new
feature altogether at GitLab.

> With this in mind, maybe it would be worth it to revert 304812ed33de
> (log: improve --follow following renames for non-linear history,
> 2026-06-22) and restart with a fresh series. IMO, it might make the
> changes here a bit easier to validate also.

I don't have a strong sense on whether or not we should revert the whole
series. I find the patches quite hard to review, but that may not be
because we're fixing things incrementally and rather be because I myself
am not familiar with this subsystem.

But in case we decide to not revert I'd like to see a toggle to disable
this feature as a first step. As mentioned, this change has caused a
rather big regression for GitLab, so we'd ideally have a way to disable
this feature soon so that we can mitigate it.

I don't want to make you (Miklos) responsible for delivering that of
course, I just want us to align on a fast path forward. In case we don't
revert we can help out and contribute such a default-disabled toggle.
And if so, that would also give us more time to fix the issue properly.

Thanks!

Patrick
