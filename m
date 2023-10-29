Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86416104
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fawReOet"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2FCC
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:24:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a55302e0so4665529e87.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560659; x=1699165459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxfUFyxXQG5goRCvINZ5aYN7UhazrAlDjDhXis71Ypc=;
        b=fawReOetObuMEhUlIsfFwjXYYGPAebzY+1L18dq5wuZ1hqOiLPm3aA3dYBJ3SQ8b1y
         wGRqU6oSPRJHfj2nf3ffz2F6BYqtIIlJbFOdE9PgNsPf4j0VAF9NSmj7cUV8Kjia7XBe
         4QjuQTIhfpau17anXXJ1RSTpNo/wr9lQbxPZOlP8XCluuEFgYrIxviEmO8n25hoDmDNx
         8x4fH9U3Nrm7lcsBuR0j5xCH0ADYshSo0Pj6JWuu1LVxmyHzLygGFU5WEj9ft/o0KtxX
         PtIINkWIUI7sc9irPYv3kmcb7X11Q4uUP/U3GImmfH1b0/M0WCnQl44qdgaNQbLEV4zs
         315w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560659; x=1699165459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxfUFyxXQG5goRCvINZ5aYN7UhazrAlDjDhXis71Ypc=;
        b=ZS8NtYNVWteWc2qRtsjNKdHXpcV+UMeY6z7K+q5MtgarBcOOhXmQ2COyt2fLegaXmm
         SOY4RBcvNS+pkz5Mbr8B/Ngv+Pz4Z8ufDSV3XgFEtclL7dFUacB/BtinFn48bDbGmglL
         LxYrdyzYYdgwJbAHYZB97oBD0CWMMTiW+aqry7DbOv2CK6h/5DPbg2bSkD/RHC6JiEd4
         gPSQWf+aGKtTHoPF4xe4vQKVHS8igNhaOolfz0uXuPaoVImfHCi69VLz/py3cYRfPkRo
         suenYJYHBOqmFVsszAEfS8b10teLLeio2gMC2D2lKA0Uixu2K7qcX7r5zfYOiKZAS0qs
         Fmxg==
X-Gm-Message-State: AOJu0YyHgJa6w1zwSXg5pAnLN7LG0Ony6ByKH5NA74rAXNTNrLcHJM30
	30Ult89HvdNsPjjW0fzHSnn1Kq5u0jBcSvUQciJPr2Ix
X-Google-Smtp-Source: AGHT+IETJE+DV8CXUUM8yIfZSq+5MYntUgk2C/6eP42XhGMlqJrsjDTyeC5ViC+ma5f0gahP8ANaS2IJC0gXrr2JIgo=
X-Received: by 2002:ac2:4435:0:b0:500:a378:db71 with SMTP id
 w21-20020ac24435000000b00500a378db71mr4614560lfl.57.1698560658398; Sat, 28
 Oct 2023 23:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
In-Reply-To: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:24:06 -0700
Message-ID: <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Object ID support for git merge-file
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 12:58=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This series introduces an --object-id option to git merge-file such
> that, instead of reading and writing from files on the system, it reads
> from and writes to the object store using blobs.

This seems like a reasonable capability to want from such a plumbing comman=
d.

> This is in use at
> GitHub to produce conflict diffs when a merge fails, and it seems
> generally useful, so I'm sending it here.

But...wouldn't you already have the conflicts generated when doing the
merge and learning that it fails?  Why would you need to generate them
again?

(Also, generating them again may risk getting names munged for
conflict markers in edge cases involving renames.)

That said, even if I have questions about your particular usecase, I
think the feature you are submitting here makes sense independently.


I left a few minor questions on the patch itself, but overall it looks
good to me.
