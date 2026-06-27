Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945433A9E8
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594202; cv=pass; b=KKSf4HSkWYCZYVGPaCsVKuAhUGLfOBkGeq8LUxuaRoCyq54wjbvn6zQrvjhChtHe3wjIzQvWkGNl0DT3RuKizp2Qlwt/oqpULO8Q8/GbgsQ07MP7h09S0D09zpF77YrQQ8LvRJHo7wPDiTnAmy3ff3fhXRstN56SZmSt7N7fJ40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594202; c=relaxed/simple;
	bh=wYivD/wuMzXNiXQGhDlZm6lkerApsc2VfyVvicMwyjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t94CpgvGHeJ3yiWRuvJ60VUQFLDrwhSBDUW1+T/x0OXldgBiqNJA8ZYcXwhnvSoEa/PM8EWZik2nb9M3w8J6N/8nN5NCztB1jqME6PlKhTDQCCJqEbLkECY/UIVhXQz+K/oJgXMIzlXkY6+nXlBqTgIZdXVqX8LWkoMJzUR26KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpJpByhR; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpJpByhR"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80dd4766206so1842057b3.3
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782594201; cv=none;
        d=google.com; s=arc-20260327;
        b=lV9f+4Q9LKlO9PLgDDn85PECNGdL7jRCwGKYY9179xsx8ABlyP6+1trxyOpPk4gb0R
         T+q+pN7IBFzkPXbJPDP+P4AFuXEZq12iPbWlbtjZRXe/wkT6yJMcw6B3hd73Mo1UJpfb
         ohsGCziywsDQORcSR4tVc9wOJd0568JNmbvlaEztK6HsRxiSjdEeuMsWTpCtP0qrLxkV
         iGu5KQZg39a/m1kVvCa4+Nq6qEiko8DTEtvZvfX+mhq7Sl9rNYeg0e+e2jOe93aX4cm3
         9YZuJuRTGqyEJNSzk2EftGeYtj+6PWMRl430HF+YjkQZ0GWMIsS3nuTS5F/hrp2Noskr
         K7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jjiRZRyo4+yozINlZy7pk2/D4a0q6qk8/fBJ+ZdtK8Q=;
        fh=II1xNaWpsbGGoje1lWhXs73nMC4GzAl4tRfC7+O7yrw=;
        b=qSvrLhiQnwxg4J0NeM05LQUP9IGxCMVIFBiPVHCUcai60hEmsoBIImlh2KbKH7VCkb
         ygvN82Gwygp6Xc/XlyCPfsmUrNsm+lRpYetb3GQFwCzooWe/Abfzm3ZMKABI6gA7pYh3
         kHGudr+265G9zrc3yVdZzNaddCqI47rvXDKbkKQPTDhErQlVQAzvDSwWGETdMfIa9zZ1
         863gtfcQq2e8GSgxGEDE3PY4kLVYe2Gya+cYBs7cze4SScf8FleAdKqS81/bB+QSNMm4
         nbKJXPpmBPBjG6GcRx3lDxN5ZevkVrC9SNOtH1d8a0tEltSdLgxb2bOI0WFesmS7j4py
         trdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782594201; x=1783199001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjiRZRyo4+yozINlZy7pk2/D4a0q6qk8/fBJ+ZdtK8Q=;
        b=KpJpByhRMlmSvc/RRx71jIlX68VI8+DtqYhEU9TGdGQjXb8reg737BQRUghs88oAPq
         XxP7IUdelVkA384OZ0rL+sW6y91Pk/M6sotgqYu0dsn8u2MoMKe/LsbBWplhxevyvMtT
         kkQfYJDUM9A7pORQcXlhke4Bo1PoNfP1NXigpr+7ntl1Zads/JT3cuWXxArutEb1+fPq
         pe1DOhNXASlhpHVqIJ5I+l0l/mJtcyYum+LPsZMYq5bqZLbNNkutKqOi++s1yL6VzyeQ
         zXaJNJSi5IYL0QQP9x6E6uT+CkUUW4Z5hzdHr6XpX0cDUBzVEqIGZefn74AsV8sROsiq
         6V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594201; x=1783199001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjiRZRyo4+yozINlZy7pk2/D4a0q6qk8/fBJ+ZdtK8Q=;
        b=YOsVsW2pOm53aG6sPT0ECzySg2HAyN/BGZfjf2NFmqrS9PVHu/Ixq1K7mILHdLVHuw
         t9V46+OX9WdtfWgZD452k4rfdGHhDKyR43RcjIXRhuSWpTvveIRaQ8kNEBy3Z0V2UUdy
         b+y6alfGZqwLnqq8vKTzvctPLIOdO9Df/J+rdMo43QVO/yb6aADfSqx9vEH4tGO7svQb
         QNjAbofBbakypyVrDw3QtsQ376o5UuuLU25oAm049BOfxxyzSm8bZE8LXK2iuiCRH2j1
         5wclRmdV8FbIQRw0r3fbIdK5DvIXuFWpNm3qLFBlN4AQ051fQN9Yqob/BGrsRGfTFj20
         ZAzA==
X-Gm-Message-State: AOJu0YytxXPba4lqLot1YaRX0s1TITcMIJ2pMMcJYX71FF1A/osub4CA
	sZA8irN9MvL1JAdk80jQVkoBwY2PyeUDDWfC3sFgqo+E7na1yc+iTB0t+QRbNFr92hmh6aLuyqI
	1AAApZlT7k+Gj94HENEY78wy9Dz9aBSo=
X-Gm-Gg: AfdE7closZ1HHeokKWbQbvp9EhaAdEXEbgsEAREndaB+ql0gbkgnJHkF8wts1vfwJ6B
	cGlP7UC/3TcndP3CYspZbmKG1qSXQNqqfrJEft83x0Q2s6nu4sbLe2o5JqDYDddm0jMRxRIa0c/
	UukI2+UZ3MO5Dz6rKqarFUhsLDtgUUAvKAkmJMxZgy/LIeIQ0s+UuXNypW/k/7ve1LXrBgyZ+sp
	l0jMCHE8Gtlu73/lJgedhSJKb8UuBRpwkoy6NzZXo5UH9DxRKSclDfdKel4k37zIjyfvm8p4pms
	aR+SGHtNQugBvdIX2DNVjlBsgoF1UqGOSAoDFXXSVKsFpkVKP0E26f2DKfhQS46HPejgUFK4uQx
	e2Iw34UNNtCafg0C8jhh3abQtInqcG/axIZ6wvecxsKkNruC8kdvBHEtS7e6oYGTw8oh5gg==
X-Received: by 2002:a05:690c:368e:b0:80c:1df8:7c13 with SMTP id
 00721157ae682-80c73af11a0mr57865287b3.31.1782594200606; Sat, 27 Jun 2026
 14:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com> <CAOLa=ZRhCXBQN7CqwLyE2F9u+oqAsqvcFP+fuiyw4SVaSDfT6Q@mail.gmail.com>
In-Reply-To: <CAOLa=ZRhCXBQN7CqwLyE2F9u+oqAsqvcFP+fuiyw4SVaSDfT6Q@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 23:03:09 +0200
X-Gm-Features: AVVi8CfX5xJ0Rb8J2sj9y1Wu-jO1AwqiyhDkSs4xgm4TJESuwVc6af6Urs7681w
Message-ID: <CAN5EUNRP7ZBxP-Q_eWrjdh5hY3+WC92nWPhyjYScTdzZWOkZcg@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 06/13] fetch-pack: move function to connect.c
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 26 jun 2026 a las 18:57, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> Nit: could we mention the function in the subject?

Yes, I'll mention it.

>
> > write_fetch_command_and_capabilities will be refactored in a
> > subsequent
>
> Super Nit: Some parts of your patches use backticks for quoting code or
> filenames and others skip the convention. It would be nice to be
> consistent.

Sorry about that, I'll stick to backticks always.

>
> > commit where it will become a more general-purpose function, making it
> > more accessible to additional commands in the future.
> >
> > Move `write_fetch_command_and_capabilities()` to `connect.c`, where
> > there are similar purpose functions.
> >
> > Because string_list is only used as a pointer, use a forward
> > declaration [1].
> >
> > [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  connect.c    | 34 ++++++++++++++++++++++++++++++++++
> >  connect.h    |  4 ++++
> >  fetch-pack.c | 34 ----------------------------------
> >  3 files changed, 38 insertions(+), 34 deletions(-)
> >
[snip]

Thanks for the feedback,
Pablo.
