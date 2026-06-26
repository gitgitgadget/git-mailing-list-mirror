Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B726E173
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456940; cv=pass; b=P1/HWgMmDfj2JryJ8ujWiuSOdaD7mzLYT2Uqpkk0qSSC2JhMTdJQdV2rmW8XToNsq5jqA3g0uwYJXFVCSmoFffjadawnE+XTFSCkxZulMkZHx91GYyAO5e/82KCrYAAh4Nd+uSJYtEUWsMdrkz0FY0wfoxuqy2KSVi+qipqC6sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456940; c=relaxed/simple;
	bh=XdURFk/XSYb2Bd7ncWux2kukG+IOdJbRAinnXkvjG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajGjlYpOdm3VbjAc0X4Skr9GlJ6beG1oeP/8Jxqb6J3BHyiFXBb88NDxyp/JzU5Tg/LjAN4Blm83GQmD5Gmdg5/IVWqL2zn5Y2bS5ifgZnpZE9cPcmoETU3llriIe15dQFc4N2P485lvdNdBLsdeXygPpUh2dG03E2W3hlaVAK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzjpN4IQ; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzjpN4IQ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-139986373b8so894242c88.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 23:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782456939; cv=none;
        d=google.com; s=arc-20260327;
        b=k7V+Qu3mHkehEDKYe53V4KX9B+vXg0mpOf45jmNbcfQTvaWNn3XZFjd9bnkFmM+PSQ
         so0mvBrl/sDPtsBOhls1ZuOH56pyxyLyTHJgDTcVJZMZJZobfZVGRRqxrBFLBJ9zSyu/
         AW5598bkzy3tibju7YeH9n8nZ9XsjfkrkYynxYHD8NlmMbttq7+eh8ggo79gPIRDlz0O
         9rysXaW4uSv2tFCi/kSCu9EA5HpKWtkfRP88QxM92lqVGVAh+MwIOH3jnyliAs9U8NHl
         lgZ8830gZ/H4OY1FRwBFCZInYn79nTmb+t4d7ezJXrgq+RxmKKRrtPSr1m81LpFIwI2O
         u0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toxN52TYFSsAZ8GrY9DOxB/sy4UPNYOkQJHZUMjWPRI=;
        fh=hd4Sl7fGkZarfkXPqKbHFchy0GdzTTinacGKbcjG65U=;
        b=FNVbOUAEsr9l6SLlRLD0mso6eASChaPg1p9U2kzPt16Kc42MnH48Zd2PalhEA8wEZx
         Lm/9MF/wmRQr/GGeIRQQpLI+Zg77xSKesynvnjyNQAuv0NWZZwvMqQfJuZFLMuZpOKhK
         Wu1lemsgd9DXdttO305dGAXgfn828MgIs6XeNxMGgINnUUHoQIa2NWvSXmGKtsG1RKbH
         sbZSmimAkt7Hs840sBZjjfw6DQeEvppjILhSAMlQuFq0nItJH4MgZfFgk3x4GQDEtFN/
         yajXYxBkHq5TrxXL8IUPnrsEJhLYC8T114QSnKxfYta+mphLWRJgFXP9o40BGfheJxDG
         e+Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782456939; x=1783061739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toxN52TYFSsAZ8GrY9DOxB/sy4UPNYOkQJHZUMjWPRI=;
        b=GzjpN4IQ/GLVyXD/E++evo5XGy3+9X3RfeJk+lAkMH27Rnv4A9gigmuL2c2g0j150j
         KMVSbznb2tfRwhCjKUVuXmH9x1LFONrx70JKCfFd3J9esZ7d0StZQKd31XF7qYdOxexc
         TkUi5YcJdymwh8g4FagxgC2moLxE4dPuZCTozQjMXsZmD0yCg2bTF5BucVb1hQDWB8c6
         IyHKcQ8WXFF2uF5sQuwhf/NGZ/Mp8p8NtUHhm8JrEffKWpYHcv81MeSA6A0eD10ijMre
         0aZJaFxgy4+CuecELHzF/QZpyilTX3+1dagU0ztwXCToDopLoBvfCcpLJWMx5auLJctF
         Fn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782456939; x=1783061739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toxN52TYFSsAZ8GrY9DOxB/sy4UPNYOkQJHZUMjWPRI=;
        b=iO7ib9mdDUcdYi4L3qTYU+wSim4xZWU+4CgxLUG7i+mt5BqB0Sj7gpoYF1MVw2SSfV
         9bwzB2gXRTlENt8BYLLqZgmgdS+SCVSAcodo6yo7YMrbA3nFFlLV2wqZqZ6V1rdh1i+P
         N8arHW3b5e2R5kqyX1yl0pnKQnoFJlUp91rkMalR6Tdu/SpUkTxeDpDR3GMnOHzE4+X1
         cFx8nrrO7mS7cJ0AJPxTo0mWyz8+gjtC8NT3zFskbFmNftZkxT4lPQHFy71bAFWY+cC5
         KxlZn7gaS3/m7k1sF/5mZ4qghkXwgdPa49iSyJg1wIkuroIXXIED3L/JhFntiyCs5p6U
         DP+w==
X-Forwarded-Encrypted: i=1; AFNElJ+eZ/Ts2fbE1XACQXkT0PKNIpmFJPeG1wHCu3IY4NKYwEZbzcZ9CEHH8QCRQTi97fCeu3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdXuDFPVqWEq9xZmBAoMrupOIVwAIt4pwgrNv4iPMT//M783A
	2iegeLZwaLmLwtg/a5/kHH/TDOYC/gB8SNmAAonlct5JmQdJvAilqBlDsbqBMGaQ/BBeYkBK4ut
	zYbuDtzHU5EXxw0/X7TVNQJ9llUWKTcw=
X-Gm-Gg: AfdE7cnkg9oftwLHJ40RkCdJHRwa0GVA6iPV6Z8MJNTt4/b1KcsSijuMdACu4aHoyXm
	YIzIw/VnJh8A3Lpru/OJukK0ohF4xp75hatxS6YX9IexAMdWJ+w/BNNxyx2OLqib2r6J/UDhBZk
	5leAHVK7QlyBCMjnF6616TenE2jTIJPGo0FRnDDp3KSZIYqyztZ/pP94nWy09sxw5BUkJGn34Gs
	QOeziKfZntx3NU8pqb7Ik+J0JPsc7zkUyCt4DUjteSyTJ4MpCNAnRxKm2DZMV/rcORzpPVr50r1
	yaqQWqkUAjU+5TQi6E29w6QAkPq9QhRRgeo5C2k74gt0/WecpF+kLfkL+w==
X-Received: by 2002:a05:7022:788:b0:139:819b:ec4f with SMTP id
 a92af1059eb24-139dbb2b288mr4782465c88.14.1782456938759; Thu, 25 Jun 2026
 23:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
 <20260625-pks-connected-generic-promisor-checks-v3-4-7308f3b9dc44@pks.im> <xmqq4iiqfk0l.fsf@gitster.g>
In-Reply-To: <xmqq4iiqfk0l.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 26 Jun 2026 08:55:27 +0200
X-Gm-Features: AVVi8CerriZB8ppZjBDP0JrS8Olu0dEq_frPfx9ZQ3stWD-INhBGFH05R_767NA
Message-ID: <CAP8UFD07AzNtP3rRj4btYfFfakX0kkLXKpO9T=a3Mds3YWEsXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] connected: search promisor objects generically
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > When performing connectivity checks we have to figure out whether any o=
f
> > the new objects are promisor objects, as we cannot assume full
> > connectivity if so.
> >
> > This check is performed by iterating through all packfiles in the
> > repository and searching each of them for the given object. Of course,
> > this mechanism is quite specific to implementation details of the objec=
t
> > database, as we assume that it uses packfiles in the first place.
> >
> > Refactor the logic so that we instead use `odb_for_each_object_ext()`
> > with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY=
`
> > flag. This will yield all objects that have the exact object name and
> > that are part of a promisor pack in a generic way.
> >
> > Add a test to verify that we indeed use the optimization.
>
> OK.  The new test is a good way to catch the issue we noticed in the
> previous round, I guess.  Looking good.

Yeah, it looks ready to me too.

Thanks.
