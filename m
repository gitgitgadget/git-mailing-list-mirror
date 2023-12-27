Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCCED0
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi7imv/C"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so529155066b.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703674656; x=1704279456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsiwTaXXvV+tW12zAy+OBc4Nhjeqa5ZBqria6jReat4=;
        b=gi7imv/Clbo6lGq9Qs1eSVewPLGRPBt3EXhs1rQthqpz8ZbtO9HydTgbzu87Utm27S
         hmTlGVliFS+VaLqW7fBfPSbc43j/2Our1HxLHXW/Q11v/yfrk6DBrX8V0eMKEwo+IqnJ
         RKaP7bGMBKqAkh2KtiIQ9Y3QCi7xoe/0BSjoa4qYDcncdSnH2K9NBRGWriuzvobHb6Ms
         tT1pkjcZ8nSdwa6q7J/3llJXItfVeXWe5WDqwnXDbA3i7Ct39ULVbQLhe21JZGwxEJzA
         L21FzAHUrTmxKB47Apu8IMh1dHgpQjMTRVVVKitFqvZYegwkz4v+vOid2mI/u/TIIhWc
         SIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674656; x=1704279456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsiwTaXXvV+tW12zAy+OBc4Nhjeqa5ZBqria6jReat4=;
        b=C4ut4VXZhrNs87rOCoGfYRTGfB7/1D4X/uTM7HAEauM90skqGc1vjn81mj4URU0SjT
         q53Zj6zKnRXXBmnOdYbAx2QjMzcp+twDpTRfFiaDXu/1+mHYBRTm8ZpxJasCneqfN9mD
         Eec27pjQfoPSXiFlUATSeaQF1yqecop6JjJ54TSd4oAmm8t/iThGAm1Z3k+CvuxsFF2x
         srkDMbDcAVgr+lEocEYcT/bGXfw97bPNdBhpK31aHHVhPuQbIDVqmWsUwGIlXBTDzKCj
         311o6xvU03cCSUqh789pRmjyBgs+uAUROGf74MHjE75yrImZPyiAmZ0ghvrMAjxBhyr2
         hxLg==
X-Gm-Message-State: AOJu0YzhIHTzCRADfobqbEDGKPOgywg3Wg8MLpFhA+q7Z9RqGayyLulu
	dgE0+8KIYBuIK7GaUk5X7oxhYb2WMdteEsowjcI=
X-Google-Smtp-Source: AGHT+IG0BYWlQ1QL2Ghf6Vk8KmNvsNSkyr5eH0LFMz4Q5Mi2Nkhp3bhUr95k783TlydyljvB05bpCOK4OyjUnIqhZUQ=
X-Received: by 2002:a17:906:1c0d:b0:a1f:7fbb:7f92 with SMTP id
 k13-20020a1709061c0d00b00a1f7fbb7f92mr3502152ejg.117.1703674655851; Wed, 27
 Dec 2023 02:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221231527.8130-1-ach.lumap@gmail.com> <xmqqsf3ohkew.fsf@gitster.g>
In-Reply-To: <xmqqsf3ohkew.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 27 Dec 2023 11:57:23 +0100
Message-ID: <CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 7:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Achu Luma <ach.lumap@gmail.com> writes:

> > +/* Macro to test a character type */
> > +#define TEST_CTYPE_FUNC(func, string)                        \
> > +static void test_ctype_##func(void)                          \
> > +{                                                            \
> > +     int i;                                                  \
> > +     for (i =3D 0; i < 256; i++)                               \
> > +             check_int(func(i), =3D=3D, is_in(string, i));       \
> > +}
>
> Now, we let check_int() to do the checking for each and every byte
> value for the class.  check_int() uses different reporting and shows
> the problematic value in a way that is more verbose and at the same
> time is a less specific and harder to understand:
>
>                 test_msg("   left: %"PRIdMAX, a);
>                 test_msg("  right: %"PRIdMAX, b);
>
> But that is probably the price to pay to use a more generic
> framework, I guess.

I have added Phillip and Josh in Cc: as they might have ideas about this.

Also it might not be a big issue here, but when the new unit test
framework was proposed, I commented on the fact that "left" and
"right" were perhaps a bit less explicit than "actual" and "expected".

> > +int cmd_main(int argc, const char **argv) {
> > +     /* Run all character type tests */
> > +     TEST(test_ctype_isspace(), "isspace() works as we expect");
> > +     TEST(test_ctype_isdigit(), "isdigit() works as we expect");
> > +     TEST(test_ctype_isalpha(), "isalpha() works as we expect");
> > +     TEST(test_ctype_isalnum(), "isalnum() works as we expect");
> > +     TEST(test_ctype_is_glob_special(), "is_glob_special() works as we=
 expect");
> > +     TEST(test_ctype_is_regex_special(), "is_regex_special() works as =
we expect");
> > +     TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works a=
s we expect");
> > +     TEST(test_ctype_isascii(), "isascii() works as we expect");
> > +     TEST(test_ctype_islower(), "islower() works as we expect");
> > +     TEST(test_ctype_isupper(), "isupper() works as we expect");
> > +     TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
> > +     TEST(test_ctype_ispunct(), "ispunct() works as we expect");
> > +     TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
> > +     TEST(test_ctype_isprint(), "isprint() works as we expect");
> > +
> > +     return test_done();
> > +}
>
> As a practice to use the unit-tests framework, the patch looks OK.
> helper/test-ctype.c indeed is an oddball that runs once and checks
> everything it wants to check, for which the unit tests framework is
> much more suited.

Yeah, I agree.

> Let's see how others react and then queue.
>
> Thanks.
