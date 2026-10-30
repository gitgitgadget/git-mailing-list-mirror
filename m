Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353430;
	b=3YY1JvfZW2KcDMS2zdGx1YWpUM2tniOcbrY2JXQhJsGy6jTlh+AiRC05m8tZ6VzHZNlP
	 RAYk1Dpsvu/lKJ5ryXnt0/2vFQIuTwy/PAl+iUxHL31dM/mAr6NMh5kQwBM1EJYxhwufP
	 lf0PCWYyM+EWX1rc/sb8kCPbH/NjbbIqiVxHkYtgdbhjQqY0QjChJfG05qzFqBDBClQwf
	 hbNt9v92R130KrDZM4sAeA+PgDrCbnvjAGv93M3e+R+SlkC6Teb7N9yWaC1G7I9m538oP
	 snGH/MIUL6okM3YzPUDDS9RoOzEOwJMmfOxY2FHoc1Z0BRpkINsRgukVmNd4opybutQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353430;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=91YaHxdCYRkCRPhhJZeWMEOtQMOptPb3qTyBE/Ywr9g=;
	b=xwjYxrYPSBLt6RBwMEuCQUpCRrC/hqDg4c0BLiNoqTHLNRKaJHYgZ6NyeS2305Ly7QqB
	 DwLXDPq8g9SB9KUj45NMBNdGlokV1SQRf7nEzu/siesnKOsL3nbQ7NH60aCIHmf04Fpnv
	 jQDlt8vU0vAAUP2bRQxIeTg6Bp8xo+ZeDWOmrSYolJH5oudB7gCuwR25sxDpuJU4i9LZD
	 foIU3+dYPqgy12QBcefYkoPxY+wFEaFkFw7KMt7OMP2z6GyU9DND7qbZcF1GWU6hA7vgc
	 Y39PpD7cZYorMZDUlOriJI1t4w3O8dkFUYMhaWweY7PACtu3yjFS2bcDUO5RJvd9Dow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aDXOkcH1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wt0nRtZ1;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA7606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CEA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aDXOkcH1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wt0nRtZ1
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D4071D000CF
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:43:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 05:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793353429; x=1793439829; bh=91YaHxdCYR
	kCRPhhJZeWMEOtQMOptPb3qTyBE/Ywr9g=; b=aDXOkcH12SIOkw6vgshnR7IgZ5
	OT/+AL2Symn0SrjuJe+8zKpJTudlmzTF2WzJ68n8BoXXP340Z+SOet9H1JSr9SQn
	NPR5hF3tSd3qP6g4+BtPu/K2sL3+qhUQBH7eIWUZOicSKUyVogdS40HxHBgWFEL3
	lFkT4cYTRuSqa3AS9arMjmunf4oYS4MQ4/mURRPxMJbTm8P70UlDhbiGT7xkHCWX
	3+UbSRiRhDEIH8WB5WZTB5GcqIrRj7qUfzQx/d+d8qK+7mrNSvJ8GdhtHHR/N+qF
	XIqdmtrrVs6UvYzydpJh4am1lqi8G1FVkvnCRq35MPFTRAN9WcaLesmsS5mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793353429; x=1793439829; bh=91YaHxdCYRkCRPhhJZeWMEOtQMOptPb3qTy
	BE/Ywr9g=; b=wt0nRtZ1GWxQkLuMn9D2b0+ZK6+wPHHp0pdWHoVzKTkXMAs1GM9
	Tv4VySlsgmSqclwiJG7q8dIvj+Wxd5wBFXHCBYxCRVIBASDknRpEpx8qu7F7wNfr
	La01UpNvsfOc8ZOvTmKrA159bZo+Ui5mqGjllX4FSb68DLHH2Z6Gi1aKgSwtXyt+
	uIKoPcC4uWBHrjkVzaiOKU6KjZq7RcpuaJR86D3aYhf/rhWRtO/wLXrI+c4tcZc1
	CXvMwPAJYojO+CooVru5URLonFYXu4zD5lfqtayzar/ErdaTvYOQFoGN9VUZw9+H
	wwIDwYR4uua0JdCl1lK7zeGni+ferEsWlmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793353429; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XgvS+OHVyJ3en2/D++rcznpiXe70MPU5zc8JGaA1NNVL8Lj
	s1gZygvIxApLcWKbi+WPi7fazLbOp/mrmrrlQ+S8cEVhpwp73OI4qzcOsq5qTBlZ
	KRiHuZ5yngRJVLcrMfwdJ5X6sEZC2NZO0q056fshgni1FORIFZUaB6lgmy11mcCf
	YQg78skTvIE3edMSoT+twlVPV4yx7SSWevdF0kgLpQvFb05oXzQRR/2SzAwV90Va
	qhLqFUNNLtMVmp9lXvs+iw6StApqZegqlISaiWOjwcbxm1w5ps8ai0zNVP8+BGVy
	d5A9FRk/rwC8gmaqOtc1wQRjrANMSNgwl5QkiIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:el+QX4WnqZV27m+f1ah0YHS1BsGyHA77JlfaTl8RC9g=:wv8+64IXFBMiIUssMaXRYQlYFmGybyu0V2+jwlDEYFM=;
X-ME-Sender: <xms:1GbkavMn40FByI6Nvrh1Ils1pFzrSXSBpJTreWGhOJLFftTdYHQ4hg>
    <xme:1Gbkav_zM4qXbZFWLWLuiqM_EJ3nNuPcPhRxyaU3CoQ1jII0DAYNlVUV6Tr2chhFm
    hTDT-5W3_NgZK50MK0TbzAi4K2Z45YTCHaZKlBX_dWtxqBI-UQqvKI>
X-ME-Received: <xmr:1Gbkar7zssp4-Pa1Ffokdk3SQzPRnTGMopQBqjJSyCPYhOGJ0kgYkK2OipPeLt7edKSTjw>
X-ME-Proxy-Cause: dmFkZTFWCzuQVVMERzC7iDlpFmlBOQ4nmDWpdQxoCO2sPWKz+JdchPsUU5a/ECTJgfHXI6
    Wkq6AutyXHX1PknJECola/3reYGvRk+xfoYkxU/UD/XTu4HAS6hHEkGnkQondn4PZkYuHV
    hmLT1EzAdo6BtR09ma7JSElMG/U46n9/BKw8TQy56ZF/cr6b874boOi1IStBfVt2pZuq1M
    McjnJe7UKVqcsRXhI+A/y5/+ytFxl4xTOMI6dZqbodAAelpbkQ1pyhXzq9RUyBciLAOrm2
    /yrPlG5AThM8PyBsZ521OnHCQWWbGoCNNMdH7P7ch8e0ArVU1ncBicNgzZnJIcY8NlW6RE
    SAwP/5U3kHMyA3jQHDSyrr+nSQoKEXfWWdJp5OjUUwsq8oH3PPkoceghvJBmcba9Fvd9sA
    CCMXmVBb5+tFbonVCrDNdYG1/QJQOkfGTx3X4HAi3rZ6QJE+G0XDX41lFa1HkraHWkmYGo
    XzZcoPPXmoEcZVIGYq2tRgzZGG+vdEGy+851CsGvniwnYj4NCrLm7+YE8d4Y4tupO8yyfa
    vXcSNl2yKtvacTf/CJneltO8nkP0cn9gqkKJcub0PdaEpc+UjYXz6fGpevFs9wIOX2Aae5
    8bjy6TsTAn50RwnkGqROXcgeooHFRf5rq9WiDyMg1UBnRl3iBzEXEDZSM3pA
X-ME-Proxy: <xmx:1Gbkau3EMLRrFr1zm6PejTpUuQ9hZKn2oQ8l7kVmm_s7oIvBv9fc-g>
    <xmx:1WbkaqBE84NL_uGmXoiUZc-8B2hZF2AD2CTRgUVW9rs4BlFp__DkiA>
    <xmx:1Wbkao3jU19YdTsjtzeoiwQq3SFfEkI8mENJQVyCq-YqhqdMHqqOcw>
    <xmx:1WbkastDudw2fYGDMLIeeROpZaYhzXGobGQJ35EwBApHZRDLutCrpw>
    <xmx:1Wbkaqkr4lKIOVtfgh7-crcnR-E2veoCzHOeNCZ152OBfvGQIzbGEMbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 05:43:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3d00227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 09:43:47 +0000 (UTC)
Date: Fri, 30 Oct 2026 10:43:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: hide refresh_cache_entry()
Message-ID: <auRm0Ohkg3OQIbWE@pks.im>
References: <xmqq4ie58syl.fsf@gitster.g>
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
In-Reply-To: <xmqq4ie58syl.fsf@gitster.g>

On Wed, Oct 28, 2026 at 01:34:42PM -0700, Junio C Hamano wrote:
> Once upon a time, there was a merge strategy called "recursive",
> which was added in 6d297f8137 (Status update on merge-recursive in
> C, 2006-07-08).  This implementation came with its own machinery
> that creates an in-core index entry, and then refreshed the index
> entry it created by calling the refresh_cache_entry() function
> borrowed from the read-cache.c API.  refresh_cache_entry() used to
> be file-scope static, but was made public with this change.
> 
> When ad45b327c0 (merge-recursive.[ch]: thoroughly debug these,
> 2025-04-08) finally removed the entire code for the "recursive"
> merge strategy, the last external caller of refresh_cache_entry()
> went with it.
> 
> Hide the low-level implementation detail again by making it a
> file-scope static function.  The external callers would indirectly
> call it when they call make_cache_entry() or rename_index_entry_at()
> external interface, which "ort" (the successor of "recursive") does.

Seeing all these patches dropping public declarations I wonder whether
they should have been part of the same patch series :)

> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a3..94dff890a7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -129,6 +129,8 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
>  	return *pool_ptr;
>  }
>  
> +static struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
> +
>  static const char *alternate_index_output;
>  
>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)

Could we avoid this forward declaration by moving the function around?

Patrick
