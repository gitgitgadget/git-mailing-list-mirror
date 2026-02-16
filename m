Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307723BF9F
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277155; cv=pass; b=PCcZVsrwdodv5jLD+FQ/O+hXsoLE+22CJuNrAZJuWu4xoZY+SdRlV8X6l/PgmxJkf09W/EsMW/56jBlD+OQGtEnX/x2STm/jTjtxAVhMqhRKzl7WxDR+REigbXR26YjAEgqxfK1U2YQm41zRatVtq6TUE0j4tTX/GWUWHburOzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277155; c=relaxed/simple;
	bh=Py0YHGSpy3phMm+k1yBWyKNZRETOB3X0sh/u22XsH54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbn46zL7Sc2rV5MTIG8+c/2BiNEOmWqknjiI4bcNXgnAvfp5IQDNnqrZm6+4m98qCYb8Lt131q/pgYtr4LkewBMTfeNlS8dqJBUMyMI1TiJll4BOMxmQjCddTxMz/CwhJsa7ivb70VGZ2Q1tJFPT9n9hWedVyNi1qBdtQeA35yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDwhGouu; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDwhGouu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1433329a91.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771277154; cv=none;
        d=google.com; s=arc-20240605;
        b=b7gyy95JMwn24N6VpN8+zaehoMtC4xFnL2OQRXfOrpRtmcmtQ4097pLHJ2YqxsBYp2
         NT7eprasgHE0BCK0exVZW96ULz7PvIUJZO45hnXfoZ1D1sNKu/7pzC4wtXAEXdHLB/Y5
         UxHA53Xg+2vO5E4uGJUSYnOfK9JethtrNT44xtL5HRkwSHFllx0b5mUnSV3Ls2dzOQdT
         Z7xhC+klVp5A6CTFd2u8sng7p85yqSmob1vJStc4lBUgQqMTiCgjDfe7ASrGLBV817Qz
         racXQ62Tq+ZybvK2I3VeJZNWCMS40GQIh+qYgGrEPzG/TYl2GNX6aMx8xUS9Pmk0nsoX
         JufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Py0YHGSpy3phMm+k1yBWyKNZRETOB3X0sh/u22XsH54=;
        fh=h0zmq8ijHzs6/yGwVrcMuThoZHWAS7Weu7RTSv00c94=;
        b=FKOgL+yhYsAIpmwfPsX5mRFhU86M0DuXKty12p89y4wdjl5u4yf6IrnRbChBBU9I3j
         FDyZIT5Gd0zK3yc91MY21EipyYRDhNzl/RDB66G6RO5RN2kKiJnQXtuedzkeOa66NQfA
         0hjxfqwTpLB9sCeC42KxH2wcrnJFpvZ0TeV6Y4hOR7wZeKofs+QoaNBVBF863TXLHRuC
         vD2gOSFI2rEjoQD7LOwMDFgnPpECBQYEmrE3eoN+XPD56z0IsQ8OBT2Sp935VWGTXhQ1
         FtSYeJpTXiTBIBtDXIMhccfJWgQQ5jbtNgO1ipsRSWhrHhBRStDyykMjk6VjfTPX8tnN
         HqfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771277154; x=1771881954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py0YHGSpy3phMm+k1yBWyKNZRETOB3X0sh/u22XsH54=;
        b=jDwhGouubwdzsxNUc/G+TLb9pqK/W842kU4g46KrsHBD7K98N0JssRH042VT2DlMPQ
         EjBdRyzeC1cWbHxPFG51YdqJsGisw0/iLAfzvkElXGEL4+sxRZUhSJ4irhSJ7LTxzQgH
         AQ+fsWBTrn/kVIiAo6LbLLR7qu2CuPl21yRYT7TatFWqIMIaYoCN4LNmcTbB+OfwETrH
         r3WdD0SLSroUHYhK4fjPLax0MkcQQwnmG37a9Jnb2/Lps80TWew/rQFbqY3CSr5AiEck
         kEz1YriJ1EYw7uaiWLAndFerhFjzAKENg2kjzV1KzKYqVNh88c29IH+IsoK2uPFNynjW
         xysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771277154; x=1771881954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Py0YHGSpy3phMm+k1yBWyKNZRETOB3X0sh/u22XsH54=;
        b=hJhZNvBcnY9dFeQasWzShnmUboFFqdIg/vuxLDIYEgH8khwgye2vsObbBTH+YV9kh+
         hjrtEfSOX+aEMEE0fDjQ739l9AsvK5j+HIw7p8PJEoV7+ORjyA684QQJc/uWUUUx/X7c
         gxceG0TdWlSiqec1lo4UM+N+wsDuAb2kQQvpQcdBgZ+w1oieUGFOomeVtM87PeyHXDmh
         Iq4BYjK9BYevVqsnRi9k9QWS6NKkLBeegfyeCjJZq85txLzP+WB6HZzf+6Xx5k8bx2oe
         XEqvaT1YXG69gMpjQ+SLCAvXMJVX3K4HrcGhIWyak7hVvvVxhcg9IRriTuQWgr/ltyLj
         e7IA==
X-Forwarded-Encrypted: i=1; AJvYcCX14SSu4wkLBHC0CwxO2sau63rI9s67p31hxQZI0Iyv6eozcUFS6uzeYGvDi1nv65Hmf+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiQMTKFxjGLocFmqCksI/zVIagZwTDiCzGrqFS7ju7ietilP0
	K1SRm3E0xjm1VZKp0aqMc2TRlirV+1jlclnI/wSBxFSSE0s8M2I2Hez32kAfGHZHCLP1Ux7btJR
	1845kxnLWCqBxInlo1TrCqvrxHWG8TxZTDA==
X-Gm-Gg: AZuq6aK2Ca5xkf5jkmSvEi0JN2VWUWXEPTsspr9JfxbXDhGj9bJY//Vu3tWRgDNxZ/L
	5Qd2eKpX9VJ4SMLJk9MDrw4RjcJWtZfgIRxGpHpWduPrdZQyFeK2zegOst4jDAemrLB7H2YQLJD
	4S4BG14nX08iVPUQNtvP0rtiz/k8x42BQogYIyAPKP6rH2tSSf6fij/LQcovOWFaU0+be+fRuip
	CRKMYdYDlZAgWitsYeSAyGGv+MaiaQEM52HWsVpUE/xvKNoDpDhFz+JfrOrdXCVcxmcUC2PZLVZ
	4PuxIac6idNZhqC6OSu+Q2INGMD0g9jgDzkvJ+zCJk0L8BOg9X1+nWyBSLMh/w7xhaiKg9uNOgG
	Q8tBAGDGBJjkXjvjfpCkkhiWKjg==
X-Received: by 2002:a17:90a:e184:b0:354:bfb7:db13 with SMTP id
 98e67ed59e1d1-356aadcf6f3mr9705265a91.35.1771277153632; Mon, 16 Feb 2026
 13:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5794d99e-a7e6-4258-9a1c-1512c3f577af@howdoi.land>
 <20260110172219.125762-1-george@mail.dietrich.pub> <8d5212b5-3088-4b73-a849-f1c297e06157@howdoi.land>
In-Reply-To: <8d5212b5-3088-4b73-a849-f1c297e06157@howdoi.land>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 16 Feb 2026 16:25:42 -0500
X-Gm-Features: AaiRm52BPtUti5DzoJrJIkNxW4PS32e4SzhjPgm98geDLILPhuBduqK7s6vJgCE
Message-ID: <CALnO6CDkeBCi3jhHVDG5T2Em_SJrDokezjrao6xCXtSK89MpEw@mail.gmail.com>
Subject: Re: [Bug] Git subtree regression
To: Colin Stagner <ask+git@howdoi.land>
Cc: george@mail.dietrich.pub, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 3:26=E2=80=AFPM Colin Stagner <ask+git@howdoi.land>=
 wrote:
>
> George,
>
> My original patch for this issue introduced other regressions and needed
> to be reverted. I don't recommend using it.
>
> Instead, can you take a look at:
>
>
> https://lore.kernel.org/git/20260215201748.889866-1-ask+git@howdoi.land/
[snip]
> https://lore.kernel.org/git/20260215201748.889866-1-ask+git@howdoi.land/
>
> which fixes a "recursion depth exceeded" bug on Debian/Ubuntu.
>
> I've CC'd you on both of these patch series.

JFYI: looks like you pasted the same link twice ;)

--=20
D. Ben Knoble
