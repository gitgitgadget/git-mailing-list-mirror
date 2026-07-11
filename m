Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FE2147E5
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777328; cv=pass; b=Vyuz5yJVDDlvC7ifbmgRDuiDwDHX3ipmS4oFS6xD6eGCbdPQ7YzFnZZl/bk9wZpyahfYwEav8Z45Sd4H99ZEJwGKdffdv/d6sgzEnGkdwpKG7z7737/8+aMom3+H7rlEOJES5T9S8wxpJfqbIlVFnH7SnFrx14Q/3cT22b2ccjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777328; c=relaxed/simple;
	bh=5eQdCSyM/CkI70doLBQfEbvtjDoom7u6RjXwjrzsO1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLzNn1EFVv83dWQQ4Y6kDWXATxciefVbtDsBxatnraDOneMw9Sgh+qmfZZMn6LNKXvg7ddWNU97l2sEcyGDo2x2LbSMEsz2heut8XkoH2qjhY7PPzbV8s/4p/iTogXh6+ED8b0PfGeVhW7OJ1vzQN+tSmIE/1Tks+oR95pIo6i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siqvA8Mi; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siqvA8Mi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so2132902a91.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783777326; cv=none;
        d=google.com; s=arc-20260327;
        b=LhkhrS9KPQ4ecXClpdNikFVxMQ8wOb3X6+8WAzbjK2IJchmyCNnWSdzclcX1klGBnt
         j7ORRsy9ub2wPAhvQqt+T1xFYmlQUxKxcbWZ/ze/O7u0xQ71jH+i115FeLpIe1ujX6gr
         HDIO3wYjNFtWou2CV/evglzMUaj4Y9iIU8MYlt3Aoe2vYXmlorRpZgHV00yaoKHxlhgh
         VBcNpgaR+/UcO0Xuxa8pSqKnmPjA9EdXCN+xQsHEXxmldvQ2pi6i0Hqi62wlxtSgoITf
         aiNxLZkVnkwKWx0o7Sa1CEDvIQMlvOKJ6NWRLUbfDgCI/WyDNOdEoze9gyfgthvg46vV
         AX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZs6C/QifMZeepU3yz4lVwxYYE5eThpWZYYbyR4ZejY=;
        fh=U/YVYVeITvHCiO3Eu2a0nYxfXh9Ry9hvWX81oqLYHl0=;
        b=YqT0bX31Hisq9xbRrt5qMjw7/YIfjbjTRdBQcx7TDAaj9pOw0yMSGUWsAuhkOxri7D
         oXdTrU8KfCtDn5GBduUsVfoOdOyRFKuoW9G589iKy+ZsnB7xtk73+hDi9RUgjk201lEJ
         8vFoP1ak/Lq6k1pvGeVh4LCooNwOmGPvhnfXeV+6cv4Y5tZT9VXKSE3Vr8CC8KqEw3Yo
         Sp+VkH8m3jkUb6EBQWpXhqpr1tZVRXYU0LUyMM8KJxnqApLVmjd91AJJg4i1MLeENAjG
         iVyQCCfmiX3JGDZO/IEB77TcYDI0lSqIuz5zvyaNfXBSwnaZkoZ/KX4v16rdd/4uf638
         mphw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777326; x=1784382126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZs6C/QifMZeepU3yz4lVwxYYE5eThpWZYYbyR4ZejY=;
        b=siqvA8MiPcxl4F9b5Cze0+GOjuSDVxYU1WkrzjbCIbS7dsmdX6tvSHbfDIxZu5zfUb
         8qTNwKDNhP6v9dEJqz/GFGtwRn6/pbwvXGnA0J4Hp3Va0xVsttIk8yM2jkghqRJuzX28
         NxNlWNHzd7yjWquhDGuBq3ygem74JWfYmjwYVuf2jDPSHqhaxpEHMZub5nX1G9mJPu6R
         xEEhMInxvEZWcFp/Fi3hwXibemmOY07brTy/JJ6BttQ+sb9nfOcDKNU31jrFXJ5tJuAY
         21rkFM6Q2opvkyvqLG/Nv6QUka/k8zoR/KZGW2q6FqvSWRhVtdKW0CKU8cxSZVNCvZPs
         WEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777326; x=1784382126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZs6C/QifMZeepU3yz4lVwxYYE5eThpWZYYbyR4ZejY=;
        b=DPnYSoMPzdAT7/+Gx/C+eOrmVIYHLsv6t09dftfWKs/PkNS4NuV6lp0H1Tf4eoEj50
         Fpn/q7EolEZDBSnKJf3wPCBm0mbUok1RWVrYvvYOBoJXKa2vZbGC0Y5EjTstypQqeKoH
         1w7r/0DsJmlNg5Wi9TGsdv/o6zyOXy0I7HT1aEflnOKLVQ/t3WDREZOY0L9Fa5maEdah
         HACj5qlbua7uJvYD1lj+ZuelYdbZ9HJ4i5jbJSzaQDiUk+mtfTpELD3P6296deaIjOmT
         DODIaJdUYHsMaMU345+Qz6ZkOjzroDAIxS0lmMSv7oLdnOe+smY4mTap7RuZcNV4t2jT
         6CaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4DJqnJhywuIWgY61SK1Qb6aoskXa0/pyYoMeYo5SUUKktTO7KMeiyenGGfQzNCGTqoy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfe16htjioyiZ6pXsNO0yQapcmKGQtyDaaPmTdkhshudZZiDg
	nqnA6eech2CBrUsFj/kOWZfZ2HwIbUT3GxhzN7GdaVmImoXbD7Ql5vSRUpRP0j6z6GFzhGfoaxL
	nn4ir7N7TlB7w2k7HoWjoL82gVKX6yO62ZQ==
X-Gm-Gg: AfdE7ckcTajE5Niyxxu3/GEGEdC1IGqfIDBTzWv0Zy8D9CJLfDMsLx/dRc44A46KUyZ
	BcQKP9rIt9VtpL/fh4yCx2QqsRGZIboajWNn0P2rBgV2Yty7WMMcQPsgnoeIxA1tFVQZdS/rQsd
	AF4m8EfUQ4Q35rhl3ZG1lPmzAB/kjamcclm0Wgc2edQFR3hn9R/EoGf8qITXEp+6UNIb+F4tknv
	y24c+A/ZqwVIUkdAdJ8D1yEzcnmm7zKkJPPI/Sj3tix/7UP63H+xH/MtkeoHEJdimSHPyW0r+gc
	QiPzNDaic3LyhT92MXIpxO661XVFMRALMYkdVRGo0KmfCS+VBAmNrARRyms02ctNshg4qmIwA/w
	day0kB6wMBiGMgtYuE7uuPzhfU+FiLMC8l4FbcPT+4SgbW2g=
X-Received: by 2002:a17:90b:2646:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-38dc807217fmr2355462a91.1.1783777326250; Sat, 11 Jul 2026
 06:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-3-ijackson@chiark.greenend.org.uk> <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
 <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land> <9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
 <27215.27575.968985.583226@chiark.greenend.org.uk>
In-Reply-To: <27215.27575.968985.583226@chiark.greenend.org.uk>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 11 Jul 2026 09:41:55 -0400
X-Gm-Features: AVVi8CcCJN9tgX5pdK4k-9CjzU14QQOyv52BRmLOYdEArTPED-GzQsvcR8DwiRQ
Message-ID: <CALnO6CAPMEjVsj-5X9VyUtGM1JipXj6g_0JrC5gk37s178G02A@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Jul 9, 2026 at 5:48=E2=80=AFAM Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
[snip]
> > On 7/6/26 06:58, Ian Jackson wrote:
> > > Another, bigger, reason is that current git-subtree generates unmarke=
d
> > > subtree merges (ie, without any git-subtree trailers)
> >
> > Subtree merges can be performed without git-subtree, via the `-X
> > subtree` merge strategy option. While the design of RIIR git-subtree is
> > outside the scope of this patch series, this may be worth thinking abou=
t
> > in your rewrite.
>
> This is what I'm calling an "unmarked subtree merge".  My rewrite is
> not going to support this user behaviour.  The problem is that it is
> not possible to reliably determine whetheer something is an unmarked
> subtree merge.
>
> It is possible to guess based on tree similarity, but that's a
> heuristic.  It's also possible to guess based on root commits.
> Both of these approaches can go wrong in some cases.  I prefer to
> write reliable software, which doesn't guess.
>
> I'll advise against this practice in the documentation, but I'm
> reasonably confident that if a user does this anyway the results won't
> be terrible.  The upstream input to an unmarked subtree merge in a
> downstream that has already used my rewrite, will be treated as if it
> were a downstream branch that predates the subtree addition.  The
> effect on split (in most cases) is a missing parent relationship,
> which is undesirable but not catastrophic.I've made a note to add a
> test case for this scenario.
>
> Combining manual -X subtree merges with git-subtree --squash merges
> could easily produce quite weird and wrong results in the tree (even
> before anyone tries split, or something).  I don't think I can even
> reliably detect this situation after the user has done it, and of
> course since that user is using plain git, I certainly can't prevent
> it.  This is another reason why manual use of -X subtree should be
> discouraged.

Just to make sure I understand you (I regularly use -X subtree with
one project): the Rust rewrite won't support -X subtree merges, but we
don't intend to discourage folks from using -X subtree merges in toto,
right? Merely not support a mix of the 2?
