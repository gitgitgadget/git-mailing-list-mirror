Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313E212182
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862565; cv=none; b=kjD7qljxvO7uRbn30jhro+xtvAHZpUO42g+ENuUwbD9xfHJouKBQ5AFy6CjJlcHvU5n4Nkbp90eaYvNSEPFzPDU6iuKUuh/zbecqEGjX0LUROcbYnyj+5UBcjhvbj3JElwPVERaGJ0KF0eeKG3o5eCCHrO0zUVI2avc9PuW4KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862565; c=relaxed/simple;
	bh=4NvYy3rwvd9iu57XRPW4kkwkZWWn84ICRbOvueo/66o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebKPPJJpz6UqUx5eFS4r94/HLuIBjJMdZ4KuVbzoJ5nIrhHnWDKMACjf7wJoLLthp8K74X3b9N5/UlIKdCeuYxtUqXeK22XUjWaYnXJhecZ8Ab9QaUK4WBejusG+MeBBOWsOd8bmWjKv/vco59ClHrpyrLwAsIYTfMrXUk/3I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdrctNah; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdrctNah"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so20499765e9.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862561; x=1730467361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJTud+mCgr3uortgjhHtxUbv9Y24VsVndbgvIPtGst0=;
        b=CdrctNahzKTaVnj3/1yGIYdB114SKXQhwrtcHbfviEuusSlyu/vQTqiK7SHvTBx5M+
         EWZp4zd/UIA4tmC1oMFZVnw4JOadEmNovI9vNt05qd4WHX6HstcCHelPdhV5Ol4a4h+F
         rPHczMuQNmafxRYYhBzT6Z/8t9tWhNtrKB/FuI2GcurxJJw1QVHUTKyGwXcgykv1BlVJ
         RKTGnVvUs1CV98dwR5SjLDpfL0PEP2eKURLzGVa+ltRcIHVbQaMOZRUshUxFwM5gD4x6
         kV5HX/8VIf3Dsbk0VoMyXUkeYqSo7V2hLVSQ2xAoNuZuFzJRohKyvol/DFiv0PIJb6ni
         a5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862561; x=1730467361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJTud+mCgr3uortgjhHtxUbv9Y24VsVndbgvIPtGst0=;
        b=gTUMwQnqY6ObysYJYxges9o+dkgNpOibnjGYxPKP3HRXWVCnHIYvr8J3xYlGGH7Oju
         pVXkSn93JemT8t8dEbbO6k/VrOquiqTQHqHsRNekPG1O/Elo4KCDz9kQ6z7wXf1vOlPy
         6bFOls21pNgtbaleISUk4mdqfcAMR9N7oAr3qjwKGs3odpMyzHJVWcVEyL0qtppz1n1f
         QguRklVFLtGHW1CNY1CkZguZCWcS12E8pQUAFlbYhz2uC8pzwObNEVTHsCc/5G1wrn/J
         myYyYr1jyRkLPtqR25tCnrQHAyJTyMNl630xzCBimDa+ZCx64qbdyDxVdpUqrcF7IUxz
         MUrA==
X-Gm-Message-State: AOJu0YxnoXYxbcuTaDMVtYZ+muzH6OntW1hojg8no7bXoWb9KDMitzBt
	F3CohZhIFQR2dliszNMOapURqgtKbvtOm1YUWdFIbq1TIqmNkiVB4r5hAPRGcmAmBbR9sGYXdgC
	VTLXnXfJBbntTn+TncV4bflNAdVQ=
X-Google-Smtp-Source: AGHT+IHf08SAt1IBumxAMTlcTw1tvvJCu3M9DhE75kBtjdn1VpQ4Wk3kUzeh1/L42VOqL7q7c3AtuLhQvufVQovbMFI=
X-Received: by 2002:a05:600c:3555:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-431841441b9mr79411025e9.9.1729862561040; Fri, 25 Oct 2024
 06:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
 <ZxttGFtt5nnc7g9Z@pks.im>
In-Reply-To: <ZxttGFtt5nnc7g9Z@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 25 Oct 2024 14:22:31 +0100
Message-ID: <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar testing framwork
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Wed, Oct 23, 2024 at 10:45:52PM +0100, Samuel Abraham wrote:
>
> Thanks for your application!
>
> > ## Project Overview - Convert unit test to use the Clar testing framewo=
rk:
> >
> > I understand that the Git project is in the process of converting its
> > unit tests to the Clar testing framework to improve test readability,
> > consistency and maintainability, a move away from homegrown unit test
> > frameworks such as t/helper/test-tool.h and t/unit-test/test-lib.h.
>
> Nit: we've basically moved away from test-tool for unit tests already,
> to the best of my knowledge. So this is more about the second part,
> moving away from our own test framework.

Thank you very much for the clarity.
>
> > Clar provides a structured and efficient way to write and execute
> > tests and is well-suited for a project like Git where robust testing
> > is essential to maintain quality and stability.
>
> It would be nice to provide some pointers _why_ we think that clar is
> better suited ;) Hint: you may have a look at the patch series that
> introduced the clar for some ideas there.

Okay I will do that.

>
> [snip]
> > ## Project Plan:
>
> Formatting of this section is a bit funky, which makes it harder than
> necessary to figure out which parts belong together. I'd propose to
> first provide a high-level list of the steps you want to do with a
> bulleted list and then maybe put more detailed explanations into
> separate "### subsections". You may also want to convert links to use
> [Markdown syntax](https://www.markdownguide.org/basic-syntax/#links),
> which provides some structure aronud them.

Okay thank you for this.
>
> > The first steps to migrating existing tests to Clar would be studying
> > existing tests in the t/helper and t/unit-tests directory which will
> > enable me to determine those appropriate for conversion.
> >
> > Liaise with mentors and community members to determine the viability
> > of converting the selected test for conversion.
> >
> > Convert the selected test to Clar while in constant effective
> > communication with the mentors and Git community, implementing
> > feedback and review suggestions.
> >
> > Properly test converted scripts to ensure validity and correctness.
> >
> > Steps to converting the existing unit tests to the Clar Testing Framewo=
rk
> >
> >  From the project description in the Outreachy Project Description page=
,
> >
> >
> > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communit=
ies/git/#convert-unit-tests-to-use-the-clar-testing-framewo,
> > the goal is to convert all Git=E2=80=99s existing unit tests to use the=
 Clar
> > testing framework exclusively.
>
> It might also make sense to plan some time to add missing features to
> the clar if we hit anything during the conversion.

Okay noted.
>
> > The existing unit tests which would need to be converted to Clar are;
> >
> > .c test files present in t/unit-tests: Tests in this directory use the
> > t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=9D sc=
ripts,
> > converted from the shell-based testing which used the tests in
> > t/helper/ and corresponding t<number>-<name>.sh test files. Examples
> > of this conversion can be seen in the link below which references Achu
> > Luma=E2=80=99s work
> >
> > https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.com/.
> >
> >
> > The link shows the work done in converting the test from
> > t/helper/test-sha1.c and test/helper/test-sha256.c to use
> > t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framework
> >
> >
> > The steps to convert files located in this directory include;
> >
> > - Identify the test files to be converted.
> >
> > Examples of such files are the t/unit-tests/t-hash.c, t/unit-tests/t-st=
rbuf.c
> >
> > - Rename the test file from t-<name>.c to <name>.c. This pattern
> > follows the style used by Patrick Steinhardt in his conversion of the
> > t-strvec.c and t-ctype.c files to use the clar framework.
> >
> > https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c864.17=
25459142.git.ps@pks.im/
> > and
> >
> > https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a076558097a240.17=
25459142.git.ps@pks.im/
> >
> > As a sample demonstration, we will convert the t/unit-tests/t-hash.c
> > to use Clar.
>
> I think the previous explanations are sufficient -- going into the
> technical details like you do below is appreciated, but ultimately not
> necessary in my opinion. What I'm after here is that you have a rough
> understanding of what needs to be done for each of the tests, and that
> is sufficiently demonstrated by a high-level explanation.

Okay noted.
>
> > The test scripts in the t/helper directory:
> >
> > The tests in this directory are invoked by the corresponding shell
> > scripts which spawn processes to test the different unit tests in the
> > t/helper directory.
> >
> > The process involved in converting these shell scripts to Clar
> > framework will typically follow the same steps as illustrated above
> > bar the following differences.
> >
> > Identifying the tests to be converted to Clar
> >
> > Create a new .c  file name which should be named appropriately to
> > illustrate what the file is testing.
> >
> > However, the shell-based script which tests the functions in t/helper
> > will be studied for in-depth understanding and then refactored into a
> > .c file which follows the steps above in converting to use Clar.
>
> As mentioned above, I thought we didn't have any such tests anymore. If
> we do, it might make sense to provide an example of such a thing that
> needs to be converted.

Thank you Patrick
Okay from my understanding, such tests have a .c file in t/helper and
a corresponding t/t-<number>-<name>.sh file.
From my master branch which I study, I can see for example
   - test-env-helper.c in t/helper and t0017-env-helper.sh
   - test-find-pack.c in t/helper and t0081-find-pack.sh.
I concluded since the shell script used to compare the output against
the expected still exists
and no such file names exist in t/unit-tests, I assumed they have not
been ported which is why I listed files
in t/helper will be converted to clear.
Please I will be happy if I can get more clarity, thanks.

>
> > Project Timeline:
> >
> > Community Bonding (Present - November 26):
> >
> > Continue making contributions to the Git codebase working on different
> > things within my capacity and getting more familiar with the codebase,
> > participating in patches review.
> >
> > Conversion of tests begins (December 9 - December 23): Familiarize me
> > with the conversion process to further enhance my understanding,
> > identify files for conversion and start the conversion process, and
> > set up a blog for weekly updates on my conversion process.
>
> Makes sense.
>
> > Implementation of community and mentor reviews (December 27 - January 3=
1):
> >
> > Continue with conversions while testing converted tests, communicating
> > with reviewers and implementing reviews.
> >
> > Testing (February 1 - March 1): Continuously determine the correctness
> > of the converted tests by continuously testing and also liaising with
> > mentors constantly.
>
> For this one here'd I'd recommend to start more iteratively. What you
> have here sounds a bit like a waterfall model, where you first convert
> all tests and then eventually test and send things over to the mailing
> list.
>
> In the Git community you will likely have more success if you work in
> smaller patches. E.g. pick a small set of tests to convert, convert
> them, polish the series and then send it to the mailing list. That cycle
> would then repeat several times until you have converted all of the
> tests.

Yes, my contributions have made me understand this process.
I will make appropriate adjustments. Thank you
>
> > Availability:
> >
> >  I am not currently enrolled in any academic program or have any jobs,
> > and will be available to work on the project for a minimum of 45 hours
> > per week.
>
> You really shouldn't be working more than 40 hours per week ;) The
> [Outreachy Internship Guide](https://www.outreachy.org/docs/internship/)
> recommends 30 hours per week, and I don't expect any more of you,
> either.

>
> Other than that this document looks good to me, thanks!
>
> Patrick

Thank you very much Patrick, I appreciate your time. Please I will
also like to know if i should send the corrected proposal
as a mail to the list as I did with this first version.

Thanks again for your time.
Abraham Samuel
