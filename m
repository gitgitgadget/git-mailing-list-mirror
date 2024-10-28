Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BC18C031
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093114; cv=none; b=A+PdUBkxI2mTuh2qfx8eWBcSf+GHL0g8wOL7ipYQA9hCh54RM7OAiV92ku/tm1DmTOzDeD3jo1JXrjXBFga0weC5o9ktH7bYTrLxuLbDrtS7qs0x/yZxWxqyWdn9b4qL8+IQZtKwYjdq9Q8l2+2Vy3J2YHpZkhnznZrq4jsN+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093114; c=relaxed/simple;
	bh=zWmoed6z1iUKi4iTLucL1rO2/IBfb1HvpJ/KH8bfwlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzdPZcjtlsrM2ktQQzWySl7yCXk0m2IXfKIXLeHhntATzveW/A2lGKYLRRT7eyNNWP+NvUSjCpnh+MV6X/UUcEV7xtrh/M0WYyOWq1AlPfqiDB36tvGU5mEjl5PYPAV/s4azIEssIAxxSAn1oPoDzkRiCmRR7hvK5uOi2PahpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4ZVOBux; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4ZVOBux"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315abed18aso37973845e9.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730093109; x=1730697909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY0LnE7j6o/K1cq7P9nu714M/a4xt2lK3pYCK1mnZYg=;
        b=b4ZVOBuxvejt3JILypvNhk52n7WM/NdxPnD0DJ6qqPYcPSvvjlkwKY7XXC2VrzZiZm
         2HAhwz8h3trBqSh8wkEtQ+QoAu7Ts40JHIv+KO4RG/JBQPzf0QTdLiKzAhNt8niA4jvK
         6xn5wGS3afs8Oqmmv61Yfc3MC9zuUbF9pQd/ShryEwFBQttEo2ni7n3vh+kXqF//s9gc
         EZxZUo7iTIuSNj8eF2aug+jyQNFJK2myiQBJxyYdVp2j5FrieH/20vI1px9dq/kkS1us
         3UIeWHSxMAZNRMkjgcanWX37ifMml0eiLsdLJl+AJGIVoFgTVYpAhUvLBuxjwpbUroaX
         5XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093109; x=1730697909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY0LnE7j6o/K1cq7P9nu714M/a4xt2lK3pYCK1mnZYg=;
        b=MuVutBUs6ardid+o2k91CZLefG7zrwdoZhsiuW4/ip1XWKmHnlN4T5pwXTtmaMJgfr
         GsSRT4RQE/lwfUvwHRFsYVpfXQIdBXEs/w1wt6l8QONVQrgGi4F6KD3twfksFbyFfpFL
         s6/YTQbhOWEnGl716xNYaffbVpQzzKr6ssNxa7Abj10hTu/2xkw1CJ2TmHF3l/f6qekR
         OKvY7ctUlNSapFORnXNoTPG0V06FnA7xbKNsg9ejXg2rSgpRQcvd/PdrabTcMfEU3nvG
         d68SbZ/yyugCLRUBbH7OLFxHmSXFh/ptN8U8Ip6tg9yB7eUIHPIbQijataoWDd41isyx
         kDgw==
X-Gm-Message-State: AOJu0YwvsuX4mbiIOe1qfLJm01dO8CJUDouIKmrziddeclnZmKkSwb3j
	Ab5AHcvO9lNc64MgiAkSdO1L4D9m8Rs0dy3VK401MNQe3ie47k8QKaXCENFJUkM7ADt4/VzBcXK
	tjza5Jqs1rFCrW6lkT3GLvf71QoU=
X-Google-Smtp-Source: AGHT+IErqxAtIXrYV2jKhNEqO5C6JYZAyukuszyMiRH/fRJKbVA7zSqmEMdhz/kF/AzoIv3eZLG4Q54NJbKlLzAxX48=
X-Received: by 2002:a05:600c:1d22:b0:42f:7ed4:4c25 with SMTP id
 5b1f17b1804b1-4319acb1739mr64006165e9.14.1730093108612; Sun, 27 Oct 2024
 22:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
 <ZxttGFtt5nnc7g9Z@pks.im> <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
 <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com>
In-Reply-To: <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 28 Oct 2024 05:24:59 +0000
Message-ID: <CADYq+fbsnyyYosGFVEG=EWRhrwtKhynw6HAN1ac4NJM+an0tRg@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar testing framwork
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 6:56=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Fri, Oct 25, 2024 at 2:22=E2=80=AFPM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > On Fri, Oct 25, 2024 at 11:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > On Wed, Oct 23, 2024 at 10:45:52PM +0100, Samuel Abraham wrote:
> > >
> > > Thanks for your application!
> > >
> > > > ## Project Overview - Convert unit test to use the Clar testing fra=
mework:
> > > >
> > > > I understand that the Git project is in the process of converting i=
ts
> > > > unit tests to the Clar testing framework to improve test readabilit=
y,
> > > > consistency and maintainability, a move away from homegrown unit te=
st
> > > > frameworks such as t/helper/test-tool.h and t/unit-test/test-lib.h.
> > >
> > > Nit: we've basically moved away from test-tool for unit tests already=
,
> > > to the best of my knowledge. So this is more about the second part,
> > > moving away from our own test framework.
> >
> > Thank you very much for the clarity.
> > >
> > > > Clar provides a structured and efficient way to write and execute
> > > > tests and is well-suited for a project like Git where robust testin=
g
> > > > is essential to maintain quality and stability.
> > >
> > > It would be nice to provide some pointers _why_ we think that clar is
> > > better suited ;) Hint: you may have a look at the patch series that
> > > introduced the clar for some ideas there.
> >
> > Okay I will do that.
> >
> > >
> > > [snip]
> > > > ## Project Plan:
> > >
> > > Formatting of this section is a bit funky, which makes it harder than
> > > necessary to figure out which parts belong together. I'd propose to
> > > first provide a high-level list of the steps you want to do with a
> > > bulleted list and then maybe put more detailed explanations into
> > > separate "### subsections". You may also want to convert links to use
> > > [Markdown syntax](https://www.markdownguide.org/basic-syntax/#links),
> > > which provides some structure aronud them.
> >
> > Okay thank you for this.
> > >
> > > > The first steps to migrating existing tests to Clar would be studyi=
ng
> > > > existing tests in the t/helper and t/unit-tests directory which wil=
l
> > > > enable me to determine those appropriate for conversion.
> > > >
> > > > Liaise with mentors and community members to determine the viabilit=
y
> > > > of converting the selected test for conversion.
> > > >
> > > > Convert the selected test to Clar while in constant effective
> > > > communication with the mentors and Git community, implementing
> > > > feedback and review suggestions.
> > > >
> > > > Properly test converted scripts to ensure validity and correctness.
> > > >
> > > > Steps to converting the existing unit tests to the Clar Testing Fra=
mework
> > > >
> > > >  From the project description in the Outreachy Project Description =
page,
> > > >
> > > >
> > > > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/comm=
unities/git/#convert-unit-tests-to-use-the-clar-testing-framewo,
> > > > the goal is to convert all Git=E2=80=99s existing unit tests to use=
 the Clar
> > > > testing framework exclusively.
> > >
> > > It might also make sense to plan some time to add missing features to
> > > the clar if we hit anything during the conversion.
> >
> > Okay noted.
> > >
> > > > The existing unit tests which would need to be converted to Clar ar=
e;
> > > >
> > > > .c test files present in t/unit-tests: Tests in this directory use =
the
> > > > t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=
=9D scripts,
> > > > converted from the shell-based testing which used the tests in
> > > > t/helper/ and corresponding t<number>-<name>.sh test files. Example=
s
> > > > of this conversion can be seen in the link below which references A=
chu
> > > > Luma=E2=80=99s work
> > > >
> > > > https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.c=
om/.
> > > >
> > > >
> > > > The link shows the work done in converting the test from
> > > > t/helper/test-sha1.c and test/helper/test-sha256.c to use
> > > > t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framew=
ork
> > > >
> > > >
> > > > The steps to convert files located in this directory include;
> > > >
> > > > - Identify the test files to be converted.
> > > >
> > > > Examples of such files are the t/unit-tests/t-hash.c, t/unit-tests/=
t-strbuf.c
> > > >
> > > > - Rename the test file from t-<name>.c to <name>.c. This pattern
> > > > follows the style used by Patrick Steinhardt in his conversion of t=
he
> > > > t-strvec.c and t-ctype.c files to use the clar framework.
> > > >
> > > > https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c86=
4.1725459142.git.ps@pks.im/
> > > > and
> > > >
> > > > https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a076558097a24=
0.1725459142.git.ps@pks.im/
> > > >
> > > > As a sample demonstration, we will convert the t/unit-tests/t-hash.=
c
> > > > to use Clar.
> > >
> > > I think the previous explanations are sufficient -- going into the
> > > technical details like you do below is appreciated, but ultimately no=
t
> > > necessary in my opinion. What I'm after here is that you have a rough
> > > understanding of what needs to be done for each of the tests, and tha=
t
> > > is sufficiently demonstrated by a high-level explanation.
> >
> > Okay noted.
> > >
> > > > The test scripts in the t/helper directory:
> > > >
> > > > The tests in this directory are invoked by the corresponding shell
> > > > scripts which spawn processes to test the different unit tests in t=
he
> > > > t/helper directory.
> > > >
> > > > The process involved in converting these shell scripts to Clar
> > > > framework will typically follow the same steps as illustrated above
> > > > bar the following differences.
> > > >
> > > > Identifying the tests to be converted to Clar
> > > >
> > > > Create a new .c  file name which should be named appropriately to
> > > > illustrate what the file is testing.
> > > >
> > > > However, the shell-based script which tests the functions in t/help=
er
> > > > will be studied for in-depth understanding and then refactored into=
 a
> > > > .c file which follows the steps above in converting to use Clar.
> > >
> > > As mentioned above, I thought we didn't have any such tests anymore. =
If
> > > we do, it might make sense to provide an example of such a thing that
> > > needs to be converted.
> >
> > Thank you Patrick
> > Okay from my understanding, such tests have a .c file in t/helper and
> > a corresponding t/t-<number>-<name>.sh file.
> > From my master branch which I study, I can see for example
> >    - test-env-helper.c in t/helper and t0017-env-helper.sh
> >    - test-find-pack.c in t/helper and t0081-find-pack.sh.
> > I concluded since the shell script used to compare the output against
> > the expected still exists
> > and no such file names exist in t/unit-tests, I assumed they have not
> > been ported which is why I listed files
> > in t/helper will be converted to clear.
> > Please I will be happy if I can get more clarity, thanks.
> >
> > >
> > > > Project Timeline:
> > > >
> > > > Community Bonding (Present - November 26):
> > > >
> > > > Continue making contributions to the Git codebase working on differ=
ent
> > > > things within my capacity and getting more familiar with the codeba=
se,
> > > > participating in patches review.
> > > >
> > > > Conversion of tests begins (December 9 - December 23): Familiarize =
me
> > > > with the conversion process to further enhance my understanding,
> > > > identify files for conversion and start the conversion process, and
> > > > set up a blog for weekly updates on my conversion process.
> > >
> > > Makes sense.
> > >
> > > > Implementation of community and mentor reviews (December 27 - Janua=
ry 31):
> > > >
> > > > Continue with conversions while testing converted tests, communicat=
ing
> > > > with reviewers and implementing reviews.
> > > >
> > > > Testing (February 1 - March 1): Continuously determine the correctn=
ess
> > > > of the converted tests by continuously testing and also liaising wi=
th
> > > > mentors constantly.
> > >
> > > For this one here'd I'd recommend to start more iteratively. What you
> > > have here sounds a bit like a waterfall model, where you first conver=
t
> > > all tests and then eventually test and send things over to the mailin=
g
> > > list.
> > >
> > > In the Git community you will likely have more success if you work in
> > > smaller patches. E.g. pick a small set of tests to convert, convert
> > > them, polish the series and then send it to the mailing list. That cy=
cle
> > > would then repeat several times until you have converted all of the
> > > tests.
> >
> > Yes, my contributions have made me understand this process.
> > I will make appropriate adjustments. Thank you
> > >
> > > > Availability:
> > > >
> > > >  I am not currently enrolled in any academic program or have any jo=
bs,
> > > > and will be available to work on the project for a minimum of 45 ho=
urs
> > > > per week.
> > >
> > > You really shouldn't be working more than 40 hours per week ;) The
> > > [Outreachy Internship Guide](https://www.outreachy.org/docs/internshi=
p/)
> > > recommends 30 hours per week, and I don't expect any more of you,
> > > either.
> >
> > >
> > > Other than that this document looks good to me, thanks!
> > >
> > > Patrick
> >
> > Thank you very much Patrick, I appreciate your time. Please I will
> > also like to know if i should send the corrected proposal
> > as a mail to the list as I did with this first version.
> >
> > Thanks again for your time.
> > Abraham Samuel
>
>
> Hello Git Community,
>
>
> I hope this mail finds you well.
>
> I am Abraham Samuel, participating in the Outreachy internship program
> and I write to express my delight, enthusiasm and interest in working
> on the project =E2=80=9CConvert unit test to use the Clar testing framewo=
rk=E2=80=9D.
>
> My first exposure to Git started with the book =E2=80=9CLearn Enough Git =
to Be
> Dangerous=E2=80=9D which taught me the basics of using Git for version co=
ntrol
> and collaborations and I felt truly dangerous :-).
>
>
> I am passionate about FOSS and now that I am presented with the
> opportunity to contribute to Git, It is indeed a great opportunity to
> understand what happens under the hood and I have never been happier.
>
>
> ## Introduction:
>
> I completed my ALX Software Engineering program in 2023 and I have
> been engaged in various software development projects, open source
> development and various personal projects, providing me with valuable
> technical and collaborative skills.
>
>
> ## Project Overview - Convert unit test to use the Clar testing framework=
:
>
> I understand that the Git project is in the process of converting its
> unit tests to the Clar testing framework to improve test readability,
> consistency and maintainability, a move away from homegrown unit test
> framework t/unit-test/test-lib.h.
>
> Part of the reasons for this
> [decision](https://lore.kernel.org/git/cover.1722415748.git.ps@pks.im/)
> includes:
>
> 1. Avoidance of duplication when declaring test functions which occurs
> when using the t/unit-tests/test-lib.h framework
>
> 2. Having a proper unit testing framework instead of reinventing the whee=
l
>
> 3. Clar can be easily extended
>
> 4. Clar provides a structured and efficient way to write and execute
> tests and is well-suited for a project like Git where robust testing
> is essential to maintain quality and stability.
>
>
> ## Contribution to the Git Community:
>
> I have participated in contributions to Git=E2=80=99s codebase after gett=
ing
> accepted into the contribution phase in October 2024, working on what
> I found doable and within my reach. Below is the list of my
> contributions:
>
> - [PATCH v4] t7300-clean.sh: use test_path* helper functions for error lo=
gging.
>
>        List thread:
> https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@g=
mail.com/
>
>        Status: merged into master
>
>        Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca
>
>        Description: The patch converted instances of  =E2=80=9Ctest - [de=
f]=E2=80=9D
> in test cases to test_path_* functions to get error logs when the test
> case fails when testing for the existence of a file or directory after
> =E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called a=
s the case may be.
>
>
>
> - [PATCH v4] notes: teach the -e option to edit messages in the editor
>
>        Status: integrated into next
>
>        List thread:
> https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmai=
l.com/
>
>        Description: The patch worked on a #leftover bit which added
> the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D and =
=E2=80=9Cgit notes append=E2=80=9D subcommands
> when the message is supplied with the -F and/or -m options. The patch
> enables fine-tuning the message by invoking the user=E2=80=99s default ed=
itor
> prefilling the message in the editor to allow editing the message to
> the required taste before adding the note to the commit
>
>
> ## Project Plan:
>
>       - Identify files for conversion in the t/unit-tests directory
>
>       - Write incremental patches
>
>       - Convert test and implement community and mentors=E2=80=99 feedbac=
k
>
>       - Validate converted tests
>
>
> ## Detailed Steps
>
>
> ### Identify files for conversion in the t/unit-tests directory:
>
> From the project description in the [Outreachy Git Project Description
> page](https://www.outreachy.org/outreachy-dec-2024-internship-cohort/comm=
unities/git/#convert-unit-tests-to-use-the-clar-testing-framewo),
> the goal is to convert all Git=E2=80=99s existing unit tests to use the C=
lar
> testing framework exclusively and also add any missing features which
> might be necessary for the conversions.
>
> I will begin by selecting files from the t/unit-tests directory for
> conversion to the Clar testing framework. This approach allows me to
> start with smaller, manageable patches that the community can review
> incrementally.
>
> The existing unit tests which would need to be converted to Clar are
> .c test files present in t/unit-tests . Tests in this directory use
> the t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=9D =
scripts (for
> example t/unit-tests/t-hash.c and t/unit-tests/t-strbuf.c), converted
> from the shell-based testing which used the t/helper/test-tool
> framework and corresponding t<number>-<name>.sh test files. Examples
> of this conversion can be seen in [Achu Luma=E2=80=99s
> work](https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.c=
om/),
> which shows the work done in converting the test from
> t/helper/test-sha1.c and test/helper/test-sha256.c to use
> t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framework
>
>
> ### Write incremental patches
>
> Each test conversion will be submitted as an incremental patch,
> following [Git=E2=80=99s contribution
> guidelines](https://github.com/git/git/blob/master/Documentation/Submitti=
ngPatches).
> By keeping patches incremental, the community can provide focused
> feedback on each test conversion, improving the outcome.
>
>
> ### Convert test and implement feedback
>
> Once the files are identified, I will proceed with the conversions
> while regularly communicating with the mentors and the Git community.
> This communication will ensure alignment on the implementation and
> allow immediate adjustments based on any feedback received.
>
> Each file conversion will typically have the following steps:
>
>        - Rename the test file from t-<name>.c to <name>.c. This
> pattern follows the style used by Patrick Steinhardt in his conversion
> of [t-strvec.c](https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f1=
1d4d137c864.1725459142.git.ps@pks.im/)
> and [t-ctype.c](https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a07=
6558097a240.1725459142.git.ps@pks.im/).
>
>        - Add the module name to CLAR_TEST_SUITE variable in the MAKE file=
.
>             CLAR_TEST_SUITE +=3D <name>
>
>        - The next steps will typically involve writing optional setup
> and cleanup functions with the signature =E2=80=9Cvoid
> test_<suitename>__initialize(void)=E2=80=9D and void
> test_<suite_name>__cleanup(void) and the actual tests also with the
> signature
>
> void test_<suitname>__<testname>(void) and the Clar methods such as
> cl_assert(), cl_assert_equal_s(), cl_assert_equal_i() and any other
> implemented assertion methods can be used to verify the results
> against the expected.
>
>
>
>  ### Validate converted tests
>
> Finally, each converted test will be validated to ensure it behaves as
> expected. Tests will undergo a thorough review to confirm that the
> converted scripts accurately replicate the original test=E2=80=99s
> functionality.
>
>
> ## Project Timeline:
>
> Community Bonding (Present - November 26):
>
> Continue making contributions to the Git codebase working on different
> things within my capacity and getting more familiar with the codebase,
> participating in patches review.
>

Understand Git and Clar codebase (December 9 - December 22):

       - I will familiarize myself with the Git codebase to understand
current tests
       - Study previous conversion processes by previous interns to
the now-old unit test framework
          for ideas that would benefit me.
       - Work with Clar upstream to improve shortcomings discovered
during integration with Clar.
       - Set up a blog for weekly updates on my conversion process

> Conversion of tests begins (December 23 - March 1):
>
>     - Identify files for conversion with mentor=E2=80=99s guidance
>
>     - Start conversion process for selected
>
>     - Send incremental patches to the mailing list for review by
>        mentors and   community members
>
>     - Implement review feedback and resend patches to the mailing list
>        until an agreed patch is agreed upon.
>
>     - Update my blog to talk about each conversion and the
>       achievements, challenges and goals achieved.

Final Stages (March 1 - March 7):
       - Update my blog on the gains and knowledge gained during the intern=
ship
       - Work with Git Community to ascertain level of satisfaction
with converted tests
>
>
>
> ## Availability:
>
>  I am not currently enrolled in any academic program or have any jobs,
> and will be available to work on the project for a minimum of 30 hours
> per week.
>
>
> ## After the Internship:
>
> The Git community fosters proper and effective communication,
> regardless of one=E2=80=99s level of experience. The patience, guidance a=
nd
> explanation of technical concepts shown by community members are
> wonderful and this has made me grow not just technically but also
> behaviorally. Due to this, I plan to continue actively participating
> the in Git community and be part next generation of those saddled with
> sustaining this great project and preserving its legacy.
>
>
> I look forward to reviews as regards my proposal.
>
>
> A special appreciation to everyone on the mailing list for reviewing my p=
atches.
>
> My mentors Patrick and Phillip, Junio, Eric, Christian, Brian,
> Kristoff, Taylor, and Josh.
>
> I am grateful to you all.
>
> Thanks
>
> Abraham Samuel.
