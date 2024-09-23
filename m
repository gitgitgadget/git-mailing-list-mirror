Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089419F42C
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114371; cv=none; b=Lp0Q5au4OVbSpusEFu4rTmHVmStcvDtmBIAERXuZhkWShxKinjDXIFHLjMubHWAp7SKMMDxhvTnx1oPQkkJDIWpByJu3XzTNxJWqTx7eKjdweA+ElfxLJIDZpIWh24gU/DbIS/xyvDwBjU65ABM1FBJkR5rAqauAsOivrYjDNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114371; c=relaxed/simple;
	bh=S/XkABUSw3IjS7izZzSRw6FqGpQ25yxbBqnHZQBSTJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+otlPwEY0cfyIyEnq2iIW+ycP8/ErfZwkJUVJ9aR7LKEhcdX57mP+GRFdtov7HPtLD4L2LW8qUazUrtl5WtGpib7uah+BaQfVZsf6U6Nwt6l9W28+eFIkQRZREjpt2kRZwo9oYPSq3icvRjLcm9GktMirBLeyS0RJe0OoNR6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49d37980aa9so103065137.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 10:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114367; x=1727719167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVGGLa6NOWGGb1e2cnRuuHh9ZZTHW0BTkfXMWCCsIow=;
        b=B+ZNXtqDSqvGY+thFoIuewolfjBplc95dySJupl/TLF5ISWi7srlQNasjK8quyXwo/
         vLMkfBjh8BAF6Cg3vdsgzZlboQtape9ZZhMAnSgrHCpF1mDPwJK6r4jEXswNvELVdHkX
         Nr9YMJZV2hKlIDHdLDnlWUyYQZjQvabZCkTWEc/KKD8+vNGvEOjz2m1VnyBrRXvRn+Y5
         zvUlaz6pcDGE4p2PM5/ipfPxFBHKf4h0dpVibXEjhRjE68sIg9OBMNgTkD/bet38AH9y
         xwnfO89DD9C/gHT8fp0L7kc9Jc9Nqyb3yfQ+1WrgiQhHFPpGfga9mUHcZt4BaU+JtPmw
         2VhA==
X-Gm-Message-State: AOJu0Yz9LHqQsrYb2C4c+N2D2+TOee4msXZw8XoDAyc/WodIuPpFC0RE
	XvPQiv4a9OyMbecatxWpguDg5r2tlLfmJeaTcm9/1nQQYXT7EeZNQv+ehGB6SVCVNLtRKoc7bHv
	5JygFxMOp0HY2bBABi1cKr5ul6DA6nU0JVTQ=
X-Google-Smtp-Source: AGHT+IGHzp990+/9DifsVHAfarGGdalTTiK7jlvqc7HLOZCsBhHgGPzwTOPh3V7dMKgnBRn8X5Zk6oJrZNwQtCsZS1A=
X-Received: by 2002:a05:6102:508c:b0:49b:ce62:133a with SMTP id
 ada2fe7eead31-49fc7511e2cmr3638054137.1.1727114367528; Mon, 23 Sep 2024
 10:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110343.12388-1-algonell@gmail.com> <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
In-Reply-To: <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 13:59:16 -0400
Message-ID: <CAPig+cR5BdfVRwdXJ7viJbvgkUW7KStG2Y_=qGNzoXWrOgZcJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 1:51=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Thanks. The changes in v2 of this series look fine.
>
> In the future, to make life easier for reviewers, when rerolling a
> patch series, please include a cover letter ("git format-patch
> --cover-letter") and include the following in the cover letter:
>
> * explain in your own words how the new version of the series differs
> from the previous version
>
> * provide a link to the cover-letter of the previous version (i.e.
> https://lore.kernel.org/git/20240920082815.8192-1-algonell@gmail.com/)
>
> * include a range-diff ("git format-patch --range-diff=3D") which
> provides a mechanical representation of the differences between the
> new version of the series and the previous version

I forgot to mention email threading as a way to further help reviewers
and readers of the mailing list archive...

When sending a reroll of a series, use "git send-email --reply-to=3D" to
reference the cover letter of the previous version. If your email
client doesn't provide an easy way to access the ID of the previous
cover letter, you can grab it from the list archive. For instance,
consulting the above link:

    git send-email --reply-to=3D'20240920082815.8192-1-algonell@gmail.com' =
...
