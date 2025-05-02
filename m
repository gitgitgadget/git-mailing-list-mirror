Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D318024
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176064; cv=none; b=d4PNEB0tdqfirIdq55Kj2xI6CEZ3Vx5Zw3VubsiYiCwRrz+X6c+gaJcioAbkDKUIWV4XOSfEBcC9t8SdsYo+vpkevLAPKR3NNOMIm2rfV6QfVFkxsY7Rux+CkHhXipdtWDtMAt1H+PI8moyElwQohELjE+kjFCkJCyYT8c9USAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176064; c=relaxed/simple;
	bh=pfFTCippbSHXUFQEmLVo7Wz1bn6OgTRGLun/ClHCt7U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qmkhjehZFTnNIVRsLv1U1OK4VftqaFgBgc55oEP30aUuvIE2i7DwRVGYjvOKjMB4n9biW4A0TXMRR7PbegdJlhxeByT7R922+RNQ/MpwUPW0RsuOqXZq90+jH0YavO9539KKn3RDNEV2zqOB/QkC6uDDYBFjKY12SlRjnSzoucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeNX+d49; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeNX+d49"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f728aeedacso2666369a12.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746176061; x=1746780861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=obTCIOXTeHnFMpiFMK5LteMBXhl3sjJY5n0bb21wckk=;
        b=jeNX+d49B4gWLBXD7XXS5ffi46swfD8F7iUu2yHxnUcDKKPl49QzM+0izaZSYzulHp
         7DigJ8/mbzSlM9UU1NrkVSCa0tlu2wd/Ua6Meqmc8M9z3MmHba2I9BHO9PdKPhw7tVN+
         ysWMwNot/rgxDFY90UBnfNlDkJsA7EDPqlMIlUDa3e5SF0wWLkHNwuOyosyrRFejmhSE
         4UcnxRhWoASyxx8TXfKyLZc+hJ0gn5MESt6apAa9IHXqlwlmA0uFKV7B8lIKU6d/0rk5
         rVDMDpNDGcxuPISH0F9p3ZIQ8kZnZvTbvoMoypqyIUQmVIdU1Yg1R8Cfoo1xaijcavpD
         vi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746176061; x=1746780861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obTCIOXTeHnFMpiFMK5LteMBXhl3sjJY5n0bb21wckk=;
        b=u/ZJG267v+jctQnJsAnjRBQokxgGTxpmLIGbzZ4AOArazUf9NcI3vg/SeR+/tZJj65
         gtQstFa0+UPuLOlt2YelBnSVKz/bZSERaUPyQISKuPxkv/AJfezF/qLYgwdX2UvPfK8J
         Qj3SWYc90oYlFs70G/RdTmoHCQp6PFJFrcChRcMnHWHFI55ojGEcNgCBbvzdlnNWysvS
         UCUXRVw6hImTxatcQyNXaK3S10fDV+XsAVVQ7NzQ+o+DIvvJZFFUvl7N5KpDw2vCSAdl
         pgW88FmYoLtGNsUsNgysm2hWYkNZavBn1YL7Ke2iXpugeHegm/fKm0Tt21WthhNJ46C6
         Y5LQ==
X-Gm-Message-State: AOJu0YydNIG1jQ2IfiP9P5EOEjphfXtnOUpwWpklwFxhnlYrAGs6CsJ4
	AyDyFAVHna34zRWzIild6/Q4uHSxDDQw6dAiMzPwObTtQpuGx7kvZ0PYlsR3LiQyt5wXEQfVNZc
	N4/1DA5TBcftYYhuhsskm06bf5LIraiMC
X-Gm-Gg: ASbGncuzukU55X/mJSsudkUxliokUAbrMwrsnTEcU7u4Ugi9O3Cl1kbqL6/Jtx+AkYp
	JDTkxOJ2fbzTEznQ/9lrE3fsw8BooCQ+omRqC3+UGfHwQy7x0yi1TyLzXO+Qunsu+uACwHLr4lf
	OVnbbTJ880vxUYFtB/JiHKrm1zqxDKxvHImI1HqrwV7TkjLQZdjQo7JgXGHBWn4UCI
X-Google-Smtp-Source: AGHT+IHiNZxgcArt7Lsulpiq+hytLJ+YpC+5QaXYnwsaj1bhJVMy/ZIvO2RhGRsufcwr58pu0UG9gbqCb8/W0bUsFI4=
X-Received: by 2002:a05:6402:5192:b0:5f6:2758:149e with SMTP id
 4fb4d7f45d1cf-5fa78014527mr1508466a12.11.1746176060802; Fri, 02 May 2025
 01:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 May 2025 10:54:09 +0200
X-Gm-Features: ATxdqUHsKsKx59Yafh_bgyzXA5u9gJgSIbPNi6QvixAZi7AKbiKy7dPri3sI1cs
Message-ID: <CAP8UFD2umn8xr1yYKGLm3jcZv-s3OdadjNe3fEkp1x8G9tJ_Mg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 122
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daniel Barkalow <barkalow@iabervon.org>, 
	Catalin Marinas <catalin.marinas@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>, 
	Darrin Thompson <darrint@progeny.com>, Patrick Steinhardt <ps@pks.im>, Scott Chacon <schacon@gmail.com>, lwn@lwn.net, 
	Luca Milanesio <luca.milanesio@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Lee Reilly <leereilly@github.com>, 
	Bruno Brito <bruno@git-tower.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 122nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/04/30/edition-122/

It talks especially about Git's 20th anniversary!

Thanks a lot to Junio Hamano, Lucas Seiki Oshiro, Luca Milanesio,
Thalia Rose, Elijah Newren, Toon Claes, Lee Reilly, Bruno Brito and
=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/775
