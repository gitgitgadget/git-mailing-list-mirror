Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F7236451
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596290; cv=none; b=QhNBv85lY/I98vLhBI+bddRlvzk/wv9PS/aK2p8qykFr3leYwB5r+/BPBi6nWd9okT12xultyKD0BxZ/fgIkUFTvxW4WOm5wGX5jPc0S5FOmTpL/jYdMIN7rxDnjapaAxndu7zeyGXJ8WHGxI0sffWyv1NIs91gHKabTo7NMGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596290; c=relaxed/simple;
	bh=GSKzSQlr0Hn3RwzYx31IqX4tPZkPfzDsjC8/I+n0S60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGNmQcOtX1Qa43uGeCp9/FEb/Vv3FesHFwb95MSTbP1K/smXX+o6DUpfySY4jAWm7dvtgSf/waWI7joy28UWLjSj7M5PVl54U5vlk8Aage2xUgFObI6r1361yDFl/AwULtSMCl2b1rkOIvfhHSbuGLIcN/hH6CMi1VhgVIhZopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzFKXjQ2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzFKXjQ2"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7f539c35so16773266b.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596287; x=1741201087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSKzSQlr0Hn3RwzYx31IqX4tPZkPfzDsjC8/I+n0S60=;
        b=PzFKXjQ2yjjt9kMo5dKsM7KI8ibxF0ciSe9bTflpAgmAu4j/A1WjVjTpFF7oJ10qD5
         gWH3XqbydHpP/zRU4liMZGxS7RKxgFLywSm3xj4ST/fOJL4UZxzynyStzUfuA4VUvg7f
         Wuko4FTFK2ffWI4SQySnHEODuCDJ/zYzrnQQGHMurmdulSGP/g7l3YHanGGt31TzLTny
         Jb4wW+T3k1wSASXOJmkN52/5oPswv0ZhU/5l/8actsehePCpSMi8fe13y5JPVfXoNMXY
         P++0ozgvS3m/5UEwrDmOlE1gd6CKP8u7WCNAzKMPeq2RGuQIxYiS8U6BPXEO4MSRkkQK
         E4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596287; x=1741201087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSKzSQlr0Hn3RwzYx31IqX4tPZkPfzDsjC8/I+n0S60=;
        b=hsj0Yt/lJpAvujqWkpl+DKSTmsQkRxK/sYqiWrKE5ZBIMsL9tAmuz8oEVapdsMmNHt
         a+apcb1oEoQB9yYbGBnaZhih/ONgRB7D77jDFMXTpPOiFMPwmQNhdpGpYuaFWUZ1QUR/
         IeNrMYz3VnW3YUAM1228B80M3NDciu4iIW2dMU+Npr/CfniewU2sXo/WtF5x0XAjY6dY
         ZH7N59w8Ilhdtbkccq9DMI98eX4LrXdMS/tksqxxcMNgCs11HhOEldHxclAhwtnhOSRh
         KQ1pW8d/1yd1y/CK5qcSDmozv8tuNs9RGlZ0ecNsATQqlqxJ4DhxP3HfYIhwXPoycnPv
         X5JA==
X-Gm-Message-State: AOJu0YzVSerAWfLh4UD33QsHMAnvvlstMAtxcPKYssHK0gfcyzCDg8wf
	SfykEgx4N5BOLol4gm7COsYK9x74feo3UuKX2+pFHjzuKtvcLak0FxEgxD39xcemeVrXjlcgqDw
	zWAv0mmAqQWvc0rMkJ7Epr8webEbwbA==
X-Gm-Gg: ASbGncuXi2f2c4eGk86MmWx59ZZy1RP8jZQ3kWZQRKLUcTOnEDcW9UMlqWtzz1BwjJn
	Wuat5Azxz9vGB/XKshc3KEVPr8RptIVpgaUpeUb5JlnhMM0QYVxF5clEmKvxCtAXndSNEr8jOov
	OQOvHWSkC8B+pjlvXcnvqatvRyOPY7aXo6Q3Qxibs=
X-Google-Smtp-Source: AGHT+IHSfAlqNuQ495sGKB2pu4MaPg0eDiPLDECrEJz0Mb40NDk7HOxmjt/zK9pxIPDduWHCQsUqQdPRTzNEYt9m3xI=
X-Received: by 2002:a17:907:3f90:b0:abb:eec3:391b with SMTP id
 a640c23a62f3a-abed10182bfmr1097754166b.36.1740596287172; Wed, 26 Feb 2025
 10:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXAcUxHp3LnyqR=NM0coh6wG-1uy4GB3FdeZEg8mPHu-vt0bQ@mail.gmail.com>
In-Reply-To: <CABXAcUxHp3LnyqR=NM0coh6wG-1uy4GB3FdeZEg8mPHu-vt0bQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 26 Feb 2025 13:57:56 -0500
X-Gm-Features: AQ5f1JoEqTBmnTGMb5zdTnpv1UhEi-51YdNGIewEgODuorKUM1v8Ga9x-CqF36g
Message-ID: <CALnO6CA2j60gpPhUjxOY6_q5WdU7MHoL1GLDN_AVwWVNx_JddQ@mail.gmail.com>
Subject: Re: 'git rev-list' commit ordering issue
To: Clement Moyroud <clement.moyroud@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:44=E2=80=AFPM Clement Moyroud
<clement.moyroud@gmail.com> wrote:
>
> Hello,
>
> I've come across an issue with `git rev-list --no-walk=3Dsorted` commit
> ordering when
> two commits have the exact same commit date. In that case, `git rev-list`=
 will
> leave the two commits in the original order, preventing automated
> cherry-picking.
>
> To reproduce starting from the attached repo archive created with `git
> bugreport`:
> git rev-list --reverse HEAD | git rev-list --no-walk=3Dsorted --stdin
>
> You'll see that the order of the two middle commits is incorrect and
> does not match
> the order returned by `git rev-list HEAD`
>
> Since both commits have the same commit date, `git rev-list` should use a=
nother
> criterion to do the sorting - namely, use the parent/child topology.
>
> If there are better ways to sort such a list, let me know. This is a much
> simplified test case. In our real-world application, we start from a subs=
et
> of commits that we want to cherry-pick from a branch, for the purpose
> of creating
> a customer-specific patch build. For the automated cherry-pick to work, w=
e need
> to have these commits sorted in topological order. I do not see an option=
 to
> `git rev-list` that only sorts the commits in stdin topologically - the
> `--no-walk` option only does date-based sorting.

Is `--topo-order` of no help here?

>
> Below is the system info gathered by `git bugreport`.
>
> Take care,
>
> Clement
>
>
> [System Info]
> git version:
> git version 2.48.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 7.87.0
> OpenSSL: OpenSSL 1.0.1e-fips 11 Feb 2013
> zlib: 1.2.3
> uname: Linux 4.18.0-553.33.1.el8_10.x86_64 #1 SMP Thu Dec 19 14:28:01
> UTC 2024 x86_64
> compiler info: gnuc: 6.2
> libc info: glibc: 2.28
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]



--=20
D. Ben Knoble
