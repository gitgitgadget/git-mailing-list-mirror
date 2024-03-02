Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFF3FE4E
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416807; cv=none; b=ZyxVHPzonpjoECcHNWs5tWMJTvDlkAB9ls4HapG4e4Alt3/EK1errMXSGD/qJW8h+9OtoOuzQPs20nEMrRNkKvCrmFVk6FX+9wjd116z/db1qr0FF/+TTB9CxwlBBWQcT5dGgiTOnE+l2KAL2GpfaPiJ48mtNPpypP6DvBFECvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416807; c=relaxed/simple;
	bh=ajCr6WMHveYaLNXEVs+bj2ciTXjv5vzLjng80OdYTkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=PzkKZ7Zw7p5aPgkvtawJoY6wm/ylRtBne+FHDrZ0Puk4JesjiUDK7Y2V9OvxJlJo2y0bSRosAoHnn6CodUFhUexdIpSxJ4hQh6Gu/WOj7YHupDmQl+Sl+SVC3/Ax7bFSWitTlZ7Qv91X39EzYhVi3WKQ1X2fvbkG6rd/Ouu4mqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ngI76Xoi; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ngI76Xoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709416800; x=1710021600; i=l.s.r@web.de;
	bh=ajCr6WMHveYaLNXEVs+bj2ciTXjv5vzLjng80OdYTkY=;
	h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
	b=ngI76Xoi993J40cTxu+uaiDRc1A3X9Mf+bZA3HB1lcPqrg/EBz+Z+t3Q9vKqGJiO
	 N4M9vPWl5uZBwhj4uHf43dKfXzQh35I8zCOSzHeV+qlW1RA36+8vgfupk/CwYHpX7
	 zs5Jyx1KAsbdu7iSW/RdXiyNcBe4vQgonJjVJ3d0p/VBey5lcpvfewkFwdxcqNjjx
	 t3YXG/76ge2ATSNoH3EqsAnX+v19r0k953ahn9Ogajyi+5uM+epFC5p4LpizDoGJG
	 vjDTtOFUVENhPhUrtLaEs0IS6FHzB/kbbBKn0GzB5cn4G7IA2Ka+v1vz2J/yIAQ6y
	 hNtf39ILGXQpVX0wdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1raC0F2l6F-00DADh; Sat, 02
 Mar 2024 23:00:00 +0100
Message-ID: <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
Date: Sat, 2 Mar 2024 23:00:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: Christian Couder <christian.couder@gmail.com>,
 Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>, Achu Luma <ach.lumap@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de> <ZdzfYPim2SP22eeS@google.com>
 <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b74qPnzr7gDqnHcGzTXXbv1NPW4B2Z/zTTHrdndE9YxrHBKb85H
 dPzrtF8VClECH4yU0Jt7P8WOONaAYZbkgq2vhdZE5/1/QL0bKtD21B/wcIIIDjxG/mlbtGk
 TydAqoWUF4ZSIrGeEDt0XPbpDJCZOVfJzqh5cDIq1pgkrZ4EYM8jHfiI7p1+a3FPh0BxGaB
 q80By9EosIIuilVRMYDsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w/hnj3rOCzE=;1c2AwjO/l08nCTRMBZ9llRx9nM6
 BhnmCPWdxZ5kvQQP1pTl8Abnr6cCbyd6oyRJcBOfUXzUUZ/RhT9wGclHIWiPpw/dNrLZ5Ub0u
 5cccF+HI7uFk6TC4H/zYll2uhs6tjspgUCdoBwx4hCvmQpeOTCmU5ZV5eQ+nqRCk36ZRSsj6N
 6NTYV6i43zR1q+DwX5X+tqh87Sq9YWEKh3D+SXW71eVb8LrBNWuEAo3srg//hvLINUX65vJsM
 zqgdlGeto1UOAwg2LZ/7oVqYN7yGdCt5ZfCh/tdVUQZI47LRIXDseKzyKZMVOnF8EqqPy0RHA
 6lY3Uc0NiKTVJ/ubVrxOgcZad0XLu5trIhJNudkMmmIxD98vtJpTXsXrt6tdwgDglfXcEym8E
 67T/kmQnk69w3qNHI6IDqeSTBH9zXHOJNb4eiP6ILX4kivSEOCg8dY8ktByxhVe/h+mw5kAzq
 Tk8uUGsbUY4hMXXz4000/bikMRvQoHqeyLIQBdVJntVcJpMhChNsCKiKUbcoTmVkEE0Jr2nOZ
 Q85nEV1WQ8Y0SRu3M70X9+qt+8oRzZU7+JHx65VG/1DqBnJOI4M5ptdY0Z9+eaA701nDdqJR2
 7mIU7RiwdmekNjgb/1fo9CIOUpRm6a+QGIiSdwmqO1DrZtv79MJaOyuB+fvXh2t8QqL6f0OyH
 YDlZeDcdz8nvChCVJM861vcdpYGNfnGYMXaTH1a8t9ydVGmr4arNGFjdAq1ntR2gyo+j/mMkP
 fFm5+P6Kx3cxuyLKfGC5P9XNuuZBhOLptU6RWMsVFddeIg+UoW1vzCNvQJOF1waXxSv6i+gQ5
 zdZwWBMhxSwDyt+cppl7e02u0ceK6lejHZw4KX+kToYBI=

Am 27.02.24 um 11:04 schrieb Christian Couder:
> On Mon, Feb 26, 2024 at 7:58=E2=80=AFPM Josh Steadmon <steadmon@google.c=
om> wrote:
>>
>> On 2024.02.26 18:26, Ren=C3=A9 Scharfe wrote:
>
>>> The output is clean as well, but there's a lot of it.  Perhaps too muc=
h.
>>> The success messages are boring, though, and if all checks pass then t=
he
>>> only useful information is the status code.  A TAP harness like prove
>>> summarizes that nicely:
>>>
>>>    $ prove t/unit-tests/bin/t-ctype
>>>    t/unit-tests/bin/t-ctype .. ok
>>>    All tests successful.
>>>    Files=3D1, Tests=3D3598,  0 wallclock secs ( 0.08 usr +  0.00 sys =
=3D  0.08 CPU)
>>>    Result: PASS
>>>
>>> Filtering out passing checks e.g. with "| grep -v ^ok" would help when
>>> debugging a test failure. I vaguely miss the --immediate switch from t=
he
>>> regular test library, however.
>>
>> Yeah, I agree here. It's a lot of output but it's almost always going t=
o
>> be consumed by a test harness rather than a human, and it's easy to
>> filter out the noise if someone does need to do some manual debugging.
>
> Yeah, I know about TAP harnesses like prove, but the most
> straightforward way to run the unit tests is still `make unit-tests`
> in the t/ directory. Also when you add or change some tests, it's a
> good idea to run `make unit-tests` to see what the output is, so you
> still have to see that output quite often when you work on tests and
> going through 3598 of mostly useless output instead of just 14 isn't
> nice.

I was starting the programs from t/unit-tests/bin/ individually because
I didn't know 'make unit-tests' exists.  This is much nicer, thank you!
Especially after adding 'DEFAULT_UNIT_TEST_TARGET =3D unit-tests-prove' to
config.mak to complement the 'DEFAULT_TEST_TARGET =3D prove' I added long
ago.  It would be even nicer if the former was the default when the
latter is set.

As unit tests are added, their output is surely going to grow to
multiple screens with or without prove, no?  So someone writing or
debugging tests will still go back to starting then individually
eventually.

The size of the output in itself is not a problem, I assume, but that
most of it is useless -- details of successful tests are uninteresting.
A test harness can aggregate the output, but prove annoyed me when used
with the regular tests by also aggregating error output and only showing
the numbers of failed tests.  Finding their names involved running the
test script again without prove.  Turns out it has an option for that.
Added 'GIT_PROVE_OPTS =3D --failures' to config.mak as well, will see if
it helps.

Is it too much to ask developers to use a test harness?  Perhaps: It's
yet another dependency and not enabled by default.

What's the right level of aggregation and how do we achieve it?
Grouping by class is natural and follows the test definition.  We
could stop after patch 2.  Dunno.

Ren=C3=A9
