Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF22DECDE
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097490; cv=pass; b=WTqxSi56NtQbvK3Fog1b5iBov3ejGrpg9p8j+nbTqIGxLKzv2AI65YmVquI2QfTZOCSMk22cVay572UtFT2wUasage4UYbebf44/5IMdNTXRAoMpErmbjWSLEZRlb/WbwhLWUQGPo3VPA5WnD1ld99sedtvJNLWi2C/RYOmxzoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097490; c=relaxed/simple;
	bh=+SswpHsy2l3f4a/z1vwtJkiJzjDHliDjFwFnaZVO5XY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=adNGB1JqqncFQCwnIJOR/7YuTy/Wh0M0fidQvO3Nudpg7XUnlQQoVG/pm5+S43dRm4iIRDN5D3bEXVKiD3gRKTlvCO7NFgG7PkOp4MXuZjOZwcK0dA4L3Va6kDdh1tR4LpyFjlbOwm+91OEuKKdMi948x0K3JXHCafQVP+Jjk9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5uRmycI; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5uRmycI"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c0f754e756so2714406eec.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 05:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774097488; cv=none;
        d=google.com; s=arc-20240605;
        b=kTblhEvxjCvPymUjVWpiM0GLmblf/LFZgjn5gDlZHUiUiT/5gprghwMPqjatSkRFtI
         lfzJdKrlvz/xRyKS87jHL4EwKvch5dwMxnAdDTSwAGDxioJKOO3A2xKSFjIB76EUxlef
         fUqeBljzMgkwofpcrhpyybJ6NhCE+aBlku+B67OJ1PohpY+DMNpLgUq0R2r5kbN9kKqN
         pIxiwqFJwM36gKlHCQv1Ue4jJ5pUMoozEUe1jiEBHezTp6oHsdo5yH3SwXVy1T0nXbZp
         Xl7biWqqKTSwRJQotFMPm+VFb0uEOPo4e+VeOShqZLTR8nV9jPDsM1EOw3d3WB9FvNxI
         suLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+SswpHsy2l3f4a/z1vwtJkiJzjDHliDjFwFnaZVO5XY=;
        fh=dH9oEuoSR0tweTCd4kttzKHkj6tK0VWYZe/MCTfwrq0=;
        b=N223DS1gW7n8xkkzKX9uUGZCh9SIMnyPElhcPuCsL9mzpS7hGxHWlqnOOlnJqMyFro
         MJ6OiQ2ooUPAPweWldD9l93WMwY5SGWYAbTdFQPTVTjwj8G+WXEUwjujueJzY3lgKTld
         ZoVxCAXnsFbykA021A+N/8zFkKzarB02si3IosWxhFZfGd+I9Ns9sdkT0RpPCSqdo1RP
         qoA2LWNJmLfHppjd5+8LaFdBQwfc2vD/TgWjCmuABQz6r2O2jF8+ZIokSVXX4MrSkoHn
         XB4xk7fHlu+so6/lIzZprkwWv3o6e+N0gF116nAxLm7Zk3hFlfjS7ntvV2rpzFRklw5G
         2FRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774097488; x=1774702288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+SswpHsy2l3f4a/z1vwtJkiJzjDHliDjFwFnaZVO5XY=;
        b=W5uRmycIixsJgfaSPVO2Fhv//7k9SltVksAryG1PUDF+eL1ATG3nbRBtYy9mSVnUAw
         T4nVChbYwuwXtjXJ6GQqhXuaaDzG2E2ZDir7GzqA4bZWvCAKnQqKObHqKS8zuwC8x7Ci
         SLQtZ/Z95WF7CDZmGHCZGyvNum8R33rCIA8h9Mt/nVFjsXvYoy9mplB87iXePPWtU6HJ
         j8w8S2/SDJCetFQlL6ynHQwoevt0VpsnCXzzKwC1j1qTHe2KLx4QieolS2b0drdCQDnl
         sSku+H/9g//it0jd3OwTO6gAm9r39b3eERtICeCFIxfWt7FitZfdlvR/sIcdvoK8ygcW
         x1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774097488; x=1774702288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SswpHsy2l3f4a/z1vwtJkiJzjDHliDjFwFnaZVO5XY=;
        b=L9jxNPbnkk5PncWIDXPHu/rILqnwsbcV48kspau3sMUb+vQlftqy+HnmQEDUbAYyyW
         WvWVguTApsM6KDaO+9pybTDnVUK+aLW1tKhRYCRJnUzHwZj4W/8vPGcj8NGR36PbYl3J
         nbTrTHZfBiS585zafx1SJJSbPQ4zYz+PQcuNc3MPm5Yhg0YxjHFP7R1eudUddxI64rg1
         gsZ9AuHh3h8/IDo/friOO7yGoiBA59ZmH6XLKRgV/MterNOA8o/j1slgev/bK2SsDYwD
         VttDbYkvaKCL8vSlFLPsAhhsC+cmiUGRgABcQuZBK4fGWxriXb/lMd0vxKQOSJpBj5aj
         25jw==
X-Gm-Message-State: AOJu0YwSLCbsOt86cXceMVVzNgLsSb00rje6KvoRL57l0xGPJpk650TO
	VspB+bKDgiGqrRQAAbbccWa3jyEBeJdJ86w2Uqxa+HRLY1aYEOEOABODOf23bOfe1wzo65Taxqj
	kG5wy2pOcAFyFnIG2GcFAbbZZRYsTXoQ=
X-Gm-Gg: ATEYQzxB5NC57S1nxeP6UsyHGT6TlOn8vHsHNXNLquSMMfzh3O5CDJEEcWcDfF8v0Rp
	agjKtQFAaX9Rej3iY2tWoumqzyeHDn0F7rC+KPVOXn5i6QdCDY6czVs+YS7i6rz/H5mR96QenFs
	w6pWHMPyeWUoxNCA4Q9tLZrFrCpBhcAja7xJ3tLjwgJR2W44gXVeVEMXzZgNHSYK5B+uyQezcyU
	2VexvXk5XoWcFkUiSrHyV+9OIylMyJcZ2qqujmavMP90DwHDs/R4TBmuVvAM5J4uHPq0v/qduWE
	ZXnSIJLp4iTXgwbfZRhi07zjp8gdzJsFajQOzHrFRUa1vUS3pxpz
X-Received: by 2002:a05:7300:3215:b0:2be:833c:14a7 with SMTP id
 5a478bee46e88-2c1095a50e2mr2900519eec.1.1774097487838; Sat, 21 Mar 2026
 05:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Sat, 21 Mar 2026 18:21:15 +0530
X-Gm-Features: AaiRm53T9v7ec7W4MDIKSUVMfpJTHDrGVwCS0f4DX7lZUS5VitYHX_iu5ed6S8w
Message-ID: <CAG7UgESk3Vv6-2f1-r1xnHGX_KzNEvTZCxPHhz3-zbSVvyktEg@mail.gmail.com>
Subject: Re: [GSoC 2026] Introduction - Abhigyan Tiwari
To: Abhigyan Tiwari <abhigyanph@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Abhigyan, welcome to the Git community!

[1] is the GSoC 2026 ideas page, but to submit your application to Git
you will need to complete a microproject first. You can find the
microproject ideas here [2]. I would also suggest going through [3]
and [4] before sending a patch.

Best,
Deveshi

[1] https://git.github.io/SoC-2026-Ideas/
[2] https://git.github.io/SoC-2026-Microprojects/
[3] https://git.github.io/General-Microproject-Information/
[4] https://git-scm.com/docs/SubmittingPatches
