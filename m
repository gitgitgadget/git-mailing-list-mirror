Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED61CB30F
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811176; cv=none; b=IvhYxURAPaclBOErcM9wyylXk9Jd7tOYb+e6gXlkafUKCo7ay5KeFh1JvA4n63jqTg5pRxw2o1QvWOI/U4cUNFUlRBMrHhvpDuAuXGJ7vz5KO0PZU9rSGfasg19g1ecpU3I/5zDUyB8Ozrc4KwcAEUCw7SvWrBlYibbkCthlFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811176; c=relaxed/simple;
	bh=2fNbpCxjh1ryq8etjdrK7qHB9PClzD7VeexuEqcZCCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khcVczmMsk64NkEdcdz0kKYRYrJZWjrBiC7XaqAdMsuwTNcQW8U350Xdpk0+RqGCN9vFEY86qWhE54qPDHbaW8liRqM07HNB2mZ3l9iJK3WB/oe2+kncPKaXkfoe9TkX09jQDSAu9uDfRNjE7BhmYAH1ir5yxb7WoV0cUWHgOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb3eb30527so7913106d6.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 12:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811173; x=1728415973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmpgcvwG0t/jl2KkH+KfiH9/L4dobanlsQB7m0W0X3A=;
        b=cPhSXIfNDcDvQCfitEDgUJgW+5n0GHP5WfCAvM+Ppk4A8u+LeWxSlahAgEzCA//hVg
         rH2zFAtqGVSevfODBODoXg4jJVJraBwhJD00jdXto4O0/OQ7N1l5Et0N20XLyaX5NeJc
         8BZEHoeLK4zkzw/ir30DjLShWSZxJ8DaLtl2YpfVqvV9dUdsoXb6mZm6POeQ0Khk5MeF
         1JwtlVCuZX3Y3ZKHCAuIrUoHqBd6yod4hvKkuRwZgu21UDW5kLlVmCxAfFuTzIkaBCcc
         PDg+DcUOnmghpGHSz/T9xbbBYOJv6oehNgiR9lxtRouqftNYzFNo2znwvKKFo7Pn5epe
         0oxg==
X-Forwarded-Encrypted: i=1; AJvYcCXxWPybGCyQXgpfjiHYzAC/i6NFrw1YlLbv9fr8vT3HEMyGqnzwnmlPHAZ2XH4bUJG1pWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+/yGx2FmSRdQisbywKO05sGWNeaVzD7i4js0uWoosoYxIuTA
	wWN9VONZlJertOaQra7QRlHhNuglGcpTJ4zKZFvRG06GVaLJyLZ/q+Q3yh4ZHPCAZf6FZ8W6glK
	SeTplOGZyzpVoqs4fDBaSSxqlgkPe9kJX
X-Google-Smtp-Source: AGHT+IEx9YchVYvI6iy6FeKtu0MmtRDx2s0z/8qYB5bBV6uiN5nT4wWh3efzFM192cNjPHoz2VnwMMPJwsvVJ/YRyn0=
X-Received: by 2002:a05:6214:250c:b0:6cb:4a88:8cf5 with SMTP id
 6a1803df08f44-6cb819ca829mr3605276d6.2.1727811173194; Tue, 01 Oct 2024
 12:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001170629.7768-1-chandrapratap3519@gmail.com> <xmqqo743vd9q.fsf@gitster.g>
In-Reply-To: <xmqqo743vd9q.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 1 Oct 2024 15:32:42 -0400
Message-ID: <CAPig+cQGz3TFGfmLwdpYHNMOqKbqXZpCRMj=bT3pvaZD=oyVSQ@mail.gmail.com>
Subject: Re: [PATCH] unit-tests: use xstrfmt() instead of a char buffer in t-reftable-stack
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> One thing that this worsens is that we now have two copies of the
> literal "branch%02"PRIuMAX string.  If we ever want to change one of
> them, we must remember to change the other to match.
>
> Perhaps with another constant, this patch would become perfect, like
> this?
>
> +               static const char fmt[] =3D "branch%02"PRIuMAX;
>
> > -             snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t=
)i);
> > -             refs[i].refname =3D xstrdup(buf);
> > +             refs[i].refname =3D xstrfmt("branch%02"PRIuMAX, (uintmax_=
t)i);
>
> +               refs[i].refname =3D xstrfmt(fmt, (uintmax_t)i);
>
> >               refs[i].update_index =3D i + 1;
> >               refs[i].value_type =3D REFTABLE_REF_VAL1;
> >               t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMA=
T_ID);
> >
> > -             logs[i].refname =3D xstrdup(buf);
> > +             logs[i].refname =3D xstrfmt("branch%02"PRIuMAX, (uintmax_=
t)i);
>
> +               logs[i].refname =3D xstrfmt(fmt, (uintmax_t)i);

Even simpler would be merely to xstrdup() the string which was already
formatted by xstrfmt(), I would think.

    refs[i].refname =3D xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
    ...
    logs[i].refname =3D xstrdup(refs[i].refname);
