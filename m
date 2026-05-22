Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53261356772
	for <git@vger.kernel.org>; Fri, 22 May 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471979; cv=none; b=dHit0Nq561VI5KTEBR8XY+NMXBMwaGBemWm0NOm/Hg0qL0s8lNpphjGlktx5Vb9HnpCUGtETPMEPKeHNVqSUz/RpqcCR1oMrW5RQjFEpDvBgk25z+gH+jXQdpMcSBkWO9PXAstNK+PKU6I+M1DEfsPwNuwmW3W+8e2TOd56qyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471979; c=relaxed/simple;
	bh=3Izi1v0Tumf4MUHuAgabX+xV/VYEpP/GJSgSffw0ySM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cQpb/fwpmjUqM/QV2DIBX4518f2O3lJL/UB6Vk7swW/lakH7jl205Dkrk5I5m+vqGT7F0gsMlDfS8mk4bqoVQFK3a/ngA7tgPJy/F33eaHKSR/iNecj5G8u30o8+78+00GweQEZ5rzYRRB8ZpH4OMkeTigc6zSQrbnoQA9VgVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1EVBcSY; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1EVBcSY"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7ca947f9b00so71969327b3.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471977; x=1780076777; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Izi1v0Tumf4MUHuAgabX+xV/VYEpP/GJSgSffw0ySM=;
        b=E1EVBcSYUVCkyiGlbXZZWcg0jjB2SN09FFT/Z0fAgae75Nxl/mzwtXwMuXbFCalfbn
         1ZSOM5LS8zLCv9ZwazwEBKlBzDtGOL+oysBGseucVoCw5L5O0LUPLV7p9cEGviZWy/1F
         5rDFgnt0JPpuLo8sKKeRykgrKCKM5UbpE7DUjb6auAwIP1++YZRUNpXaUXn5xr07bMy8
         UADk0F1gakHjjNJWKk5IjjkU3Wve0i7U6f+yTPneR0sHhP8FpJXJx7r00azMIh2mm4xL
         KibU7sMETGvdgc8bHnnRwpE92wWfT4iu3XYTzOTvdhJO+BndMNCaV7QR5Ip5F6cc5Is7
         ZkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471977; x=1780076777;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Izi1v0Tumf4MUHuAgabX+xV/VYEpP/GJSgSffw0ySM=;
        b=rVM7sQ/8OnJilZ2vyANJTawEAUogyzB8E2zMCyokG8t4LWjHDefYw7oslZaTQRQW5x
         3uFwRSORCMSC3UUzo1yOlVodVKiMgj3CORQZQtZ1WuqisHSQANNUVXgEqV9Yj7t2jDYe
         ZJZxuiKeSMlEQMQuqQl28+JUZ7h9BtLYuFpVVSwFnWWyMkx9TCCiaXwk75mrgK4Sa6Vx
         v/+spq61CLStHUU4TMSVOoHCOdWhSDHGRdt9R2yWm97ZOpQ2ooPMFQvAu63LCfv6Hwn3
         x2QZwi3ihCYj+YKS31BGKX8uzF5iJh9owMvp/LdMTxyC0QSZ4ZlEkYyaA0BataAaZpeR
         73mQ==
X-Gm-Message-State: AOJu0YwKeTIGM3u0pxk2kTRbnC7+dMh7l/CnyVZ9y+nKmvi5nuDbYWCp
	HKD8WRdrTliEsYFNOGDzL+2J3t+H7Yb1re/U1eMoqWgcsGofETzLFWvR
X-Gm-Gg: Acq92OFvxp813q6eVZGSp04mzC4HI2eqhgGm4ptdlfsPwCTfqH28VdgXYatoje5pGQr
	hwYxAkPOIPo826DGccQHTr+J1Jsdet6uAvW3/0fro+isnjX1AibvtResIY/M5vAuZ2YmwdrC9k3
	9Mn4shF3P7xSuDEQ2Ej6c5sZU8lnpY5FaZ0urgAWjTX3QQYplJHE6B0PN8PGTlXSyO5NShNfs52
	/g4hfMuKkv2OegWFoEI6u+EvkyUmLlVZvgI3yeU1amfeDv0dxXI2uO1Zt9FYn6KVHBU22AqdaTh
	PyZ4DLSThdJTdlW2AYi6T7R1yyJCOD+itUtDN5BStipTRLcvJXIBA6I2B8sf7EUmJpK/Qn9qvcI
	2ArmmWQVmpMpJq0JkPSIbkdQEAPf1E5U+vKeYH1hjtDX/gp3O8RtPG2BdS6l/g0xx61mU8am+Fc
	1gDqJHLVEoyX4/6rAi1FtBZM1i9Y/z/1zePGR3aiYLo7wGxCKZiDd/gegkw32AcLz3Rb7IfWBSD
	Qv6cHVSHOG57phZXdc93GLQ/5Q+rAdBJM/1zdLGJcfFs3XvaQC/IWE=
X-Received: by 2002:a05:690c:6d89:b0:79b:deb2:f5ed with SMTP id 00721157ae682-7d3356de6bdmr54023757b3.23.1779471977075;
        Fri, 22 May 2026 10:46:17 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:d482:f98c:bd24:64d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d3873d080esm11279457b3.0.2026.05.22.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:46:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: I discovered a minor issue with `git fetch`.
Date: Fri, 22 May 2026 13:46:06 -0400
Message-Id: <65A1122B-D57C-4789-8C2A-E6330B6992AF@gmail.com>
References: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
To: SURA <surak8806@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 22 mai 2026 =C3=A0 03:48, SURA <surak8806@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFHello everyone
>=20
> The child processes spawned by `git fetch` can become zombie processes.
> In most scenarios, these zombie processes are reaped by Process 1, so
> this typically doesn't cause any problems.
>=20
> However, within a Docker container, the application service itself is
> sometimes designated as Process 1 (for instance, a service written in
> Go). Since these application services lack the capability to reap
> zombie processes, the zombies will gradually exhaust the available PID
> resources.

See also lore.kernel.org/git/202602231615147.3294516-1-cshung@gmail.com and s=
ubsequent discussion for related material.

>=20
> Here are the simple steps to reproduce this issue:
> 1. `git clone https://github.com/SURA907/pid-1.git`
> 2. `cd pid-1`
> 3. `docker build -t pid-1 .`
> 4. `docker run -d --name pid-1 pid-1:latest`
> 5. `docker exec -it pid-1 /bin/bash`
> 6. `mkdir repo && cd repo && git init --bare`
> 7. `ps -ef`
> ------
> UID PID PPID C STIME TTY TIME CMD
> root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
> root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
> root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
> root 29 7 0 07:17 pts/0 00:00:00 ps -ef
> ------
>=20
> 8. `git fetch https://github.com/git/git.git`
> 9. `ps -ef` (Run this command from a separate terminal session
> connected to the container)
> ------
> UID PID PPID C STIME TTY TIME CMD
> root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
> root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
> root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
> root 30 13 1 07:17 pts/1 00:00:00 git fetch https://github.com/git/git.git=

> root 31 30 0 07:17 pts/1 00:00:00 /usr/local/libexec/git-core/git
> remote-https https://github.com/git/git.git
> https://github.com/git/git.git
> root 32 31 2 07:17 pts/1 00:00:00
> /usr/local/libexec/git-core/git-remote-https
> https://github.com/git/git.git https://github.com/git/git.git
> root 36 30 30 07:17 pts/1 00:00:00 /usr/local/libexec/git-core/git
> index-pack --stdin -v --fix-thin --keep=3Dfetch-pack 30 on sura-pc
> --pack_header=3D2,399455
> root 38 7 0 07:17 pts/0 00:00:00 ps -ef
> ------
>=20
> 10. ps -ef (after fetch ends)
> ------
> UID PID PPID C STIME TTY TIME CMD
> root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
> root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
> root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
> root 52 1 0 07:19 ? 00:00:00 [git] <defunct>
> root 53 7 0 07:19 pts/0 00:00:00 ps -ef
> ------
>=20
> A zombie process has appeared. It appears to originate from a `fetch`
> subprocess that terminates very quickly; despite several attempts, I
> have been unable to successfully capture it.
>=20
> This issue was discovered within a legacy service. A few days after
> upgrading to Git 2.53.0, the system's PID resources were exhausted by
> zombie processes. This is likely the result of recent changes, as this
> problem did not exist in earlier versions (2.4x).
>=20
> To be honest, this is not an urgent matter; I have already deployed
> `tini` as the init process (PID 1) to prevent the service from
> becoming unavailable.
>=20
