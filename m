Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FD38C43A
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830858; cv=none; b=ZLCB3VWRvzqKU5IKDS3cHOAAriP7+Hzi8U0ILUq4H5FTyBgRaOV/1+7Bc+1adbQtxgNedZvzlj88xFuovH2pDfK/5KFN3ln0k5utwv4P0E9I5uOG108Q+s9FpdXJAZkdR0MxKcIbq+HufbPE0hQsKeiH93tKGAJoJo3A2lVCxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830858; c=relaxed/simple;
	bh=eHF7TiKPQ1cqGa/FPYQb7nBzbnU4hLqWCpTKbq9xqeE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pihpRfNYN03sBi1a4EfOmxsrCYVlTzW8w47yYYiQfgb5SuIu9rdeKbx3o3GC5u2dZaxKCY2yU8tY9HmG4wLKULXM00nPDa+9UVIs9GrKCeHfe/mwpyUAGg1mU52eZq/QbomhlpjzysFGNReX1a4Q8z39R35duC5CKhrJ04gHIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9wVuSfs; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9wVuSfs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c21049dafso10116465d50.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779830856; x=1780435656; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA4YmIbpDD3RsQf1kAeqHh7fumNqIvCfBQzTtj5BHM0=;
        b=g9wVuSfsBy3fYQ2Oa338SAgWFKUxs996+mv44TXBlAGY4bJyO7i/y0LNunlAOfP2t3
         EV06ntbQF9qosZlzojZyyvDcnD+jlBR2a7O29S8j6C4FjWd93l3PH++loCRMOZDapDvg
         kvbvGus4qF0geHPaYF0MqUzKE3S1EXEDf7ShTkJeblCnSaIKf7n3G1+bHvMO0rq7MQt5
         vr9yyQpkd+iQR6qh1APN7JqyYz5WxlnMDru8EHJMTMoTOMsHDh9R0txE2eui7sOvkqun
         mebLWpYUGlmNGJbhdwPPvgVgOYZoh/lnT27n0lo8fdx//ehIj2049Fcgu0KJ/RvXQgEO
         XTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830856; x=1780435656;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FA4YmIbpDD3RsQf1kAeqHh7fumNqIvCfBQzTtj5BHM0=;
        b=a+UMPlJ8O4mI66cWwTyS0e5CBP7ZX/hpJJeuf/kZeRlo7aw1TNvtPvrb2o1aJxQYPs
         lvnh50x7cOcdJRElQpnEOC7WRONIobvgO5ut+dFvjhrqlcZZCv5j5e+RuTi0E/AwzkEG
         X2Grq+2wKkO/AkbcUoJOAmIqPaNAeiqt5F7LuBBmqwsGiTHaw4SGqTPmeS8GXKrThv11
         0YZSbsNh53+Vrp3/GULrVdYuPsonBMTkJ17OdRwHLQsjII3UT5J9ZOO5QmpurFpU6LUI
         uaNy6WzucZJbngTwllPHvu9ExpyJFY9rEEiJYAo6vq9EGziBbQOpONXtzq38GC1uiTzF
         JnLQ==
X-Gm-Message-State: AOJu0Yyi4X1+1qL8EJP9qAOBK0eXptEwXYXpVVFRMJQM/D7eMAz2fbUO
	A3kpIs+Cw6bWPg96sPABqaW6zbYoMMPpwT76YZTQpbbhnOJNHHLuopvO
X-Gm-Gg: Acq92OE7ZYrRnrCWMe4yClrvHzRA6jPHkTOhEIxNd1dDLWVThEcFsANHvadV1a1bUSC
	k3tZa4p0UGgS8578knqM/VStFsQJKiiMvJl4BuUme5pD5JLw2sINTxtluA2QTov8pLKXeaq2fGI
	yHYLVrOrFPCicIHqMFCDlebS5JLSRqp3p6Y7mJ5JS66BvVCbRttRnyEY291RI88Lrql5o3gKqUJ
	0HjaALOvj7wX4gBFcZY4np/P2e4IVoLnrJjVcCPLFpO3JLOPMABdX55FAPwAMVbD8DuakkJwcma
	A3426RMsZ0obYLF9+h32+2La1/oZAkDwzYVwA/SRGD3fxM2P9L4IjNCh/uyNCdbOIJDdCLwaM5x
	y2zcMaXOvW3ZzUMQf45URITDr1ZeV+wwOI6V3gHmwUCOkL6fq6PJVCMyMHjlDkRPi35vB2vTUil
	CPmmSbZ00rR7a1wMDAez6EkbnOgVfO25tVA5ddppWj/sK+c+033kZ/t64Rcn8Ywx4aQRp6wPUG5
	R0WY4RZ7guvqXY78+YDVZhwrNQWJMzxT68ZsK6rzTYR7kMyJg/pjpN6icasFffHsmU=
X-Received: by 2002:a53:d04e:0:10b0:658:a95b:894a with SMTP id 956f58d0204a3-65ec95f0e92mr15607772d50.13.1779830856204;
        Tue, 26 May 2026 14:27:36 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:f59e:7784:8709:5b6f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ecfdf4bd7sm6614879d50.19.2026.05.26.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:27:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/5] git son: add command to create independent child repositories
Date: Tue, 26 May 2026 17:27:25 -0400
Message-Id: <7377E3A2-C866-4E3D-85FC-BC6E10CBF8FC@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Evan Haque <evanhaque1@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
To: Evan Haque via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 26 mai 2026 =C3=A0 13:08, Evan Haque via GitGitGadget <gitgitgadget@gma=
il.com> a =C3=A9crit :
>=20
> =EF=BB=BF
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> When spinning off a new project that is related to an existing repository,=

> there is no built-in way to create a child repository that maintains a lin=
k
> back to its parent without the tight coupling of submodules. Submodules pi=
n
> the child to a specific commit and require the parent to track the child i=
n
> its index, which is too heavyweight when the child is meant to be fully
> independent.
>=20
> The typical workflow today is manual: git init, git remote add, update
> .gitignore =E2=80=94 three steps that are easy to forget or get wrong. git=
 son
> automates this and establishes a lightweight convention for the parent-chi=
ld
> relationship: a remote named parent in the child, and nothing in the paren=
t
> except an ignore rule.

I don=E2=80=99t really understand the motivation, but if your goal is to cre=
ate another repo with the current one as a remote, how does something like

    git clone . child

help you? (I=E2=80=99m pretty sure you can even set the remote name to =C2=AB=
 parent =C2=BB if you wish.)

You also didn=E2=80=99t mention worktrees or subtrees, which might be useful=
 for you.=20=
