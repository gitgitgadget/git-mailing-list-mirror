Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907D177990
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336717; cv=none; b=dEEXjp5tN5pRDSK7Q4scbhssGi9pY/Dlgxe4Xe7U8Yc70zizIKsWNi2iZhHHQXvYDghbneRDumsospqMahm6n9WC2Fhf/zGKbghFbxxxLUDNuk4uzgeppam8jyXDyrAYRiaLYYTSm6J5leZWVJPSItfObkn8zV1osWRCGCvqbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336717; c=relaxed/simple;
	bh=wAHqtWkMtNmnn2nZ2qnjnvvML5R+b7WYgUgmr5NSwGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYLMKasP6PjbPNNYOOqpYpNiQ0HRwUcogoXyS3AbsCZD+ONS++vUIThO+KMjYZZFhpi8A3FwtqtVEQ+0wLX08iAnE0JgNouGPnCamfjhKgSVx4XQ8HCVQRx6tR+ur7kPD8N3/kwa4sHTAurLqLy4svNKwflYbuhXd9r4UrmPPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso4095645a12.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336714; x=1719941514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mCBFXFW3xrmb5Ltv5b2iAf87RMobkMSxdTfkPAD8fQ=;
        b=qs6pum8IHeL0hNmzSmplbP+Fyrz1jLJUtTnEUHRABWpHuV4bPlzNIbztsDpJ3cjep6
         UvQh4vpDeSB8Klj3U9SyQWUQMYn6NOi5ij5+B+VTzNgN2a7K+YS+z+eHwGUY+0UlEXLX
         5qKJDP88LmIH/PB+f49GDMIGOO8IHojnvoHFv/mnBokwQNJSbJdnmCNloOXl3z+TrMZS
         tOG119F1n2nYaFOjuPAvANC8+gcVLe1hvDSL4f7gKUC9oAn2fqAvA7UDERs0sBQh7YGX
         G0aQRN7MEuunuJLi/Arun21eFpg9EO6OXsByU7q1bw9yJ4K/BvU3E+Z400p4RDe/o4O4
         SJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWwXW3B1PTwq0VwHEQx3h18IVKGvJOROr3gt55WvbHOPoowh4p1fVavYNmW/o482PaesaPqq9b4l9VBnogf8i1yWa5U
X-Gm-Message-State: AOJu0Ywq4khG3uHd7DH8PbYeb8MniEpnBqed0Lg91/Ri3xhs1dWuI3cc
	WHRZTwQBwbs0bBQBQk1z1Npn9bpLU25njy9YgBlrwxQctgjERjve1Z+tsawIiJa/42EVxYxEUCU
	pR0P9U7t8g7WJUFu8oksi5GyffF8LZw==
X-Google-Smtp-Source: AGHT+IGBRjxrWBhdL/7mMB6ecSjWuwPRVZrc8rPNdKqszsUSJDTBRebFF6rX4he8X/Uf7oNfrHGDEupGZ0QVlSMaLpQ=
X-Received: by 2002:a17:90a:d78e:b0:2c3:16f8:b57b with SMTP id
 98e67ed59e1d1-2c86127486fmr5831263a91.25.1719336714358; Tue, 25 Jun 2024
 10:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-7-chandrapratap3519@gmail.com>
 <CAOLa=ZSKcpOVv8wcDpe8mgtu53aWrCKG+scMqNix_BfBrT=KkA@mail.gmail.com>
In-Reply-To: <CAOLa=ZSKcpOVv8wcDpe8mgtu53aWrCKG+scMqNix_BfBrT=KkA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 25 Jun 2024 13:31:42 -0400
Message-ID: <CAPig+cQFnKXeHJwKxSShXQOwP3fbjfSMX+C04_5urQyL9+uWJA@mail.gmail.com>
Subject: Re: [PATCH 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, karthik188@gmail.com, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:15=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable=
-record.c
> > @@ -121,15 +122,19 @@ static void test_reftable_ref_record_roundtrip(vo=
id)
> >               switch (i) {
> >               case REFTABLE_REF_DELETION:
> > +                     check(reftable_record_is_deletion(&in));
> >                       break;
> >               case REFTABLE_REF_VAL1:
> > +                     check(!reftable_record_is_deletion(&in));
> >                       set_hash(in.u.ref.value.val1, 1);
> >                       break;
>
> I think it might be easier to follow if we just move this outside the
> switch, perhaps something like:
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-r=
ecord.c
> @@ -139,19 +139,15 @@ static void test_reftable_ref_record_roundtrip(void=
)
>                 switch (i) {
>                 case REFTABLE_REF_DELETION:
> -                       check(reftable_record_is_deletion(&in));
>                         break;
>                 case REFTABLE_REF_VAL1:
> -                       check(!reftable_record_is_deletion(&in));
>                         set_hash(in.u.ref.value.val1, 1);
>                         break;
> @@ -159,6 +155,7 @@ static void test_reftable_ref_record_roundtrip(void)
> +               check_int(reftable_record_is_deletion(&in), =3D=3D, i =3D=
=3D REFTABLE_REF_DELETION);

It's subjective, of course, but for what it's worth, I find Chandra's
code easier to reason about than this proposed rewrite for at least
two reasons:

(1) The intention of the original code is obvious at a glance, whereas
the proposed rewrite requires careful reading and thinking to
understand what is being tested.

(2) In the original, because the check is being done within each
`case` arm, it is easy to see how it relates to the case in question,
whereas in the proposed rewrite, the test is far enough removed from
from the `switch` that it is more difficult to relate to each possible
case.
