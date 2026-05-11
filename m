Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CC37E31D
	for <git@vger.kernel.org>; Mon, 11 May 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529315; cv=pass; b=aKd7AJt6SgBJzGUKTqdIbC25rr/wv3FtwlcA76dpbn4g0ujhcSI2uQhBoK8WCSN9rpoORxfKSO+AzHG+qsMnRfl1STVsNBxKpJmGVa2GYIDd+GEQleAAtjTMvSZlEmI+FdBH87YDFp7rljv3u+b/tJXLG7um20ABoPUW0jmlHnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529315; c=relaxed/simple;
	bh=qcYVEymW2FVlB344TArYMfHyCQzbOjjbEH+ArtI5EmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rShfTDJj8rhFxx7rRuE6WGHQGImHBYPBDOVw6hTpJ/prOJjIDxykSROROiGVj0GPWhDMpowJm8D28FtWczg3ED9bs8/288tgM5+J7d1XHmjI2P8Sryj88lGupPByoqvOKXT+ChcvwtZykr1gIQFg0viNV3JO/6TaQcCT4NNd0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKPUPKGr; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKPUPKGr"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso1969461a12.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 12:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778529313; cv=none;
        d=google.com; s=arc-20240605;
        b=lSro8RAhjPhKVGnN3GDwAs6c15IVVDC6jzO+0Z1ZKLMdWseXdbUJ6+m0M4/j/y7N/X
         ydlseBBFlJw6IJaOYOLpbexK07k5nrpEo5c82FyUanxj7EJuZykEwGcNNBiUrWBKP9MX
         K8VjWqM6J2B9XDwKnF1EBOzm3kzLdxl8WJCkl1YwtPAGwuwYj9UWd+6ESEL3yqOkpK5G
         gnyEaPnscQfyrKDR88bao860pxpOQkYBgnGykYJKKj1uWI+3FQYrrQlVWQG/oG7hQfDQ
         B05pKGs5Xaq7eiSIirDo4xxilDGV2D1KawB+CBb5uier7806fhDDoypQLHisuugfns2g
         5+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PxughDZv2ExyLisbuqIhCs1N/oaAdXR0VIR/UAHwKrc=;
        fh=o3JiAUjE2zsUX0IGxTCc0e2YE60WIc3Ibz2qdnue4EI=;
        b=W4dQj2eyU00qfoqRBXyjQzYE7Z0eHE4UGcQ2oxKBFgplTpL94QEIz0tOESQXUFDQd8
         BpP3IAJOMUWD5zDLX9NJApuTnQuEfkRkO1EN5UukMaSm5uBU7btXzyLqcligSflwDlWK
         Rbv1Inj8O9sj9Z+IF952+gTtd2VhnMqfM+bnAcvfskUmzwffawgGse6GK7TRnVs28of0
         Y8J3K72BJpacW+vqO3lstd380OdFhbwMniEHVmMj9BRLTf8cNQ3y+fMlqymWJwu6y+bm
         LfCuD6BX5ppeYgJ8DoVR7NOpdqRErqh7dXsN/CvLkz5ObUf14zUzqX7P89V9QswCt1Qd
         VVGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529313; x=1779134113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxughDZv2ExyLisbuqIhCs1N/oaAdXR0VIR/UAHwKrc=;
        b=nKPUPKGrYlmUdlsJO2lnGMLg6+9vKnQHp3Yc83n1k3oLp2rqumLoF+GpzGBQsgSC9X
         ivRUgvdKYaSvjQqGanf7FYcoCMGO7EunTXDVhF7sbZtDZ0OSptzK+EIP0QYq1eootmh2
         d8h3YI7aiypcNhV9Wsl4RWlt6FEVSdvEnnTE+ssQmllI9XV/tSL43MkmR4hjFzuU1Awx
         sfF/KFFNnw7gxcajoX1FjNMr7lH1ZFul4L+lfWRQCm7HY/uXL4rQ7+GNvIJRZYGOyorp
         QLN3Vj0PYkIm4Jmh9AvCuE+dQksxAsPMMoRFlJrpjWnThg/WrtHPVRTceqahR/shHWKq
         9JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529313; x=1779134113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PxughDZv2ExyLisbuqIhCs1N/oaAdXR0VIR/UAHwKrc=;
        b=ZHUuy4108/fNfAJHw/U5O3JYS7Oxn3c4i8Ahb1LJdvBp4yo4fNJBO8uFdyFTxuhRqT
         ncX+v1GXRH78njmcFgsrGnqqBv59zWkHHCchKU2oK6TY3BoEEmYXefMjFfhlgcoYNGx4
         c2JU/rk0/gmMFa/dalWelRPx+Upqnskj5rTWjDuQ/9GHJQsERuh6BnkmGCYU2P0f29Ux
         tvQfHU4WEO1fH0//RQhoZEqH0W8kuHkkaWwqeVsntJPj7MSA1IvlO2ollbr5s+pJ5PaT
         EpIR0rBVPRPFHjO3HdBzvu5iegzE8+ZnJoRCNkPT7pw9BWAd27F1zGN0c+ENzsJX9XdU
         7nlQ==
X-Gm-Message-State: AOJu0YxaUe8Xj2zgr5Fw2OyM0xlGAGgepG3SALZ+MgPj9gd48o6+WNpR
	B5eciNNNJZWioOmZuLDvJQPPQS5K00v3icaRQ240qwN/srSKS647zwzI9Rw4kTCXUmYtj1r0dJ2
	9/AKSayhXuMrmtSpcF6K6QLESwo8kqsTeRSTt
X-Gm-Gg: Acq92OF+fchgYYUIyV/dJ/US5RQqtcGWVvYCD9/Om+LmM8rUlLA0g9Wm2ZYfhNDsZ+S
	UAhCTlRHUKI7p6RihtlbivWdq24JCROBMLfUUHkVfstcrwkEJ3MIP5kJU4hxveIsbzFGm+ktALH
	lVypNkeHFVmN8LYpqWmZXHBkHtPn8pB5ppnsQBYJiDVr7e8cT9cmdTtFb/Nd0wzM622hg6oOJUo
	hamIjufLAieESc9ehLsQRw3FMszSpWJ9pk9wOKIHAQ3KRmDB9EdAHr2cHPjoVCEWVEqlkd7p/PL
	fsAo2MlRLfLQJZh/nSLoXv321P5dTcq2TVWK7gyyRnAeb5wsV4A9HiwTd2VnbKJ/aRk0FeuqJQx
	LaA03
X-Received: by 2002:a17:90b:58ee:b0:368:3d3e:efa6 with SMTP id
 98e67ed59e1d1-3683d3ef378mr6717412a91.20.1778529313149; Mon, 11 May 2026
 12:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
 <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
 <fd05eba1-d821-4cbe-ada6-ccab97308e56@gmail.com>
In-Reply-To: <fd05eba1-d821-4cbe-ada6-ccab97308e56@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 11 May 2026 15:55:00 -0400
X-Gm-Features: AVHnY4ImAxZqtZsgMuVHGkr2apqSzLb7Q7wIW-lEfByx-55uTZIe7ny7AHreD-Q
Message-ID: <CALnO6CDeejkgXwDJwq2tmeUORf9DTP6kLEmsCoK4X_jcRMCEpw@mail.gmail.com>
Subject: Re: [PATCH v2] ignore: note info/exclude lives in GIT_COMMON_DIR, not GIT_DIR
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Caleb White <cdwhite3@pm.me>, 
	Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:30=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 08/05/2026 15:14, D. Ben Knoble wrote:
> > gitignore(5) says that the per-repository ignore file is
> > $GIT_DIR/info/exclude, but in a worktree that is not the case:
> >
> >      git rev-parse --git-path info/exclude
> >      /path/to/main/worktree/.git/info/exclude
> >      git rev-parse --git-common-dir
> >      /path/to/main/worktree/.git
> >
> > We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
> > to say so.
>
> Thanks for making the documentation match reality. Are there some more
> instances than need to be changed? If I run
>
>      git grep -n GIT_DIR/info origin/master Documentation/gitignore.adoc
>
> I see
>
> origin/master:Documentation/gitignore.adoc:10:$XDG_CONFIG_HOME/git/ignore=
, $GIT_DIR/info/exclude, .gitignore
> origin/master:Documentation/gitignore.adoc:37: * Patterns read from `$GIT=
_DIR/info/exclude`.
> origin/master:Documentation/gitignore.adoc:53:   the `$GIT_DIR/info/exclu=
de` file.
> origin/master:Documentation/gitignore.adoc:100:   such as $GIT_DIR/info/e=
xclude and core.excludesFile, are treated as if
> origin/master:Documentation/gitignore.adoc:149:`$GIT_DIR/info/exclude`. P=
atterns in the exclude file are used in addition to
> origin/master:Documentation/gitignore.adoc:150:those in `$GIT_DIR/info/ex=
clude`.
>
> We also have a ton of other files under Documentation that mention
> $GIT_DIR/info/... all of which, apart from the release notes, I
> think should probably be using $GIT_COMMON_DIR but we can always do
> that separately
>
> Thanks
>
> Phillip

Good catch, thanks. Let me adjust the ignore-related ones and leave
the rest for now.
