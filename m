Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B147143E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143375; cv=pass; b=VXZEQgMX6hqNudW+8eZzaKGBhVMqPKCXyWDXOssun4aaHX3NGrngb/mtF0ALPfmlDQIApQbx8rrdnmeiH3V7cMV9Ry2ZBRZ8VGtNZCelLQF5LAL6d9mbrSuQq67GSRJKGwwEAtZcrHFQyURzIwD6IP3ZvpiNtWL97I2k758mA9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143375; c=relaxed/simple;
	bh=kUGqu9B1xgff94j4eEpVPAu0aKz61tpMZfDqOYBtSRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw044E+dePRpwgCYf10Jq/oUBiw/frbYT7akf3skI14H1AXRDT/qEM9WG1X+zjUEJAYmYPUnxiRsaijJGlwaO4rKjLVevyLRUNI06wEzAocMKFc7flsiyoWN1CWtGcfhRwI53aeA0kH3yKo3Bxj6ACIRDvoQQ9vTcIEAJhLPvvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTzlpqcW; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTzlpqcW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso235659266b.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792143371; cv=none;
        d=google.com; s=arc-20260327;
        b=avjLq+kxk+8f3+ABCaVKwWWNqoRELc1htRzYFkEsRRvbtoKJ8zj23xTWGBGsCwnKkV
         gm91Rojj4rk4xVaYnG71aSnj5mUgFZCts4ZcsaW/x+eTblGOkgRgA/mgeVLha1CdrHoK
         APLY4ckPHoBzfeq7CNZJ9fEW425hskQzSjl0cI4ISAYdVrG/RuAM/jGolUs1cVLNy8JO
         bpSKjnEwURFFx6lvVx/s2xibtsCVrObwfIi0yYOwBnyAjOKhgheB0i7ealtR+ywCHWkQ
         1PjZRddVZczYpFU2DJPjzx2u/DQ+yYDcsudPQZuj3EZX2GU0MWnAd9U2FGGCOkEhCoF8
         lIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kUGqu9B1xgff94j4eEpVPAu0aKz61tpMZfDqOYBtSRE=;
        fh=3b/OEPrID1DxlN+Vzz3gQmASWQAUikgd39XXzrJncmk=;
        b=eE95o869n9OKm3nXeJm/b+M6cymglLKlVNGbtZhCAVDOJ7Ge8+49hFu8H05tzNm8JN
         4V6KwHr3s7iSNqww3dFmNT1I+wCDevYtD9Zw7JF+gcelwr5R3TgE4ELE6vDp45KZfXar
         e3ot8q3u4tlD4JhnoNTxhpulHr/y55EM/VYhkoGn9/Fr0Mfmdyces1Ixf3SdhxgObHkN
         sEBbxrymvSI2Fe1fUQLnBFlw/aP5IFSsFR1my5hwqNswrc/FwBGOtPlUx5qNBb7K+nvq
         vI1o28wqmQe8qK52fKUT6F9MRfUi14E8QEIbXwBHCLtYCZ6Sp2Z4ViB9JKIJZYbgMkdD
         cCYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143371; x=1792748171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kUGqu9B1xgff94j4eEpVPAu0aKz61tpMZfDqOYBtSRE=;
        b=PTzlpqcWIhFvq/ogYIpNn0vD6q4lbozIMxNQmVhZDcNZobjDyTDa2AnrEl/M74+C/T
         0IQDXnGwTXOyyvzKAgMwYSeuipbhGratO3JugPSFJwhG8OzQTB39UWl21G1KkT28Ri9S
         Ow9owzPE4riS+B3P79q436eYjzBpD9sFDakxuxAWWNSJFBwWQmV0Boa45HgNjMxwN/Vq
         agoj7guIHa+SYyvCpBs18nPffSH3pd3bnul6ihbZ7M+dskgBpMY2PQvs0gwmS8/e3CKj
         Ixo4o1y53wVD+zwMD3G+xS8iambeq7sxjmQBvqFLX0FRLbI5N7YUkP7/sMjcc+0piC5j
         1J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143371; x=1792748171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUGqu9B1xgff94j4eEpVPAu0aKz61tpMZfDqOYBtSRE=;
        b=Gil9KliYlim+WT2/yIrf9mjHZ+P3yhp3OPHjAb6mbbyyRIkiElLhQ5Uf4whpxIvdO/
         TQRnYxABeoI0CxfPseCnXVkms/it9KdtoVZlEHr2S20C/0/kj4jS7mNDBedtSE2XSaIJ
         7+jsNvZEXyaliDCLH1L/CcpG1ZCVJHecMXtDsPpSZ2kRKl/Urw9Kj7s2TeAu0dRqxK/m
         oMwuQymGk+HEyGgIn/YEM7vBALMmiq8LaZ85hVMn3axnktXEXj/qgbweiBz64witoul2
         406pfaCNt/5KjCxuJAXT4f1gGIs5rmI6YPRn0YvNGqE8OyGEH4W9Z8UastK3XyUPMb7b
         cPdw==
X-Forwarded-Encrypted: i=1; AKwUvByhkwHa+0FCoToYkHm5lKguHwhUfXjhbxASQlirngKZw6CXrJEnMbIfIH1jQpURCr0U6w0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUU1/xxbv5SNWe1Q1hgRNBL7JDeua9RaGma7t89OCc2Ird2RdT
	cPG0mUOr0hhdtVGrt3AGt70Ie5tskGWqrMVekOuxjuVDFVuyYFWDekFoZzfOci/D+P8Sg4VnUxV
	Dgb//aNmlJz9u4m7c7cwP+WiC9j5+pi4=
X-Gm-Gg: AYBFou0QqYZSzpPlfmZPdAVC9CHCW4k98lTzuYMz4pT+EYEC+yH6BKkBPp2I02HqSFe
	4W1yEU7wE0oOpLOYqRE56OenCw0H3IlZYYZ4zsYwJJ1UeB7P3mUnEODVDnJJXkKsmADbpo4v7VK
	2mQtdrzlGCSdbQUoDkDwkN78AfLeHCzo3dXDSwX4OgomZwTv8lVGrlBzuD/qIyKY37NQsLxJRDx
	4Mkpwn4u1usVGlnIZ+pPg35ONhoYBvgxW6HJEQPZQHRMGVmbVxq/iwjxPdmZslQpkv71bSOyxz6
	pqD2VIApPzzdmXjrjm0fKpfxcF/HSLzTM8YdLBu8aPEZCDsmIVGvN65Lm1IVUZB4WnwBCMFrX8L
	Oa2kFKH72kFHf4g==
X-Received: by 2002:a17:907:948f:b0:c35:3880:773b with SMTP id
 a640c23a62f3a-c3538807e2bmr1261766966b.45.1792143370642; Fri, 16 Oct 2026
 02:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
 <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com> <CAHwyqnWT9f0FvthhsPcRb+c7j7xb1LBxGxxBheb_ddfcUqij+A@mail.gmail.com>
 <CABh_KWi-MkiTY56LOLdaZu1dxxYjkSNX3jjO8+9_+mp3-FaNkg@mail.gmail.com>
In-Reply-To: <CABh_KWi-MkiTY56LOLdaZu1dxxYjkSNX3jjO8+9_+mp3-FaNkg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 16 Oct 2026 10:35:58 +0100
X-Gm-Features: AclHuK-XktBpIBxrBFcFOtT4RcPL2jKUiidNcLZ5l2QNhW48-Ie5yUeQrPNqL6A
Message-ID: <CAPSxiM8N4MjXpXjryxhx4170gEEQS6mfZu3+MQQ-1iRaFrxibQ@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thanks for taking a look at my patch!
> Since this is for an Outreachy microproject, I kept the scope small to
> follow the guidelines. But I completely understand=E2=80=94if it helps, I=
 can
> take a look at modernizing some of the other ones too in a separate
> patch.
Firstly, do not toppost when replying to a message at Git. Use inline comme=
nts.
While the guidelines talked about keeping the changes small, which is valid=
.
But, that file has about four instances of the same "test -f", that is
not a big change.
You can change all of those instances.

The main idea of Microproject is to get you familiar with the Git workflow.
> >
> > Seems like a good change, but there are lots of these calls in the
> > codebase. Maybe change the others ones too, while you're at it?
Valid.
> >
> >
> > Harald
Thanks at Harald for the review.

Thanks.

Usman.
