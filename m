Received: from relay3-v.mailbaby.net (relay3-v.mailbaby.net [205.209.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19128850F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.209.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054117; cv=pass; b=ahtm7JODcFOPm+nxWjOWUQXmlMgKuwbVd6RfL5Og3GidCACGE2tU11GpKeCAo93v/D9fRVj9umbIw3Ybe1VH8NafB4IJqzZsD/2981xU/V/bS8RRvvpnkjb19wWLOEuDhecNWmSz+NtqkHc5qlhWes1NP0uJIyyqVi9buwEGz8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054117; c=relaxed/simple;
	bh=47W5dRkrCc2xCmj1TXGfAWTG940LuMfldwcBBXKbKXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbBPIQUt8bId/pFgI3iIdpLtl+89dTtHAEQ9yoyZy4O7zC7Wvl0lg92BrRw5L1JBO9xlV1PBfB02aSColb2hVtwWKKckb3xMFc3UUC2yQRLU7ac1gq9HWUt/lGy3wmKW3hDZIHFIrfzZuFWM0ytXRtvME8Z4Y8o7nB52atWh09U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=Iu78oOgG; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=lNtV31Mm; arc=pass smtp.client-ip=205.209.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="Iu78oOgG";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="lNtV31Mm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=SQvrR5ekSi5jCrttXEGHdTOvJp6MQnJxQq/AY8MiFQQ=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references:feedback-id;
 b=Iu78oOgGY/FP88xYxoxiEC155V4Nm4KLqGhv6isNb+1RdhALLmitp2++ZLqPjbyLGTMIWkU4S
 pc2uJwJEZuU8fDnuxAGpRI14m3xWaikD0q8DAz/+nSQ87OR6DMSTtEhY00cKdMRJ087OnHVxHBm
 a6V09Gj2r/pOpyqKoQ1hvmY=
Received: from nyc3000-r.dnsiaas.com ([96.47.167.18] nyc3000-r.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay3-v.mailbaby.net (MailBabyMTA) with ESMTPSA id 199cb6187370009dc1.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 09 Oct 2025 23:49:50 +0000
X-Zone-Loop: 1fdac5a438b769f37e8c453cb4442d38f3eee2a9f692
ARC-Authentication-Results: i=1;	rspamdcluster9.mailbaby.net;	auth=pass
 smtp.auth=mb6724 smtp.mailfrom=code@agatha.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1760053790; a=rsa-sha256;
	cv=none;
	b=j9zj8UCb9uJ7s9cIW1KBx4G46q9EzP4/T8f3p8x/R+rF9IqW1s/TXOI/6T84CMjHw+OpYJ
	VR0Hf0oTX8WiOJuAmeYaVQU+NFD1jMTJYe1ukp4YFxRF1s6J7rGuYFpS1ELgQY3JBQBpIj
	qkIIVRYStPNdcSAlqvISDSsR1KhcmL1Sw0yVXQczFwtWVAaaqz52a1OeDBF3Jhfv2BqGXe
	F65ovw2UdfI5v/yT0+fX625q58zAuXOwkZLalmnS2f1fvuaV4tEG2KTk0XCtdynBo2lWVP
	85FlzIlM8kfQKwnqPkvXWQ+89N0eLdyXM5TbzMwZ/CQmRW8qo++CbOCMS/jIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1760053790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SQvrR5ekSi5jCrttXEGHdTOvJp6MQnJxQq/AY8MiFQQ=;
	b=kyXL8+mYKf1tmQB82vB+Ro4jzIi1JlgnUE/bdmMs+5ESAYrQwrXxTRbAaxtpzdkBdxU5b0
	Q1dRm9b5DpgXppfRvYEL3fiTY4XrnMwPSoUbX9Nhwxvm/Pc7joFdcIf5FH+wsPeK+fggDP
	eGrj+IlKvpHfGd2LpWuAStXOHRm6o6W4Ie55VNmf/084BIXz1faUvAQyru7VQ+9+8Wh6y/
	731Z10+oT1i4RqhJXFr4a6LDC85RKkbm2D4sEkvDeHQ5HrWvt35qu/Zo9ibP72vHhiSuIR
	/ycJ56AP/VLd5bIAuqBatU1uqyXOrT0RLMG5DsyORo+9BxbCzbAbMjabarESew==
X-MB-ID: mb6724|me@agatha.dev
X-SPFOrigin: SoftFail
Feedback-ID: mb6724:199cb6187370009dc1:96.47.167.18:mbaby
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SQvrR5ekSi5jCrttXEGHdTOvJp6MQnJxQq/AY8MiFQQ=; b=lNtV31MmR6994Gzj1dvfsMYlxR
	pa3HEPs2nrAyMA7eCDXN3q4ldVl2IBfuiSnC3Yav0yvbk7lXUkiAe1QQJIePzBH/EjaMTW0x508cy
	XLM3hi9pvCHZHHdcvOBWiAA93O6vxUoWqinRXI/yE85jS3M4mvR34BDQmeNjt37IsnDfw62m9KMhG
	GwEI/nD1uxtcIygspvSUqgtLDth8e8jw4/RM6tz+dmCorWyloObM/FiTIN4noQ9d9WEFx/k96tDFB
	eCtQA4ENXVVBZlC9MxTV17p2TzzAzhV71fevJOYsllr2DYptE29eKk5q+v07EITM/C/Z7uQkzJ8dv
	h5FcS7NA==;
Received: from [23.94.14.143] (port=41616 helo=lavender.agatha.dev)
	by nyc3000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <code@agatha.dev>)
	id 1v70OO-0000000FJiz-4A5F;
	Thu, 09 Oct 2025 19:49:50 -0400
Date: Thu, 9 Oct 2025 18:49:48 -0500
From: Agatha Isabelle <code@agatha.dev>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
Message-ID: <6n5vp3vkmk6gota27baejwu2mkuqppy65efsiimvjqnhjjqecz@uud5yaetl5l2>
References: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
 <20251009215737.1196464-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009215737.1196464-1-okhuomonajayi54@gmail.com>
X-AuthUser: me@agatha.dev

Hello!

Nice patch!

One detail I would add, though, I think the correct way to submit a v2
patch is to prefix it with the `[PATCH v2]` prefix.

See:
https://git-scm.com/docs/SubmittingPatches
https://git-scm.com/docs/MyFirstContribution

On Thu, Oct 09, 2025 at 10:57:20PM +0100, Okhuomon Ajayi wrote:
> Fix const correctness warning in patch_id_neq() in patch-ids.c.
> 

Before the changes, I think there must be the `Signed-off-by:` line.

> Changes in v2:
> - Removed NEEDSWORK comment

And this part of the message, the changelog, I think it's supposed to be
in the email message but not as part of the commit log.

> ---
>  patch-ids.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/patch-ids.c b/patch-ids.c
> index a5683b462c..b6b808332f 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -41,8 +41,8 @@ static int patch_id_neq(const void *cmpfn_data,
>  			const struct hashmap_entry *entry_or_key,
>  			const void *keydata UNUSED)
>  {
> -	/* NEEDSWORK: const correctness? */
> -	struct diff_options *opt = (void *)cmpfn_data;
> +	
> +	const struct diff_options *opt = (void *)cmpfn_data;
>  	struct patch_id *a, *b;
>  
>  	a = container_of(eptr, struct patch_id, ent);
> -- 
> 2.43.0
> 

I hope it was helpful.

Best,
Ágatha Isabelle
