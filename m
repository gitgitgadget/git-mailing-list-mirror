Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EA3611B
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728253510; cv=none; b=Z3hcU4r7MFVO7VSi73ElbG7Zukqh8XR4jO+dy0UiRXxHLauEBZjCdbqBiNGmVZcVUHmM98N8BAA40wiRtXu95H2MMY/cWqlrmzXl0xwgjBGdq4WbLSr4RaVyQjSWHS+ugevcsFsiMj5V2FjyMvkjjT9ISPDbsV+N3pimZQSSxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728253510; c=relaxed/simple;
	bh=JM1CO7ckCyOZtQ1ddnCPiQZ0c4SkqPG+5O3h6mwvuh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ0eoSmR20Vkxk0Q/LA4BeXy+e8ZIzmOe3czxUlqRwQydtWmKa13WYWHgeY9+jKGDzXMX0lPJDcAwEPZimJl0kCqPcWBdEFcI08cR4p9OlkDRuAAg6yRjQi3NHT4yydhGMoN1tFsedH7QsMEY/yKdazE3F3Xd/+FiadEr3cTBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45831fed060so6346101cf.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 15:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728253507; x=1728858307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM1CO7ckCyOZtQ1ddnCPiQZ0c4SkqPG+5O3h6mwvuh8=;
        b=sYcs2Z8kV75wsOOjRWodp5WuveS+w67BqqQRqD7Q7dbr/inf/GHZ0W9tI2vJ3ZnIPR
         tj6cDAslChedNr2UZopbEkIS+7NcJ4X0swe/hYbDwqXqOEUef3xns60kXjaFYrwiZRLe
         G/gjHt/C5jN8YU9oUv6FKFZyL15HgLR6AX7SG2gQS+KeBT8xHreWCOIcokW/+lVQpEHa
         P93JCdI8q8VcR4EZqs5ZrErydS+SfuBym0dY1OGRCWaPb3x7Isju2+DBw9vtxZqDrOg0
         jTFOvct5jsYPtK7t7sjJdY2/zt+a3DRd2w4G687uhfxvPGZIjgI0kHQDbwgBKsPoC9sX
         yLCg==
X-Gm-Message-State: AOJu0Yx0YJztcBtxkMa6JSU/p31wVqJkk0d3avTr2qihWHwP3RKtk6TE
	1JHZWayXPCSWJAmxABBJTZbcluuoAit4cVfhqdceS15Lyb07RWL6ZotfzIoW91xjlYnmQ0NZATV
	MCxu4CAnWyZ+kbPvVG5ASSW6bln4XEQ==
X-Google-Smtp-Source: AGHT+IEg72CNr3f8vpUHzlEr+KCfAInHRtTiNgGde6yUKDTKWSBzc/LfLW9bVVqCt5aNAWCl/j1LzARUp3L3+7cv7+k=
X-Received: by 2002:a05:6214:414:b0:6cb:2299:812f with SMTP id
 6a1803df08f44-6cb9a4ae541mr70241006d6.10.1728253507118; Sun, 06 Oct 2024
 15:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me>
 <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
 <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
 <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
 <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
 <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com>
 <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me>
 <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com> <w7hncKNNAlJFs7fyi_ZzMj8iNF-GMgbm3E-7Wit9qUey2FDVTwj0CKg_Youi3mPpOcBvDEWyVEaeryeL10LqAY002FdBxBpi7zTQervXgyM=@pm.me>
In-Reply-To: <w7hncKNNAlJFs7fyi_ZzMj8iNF-GMgbm3E-7Wit9qUey2FDVTwj0CKg_Youi3mPpOcBvDEWyVEaeryeL10LqAY002FdBxBpi7zTQervXgyM=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 18:24:56 -0400
Message-ID: <CAPig+cRzvKddHsqahndU-pnScqNB9tL1KR-XBBGB6wx6U9v40w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 6:08=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 02:45, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > Can you try GitGitGadget instead (preferable) or perhaps publish this
> > series somewhere (less preferable).
>
> I just created a GGG PR [1], can someone please give me /access?

Done.

> Speaking of which, is there a way to tell GGG that I want to start on v3 =
to
> keep the continuity? I suppose I could always just reference the other ve=
rsions
> in the PR body but I wasn't sure if there were other commands available b=
esides
> just `/submit`.

Um, I'm not a GitGitGadget user, so I can't say definitively, but I
don't believe there is a way to do that.

Referencing the previous versions is always appreciated by reviewers
anyhow since it makes their task simpler. In particular, in the cover
commentary for any given version, reviewers like to see an explanation
of the series, references to previous versions, and a prose
description of what has changed in the current version as compared
with the previous version. Reviewers also really appreciate seeing a
mechanically-generated difference between versions, such as generated
by `git format-patch --cover-letter --range-diff=3D...`, or generated
automatically by GitGitGadget.
