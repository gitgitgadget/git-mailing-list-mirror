Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B0370D7C
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562288; cv=pass; b=ilJaAkVJal2rX9Yps0IoKekKIwMMyvdqT9+6WlByjTeeBg8+cqIu4/BLo/HKWO2QeVWuz0UeJ8lQKCyD9EqKeBGj+a8oK3O2AgoCUxUPOshqgr+El4tx0JElfpwu3/4GpjZ2sYlvPFLpkQhBe+ZefWnBluiTjVzvg2GR3EWzb7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562288; c=relaxed/simple;
	bh=9f38r7Ww9SHtak1oPZC2vqH6Zcb14jo1Xsa3EwPp++o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFryrI4hhrfmshc1Pr5QFjfKr8Y1YPGLo3NCTUYZT588ZW7H4drq+UmoCeJ+cXo1akpnIzYnnx2RVY020u2F8820+H+pRE6glZZR96PzJ1XvpP6duomuGSS0Amh+GgdIYZMM3Gx2fiUtmRBDUk3G8r2G7IYmdBpvq8b/dkklj88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImyAZx1X; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImyAZx1X"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c648bc907ebso3796376a12.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772562284; cv=none;
        d=google.com; s=arc-20240605;
        b=bXpoXluT9knVOBzIRh9QNwuH+m0FqD8I+L7KMC12qyBWJzDBDsl1nj090BY+yUf0A6
         kl+/fIO8FAwoVDAqwVVGnasKkciEYZCOzza9z33MLRk7QGcV5ZxE7upVOKKDKqghzsm+
         PDgcDPPdGVhxbFO+y3VdfhsOOngcB4tgUx8fW7fgLiFrqjp4n8Hsje1pLsT5NgUo+FM3
         gUbQwtQhBBgTm+U36Btkji+A2i+QwkAtPpcR3Lk9qGfD8fe307q3bOw8UmX69CeyGV3r
         zJM7RUBXZJw9k80KZlW0cng/GKuSTNg5SQOUTqOqvY4jFhpfcTCaTc8W23JRae5+D4CX
         qiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9f38r7Ww9SHtak1oPZC2vqH6Zcb14jo1Xsa3EwPp++o=;
        fh=GEQ+IbQqROY3U4O8XndxS3aqU12fYcjbHTyyPDXGSio=;
        b=YQBqKt/oMt1N0zRLgxbTNOFFDSBzNe/ZXUwVw2CijRdk2UZmj1GPYYwoSJxRmv9nEz
         Ff8+Bnw+R+PSPdOdrC8v2RnOyz1ShRKO87R9pZ+A8Zzuilgau3uugJw/4/VyFXMuG0UL
         0732codmCHy1ZSSajBDQtR+jhhJLWAHYO7y+N92W1ZiRopsmacxa9FjW0KRn7rriMUHO
         IJ4L2L42P/ogi54t4dkLD5+0JqgRg9OUMcHJ3P7ZgdQmXm5sWJlfJIHoKgLhrNxJuN0B
         X9GClcOwkIgGowmwDoYAT5N/BL837Odrc/XOl3Z5tTV09N3aph5+OJnNXc2pjXGnwnie
         sqQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772562284; x=1773167084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f38r7Ww9SHtak1oPZC2vqH6Zcb14jo1Xsa3EwPp++o=;
        b=ImyAZx1XQvCMcHsBkJwWkBtUA/EfrHIh2B8ktiPYR/tiZmzh3Xw08OepHk4waFRVfX
         Yj4h382MGvdDkZn5b+g8GLDTnGU6CH8G7mIpDZW0H6fOSbiMOHPYfLMkz4LEB3cqCxdy
         kXU9jP7ZZzHCSdltxXCXalgRInfTo64ESF/AKtRZ4/bfE6klg6rCrPZS9xZrvSsfx8RR
         QO6pBLO5Sb3LfW0FcH0jZRe4GPJDkKC7BcltV6+aTXvT2EeJEMCAWXKx6yb9qHCvcXHB
         tRYjneYwabkL2iKF8TQzcnRDxLo2bQ9cih6Wa/mpuIgDkWZhUXvlpEanhZLdaj+2aJdq
         YteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562284; x=1773167084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9f38r7Ww9SHtak1oPZC2vqH6Zcb14jo1Xsa3EwPp++o=;
        b=D+YGqf0qENQp8D2sOlrtcBSRPkfiiRvNDHdiEtA4hptKWGv+JBCIZS1W0ekDLhbcY6
         R7zkeSsxV7dwHnUQ2Xxn1kyNgY+NePiBlVvqtNghlqCORZB71r3HADZyxVGHvh4tML8E
         dw5+F8cM0jQq5jIHM0LEL4fJGTh73HxOQivDnjvZ264kU3WVarmdCZ93ClgY6mj7D7rJ
         CaSd4deXOulGyTUy4TA/CP5HYa35+ee2eSs5PSROcmCiNZUN2KihpqI+JU4+IhaExZBc
         S/O7u5/k5oFbFB3Tp6WIlV2aBeHDrkYWd5YA9FPzY8Woz3VAQChoDxNQd+elud1G2qN0
         TvJg==
X-Gm-Message-State: AOJu0YzMruFFOdBeBMCKB/gWjrsk91TtEknZGm/WPx9k8bStJUnGcJH3
	syrHqVp0/cIhlwJBaNfwbcQ8l0iY9DebeM4hXsCDpLwn8zBkCGPQecrQavdtamA7Xi5sCrViQgy
	SB4e+v6JTwcfJ6Ptszl36VSh3I4rfkL6H7Q==
X-Gm-Gg: ATEYQzwO8EWo8vFsEtCJoy5/lgMoHtTg2lKHAn27W9V/GuA0CZ/mZbSV3yr0dCDyKAd
	8nDTcFSiseO1O6XALlNDuFtxK0Bnz9p8zunB5n2ZoGY8fO8HWPkALJV1pSto7GSo7l/au9cE0zC
	jP2daz4k2TlBZpoVA6mSjw73GzmPOliK6k85B+a6oE1PoBJbhUmAhnI2zQ5BNAGSsyIdgfoo7Qb
	JWoy/+iicksqsUcipOH8KUHcNWOLS8RaXUFju63TsFENv0c1P+nfgZk4p/HhaQMKoD9kt+DhNXn
	bSCWJTJbGpXzilijbFg2de7iRwfkzMB/ZNKoqKNqCjeehs55Z5I3gG0ZbXziNh2u4fPRu83K0Ay
	juOJH/Kyy0JAminDGtHkl9oBZ7KU=
X-Received: by 2002:a17:90b:134c:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-35965c11630mr14676051a91.6.1772562284074; Tue, 03 Mar 2026
 10:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCPR01MB8293D4E9A416FEA864C9906EB67FA@TYCPR01MB8293.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8293D4E9A416FEA864C9906EB67FA@TYCPR01MB8293.jpnprd01.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Mar 2026 13:24:32 -0500
X-Gm-Features: AaiRm533WDvmpNkebtD3fqyupNO2iLLiUiNCXCgweTbTrYvsDn0hhdXSuQbO61g
Message-ID: <CALnO6CA03sW21WaiOQwUE-e3FZpi+fz8mi_NMs4yQPNg2Ez6WA@mail.gmail.com>
Subject: Re: How to parallel coding/reviewing the same repo in shared dir
To: Klaus Ma <klaus1982.cn@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:04=E2=80=AFAM Klaus Ma <klaus1982.cn@hotmail.com> =
wrote:
>
> Hi team,
>
> I'm trying to use multi agents to review code or coding in a distributed =
system. If I clone the repo to local for each task, it'll take long time fo=
r a large repo; but if I share the repo with shared filesystem, the reviewe=
r and coder may use different branch.
>
> So are there any suggestions on that?
>
>
> ----
> Da (Klaus), Ma (=E9=A9=AC=E8=BE=BE) | @k82cn | Beijing, China
> Founder of Volcano/Flame, Principal Eng. @ Nvidia

Try git-worktree(1) (although clones from one local copy to another
are also really fast, if slightly more isolated from each other than
worktree, which _can_ be a good thing).

--=20
D. Ben Knoble
