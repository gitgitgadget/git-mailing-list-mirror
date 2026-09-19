Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD149620
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789829987; cv=pass; b=HDBvWlxHXyqHG7VuNksF9QyyQlPl8JdKSqu568Y4QIy5nuDa6fDPq082+iPUvYJzThKMUofvw0eB0+wguUbWB1ft0kNlG2SY0rrXEVYXqoRfBPR0hi3CffD53Pw0juKOqJk12pOJZhq/8BfNWWZmtO2o+4hozSYvGXEzzezHrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789829987; c=relaxed/simple;
	bh=syjnEFqJYM7dSubTDG8dt98iKuCd0yF02xuLT0HvUyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWKXImCyKXaTsL44oJyq0Aa6h5tkFixcAw8nxL0k83N4EX920dw6JV/359KU35m8eleJf/zrceufDg2T6o2WXPA5suX3m2vEkQEzbVt9VSaHhvT4lF/NKW3OlPxZMUcly2Mzz3aKDcSVWlg3CDcDuyBQMfrpE1EIgJ93qst36TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIU7X3Zr; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIU7X3Zr"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1253482d50.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 07:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789829985; cv=none;
        d=google.com; s=arc-20260327;
        b=fQa7qUl0dQ2+ZWCyCGZ5j4TlQEwLrT+KUzjVkfwJ+6BsQdmzQhx6lnKenQjPTFQ65b
         6FUEA7RyznDZncNtHb1xLeyBvtKMpal/P8zN320bpUIcdK5SRznM+rZSHF+DRjWvvcx4
         +F3hyLx5WoCEo9EhQn5n8IlYEPg7M8mKH6Q9a8KomfygkNk/aIeL8CLltETEBHvU1UrZ
         xKTg1IE8gJp/m0oWNXuS4SPvSDaxkdcinK1EqhdVDgodrmwRaE5E+l01FbJGHr0xiYY9
         EPurW3vlsgINBXpXcDOtY1P6ODXTpgb/AKuZjAigTg9artELg6jy1DbYuaVt5kYZ/mLX
         vt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=syjnEFqJYM7dSubTDG8dt98iKuCd0yF02xuLT0HvUyM=;
        fh=ibKbMMBaLENO3Hoz4bQWMF8OxegzyjnZHV3qUd0382k=;
        b=AfZ3T0xJhbCgTl98eXN2Fd3TgP+uyi6tnLKTveeHRzBBPCQ74O1OxsBIkuR4k0cnqI
         XgNqHPLjelJg4PZjwnl0HeUpzJkh/OzK32L591h619KCWbWaXH4D+ABWdhI0kHP7irPd
         6QotSDBu3i7c2qEvmWIRnD/BhYK6N7tVV+vJpGp1485Y2VrlVNWNBBW3qiy8jfsRU2YF
         3AJQ1UsIe47c26iPZ99uqHRtU11ApJPIZs3rnQNOT25kPhwnHoW/ehv2/1WeFeD+3iNV
         QON5LRzia5VlFdoQuuDC9YQ3C/hhz0hJyEvADI94O5Li1XXRDl6hqJyiq9jYZaQkXEPR
         zE4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789829985; x=1790434785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=syjnEFqJYM7dSubTDG8dt98iKuCd0yF02xuLT0HvUyM=;
        b=tIU7X3ZrpZDUvcAacgCeGlBLPa4r7XMdDSeCKNqPBssSJ7LS/TkjjYmp6/gJkIm3uT
         IrytukTaO1+jDPFO7TaSuoO4G/TFBR0MTLgzfAxcKv06tlO2KMu0a2KuJA4be+9657vL
         qRUUAHOCnY70ZATZ7yadsKeorh/Xgti9dMIfJbccG9FqltCnr5emXx7AkcjSspXsgRET
         pnBwSVdrn4i5ZJHVIHDeMlv3inkN3DNJ9M0lCutwJEGo9QoHZeGNx1DDRfnT4G7svhY9
         fl+Wz2DP+R0PZjc+ImJIX6b/EIB9DpnQ48USfNRRvb9JcCzzpLyEnHajHWO15BpNd3N0
         U5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789829985; x=1790434785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syjnEFqJYM7dSubTDG8dt98iKuCd0yF02xuLT0HvUyM=;
        b=F6cJasIOwuOUV3HZP3HAxHdcl6savVAY0+aVzFE0CtLGbEnpapzE0HWp8ki6tSJnau
         oOE8c0X/h8qlH1A80+5BUiVt2GGiEFh7/mgQwFKmhyPPteYZbA73ZqIxiiKgGALvePcn
         or+GcToryF2XK5mIoqR5Oe4muGyXTJYrDhp1tLLUbnvF2MeCGGJaBmYVgEtT1sEdgb4V
         iZOwoCiQ3IUrRka5O44bYnzBGqEd6iBGm7CwQLZj/Osa3dfrkLMHo2fyb6BHHU79Y+oV
         2ia32n79//bJcb+4/3jAs0ezWJ3xe0ihjAOf2anSDCNWhNwdT3WZLEpMTXV5xajhnJ/z
         SgOg==
X-Gm-Message-State: AFuF++lPWcAtpYuDahgOS+CxFD6W4tIGfFvwkp2hFs+VcmbmgYtP82oT
	/Dm/X8Yljcp8/hEX7kFu0eUJSEBnaHwXafTLgnqI8FGmY0OuLEC80WEqCT1Gjv1xeqX8nL0MNGh
	z92NI/mT5BwLL7bBc+jvV1r+xq0O6REDrxQ==
X-Gm-Gg: AYBFou0yaTf06v7BHSUK97bo+DAVcTvMr4BmGcy+HhYSsdaJfAM4r5W/hkwvfz8W2F7
	O2CI0w0ex/iTkOqHi1SRGcReQECNIBjGl/tZNu9xD/QkJzRFkBHDnZY1RcosKyt+nBaUdV8ebNe
	YuARVMM9ipQKRhWvbKdpTAttkbKZvL9B2hrjgNQRzqrXvvq2raY36hngauXhMjPVY1y8/2QFe09
	agvCec1YvjfNl+HIKlQcOT/9DjvGZ/DXCDCkMS71UqYD7IO2Tpe7jGtm33HTSfnvzswu08ZBxN8
	AeDnxAXKjZ4ppBhGyXEeYq4lBveSCVt2ydt8+JMB1BSTHPl2bmelli1sYrMJyqxTNCgwxHN3mOg
	xBiQJMucXRmuobsFz3LEedHFaLr1XqB87rVaqqpPVlbWXsx1quuBGaZm8ARuHx1Twx93jJ4WPI7
	TvmwI4WUY=
X-Received: by 2002:a05:690e:454d:20b0:671:47a8:e02a with SMTP id
 956f58d0204a3-6717fcd7aa1mr1121263d50.45.1789829985093; Sat, 19 Sep 2026
 07:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com>
In-Reply-To: <CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 19 Sep 2026 10:59:33 -0400
X-Gm-Features: AcwNN1VMS5YcrRO5-S7YmzW4KPfAaFIogjV5uffqCZuCZg09gwUZ3v_xBeX4Eos
Message-ID: <CALnO6CBUr3=Cj57ikytiPxU-1hZkYu1Z3fRPydhFLqJHprbDew@mail.gmail.com>
Subject: Re: [BUG] reference-transaction reports zero OIDs for branch and tag deletion
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 9:34=E2=80=AFAM Maciej Ciemborowicz
<maciej.ciemborowicz@gmail.com> wrote:
>
> Since Git 2.31, the reference-transaction hook receives all-zero old and
> new object IDs when a branch or tag is deleted with a high-level command.

[snip]

> Was this loss of information intentional? If not, could the previous
> object ID be restored for these deletion paths? If it is intentional,
> the documentation may need to clarify that high-level deletion commands
> can provide a zero-to-zero record.

Since you seem to have identified a "good" and "bad" version with a
reproduction script, I suspect "git bisect" is a good way to answer
your questions about intent.

--=20
D. Ben Knoble
