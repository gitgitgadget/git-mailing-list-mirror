Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090530;
	b=YkkHccwrdKBx8hQQ3+U8MdMHpeOvbWcZK7oQmah6xpA8ixxXiwTbOcb53epMLx6txkK9
	 Zb9ghbSsZPeWfizt2ep+9yXgREnpoUGPLfERWy3r0m2uXx+yVtGHjH1tyQzFwigycl89t
	 ZAzgoHWk9hcpzcon4nepwMGaKdbumqgyTR6VdvSZADQHIWguprMrGT0dE3BtriHQI6qVN
	 R3L7lKH4PVurDD6XzvRPfVYfB4LIoay17CSRcPcAX7Z17ThiVBe2SMIlLnhLLHI8mn7hD
	 xhjc+UcWdevBbzYdEyFS/7nhaDqzNDILOBrJmIpPS2+DVywXvhQ//8GU7gft8MmBrVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090530;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=a7ojvaQFZer3/7eOpbJRsY2Vbfr97/WPqCXcDqvkAwA=;
	b=4zEggfGfdmmnH93U+0iAACAebnpLh02VU4Jf46woyAB1ueDOmTFtRRV4dPLaSFPgJbbw
	 wzAAkzF1XQDlEq6Fq+QWkDwagaTmXOlNYdh12SOaMS038k8XDfyydVxUidIZuERdNaIaI
	 JD05Gp0xRRdsDNu3GhnO7bWc6VInOL5Do8kp0VKfse+rJ2KJmdH1CU5V3cdLlRxR2msVX
	 oOfHoMWiN/lhdqvrfRQC3VKb07JfOnTPAD3zyYDF/TAFtFavycM9vDJURnCQ62UYme6IS
	 4gua4o3wRgA6zgdqWfutfSRo43R8pGFD6RAbdyqebhHBrkH3nrRQdGDU/fEIBHL6iFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="GA/KGJB0";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+BZ6HTg;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B0606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A8B0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GA/KGJB0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+BZ6HTg
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 26602EC0936
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:15:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Nov 2026 07:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795090529; x=1795176929; bh=a7ojvaQFZe
	r3/7eOpbJRsY2Vbfr97/WPqCXcDqvkAwA=; b=GA/KGJB0P2Hd1/blaV2sRYDrwi
	+LLdjRUBNEsrOrWrnjfZ7tPgEKBAdN/TPiJhwHlEP1KUgl8EiUAUTvcCy6cbqXq+
	iBTOU+xIgKtWkbYvwUPFU3nerx1QADVe1oWPd3kVWCn7Jvwnm38Km1unMfvrdsCq
	0+rCO2OpF0acuEOR/oPwiUtAvwBSAista4FgqgVigh4znavlyCn7+au/GNY1Jb1V
	HzrcuNiObFAP8ljjIX/gzVEPk31/hVvTW+GZBkZR4noHFA3mvqRYwQ1KdBcfkAfa
	sG3CVgXuCG49sqEZVUpd9K77n6SN4gVfKwdLTTkF3JJA6sx8S10SqHrZdfag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795090529; x=1795176929; bh=a7ojvaQFZer3/7eOpbJRsY2Vbfr97/WPqCX
	cDqvkAwA=; b=n+BZ6HTgyETYsUrEs53Gmn3amk35jpgHJ248foqZvvO5wfcsGw3
	V7RxqmxlwMaaYht3eotCYRk7CYbOW308r4vSj+2AmP7svbxIq8Giz+OFqpUmoMmL
	dnN2McP0tn9ZcNs9X+AAHNWU0gMuJbnUdoTBQJ1su4sxQ74ptuTFwqqqapLrzPdi
	YWGJ4UjcGNZoSVQwJN7qYwY3eZeqine0XjcLd+b8d7RamQQCipGiMTnts058ot3E
	qAw+ZIbeoSV8dA6gCF/gKVawDia6q2ujyULJlV89EfQIis+TZYVjQ0FW9utXo0GU
	GOy2hU7OYBzQYCa+i8BqjYTEtsO2FzWgI1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795090529; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JcwqEKvD4AQosF3y6sgWNVBovYl1SzMRJv4BmMr4tfrsWy4
	4JZFTQn/jhTYztLZxYg3Pc4TobTp+sm25nE7LHa91AjUGN9KD2LFJswJmBxugvKj
	bZjtIHfE/h1lpoyTDntrDMwGr1k1QkxvRBcerv7Mw2ObJCr/Ag7wxT22C2TvDSoj
	5mxsRyIomdrvB9buSWYt+JILjbyUbIOOTbMjXTlNC3sk2KnRSIzJPVBOsApOKo7+
	Wg2yjURtqwfDX9rEoCUswrdl+4RLURuxWtv9htM3RKyzDL+0Xelyo8dBa9fD1VM3
	4AYVSycAlUqzhe7H7CRNH/0+w1nPPZZkZU2A/Fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qnhAC1kyP/wrg3aLrnsy4TSvU0rKdVI+bO0X3Xzl8lo=:CaPhxU4j+csYZs/1I8a5/8AF95HXt754+xvqnK5M2uI=;
X-ME-Sender: <xms:YOj-ahP0zGyIXYS6vMIWtTV9aiDqLrGMAoZKHDB1Wp9-I6kyq-lygQ>
    <xme:YOj-arb14qNvUGY_UBu_5qnEJiu_IOIST_CjhHFKAhH7iisVxmfFajRvVnjgRNy14
    q9NfD4fZn-J7oAi4be-DiqbtnDT5lXiGK0beWqctKjUtsMfvWOegs4>
X-ME-Received: <xmr:YOj-atoqqjwgZ3aAF4Bg_UQ1sK2XgcdETRZMdRD53lt7pSlhRs7oT6yrD5CZHaw6maN-GCs>
X-ME-Proxy-Cause: dmFkZTFZnGOdKRzMJBlowx8UXfAYey+ZiD2Ikd3gz8d5/ww6MTbrduy5AwAKH4jAjt/6Zc
    TC/LB+ym4Pe8WMcD7MFCk3UDlueSO36jQtRXvsX+1CvrPNQbW3Ytzcw43TpxtCIaE36QPk
    g1tREoqc9hMZDtf5m+WZJlBbiqyafKeEhznrOEGeTZcv4x/vLhxWOMOP3TVn5xJfqquYKH
    zkJhz6sjqk3bvva0rsjrrLkIPwc8+5JAl2r25St8vSbhfhQx88g5NikaGWiOZvyzkVIeW0
    NFxAN2kHPOTnhiVyfI6udMNHA453IocFaTqdhnv6efX5WxxApC20PlHTOz0LfjQDXQBIB+
    217Epi8qIau4sF6oSfVH7EY9pKGEhQv9UPS9QkZwoK8giV80QihnmmI0JY4FF8UjrD0Y4k
    8EMSKsbYOc5ud+xMFhP0uNM6gcECD89Tmw/1HpbFF40WyI0hknwOYXcdsK1s3rVhgzo6Cc
    /uFKYpsuPv+7bclUmp9GFdjOe8Z9jdwiWezhw7DHbEoGUsWzKlXAVYDKqTQQlFl5YVxW9/
    LXILlwRavBhO7mdzbsSKEsZ72/CDjNG6RADcO3FdcfptdfQODzAiyLkYZFSfsn09j5NgGp
    5xDTTHf/VnlxThx2zTBpyBOTmxPeHiqSxyQnh9+m8iuMmzb9FqsPvgjkFEcw
X-ME-Proxy: <xmx:YOj-anaetizuPkeBcnGZhmpTiogeWPuS8JqjojZjQeMsPP7GQH-0NA>
    <xmx:YOj-atT3SO9ZowemIaosEkkNJ_ri0VYg2Jny2nYqiZYhB9H2rzMfWw>
    <xmx:YOj-am5-u8pvJNKqr-CQ5ekRWx-XjQ4-MrXUESQC1zlq_uja8zCyGA>
    <xmx:YOj-aqyypiQraMHbO6SIMw6EkgdIP3XA5cJDqIXJIATOgNemnQ6ctQ>
    <xmx:Yej-al25SFZNl9-sAwOSPgc477qW2KAZ621Ox4T0HDXCE5LDwc1mV9HW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 07:15:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7abb943f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 12:15:26 +0000 (UTC)
Date: Thu, 19 Nov 2026 13:15:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 5/6] odb/transaction: avoid "ODB" in error messages
Message-ID: <av7oWMU84sH-Wx1c@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
 <20261119002043.2108654-6-jltobler@gmail.com>
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
In-Reply-To: <20261119002043.2108654-6-jltobler@gmail.com>

On Wed, Nov 18, 2026 at 06:20:42PM -0600, Justin Tobler wrote:
> diff --git a/odb/transaction.h b/odb/transaction.h
> index 2a40c85bc8..f6c4b523cd 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -125,7 +125,7 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
>  						enum odb_transaction_flags flags)
>  {
>  	if (odb_transaction_begin(odb, out, flags))
> -		die(_("failed to start ODB transaction"));
> +		die(_("failed to start object transaction"));
>  }
>  
>  /*
> @@ -146,9 +146,9 @@ int odb_transaction_finalize(struct odb_transaction *transaction);
>  static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
>  {
>  	if (odb_transaction_commit(transaction))
> -		die(_("failed to commit ODB transaction"));
> +		die(_("failed to commit object transaction"));
>  	if (odb_transaction_finalize(transaction))
> -		die(_("failed to finalize ODB transaction"));
> +		die(_("failed to finalize object transaction"));
>  }

Thanks for including this, the changes look obviously good to me.

Patrick
