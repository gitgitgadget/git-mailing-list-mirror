Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387A2C197
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="G0cGqtR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704402864; x=1705007664; i=l.s.r@web.de;
	bh=3tcCLehUnw9eKAV5nJaroKPXGwK2CWkddcu64t8rUf4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G0cGqtR9B928BuBO+CXJ/j+dDNXP0/xwx5quUfTTwdQ0+z3RK4JGcHUP4MISb7Rr
	 EMlcgEr9s7+1/Kpm7txjAzsoPmNCcro7vav9twZzekLrp7WYeeMvnI8xqkledw9N4
	 nsbeoNNTSeOlquaWSEqNJMCQKGg4yX60MUgLP7q1PsoWdJQOHvOB34ZzzG7DtWqv7
	 Jb0svPMFbFUvNmbvjN0tDY7c3txkKwwnrLTtStWDLAMHkUZdVUR0/QU2DqNsJ1DuR
	 fvptLB5c1SCtD2Jz1IB/A07rszJrMXAdTc1BHqTvJDAmg1h8SRkayarWnhWHj93zh
	 CBe32zs5+oU6EvQDhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1rFhcD1Kmj-0062Zz; Thu, 04
 Jan 2024 22:14:24 +0100
Message-ID: <ff21e91a-f2db-4d37-ab9b-da9a492db8d3@web.de>
Date: Thu, 4 Jan 2024 22:14:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] grep: default to posix digits with -P
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org
References: <20240101150336.89098-1-carenas@gmail.com>
 <55309061-5996-4f70-8e6b-b341fc632ddf@web.de>
 <CAPUEspgbVx6wbp4UNjjxFO8iNJw3i2FnJxNwn4pk5EbaAP-7gQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPUEspgbVx6wbp4UNjjxFO8iNJw3i2FnJxNwn4pk5EbaAP-7gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dRmHEzDfl0blXlh4ASsCfuIZTywYQOQbIwOTYmB2BBYQSkiDsE
 Zuby+VO+Q1SQNrvTyoXhSR8dmDQar811PsW6bMRBzZPMmt+zyqcN7zg8UoCb8UfAbM3oUdq
 +zbpv2ns09ras6q+p/mNDsdpX7ITtb6P4zzYMG0IC6ENWX5fGNiHqZrw06rp2nwu2IG/9Vj
 cUMVw2jBXvca9HbT/VMZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:04eYWjRVtcg=;sdlwKKJvcS6HbVNvoGx3n5tPJOY
 2vxY4jnkDNQChYPIMWByH1gJZaKrG4wSWy9mGoTUfC95ge71heQtoTaqSq2ZF8wRr5azxOUga
 PEHyeinoGYcsS9qJaL37nvU3h58OI0VCOGL6lOq3++mpwDq645k/KXPNJirlhPQcejPX6w9MT
 MiUlenqcqNhwoNCDOJtI9bSF1WFc57oT1BNqutS4FX1LljBQVSkGDGntw5W9pjbYZyGd60N5x
 k/ZG2Hcg4KpQu/BsDRVLY0cmiE50zXtP4xewuUmvCkQ8/1zey6PbRhd/tkF5XbVsvo0p7yR5x
 1FiF41ZouN+9lJRiFyvp6cx6WCSJcuEmI4q86o926LpNI2Fth5O9ED2Ghapqd0nKgCih9VV9R
 lgoDZrxCHMosrUkWKE64a3SK2aLJ6Tfb5Mj2xlzQ6yHwy4aylckFVT7R/tz1bNCfAPWb3kGVA
 wHkOkbQMUG3+yZ3iKVQ/a8Yg6Z23nploDBu9z4A2tnPw4wrbOdVumal3jd3VmtBw62SNYv5LQ
 F5chzL/B+stGpt/NzOEYNqNuv1QV2jUjThQuYapRGKaWiXufG/Obs4wdB4NG4vDk0updXNKxn
 b/bLHyO6lDiBjoGgXuZrjfl0TxVAjeSDzLlFv5rtwZCfLJDUZEUeGFQ0ATf6JwxtM9Sa5seV5
 KYzSMVP/k+siPneavXoVun1K7yVhjHkPpFbGhe5ieppflB4au/mmHjuqUM8SbHu62Q26kWZPx
 1QrYQ6S5t2nqbgKPhbYmVfhjk4beWC4I3eY+UPHOuzvyDVer3xtyfKYE+eP9ZdnKhfSIEO0WT
 UaNRNmmJz3knGGIruiMt02On48oafEJQprquBxFmBQB2UNDbAMjDM4Rg0Srz9NM673ss5RxwQ
 4tF6VBEyco3HgPhLUjt5SURs1wGAroZRGKtlHBkeHWmuJGzib4tu9kbH4AxREHUjJ5NI/cXVO
 a6vvmMsjWY/BTQtsITTiOCFVYwY=

Am 02.01.24 um 20:02 schrieb Carlo Arenas:
> On Mon, Jan 1, 2024 at 9:18=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>>
>> Am 01.01.24 um 16:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>>> @@ -321,17 +327,22 @@ static void compile_pcre2_pattern(struct grep_pa=
t *p, const struct grep_opt *opt
>>>               }
>>>               options |=3D PCRE2_CASELESS;
>>>       }
>>> -     if (!opt->ignore_locale && is_utf8_locale() && !literal)
>>> -             options |=3D (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALI=
D_UTF);
>>> +     if (!opt->ignore_locale && is_utf8_locale() && !literal) {
>>> +             options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>>
>>> -#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
>>> -     /*
>>> -      * Work around a JIT bug related to invalid Unicode character ha=
ndling
>>> -      * fixed in 10.35:
>>> -      * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
>>> -      */
>>> -     options &=3D ~PCRE2_UCP;
>>> +#ifdef GIT_PCRE2_VERSION_10_35_OR_HIGHER
>>> +             /*
>>> +              * Work around a JIT bug related to invalid Unicode char=
acter handling
>>> +              * fixed in 10.35:
>>> +              * https://github.com/PCRE2Project/pcre2/commit/c21bd977=
547d
>>> +              */
>>> +             options |=3D PCRE2_UCP;
>>> +#ifdef GIT_PCRE2_VERSION_10_43_OR_HIGHER
>>> +             if (!opt->perl_digit)
>>> +                     xoptions |=3D (PCRE2_EXTRA_ASCII_BSD | PCRE2_EXT=
RA_ASCII_DIGIT);
>>>  #endif
>>> +#endif
>>
>> Why do we need that extra level of indentation?
>
> I was just trying to simplify the code by including all the logic in
> one single set.
>
> The original lack of indentation that was introduced by later fixes to
> the code was IMHO also misguided since the obvious "objective" as set
> in the original code that added PCRE2_UCP was that it should be used
> whenever UTF was also in use as shown by
> acabd2048ee0ee53728100408970ab45a6dab65e.

One level of indentation is correct because the code in question is part
of a function and it's not nested in a loop or conditional.  And
preprocessor directives don't affect the indentation of C code.  Am I
missing something?

> Of course, we soon found out that the original implementation of
> PCRE2_MATCH_INVALID_UTF that came with PCRE2 10.34 was buggy and so an
> exception was introduced in 14b9a044798ebb3858a1f1a1377309a3d6054ac8.
>
> Note that the problematic code is only relevant when JIT is also
> enabled, but JIT is almost always enabled.
>
>> The old code turned PCRE2_UCP on by default and turned it off for older
>> versions. The new code enables PCRE2_UCP only for newer versions.  The
>> result should be the same, no?  So why change that part at all?
>
> Because it gets us a little closer to the real reason why we need to
> disable UCP for anything older than 10.35, and that is that there is a
> bug there that is ONLY relevant if we are using JIT.

How so?  If the same flags are set in the end then it seems like a
lateral movement to me.

Do you want to disable JIT compilation for older versions?

> My hope though is that with the release of 10.43 (currently in RC1),
> 10.34 will become irrelevant soon enough and this whole code could be
> cleaned up further.

Cleanup is good, but if we package the workarounds nicely we can keep
them around indefinitely without them bothering us.  Debian buster
still has a few months of support left and comes with PCRE2 10.32..

>> But the comment is now off, isn't it?  The workaround was turning
>> PCRE2_UCP off for older versions (because those were broken), not
>> turning it on for newer versions (because it would be required by some
>> unfixed regression).
>
> The comment was never correct, because it was turning it off, because
> the combination of JIT + MATCH_INVALID_UTF (which was released in
> 10.34) + UCP is broken.

The code disabled PCRE2_UCP for PCRE2 10.34 and older.  The comment
claimed that this was done as a workaround for a bug fixed in 10.35.
You seem to say the same.  What was incorrect about the comment?

>> Do we need to nest the checks for GIT_PCRE2_VERSION_10_35_OR_HIGHER and
>> GIT_PCRE2_VERSION_10_43_OR_HIGHER?  Keeping them separate would help
>> keep the #ifdef parts as short as possible and maintainable
>> independently.
>
> I thought that nesting them would make it simpler to maintain, since
> there are somehow connected anyway.
>
> The additional flags that are added in PCRE 10.43 are ONLY needed and
> useful on top of PCRE2_UCP, which itself only makes sense on top of
> UTF.

This conditional stacking is complicated.  I find the old model where
we say which features we want up front and then disable buggy ones
for specific versions easier to grasp.

>>> @@ -27,13 +34,13 @@ do
>>>       if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>>>       then
>>>               test_perf "grep -P '$pattern'" --prereq PCRE "
>>> -                     git -P grep -f pat || :
>>> +                     git grep -P -f pat || :
>>>               "
>>>       else
>>>               for threads in $GIT_PERF_GREP_THREADS
>>>               do
>>>                       test_perf "grep -P '$pattern' with $threads thre=
ads" --prereq PTHREADS,PCRE "
>>> -                             git -c grep.threads=3D$threads -P grep -=
f pat || :
>>> +                             git -c grep.threads=3D$threads grep -P -=
f pat || :
>>
>> What's going on here?  You remove the -P option of git (--no-pager) and
>> add the -P option of git grep (--perl-regexp).  So this perf test never
>> tested PCRE despite its name?  Seems worth a separate patch.
>
> My original code was a dud.  This would make that at least more obvious,

The change is good, but I don't see any connection to the
grep.perl.digit feature that this patch is primarily about,
so I (still) think it deserves its own patch.

>> Do the performance numbers in acabd2048e (grep: correctly identify utf-=
8
>> characters with \{b,w} in -P, 2023-01-08) still hold up in that light?
>
> FWIW the performance numbers still hold up, but just because I did the
> tests independently using hyperfine, and indeed when I did the first
> version of this patch, I had a nice reproducible description that
> showed how to get 20% better performance while searching the git
> repository itself for something like 4 digits (as used in Copyright
> dates).

Great!

> My idea was to reply to my own post with instructions on how to test
> this, which basically require to also compile the recently released
> 10.43RC1 and build against that.

OK, so this is about the grep.perl.digit feature, right?

What I meant above was: Is the statement in acabd2048e (grep: correctly
identify utf-8 characters with \{b,w} in -P, 2023-01-08) about 20-40%
performance impact (in which direction, by the way) still measurable
with the fixed perf test script?

With the fix and PCRE2 10.42 and PCRE2_UCP I get:

Test                           this tree
=2D---------------------------------------------
7822.1: grep -P '\bhow'        0.05(0.02+0.30)
7822.2: grep -P '\b=C3=86var'       0.05(0.02+0.29)
7822.3: grep -P '\d+ \b=C3=86var'   0.05(0.02+0.27)
7822.4: grep -P '\bBel=C3=B3n\b'    0.04(0.02+0.23)
7822.5: grep -P '\w{12}\b'     0.03(0.02+0.13)

... and without PCRE2_UCP:

Test                           this tree
=2D---------------------------------------------
7822.1: grep -P '\bhow'        0.05(0.02+0.26)
7822.2: grep -P '\b=C3=86var'       0.04(0.02+0.18)
7822.3: grep -P '\d+ \b=C3=86var'   0.05(0.02+0.26)
7822.4: grep -P '\bBel=C3=B3n\b'    0.05(0.02+0.27)
7822.5: grep -P '\w{12}\b'     0.04(0.02+0.18)

Hmm, inconclusive.  Perhaps the test data is too small?

> Indeed, AFAIK the test would fail if built with an older version of
> PCRE, but wasn't sure if making a prerequisite that hardcoded the
> version in test-tool might be the best approach to prevent that,
> especially with all the libification work.

You could extend test-pcre2-config to report whether that feature is
active.  Performance tests could set prerequisites based on its output.

> PS. your reply got lost somehow in my SPAM folder, so I apologize for
> the late reply

No worries, I need days to reply without any detour through the
spam folder..

Ren=C3=A9
