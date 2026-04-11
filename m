Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E6EAC7
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775891861; cv=pass; b=RCRwd6V6rxWIV/26GGiEgMHsxAJ7FAkHvDjP3e3su6XE7Yb1Sv26dRHQAMyU90DJeg9v8S+L2YZmlu/PGrb6T81T3Vc4DFsZtMt00QJeE4yrOa5P3rXwoaUHRNX0Qz1sYL6bbCkI3a62WtpJ8AujU23CLRoc4iDwkL4c33I5ZQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775891861; c=relaxed/simple;
	bh=3DJ0Xeohn9teXjZRx5f19Keax4ps/WaUyrDWTY3ThfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwjIBDyQ+nkTsSITO/1bksLjgyKP5yny1OKo4xBgGUggGCE4xHZSyCmC9/Tq1AMl5Kyptoye7AHfVfr6G7nHnY+fRQ87Oa6nUldxKa3pTrvRmVNxtCxmi1np0Oh3c4gzMWc3t79FjSVHf+lAxr1XMgXNGnJ+Ay7mccsmYQLacWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4V5Zm3B; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4V5Zm3B"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d5ead6a34eso1747320eec.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2026 00:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775891859; cv=none;
        d=google.com; s=arc-20240605;
        b=gEjpoxUhzt0+1oOTldfjvxMCXTjiZa6Z/sslel8FP1mX51PlFwUikvs5PNx2nbwx49
         RKLd8R+3Ze9d8doUa9d8Z0KuXtxIzmV9SWaJ9O0TAY7CJCtZfcn56jcl+utfIQ/NnjFk
         R+dckvk3SErgRJE8t+htAWAvwKwy1lmtz77ERA0+A/fkupRX63UBtrL4NsY2UeEmKpOv
         Z8/ER6gZrt/si1l7ZyKhP5DKv5qsnyxuxYG9b6tLwUijocwm81mHcUMxTkfrsAchevN4
         fSMndWQvENReTp+7+XmTrRJkUc38gE+9hfFNIRTPVDIdCuGjMnflSKyl0FTm2hmE2PVD
         Y7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3DJ0Xeohn9teXjZRx5f19Keax4ps/WaUyrDWTY3ThfQ=;
        fh=acrv9a3zZh59s2d1Q37sV4XwD2Q08tBf0ekhrnZr+Ms=;
        b=BvuqkD2l7M/XG5tTc5pmxbM/HD+EGLodlyv40KLw4OWh8DDHvtfaITRmP5InKS/Rdy
         tiT8AhKeuW1kXtGWci+gAU7Y+wh6NdGM5nZ+uZ5Ft4cokhNcXTRRq02rVDBuevJFLw+x
         ocARyE2/GsZ2O1DYgWT7EF7o0ByfIVUQe6P6vCO9XhoyfwB+epApKYIdCv6GslM6F9+r
         p5UsjUvsWrw6aWBveneAniSxATDHjypn00iUpwEgBpjFalCY2IQSXJ/PVfkNwfnNal6l
         TsBV2F4PQiDe9AW3DftQdTp4e9w3mGNo40c6ciF08zgSnIhXq1TOUmclrvp22tzDvwAx
         L6aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775891859; x=1776496659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DJ0Xeohn9teXjZRx5f19Keax4ps/WaUyrDWTY3ThfQ=;
        b=a4V5Zm3BJ8pkWYR9qXbQv14/Jt4J+bfzu3pzdVhUdsDVYZ3ExkBknFrFpOBLkgrthE
         XU+aVDbRQXjhH5PsVGXT5aTUVF7BqUV6G77ZHeNf2XymhIodQHcIh1SYvGniKSNwrwkS
         MIzIw1LKyy9pYT9MFqTcBAelFhTLV/VPfJhEhK4akt+/ka+VypasZf0XJ/BHxpWsiin2
         SAkaBUqzh+HET2mwJQBjFuPeJ6JdhHVvVMnGqH+Ct8Zpznrc5943Qla7/mSJNp0VOswW
         pT/o/wZDOMcu3o47HqyvNTB3V7wTI1dLKnw4h4I6+6RkA/Nalvx4LpigENR3qn4f6k8a
         jyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775891859; x=1776496659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DJ0Xeohn9teXjZRx5f19Keax4ps/WaUyrDWTY3ThfQ=;
        b=IVA4a8ej3PAqrMuGBrYOc1PjvcBU0+V/sx6FfFC9tQ2rKl6lHuyFz0ptQIbO11ipby
         zxZ2D7vip654LKzZnPCakcEQGgbyVs8Uj1BrrRyFOQnl1/fCDsQEYuTfimrqNM3RCTpR
         f+ozndlza/7C788KJmivCvb3fcWsQrBype62oh8vBJR5g3+D6CkjINA6QJVWn4GRaw5M
         ZiMtjldnQRaoMOhAQ0gfFKpJ6g1Sw2Ns0WCqgGUZr45NMAncf+T9a7zgXuEbG/ZtjUNw
         DpfGqWUSamqVYmUzwKC0rVe6g++Wjm5aH/P+zTMULe3fB7pjdOE4p5M1w6iHn/izmUt6
         WQzg==
X-Gm-Message-State: AOJu0YxDi6wzY3XyyVt8ZxUN0xnH8ucy3aI9rXW7tyaV0Y0mUlpwhO7e
	+fW8cfLhaOijFHHiU9+927RyQWG1ukrFM7t9AloQZGYoK/UthtxVVQnnYk1lWfn3UQwoE9mRjhc
	ww8RtQPWo2cZpMvpGwSzINSHjC+Vid+VV6ExT
X-Gm-Gg: AeBDieuiSS+ezx5TJoicZGdE77Kz5mfbRvE1RmrPbLsi0GjSAZwAxkG7gpqwTIaO0it
	QMhDi5RzFAw5iyZvs5RW0V/o3C11a5wx559XY3kwmSVMp9QXdvQ2AVdmhDVOaV6u8TGQtQWvcoy
	hDftJAQUkdGoC1JC2y+zeLbuJDgZWLLBf8B/lCxGvO9o19lr4yCjssWKRlP+mcd0rPPGWrQm9/I
	0EeDxFr5ARGcUS7jz37Ae694Cds4PtbMfTIel5qngfqCR9+tUV5sxUXCqX49CFaxaU2CtkQNWdk
	ZlgQGbdrfeUABvCNTdngtKdOyfepcdFTY8wtNg==
X-Received: by 2002:a05:7022:6982:b0:12a:6a64:81ee with SMTP id
 a92af1059eb24-12c34e6b3f3mr3027077c88.3.1775891859020; Sat, 11 Apr 2026
 00:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
In-Reply-To: <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
From: Shabbir Bhojani <shabbir.r.bhojani@gmail.com>
Date: Sat, 11 Apr 2026 12:17:27 +0500
X-Gm-Features: AQROBzDCrbE1_F_-FU8ZTLiXaOJq6mRtBx-AGJPsQ4wW4qSlQgWd4sAz4pZWVeQ
Message-ID: <CAEc8y5QM+gV0saHUO6xbTMP-GWH_KZWPb9V-khcML0+3=67ZCA@mail.gmail.com>
Subject: Re: [PATCH/RFC] stash: add --include-untracked support to git stash create
To: Shabbir Bhojani via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Shabbir Bhojani <shabbir.r.bhojani+git@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping =E2=80=94 this patch was submitted about two weeks ago and
hasn't received any review or been picked up in "What's cooking" yet.
Would appreciate it if someone could take a look when they get a
chance. Thanks!
