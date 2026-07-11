Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2D2D0603
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798741; cv=pass; b=B3GorCRSznh2+nanvUJ+LcbPfQtdLqdVvw/tHSJJe6Iic4SdLQaj7/LWKJnTN9/YDhDmpJxy3apUJ6zNCa7pT248EyQqCgM1V/oL05RUZLH8pFL/X5hLeYqYIq33UVpHPqkVMjoNuf/2vp11NCOlZpsVLzENjCm1Phwd2v93cJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798741; c=relaxed/simple;
	bh=SiHT350nezs8yxTIKwuMD+yU9frDh1IPZ5f2p/e+quE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTmvrisezkO2pTEdK6fIx8Q6Bdcq4q2rRB2Rp8Rcb2NGcHVRx2ofvjtpQGoZpj8WOFec+vCSQrwvpaG783pUYXFXZdQInuXjgkL5CYYbL88rhvZ5nWciy1+oVC9y1Qb258O2nurNIA1QhqDxHJgHmCUQilDgDO4G1j+4ERAF/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVrDbhWX; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVrDbhWX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e70159a27so16424157b3.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 12:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783798739; cv=none;
        d=google.com; s=arc-20260327;
        b=OGL7jr26be5lMwTaDxW4GUaQRfiu+Q3y1ioePVlxUH6A2pzWz+dEs3SolLEFIY37PG
         ML5QZYR+B2UmrBrbcbbAhDVFQwLQmpQsMBNYTQF0OdHXwPV/YkiUkYgWPhGdiv3oWQ3K
         /DmkgJGyEX7qhkqK+23WAeg5g42zZHKc6plJxhJ177LqLmGPI73ppA6+UtQeo1d2fq+2
         v5e1D8UbAg37+xupnEf/VqLQbby3nuBgPWGncLS/lp+tMXp/6ztnWiGH2QDknnC3dFcf
         vsafnB55nfCxOdo2Y79JyBjj3QtIpHl140GvMeC87977wAdUP8XTmtHIkihgM0LPJubx
         h0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SiHT350nezs8yxTIKwuMD+yU9frDh1IPZ5f2p/e+quE=;
        fh=tk9PMBi09uQBf+tFsCHlY/w1gItFGwM6zN3VIS1dNl8=;
        b=njW8iM+3Y18hTXGrPdHFith+59t3T0ilZ4SgNGkUR+wu3I0IEnfEcIYjIr2JtDHAtL
         eXkuySoJgUeP84ygx+V8BTnjtZ6fdUVWRUUaEyIBLAgdKWJZt7s8UBsTI/hQbMOEEDeD
         U9Q1Y2oNizKj8tEpNPVVpNkqEg7jqT20oeSqRfQ19PxS4MKb3snUNFJP5nOAkp9gvazO
         rhISTCPoS11SwpJRJF9buPXvH/JsVLBDV3Gu5u05C7gKiUKFkEKKt7xjWP6rNB3kVvGk
         ABI0TQGN+u9hWF+bz2ux+gQEa8UaXoqkFQ/RC10iYSNoA4/SrMzWVSfA8UXu4Ul0dBJA
         /LDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783798739; x=1784403539; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiHT350nezs8yxTIKwuMD+yU9frDh1IPZ5f2p/e+quE=;
        b=FVrDbhWXLEIwpg7CFKcwtbD1RxZ19xxPboWZthG/ylxprTXMs7msPI4HonxCUOUt5x
         0Axw6djQHt+Pd29MBEedEDQkTqK2vHeUtRMvkADtWAAyP6vn1VlXNV3f3TNvEaXeX1Ah
         jFlHqRAJkLrPH9+Ht6cwAyL+ywpOpwX8jSQ3T5vvWAQa7rwGDLM4tpB7LaPuCZg1hmyk
         rbnQHzlDQq3N9ZXVmG6cz4TrwqYSudEik1nfWXkLu/ecMvToYk+edO6yHyzQYWbwOmmK
         JMoqSJtGDruA8GpIKmOVxohlQ4lYU/rGBCpF0n1c6+bZhODeK0VZGdBJX/dm+VO19mdD
         fP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783798739; x=1784403539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SiHT350nezs8yxTIKwuMD+yU9frDh1IPZ5f2p/e+quE=;
        b=WID/2Fz+Qiptd9ieLSeqCFLpf03dzMPplLUPePCWuGQE8TpanYCBoRL4xm3xgQ6Yo4
         nny29BmkQRiP9JsErYB9M2n5Q48cvyjpFTylOvgJ1LJi5mVD7zY4TQTzccAKmKATz27N
         upmy7DfHDeLmo3U5Q7PSlDH0DVsL8T99ATLVBi3vNYbgpwN/HrU2vL7dNADfLQG3k7vm
         STIKKc3EAMrCRveO1iZbUisVsuvtbKtErFEM6sq1SsrizomwhvSHh/38UfynXdfqUDcG
         0ONBvLTJsaIoAYIWmH5W0Tyw2iJcRHMY94MQtq6QVrPh2bxedDYDs4iPZSJ8ootr7gOA
         29cw==
X-Forwarded-Encrypted: i=1; AHgh+Rryz7+S38bSNHzi21vdNDwoTkhP0cKKsURNJeigRzGOhqxz7Lvu05bXiynLnGf40V/NE28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/OTkP+4bMT56NxZpjQyKOGy1C7KwJAWyVUxTG/6eE9GB56jx
	Gtuxx3Z/iTEBXzFvjGWQBv3p/sqgEIjvKGVHErss42+1FdotUR+ekzbE797sEBuyUzmdVhukY3x
	7IwIte5//J2waxxQg0GbtDowBXa9O6jU=
X-Gm-Gg: AfdE7cl1scv56+QnhKBSXN/rbyT5CYcQkCeKuygAoEG2BO7V2IHOAm03OkL/BEFUAYy
	Oj6b8qSu4gIyBNXWMLTUsxLari/rL5+IYSnO+M9Rdagal4BwtY8POVWzECC+MMyQM71ACJIw2vb
	AuFnyRvcTcoAqWHcJVgVSDgsE/w1zZCLrMvRuXWKPWth8DGEr3ovqxu2lj4gLgY3/mPA97im1Xh
	ug6EV9y84lbVdVTdyrXCdfV1/+MxvuwY1j+w6AwqkSiowxEKx5s8B1PLWr19sLsPDQrmMvEPfFM
	p+TT1WWEYqaMI90evEcLdZE51kR3udhndykPP5EFBuKyeFqSyLZyIJAqexsS2PGbrBGMuGtUmuz
	4EPP62N2Dxq5LRn8VACGniIpIn3zlb+096iHXUJoE7UuVpbsbs46CE64/t8qhISXPv73C1a4=
X-Received: by 2002:a05:690c:4c05:b0:81e:7ff7:63 with SMTP id
 00721157ae682-81e902e0148mr27474187b3.67.1783798739253; Sat, 11 Jul 2026
 12:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701180813.776173-1-cat@malon.dev> <20260706142530.3681520-1-cat@malon.dev>
 <20260706142530.3681520-4-cat@malon.dev> <DJVZ5QPXBFY8.VBJN0TB3WROC@gmail.com>
In-Reply-To: <DJVZ5QPXBFY8.VBJN0TB3WROC@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 11 Jul 2026 21:38:48 +0200
X-Gm-Features: AUfX_mxG5ummTHyMYPhMZrQw-jLRsIR5Hbeao4jrNwwAhL9tw7M9Z1-rZjLc3Zg
Message-ID: <CAN5EUNQpJWt_FD1DvH4qRn12PueNfjXcdqOcEk1eh6dbd_1i2Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] environment: move editor_program into repo_config_values
To: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com, 
	Christian Couder <christian.couder@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Please ignore this. I replied to v7 by mistake. I've resent it correctly at:
https://lore.kernel.org/git/DJVZP8E2GS7C.1X325XFFFZ6WR@gmail.com/#t

Pablo
