Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85863CD8CC
	for <git@vger.kernel.org>; Sun,  3 May 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818550; cv=pass; b=TI9FeDmWWJfxmim6VdNHLFB7otwm7fIIfxveUg6M8yNZN7pGWMIRzdfIJzHvbj89Kl02SWlWMDhmkfaAavmzJirmhaUxvTPCu3otVfubH/EtQ2weCdoDOW9uQJwAmbR04wPknMb/RZ+vg2JNeW6TlQSQzkt8++he1PyA0XVuJiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818550; c=relaxed/simple;
	bh=G4n7mktJNctkF6nmvIQWRB8iyONt5YjKLnLWbYj2p+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kViVS0Cdy4ZKoVAosmdjMgVWkTHxgFwMHOfBJbOBUxbkvz/mov36Sz1xyN+9rS7qVNu44Gec6WcvbETgLDbNyEJyagtxt+qxXzXHRAfIi3XiLKEnF2mqRcnFf+uruRH5f8v29NgOtEujbvhhkr0AC4rU2SAAWcaVzsxmWC0v/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwrCjxaR; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwrCjxaR"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d85152c9so1081634b6e.2
        for <git@vger.kernel.org>; Sun, 03 May 2026 07:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777818547; cv=none;
        d=google.com; s=arc-20240605;
        b=N+nFxFdyIAW+vaGUQyxFyTWf4zHkBS93UcEyRJ/U/LX4R67QnH5DvhlR0sb3L0PtTi
         wsyEG7A9tiTH7eFlctZS51GHXohm8qncMwp9halbAv6UVSHBpA7dXWP4UEy96/7zqMcx
         h8nlwGOx7ofEq2e5/V+Ujt0ZX/86wv7JM/DDX01IQFPnPfVIkoZyxvCQsnIaivvu48VG
         nVlBqBh2ufmx1lQjlg8VVqMr05EbM5iZBQCOEdPXqxCKi6ql13wu+Z46yoKYU34mAJM+
         D1odC0i5kx2+2mFWsz0/WTyKs6UFwuEIOS+QPganvCuYvP9guNHMSbIyQ5UWmFUPw1l3
         EZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=n6tmCEMYY0K6dRm87IOToDZETaV/f+jRsEq3/v8OKAI=;
        fh=MuhPXroUYsQRT4srYQaCPZ4N2V26P+p//xK4VT57afs=;
        b=OE1TPhVlNWAppBAaB7TeY1DXHMwOsekrqRhAPn23QyIThmckvEiYPXDDybbzELmKIF
         nAcfJeR/0wxX0SM5fuVB+r12+aJC5uFE0UyHqg3GVZ6lrd3UYb3p2nf0CpXwctHtRU7I
         L8XFNMHNd6BIUScbpfeRJeiW/O/Hx9WoXFZh9u3VV6Sq/s5+anJze0RZJrztTTwMJGlS
         TH3PUjRPihS6batmTtUhgY0f4Xf/TP5Vc8FAB6KELuPt3UTpT+hkFWvZtQrnaGtOkUg1
         FXTqoac2IFCY8sDB3+aMxgjAjFq96Ox7Pp2y8F5++Mo1lxUhbLpsrZhSAeomM8iSCuNg
         3/Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777818547; x=1778423347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n6tmCEMYY0K6dRm87IOToDZETaV/f+jRsEq3/v8OKAI=;
        b=gwrCjxaReFHUhZsQD0+6SBurkEl7CA9WnK5FR+iel7qObMK+oBKSPpQEzmJc+sqUDJ
         QqbMNG9NsdIGU0fppas+g33wjnEZv63UhkXHwnH7gSDtb6LdriTNSlYASHpZpxOlU7UL
         8hqIT409JgrSjo3As4yhmCk0BBeHcfcP107FZZx855rBp8ek/lZ8pmDdPc9UurPmnVTy
         9V77zdI20R2QoLDP4utz+ofgFBqBKeDpO6tBHGhXac876fCpCyqKb5/CzK64629dSArQ
         mEaZbgbEdsSiTNuhsa4qBbhEjy1mfBahPyN/8Q05Jk1k/m1Z2oNGuXLLy0kg7pYUgnoW
         Jacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777818547; x=1778423347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6tmCEMYY0K6dRm87IOToDZETaV/f+jRsEq3/v8OKAI=;
        b=QRoNqrUh/BsByIDgAmzbnebz/UMwtcfuvvIylOWnfPG+ffaJINpOpjBj/7IM4x5t5Y
         LGOmhRTyWb5O6MySLpOSSHSSsb4ykBHEqZghVYsbsO8tOKeWuY0T6m1ehpb37lDUiRM/
         LhlVmsMZljdkVvFhtAVlLCn224ixOlmCHb/WeTFy2MeKrHzyFN2zsXo7Gc0B+og7QUbb
         di/3KBrHTBK789bdL4l2ZFCbfF9xEtizBmZrVmeAkZgsCFbGHRXFK/NbmOQ10Ml9SdLX
         wOsXCjiqcTngLlCF5vFkAK+r9p0mq2qFtG7edJK9+/rrDgFPRDi7ZEqXLHwKwB9qotB8
         FBUQ==
X-Gm-Message-State: AOJu0YwN31npmsxTD2xMSERiGGD116zkBhsaSLdMJiRcShus8kn8J8bo
	sEcVddgbLqet2GPGNUrbN+xrybq0fsLC6B7AINkMn5+su08dmRcK7dqZX3GDO8C59sCbHOlmToF
	FXO5MQi82Ejfsyzkn59JRiEaOPkvUvsYfSY70
X-Gm-Gg: AeBDieuaOfzHTCPGlhsSzEt48jsPKELcimAhpi8+LiKpEdhbZwC9W/xL5QmHwLlgKuc
	EvnP05LvaaoAZW6ZYNUuOXUfXEhuIU6Cwd2WHu+rhvO/6QjFYKFlu9XpaOjx2vXti5xhWhgo6ni
	eBS2XP1RF7Wo981kCk3XjisF9nwcwJoXUJLEnIAoVKWwQewcd+f5iH4PdUzG6oGfcxgRDRS5yPk
	3CkI03I8Cddoke1G4UlNq6gOXQh3NOMGGGVynytAU5kFbvJZrtSwwkRbO8IKjyM22FviQjvNGP0
	n654stq0Bbg7hcZL7YEMBGpMWMlHIi1Q19M7FshvbMvWdasvooHyTV7/Rcwm
X-Received: by 2002:a05:6808:1b0b:b0:469:fca3:e611 with SMTP id
 5614622812f47-47c892459edmr3178438b6e.28.1777818547430; Sun, 03 May 2026
 07:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Sun, 3 May 2026 19:58:56 +0530
X-Gm-Features: AVHnY4JVo_SRfx0QusB-D6JDdV3CsR46iUPwwvK_N7u2ab7Ht0gdEcG4sQTe2Ik
Message-ID: <CA+ARAto8ZLSu3oFS1QaOqc++Dm+Wb35EqeBo6JUJ5jVG4MZNbg@mail.gmail.com>
Subject: [GSoC] Welcoming our 2026 contributors and thanking our applicants
To: Git Users <git@vger.kernel.org>
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, Tian Yuchen <cat@malon.dev>, 
	Christian Couder <christian.couder@gmail.com>, karthik nayak <karthik.188@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

As you may be aware, the results for GSoC 2026 have been officially
announced[1]. We have 4 contributors contributing to Git this year[2].
They are as follows (in no particular order):

  - K Jayatheerth

    Project: Improve the new git repo command [3]
    Mentors: Justin Tobler, Lucas Oshiro

  - Pablo Sabater

    Project: Complete and extend the remote-object-info command for
git cat-file [4]
    Mentors: Karthik Nayak, Chandra Pratap

  - Siddharth Shrimali

    Project: Improve Disk Space Recovery for Partial Clones [5]
    Mentors: Christian Couder, Siddharth Asthana

  - Tian Yuchen

    Project: Refactoring in order to reduce Git=E2=80=99s global state [6]
    Mentors: Christian Couder, Ayush Chandekar

Let us welcome them and wish them a good summer of contributing to Git
via GSoC!

Thank you to all the contributors who applied to Git this year! It was
a bit tough to choose from multiple potential contributors who all were goo=
d
in their own respect. Hoping to see you around continuing your
contributions to the Git community in some way :-)

Also many thanks to all the mentors who were willing to spend their valuabl=
e
time mentoring the students this summer. Very much appreciated! Special
mention to Ayush, Lucas and Chandra who were GSoC participants in previous
years and have volunteered to mentor this year.

[[ References ]]

[1]: https://opensource.googleblog.com/2026/04/the-journey-begins-meet-the-=
2026-gsoc-contributors.html
[2]: https://summerofcode.withgoogle.com/programs/2026/organizations/git
[3]: https://summerofcode.withgoogle.com/organizations/git/projects/details=
/O1nF3zMT
[4]: https://summerofcode.withgoogle.com/organizations/git/projects/details=
/752yzmwm
[5]: https://summerofcode.withgoogle.com/organizations/git/projects/details=
/hs14IFAn
[6]: https://summerofcode.withgoogle.com/organizations/git/projects/details=
/Lx1PmL4k

--
Sivaraam
