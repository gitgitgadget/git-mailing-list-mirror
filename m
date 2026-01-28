Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C781C3F36
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560947; cv=pass; b=QIjSRZQkrPKArbbKVYP8qKrStGzrRRAiXBya4agWp/MevkWRAmQn+JSUuc84CkwEVIZI7n+fNvoOnyfmIMcBjRHMFaZkhtHOBCNEw7jQZdgVdo4vo+ZEx1HJcTaqsPKU8db4cbvSMsWo688ZuUswR4WmngrD1O4/5CFgGLs6syQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560947; c=relaxed/simple;
	bh=gktnqxEqOdJMuYorWOJFicbeoXWxtR9xQz7cNkpiIlM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=POq9cHT17rCarEtpv5FZorVE0ry15qQ4pIj/gW3SaQw4dQrLEpHQcjlkk1B79q28irfPrQNEFwPihudVJhk5OLBSTAY98FsvZazKAdDBVh6Hm/BZ3xMpXWnZD3agnrocC7t3UITxek0kTBqMTo88WimrFRrttS4peSnJzesyySM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=durRGOgE; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="durRGOgE"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11f36012fb2so9009426c88.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 16:42:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560945; cv=none;
        d=google.com; s=arc-20240605;
        b=H2rkFdnhMCjbYb9WJZxN7c305ss6ibGEKF5XbLO8BYLqXyO7h4qykCESZ5HyzVwrYA
         XaQ9tVbCR/4gb+Nddt7yInfQp/I78Wr6o9EXqchpRKucl2KOaPootxpdeeD8PN0Bh0C9
         Nxj4EkuHAd3h1hgt5PEt4iy3LcEdcd2paV5R7iTSp53jYloSe8RWy+LZIz88AenehXsO
         imov1DvAVLYFHFsCSCtdzUH7Owy59DaUMOagpL8RwPdbsnXs1IpOyZAQHCj/Q9seCgEP
         +zOeYUM2mAgwjYlJPAYvfvopffHGZ4ajMxY7U2CU9ggHiAbr5RS3mgI/ZbCd0JruaPLN
         UYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=gktnqxEqOdJMuYorWOJFicbeoXWxtR9xQz7cNkpiIlM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ay25BOQ/dlc/XwbuQQHEyq3tyACwcWeBK4SgJkVUKdHSGygnyvZY4xVJ2/Qdr5Sn7Z
         kgwbRkHLnSbNXtEXAvD6iKjwx1Sr4CcExAVB3FOKkpYPbg9ohvXxrKb830qoxpUFlFiM
         u3Fh0qdZf9ybW04pA6GoMTLgv+4dHrSDQ4LGLCBsYkf7nQAFOf5eLPW0ojLXFpog1I+l
         Z4lT3mLHXwIaoRUCxIYOHssP2JfZaBCCiIa9Xj+oJGUe9NmeZIGAKcFycQenPVMFAYAQ
         wYKEJmFClS/4qLxt6/GXbckGwn0VCyFKTXPFGr1io+wT3OHkrO6m6C1ojdzwq5nE2wc+
         g1Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769560945; x=1770165745; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gktnqxEqOdJMuYorWOJFicbeoXWxtR9xQz7cNkpiIlM=;
        b=durRGOgEEaG8DIlkQUkeq7bbG/16rOQ+BPp+nIysgYxLhxKvirm69at7jiGkM+j+Al
         ZqSd12jJ/vn93fepQYlgTkFFLtBnl6bdPluhmRLu72IaRSP/2zcYF4ewRAewy67fHjZ/
         EPK2BTk5GRRDDpN6EF6wKUkXJOJsolKA4ebVpfoKu/mQNhcsNCxvyfL9EdZ0d5qBuSiB
         jrhW1qcYNzfykjldNC7kcEBMnu+L3XGQONhV7jDXK7P+31+fveCrZXIswl0pKOqynXIl
         9Bep3h8Y9rYnYfuF+yx+aznXAzCl3UnH8DFEtbm13rnJyLstuA2EPDn+gDsi8bjUIjL/
         b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560945; x=1770165745;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gktnqxEqOdJMuYorWOJFicbeoXWxtR9xQz7cNkpiIlM=;
        b=tohIvqBG2vHS59d15uwhM2081HS7C3in9hX5GY26iwidmpjxbcgTwq+3D6LfHfGHb8
         KS4uAMZRu1Jl3erbXh+lSjew5l1ogn1GaCi36aH/wRGiUly4GW1ZDQfocqpBYzMkcLqx
         XYdcsz/MfYNq4YE0t4h1BkEXu0N8pBuUDMitoMm+2YYf41U1XFxS5Ovivnzzr1D7jCPp
         rTld1JxX7F/+fTb9I7sEkU7VQYQsQ2Keryb7NHpWn+H8awYSHZL9jQTi5LMDkpRTTBV/
         Sv59AxZ8+GMOcXzDaX9KUYGB460b3FQS44U+WiPC/FBtW/93SRQ3Kg8gYaT6EDcbWwtd
         LnXw==
X-Gm-Message-State: AOJu0YyEEd+1X0w9PorE5cwbnIny/oFkMVSxciv+vovEZgnsKymW/1bB
	9nDAoym7rsghVtuG8HcESLTHhAfNaqSlYEUwYwG7DWFnYwre/1oVFWfdFB30A3a6WdQ+Funjf/8
	lRMqWXhcgblecbXlYC/Mg9fORJOLsXrBFSR1wUCE=
X-Gm-Gg: AZuq6aLLPIssA3/fnX2TW29LaLySnb3pzWYVlmrRgxG3+gv4W6Jnm1YLHohNgCwgc1K
	QS6XKVuqmw3byeY6QzowDiYyRZHbXUSNTgfy6tkSVP2jce8H78Ul6nx83xZMurPNG3cxPKLe1py
	6Cy1xozzwxv/GHIrGPtilF2PB5KaHYZ6PVijXhddNyoVSsP02s1E988UnOkoIZ60jh+87yPv3u1
	v2piPRX452X4cHCxdO9qVztXZ8XM2l0fNgglBlyWchwoWzUdXQHxzSWhiLMZ2KMuAp63VVar34p
	DTWu
X-Received: by 2002:a05:7022:b8f:b0:11b:923d:7753 with SMTP id
 a92af1059eb24-124a005f58amr2515852c88.3.1769560944716; Tue, 27 Jan 2026
 16:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZH L <lzh2587379717@gmail.com>
Date: Wed, 28 Jan 2026 08:42:12 +0800
X-Gm-Features: AZwV_Qjj0v679WZ9PRHb3Hl7TId_1Kkv2vq_2uGeOPC7NJ2ffnHiC_BALDTfN-g
Message-ID: <CA+5Chmhwcz=gOQHW18_w+uYojshjFj8MCE+srUpJgEhbh8J09w@mail.gmail.com>
Subject: Question: supporting multiple named ignore files (in addition to .gitignore)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Today Git only loads ignore rules from .gitignore (plus global and
info/exclude),
which works well but can become hard to maintain in large repositories wher=
e
editor, build, and miscellaneous rules are mixed into a single file.

Would the Git project consider supporting additional named ignore files
(for example editor.gitignore, build.gitignore) that are automatically merg=
ed
with .gitignore, with a well-defined and documented precedence order?

This would allow semantic separation of ignore rules while keeping full bac=
kward
compatibility, and could reduce the need for external scripts that currentl=
y
exist solely to generate .gitignore.

I=E2=80=99m mainly interested in whether this idea has been considered befo=
re, and
whether the maintainers see fundamental design objections to it.
