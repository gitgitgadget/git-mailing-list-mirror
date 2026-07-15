Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0A2931C8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109142; cv=none; b=JXbwUSnfDqPbhtGMzBXx9qRlQ5QNML8T2xtf/9fsfd+E8AmJ3MKGRizVE8mAPM3tsyt6WdIVZ5l5kLfOdkeNivHOJA3zXQw8aFtyrCSeF8PNmCXC2XD3PTMRBV4OnMVusbW8HhSVwn0Lvv54nJXU9wqZjbqBbBx1LhnwI9Hprfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109142; c=relaxed/simple;
	bh=2m019Lssy1f5VX6e6D7Q1fRL7Z9N1GiiksX/Dsy6Ykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVVH93GE0Vi9oHj3vnNaNk8OQBoUl8IQ93WGesTC+zT7S2I+4oTNZ5tcSEYZL6TLb1E1qb4uZkXLtFWQnxmeujqTv24GP2H+ILX81mdtvQwWWJm7VYnVtckyWLvnzw1r4qpBxphVtaQw2hhUY31sMckeI0+LR7i/HQeOl8NzQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eSWe4k6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNS4qa9F; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eSWe4k6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNS4qa9F"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 630C77A0122;
	Wed, 15 Jul 2026 05:52:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784109139;
	 x=1784195539; bh=PHfXehGZvJ4xTIsgeqqgAV0QNFcSRfrpn8NPee8kZcQ=; b=
	eSWe4k6JfFL+l/AdJP4Jq+nJELv4qtw+jwRE3zUG5CaKg2F3DhiJEcz8NGZjNlnd
	Gz6L2McBuWPofze7mn8QH8fLpI39GdCC4aKhoB3HYGjlLfutvfLzHgaxSjfQNZCs
	ebq6LKVY2OuwFHXwiVLgrYQvCcm8nnVnYuCY+ufudx2YKMmjT+tPmh/9YsdIloNw
	YAknLEW/66HlcnNEXr25JtUWAa2c0PK7HKE3XuGs1DWp9jYfCqaK3eCDzrLkY/Wc
	dsmDtccyOOIFXIV+bzBadcJCrFvEYzuzgvJNWTKKUSEt6IGLRLVKuC6WdvUAyYq9
	q6L2o0Yeda3C3iAD0h7HyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784109139; x=
	1784195539; bh=PHfXehGZvJ4xTIsgeqqgAV0QNFcSRfrpn8NPee8kZcQ=; b=G
	NS4qa9FQ4eAFRw00wIdDa3KLTZjrwUwB3hH/exUIiMu80bNIFIcPoFIxkxp8fAVK
	Nei+MyZL9tdklwTsNAk3OTGchbI+y4vcKFxQWuNW7VgypwSuXPtfLkF96baGDBxy
	iWh/noN9WRmUtchaGxMCox0O4xCQ/h7e57/QMRg9jGtD15LlbGV4bqn5TT3qSsJn
	1T2vu78UWCwA6gx5lsn9v/TLXE8kfn7cg9qmgl96HOeBOpSkSZa9GaDnj6XJgcp4
	aE06CT2ico0v4a+rqOmvRQ6ahf/IoLp8Phgft8pPfIGDmrGynhth2XiUhmYBuZxj
	YG7kqgi80N8IlCswOdQRQ==
X-ME-Sender: <xms:U1hXarc5vMWA2VU3U56cqTBayVTk66kU9wYeDt4PuSlSU-UXCS-WbA>
    <xme:U1hXanOcRgxXwL80MgsQiS_VJCWyfiCu9ygm-aD-5u1dXSu48m9Ymm6tYEGY4i36I
    tx9J0z3n4SnuzzL24Ur_R9NS1LcjYU_mm8TdCxKtSnxfYXyOV8ziQ>
X-ME-Received: <xmr:U1hXaiLl7NIoMm7F8basHG62-IQn96qlFX2d-sYiGSyeaq_OPYou4TBvWtfoUhk9OlmWi5OI-ZEWLgXhG_9jkHJYRNMcNw9s42W3t4S-1kc>
X-ME-Proxy-Cause: dmFkZTF9vAEKWEm+zatVu0XwUa97Lg0upIjLbNzMu44qWREneBKkSZX/ymrL9B3r0vtjQw
    jGtjCWu0+zhpsQEtVXHVKvgznz7/okJ9wOwXphNMO8xtk9TJB3RFjUdAV02b/lAlQ1V209
    pXnZZNEgMHi1pkb1UQA6tkzVCCyKXbqdfTTGuEjSFmJjqHbSf5CWNlNPKJv+fQHmz0xFNX
    1XH3i/cqFGRkBvklBSgd77QKC8OxwfoPLMmUtZhZ+Q9r489pYggj9TTEF/3wABKSMcSYLu
    p/0X4Lsu8vE4GSGciJf51pgpT/Svj+9Vv66ed6yrqU7VosO7x3HePbXsA+/lN5kojYAqo0
    gyg5VdsG0882jZ6YAZmHb5rcWl+HE2Lm6hqWr/7iX2XfGdkv1oNvkPKrEmaLiAF4vthE60
    QRfLSCe7/HZ8bHwXXtCM9E5mjyi9suZGUm1mbnjP3K5rMundcuQqoA2b0TLkdWS+Zi4dSi
    iFLhPPlS54UA+8KLmZgwzzwpmkp4TSNVq6IrwuZL8gqhbBlI+5rOvcaCKUZHeJ2rzuXdaX
    QuUq7d8xi+5ufcUc14/jz6hRpMwZQOSjnuXA+SrrSGu/5qIX0vNQOy2TtshWTBv9jv7TKf
    weXW0KCPgm6AbA4bt7bqbrHknevRrcJESwwQgPF3nIbAve/q6ETkWf9AG6oA
X-ME-Proxy: <xmx:U1hXaoFk7IOT6-uRp2C0W_8EGM-0bjw8CvlPa_h1H3C-j_e3pbNQig>
    <xmx:U1hXaqQupfxL_ASNMpcCeqHIlwvoclO0s8G5ELTn_D8tDQp_zIuvSQ>
    <xmx:U1hXakEfBM-mec4SqWD3sckMSCys_k5ore3KVuCdxbPYPh2FWmj-4Q>
    <xmx:U1hXam9nVuJByA1msTHbeyyvDbQ_WsV-p7qfwJ7OtcKm1bDxn0OXGQ>
    <xmx:U1hXam1vG9P-2kK9pb6P05SuKk6JGvleuXn--vabf4eqduUb5eg5CGnu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:52:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8b13446 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 09:52:17 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:52:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] tempfile: add repo_create_tempfile{,_mode}()
Message-ID: <aldYTuMvN-8EMvYK@pks.im>
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-2-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714175956.54601-2-l.s.r@web.de>

On Tue, Jul 14, 2026 at 07:59:52PM +0200, René Scharfe wrote:
> Add variants of create_tempfile_mode() that handle arbitrary
> repositories.

One thing I was wondering is whether it really makes sense to pass in a
full repository. All we require it for is `adjust_shared_perm()`, and it
feels quite extreme to require a full-blown repository.

An alternative would be to let callers pass in the setting by
themselves, but that would likely lead to lots of duplicated code. So
maybe this is a good first step, and we could eventually create another
API where users can pass in the configuration instead of a repository if
we ever gain callers that don't have a repository available.

> diff --git a/tempfile.c b/tempfile.c
> index f0fdf58279..3132eb4371 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -135,6 +135,12 @@ static void deactivate_tempfile(struct tempfile *tempfile)
>  
>  /* Make sure errno contains a meaningful value on error */
>  struct tempfile *create_tempfile_mode(const char *path, int mode)
> +{
> +	return repo_create_tempfile_mode(the_repository, path, mode);
> +}

Nit: We could've easily created this as an inline function in
"tempfile.h". But I expect that we'll get mostly rid of this function in
subssubsequent patches, so it probably doesn't matter too much.

Patrick
