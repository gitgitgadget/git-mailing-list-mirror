Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191E34CDD
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009199; cv=none; b=UYgIWgiL6YUQyAtCbZLO3W5yUzz1EhVrEf86mg/KZor44uOoVJwzp1qFiddiKoHGIE1vienLJvGHgzNn/QupRVAXh1AO3A4/cwsAIjS7eBbwa6DUEI6jITUh6OvlL+1jv6yqFl3BSDJjh3BetDzIXoem12Py96OG1I5cBUC/TQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009199; c=relaxed/simple;
	bh=GcES4ifcpjJzTlDnCI5j68prZIyODUIn+W3Jy/twsVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPtnUi01Vr+u0VDtgkHqZfJZkNc80djp45PfxoJ44kI31J1amomKorT41aWrip6FYZ4exKJHDhKi8o+O9JHCOfBIx9SNd/GU2O+uzOYSDCbhjA0k1nDq83DBDZKMq3TfJWJ1SroIepYuQAfF8r5eZIUVAYm/2+/UBKL5yEkhpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaW8DeFp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaW8DeFp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4aed12cea3so590226866b.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762009196; x=1762613996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOlBNfPYo053Fcm/z+qTbjySEFNTfgh3kDRpBA4pNg8=;
        b=VaW8DeFpySvt0GktRwggGydT4YGXjT+Zz61vezSfHBv5IKscwEkVnV8vheDx+o1cYB
         g4hFZ+PnVha0Ay7h+kcUG2CVVcMwcHgT6Xe7DpucADw9MhIzwBNsE515ByfDeLjkyofa
         acpSLhrXI+hCjZGqo8Bx0HVIVxyMUKLJ2s4XH6xt95tlmtBJr9CtFBk/DOvs3TOg1/OC
         IYxiLR37SlzZfjuvjwUJoSiMAp4irf+O2HHsNxJJTRjLkT/jMScf6K7sbQ9srAOM3X7b
         A9Tfzqklew3F0lCdcLNJlYGgcZM8eoao/ZZyscNmqq+PUPx8RxTfcjktRU0o6W2nUGbK
         ZLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009196; x=1762613996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOlBNfPYo053Fcm/z+qTbjySEFNTfgh3kDRpBA4pNg8=;
        b=HgO/sHIYJYjhOPU6+sVM+nE246Y7XIWm8q4RiCo9vNy67Pfi3BPZ13jIFwpZAa1Sk6
         OqKZ8pDTEShoCyzu0F24QQfhgOdp/xhQf/17uRypNOZfUVQIGCl7NhL3t7Na0EFwnvWP
         B3uAGOjw3/4F9Dqc7zW3fi2uLZfmwjWGHQ+kMQW3uY6EExT8DS+7x8CjP/t4a7LctRIB
         aEsw3VEphdl5Z13jXyxuAb79hejnVwZJcFqAns7+evtPhVT0oZUgQ7btrm/agBQanqhp
         XwgjEHHYrA4nH1D6+WArA/Rr5Ltz0TBZm5h3j7vjJj+dJg32kRV4mgo0nA3zwvbyl59w
         QZAA==
X-Gm-Message-State: AOJu0YyB+Ox0So0XIo7LpcrMJR7hkZ7nE50Dz0nqRXfeUmV1nC65+16D
	7CMoWMeE0jcZhF+9Xn/Jcr2pm7F+DoAvTi2bYGpuL6xRqoWPCKlR7pCQtylJn8vRIYgP3hSFIuF
	lsnoEC5MCvTyEAdPVRMtE2Rshp5aO529iyFGH
X-Gm-Gg: ASbGnctnmjoEK+NyXHtQU+yN2yO9yAwAl2XpTqQjcdsQ6rgF4OVs+Tk5OaHpPuHhv0b
	Xrp1u7Al4t1bkTh3DrAhGzgdWgXjefCWqSx/jarIJkORGus73yfHns/T7vP759lWzjAkCkXM6Kt
	vx52e4QWH3o2LIhVPUuxvl2px5+vRmXt3uPlMd+/zECwgU1pjQbq0CqeGkDR4iG1VVQ+el9gT0b
	CrH8o8drQ8/+MEXBMEHYSErU1XNVfZLvxA3r61eOIqbALwxpxiGAnwdTxB8x6o36Uxd3kM=
X-Google-Smtp-Source: AGHT+IFltj422oqPtbiOzLWJX8DxCecb0lZY9oCb/FbAEaOqdy4WH/pluzjB3XtNc6NFHXmdMddK0OnfSWlue19H5Xo=
X-Received: by 2002:a17:907:728e:b0:b4b:dd7e:65ea with SMTP id
 a640c23a62f3a-b70704c3e7fmr714300866b.35.1762009195512; Sat, 01 Nov 2025
 07:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q4heOh8stc94r_P5mX-tucCyqQ1JdGP2dJ9Dot3WTyDboRWsboWMAIoCQIXuyuRvNRmN5AGQYjhmAnjuxgOXNooUDjPAEEvKPc2k_DCDEtY=@proton.me>
In-Reply-To: <q4heOh8stc94r_P5mX-tucCyqQ1JdGP2dJ9Dot3WTyDboRWsboWMAIoCQIXuyuRvNRmN5AGQYjhmAnjuxgOXNooUDjPAEEvKPc2k_DCDEtY=@proton.me>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Nov 2025 15:59:43 +0100
X-Gm-Features: AWmQ_bm0Nn3P_SCHBAsjevjX8MMaDGjQ8ZmeLqv2oTWae4Jsgo_JzL5uxKB4U7Q
Message-ID: <CAP8UFD0CqC2tgERkPHuoOPO2ON9NNw_C1R-6UpBXjpgYEM8yxQ@mail.gmail.com>
Subject: Re: [PATCH] fsck: use starts_with() in fsck_commit()
To: keita <rudykeita@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"outreachy@gitgitgadget.github.io" <outreachy@gitgitgadget.github.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 31, 2025 at 11:01=E2=80=AFPM keita <rudykeita@proton.me> wrote:

> From 30136adebaffb97edacae2c58c4ea491e39e3f5b Mon Sep 17 00:00:00 2001Fro=
m: Songiso Cooper Lyambai <rudykeita@proton.me>
> Date: Fri, 31 Oct 2025 23:45:23 +0200
> Subject: [PATCH] fsck: use starts_with() in fsck_commit()

If this is related to Outreachy, it would be better to put
"[Outreachy]" at the start of the subject.

> Replace manual buffer checks with starts_with() for safety and clarity.
>
> This avoids buffer overreads and follows Git's idiomatic style used

It looks like the above sentence is not finished. Maybe s/ used/./ ?

> Signed-off-by: Songiso Cooper Lyambai <rudykeita@proton.me>
> ---
>  fsck.c | 124 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 67 insertions(+), 57 deletions(-)

A lot of lines seem to be changed for a patch that wants to use
starts_with() in fsck_commit(). Let's see below.

> diff --git a/fsck.c b/fsck.c
> index 341e100d24..7172c4ff1c 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -921,67 +921,77 @@ static int fsck_ident(const char **ident,
>  }
>
>  static int fsck_commit(const struct object_id *oid,
> -       const char *buffer, unsigned long size,
> -       struct fsck_options *options)
> +               const char *buffer, unsigned long size,
> +               struct fsck_options *options)

If a patch does other things than it's main goal, it should be
mentioned in the commit message that it's doing those other things
"while at it".

Anyway when I look at fsck_commit() in "fsck.c" on 'master', it seems
to me that the function is properly indented. So I suspect that your
patch changes its indentation for no good reason.

>  {
> - struct object_id tree_oid, parent_oid;
> - unsigned author_count;
> - int err;
> - const char *buffer_begin =3D buffer;
> - const char *buffer_end =3D buffer + size;
> - const char *p;
> +    struct object_id tree_oid, parent_oid;
> +    unsigned author_count =3D 0;
> +    int err =3D 0;
> +    const char *buffer_end =3D buffer + size;
> +    const char *p;

Here also I suspect that the indentation changes are not necessary.
They are also making it more difficult to spot actual changes like
'buffer_begin' being removed and 'author_count' and 'err' being
initialized to 0.

Sorry I am stopping my review here as there seems to be too many
indentation changes that are masking the actual changes.

Please make sure you send patches that don't change the indentation
for no good reason.

Thanks.
