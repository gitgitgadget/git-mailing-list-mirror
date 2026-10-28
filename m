Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793185507;
	b=bSfhPDcWNSTUy2yyhaoPuNmghAcrtpDB2CPrUv/aL0zypKDfCHLuJtChkW4BRsQeQcpA
	 wuat1dF9h6Uu0nMjhPsqJdelA44/nq49nEEjFFaG0ybCKrt2SWD5hECIQ9wFWc9GGBKGA
	 +Uqup1WgBG6aQLV4N1MLbPsi7gWx6sgaKmIa2N4obnj4LJsRSUzMNbR0U/Ji0HZaoeiUd
	 MvGoY911K17Q4bu/rm2z8pTnuuw3XSeTtGWyDMZkH9nAXQsSdmLYQguNFpDk02PMYVaNe
	 WxRforuCz40zg8zbegB0RNQBwZAoxdUQlMR38Lw5nURceaPUChTwTSpsszNsxmu6ZGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=grB5JEQ2MoMEqIAaN8WRe9dcGNr8ZwYrmBcGhm/2LS8=;
	b=SuKtZ7vbWn9mg6UxT54P+3ygZCkx07pFFI7u1ac8qiwHZCY4b2a2yg9H6MpCAN9SZ0lE
	 0aBsKD123ru+1j95HMmq6yKvU9pLxGtGJ8yUZW6HSd5Bf9hrzeJHyfJg426FtvF3m7TdD
	 3Uv3rYGViFZh3pxB1UiNUtvlN9UhkgAlKRdfXoaGVUFmMdMKpVPoIN3aGW2G3bvOQAQoy
	 cW6+eP2ccUS9JGL/XOinrDhSBjjg4Eu5tm8xRMmAqV/zcuRL1yRDOovZsmS204jNIXlgi
	 kmn0T+x7a/5hRTkdQuE3VniOWyAnf6NiYVGlEMhJ7U0w1xPv5nup6RFH5xSHsU68/Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EfvpOFkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7C606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EfvpOFkG
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99061e2171cso288407241.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793185506; cv=none;
        d=google.com; s=arc-20260327;
        b=gHdeJCmNbrSLoM2Bo82/6mw1uwRu/j20QCJ42H4YK7/s8/i7Z0e1cqI0D13+RbZkxI
         tYnKhX71vH/X5QxH/mTv2oL2eqlChPvtz8D6tT7UyE8WW7wRUOSjPchxilda09ZKvplO
         Wg/HpzNlthyHn4mPsHAfHKT/m+TkrneGL7n1IlMIg7QPxeaD+W3y2w4WjCmLW8sGQJYf
         9XAAz0Wgx9Mm9x8dk8OUhw9ax1sd7+O8yx96lbWvmts2G5MaaugpoUN1U6gBTT6SSLmX
         J5lvNKy3phXLbnKtkM5WVCLgb4URWzyzTHq90TeWytQ3O8LlJPhebwe3jO+o4HLtZSJJ
         64RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=grB5JEQ2MoMEqIAaN8WRe9dcGNr8ZwYrmBcGhm/2LS8=;
        fh=flr9PhWn3ktCh+aGXoOYZoNSj4Slho0sPqLHaRRdc70=;
        b=YWBDui1KIJm+EiP01znHNiHl68kJ5cQNNIC15Xfnq/18Oi2Eie62X7U4H2fELyieUa
         pNcMP9Vz1AeI5zHne55zQlUHRyTsUqDEhWdI5DBTzPDCSFddcDKC02BJbw0Hoy/IcYwy
         /F8kyRmT2Lq9n07BglLCJ32Im7HYLplp9au3RS3Dm7R5jCyQc16TSJAL90XUxZfC84zJ
         sOmokunIDr/nbrUE/Y426kvsPQD8jB7aucqgzY7kzNZcmxJ4SiLKouyXtzuGs2+cGWoT
         Dw931VGqn20kV6D3fJO7sj/1FpaT9ItBcudoQCxJj/6NxfjYisq7PWB6kxRdZGRok/zl
         XYYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793185506; x=1793790306; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grB5JEQ2MoMEqIAaN8WRe9dcGNr8ZwYrmBcGhm/2LS8=;
        b=EfvpOFkGYDXk9LoHqv67KQxJdPX72looSoALboonq1dp0cnNC+hJ3x4EkjipTAi85G
         8AVw5f9N3sUoaimpi8TOKLAVLdl8HKpUCN0lvrBYBA3T/bZp3L5xRePKzUsaTjv6qI/D
         mO/+Aj0mrqqQP8mx7OQpI9q+0rCh6FzrfZe9Uw3/JNZ0OLM0Fi4Ts9SzX8xxcK/LMQ0r
         KkErpoSnAVRU4E8RbOcgsMJvBqTKXsHbjHGGIgMJPmyJB4krIOTtuXMoLXh1kn+S3kQT
         K+UXHJ/pXJPP7iwg0QN5NAUYDC7gmNF+sBd/sZh6GHXTKssjFH/gEch4H+fM79pKaBUu
         H+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793185506; x=1793790306;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grB5JEQ2MoMEqIAaN8WRe9dcGNr8ZwYrmBcGhm/2LS8=;
        b=hePd+n+pv4BkEDBL/lw50jMnozWwsNNRLUT0s2eSwhE3sGL/rL8lYCLEqnupyafpov
         n5CKGZs0eF401J/aByDpNOKrViguMJXS/0nl6Iomu1x2PlpnDb8lOdEf+1ZFCaN6Yint
         H3TEVR8UCxkJzGSsxlKX9tpALFwRArT/f/21GGnSwk3q6+KELVrRcbZlLtkdqxb4sk3g
         cWixWd2g9KDfVcSMax1ibM5MkV/9EPEOn50kL7LIqlhz6OSnSEbVPcva2hUOJCl9xfLn
         wjaU2TnAayvAa3gJBXqXK5wSAuAwx0whEO/RKZFTqWzZBH8Z5HzTBNihRld5/1ve2L8x
         c1aQ==
X-Forwarded-Encrypted: i=1; AKwUvBxl50UZar0ZSe2l7mhS0TQIrGpUzkLS0d9iPI5lvNg1gbXyqIwF0SUmyUPrM6ZnVhcr/rI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGYfC7PBbfv4Fzfdyy/8MXntzuVsZvbfUiDtRE66ExyS1JK2Z6
	MgqxFwxomGpDWRlZulS9zzE4BkPtJ8qxznbJcJVEWjRtAeI/zUopF5un95Bd3toOvog1VTG813Y
	ehhPK9eTorB5f+KPdIjzEPYgj/wXeZZQ=
X-Gm-Gg: AYBFou2yPfPTdt7uAr7nuSP8v4RK8JAJvtw1rZEELaJ9IEj2W48aHdAF0yNTGqhJKjr
	95UTXeSCsj24ikJSJMEufe6InJmHhYx7GtolfGfXqjEd3Xujsc6oAeUljNMgMAEx3vqZAErIrBE
	vHuYAaczVnwlTpUePzyvdomy+ZH2QUeOuLAjfo5A29zdXFl+kmatep7gCmc2PcePypwu2fF9eZi
	CIYkk6JpMQbw0fxKwVbReawxbAQlUCddaeGRtEFwBqDmqZ15n3Gd+aMBwfDRIGXShOY14y8iQrQ
	KJQ9IbViEm6HfSnidD1pwqIner+SL4ALdmZG0UZ9RQ33zttBfbK3+A9ldvV3hBh20UarhtInWHX
	wDSQuwcgc9MZE0m3Pb+lUjHknEtENX2eMT61gCF7s2qjRhtYMqDULMo1CAuxyF9QmFVM4/J+jsY
	KcAQCsRtLoQSLKFH8Xi9P6wlZMUQ==
X-Received: by 2002:a05:6102:2c81:b0:7c1:5862:a97c with SMTP id
 ada2fe7eead31-7d03a66d992mr714887137.37.1793185505925; Wed, 28 Oct 2026
 04:05:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 06:05:04 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 06:05:04 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
References: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 06:05:04 -0500
X-Gm-Features: AclHuK8m6wFdZlWfmoMtNIASeYB0Pnb4pSmzMd_FHOPBbD1Td09h6sZo1QdZxpo
Message-ID: <CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] bundle-uri: use the passed repository for refs
 and tracing
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: multipart/mixed; boundary="000000000000190504065ee4899c"

--000000000000190504065ee4899c
Content-Type: text/plain; charset="UTF-8"

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> unbundle_from_file() receives r and unbundles the objects into
> it, but reads and writes the refs in the_repository.
> fetch_bundle_uri() also has r, but uses the_repository for its
> trace2 region.
>

Looking at the callers of `unbundle_from_file()` I don't see there is a
reason for divergence. i.e. both `r` and `the_repository` should point
to the same repository. So this does make sense to me.

Thanks

--000000000000190504065ee4899c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fa9e251fd1785122_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yaDF0OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXZRQy80Z0dzNG5TYlNsMThVSTNmTnRTdnJVYW05MgpEUHRraGRNeGRK
YWw5ZThMSE01VVVIa25RN3VQbDEzQXNoZHVBR0ZnaXlXVkVmMUxINW9SQzIxUDVHeHVCMjFNCkJY
NkVpbzFsaW9kalJXdFkvVldmaThWNXU5d1dDSmkwV2NlK3R3Z0QxNU50Tm8wNkRlY3lnSXhQOUhQ
SUZiTFUKV3planpuUWVuSWZOdHpFQU9JTW1MckREWmVoY2tCQTZKNHI1ZFZLV1ViV3NEWmluK25i
Wmc2ZER4ZWJQb2hldgoxWCt4a2RGWUoxUnFQZ21jZTJoUlhQZzVkbVI5ekZOOFNKUXF0Z3hSbm9F
dHhxSWRPQ1VQRWdGVFJUaysvakl0CjJaeDJjOGEwQnFtZSsyQ3JUNktGSnBKOGozLzQzZVlJeDls
bC83MTJyUkFsT25IbS8zM0IrL0JPL0kyWVhRSWkKSEhVVnVOaUNRdWM0U1h1dytaMUFzNUVVR2ow
WXkzWXFBRS95dDFBekxXcERKNXM2ZWZoUE1wNGh4VEtrd2I1bQpvNFdZSXBBUU10aFBLZ3JFVFZB
RTF5NzdDTHN2WmxjdlYwMXNlVCs4aHQzK0dhZEw3eDZ2M25RMmJ0UkN0M2NQClJtVHk3ZytrUXB4
dFNLaXppc0hpbGVaL1YrdmV6dHFxa1lJWGFPWT0KPS9XRDAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000190504065ee4899c--
