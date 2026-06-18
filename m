Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C03101B0
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786212; cv=pass; b=UjIcp39gyodwkMkLJ95LT+HxhMmaqH3gPJoZVCZPrp4l3Zn82AUlrqGH0FXvAslqeDWhXIurYZDpCa7uUqWQIpAjfQiSmaAVwG+ugVBU7X9BOjYYxLpvLJCcg5mEQg9SUBl+Y8v2G3Pg/ES6fcAygkWkuiMulnIAsxS3vS5FkDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786212; c=relaxed/simple;
	bh=C6gtxzBgmNJl/gE1ogbDaY/VKkRWXzO04ugBLFDgbcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o07bFXNQLvttAyCeTWMS/rSvRNQqxd7epxM51H/Vuq2l8jWOu4fDd+y5qpMo2s2ibJqe0QlcqN3uPRYfSWdCUvVi9iMIZW+LNOQ6V3VpR6Xy0qzh2M1wq694LOwtXxJ7bMkky9UKCge3C1oACCicqi6cHuYyOUSqf51lp8z+dnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLxGBMwT; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLxGBMwT"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-695427c153fso1139613a12.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786210; cv=none;
        d=google.com; s=arc-20240605;
        b=RXF7JRopZhgu/n9/1kA/P6y2mDtFGWDiSmKIDb71kJ3LtDW9XQ0xFzOttCY6VbaUq9
         9JFOsy/AJD+XDwTQNqmLVXZYSkbqGvRUkSrsYT8RCzygUGCJ7f0JCaKCv0nTyc2Ovfln
         p8NHHwX5NviNcnDruoBNnbPBUCJmz2kDSyxvfV+0agHFpsvHJtWnevuXrIExipl5j3ax
         ilJLKsP7gB1bX0NcpcqTJp0kLb8FHOrIfLOtmxcioZ88Z5kKibriDBwhPmsaDitj0nBG
         eRRRWONg1C0oJXLodg7swqi9ZVezd7cZmeRnI/aQsAuI35f7QOV2FhrRUvpNw5EoHit1
         hSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C6gtxzBgmNJl/gE1ogbDaY/VKkRWXzO04ugBLFDgbcE=;
        fh=UbHHmcsQGN9ex7IP2G7nk/5KlaH3B2BCRP688m5UAOQ=;
        b=LiwUpFzAhv1O2lgcjeDxWebvJj/DFqvkjuW/ThtxqbM6aLuKXJYWGg65nW6cbQ/ptS
         S44PbEt1QCS8ZNs9Z+TB/8iNnVaiRk6+mZ7YO75vQXBhh5EVXEyqfgRDJeRbck86QCcZ
         FcUBGmM8U4aGbLuiQWzLuQaQoJmkii/MI6TQTmI+XLQjbdaOysTBW7OIqg9Y5nFxhHUr
         IBz973vQKUrRWJACfJx8fxKdYPQbPOJbMOsIbxolq/I0JrRogjZztIOWdj00GTmrDYtu
         cKZw/EVFtmKvCKHIiZbnSZfFKAJqpaFjSdUAyVZmRnP7eiwMUepxnJPhvkTPlg1+qCQl
         Y5jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786210; x=1782391010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6gtxzBgmNJl/gE1ogbDaY/VKkRWXzO04ugBLFDgbcE=;
        b=fLxGBMwTb9p7tiFQLzZH2BM+wakd3KAYTWlGFDN3mg9drqD/f4J7j0mKM2sy8jakJF
         6VanmEVuqn/LyGye7wxgEyhfl8wHpyOvjwPys3KBHW87pfITCm1JlbHdTJuCFVDBQfXb
         P/+G8socmNGSjsssrD30ckjhZpZ2GpCmUrnT0eflN8Y/bKrTdCmHJA5bCfr/oH8O/Mta
         f9GhjzShlWaS68+16Dnb2qJ8mcsOr7wjGHIVpZVx31R8MAiTKx7b9YM5PudCNZwDRvZC
         325/8Qu20ktRP671jXrQ6lx5ZZDmRNtPEfrY9UtiOqx4NV5aWx7K2vKSijzdOu1oDSW/
         jM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786210; x=1782391010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6gtxzBgmNJl/gE1ogbDaY/VKkRWXzO04ugBLFDgbcE=;
        b=iauQ2cj5yCNo/dCFKfnhgD3iFacsTLp1FCiWe+ZEbD435IDMpdRzpSzKLyoL1NsdRR
         k6NoaCmNjwPcz01inuNoSzdxKkrj75JaE4OF6d5191ydVxhaQcGeOB9VlrrYz4So34Aw
         NaeTrEGlTFIh4OHGdAC3BBavUDx1WNdrgFp5og1v6W/ccs5HD2/hIU6mvQ6fIDwAAuB+
         9CHiMPiMU35lophBSojqOHVdcpzf6APutr/6M92ehZemufRB6RzOAFDcUYDxM28Imrf8
         dSpzMstG24S76Q2sLmOQ6I8t11agxXpSYxLzs0fcXdu6B9dqvNo7UqNhgLEc07Nm2k/y
         rNIw==
X-Forwarded-Encrypted: i=1; AFNElJ+4H6xt9gcZYXbGLYXSks4f1N1S9lcA3mR2Tz6uH+fZ3wzucmIFHYK+t92NVGydUDe6yS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDbrj5lGWnYDeyyfklObPnSUN5kJMQq+OOwAaaIvEKqlk1O8Y
	rFlgvVhvMBkLp3CkJT8nrqnYn3whvNr0j7XGNEMG4czcoAKtkyReo671aLe7L6hg1FIywYrKV5z
	5S9w064M2KLDW1NU3oMZhTAlz8rVnF5U=
X-Gm-Gg: AfdE7cnJxDBMOLkK90JnG/3u0muzLidl8wYGKiX51Y3H9jNGDu5qIBlwHAXYItYPpVv
	ZGGfHH9o0qUT8LSswEXCvHyN+54FGKh+gSQcRFQbDIZdU1gTBzbZ0lYQR6A2RhX0+PlYsvU42yK
	HqdMqFqRRq6XEAz7x0i0qP0nXI4/ok3/4/6VqKBxySCQOEvo3L5vX3sQW9stjXsUMVs5U4thnEK
	9yiCYFS3fwkY2AJAV+4PiNFhNQEqsuiJ7byO2492137MMIKRVCTTxQYuISzgIsRyt3AJGLvcjAS
	U//iLd0=
X-Received: by 2002:a05:6402:358b:b0:695:ec53:976e with SMTP id
 4fb4d7f45d1cf-695ec53a1a1mr1231610a12.26.1781786209599; Thu, 18 Jun 2026
 05:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com> <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com>
In-Reply-To: <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 18 Jun 2026 14:36:13 +0200
X-Gm-Features: AVVi8Cfekgsgv3muKenTDFMj07hwQRRExJXS92whBCWfDckRYONt8XMj0uBK_iw
Message-ID: <CAHwyqnU4xuw9ZDjarWKKua_s1Qywt07GyP1kJO2HM+XQTcE8hA@mail.gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ben!

Trying to shore up some support for this topic. How do you feel about this now?


Harald
