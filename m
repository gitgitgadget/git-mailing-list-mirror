Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C7264633
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209774; cv=none; b=PJwk/hBEWN3zHCrMUmeSc2mpVppoUr/wub/M1FIl+wOrAS8ThtBpR1capF2l+XdjYNYIcfUUTPDlzx7WrxgxXykjlu5uYx6ExNDQ4ueOBJ0xoUsu4sIIvHIMFzL0KnIquj/sEJIMmM2mVD+zYJppcTCVp+cStpG4cThyFigFEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209774; c=relaxed/simple;
	bh=8P38s/QPgVLXYg1iSNQugL9bYBcoooYnnMJuRNmX2rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAk1dDLFyKWy2dTk8lp3jsyfXBaO3OfQE3phA/mzo4lb/6ohn573FJxkaYJlFG2bQxbksKk4nEkQ2QZcF3UwVc80plybPEJ4UMJXXG9HBXErjUNuFW+Y+sZF2E3P0kX1+Sf5I5rW5f/aLcdXU+AJx7M4dL28rAUCnWGBC/8Dtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj26v/rj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj26v/rj"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85e751cffbeso531184639f.0
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209772; x=1744814572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRxEqBVd8oBCgS/fCCVDdp8l+CzanO/PZUPGo8xEqsw=;
        b=Cj26v/rjWVHMfHimw9KrsXdqb+SlNaZG+lPuq7IRK9P65gzlLzEDhlhP27sKDyIkwA
         /7rtgh2PMVQfe+HpE0WtynigAjNyMpe8l9LKw+nyNLRL+7ldfezFJNRYHcbtVLUYs0bZ
         gC9cfgxyMdBOzMIQ3nQFmw1WLeWwvhAkZxfegjGfpdOYhRIkI8FxxpsgqrwTLPA0HIQW
         +N03+JyvVv+yIXRqwGVEqUpaIw7nChZ11yc7CmRsiLvxik3gJcIt5kfk/naEIEVyS43P
         y3s1lRT5pMcFw8Apgs41IJtWvbHeYy4F6ujkZXmvrJclotj4nG3VHhPkWkrWKKybNw4O
         uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209772; x=1744814572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRxEqBVd8oBCgS/fCCVDdp8l+CzanO/PZUPGo8xEqsw=;
        b=eCgQrJjw004Sfqu3lhZGUgYPfg02ti+m+0sbXtlNPrTNbnsGZ4yXg4c8SC9FbLWgnI
         QUYDlGVnYXyJ0J+F7XHBi3r562jvrdanGYPYdkR5SgHxeLXsj1/XIFNcpjV7kbL++FQG
         SbcUKUhgNv+3XpqRHICp19UoHvMd5xpBpRKMGwRScaGg/5ErzeNm9NUF+WxxEE56l6wc
         SEx4bGkFabwNHToF5guwdXBF+PszXAou2aKgMmzlnvfgXE3gUgMXjXifC2HoVTVsDzT9
         iJ86DivPlk+Ufk12xiW5TORGD/8NX1RthOnA7sD0jtu9ZIZ91vbA1gdWjngectqj+707
         UBIg==
X-Gm-Message-State: AOJu0Yyo9UdIJAIKMrPNk56+8h8TwzjSW7Zsj2KFtXsmMwXuOMORykgq
	mHsYSy7jyJsY1veVpQNZVJgtm34wDQDBS00+Lx9IK6KwkDF2VOOWYpoBU5++mgFfJtAZXoQh3tI
	RMMSgk03REjtUt8b2kJRCVE1gWmNsAg==
X-Gm-Gg: ASbGncsDXKKh7VxAz0qu6NWA9UjqAMrFgv0397AQE0E1TpthEiKEgYYDDJBeM+rjWAL
	CFvwMsrUzwiJROPM9kL19JOZkghE4/rDx9n0liw1AzYOY84uJDg/ABL+Qklz1Mw2Y+vY4A9qpTY
	efEeWKidtbp0wsG4JuwLWZrSPDe0iUy/b1FJiBQtNicCN8YOU2ctKRJq4=
X-Google-Smtp-Source: AGHT+IFhat1ewcctNN0aYCzZkzKiuMP43CW/m+aj39pwMuDouMY+K+Co43fSPOWpXBEtbYVWa/stCC2VrW8RsS2kVr8=
X-Received: by 2002:a05:6602:7206:b0:85d:115b:bb3f with SMTP id
 ca18e2360f4ac-861627eab05mr342209139f.6.1744209772190; Wed, 09 Apr 2025
 07:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Apr 2025 07:42:38 -0700
X-Gm-Features: ATxdqUHyc5VClf2_KjkrZiB4R9rrr6UfSb2VOMiXBfWgmlItREwuGjx-J8OIfaQ
Message-ID: <CABPp-BFv_WGVUexyQBHkCcyO0N+UQCcJ3eM9Oh6bP_ZCUkaxLw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Split up "object-file.c"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> "object-file.c" is quite a grab-bag of all kinds of different functions.
> Many of these functions aren't really a good fit though and should be
> owned by a different subsystem. This patch series tries to split up
> concerns a bit better by splitting out this functionality into other
> files:
>
>   - `safe_create_leading_directories()` is moved into "dir.c".
>   - `xmmap()` is moved into "wrapper.c".
>   - `git_open_cloexec()` is moved into "compat/open.c".
>   - Several functions attached to `struct index_state` are moved into
>     "read-cache.c".
>   - Several functions related to `struct object_store` are moved into a
>     new file "object-store.c".
>
> "object-file.c" now mostly contains logic to read and write loose object
> files, whereas "object-store.c" contains the higher-level logic to
> manage different object directories for a repository. Eventually, these
> will become the loose object backend as well as the `struct ref_store`
> equivalent for objects, respectively.
>
> The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
> with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
> branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
> into it.

I was able to apply with these instructions, and looking over the
series locally with --color-moved was very helpful to verify that you
were moving functions without modifying them (or, to notice where you
did modify them and why, e.g. removing the static declaration).

I very much appreciate the grouping of functions by area that is done
here with read-cache.c, wrapper.c, compat/open.c, dir.c, and the new
object-store.c, as well as the new enums to make the purpose of the
HASH_* flags clearer, and the reduction in the number of globals.

I only had a few comments on a couple of the patch commit messages.
