Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278103976B8
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542409; cv=pass; b=EFSrbz7LVgnnfjiI5UhAGLPEaFAaj1+SC3/eEZkl8bpb3Wv5Z1y5ZANusaD4NXmor0eyppTdWsM8ef3ZGTauHsLVSHHHdnVQA6xgbYGPGx0u98LYx016NpXhdIOuqjblsjB6yfOLv59wreRSatM7n0FqasUcr2H6oI48nanZMXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542409; c=relaxed/simple;
	bh=+yKMlI8uJquR2sSJCAz4cVknqAyvg7xeMP/PyU8Y2Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uezlLSu4wEJ9pVmlB4yyV2A8fOmeyxnzNTpeHuELDQehbOGWZCVnQZ+ZnL18hjNl1BK0WThoaZRPWgWjOPCjc6MNGEQvS7Jo0tppDWh8mInwGjec7fSLXRklFPkWFk32/IImdY1aT2hHthB6/q8jKCdZmnYQSLihkxefqAd0lk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGP/Ilc3; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGP/Ilc3"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c05d7e0e9so1069973a91.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 09:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542406; cv=none;
        d=google.com; s=arc-20240605;
        b=BwuzjN4K6wrFcmnURqak41zeDYMSWy1rVs1yv0F81IryRZLhxcmeiBrVhBIEqkn561
         f1u7CDw8P0OJvfKZIOMM0nYqJNgneQ+p22reG+YVOgnCqnYpc8zAa8Ee9+RzFxZSLxAW
         lwoqEpyZOygKvqv1AGwSqFIEY8ak/+BR99xdfrmwcYNmR6wDmS5HhfjBtbou8JILbDq8
         mN11dSjff+r7t0Ld5Z0fX0sYpMwXpgM7o5tav/qGwkWz2/Uj4TFRifUy3xWUyQgTizPh
         PbXx9ZoigVUxXNrNlc+ASEuzUm0O6cbCqOrnOatBNG+q1O6dPRqXdjfqkN2w0Ozd/r4z
         Ceiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFLSRJBMyhztARJMpZvDWgK03Wik3BafUC73dOOcfBY=;
        fh=mTD+sLSRpELEnc+1B2kbNUTNiNbqmU9taiiKMTwf0pU=;
        b=Wti5Yt0oR409HAoQlcgf+0qnFEUipGVFOnVF1+V4nBK7n2wZ0bzxCnq/xPufZuP/cD
         YemrCbZuEgrxr71CaSMq88bJZCCZ7ctfBSTBQkpVZItomgGdqaTu2K6Z0Hn6yXEzrDwg
         F65n48rC8q/my9iQaHntMyB76r6YEBth+z+exA/ICH8icZUQSGxrmtrtyZqH0ob4dMTS
         IrclcyfBBWryR8rJjDoJc0KpZclRN8bnZ9BTGwwK/VB6eP2TTo6Xe2xnRem0rkF0XHRD
         jTjzyTvY+AfDC96wXEBEVI7MBxRIJDtiy2wEFR9zh6DMbSOVUjG4pvAZfWUHAM018YIM
         NtEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542406; x=1775147206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFLSRJBMyhztARJMpZvDWgK03Wik3BafUC73dOOcfBY=;
        b=aGP/Ilc3KBJBCFlkEhWc21hen6ZWm3gjUiih9z1CngmPe6toEnNc4WsF0eHyRxcODJ
         DCfz++hJdJkOBcAbUfTvqxlO1pQIpPo+L3Uetawz77xEDHkTx/lYhsT+Uo0L9ESHNa5b
         QIebw1IZjVNQbs6VyTsPge1FLMnt1Y4+YZ4iL8kiB1iS3jdNzQhprHIG0+5+IQbXvVPm
         /V2M3UC0yI7M8xM+drHD0+LldNCiDnzpblhDnOekWv7w9vFLv5uMgaa7AkuFoJ/OCKZh
         HtOCBA5HRo8jees19d7bt3/forQuBVFX3dqCWpK4etE8tcKQQm0wcgPVwuyboU53EQaF
         rWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542406; x=1775147206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFLSRJBMyhztARJMpZvDWgK03Wik3BafUC73dOOcfBY=;
        b=ltQTysAb/6zwuf9mr7s5gVbspjT1cs6jDkAv7S5JUDfbkTdQyMl4Er5RMDpDQfIpI9
         oJyV8sQ43Zua5VBj4vzgOIZ7JYe6kC0IC8fHXxl9ZySK/w23nH8LQXtzo3cnsyWIKqgt
         r6ET4NacdEF9mqXIhf2jsil1CJN1LyMvb5WDjUr+PaZe0E0xsCcK6as2W0/EXIZdWyq8
         aBToCGHHyMAtYnGUcR/3eoupTArnUCUVHW7s6sLF0++P/EYyDmkSoVEWlrMWRnaSg96B
         O36sx02Z/YsDWfCrCzw+W9HJebtWlNFtcXplrNmELT5VFUO1ZlhTzWjsRA2V+CTONhj/
         IU9A==
X-Gm-Message-State: AOJu0YwomPwnA5KMbNjhHwKj0KT50iZmDo/oP/MRgQuCQAiJf6EWbkDS
	PoJJN7plTzIQkQVE1XgDa7QFxSET2Rdy6Y8uo22IfBdfZZI8VAVB0g+2+6Bt3xLdw/LVqZtVM95
	8jj4kcZ9Bcbue/Kiz2L+fdjPnXxHG+XxonFxO
X-Gm-Gg: ATEYQzxB+URe17CuuIzovcFgtU+I2JlJxaPNNu7fCo4qUvZtNKkS3MQv/ntJBkntHA+
	RS1mUqUz+1Nwqw8CN86Q4KoW4agD1Al+t1E9DQzymqjcwB/idOJMhGY3WH7+htXbgmOwey8Thk0
	m7nsZ0df5ykaSTeRM8PZFi3FGb3sjmrJtmX4X/gsYUsOrQfaHAe2nzIW2STV0d03uOxQvW28O/z
	df2QQS+4PF83dyHdHJQvkZhqJmlf88OIg+2zBZpYPgZrBdyGHu+gPsfDDeilejbe37gl3CSiQlY
	WUh0gm3YvoM/n+4RZeFqg7ATeNwJnpVVvwkxmLhFzW93wluYjYwU9pFf04hUB3EoeGaElhb2Ua0
	3gGqZ
X-Received: by 2002:a17:90b:1a8c:b0:35b:e4d5:dc6f with SMTP id
 98e67ed59e1d1-35c0dc8a39emr7258071a91.10.1774542406164; Thu, 26 Mar 2026
 09:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 26 Mar 2026 12:26:35 -0400
X-Gm-Features: AQROBzDmFqg_UF0aocMF7DzbsDq9uB1gG7bCu7Qz1Bp3FwBYKQtWec3aYCDk0O8
Message-ID: <CALnO6CA0ZfzAk8FU7xOYAW-emLwdVJ9Ed7Vt-77gfuY97FR=1A@mail.gmail.com>
Subject: Re: [PATCH 0/6] ISOC23: quell warnings on discarding const
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 11:40=E2=80=AFAM Michael J Gruber <git@grubix.eu> w=
rote:
>
> Hi there
>
> Fedora 44 beta (gcc-16.0.1, glibc-2.43) brought some fun new warnings
> when building git. In essence, we're not always explicit about
> const-ness or lack thereof of certain pointers. Before, strchr()'s
> signature which turns const arguments into non-const return values
> covered this up. With ISOC23, strchr() and friends return const
> pointers.
>
> This little series takes a middle-ground: no new data types (no new
> const versions of non-const data types) but more explicit casts.

I think a few folks were working on similar things; hopefully I've
CC'd some relevant parties.

>
> Michael J Gruber (6):
>   do not discard const: the simple cases
>   do not discard const: make git-compat-util ISOC23-like
>   do not discard const: adjust to non-const data types
>   do not discard const: declare const where we stay const
>   do not discard const: keep signature
>   do not discard const: the ugly truth
>
>  builtin/config.c       | 2 +-
>  builtin/receive-pack.c | 6 +++---
>  builtin/rev-parse.c    | 8 ++++----
>  convert.c              | 3 ++-
>  git-compat-util.h      | 2 +-
>  http-push.c            | 2 +-
>  http.c                 | 2 +-
>  pager.c                | 2 +-
>  pseudo-merge.c         | 2 +-
>  range-diff.c           | 2 +-
>  refs/files-backend.c   | 2 +-
>  remote.c               | 2 +-
>  revision.c             | 8 ++++----
>  run-command.c          | 2 +-
>  scalar.c               | 2 +-
>  send-pack.c            | 6 +++---
>  submodule.c            | 2 +-
>  transport-helper.c     | 2 +-
>  18 files changed, 29 insertions(+), 28 deletions(-)
>
> --
> 2.53.0.1195.g771ffcb452

--=20
D. Ben Knoble
