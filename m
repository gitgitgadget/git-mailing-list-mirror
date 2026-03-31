Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF93FCB3A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969092; cv=pass; b=XVr5y9SiK9cUs86LfjXm6JiXx5PhKuVKnmesnXbnOgm3IAMBrQX0wsxI52KVabHHQggXBJYw8ZvfJrJxcY0RzaAJ9TA0xPzbZ5M8ygz6DVBv2TeT6upltyizwOG7OT28NtyTgM+q+yAxXeZDykG3wg4iwV/O/0YiJ+sdAnAfF+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969092; c=relaxed/simple;
	bh=2i1zO97/vvUEwmowc+KfL0xeEmu9XnsG20WK0HjSe1k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K8wTN2kyV99i32jZ0nsLRi42b3XRY9Cu+aR0rqzP52qiEwy+jFwuQbwv7zMSzsOEcf+vTnQGvvSWhfcCmigza1hD0zadUAYozalVaAtJaQ9Oum+2C+FZP5Ekzn2IxUbRpwxO65zZMhUrYaMwFix/959HoAdbVGxap5B0s+DUhGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icy3HeLb; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icy3HeLb"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467e044082dso1991067b6e.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969089; cv=none;
        d=google.com; s=arc-20240605;
        b=Md3IRekE7XXhwaZHkatnSlik5oA1aAXLE1g4xvtn1HPjCB5A8upd5txnxWHzKXxHmL
         js5YPJWXfocYMOas3FTChvHgCqlYY5JVrcEvcIGFSIdMny/j6exFgUtrTWTAps+xew2C
         zh4YkJO/t2aELwBOooVaF0IV/6FTkFOQGsIt7QKLdNgYCBaqm8Xf1nrQb7b3MQ26ZbYs
         rIbd1+Q0phe4xycowfgbusPzfY4EILBR4rNng/6VEkLZV6JBRCm0++MwrcxLPNh8Gu//
         dpH1HCTRn0G5XkwHK2sxNcbht0vMeNyPFhFL7ZP7Q2lhuIGfZDSRCR87mqDrWEdII3Eu
         VEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=2i1zO97/vvUEwmowc+KfL0xeEmu9XnsG20WK0HjSe1k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=dhple5WWZ7oJ9znie9SKaSVzhqDNRk9pXUZsv5EMH2IRNqsSG+r6yKYYw2YjcexWfx
         ntz/DF0z5+TAbQUAPqHUN2/VmOBMFcy2tG+d8pLzOEyt4tBwMFNC84prf4VGoEpr3YHi
         iK/NtqvUMJk5QN7pOeWR6hYARkSXR0/gv0Hqk5E1+Vpln/AJulv+pYffYr+pCAqMoRPG
         ksMJNewkXCuJVJYU4VG9bYifMkx666vMGHbNbBm0VFp+135OKRCIp13pnXVyHkMUwkOJ
         o2gwPb3zLo6ZW4SunTB3FbNeE6t1/VJkCFVqQx4DEdeJoTdlQcQek6tTjwSCaoSMZkCj
         UnGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774969089; x=1775573889; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2i1zO97/vvUEwmowc+KfL0xeEmu9XnsG20WK0HjSe1k=;
        b=icy3HeLb2d/anbPAjSh/RIO3KAxmmmJkTcVN5wgdzQSgZByLD8c5vfIaN5IgWPxn47
         u3ABPOSPH6KwJXMajVovP4piKtGp3512EsyY9Vll+MeD47xOYz+kh+iv4w6e+ziE2rFV
         rUt91k8fT6XzhHYamBjoFmOASQFzvygjkCWD1ynm4H3Cc8Lz2XLcIvrycaXtDN+g/pCZ
         Azi0ZcOvInUGPsCzaUojlZ9MpEWcTjj3FgLP740AHgubGtsCNJINFXTtNxx9W9UyyZ5i
         D2jMAYsDwb6MI7A1hC98y8skIfMPtcPCekSa6jCeiViWjZf/EwzBMmAPSbuBSYJNRn5T
         ND6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969089; x=1775573889;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i1zO97/vvUEwmowc+KfL0xeEmu9XnsG20WK0HjSe1k=;
        b=Y31ue8p2q5xTeYrROkvOkfLBWpBSctRlNQN1N6vhhITmdBImjFrYtyWCw+JYD88wcL
         kO6shhj7SMbLwYNODShZkww7+I6R2pjAGBbozN6RaMkMbwRIcjYpaD52aoBashOkDJ/Q
         Oj1C3eC87kn65/xjKE8tBK+Wld0osEyv6TzmN0gfCQABfZK5X4NTj+tAQ0fE1J7f9Uy+
         m9oR1/sqb781v8SxmiFVoKRLH4v1biAyzIeAjCZ7YL+N1+tIqWoNDrEnpJU3JoNDs21y
         GKxbUEdJRT98WguK2QLUIuZVqITFeiBTLXwdxWd2pm8Ob4j6DngH32M0TJxIEbHhILks
         wPcQ==
X-Gm-Message-State: AOJu0YwsyrQLGrt1MOBPhYdvLm65axMdeDXR5r6VHbo59y3eUwue5DNY
	eBrgOxOlQgFceWyOmCRdQQl0Uf4OaQTw5jioMjvQ3KqeKCiC20yAl17eKvlXkjWCyCF+boxZzg8
	1QgTf/vbSLLabktSv0LcmShi0a7/4AeoeDKJ4
X-Gm-Gg: ATEYQzzVNt1sTSInQV/a306dJeqJ+5Tn77CwDy33zi7hsAoU3d9Lq+YdIh07eFK6gAA
	OLIzfFDwnTU8yZwc4tOsIwAnodo5EwVcd7m+ZaneKw2+09T/EgGhzTRUsLBUl9s6Xx3TgJP8YqE
	iQJvZtbZcpuN1jwPKU8nbAxH/qKdtRmS8qe5KIZUWf6guO8nv9cnZ3jpS4VV8CF4UQo8d2LLzCx
	JZX1GDfsvl2O0ygsVUm3mBjYz9eghcGRivY8WuIOQNop/L6s2/0CSloUu6mabfQd0jlFdOFyOpp
	fQFOKKeDY37kR8RwMojMUx52G3oLc9bMpEI9xg==
X-Received: by 2002:a05:6808:5147:b0:468:140:e8e0 with SMTP id
 5614622812f47-46a8a3d6600mr7891105b6e.14.1774969089578; Tue, 31 Mar 2026
 07:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giorgos Gasparis <gasp.giorgos@gmail.com>
Date: Tue, 31 Mar 2026 17:57:55 +0300
X-Gm-Features: AQROBzA3lK5ltynJFCOS-lB2Bp8-c-jiow4cvGI9-fEQRjSo8WZwlVaoe0pqCT4
Message-ID: <CALCP2CjymE-i9TsKB8TmW_0M=ZDbtLPzZFpx4-ba01164b1MOA@mail.gmail.com>
Subject: [Feature Proposal] Add a built-in 'git whoami' command
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git team,

I would like to propose adding a native git whoami command to Git to
easily check the currently active identity.

Currently, users have to run two separate commands (git config
user.name and git config user.email) to check this. This is a frequent
friction point for developers balancing work and personal repositories
who want to double-check their active profile before committing.

To solve this locally, I currently use the following alias in my .gitconfig=
:

[alias] whoami =3D !echo "=F0=9F=91=A4 $(git config user.name) | =F0=9F=93=
=A7 $(git config
user.email)"

Having a built-in command that provides this kind of unified,
single-line output natively (even as standard plain text without
emojis) would be a great quality-of-life improvement for the wider
community so they don't have to build custom aliases.

Thank you for your time and for maintaining Git, Georgios Gasparis
