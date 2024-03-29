Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1A1C0DC2
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734699; cv=none; b=qOwUJjN9sMnGV9rRcs+RmXGrwD8iV55vjkVfyqNzzWiz5lhuwoP4NG676CviEsM/U5IZhgaSJke4pDkrRv7sb7qd4lwSqnPL15NHPtSflbi8BaheqDaomQGqhcNFwMaRq5iw8tcg8dAXCvy0Mf21x9vCqZXd0h8GhReBULFycpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734699; c=relaxed/simple;
	bh=+k1AYN8JXmU7TogEmK48W4osI05fpYDsC4eR5xVJRaw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7PG5cwsBtqSVOLwypabM5GKpfZBkNz6d+ZM5epjIqwPXaaw5POu42RvJQRaXEbERaHYekX74fihsbnwDlIcvRO6gwVLnfU+hYovrNAm7//dprk4sOkSanN0AHhA8Gd9pJgqZfQ7IkozkwRgoWcshnuUsQrVT4OGenhG7Mshz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvYaLnDl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvYaLnDl"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-229b7ada9e8so918206fac.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711734696; x=1712339496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYw836SRioGG7xMhKvEnopGY0vw+tJs0XvSQoG/i+pc=;
        b=FvYaLnDl5D9qOtUKh/Hi5ImFFuF4Ggnix/i4Ae9NwiM8/d+m+DKTXjxsRFTzIvoW43
         i5mxWa6mc8pIjy0igdDihPjC/NX9Q5iJdQquPQtIaAr+uZfMbIMW2ADMw7Ww7/sYMocM
         jg9VYQtO6ZckaDrjHqyQIrmr6jKTfTcyvh14h0Yjp9VI1PZUiSwIrw7fQoJsfq6mWVOv
         snFj3isK0j76mwEU/ojW+LitP/vr4pOCZPKOvmZGiEPrwk6SMRwfl7AAGMAi2QZQdmBy
         WGuuOWQHeP2zCZE3c4miBO55kn5jc4KG1hy1fw5zwnLY/NUo0+MT90tUoogjKImoCMAk
         Pibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734696; x=1712339496;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYw836SRioGG7xMhKvEnopGY0vw+tJs0XvSQoG/i+pc=;
        b=uH1ZsHI2Bg8wBc3LbkMhHocxR1ipny+gaPWI0NEBECv4UBtuggLZL9TYeciwqk5PlX
         KpXGlNaeuLu7VyKBxgbrjzXccikBWCYDaUHy3S9oVeokQvg+1tzapWCjYpX+9pUXn7v/
         EVNob2iAQbsDV2SmsXTtu+NnfPAjzWQ/UZ3leHSXHK0VDnKvlD/iY3eGSJf8+fg68rNz
         kC7QXpWJahtbskacPInw18iNVsEXXehX093Dp2bMg7nirMP/RLrO7kS1e+35TD0YTbeu
         OIWjLePoq8jJVGhoH4ephp7TnkQk3nKq+V8andi7C6XHm50605dyEu35D6TmxVxPX3bl
         9nXg==
X-Gm-Message-State: AOJu0YyBVA1VRAU+sTyiD9EmayttSUVWwuM+wQZuxA26kZy8gM5Xlkqk
	tm+2gaseh/CFVChDsy6SLFBobfY1Mde0GAKXvTo2c9ZtzDAFrtKAtb+1cgVJ9ucJcNzDsUxYWU/
	56Ds/n1i8uENKl14zlF4WtXA8XMw=
X-Google-Smtp-Source: AGHT+IHeUq/6afbjH3BjYo/00sglzcEDi++FW5xdB7iJee3ZWeKmarsgD9j5vw2wLZjdrY9HFuLKdFxZ7LfI09pfPTk=
X-Received: by 2002:a05:6870:d189:b0:22e:7ff:65f9 with SMTP id
 a9-20020a056870d18900b0022e07ff65f9mr1602898oac.22.1711734696211; Fri, 29 Mar
 2024 10:51:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Mar 2024 10:51:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e2d91c9f-9c7a-4127-9bc2-41807765241b@gmail.com>
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
 <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
 <ZfwnrL6Zl_lcV09y@tanuki> <e2d91c9f-9c7a-4127-9bc2-41807765241b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Mar 2024 10:51:35 -0700
Message-ID: <CAOLa=ZTdvYtb6VktU5o7+Erg2_9j29dY9vBsaVEPBzU2-cu18A@mail.gmail.com>
Subject: Re: [RFC][GSoC] Proposal v2: Move more tests to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com
Content-Type: multipart/mixed; boundary="0000000000008490c30614d04ac3"

--0000000000008490c30614d04ac3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chandra Pratap <chandrapratap3519@gmail.com> writes:

Hello,

> -----Contributions-----

Nit: Not sure how these contributions are sorted, but it would be nice
to group the git-for-windows patches together.

> In GSoC
> -------
>
> -----Plan-----
>
> Tests for Git are defined in the t/ directory and use the combination of
> a helper file (written in C) and a shell script that invokes the said
> helper file. I will use my work from the patch =E2=80=98tests: Move
> t0009-prio-queue.sh to the unit testing framework=E2=80=99 to explain the=
 steps
> involved in the porting of such tests:
>
> =E2=80=A2 Search for a suitable test to port:
>
> As Christian Couder mentioned in this mail (link: https://public-inbox.or=
g/git/CAP8UFD22EpdBU8HJqFM+=3D75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com/=
),
> there exists a subset of t/helper worth porting and we need some sort of
> classification to discern these.
>
> All helper files contain a cmd__foo() function which acts as the entry
> point for that helper tool. For example, the helper/test-prio-queue.c
> file contained cmd__prio_queue() which served as the entry point for
> that file. The binary for the helper file is then mapped to a different
> name by helper/test-tool.c which is used by the =E2=80=98*.sh=E2=80=99 fi=
les to perform
> the tests. This name can be discovered by searching for the helper
> file=E2=80=99s entry point in test-tool.c. Continuing the prior example,
> =E2=80=9Cprio-queue=E2=80=9D was the name for the helper/test-prio-queue.=
c binary and
> t0009-prio-queue.sh invoked it like =E2=80=9Cprio-queue 1 2 get 3 dump=E2=
=80=9D.
>

It is really nice to provide an example, but you're referring to files
which used to exist here, which can be a bit confusing. Would be nice to
talk about a new helper file you plan to port and what is the general
flow you'd follow there.

> =E2=80=A2  Create a new C test file in t/unit-tests:
>
> After finding a test appropriate for the migration efforts, we create a
> new =E2=80=98*.c=E2=80=99 file in t/unit-tests.  The test file must be na=
med appropriately
> to reflect the nature of the  tests it is supposed to perform.
> Most of the times, replacing =E2=80=98tXXXX=E2=80=99  with =E2=80=98t-=E2=
=80=98 and =E2=80=98*.sh=E2=80=99 with =E2=80=98.c=E2=80=99 in
> the name of the test script suffices. E.g. t/t0009-prio-queue.sh turns
> to t/unit-tests/t-prio-queue.c.
> The new C file must #include =E2=80=9Ctest-lib.h=E2=80=9D (to be able to =
use the unit
> testing framework) and other necessary headers files.
>
> =E2=80=A2  Move the code from the helper file:
>
> Since the helper files are written in C, this step is mostly a
> =E2=80=98copy-paste then rename=E2=80=99 job. Changes similar to the foll=
owing also need
> to be made in the Makefile:
> -    TEST_BUILTINS_OBJS +=3D test-prio-queue.o
> +    UNIT_TEST_PROGRAMS +=3D t-prio-queue
>

This has a good potential for refactoring these files as they're added
to the new unit testing library.

> =E2=80=A2  Translate the shell script:
>
> The trickiest part of the plan, since  different test scripts perform
> various functions and a direct translation of the scripts to C is not
> always optimal. Continuing the prior example, t0009-prio-queue.sh used a
> single pattern for testing, write expected output to a temporary file
> (named =E2=80=98expect=E2=80=99) -> feed input to the =E2=80=98prio-queue=
=E2=80=99 helper tool -> dump its
> output to another temporary file (named =E2=80=98actual=E2=80=99) -> comp=
are the two files
> (=E2=80=98actual=E2=80=99 vs =E2=80=98expect=E2=80=99).
>
> In the first iteration of my prio-queue patch, I worked out a
> straightforward translation of this pattern in C. I stored the input in
> a string buffer, passed that buffer to the test function, stored its
> output in another buffer and then called memcmp() on these two buffers.
> While this did prove to be a working copy, this work was found to be inad=
equate
>

but why? It is important to state why this is not the best approach.

> The test scripts similarly perform other functions like checking for
> prerequisites, creating commits, initializing repositories, changing or
> creating directories and so forth, and custom logic is required in most
> of the cases of translating these, as seen above.
>
> =E2=80=A2  Run the resulting test, correct any errors:
>
> It is rare for any migrated test to work correctly on the first run.
> This step involves resolving any compile/runtime errors arising from the
> test and making sure that at the very minimum, all the test-cases of the
> original test are replicated in the new work. Improvements upon the origi=
nal
> can also be made, for example, the original t0009-prio-queue.sh did not
> exercise the reverse stack functionality of prio-queue, which I improved
> upon in unit-tests/t-prio-queue.
>
> =E2=80=A2  Send the resulting patch to the mailing list, respond to the f=
eedback:
>
> This step involves writing a meaningful commit message explaining each pa=
tch
> in the series. From my experience contributing to the Git project, I find=
 it
> to be rare for any patch series to be accepted in the very first iteratio=
n.
> Feedback from the community is vital for the refinement of any patch and
> must be addressed by performing the suggested changes and sending the wor=
k
> back to the mailing list. This must be repeated until the work is merged
> into =E2=80=98seen=E2=80=99, =E2=80=98next=E2=80=99 and further down, =E2=
=80=98master=E2=80=99.
>
> Timeline
> --------
>
> I=E2=80=99m confident that I can start the project as early as the start =
of the
> Community Bonding Period (May 1 - 26). This is because I have read
> the related documentation and already have some experience with the idea.
> I believe I=E2=80=99ll be ready to get up to speed to work on the project=
 by then.
> The exact time arrangement for each test is variable and hard to determin=
e,
> but judging from the fact that it took me 3-4 days to complete the first
> iteration of the t-prio-queue work, here is a proposed migration schedule=
:
>

I think the Community Bonding Period could also be utilized to go over
the patches submitted to date to move tests to the unit test framework
and draw learning's from them.

> The first few steps of the plan are easy enough to knock out in a day,
> the time required to port the tests depends mostly upon the work
> required in translating the shell script. As mentioned previously, it
> took me 3-4 days to complete the first iteration of the test-prio-queue
> migration patch and that was a short test with only about 50 or so lines
> of shell scripting and all the test cases following a single pattern.
> Considering all this, I believe it should be possible, on average, to
> migrate a new test in 4-7 days.
> From there, it=E2=80=99s a matter of polishing the patch until integratio=
n with
> =E2=80=98master=E2=80=99 by addressing the feedback on the mailing list w=
hich can
> deceptively take longer than expected. For instance, I had to continue
> refining my t-prio-queue patch for around 2 weeks after the first
> iteration to get it merged to =E2=80=98next=E2=80=99.
>

This is an important point, while you can probably have tests being
converted fast, it would be nicer to reduce the turn around time overall
and this could mean you spend more time at the start.

--0000000000008490c30614d04ac3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fd206932f6b1c898_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZRy82TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXlLQy85a3Z5cmY3eVM5aklHaTJ1QTlRVWlOTDFHRApoQS90ZjU1UEJu
eVdvQXd1TTRZUUJidDlscGFxcXBIYzF6MzFScWN1UTZSKzlXSXJkWFdFSnowRm9UNUNocXVICkZX
WFBFVEZZamwvUERrUW8vbmlzbTZHalFnMW8zMUVWc2htb3ZjeGRVRFNVSnNyeFdkQXBFdGtRbWtp
UURNNHcKU1BIQkV4R09vaWRTSmJFY1NucXFqYkl3WFdTeVhkVWZJZU01VGtVOXRIajF1MEcyTGFB
VkEyUEpVVDlIeUQ0Vwp0SDVtVjhhYzAwNVBjK1EyTFJBUUtmemNFOGM3ejNOUU5aWUZXcHBnKzlG
QTRRTXBxK2FENzhxY2trM0dtTyt3CkMyemtOMEZ4MWdjY1dKOHUrWER2MjYvSDBSejZtN2NhcExq
bFpiRlhwdXlseTNmRUdSc1QvdUF4TE9nWHNwL2oKQUYvaU9zSTNsL3pQVDQweHdHTHd0T1JUN3pB
Z1Z5eW1pZHdlcm5wWTNDbEMrMjJxQ25oeHArVDU1b1JteU9LWApDUitxRjM1dGZHUjNxZ2t4dVk4
NVpzdFlRMCtNbVVYSEFoMHhDTDBQVXM4TFhtVEx6WG5aQXRwUC9wWWhNb3JDCk5qbEFHdW9UL1F6
ZXJPcjM3UWJWbjFQcnBTMkRLWThZMEdnU2R1Yz0KPVpOWCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008490c30614d04ac3--
