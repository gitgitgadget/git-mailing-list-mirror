Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97ED1482E7
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353721; cv=none; b=lZI+SxbjlJbL0LjIDR7wl37t5uLUzW0q/jK5NhNVYG8AfXE6Y53EBftZUn6/3UW5l8bFCfnaK/hjMbPxnDxNyYfRArY3K4uQNb6Fyq4DiYr9/eVGfhXyrC6crsfuD7FaQRzoZiUCqcGN2M/PFDgOBamH/Pa9nFuAOm1e9it9ITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353721; c=relaxed/simple;
	bh=prDcqwLIZzrwHEVYJrLAoIyOWs6hQtYrRmu9XLUjbR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPW3EhsSdtvJnzJTIVJOT1UI9e5yFqvSnjOwdKWR9KKjFc++2x3GfRH8iGdQ6KHYi9qYwBCzG7swUdoxrDe2TSagpZ4mkzIqyIKDSA5KSCiFEEyef2xJZvH9bGJW72OXuIO5mFu1M4jycLYGpcYVkUlOn4hJG6T//mYRBO+I2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0mwkZao; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0mwkZao"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so5750545a12.1
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755353718; x=1755958518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHgOsMxaz8UTLn7cVoW9ety7lMIJ1OObClZDHLeHHvg=;
        b=J0mwkZao4RXvoVilfmq2Qz0RDu2DOCEXO2e1FT6M1F0qGLHuITQlRWcI7Ueeq8asMQ
         ot6OgiFXkVx6LI0R90tmDg+w5+cFQXszOcryV3TQUsMdtT4HEEWbT+RspFqKxfQt8DCW
         r3qps1TBOUCN7upWtWvoLW6kf1qsK7zkrb02zVBGR//ORWbDdWOWUhvMy+gvk8nBB7Os
         3OhLuY7bYwwDXqT7Tbhel+6pW0Bq7jxtU0iVU/61VNoGpYbRWrWuGxfNkBe7H8v8/aLd
         BPlaCZotY3ECHlP3bjzWV7seHJSFluoG+iwYZw5dqBZ5UiwJJPip74x0cx271htBRO1O
         9/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353718; x=1755958518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHgOsMxaz8UTLn7cVoW9ety7lMIJ1OObClZDHLeHHvg=;
        b=gxPqFAwnejnw1LbHzCipl2EGx+7bxZO5eJFZ3WRsy2W02gcyEZqE2Rbbjv3uzSyjk7
         8B9Z1cklXNCh8JkIV4ywutUK24AywWAB9UvPOPrYsO+UVp26Z845v0AsC3MKKdWylpsb
         c6SYF3WXd33hSnZCAvezeY0RnrX6sIaZN76YEpb1hbomm/DoyFfVynM29zsa5lg6vQsv
         qtmBtfNEl5h1fVMPSE3qINlv7Dv3FxcKF3ZMTmMqDtrdCvephGGcZq6UEzXTKd4Wp7C6
         y0U7cm716/jxplVUqHZY6qCqFfkQTrTVRcWtzBuLouNc8q5ibI+R4y97qHcFilDOP51S
         OAbA==
X-Forwarded-Encrypted: i=1; AJvYcCV5LAqQilw/xtB5GwIJxB5WiEoXkcBEIMBHknREMsOh2WIH5FeXIkZpqGnL/Fjd9CeNCHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUiwWxvKrDv+3Si3DV16JsNfyWywrb+yCn+Qh5gVZW19TS0oM
	armfOotgVZzN/vgR7yJPO3CJGLUP4M/cjtx5pKITCQatioIkBea7DxjC16WX8a4DUalTIN/P9E2
	BYjEHM3Mi2VmRpdAW8pXpeT7PKmsdtwg=
X-Gm-Gg: ASbGncuddcbVOF1rk9V/0Jz4FbcQgZxzQs2QtH6P9d54FVKp+iJYcZ8u2EkfrjkuBq8
	oeu2ceBtCM2b46x59+1zw9khdbYkoa++D17q/hSbhmwrpChjyYYiKbNp1TIap++GrV1iLn/9sNj
	vIrNjaRuMruO2F9cR82qgKo8vPXkJvM1a2lbqs9o0AFUqx0Eou8g0UcGmNpjdvOrSadN9nUxeXh
	5bB14HV4+DKJhyT6QmjamLw1t0xXYgCOXLSHgpL9FJxt4SPhmIs
X-Google-Smtp-Source: AGHT+IGhfBq/SZQakiRsWF8b5QGEGj5eLnEkHYbrwzu/AhMax3KFOd7A6+fDyz00lh3lJz46eVuXnMUpln7HHbpAzTk=
X-Received: by 2002:a05:6402:90c:b0:615:5f47:8873 with SMTP id
 4fb4d7f45d1cf-618aed1f8admr5064049a12.14.1755353717987; Sat, 16 Aug 2025
 07:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com> <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
 <xmqq349ty254.fsf@gitster.g> <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
 <CALnO6CCvL_wc9tkjHCa-9wp7fJMVDt-WHvHZnuOai5HzZb_j8w@mail.gmail.com> <xmqqbjogpd5a.fsf@gitster.g>
In-Reply-To: <xmqqbjogpd5a.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 16 Aug 2025 10:15:04 -0400
X-Gm-Features: Ac12FXy2qzs0h2rYHfaMqcFMxh8S4XUZ0S4wm3zqudVE97ENNpxZ9pO74MoBiZY
Message-ID: <CALnO6CBNius_WJS=wrTHDHaQEeAd=tRHqFC6_MSJye7sOgr93A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Chris Torek <chris.torek@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > As Junio likes to say, a mistake being old is no good reason to carry
> > it forward into the future (or replicate it).
>
> I say no such thing, though.  What I say about past mistakes is that
> you shouldn't use it as an excuse to make similar ones in the
> future.

Fair; my apologies for misrepresenting your position :)


> I'd prefer to let a sleeping dog lie.
>
> But in the context of this discussion, I think what we carefully and
> honestly need to look at are not past mistakes.  It is importance to
> adjust to the new world we live in.

Agreed, and I could have made this clearer.


--=20
D. Ben Knoble
