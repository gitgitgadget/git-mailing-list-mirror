Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02035C1B6
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261267; cv=pass; b=SCui5ngjJ7IYcf+tICawsRoz577Gag9TlJ2qWZKmzTN0s7BR5ljkii/PtwTlYVmjIADrElnfdqdmfLXkRI91gQACceN9WoYMlN4oddL574MCrzhqaZkBh43QHYpXbW1OI8VoqR6iODX/tT9p2wA5AK+VBEm1Z3hKDG/EzEuwMoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261267; c=relaxed/simple;
	bh=iDMJUQQKiCHoP5LTGqxTfJYdlIuTPlwVudQ02q/SS5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PPosHUeivYsUlUOa1aRzB1C/Poqtevz4InxJiDTZA00ZRT1nMdrEN1DhtLFcSLEVIBs5wir6NImqyCSic0pJI3A475u8AmLYkZzIJj2xVTyQ783Q2XASdBcXoHQ2+w9HiNSdl5IHHVNYBjPzFBWPuBnjG+vsXfkNiyi+t+1NHXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2m8OYrF; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2m8OYrF"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so9469069e87.2
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 20:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777261264; cv=none;
        d=google.com; s=arc-20240605;
        b=KdynF3ZvLMvYP2q53eh/IoPw9TDf9byXSxWEbL5anUeFpEXR14k2uxMuf2kNxEa3Mj
         2pgBZUQ/tDudziooIqlqrbg4HXCcbEiptwZMCfp6IJauxibFE1KMDpVaSkLiKusTrvf7
         fTkVKvlMHGQzvvANN2F0ofFMUtYc2DVMeOe9lu/Nbc2CWOp7VVT81Vte6fU/x7Z06nYg
         JAyaiGSTfzyLbVtJFnEr/BJN4Yb+VrZ2qOYNzgh7ahscKSEvg1D4dQ5rLGibhYZcDEn8
         yqq7dAmCvNpFRvWQwtILYBYqlbe9xcbpRcfIYNWJ5Rx/UmnH7hv1pAQ34SFlktr1iJlC
         7QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=iDMJUQQKiCHoP5LTGqxTfJYdlIuTPlwVudQ02q/SS5g=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=i3lz60ocQpViv/P/CcFQv7slgaY+OadetRaTLzYuWcB7Uvmp2uKyRu+1VjVuz5Xicj
         DSv4BkaqArIWfHGyayUW1JkGTEa5tCWPJVb4w36zv7htIHzgU7cVKOouGLrRh5TYcQH3
         6gdflKc9Z5//46qFvpr0FnaOsFM6ltgPzQjTLpr8he19GDWHVbVlGokei0gef9Pbbwnf
         UrXoPUbDhkga63/xmb0kmgLbjr4B3bjGA+FoikrKCBm6ogQKkw4km5HLR89WTjTI26jI
         yRrdCsWnPLl7ZQuPMV0ud1WlyixhJ8KopXtEYMd5yrtSX7I3YQlGUJeyjibie4Tgh2KD
         NZJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777261264; x=1777866064; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDMJUQQKiCHoP5LTGqxTfJYdlIuTPlwVudQ02q/SS5g=;
        b=j2m8OYrFurbaxrkoMer/VKQQmeiTmcrAM0bK9VbgTcd8j4Ul6huxQ0+tr7aZuYi1is
         vzYKeQdttXXzYWpA0pq7nnEG8hlKAFFreLpaulQK3D6PvoTDHaPTkE1jOa1UFz/wzZRi
         ORsKKs0FB4AR80GtBGyUsYsvFUoyxVSYayILtH5A5oEYauyAkAzzWixC3EfRn3SyEOF8
         GDK/e1226gJ8OufQSLxPYcJr5S/Zgy6eVs5dogDwZNayZel9yYurrCyDbmgkd25QDvOU
         S4g0aF2SzKsTF5/70Se5e5pcwVMRvpH65/7RfEFXr0dcoa0WlN3nhpKJUGmg++hUEjra
         EsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777261264; x=1777866064;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDMJUQQKiCHoP5LTGqxTfJYdlIuTPlwVudQ02q/SS5g=;
        b=OYNId9SAB6sSnIukhO15RTy/VqCM7Q6U5mioW20xtdPi2M8D6x3RPS47CXzhlfZjER
         MG3oAHQytKP840JkjJc/zPvpxWRKhq1VsRZL27Ji9tnLXoo0J7U2vcnLMP/IPjeE4+1q
         ltAGM327Us7br8/8XjRKHqMc3fd/tA3AwUdcMrU7Bz7RDevYp68MM9wXyIXSaor+FxE4
         90eor400r6EGvHm5igjaIRiFhxPm/moSIW3PGxkLpiv4nj2ffaF2n9trgellp//E8Qh5
         A8b4lrMHTVIMl60nbjZpxDCHyL2QpUCLIR585vA+1Wf03VEaGGy2kEqP6jlZz6+YXCM7
         cBJg==
X-Gm-Message-State: AOJu0Yy6zNy0triEPkuygOVe0B++MLqTDL915DlHspQfwopKcUmy26X1
	DNBrJMm/FW+uh8jTotvXtjPrskS3R+le3INW5HbzWwxq54Odsx33wvqx+gIp39FJ/jRZJcsH8TL
	8Uh2cgPTlJgU4hTtaJoiAksGbGVRULO5unQ==
X-Gm-Gg: AeBDievvSHWy7US065Jgx8ZTtB0GZHQdBeMYzWUC670NNo1mgHxag3edTLCoxV+CIg2
	kNGnV/KMaCV5lC5CISWGxuSHwNzpA/gFK9N31bkmeZHZiFbK1Ag6ijnFYOS2vKUsyNWzZRnBwro
	cJPIajYBSkJVJDiaK/u/nMiFSXT/OQ/9mtIZ8gepTrAGIiXg9su58wuSde1coeGcip4W+dUyvmw
	TrEUwLNuLoLa+vPtkLYWr2qWm4BBvKGcjmTHbSt4t5cDNCjMIhLlt+QFQGPqTIm7DKuZrRIeRYk
	x2aqacKb7mo644SPiQ==
X-Received: by 2002:a05:6512:159f:b0:5a3:f0f7:7da1 with SMTP id
 2adb3069b0e04-5a4172cd17amr14983727e87.17.1777261264130; Sun, 26 Apr 2026
 20:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOZVFV9pKfDEG7ikAzb1yV8JcNzJ4sp_YXq9p1dPE2F-vKBO=Q@mail.gmail.com>
In-Reply-To: <CAOZVFV9pKfDEG7ikAzb1yV8JcNzJ4sp_YXq9p1dPE2F-vKBO=Q@mail.gmail.com>
From: balji balaji <baljirbalaji@gmail.com>
Date: Mon, 27 Apr 2026 09:10:27 +0530
X-Gm-Features: AVHnY4LAxLOpaZqGkOwOrfJegksJdafHNr0K4lru15-F1Sgqi1J6mFEZFX4E-VY
Message-ID: <CAOZVFV_yNBBtTU=NwL5E2QecuHqyq8W4Au46kwFRFh_fHCh7TA@mail.gmail.com>
Subject: Re: Doubt on post-merge script
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
why is post-merge not hooked when I use git merge --continue after a
merge conflict?
I was expecting it to work, Is there a proper reason why we don't have
this feature, can please elaborate the cons of having this feature?
Thank You

Regards,
R Balaji
