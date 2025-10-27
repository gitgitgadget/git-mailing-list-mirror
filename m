Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF319006B
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524712; cv=none; b=GvmJDh/+Cqq9S/Y5sQgHhC8lz0g7NFxH/xWnJeb8tS5qK6L2cRfbXfK57gsiFZM3w+oQXfqaPXx2dzGHU1JDulKX4TPYnW6RFMdXeaRDIzYQE/gKOIn4Loj+f+bqFrGikDesGh9Rv8prbufnBxlXKdXpRzINKvCR5t7S+XIoYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524712; c=relaxed/simple;
	bh=YaT3jiSi7W9DgZ5X0H2tAaH0w9skk61XtnBRuqrfgpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+t2piLqX4tDWlL0t3BSTPIK38lM5ZIUNWVjtzpSlkdAtLYuxm1kDBjq7VdvfQezT2O5kjtw/Snw6aVWpSMSa/6usLzUO2BKDueIILmEaxTrm5xE1zPvLt7+nIlHPVpnvbThgingUSoRD2trl0dPfMByXUBtLkYKeIv1b8cSlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-863762d794cso68173485a.2
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 17:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761524708; x=1762129508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAkPQqDxrNxQfZ7t+ZLdVFrQgYKWRezZWoK8iNouC0w=;
        b=q2lplLowB43cIz9FVUL6EIwfalBRJpj/0LBZQm9fYWEyr7z3BJUcBJe7ne9uuZJHoS
         uNcIO+lI11XkbpeCavY4yuRySH3pqQyQA4rx65abIOG820+3wpZRv+g7aWRwFCjBF8p9
         OPazfoF1/sGZJivgGIJrQXesvTPDPRmlrr+NBY1ULNLOyM/e2eGgegg+27ESxPtLHZl7
         J0IGI5f/npb+1mlYoEdvpEVGEwuKft0/qP9apNHHc3/BA00SGZouJFhLPmcosnFOToiy
         rSbsS6l2oaI17Y7tqMDRMiUI5eq7QY7g3okI47IfcJwe2wSXMLYkhKpCnIoKhj971dii
         SrYQ==
X-Gm-Message-State: AOJu0YyqeAgAykpRGawAUvlK3v+0tsYVZdamKAAkUPfGkVrLA0KioXdo
	fTdZYg5yuh6esJJiQ0OYVQfrCnz0S2xQ1txIXxYBaawEjCcBiQzcq0BVdJmO03T3MaNY6MdhHaZ
	M/m4Pct6X76nY1fcAzYaw4jVzKYI/hXE=
X-Gm-Gg: ASbGncsURaO5NsmAhkSYvIELxgGG+V+fd8KFqqXQaKFkCREPVVzZaXca3qaz5zIV7+I
	FAA+PRU0dKzUTsNrNxomHi+CVphLF/n1sFlPghPK/QYTCb/B2ryhgXbDzu4gNcZIpm4vhPql2rT
	FCuYRsjg08aMqpjXSA2Av2wRfKe5Mjmlmp3kyWMdbybi5rwu7l5bdAZ+F9h/0/rNPCRlVMhIpdR
	K8AsIM9giqyxRI2AxiM2AjN2AJmVg4mFCXJCcUbe2m/LuGjCkf9bEOyL7DzQtapOFlA+rZwhUNs
	NhMxWE3g5KR4p1gHyg==
X-Google-Smtp-Source: AGHT+IFRo9dcCcyjOeQDXmi2EewmrIr7BFtQEn40Ck+F/3ftx4pHYZe1Dzpj20qEJFTji+4i7YgDm0etNzJ53kHooZA=
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id
 6a1803df08f44-87de70b4724mr192184956d6.2.1761524708440; Sun, 26 Oct 2025
 17:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com> <20251026225409.46647-3-lucasseikioshiro@gmail.com>
 <CAPig+cSOE1Du52Y8-s=b7HvKQyk-XHdGh3XzZR_tVktut9R1YA@mail.gmail.com>
In-Reply-To: <CAPig+cSOE1Du52Y8-s=b7HvKQyk-XHdGh3XzZR_tVktut9R1YA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 26 Oct 2025 20:24:57 -0400
X-Gm-Features: AWmQ_bkPRsxiOCH0s1PDJJm6xlJZv6FgGMf5u9FiQTXOHKH4cbkhMJJLbHNCFHI
Message-ID: <CAPig+cT3hkBu2kKPQp74JKvO7ct5ooV1wba8xHTzOn_9FGbz7A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] repo: add --all to git-repo-info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:22=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Sun, Oct 26, 2025 at 6:54=E2=80=AFPM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
> > +       for (unsigned long i =3D 0; i < ARRAY_SIZE(repo_info_fields); i=
++) {
> > +               struct field field =3D repo_info_fields[i];
>
> Why do we need to make a copy of the field record? Can't we just use a
> const pointer?
>
>     struct field *field =3D &repo_info_fields[i];
>
> or:
>
>    struct field *field =3D repo_info_fields + i;

Of course, I mean to have a `const` in there:

    const struct field *field =3D &repo_info_fields[i];
