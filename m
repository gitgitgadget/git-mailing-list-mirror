Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546614BF9B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726752; cv=none; b=mDEra70sI8slWO9zAVHkwDhX3+Tg5MiUchRTh5luo9eMXabeQCJPdGkljUCdfrD0rNxkTJyG2xnkdfiyRVNNOyst2HbksiV41YYXQkz2e5r0EUQywkVjA0qNhm7mCVe9EaxrfGSY4xc90Vx/sFJw9qV7Qj2LkG+7ISLb7SgJMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726752; c=relaxed/simple;
	bh=pHglDVh6xpITIULHhTAlv5K96ae2rBYcZsVviwZv3BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WND0s4Yvmw6fjdooU9L6UskQTnHv3OwAk1VfROftFemZ+SjocAg1/d78u+S/TZ570tKoQIdRBf19EB2VPbA2Nd0ndWE80XjklAZU0+BLFbl1wNRobryfmctRPpmOSFowqasn8iRHkcUhaC+Qvhf2t4Xb7OtRDgXNy2YFr86DNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EKzgYAB4; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EKzgYAB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721726730; x=1722331530; i=l.s.r@web.de;
	bh=gVb5VTElEg/J8Y6ZbRLgMLNq8ijzYIsDU+zxFKGTNS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EKzgYAB4D1knem6w8J/6VOo8Pq3fxJV79V7OXJmf16XNmcHUZRIzL0Iem22Y+xDG
	 8SaLkrwbmGOTC60Hdpoy2B/v0MDs/Irv7EEPjebFt1UWL9bio7JrFtmqrx6jP84ds
	 BCglHbLY6SzNRc15KIhsTr7Z8lo20hKweA9No5di4508/+IwgiryYe2O/mxksvs0j
	 kkSeWvK3iGYxCE351laBaky4jLbCfP8bTREiGtSvw9dM89J8JGQa2/DgIZUgmMlJF
	 D3YT7Ooe1Lr31hMbHkWQ1WYgZ0KLnzGvas2sKgcm4bMMf4Zh/cvpYW+vH8zvC1en8
	 kM+rKBmxw1fxZgy9qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1sgppz0QjB-00OHNt; Tue, 23
 Jul 2024 11:25:30 +0200
Message-ID: <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de>
Date: Tue, 23 Jul 2024 11:25:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <Zp9PfdZtWJBp2xgl@tanuki>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Zp9PfdZtWJBp2xgl@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AfKhkje0BUW8FAXQJP9AStoGijE7AZqYdI2QWxhQbnVYo/pDAy5
 3FUUR0yGrr/SsS3zgeIVWH27uMNOhH1QZ3VNKz3C8Mvc0FB/Nan6zMMcyJ4/5YQtGnVVjaw
 AumRe+8A+7Y4mI6kfk6tss+eOpdAjWH9yKR9nkk21dG8C4i3sCuuWG3fztS5uZx6PKGHToL
 hEEILMIDbHwocHgaBffkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KSsSaoTr8Zw=;STB/aDTlm6M0Gh2qb7oKzXCTmKl
 wGZnTJ1vEjffGfjX3xx73BiJ71mdR1FX2qOJjME/1YkvKBuuQvSJa410gmcrnuer0q7GHuHTd
 P0ZoXT8zhSyIkPW5ZB6M3TIekyZ1bjC3CzjArvePGAwnzE76p72CS02rRrGj710eSPaZhR5hn
 NDNiq4kRs3xFP1a+s33HFxCPq/fr5MHhBifBrlmjQg2TlCIG7iUJ3j94PBpGPj2wdhQNxkJAt
 4C8rUSssiweVa25PaBhTYFvGGbqceffmmbB24Oo1fZzj3UGdQynv1XTPSMXphWrXyxBDqg9Ms
 BMZDI/w2acP8W2pIbH+3TiBbxZXZXR2mSd9RftrmpNU7CMMjowsxIv0oPjxWvNujD9p18Og+T
 L4LH7Z+BNXu9jIGcNAnsNB5HCG4inxz4rXJhqw21PRcxxJphxbrqDx/qf5iK8rC5kZtUnz9Kr
 1QUuFXKtpLr4eOflZjvsdaSrMeiBygSGxMJqoJb498ySMd1qEXT0KBGlNt4u0mkYXByW7TChG
 1ttOrp2Kz86dAhwyNdKvzoUb/GqZmlTqrutKtH4/Zu5MLHhL7CQKaioatemNyjdme7z8DcomT
 P42pGxwVFB/ax1mSL7kou9hhh2Ecz0YC1HFpCXZjsPJiikZnC6ukKyXWPNCubFpL4EDdtGp6t
 jrZQhqY6OzO9ysf2cyU4WhDZQeTQ0a1XTGBonTZ01qO6u8uOBrvhpRbOA9xaiYKN4Eq0HpWfT
 d8EIYsXfPs4cXKRwiTTToa4gl6fXEZ5lzSxYHOgyz4K3d34gM2P1M7/GeN5P8GiiMP1DOb/Hx
 kF4vY7mvnD73dN/OgFYECXlQ==

Am 23.07.24 um 08:36 schrieb Patrick Steinhardt:
> On Mon, Jul 22, 2024 at 12:36:57PM -0700, Junio C Hamano wrote:
>> Kyle Lippincott <spectral@google.com> writes:
>>>> +#define for_test(...)                                               =
   \
>>>> +       for (int for_test_running_ =3D test__run_begin() ?           =
     \
>>>> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) :=
 1;\
>>>> +            for_test_running_;                                      =
   \
>>>> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),         =
   \
>>>> +               for_test_running_ =3D 0)
>>>
>>> IMHO: this is borderline "too much magic" for my tastes. I think
>>> having multiple test functions is generally easier to understand, and
>>> the overhead isn't really relevant. It's not _as_ compact in the
>>> source file, and requires that we have both the TEST statement and the
>>> function (and forgetting the TEST statement means that we won't invoke
>>> the function). If that is the main issue we're facing here, I wonder
>>> if there's some other way of resolving that (such as unused function
>>> detection via some compiler flags; even if it's not detected on all
>>> platforms, getting at least one of the CI platforms should be
>>> sufficient to prevent the issue [but we should target as many as
>>> possible, so it's caught earlier than "I tried to send it to the
>>> list"])
>>
>> Interesting.
>>
>>> If others agree that this is a good simplification for the people
>>> reading the test code (and hopefully for the test author), I'm fine
>>> with this going in (with a different name). I'm not trying to veto the
>>> concept.
>>
>> OK.  But what you suggested in the previous paragraph has merit.
>> Are there other things that could be improved in the existing unit
>> test helpers, that would help those who do not use this new for_test()
>> thing?  Let's see how the patches to improve them would look like.
>
> Honestly I'm also not too sure how I feel about these new macros, and
> I'm somewhat in the same boat that it starts to feels "magicky".
>
> Taking a step back: what is it that is bugging folks about the current
> way of writing one function per test?

My goal is to be able to define a test without repeating its
description even partly, like test_expect_success allows for shell-based
tests.

> I quite liked the system
> that we had in libgit2: every function must conform to a specific name
> `test_foo_bar`. We then have a Python script that reads all test files,
> extracts all files that have the `test_` prefix, and writes those into
> an array. Optionally, the `test_foo` test suite can also have a setup
> and teardown function that gets called for every test, namely
> `test_foo_setup()` and `test_foo_teardown()`.
>
> Altogether, the output would look somewhat like this:
>
>
> ```test.c
> static test_foo_setup(void)
> {
>     ... setup global state ...
> }
>
> static test_foo_teardown(void)
> {
>     ... tear down global state ...
> }
>
> static test_foo_one(void)
> {
>     ... first test ...
> }
>
> static test_foo_two(void)
> {
>     ... second test ...
> }
> ```
>
> ```generated.c
> static const struct test_func _test_foo_functions[] =3D {
>     {
>         name: "foo::one",
>         test: test_foo_one,
>         setup: test_foo_setup,
>         teardown: test_foo_teardown,
>     },
>     {
>         name: "foo::two",
>         test: test_foo_two,
>         setup: test_foo_setup,
>         teardown: test_foo_teardown,
>     },
> };
>
> int main(int argc, const char *argv[])
> {
>     ... boilerplate to execute all functions ...
> }
> ```
>
> The setup and teardown functions are optional -- if not defined for a
> specific test unit, then we simply won't invoke them.

So the name of a test is generated automatically based on the function
name and there is no way to add a description beyond that.  This would
achieve my goal above, but prevent developers from using space and
punctuation in test descriptions.  Fair enough.

> There is of course some magic involved with how we generate the file.

It requires magic function names and generates code using a different
language, while for_test is a just single new control flow keyword,
like the dozen or so we already have.  So the magic employed by the
libgit2 system is both broader and deeper.

> But I think that would be quite manageable, and ultimately all that the
> developer would need to care about is writing a `test_foo_something()`
> function. Everything else would be handled by our infra.

With for_test all the developer has to do is write a test with a
description, no extra infrastructure beyond the existing unit test
framework needed.

> I'd be happy to implement something along these lines if folks think
> that this is a good direction to go into.

FWIW I don't see the appeal.  It uses more code and more dependencies
to almost allow what for_test permits.

Ren=C3=A9
