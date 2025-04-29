Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76421CFFD
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939569; cv=none; b=KEgc7eQ9L1gt1zjozPyrDbANl81fEp7ey4EnuTTzXL5wNwICOpvNQZJqXU3W7CWHxf9CO4eHx+U1nFlYHo22nxTh+XGkqOFBRRLjLHubN8kIq6ERFdwKsGJSdM4oqG34GHskqBpfeyDfJ4P0McBBYJHLzFc1n6h39FPQ8ks4Lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939569; c=relaxed/simple;
	bh=/dkIV1IjDz2zOv9XPu08kJT9GX2Vf97wOcPfB6sUppc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh2YAPPMS7Aic5HFJW0Zt+vXAshmHFumud9kwN4FWTDoe3nPWUB7IHOGrqGIXYD1cwlDsNLbxzdYNDWuAY9diDcRyZ96U3I7dqSbYQQfDNf+PwI6jIbsdGiqzyD3pPUXgCSOk17V4zzpSLG+TJptyUaoTnE6pVqBXBkNlAHefKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8fyeE92; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8fyeE92"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f728aeedacso7026476a12.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745939566; x=1746544366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvnky+D6WkpqOoAL3+PIBKxJKJeLHrVSuCYH8wnN7Sg=;
        b=J8fyeE92dNQ7J+71acwacxFhpLpkKgbzDEg0NcgIm49rsCI9UbDCI0DiksiZSBXdJb
         kc3Nc9GKqbVyJwAM3s8mOIjKxYJPx1KL21wfUzreYEGAqyD68IcwP3h71omB0Q/2DgsI
         A0iI/GEjDSyjlxwdnCjx4PMAewrYtbDeW+1pHzjql161P7M64Qq0JXY+rWZMGr1c2BL1
         dKcp/xtB3GwyDWPqOpzM/A06Ag9To13YIHX1Gv9Zv3UrLATHnKMS3xpOGAa+MDPC5HKs
         grGG3MCrB5ZZFe7D1/RQNhS1DvZ3TqivEsiyXRkCEbduEs8AncpgzzwPR/4nVe4YfCf1
         MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745939566; x=1746544366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvnky+D6WkpqOoAL3+PIBKxJKJeLHrVSuCYH8wnN7Sg=;
        b=RrW9vDPCJLqsnf7re4K3pNKyg0UOyC6KXMIX/YEOth/M6fuky0SyrXCcsf4RkJBQYI
         Zc/MGmsieA0GWoj8jyL9CWwVOoTGtSLYtvuIGPsu1POrd52DxRoYqZfMMcbvQtrQzk7/
         OW5APEzPfeeTpq2pc0JrjaNZm/LpKh6jz2Z4Qa+Oc8WMBi35/phuQKqWAssuSVBNVQRe
         +F8Yywst50/pVulLMRXiz5Vr4nOia0uu5S6nxBd8ZZF5zQle+E1f35X9cBYdcK6ZO9ag
         D9hoh4vDO/UU2kOR1NXqxbDvM/1SkHaZ5d8A1kta0szp/BTDT7tRszlmcg5kRb16A1AB
         7Ryw==
X-Gm-Message-State: AOJu0YwOdvfHosjRgeJ9Ay+nU8CjyFhrID9Cybq/kuWSF6b0v0a+nWi3
	X3jJi5+y2qNkW2Rk07oNRrWTyZLex0iV6T5TzpKPj++Zp9m8Aiv/e1lO5Wn7MCQGAQqiB/zJNHv
	pFx6W8S9V8sY8lJwJA2vhnp5e7AE=
X-Gm-Gg: ASbGncuossE5XYKeQfcKJ1CB4NJ0cL2HSJmXI18jYGYdY9HT5DcRa2G6HpdUvlwryel
	5SUMYu+ZX3OiRXZx4daKsgLM9SLCgFb80fJ9yRirh5ceZsWsSa2KEjw4ZthRUugismZaFnxoCff
	VvGa6nlQ18qxp5/e9oCLeMGk5XHKCPlsuTJphlZKjeiYaFypSLtYk4kKah0S2meCD9
X-Google-Smtp-Source: AGHT+IHsh9XETG0bBIOaSOeGiSHHJRTCZ0vgISVxuwbzYpw0IdzyA7mFWivcnidLe7/GYhhlhxe5Rr6niU/qxwlFCkc=
X-Received: by 2002:a05:6402:214e:b0:5f6:c5e3:fa98 with SMTP id
 4fb4d7f45d1cf-5f83889099cmr3338158a12.27.1745939566382; Tue, 29 Apr 2025
 08:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250414160343.2216312-4-christian.couder@gmail.com> <xmqq34eapfhk.fsf@gitster.g>
In-Reply-To: <xmqq34eapfhk.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 29 Apr 2025 17:12:34 +0200
X-Gm-Features: ATxdqUEOBMuZgEdQh1Fpf2hVjp6P9g8RoLvv6r6uDMGb4T5l2YoiFOzN4YWCHAk
Message-ID: <CAP8UFD2WBqEiSB4YxoDCPuC7wyV81X-pPrLMJiEsv_kdktdEBg@mail.gmail.com>
Subject: Re: [PATCH 3/4] promisor-remote: allow a server to advertise extra fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 12:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:

> As a description of overall syntax of the protocol, this and ...

[...]

> ... this may work, but as we are defining protocol between two
> parties, in order to ensure interoperable reimplementations, we need
> to also specify semantics, what are the defined "fields", and what
> each of them mean.  Proposing nebulous "with this framework your
> imagination is the limit, you can invent anything" may work for
> other parts of the system, but not for the part that is about
> communication between two repositories.

Yeah, we can specify a set of accepted fields and their semantics, and
that's what I have done in the next version where only
"partialCloneFilter" and "token" are accepted so far.

One issue with this is that we might not know how user systems will
work and what they will need. For example if they use a special remote
helper they created to access a special remote, we might not know what
kind of credentials the underlying system on that remote will need, so
they might be tempted to reuse some existing fields that weren't
designed for that purpose if we don't make it easy enough to add what
they need.

Anyway maybe we can deal with that problem later if it ever happens.
The "token" field might be enough or maybe there aren't so many kinds
of credentials so adding a few more will be enough. And yeah, it's
easier to be more lenient on this later than to restrict things later.

> IOW, we shouldn't be internally calling these "extra".  From the
> point of view of "core" they may be "extra", but to the developers
> and certainly to the end-users, they shouldn't be "extra" at all.
> They are all supported parts of the system with defined semantics,
> right?

I used "extra" to mean "additional" and "optional", compared to the
"name" and "url" fields which are mandatory.

But yeah I have removed "extra" from all the names in the next version
to avoid possible confusion.

> Another reason why I hate seeing this nebulous "with this, we can
> send anything extra" is because such a thing will have a wrong
> security posture.  If we truly *need* to be able to carry
> *anything*, we need to make sure how values are quoted/escaped, and
> the code for dequoting/unescaping are robustly written to avoid
> passing malformed input and misinterpreting it as something else,
> which would give a new attack vector.  If we can enumerate supported
> fields, their syntax and their possible values, we can make the
> attack surface a lot smaller.

Yeah, maybe it will help a bit security wise.
