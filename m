Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBB137E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713495939; cv=none; b=fdjwNL5VHumW1PNytNRh3XyB8ZtvlX7RO2+Qqg2VWavpad2pNQZ/oQsrchyJeDq1e5n5ESl25Uxz26/OYpZNS8BGHocYrGsXHA01Eh97Hl8J+uowMEqc/OXA099n19BJ14TpltmA3iGEgzp5ds5AchG6udIFOa+EYbROCsl6LnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713495939; c=relaxed/simple;
	bh=aXnnOsBxMqmIE59mMH13oMvjeNScVe4zoTuiXWiG0E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3Btac5x0xpDbzKaK5DHWJhHGEcamJ2aNpVIWijUBwxF2GKGBiINRl4lqCudzFyjzglSZo2vvG8eLD3jNW3nvynEEVrwGEPI4TC9iuUwu4SZ9rgzGb79+n9MLx7PX+jtHzMEEvnOKqPajXBTXX6KLdVfzUVVTUNRrJHvNO0iRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b4454e2f1so7197976d6.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 20:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713495936; x=1714100736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kzI7KuL0zpZZ0qaRNebfP95omOZGTrwEbXBMDcNzK0=;
        b=pdAR7bt9USUnuCxq7NCbCYU0YCEVNh99s3NuRMx+MVdu+b2EhlmkLu/E11JG4GozVd
         I82uhloDg2Dgj6lsaTKas8sPT/hkqZimrbOPNbBzsFcoQUnD1cXU1W6isTdslvJA43qH
         46bTA1gOOE9FNEpY5S72K5OazYZFc1K08N/zfIoYiS5E59wPXel7mG08iuc0dGryEzQx
         j/AWr5/p+7fagcN6q2uvf1HiPW1I6b+YSH8CttuFnL6NCARFsJReyG3OxbFQgVd0uDto
         iuLKGc/yYqvDjCYWP17ruawe6FK7dWaftRFqHGO90D5nzeiJ8NIbUwdrUixDwuoamxYy
         YEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKa+VBfaCTA5MUpVZs1HV2g0FD6EjActuYVOEOEY0WWD8kWrSI/4deoDT5q20qr6DFv9LrDirjxunLPSlgFFiYWsU4
X-Gm-Message-State: AOJu0Yx4mvc0TWWQhwb23d1GHLAVX0kG6pSLCTjpFKLqbGwNdnvHkXXN
	eohC3eytubNlORFFrbsWjZDlgInKUWot/yOLfFC97DcOu6yrpDvk5tv+1ADvwjEUJAA9tT9+AAW
	hYO0MGHTY0hPvx6vz+ZxoMQSWbSM=
X-Google-Smtp-Source: AGHT+IFEmKukfwPjoYy8EYuuGQkc0tjMtPgrrjkysyo44sVgGtZGAuZ46CwCjlSRBbfb7gkF2Ys/yBeENNqZ5EmiWY8=
X-Received: by 2002:a05:6214:1101:b0:6a0:584d:3e55 with SMTP id
 e1-20020a056214110100b006a0584d3e55mr953366qvs.7.1713495935848; Thu, 18 Apr
 2024 20:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com> <xmqq7cgwau1v.fsf@gitster.g>
 <c2cb9268c29ae4a5cac34383b7443763@manjaro.org> <xmqqle5b66sr.fsf@gitster.g>
 <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org> <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
 <xmqq5xwepafi.fsf@gitster.g> <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
 <a24045ae382f91fed6a499d93690e31f@manjaro.org>
In-Reply-To: <a24045ae382f91fed6a499d93690e31f@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Apr 2024 23:05:24 -0400
Message-ID: <CAPig+cQHyDbnZGXJ0qjfn6JcOv3V=_RgZGMNnxkd4OcVfaE-sA@mail.gmail.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:45=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-04-19 02:15, Eric Sunshine wrote:
> > I do understand and am sympathetic to the desire to reduce the typing
> > load (hence, the original `--resend` proposal), but I have difficulty
> > believing that `git format-patch` is so commonly used throughout the
> > day that the time saved by typing `--resend` over
> > `--subject-prefix=3D"RESEND PATCH"` warrants the extra implementation,
> > documentation, and testing baggage. Likewise, I don't see the value in
> > `--label=3DWIP` (or `--rfc=3DWIP` or whatever) over the existing more
> > general `--subject-prefix`.
>
> An additional reason, IMHO, for having "--rfc", "--rfc=3D<string>"
> or "--resend" is to reuse what's already configured through the
> "format.subjectPrefix" configuration option.  In the sense of not
> redefining what's already configured in ~/.gitconfig (in this case,
> "PATCH" or "PATCH lib", for example), by specifying an additional
> command-line option.
>
> If some user configures different values for "format.subjectPrefix"
> in different local repositories, such as when working on different
> subsystems, it becomes rather easy to get lost in all those prefixes,
> if the user needs to remember and type them entirely while using
> "--subject-prefix=3D<string>" to add more "labels" to a prefix.
>
> I hope it makes sense the way I wrote it above.

Yes, that makes sense. I wasn't aware of that behavior, as I have
never had a need to set that configuration.
