Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F742049
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416008; cv=none; b=H6cTUN5a9G3ztX2PfoSUHpzajgty57j269bHmOf0+2wms7bnjKXWOcvanCQFSx4k6o25B2PtPoMIYgWWDNxk45xl8KMQb6B6tubxUf8ibGVhQEgwFSOsVvWWM2BDsAx513d2zEjsb7gYIEck3dRRtQFCPirKjkx61dBgy0DrURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416008; c=relaxed/simple;
	bh=k3H645XmO8bH698GZqWpsKjrVvI7+OwFiAXemJM6Pvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kGPevEDM4QGFS8nJzy1h9jwhuXnPbcRLhqYeG2wepHUuAxPG7EnbnV8swRN2ENi8wcP9vsPfEnCRIldbDSYwAvqLWsG7oxsxsM7zWh8dWrVTeR7vGlkNxw7WTaZC7rKFHx6H1hUFNnmYO3xTbj0nct7chXqt91ppR2tEHm9tGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcZdIz5x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcZdIz5x"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so29569225e9.1
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766416005; x=1767020805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3H645XmO8bH698GZqWpsKjrVvI7+OwFiAXemJM6Pvo=;
        b=FcZdIz5x8ZntwCr9uL3yFaG9KlKyMbtNwJEtnr96sce3mPvxWuhj1AtuXDaMx6Mlo5
         HzpVgFlFI3/XJ9Oe58PQsz31fzUrMBbv8kRGiEcnBnaFsPJPhlEqMP9BBTWBXFTD8apU
         qy2mIlUVD8fGmeRjgXyDx+QnSY+yGsRVm7soMgbZL6yVSxSmD1TEcgYFmvciMvLRAnh5
         ll6Dt66o6JvbzqxJ6g5r2vixpYtI3dr7WKl4cecixCazaFKz0y43c4mWs041E+hDK4UX
         wLIxLaO5/eJldOK6R/Y9FI6O8eTgwEo91vcJdgPRSNfqvSrNOwaBBqiHBObJlyDfST6i
         +gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416005; x=1767020805;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k3H645XmO8bH698GZqWpsKjrVvI7+OwFiAXemJM6Pvo=;
        b=NeuE11ECUVgtRjwOYuwpeQw6ZgJY9Bqudy4r9e3D+1DhNncchkIQjxcYJHFe35dj8R
         ARt9mSL61ioLfyewAvep07u3r32rbIxJYLMrLLzoAr0MGquXGNOClqEuxZCb72EJniqq
         iP7e88e8Q18MTd9FQw143mLT86U54BF2Fha/7XYVwjUFZqbiEA0ihvLWEiCu6vpFHgTW
         UIBt0zoboLcMjXkXaEUtSlLXdH9BJ/aBtyxi43IRBt1eV1YB/IZT+zpZusoxgLX0hIDP
         8Sz8RKmfAE8Ac51E0dIo5GOi8MXHH3i4OoDyTDBkmqU2T3Tx1Tk4UwayOrQfF8OHX44b
         B/yw==
X-Gm-Message-State: AOJu0YzPVHy6L41p1Ogpb9+hgHojYkzh/dKrrA05mH2yVa1qHNz9+mzF
	3Kk2V1jnFTlT84X90cLgQsvsFuem36hSNwbhl0suwl9R+XjNGoFNNm25
X-Gm-Gg: AY/fxX52zJPcU0r/eG+QQ+DD28bxJ8KdNnfDK28qsMYJ8aczkuE6TcoXdsQ/dpP19s9
	FEdigk31mtBn/70ZF70/WL1tBih7wnPNfeZ4aIrKhL20VcUbyJWNMA9MpflSi9mJtoB+HuAX9T2
	zjt43DpW8In98VN3os8nP9j4VOz/dpIKPJLr2oOIR4TQztz4LYTjAOOzkrDA9apSBApZI0MpAsq
	tMFVi/MoHPuOoW8qL46lkLVuyREFfCNqyu5+IcZiT9FGcW454CFPKXlOEtfmYzKX7VqbyRwY0Gh
	6lTmqTwT4GvPo9W6hrxsclIp+ExbkdOxeQABt9GggvD99z1eGPgxl4m57p3B2cQexNjUgBiPLNZ
	Hihb4SdZT+N+oaU04RTRadM9wjtrrzdi2Lz/HXJlVj8yUaFSELCvqcVIal7WzONfidnlzm10ibr
	J+2t4yIxkfautKA/P+JaHU
X-Google-Smtp-Source: AGHT+IHRjNDpxfy/1RywR4+Z3drcwY+wKC48bWKQiXqWQVVUqAhT3cWJqkhgMjq++nmZF5XFwoYrMA==
X-Received: by 2002:a05:6000:178f:b0:431:344:5a2d with SMTP id ffacd0b85a97d-4324e4fd90cmr11884123f8f.41.1766416004816;
        Mon, 22 Dec 2025 07:06:44 -0800 (PST)
Received: from pop-os ([2c0f:2a80:a8c:b510:477d:cac7:7fd8:dbe3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm22696456f8f.1.2025.12.22.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:06:44 -0800 (PST)
Date: Mon, 22 Dec 2025 16:06:42 +0100
From: Bello Caleb Olamide <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: [Outreachy] Blog: Refactor in =?utf-8?Q?or?=
 =?utf-8?Q?der_to_reduce_Git=E2=80=99s?= global state (week 2)
Message-ID: <aUlegnAMlfFCiUmN@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello everyone,

I’m an Outreachy intern working on reducing Git’s use of global
environment state. In Week 2, I focused on deglobalising parts of the
attributes configuration by making repository-dependent lookups explicit
instead of relying on implicit globals.


I wrote a short report with more details here:
https://cloobtech.hashnode.dev/week-2-debugging-with-gdb-thoughtful-fixes-and-learning-to-choose-the-right-battles

Thanks,
Bello Olamide
