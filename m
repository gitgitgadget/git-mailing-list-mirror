Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB91494D0
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151214; cv=none; b=ZGwZoYEYDlv73roZ+eg99QNNYaC0eX1xRk8WiSXGsjoN9LUe6a9VOl4x/UnW9ILW9FhVFyTHxWQbu8ULpJV7usRONCJrWsTbGLhiSmZS72RzXZnNQrGh/ciPbemd8+jB5zAzMNz6bC8CewZUj12CbQpHIR5/y0fQJBp4Z4YO/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151214; c=relaxed/simple;
	bh=53C6SbEGlTCIbj/nHjCEhPRrFNV8KW202NtyLq7gsxc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=E4cMwNLiTYJWf25i27apGnJY7CX8cV941xo+jJ7IsRf7Ukwmfmz2u24L2uH8hVW8UFxqZqAjpactmJutlsr0V5qUlsv2a5Ey1CFjmloh3hthXA64LbKLIoB1IuCrXh5rlWvRPKzHtWMdNHV1H17r31k19f3hAUntbxtfcTOsrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGJUGDWb; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGJUGDWb"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-222b6a05bb1so4489638fac.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712151212; x=1712756012; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFTa4eLMey1FEcGvyNhJnKODofUrRmRXuolc7lmOQiI=;
        b=eGJUGDWb5XlaT6Yc5Ehy+9WVzSvr6eESgjTXjkgpKKPOmXuvMaYN220shqgsOdBPD9
         eS32V3j+5+rzNLVZjXHp0fplQgliYWjben4bOAFV3YJpdgUnzqBp14DvPUoPHgYAd8tI
         /Yo2eiDYjIGcRISYYD/fFO1P4P5f0WmLgMFb1AtvfGk7GjLE7PjH5Fh4vkQP8aPAeXtP
         LZ+nZ9DW8u9W+IPOEZYCmsLX0j+art/xaAM46iQzRo+epq69a8mN7eviJoAp3WTsUy6T
         f2dsOmDv18enKtONdOvn6YMXawug+ZEE/9gAJgyodQM1TPHdAnCsmqKonv3Z/AJbuTv3
         ITFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151212; x=1712756012;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFTa4eLMey1FEcGvyNhJnKODofUrRmRXuolc7lmOQiI=;
        b=oV5hE725bGM64bMhIlBw7BjOh3oqwZTvjM4lc6cjaukr/Y3VuXqzTm+qr7gQXk2SF8
         h09KNoyPIbmGs3Ab8SrKbXHEr/XaTaH7LjSJKQlUA804nRfkXqs04JbhfBpXVVAUg0tp
         rChAp7ZGjbS202LsXdy6K/18ZtT5XD4aCw8u4hOk9XG7EQQWRSLuAID2CrWKaiizdTWv
         pPtgDvlS61Qpm1HMwxgHSp9yblZt4wUK9XSpaj8aHxFQ7zfCAjMBdD8Odx5/JhYydg6v
         BpmeUXGynuGGEoRUcIIIX/d9QY1EJI7YDeXLtmbNHWTVT1qKQN5nElmDWvXOFjVGAGy+
         WT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaz+nPjJoaLMr58BX94SmySoCWyGWFCGGlG+yBk54hO/hMuCz/cgpxMuSsiqJs7fHCIjkxA31Vuq6N11yzq4ajBfNs
X-Gm-Message-State: AOJu0YxtG6SUpsBkNwXdwnKDvhsSgmuxS0GY5/fj0UTwJs9ajC6cHSnU
	aWiTPjZutm6qm3G6XRlZnNc72avY8zv7Yg47gCiEMP797fOwAQ9dCjTbDTJlFHCGvnC49qNY/oy
	tt0KrkFNg7D8WLeERu4a0BtPtU1hO+Snu
X-Google-Smtp-Source: AGHT+IHhucxw33T/Nwsk4zN6YD1QyyujQcqr2bwfj0Jgdx5z7n59+pbQtw9DyrI89m2Ud4EVVu2APpCgn+tcCjU3S5c=
X-Received: by 2002:a05:6870:c111:b0:221:bc5b:ec51 with SMTP id
 f17-20020a056870c11100b00221bc5bec51mr2833224oad.15.1712151212299; Wed, 03
 Apr 2024 06:33:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 06:33:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Apr 2024 06:33:31 -0700
Message-ID: <CAOLa=ZRB=4TRTDR1Xb5CCDqXi9qEATBO_qZ1LvKUHsLff1_y3A@mail.gmail.com>
Subject: Re: [PATCH 0/9] reftable: optimize table and block iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cfb32e06153144f7"

--000000000000cfb32e06153144f7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
>  * The code to iterate over reftable blocks has seen some optimization
>    to reduce memory allocation and deallocation.
>
> Preceding patch series have optimized memory allocation patterns when
> iterating through ref or log records. This has led to a constant number
> of allocations when decoding and yielding those records to our callers.
> One thing that is still missing though is an optimization for the table
> and block iterators which are responsible for iterating through the
> separate blocks in the table. So while the number of allocations does
> not scale with the number of refs (directly) anymore, it still scales
> with the number of blocks.
>
> This is getting tackled by this patch series now which refactors the
> table and block iterators such that the former can reuse the latter
> without reallocations. With this change iterating through records is now
> using a truly constant number of allocations.

This patch series already looks good to me, I have nothing to add here.

--000000000000cfb32e06153144f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2bd92da11eea874_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTldxa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODFJREFDZG5xNWdwK2ZOOG5VYmRMaFluaEpPVU5LVApacWtDdnVnZmlY
cnNjRkRaTkVaZmhPcWtBUFEyeVZhYU1rRndhTFF3UisyRzhWYXJXQzIzSkJDWnJLbC81L0FjCmhI
Q3Q3RTVlNFFRYzA4dFV2QXpkckVJcWdMTVJqWWUzWTlkOER0Q3p6V1VJMHcyWFRLNERyUzdNTzhQ
MHdNVTMKeXUzV1ZsS0FPbGt5K0t4SXZDMnF1MkU4d09zdWhua0NKQ0tPeXB4TEpHOGhVeUlCNitY
UmtUQXNmandrY2xTbQpibzR4bStmR2JsNW9iOE96d1UyOTRadnJjRmVRQzJaRE1EL3J4cG5UaVd3
VmsxRWVuWVY2Zm0xa0pTY1JkRXBJCi9YcG50cUh2Vm5sNDlPeGFFVjNvY1FtbEptZkxCaTVCY2RV
M3lzRVJYL3NSYThpWXpWNlBzamd2WVVsMUcyTFAKMnQxS0dzMWE5c2pUc2xTYWNJUFlnWVdPMlFz
czhqNUZoSkJPeHJPY3VlRVEwNFNJREVNVWtIMFJsWllBZkJXdgpoanE4cUwzeW1VUTBYODZRRTJ0
cVp5enduSC9rdzNHd1VueFkxYnZReUFXM3YwZ2hYZUg0bnF0aE5pNE1PUDk2ClFwblJYVTZJQS90
MzdwUnlkRmVXR2FsWnZyTVNIb3BPajJBbEcvcz0KPWwrZDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cfb32e06153144f7--
