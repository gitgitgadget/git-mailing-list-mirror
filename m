Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4514EC73
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775278681; cv=pass; b=SDptkM1EDjZQ/rRCOck5qZng8R4RDPd/8B4ATwHNBCJQX9nZTeCegs/nX3QnXqvY5JTJEZVNhVIsgXBcw8orDoTy8LF4Zi/gQp+UEd/E6dI4ReNXE/lBy3VMqQwXMcY95e0CYLu2PFefcLc3+YxDCq5nW2F0rZ3T6HKq9a2iEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775278681; c=relaxed/simple;
	bh=9akY5qB5dwD2grCijIIn2kwo0E7Ewuo+0uCXSYGrOv4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LJYSa9eCohw61QvEfmRWYWlctuYKdcF78zkm5Z0MWdePDO517gIBmmUq0AQZzHQkaV8enYwEzO/Ipa7HihE/pIF88EFpvDCq8MOpXHmDG8wYXAAONoOLnFw/WgotemLVNNDsd5wh7vREOhLvQ9evCB8/TsvAlguwLHQzl4J9WeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEx+YqAN; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEx+YqAN"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6058ac0ebceso1586023137.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 21:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775278679; cv=none;
        d=google.com; s=arc-20240605;
        b=Q6sv4dfZjHUe+Mj/fLr/WyuUKJ/7H4WjYZ5Qn9AuHxiiQbeYdJ/L3rgRGl856SFctK
         PYN4vyVyL867t9YhjkzyT9F4+a/6HprSyEwM17toI3Xpk0G6mwa+TnnHrCDhoNmIw37h
         zrPrNNESA7xvC9Z6FdQXQ3kFMuy5Ph1cf9aojoLQYK90dbrvGEu1UfqPBapfwnJlYRrA
         8M94GLFJQfjsbahyLu1fsZLivastEaVg5h9Z3/QodTMLPGwDdzUDoTOwCU1Hf0PxHo5F
         g9BJ8HRL4w5VTRzDjTCwsfsk9A461+vPmWYlDWMzTdYlLMorO4X4KQIwG+9C2VChPf9p
         EnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9akY5qB5dwD2grCijIIn2kwo0E7Ewuo+0uCXSYGrOv4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Y1Bjd7/KmBQ4o+0fkoDQEkzDRylvBW/+HH9tN/SB4pTMZNpinVrFJXy+gObnyJYrC0
         T0rvM+0bfLbf16OPH1IQRfpvEfhygr7XtJDygpK3cpaEvf4Uc2nCXrSQueCCsOcXHTBm
         +5ig1FAKUquHjmJopN5fmVu/zAUcuBwVCS+h2fRpmC2A6SEuHCcE3V1VKq6hB4b1nhB6
         gzLozV70vYamQ0sspVntQModbmGnF2jPtgVswJKIB/yC5xrGs+BFTrWv9J0o03san1o1
         p9nyVqDCU7eR6Dk5dqCTI5my8piGSADbZWU1gIFjis+CzeA5HffMg6uQ1j5/JRetX1v+
         NUcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775278679; x=1775883479; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9akY5qB5dwD2grCijIIn2kwo0E7Ewuo+0uCXSYGrOv4=;
        b=GEx+YqANO5m3vdWimBKeByq0dDHvqF5UST0RGSGM28mgFNauLRRHmNUBog6kdh1L15
         74gDNiKjlwYzNkEATIK/FF82powyW74j+fBRg5zq/nOuJ82l7jY/dY5crLpsKsiJs52R
         DRkwBQqtqfpI5JnaI6EgQfxNSIve+9Tkoob6mWOH6agPnXGxok4pZfbX/+qY4WP8E07H
         Oo+Wq4RLMSESRysOlmd/sIXKfE5uAJwWPdbzmm1hR2+T3l1jXlVwGwZ6hFlcMzqs0Jlj
         5iRHCJoRLfZvAHiP+OhpCbgMmVz6qLojI9sQ2WMIBoauFOzcWI94Bk3/EgolfGg11TZo
         9XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775278679; x=1775883479;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9akY5qB5dwD2grCijIIn2kwo0E7Ewuo+0uCXSYGrOv4=;
        b=Dw9QJ2/4RtzCrvyirdayJ0YTuRWyR5Tq0UxKV6G7Kborf5FJ8BpE89aJ39ISjU3X8h
         QfXcs1rUQ/Tot3ki1lSJNc9ClN/oH0EipnaSQyuYh0O2aq9J1u0NlMMJV9uaUBPYUs2x
         MHONx12VrQau1Z0rDdTg2kwubaEboY/RPhzslwWDQHhVmpWVG+s7gk9MC9lUplRf6sJ+
         jJQW4xyOAQZO0mNeI0akYX1WFS+dDNJ0BbiEnbkZB08Ng7694NH8fatCVdFfMVInvQ0U
         H7YgfaVOqBK7lih7gxVjrxIo+gAdIEuk+9cJuNKcj5AaKKoTFWDUYaHmQ8a9LBv6vhem
         4nsg==
X-Gm-Message-State: AOJu0YwKTvcnIiaUwJjoGAdji1SY13jXIHqtjaU9956KzHQLMBB9ChXS
	cpIjV7uCIsiC/r9M8C8mFlfFVOoqbrgVFhSLVLoiQgo0mwrNZw6Dl8NpVm6FQ7VfNsTQSWaYLoS
	JoJwgiOGI46ZAnjuYGAhCNKO9Uk9Ht+k5uYyimbA=
X-Gm-Gg: AeBDieumsPHTiC40lFkunoSGFWbD33dALFTZWEjVl7fRH/u2pgCUFJdCPMjGDUXLxk0
	ZGw4RB90xkZUKyHBFuiYAxWmbw3zoryhyF40qiq71RYHqj05NTKSFgD8pWe87AbiEC+0y/3EETn
	lpOxXVCq4/v9+HyWSsopyAs0XdVxasWu4GJxzokYIc/tA/lmjQLtsOcZFBUI17z5asec0PGv8r0
	2AAImPLK31F7lhaeP4WZEFWRb7Sq5VrIzJZLYYrGZWvHl7ZSNQh1j6Le4EmJIB7rJIss+Qss0o4
	/WH6RczkZjPuG1mUcwx8H69AY5Ib7DZvIpIBnk2F8MbvOJSddtp5is0nfhJ7fV0HzNcveVIFqt1
	aujuPq6/OAkPzluVe4Y6H3kwWJKhB1Hq02zELgxHFpb4g4ivwWpudn+nZHp4T7BRtAC+dhnZHaD
	hZpLUG
X-Received: by 2002:a05:6102:4494:b0:5ff:fbe4:8ac with SMTP id
 ada2fe7eead31-605a50085a1mr1928940137.21.1775278678927; Fri, 03 Apr 2026
 21:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Sat, 4 Apr 2026 10:27:48 +0530
X-Gm-Features: AQROBzAPbIPMuacCkXX4e2IH_65zzr9aFy7yY2lfPaAg0Po2rEvaJchwOzo_UTA
Message-ID: <CAOAgETPYmCr=1UudOZdphjShp-kFabyVJo4sxUkXiqSBNoT5gA@mail.gmail.com>
Subject: [Proposal][GSOC] extending git repo info with additional path metadata
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is a follow up mail to proposal for [GSOC] "git repo info", it
seems that it doesn=E2=80=99t expose some of the path-related information t=
hat
users often end up needing, like the Git directory, working tree root,
or object directory.

In practice, users still rely on "git rev-parse" for these, which
feels a bit inconsistent given that repo info already provides a
structured way to query repository metadata.

After looking at "repo.c", it appears that the existing field-based
setup could be extended fairly easily to include these without
changing the overall design. The idea would be to add a few
path-related fields using the same getter pattern that=E2=80=99s already
there.

Before going further with this, it would be helpful to understand
whether this direction fits within the intended scope of "git repo
info", or if there are reasons this kind of information is
intentionally not exposed through it.

Thanks,
Arsh Srivastava
