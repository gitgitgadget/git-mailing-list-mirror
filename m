Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35847F5F
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463008; cv=none; b=VarvE/iKYvq/w32dvNpUZwUgCaGKxJx2oB/p4h4iFVDGu6twBvgvsR/eugGylFY73zeOzhrPk2mMcDeEDo2JXex2inbma5zAYDAE+z0AKL3wnomWOkR2Ywahml/ldfqS6Ivcg/KX5F/f/jCcWjWn64J/zviY56TVT3HD3gFuP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463008; c=relaxed/simple;
	bh=+WpNdOpJz/tMhXK6Oxn4bVKXvRbyCV0SF9Pn9VHuOiY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4hmblAf+a5gqIHPjqPj2qTgb9qbYBDF+UFXVpOSGdBl87Q1xSlr6vx+TdphyNj7tYZVa56RsIsJms/704yM7zofI2X3fvIUVFvfc6EcLTyLsj6CuVzDdZXl3SyphByXW1fNiKI9nfhZXVDaKyWopz76zGRNm0Bo3jmOz9BDMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXcFXFGA; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXcFXFGA"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3cabac56b38so1773187b6e.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718463006; x=1719067806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/IlQYujPkQzFJptuhcCPqXXnJcj3PgCLi7Segvk/C0=;
        b=DXcFXFGAOxowVHuM3FOHgIcrWcv576F+wmz/N/cIWhKbmQN+7UM6ibWvDsMCtRlKqc
         hDMz2xqMW5M1GYpl5n3EdCZcnepZLqxCCx1hAJENwIbphevzBvK+DM+9+BEkCF8jBvx3
         cXha1vDeElA2gmwTFhp18zcivFQwIE2G8gblBByJI5AaMPUKHuZK9I4HnfhHppRHoCmn
         +6m7fp8jgDNUzA4wMAtoVMYMlxKFrLH8xBW6qHDen2L8qceLIy0tSbxyEG97GBPdP1zo
         ruJdINB3QTYLKuRHr3imtBLS8g7TBssfX0JY5C0k6LdjHsoHT3e5cBxxCUbq2uVoDRAT
         bqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718463006; x=1719067806;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/IlQYujPkQzFJptuhcCPqXXnJcj3PgCLi7Segvk/C0=;
        b=jCgVfDi28uipcemNCu0+Io5L69x6oGgsSsZRB18pbvVrlLwk9hnLl/ld1KkUeKaxXD
         Y3RhUTuzL264di/+vqT/8sST2Ttst8/C8eGIp84rxf/NAQDabaeZmAym0Oem73ZFM2cP
         YzQm0Wsj3w/k925lLMgAGp0Fvcm0FpAsgdWYH0i46MT85cd2djRoqlMD6HEesb4tqFf/
         RkUtcEBL03QB8MjsbCxh7FbcuWSFeLqe2DTkYTkY/MO+vsRD8WLfa5OisUKwWv5WRInC
         MClMEcT83h2nS7j4RLUPZDp7XYIFOrJDLPTEu31viZcpZnQHGcuiQ+OsOT3jKCbe1CfS
         J/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWP7sbjZ+b0yFNfAjycelKi84q9j0fR3FaeUomv1PpbxlGhntRl13EB2Ht/TwnJ5IwPAP4KO/rxpdn7DIvWFYf00ZWY
X-Gm-Message-State: AOJu0YyFVQdJfSEiGxoLweY4GzFzX1UUN0qmyQnoAaVnrBe6ujUwSJ6M
	+wPwP68scHa6710Y9j4r1J4aGJK0StyhZ8nn45h58WYAhwTdKaGmaeUQhmf9mvqMdWKIaGAK0SG
	yM2BST4tyqxBe8UJbOT9ro1/u73jjsHS/
X-Google-Smtp-Source: AGHT+IHB5XI80cfe5e64M+SIlNZu19jfRT2bT17QS0BcI8X2jMIUPHZuUrKxSdzEdmrZwKzAkrRfT4T0g9NSTbymsVk=
X-Received: by 2002:a05:6871:b28:b0:24f:f413:301e with SMTP id
 586e51a60fabf-2584297babcmr6149268fac.25.1718463006344; Sat, 15 Jun 2024
 07:50:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 10:50:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240612085349.710785-3-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-3-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 10:50:05 -0400
Message-ID: <CAOLa=ZQtAOnD8kX4d5C0WKFOjqU9tgeWtHp-aXu+rDe3gmK4yA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 2/7] refs: set up ref consistency check infrastructure
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000000da7d4061aeed9c1"

--0000000000000da7d4061aeed9c1
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> diff --git a/refs/debug.c b/refs/debug.c
> index 547d9245b9..110a264522 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -419,6 +419,13 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
>  	return res;
>  }
>
> +static int debug_fsck(struct ref_store *ref_store,
> +		      struct fsck_refs_options *o)
> +{
> +	trace_printf_key(&trace_refs, "fsck\n");
> +	return 0;
> +}
> +
>

The debug interface acts as a wrapper around the actual refs backend
being used, as such, you need to still call the underlying backend here.

[snip]

--0000000000000da7d4061aeed9c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 34b1549455792a07_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adHFob1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzhLQy85Vnl5TVpuYkJpUFo4YkhVY0pSaG1mOWdMaQpCMjMwaDRwbldk
Nnl3WXRmejc4c002cnBrL1dXdDM4TUdCak96YW5wem5ZR1ZxMnMyV2w4UzQybUs2dlllUkt4CmNK
aVlpVEZlTmJna3hiRkdra0NuYjkyS2kvblk4ZUdvMTdWUFB0RlZGV08rRCsyWEI2WHNuVHMvYVVU
d1RzNUEKajI3elAxM3RGc2dGL0Z0cnJzb1JrN0pEQWlUaE5ZZGYzdUNVY3M4bitjcTdISTluWGtE
VnY2eVZxMzlUZSt4Sgo5U3NqeGdVNXA1NU5VZTZSNHE2b3Z3NHpSOWF3bVBtdVgwK25sQWtQSEtV
SnJnK0tNdURrZzNOUW5DM0pCTm02CmlwMTloTHhiTWVLL1JKNEQvd3NjZUkwSlhpNGlxbGJjV2xo
QWQ2dUpJRi9LY0xQRmN2ZkN3MDhTNUxMTjNUMVUKR3p4Z1J2eU1hZjhpNnZaeW9hcXJMbXV2Mkh5
MHBTNTNpaEl2eHM4ZUxPU0ZzdjJGWkY5SmVqczU4RzZlbUo4YwpzTk5WVmxvaDRTaXcyTm9USUsr
MkFHajJLeUpUMmFadFdCQis1WTJUaTdBSE1qcUFsV1RCNmNqdDdSWkRsMENlClNXaWJZOHFuTU5H
dXJha2lBVk9lVU1TM3pMRjYzdUNFZGs5YlNUUT0KPXdiNGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000da7d4061aeed9c1--
