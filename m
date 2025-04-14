Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDC25A2D2
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617313; cv=none; b=OboN3EXWgbiptO5l2UnQrSn19tBulIPOhCR0MYKZZUKbVI4Tlow4DBZflmyfQDCdMM2rP4bm35nJwZIcD+kCK1hh7a2qFr8BQmlC/RiAWhLi/3ZB14N4g4snc8dN7p2pXohPTEhWfYhr07YryUcIzDoWB1hth9d1th4eehZr6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617313; c=relaxed/simple;
	bh=OCCzDqbL/6xfP+j89Et/ppOAjuxfwslH5cdd/zlQDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz0zlnrs6Xbr1vDhGzbkAJnJ41xVBaB6PiLPVDxmM4NLoc4CKfcANncETH4TwKzD4H8hUtljQuUOr4iv+eT+g/KMipJeo0MIBorZNYu9cpJpqSiMOjUEPKfwH8AsLVVkTcRNCPcHitm6ypvQwVuc7hm/lPGHbTTVQmREzCjYqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LseCTYNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVzdJJuw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LseCTYNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVzdJJuw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEC5B25401A2;
	Mon, 14 Apr 2025 03:55:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 14 Apr 2025 03:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617310; x=1744703710; bh=w54lMYD4wh
	LIFCiAhJrGPGBfuB0UsY972c7r8lksroQ=; b=LseCTYNT1+Ti22amlj3xtNYCgf
	5wvBAyjC58DhzNwCWjBHwZ8TPSUB9v876Gsqd89gevSknnImF3j2LGVZHePpN4ce
	LD0KBiRXoubDQEs9gPz39KveA3nRTZbY7367aXEvBOEWhEQfTvfwADtY7Qebz9Yg
	TPK3sqciQ8+HHCtBEbulpqKZ+pBFlpYcQBa15MV9LCpFyWGEyNPqFF1x53JbDy8i
	e2VNUyAycy2Vn5DmrHmlmDRRaQMGqDNUydSNlXuPR6otvvLft8cxAKbRYIr7Am8p
	YZyfXomONIhVbFFhNwYNmoo4M6Pn8tYf6/Bsfce4UMfklMGhQzah1pWukrfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617310; x=1744703710; bh=w54lMYD4whLIFCiAhJrGPGBfuB0UsY972c7
	r8lksroQ=; b=TVzdJJuwCYQqv2sfma0XaOAYcJGGblbYM8LJB4F7ZWS830nYdaz
	peXgdgRuXH2L9KFMMQ9XWlMvSMWIPDdJOLiLjAo+W3O6pmvb2h8B/NRPBYNj8YSj
	1tH19JsWwjtzX7KeJVDR6gIjPCZ3jSOcEvyIqtxNKkKHdU5/k4QJOMSi1QQMhArI
	JJ8RMMUW6DHK6r+YEIeN3/WOOjE2JUDD0EPWvTaL+mDdNriXYZvInxQSkT9jIFG3
	+1C6HijQ+dyCSvzV3cMumvihsb7ajQf1gL3a8UlctXXpc5Qngq/DYcUWsxt4YEwC
	IcGot7Rj7dF7GmDCSTubL7qiUmkVknPmFwA==
X-ME-Sender: <xms:Xr_8Z8LPch1XCbTdPfk_4PSDa9o3QpUG0F_ff9SiL3mm9gtdwzXh5g>
    <xme:Xr_8Z8LdWLs3yy8P9EAoKsEx0KOKkWp9YOMqhwxy7-S3xs55cUMi2ozK1g5-8e6oV
    j9t73vUhGNU6cr8mg>
X-ME-Received: <xmr:Xr_8Z8sPSz4IHDHxj4QAig3i7KAC5nSQPU9q-Esh8SDbG3ho3XmMDWjb1xz0ZxBRx0dyTCvsuguaUu65-vT8SFkbw3-Fh4mx-R0E_oFl0VW5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:Xr_8Z5aHLdQJeAqPcBT7FrB-OaVHhNhRo1B7CZU_EKqAPpIb80ODzQ>
    <xmx:Xr_8ZzZDv43lck7rf3xe4zlJnc0Mi4SPiMUpzA7yDxDcXxC3l6jDEA>
    <xmx:Xr_8Z1C-gHuFOupDBOqrYNJFmAeMKMTeGzGNUGCIzyjKQ0ptwSTgoA>
    <xmx:Xr_8Z5Z5KoWoEdgpnx1G00H82SsAyK5Yt9UIUj2wOjiQ-LzwJwAfPg>
    <xmx:Xr_8Z_TDESvuyVS6KIByAWrSz0YipoFCd8U363n9mX5S5d9yZsisN431>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:55:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ef913a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:55:09 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:55:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 10/13] builtin/gc.c: correct RAM calculation when
 using sysinfo
Message-ID: <Z_y_XL2C_Za5SB5m@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <a2eb9ab117c9a7ea8723c166739b30243388ea77.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2eb9ab117c9a7ea8723c166739b30243388ea77.1743859985.git.ramsay@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:38:36PM +0100, Ramsay Jones wrote:
> The man page for sysinfo(2) on Linux states that (from v2.3.48) the
> sizes of the memory and swap fields, of the returned structure, are
> given as multiples of 'mem_unit' bytes. In earlier versions (prior to
> v2.3.23 on i386 in particular), the 'mem_unit' field was not part of
> the structure, and all sizes were measured in bytes. The man page does
> not discuss the motivation for this change, but it is possible that the
> change was intended for the, relatively rare, 32-bit platform with more
> than 4GB of memory.
> 
> The total_ram() function makes the assumption that the 'totalram' field
> of the 'struct sysinfo' is measured in bytes, or alternatively that the
> 'mem_unit' field is always equal to one. Having writen a program to call
> the sysinfo() function and print the structure fields, it seems that, on
> Linux x84_64 and i686 anyway, the 'mem_unit' field is indeed set to one
> (note that the 32-bit system had only 2GB ram). However, cygwin also has
> an sysinfo() implementation, which gives the following values:
> 
>   $ ./sysinfo
>   uptime:      21381
>   loads:       0, 0, 0
>   total ram:   2074637
>   free ram:    843237
>   shared ram:  0
>   buffer ram:  0
>   total swap:  327680
>   free swap:   306932
>   procs:       15
>   total high:  0
>   free high:   0
>   mem_unit:    4096
> 
>   total ram: 8497713152
>   $
> 
> [This laptop has 8GB ram, so a little bit seems to be missing. ;) ]

Interesting. I can confirm that `mem_unit` is 1 on my system, so this
does not make a difference here. But my tests on Cygwin show the same
behaviour as on your system, so the patch looks reasonable to me.

> Modify the total_ram() function to allow for the possibility that the
> memory size is not specified in bytes (ie 'mem_unit' is greater than
> one).
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/gc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 99431fd467..cdcf1dc6e7 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -373,8 +373,13 @@ static uint64_t total_ram(void)
>  #if defined(HAVE_SYSINFO)
>  	struct sysinfo si;
>  
> -	if (!sysinfo(&si))
> -		return si.totalram;
> +	if (!sysinfo(&si)) {
> +		uint64_t total = si.totalram;
> +
> +		if (si.mem_unit > 1)
> +			total *= (uint64_t)si.mem_unit;
> +		return total;
> +	}

I expect that all systems have a proper value for `si.mem_unit` set so
that we could unconditionally multiplicate the fields with one another.
But it doesn't hurt either, so I don't mind the guarding clause.

Patrick
