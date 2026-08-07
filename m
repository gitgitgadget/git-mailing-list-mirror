Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31A44E651
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085601; cv=pass; b=I12rMOoaTAYQ86TXZ1JAKRPIyuXqxYYY2VqgqxNuMINUT/9sKIoMEZQGRpqdfnw89yebYEVlSBBPOcyc1bB41u+OjY0+iQMRH2b/kDFh+9X9TaVlrOaaekYDBAWI+1/5aHfE2ETgXMScTEaZD6yTuIGnu2gGiqeOpwEeTPMwmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085601; c=relaxed/simple;
	bh=PGZJpHnQhHSWT3surVAXn2eUUVDJc5oOrRJ9EzK9wgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGqZu2IKZ5HtDLCcDgev+8F9cktD4/s5btflaRcg/ZzxkR6IkjEdUdGcZZ08LJu741nEGIxaHa1r7Vyf9wsKjA2p/BltNDmdQ6cVsmcH7pHp93Qq2ICM3C3CePecRjVQFNZZRO4jclOnppiJTsChFmOvPMVFYQwTjkF+ijG91Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnyNyqiv; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnyNyqiv"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-497deab2d66so1435241b6e.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786085599; cv=none;
        d=google.com; s=arc-20260327;
        b=fm7jNYjbF/Vc5fkEx5Yas2yrqvHsx4nJWMvDmUQF84R77HY1ajpXNb9J3Omyb/Os48
         BkAAygodfI7WdD3zl6R5PR7mRBZTR1Vy0mdCsoeMntCKbzTd4tPLD5n7TCj74hxcHwjt
         bdQgT9C3b4QN3BVmLJwqCR1y6wX0zaeFpFLFkG8veBeeVFytLQz8P9jBsP8EouhW9KTB
         nmy2XtvLRn013dwGjTILswYMeJ68zViZkrOE5i9pA+zUc8rF2Nuo3FmGJyX+MJ7rcGZ3
         7HXnWSraUutyLzlSFvTkcbVr7pZoHwGMG/ka6ygJ/BGgsTQ8HcQssU3RcnVZgCJnkACs
         aEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgX+cPJcalQoVt8Ml0C5o8mUquJdTv4xfNjLACSLP60=;
        fh=dFkBo8cQBaHoux8HWS/O7dISSlaKRBpivvEq696mgmw=;
        b=oZO792mXm/HdEacnYVKMULVOoyvM7gKc7SU0somErzz6XeLg8uH3deLnFagKq2m12P
         KBRNUHgRS1zRZ3IP/hOldTJNZx/q7/4Psr0gmNYD+HWVeBKAU4v2H0qO6HUqP80pONUS
         TDG64mFGmNN3r2GMjYRl1+OCIR7ZM6W5JlG1kWpJW/6GaX34H11rQ/W+hqrUjw3mSxrs
         hgDHWctu9jb+HqNSxbsMJhm9zSiHIadEXKP/WCEAgUa587GA9qYkDfUnyeaZL6Ge8cRf
         DDzOZBob3PXAPDnn22F8AZzKJ06b2/KG7YsRI+tk79dSfROsCcemgFmbzp+GPwye0IvV
         2HdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786085599; x=1786690399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UgX+cPJcalQoVt8Ml0C5o8mUquJdTv4xfNjLACSLP60=;
        b=XnyNyqivTCTe0HD0KPlDmJGFzTIk+7rybZtgRdBcCbgNf936ynmf6u7zxwXklPdXzQ
         Kx/40kl1yM87OfLhD9TmabpZWZpEP0A0I6B9yDs6NtkRBaQVIQYXjsCtTTGyH3B1QA7w
         30iMhim6i/3UurO8qg/mm+9TfDuH98HaXMoAqXBt8347tT+IZoRftYXmiKoh+OUF6ZK6
         9VgEm+w15eEiqMxLdYA/oD+vDRrEgT1CuCBljeSsi6wDdpqNvELKdZo3ZP3Kt8417d8p
         +c3zAawS4Ejl6vAsisdn1c7gUKXHjeAxPGVsi5gzgxkk5fEM2QcFhspBfeCdN2Ls71Kw
         qrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085599; x=1786690399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgX+cPJcalQoVt8Ml0C5o8mUquJdTv4xfNjLACSLP60=;
        b=b8LCgCGDedYgTkQM9sae0aS+l8HkMbJ5nXdXibYmHTheClj7k0rgir8px1BkQl4rxL
         nY1e7MfppMIjVWg6RqbOsj0IKfBBEhaw9yukaAuRCIP6mB52iiJaV38NbdFTsICGxoAs
         olbwLL57bf58liXiXmeR27B0MdyYcPX5ErSiBc/Avs42wqJqT9ofAro1+2B11MdK0UHE
         7NVcPT7nORN/DSHGxfyqCy4PlpfFzBZxO54xm9vOHKJ2dPBOdhnoG0xhu2a7oZVBBPr7
         DmX01/Ix8De25CK6uloTeZnjy/emsuAqJscvk5SK7CZv/m6zetnRXlZs3BXLKG0M2t4V
         kdrw==
X-Gm-Message-State: AOJu0YzwyVdlo+xsagq+TUZHI3od9F8d2qPyxuDymzi8+3f0zpiJh4s2
	Z/tZN7DdSlvb4Fvd5l06dAA0hNTP6s5InjU7FNPZS7+Q7hhbbD0j1hpOedJ4H+1QGJC4AUmCrSz
	Z+jTiqMs58eHVJxjvxnE0pFDg9pKEBIU=
X-Gm-Gg: AR+sD10NueuWIY2NCcQAne2um2LuslKb4CIm9vm+FM2c8un7/YBNiA4bsMCrpHnwqY9
	YYu5NkuOa6wzSoiugLiBX+6qjRX7RhOe+Wgp2rBIUGg0VjD7TA7lGLegs6QSXlvGJCRSZALqWXo
	t9w2M2Lg9XfjiJ3M68te2p320BckV4vKgMRtuTPziMZ1AEGXP8CftJVaRlKI/B3EWFzwu7ULL68
	UQnTPaKVyaTr6vQaHUDjuSFmbQk1DuSpo/6P/0d9brcGw11ZEG1fGg6394GuQilRbcZx/r4IkVr
	DTErA4Zkk+5sWqj1XsSa1zE0Mq1aIJuViV2L7tlcVWD95Uh7UdLEXayU+xtYh6X7n2iXWZjyETa
	36npgwT1Mg+V+wqZK6J8vBXuckvg3OsnOdg5KyAqTLb4C4dnEBLzmVamOOdRG6Bk=
X-Received: by 2002:a05:6808:ec9:b0:4a4:cedc:6859 with SMTP id
 5614622812f47-4afc4df6419mr7362538b6e.4.1786085599048; Thu, 06 Aug 2026
 23:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
In-Reply-To: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 23:53:07 -0700
X-Gm-Features: AUfX_mzlYFd2xNIZtWjqYnxD8hE1RJnN5GaX8h_lTWlwpgd7Hag1o_G-eHITXlc
Message-ID: <CABPp-BHbWKr5tv9ApH8ZagJkY39XZgQbLoFrmQJfU71z1y6_xw@mail.gmail.com>
Subject: Re: git-replay/git-history lose notes
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:06=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> Hi all,
>
> I don't think this has been reported or discussed yet, though my
> apologies if my search skills just didn't find it.
>
> It looks like git-replay and git-history will drop notes (or rather,
> not carry them over) when rewriting history. I've seen this both with
> "git replay --onto=3D=E2=80=A6 =E2=80=A6" and "git history fixup" recentl=
y, though I
> suspect it affects all the modes.
>
> Fortunately when I check range-diffs before pushing out new versions,
> I notice notes have disappeared and can "git notes copy @{1}" or
> similar for a note at the tip. Recovery for the intermediate commits
> is a little more=E2=80=A6 involved=E2=80=A6 as I'm sure you can imagine.
>
> Are notes out of scope for replay and history, or is this just a
> "nobody's gotten around to it yet"?

git filter-repo (and implicitly fast-export/fast-import) too, though
that one's a slightly bigger can of worms.  (Trying to treat notes as
the underlying commits they are represented as is a really poor way to
export and import them; any filtering on the underlying commits will
cause the notes that attach to them to just be lost since they will
instead attach to the original commit.)
