Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B749460
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231478; cv=pass; b=aY2lXh6a68J2lucIArWgeKokYGf+l0zoFAvEFzXU659ufj+ycG5Im9fzkfWbIzPaqwCUf8+WIrr5LnGjAwVCGApMlF6i4e6P5lCfYLD+7zpJ6kLlk5oP45Odk/Cu3IhUc0Y3Uc162iCQ5kzYd9ZsW72z26Wcmwapqe3rhMg3wbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231478; c=relaxed/simple;
	bh=WgdhjKOtCpMDf8ojiunfCJHTfM1c9SdbG2tKQVZ1N1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=detRVjEb2xbcxevC5UZsjQyiMr/ki3xt0XMyTUgIiA2cIyCf/yneOXTfVZNIrgRRNGfeMue2XnxlE0MxxYCGcwYUzaszPkyHAp9NIydWh03qLaoMPD3V5cVOmEj6yBuXdW9KiOGqBj+r2zFd3/Ii8bitW50Md5SLgN4sorgFmsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwaY368c; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwaY368c"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so684298a12.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 03:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792231475; cv=none;
        d=google.com; s=arc-20260327;
        b=jw2ltpYvCZE1pHr0dGC2JPZtOotOza0wwlIeTrA6nt+HqdBFMhaksT9aKN7GTdOAM3
         RMkY/lu5vAmJA8MOU9ZjvBWtlMeao/8YOKkeS32rlbWJWpzyC0MlS0JKQyZA5pK7lbBK
         VZOeNlBAHnSGlXZ38u8/Z24cQJHqATOWcPLL9onoL/lqapAJ/eaKEHJnEr7ZrCMp7TKA
         8uUOQ6tJilK0WbEqsA7xGg+IgC1MIiOuyQrKtW5uMZDwaGx0a6/21WMtckCKoQJBc2iI
         4ec7FQ3qFknrd09LcASsCUqckoHUX0cqqNr/Nh68ISDtiGzTw5ppcK6UpMVF4C8SiwVf
         1i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j7JMqqk8lh2mnWL02uYzqxHUbXHBR3U9ld2f4ZKjeso=;
        fh=MfKE5BKBgni+Pd7PLNyQ4LFOjLoHhRpBFxMIddJ68yA=;
        b=VRFkIAvk7RGZgGU6ycMh2ccBRX631Nlt6hRfhqEa7u/+TzlxHPii38Sh5S5+7O+OzU
         pknYxmYQFtBINrEJj7npMArClFJwmm8Iqg64XzCK+CszknUA9yltXI2rlnP13vpF30zD
         0gPB/jtzv87pRqs0Ju+P2xnP0LfcA4OIoZlgGxSikZ854kBa7dgSzamc3T9/5L1efqCZ
         fUS+WJo8XVP24aZ2v4MW/Y4f5lyMReyvOO7YqTYyPcvAEzIqaru3oy9jtVm7TJqLuzja
         dHFPxrRPjErI7gG0hW6xnYbHgs8Bo27kEPLaT8UNRbJNPORKJ8lSqf8qNr/9D7ziRZmQ
         hfwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792231475; x=1792836275; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7JMqqk8lh2mnWL02uYzqxHUbXHBR3U9ld2f4ZKjeso=;
        b=rwaY368c8uABNOc7kJMJnbwqEf5+ELO/Qmr7bATQrVOfd4rqWHbg65d2bBddWQegUv
         MCbHBPeRCX+j6eVp23qu97SznI+P+z9PGdq5hMOPz2NrFT9CbGfxBl1M+irvCrlmNmsY
         cV9+HVq6faRXgOeKWWRQz+u6HI51iOIEU0Tj+XBfJvSE6wZbY+vz2DD/GR5AyX2l2aOy
         c/1fLcYwlS2zIm9eerE3UYQTTQ7Xu7hqP2jSduHlvNGd7wqbYFq70prR3pkM7wCyJNN5
         Ajgvtpo+Ulu2BS9lok25Wo+QrHCYFM76VmJnGNMidnggmSfyNBnD0hapuW0pt9DwE1kT
         xgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792231475; x=1792836275;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j7JMqqk8lh2mnWL02uYzqxHUbXHBR3U9ld2f4ZKjeso=;
        b=GBnonrWF+G4AhfuSCQCceUzvE1o4zDLufvxMky8WoKCWgXnB4BGZeLHGOFxR6PE3Ie
         a7m8CQNkJUwqUzruFi059V225inc7IOy3hE62SUX4iSxCGDIRSazqFA+gSUEMryuC93h
         NM9wmT3fiVGTNFLJp7RcDl+aQR/12SKmWYTSmWYTN+KdZq6eAltNtYxSuHRQ1T6osDgr
         RH9jGeAg2l0Gzls0TQvREcF7C1W0eGJ9dOGMN5rQDc0Gh0CiA2Uvv6kZznIGxS7vdnZQ
         5vyGK/8Y9WVhgZ5tfqQy5FYynDiTjPA0XxB/R4QfeCyksyY1VMIvjLFgPXHtRGYjTWsL
         d1GA==
X-Forwarded-Encrypted: i=1; AKwUvBxOAs2HbK4kDNnSRj9d0GpJQHePpgI1SACcHQdPkD8Q84CoOGI28eQmD+EfJmkbAENIAho=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2blt28wU73suiPUl+LCwoP42jy3SMqdFp1mtd8/c68ns7Q2gp
	D3szJ2sa5yOgMG5IG7bvU9p1DTUJPTqi1cq3FdthF55Bz/+0Dkl9YI+ax+5FKj9xWKfmV2mOiEh
	Nphz1tEio7g8BTo1Qg2A/u2cvJjgoD4E=
X-Gm-Gg: AYBFou2npRf6v9ITjQXz03P9aEkCiFWgGQd1kmK1CHXc0w7o3M0a6BbT7d2sE6Abum1
	EbccsSByTYzPkCJQ6x81nkXwdRuPEawnzCt+M/YxGBeCJlZTpdxFPtoAtPZLewidBy04iDynp/G
	Xy2DEVj8voc2oISTZp7rnTKmQkN1ram7+F1wsfijrq1fAFrUmjx0jlEcNT5NH9CaN33aqcm0QFH
	4cOfFmTbfo1EOSivw9GDyDRGJ8RwPETAcYKpADralanmCazMrzAek7tsLZA5XDXKQ//AvqPK4jZ
	Nk5NLgje7Pgej6JsQRXA9hERGEP8T9atOyv3wh0GDWnwjZRkDyq6kME=
X-Received: by 2002:a05:6402:4344:b0:6b1:c774:58c0 with SMTP id
 4fb4d7f45d1cf-6b3a81995e4mr1304016a12.31.1792231474841; Sat, 17 Oct 2026
 03:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com> <CALnO6CDOh1NCp4Y9euLbhVFJJnOc1jSk7q0ekdUeGniG8LTCGQ@mail.gmail.com>
In-Reply-To: <CALnO6CDOh1NCp4Y9euLbhVFJJnOc1jSk7q0ekdUeGniG8LTCGQ@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 17 Oct 2026 12:03:57 +0200
X-Gm-Features: AclHuK_5g9NX5g295GNRvS0LTPOvEaR1Y_ilcymNAugNc-CMTWyTWcOh1SO5z1I
Message-ID: <CAHwyqnUd5NwZMGYQeFhYB=PiJ-0peA8hSJezJGyNorDM1hzehw@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>     $ git reflog --historical-branch
>     4e5f6a7 HEAD@{0}: (topic) commit: add tests
>     1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
>     8c9d0e1 HEAD@{2}: (main) commit: fix typo

Thanks!

This is my favorite then.


Harald
