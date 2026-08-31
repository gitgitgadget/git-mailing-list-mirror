Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF038DC5C
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208561; cv=pass; b=CdqXZnASvV/UPOBLRyZIxCzwCnBYoLzyYcr5WC0pVaJs+GSM326Nm8rpKV/b7yqaJ+dZiVPWix7pjgyDD44sVzW6PTsb1bFyDSDTzon3J/s225cFmx8RwjsOq6xW6YtgPc+6cxJWnreB3H54fgYNX1qE1/74RDbrsqn47fQLOEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208561; c=relaxed/simple;
	bh=Ic7dRHoBmmFEL5IY2wttIxL4M9J5H/rUsYAgIBf+hPA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bUfUbS/6FqQPVlD6JHhg7MJpvglnj/AptrXhig1h21uEOW/1XgC3CHeaVHMjXAy88ArAvudG14K2EITSYUXdhZLtHmP7RcVqCesLQVH5GcZeKgJWtn6TVk2l8J3x2B7UMFfGJ3mBuk3Yv/K8LOKF7mNHynn3YDf8UrYVbQ2x8VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU8Ef0zD; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU8Ef0zD"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3342081a12.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788208559; cv=none;
        d=google.com; s=arc-20260327;
        b=oxFXCwulle4hHq9Ih3Fmp+QOI44y+5WJ9o5CioHDpb4B7507/ORJfhrVNQ7boomQjA
         +uUp8pM9VjR0Az0+eJtLzyPPXxLRUqTq9Ud/1E4A8bMkWI9X0mIFJa0Mgr9JqUWa8L+k
         +D8IuIz1EGBpTgqYNV8dIztN3/UZa0kb4ZZm64cWFV//lPGQ8V9svjKEpAy7TPlquTgG
         pQvj3GY5Wncx8/8Pk4yq+Yqyn7jRM+k2EN1NVkmNX67fmLOdT3jwUsg8+zk4mVQIWjCw
         RQoOjlVXGvTFxo09S2fVYYB+23xLu08hTEcoh10KoG/DUTkcSNTEWLCIOuxVOHJnwbNM
         OdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GmGw/QQbmE53cAxFOr8lf1H0za4GJZhbs8AeCdqQG7I=;
        fh=l6El87tDRIBbJeF+PdPs8k46FfzzH3dt4/Kxk07b6vg=;
        b=Z2M+fzQdOUW1iA93FztbeZ4+dBLML43k8VPcY9+hEvv9P9QWizIQzxmlq19YtEL0FW
         VL9PV8WD5IoDOeGLdwE1coT+QXQAwRT40igVoo9KqnnZe6cpOWS2EDYsy5QTAoqMEqLW
         HsLJ0Xvtbj1xKTqCPVKiWE3muBIb/1KWjUltNUa2m/vj5wx15jkOmOw+5UR6cXBVZDjY
         SN4Jqa238n/pkZfVki0SV4bSt2ips3A0cPmyYh5hzhdn/pWzAIszBgTyRMcZhAePFEIc
         pMfRLwHLRpS6zt3S9VioyERY9l0Cflg1c2yKm21a5pzJcNHx28v6xCw26jx685n5D9UE
         cC9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788208559; x=1788813359; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmGw/QQbmE53cAxFOr8lf1H0za4GJZhbs8AeCdqQG7I=;
        b=nU8Ef0zDkwPTgLMjJfzU6BBdpms+qOPMD62EyT5x7QulGrdUIMN4f8ISKPdZ+hUYGK
         RqrFhyo0GSvC5QlObBdyISWOwdMYQfoKxZ4fKTd5YTPNEhzZNNTTWeoZRan1gzDutHdj
         kjBICim/jUaSncx/ItIN7WsdP4bVkkZBHkjGLul4b+eS6PBzVyuawNBziZJ17PgpWkMb
         x9G2ojODQSvu0gYbe8nkNPzbgPHd7DIU/Wvm/OwyyH8ir4WDk4SOQ7PNYxJz/Zqdn7Rt
         24cWRWCpHhT+/JcuiinSxyhlr/0znYcoJ8p8Apy1Yu++UyhT2KLc6oumgNUJT7ZWGKkB
         o0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208559; x=1788813359;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GmGw/QQbmE53cAxFOr8lf1H0za4GJZhbs8AeCdqQG7I=;
        b=ZiLa7m0hVEzSScIRi+G6VhyLE+7g/WoWODiqIPRxb6SF6+sDJBE5DQZuBrsCkNaA/u
         KFwMy4B58vDq/TEvIyC5DO2OFQeCi8WRftD9QBpfNz2WlxrApJETdE95mkH6ccK/c3sr
         lDrhQCB7ssvgP5jcr/c4YK6aSXtC//YdXaUPo0Wz3R+LyR8Yhs7ep03/L30OhsjIhluN
         IQ6oQbbTQoEGjm1GREfZ5FUTkMuCQOpdXEN7a7cWqqorFnCEXFGcNzCICkC5dY9t4PTo
         CXnF5x2RK/gxZG3tZChh3LRtOJC94OZLImxmgLRzSItOQOKiHodlLEjdh/RIcDmRXryh
         ZjmQ==
X-Gm-Message-State: AFuF++lEuMJBAQ6NBf+aKkASfml6ps3n9bLkKLaj8LeuwVY7Ckr97ua9
	hagEC612G+0s9+4nzGFsFU3ZRmCX0pkl6pa8aDXOi9xOAkjuq7dC07pLHfBhuoOXGA98IRnl7u0
	vKVztbR/a7hspH+o1C34wqsNaHUvSp72tvkdSzKE=
X-Gm-Gg: AR+sD13Dztivd48MNhwHkJxRUW5BfcqHEZjsadNP8cgqvrNGVHvDDNdFmfjPxFveNhE
	Js0Ew3NL8xklJGBv9JUP9vXYGQ19umh4KoKnubi4qx8DzhFx2q6b7TxsxL/cAyafdwLHnviCfJl
	2v+tqLtYuct1IJDIbS2a3QaoOjkKLW5KmV0JhlZbgXAPCWWSP7UKCZgIzdoa5wKFI/2sbThDQBX
	cCPCUA7UA19WqqmniJ+5wPtY+RH5WQvh0nN3JGTF0BnFqsFFtk+8v2Xq3+cjLtTq7a8ba5+VX2H
	0LDaXWiP1u8x8xkx8VeQpnkfjZQkF6/fTU92Xb3JfDTzBk2kWPUDl41D85yYdDweVt2kFm00Tef
	JxdRtEZIUKvHP48voLe390dizhv59A9fP5uICv/oRdnHC1xI/iu4Ln+TbwcR2SpwmmRIXOEanHI
	UVUyxR1aaDzJeGwbQpB2rcEWodHWf2
X-Received: by 2002:a05:6a20:2d24:b0:3c3:b57b:627d with SMTP id
 adf61e73a8af0-3d7ae9f3b68mr5856160637.12.1788208559234; Mon, 31 Aug 2026
 13:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 31 Aug 2026 22:35:46 +0200
X-Gm-Features: AcwNN1UXUiTCIDOc9nlxxm8Ra4bl7_c9uyRK5Dj-oUywDvePfMM-kS65r-Qcz0w
Message-ID: <CAP8UFD33n1h587u5W+akp0MGHAgt5uMqpJVJ6HeZqTGDr2Ahig@mail.gmail.com>
Subject: Draft of Git Rev News edition 138
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-138.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/856

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition early on Wednesday
September 2nd, 2026.

Thanks,
Christian.
