Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D13CF6A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940660; cv=none; b=KOYfA7wP0bBYoB/861UsWLdEMccz5orqU6W64udUOgcVUsxPzzc1A904itph8yrHEgnS7McGz1LWLV/UbRb/Mh04dP4vbQ65AXAerU34xO8KFPshFsDTgwM723elfwaRIIeMFQClY4ipKXhMriHZ0sDB1LMt+lufI72NHfqDneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940660; c=relaxed/simple;
	bh=q5eYTQlJ+kag/ddVFCg74NYL60uqLt1g/DMhxcnmzMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWqIckg/mIX+6ULCsTWo9FXHIs//WNGo3XINfsg5z8F7X0AA2J2XPg19HOPMW0n/+2daOulft5VRzfGnj3BPb6QOh9h8tR97OEp8wGqFASGf/s+CfQqFL7uk4BK1j80UFnw8/2gODsZWWIwwRBaO35H66pS9taV/FSfsKJnwCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+NhTYFx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+NhTYFx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ba938de0so494131366b.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710940656; x=1711545456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFmlVvcZ7PJXOTNziGeKG02583fcOcEaLBSh7Wkt0GU=;
        b=A+NhTYFxsLudIZ8oTJPKH6c82ocbHrbXfEIGEFVRcf0AiWYbKP6lBmAoqzVkMoa7mK
         GbEZFHlvm9sOJS+5lzm+m7Go3yJ6r8f6TTy9/BJfP3axF8+u3KF/DUkiXjX8cfWOcYj1
         +ni122ry606/rOcQHaO2jlYOzmlitzOhJKJ9HesKqk5orF92zsMAomiMjCtN+zhxwIjB
         uS6zOnX2zCvjbE1wEa9UtkGq5mlaiV6RK1jPT8fLB61GbZtNXT/cGfHnm1GjefH+BGDz
         RKn4QHp5lEkKjeGi1WkoX6ipzzZJECRjMVQPXoQpbgatraK35L0mx08cgVsNroJcc0X2
         HDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940656; x=1711545456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFmlVvcZ7PJXOTNziGeKG02583fcOcEaLBSh7Wkt0GU=;
        b=E0UzWwOoZpGQFq2Op1aFzv7K1o+rL7RmqiqKsNGJgEsYclCo0x5tvDW3rZqpmInsl/
         3gWuLKkK5HDrhij1oa06Cq+lH98sbrumZc7qEg9s73b45ePMEx99MDQrnh7huoR+44tF
         /8TKVxlUQVnyxX8J2OLFAimieyLwIb9UhRwqR6W7LeoWFVl5L+9DgJWGQTFGI0dEGQU3
         f5uvtSSzFmtw8zaALJN1BsfCX/ZGlQrbXNBqkmi4/fMiu/0vY1R6AlNCuW11Q178IlEm
         2LgCg162+ZB9AvNlP+iChHbrCiQOBVbsmEC7B0Z9LabkK1YC5ab0aLeoi9lB0sE6kh+2
         STEA==
X-Gm-Message-State: AOJu0YxKSFGCb5KytiSVsKmzWUH9/SqZ5SMS66MYroCetcy3BoZHmqf6
	9RdKBBTs8JMeXldMydVghHkpiIb02BvecdsQtdQgskFcTSmVcF4CKAo1mvgAbs7GGt4uyT+W9V+
	AdGUv6GDToYGeRrYjKp2kHAXoQ1M=
X-Google-Smtp-Source: AGHT+IEHYM9+BqDrN9xXED2wEm/tpbQkGB2TI3a7fGx8lTJAnlElyRoFr5ntkdoVGDfkcIpXLwFszs6V1ZhF5WxecYk=
X-Received: by 2002:a17:906:1352:b0:a46:7ee2:f834 with SMTP id
 x18-20020a170906135200b00a467ee2f834mr10777844ejb.11.1710940655407; Wed, 20
 Mar 2024 06:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
In-Reply-To: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Mar 2024 14:17:23 +0100
Message-ID: <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
Subject: Re: [RFC][GSoC] Proposal: Move reftable and other tests to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ps@pks.im, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:11=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> This is my project proposal for the Google Summer of Code 2024 program.
> The document version of this proposal can be accessed through this link:
> https://shorturl.at/ijrTU
>
> ---------<8----------<8----------<8----------<8----------<8----------<8
>
> Personal Info
> -------------
>
> Full name: Chandra Pratap
> Preferred name: Chand
>
> E-mail: chandrapratap3519@gmail.com
> Phone: (+91)77618-24030
>
> Education: SV National Institute of Technology, Surat, India
> Year: Sophomore (2nd)
> Major: Mathematics
>
> GitHub: https://github.com/Chand-ra
>
> Before GSoC
> -----------
>
> -----Synopsis-----
>
> A new unit testing framework was introduced to the Git mailing list last
> year with the aim of simplifying testing and improving maintainability.
> The idea was accepted and merged into master on 09/11/2023. This project
> aims to extend that work by moving more tests from the current setup to
> the new unit testing framework.
>
> The SoC 2024 Ideas page (link: https://git.github.io/SoC-2019-Ideas/)
> mentions reftable unit tests migration as a separate project from the
> general unit test migration project, however, I propose migrating other
> tests alongside the reftable unit tests as a part of this proposal.

It means that if we select your proposal, we cannot select someone
else to work on either the "Move existing tests to a unit testing
framework" project or the "Convert reftable unit tests to use the unit
testing framework" project.

I am not sure but I think that, after migrating all the reftable unit
tests, I would prefer you working on other reftable related tasks
rather than on more unit test migrations.

> The reasoning behind this is explained further down.
> The difficulty for the project should be medium and it should take
> somewhat between 175 to 350 hours.
>
> -----Contributions-----
>
> =E2=80=A2 apply.c: make git apply respect core.fileMode settings
> -> Status: merged into master
> -> link: https://public-inbox.org/git/20231226233218.472054-1-gitster@pob=
ox.com/

A link to (or the hash of) the commit that merged your patch into the
master branch would be nice.

> -> Description: When applying a patch that adds an executable file, git
> apply ignores the core.fileMode setting (core.fileMode specifies whether
> the executable bit on files in the working tree are to be honored or not)
> resulting in false warnings. Fix this by inferring the correct file mode
> from the existing index entry when core.filemode is set to false. Add a
> test case that verifies the change and prevents future regression.
>
> -> Remarks: This was the first patch I worked on as a contributor to Git.
> Served me as an essential intro lesson to the community=E2=80=99s working=
 flow and
> general practices.
>
> =E2=80=A2 tests: Move t0009-prio-queue.sh to the unit testing framework
> -> Status: merged into master
> -> link: https://public-inbox.org/git/pull.1642.v4.git.1705865326185.gitg=
itgadget@gmail.com/

I don't think it's a good idea to submit patches related to a project
we propose before the GSoC actually starts. We might have been able to
detect this earlier if you added [GSoC] to the patch titles.

Also a link to (or the hash of) the commit that merged your patch into
the master branch would be nice.

> -> Description: t/t0009-prio-queue.sh along with t/helper/test-prio-queue=
.c
> unit test Git's implementation of a priority queue. Migrate the test
> over to the new unit testing framework to simplify debugging and reduce
> test run-time.
>
> -> Remarks: Perhaps the most relevant patch of all the ones mentioned
> here, this patch helped me understand the expectations and workflow for
> the work to be performed in this project.
>
> =E2=80=A2 write-or-die: make GIT_FLUSH a Boolean environment variable
> -> Status: merged into master
> -> link: https://public-inbox.org/git/pull.1628.v3.git.1704363617842.gitg=
itgadget@gmail.com/

Also a link to (or the hash of) the commit that merged your patch into
the master branch would be nice.

> -> Description: Among Git's environment variable, the ones marked as

s/variable/variables/

> "Boolean" accept values like Boolean configuration variables, i.e.
> values like 'yes', 'on', 'true' and positive numbers are taken as "on"
> and  values like 'no', 'off','false' are taken as "off". Make GIT_FLUSH
> accept more values besides '0' and '1' by turning it into a Boolean
> environment variable & update the related documentation.
>
> =E2=80=A2 sideband.c: remoye redundant NEEDSWORK tag

s/remoye/remove/

> -> Status: merged into master
> -> link: https://public-inbox.org/git/pull.1625.v4.git.1703750460527.gitg=
itgadget@gmail.com/

Also a link to (or the hash of) the commit that merged your patch into
the master branch would be nice.

> -> Description: Replace a misleading NEEDSWORK tag in sideband.c that
> reads =E2=80=98replace int with size_t=E2=80=99 with another comment expl=
aining why it
> is fine to use =E2=80=98int=E2=80=99 and the replacement isn=E2=80=99t ne=
cessary.
>
> =E2=80=A2 make tig callable from PowerShell/Command Prompt
> -> Status: merged into main
> -> link: https://github.com/git-for-windows/MINGW-packages/pull/104
>
> -> Description: Tig is a text mode interface for Git that ships with the
> standard Git for Windows package but isn=E2=80=99t callable from PowerShe=
ll/
> Command Prompt by default. Fix this by updating the relevant Makefiles
> and resource scripts.
>
> =E2=80=A2 fix broken link on Git for Windows=E2=80=99 GitHub wiki
> -> Status: merged
> -> link: https://github.com/git-for-windows/git/wiki/Home/_history
>
> -> Remarks: A simple fix for a broken link that I stumbled upon while
> browsing Git for Windows=E2=80=99 wiki looking for some help with the pat=
ch
> mentioned just before this one.
>
> =E2=80=A2 t4129: prevent loss of exit codes due to the use of pipes
> -> Status: merged into master
> -> link: https://lore.kernel.org/git/20220311132141.1817-1-shaoxuan.yuan0=
2@gmail.com/

The link shows a patch from 2022 by Shaoxuan Yuan. Are you sure this
is the right link?

> -> Description: Piping the output of git commands like git-ls-files to
> another command (grep in this case) in t4129 hides the exit code returned
> by these commands. Prevent this by storing the output of git-ls-files to
> a temporary file and then "grep-ping" from that file. Replace grep with
> test_grep as the latter is more verbose when it fails.
>
> =E2=80=A2 t9146: replace test -d/-f with appropriate test_path_is_* funct=
ion
> -> Status: merged into master
> -> link: https://public-inbox.org/git/pull.1661.v3.git.1707933048210.gitg=
itgadget@gmail.com/

Also a link to (or the hash of) the commit that merged your patch into
the master branch would be nice.

> -> Description: The helper functions test_path_is_* provide better debugg=
ing
> information than test -d/-e/-f.
> Replace tests -d/-e/-f with their respective =E2=80=98test_path_is_foo=E2=
=80=99 calls.
>
> =E2=80=A2 regex: update relevant files in compat/regex
> -> Status: WIP
> -> link: https://github.com/gitgitgadget/git/pull/1641

This is a GitGitGadget patch. Please mention that. Same thing for some
other contributions above that are not part of Git.

> -> Description: The RegEx code in compat/regex has been vendored from
> gawk and was last updated in 2010. This may lead to performance issues
> like high CPU usage. Fix this by synchronizing the relevant files in
> compat/regex with the latest version from GNULib and then replaying any
> changes we made to gawk=E2=80=99s version on top of the new files.
>
> -> Remarks: When I started working on this patch, I thought it was an
> easy fix but the work turned out to be more involved than I anticipated.
> I had to seek help from the other community members, and we have made
> some good progress, but there is still a lot of cleaning and changes that
> need to be done. I haven=E2=80=99t found enough time to commit to this ag=
ain,
> but it=E2=80=99s surely something that I want to get done soon.
>
> =E2=80=A2 tests: Move t0032-reftable-unittest.sh to the unit testing fram=
ework
> -> Status: WIP
> -> link: https://github.com/gitgitgadget/git/pull/1698
>
> -> Description: t/t0032-reftable-unittest.sh along with t/helper/test-ref=
table.c
> unit test Git=E2=80=99s reftable framework. Migrate the test over to the =
new
> unit testing framework to simplify debugging and reduce test run-time.
>
> -> Remarks: An infant version as of now, I tinkered with this after
> seeing the project list on 'Git SoC 2024 Ideas' page to get an idea of
> the kind of work that will be involved in this project.

It's Ok to tinker and to mention this. I hope it helped you write this prop=
osal.

> -----Related Work-----
>
> Prior works about the idea have been performed by other community members
> and previous interns which form a good guiding path for my own approach.
> Some previous example work:
>
> i) Port helper/test-ctype.c to unit-tests/t-ctype.c
> -> link: https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmai=
l.com/
>
> ii) Port test-sha256.c and test-sha1.c to unit-tests/t-hash.c
> -> link: https://lore.kernel.org/git/20240229054004.3807-2-ach.lumap@gmai=
l.com/
>
> iii) Port helper/test-date.c to unit-tests/t-date.c
> -> link: https://lore.kernel.org/git/20240205162506.1835-2-ach.lumap@gmai=
l.com/
>
> iv) Port test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
> -> link: https://lore.kernel.org/git/20240310144819.4379-1-ach.lumap@gmai=
l.com/
>
> v) Integrate a simple strbuf unit test with Git's Makefiles
> -> link: https://lore.kernel.org/git/20230517-unit-tests-v2-v2-4-21b5b60f=
4b32@google.com/
>
> vi) t0080: turn t-basic unit test into a helper
> -> link: https://lore.kernel.org/git/a9f67ed703c8314f0f0507ffb83b503717b8=
46b3.1705443632.git.steadmon@google.com/

Thanks for mentioning these.

> In GSoC
> -------
>
> -----Plan-----
>
> -> Reftable tests:
>
> The reftable tests are different from other tests in the test directory
> because they perform unit testing with the help of a custom test framewor=
k
> rather than the usual =E2=80=98helper file + shell script=E2=80=99 combin=
ation.
> Reftable tests do have a helper file and a shell script invoking the
> helper file, but rather than performing the tests, this combination is
> used to invoke tests defined in the reftable directory.
>     The reftable directory consists of nine tests:
>
> =E2=80=A2  basics test
> =E2=80=A2  record test
> =E2=80=A2  block test
> =E2=80=A2  tree test
> =E2=80=A2  pq test
> =E2=80=A2  stack test
> =E2=80=A2  merged test
> =E2=80=A2  refname test
> =E2=80=A2  read-write test
>
> Each of these tests is written in C using a custom reftable testing
> framework defined by reftable/test_framework (also written in C). The
> framework has four major features utilized in performing the tests:
>
> =E2=80=A2  EXPECT_ERR(c): A function-like macro that takes as input an in=
teger
> =E2=80=98c=E2=80=99 (generally the return value of a function call), comp=
ares it against
> 0 and spits an error message if equality doesn=E2=80=99t hold. The error =
message
> itself contains information about the file where this macro was used,
> the line in this file where the macro was called and the error code =E2=
=80=98c=E2=80=99
> causing the error.
>
> =E2=80=A2  EXPECT_STREQ(a, b): A function-like macro that takes as input =
two
> strings =E2=80=98a=E2=80=99 and =E2=80=98b=E2=80=99, compares them for eq=
uality via strcmp() and throws an
> error if equality doesn=E2=80=99t hold. The error message thrown contains=
 information
> regarding the file where this macro was invoked, the line in this
> file where the macro was called and the mismatched strings =E2=80=98a=E2=
=80=99 and =E2=80=98b=E2=80=99.
>
> =E2=80=A2  EXPECT(c): A function-like macro that takes as input an intege=
r =E2=80=98c=E2=80=99
> (generally the result of a Boolean expression like a =3D=3D b) and throws=
 an
> error message if c =3D=3D 0. The error message is similar to EXPECT_ERR(c=
).
>
> =E2=80=A2  RUN_TEST(f): A function-like macro that takes as input the nam=
e of a
> function =E2=80=98f=E2=80=99 (a test function that exercises a part of re=
ftable=E2=80=99s code),
> prints to stdout the message =E2=80=98running f=E2=80=99 and then calls t=
he function with f().
>
> Other than these, the framework consists of two additional functions,
> set_test_hash() and strbuf_add_void() which are used  exclusively in the
> stack tests and refname tests respectively.
>
> Since the reftable test framework is written in C like the unit testing
> framework, we can create a direct translation of the features mentioned
> above using the existing tools in the unit testing framework with the
> following plan:
>
> =E2=80=A2  EXPECT_ERR(c): Can be replaced by check(!c) or check_int(c, =
=E2=80=9C=3D=3D=E2=80=9D, 0).
>
> =E2=80=A2  EXPECT_STREQ(a, b): Can be replaced by check_str(a, b).
>
> =E2=80=A2  EXPECT(c): Can be replaced by check_int(), similar to EXPECT_E=
RR.
>    E.g. expect(a >=3D b) --> check_int(a, =E2=80=9C>=3D=E2=80=9D, b)
>
> =E2=80=A2  RUN_TEST(f): Can be replaced by TEST(f(), =E2=80=9Cmessage exp=
laining the test=E2=80=9D).
>
> The information contained in the diagnostic messages of these macros is
> replicated in the unit testing framework by default. Any additional
> information can be displayed using the test_msg() functionality in the
> framework. The additional functions set_test_hash() and strbuf_add_void()
> may be moved to the source files for stack and refname respectively.

You mean "reftable/stack.c" and "reftable/refname.c"?


> The plan itself is basic and might need some modifications, but using
> the above plan, I have already created a working albeit primitive copy fo=
r
> two out of the nine tests (basics test and tree test) as can be seen here=
:
> (link: https://github.com/gitgitgadget/git/pull/1698)
>
> -> Other tests:
>
> As is already mentioned, the rest of the tests in the test directory use =
the
> combination of a helper file (written in C) and a shell script that invok=
es
> the said helper file. I will use my work from the patch
> =E2=80=98tests: Move t0009-prio-queue.sh to the unit testing framework=E2=
=80=99
> (link: https://public-inbox.org/git/pull.1642.v4.git.1705865326185.gitgit=
gadget@gmail.com/)
> to explain the steps involved in the porting of such tests:
>
> =E2=80=A2 Search for a suitable test to port: As Christian Couder mention=
ed in this
> mail (link: https://public-inbox.org/git/CAP8UFD22EpdBU8HJqFM+=3D75EBABOT=
f5a0q+KsbzLK+XTEGSkPw@mail.gmail.com/),
> there exists a subset of t/helper worth porting and we need some sort of
> classification to discern these.
>
> All helper files contain a cmd__foo() function which acts as the entry
> point for that helper tool. For example, the helper/test-prio-queue.c
> file contained cmd__prio_queue() which served as the entry point for the
> prio-queue tool. This function is then mapped to a different name by
> helper/test-tool.c which is used by the =E2=80=98*.sh=E2=80=99 files to p=
erform tests.
> Continuing the prior example, cmd__prio_queue() had been mapped to
> =E2=80=9Cprio-queue=E2=80=9D by test-tool.c and t0009-prio-queue.sh invok=
ed it like
> =E2=80=9Cprio-queue 1 2 get 3 dump=E2=80=9D.
>
> To classify what among t/helper should be targeted first in this project
> we can use something like =E2=80=98git grep foo=E2=80=99 (where foo is th=
e alias for cmd__foo())
> to look at the instances where the helper tool is invoked. The ones appea=
ring
> lesser in different test scripts are the ones most likely to be used sole=
ly
> for unit testing and should probably be targeted first.
> Utilising this strategy, I discovered that the =E2=80=98prio-queue=E2=80=
=99 tool was only
> used in t0009-prio-queue.sh and hence, was a good candidate for the unit
> testing framework.
>
> Note that this strategy is not full-proof and further investigation is
> absolutely required on a per-test basis, it is only meant to give an
> initial idea of what=E2=80=99s worth investigating.
>
> =E2=80=A2  Create a new C test file in t/unit-tests: After finding a test=
 appropriate
> for the migration efforts, we create a new =E2=80=98*.c=E2=80=99 file in =
t/unit-tests.
> The test file must be named appropriately to reflect the nature of the
> tests it is supposed to perform. Most of the times, replacing =E2=80=98tX=
XXX=E2=80=99
> with =E2=80=98t-=E2=80=98 and =E2=80=98*.sh=E2=80=99 with =E2=80=98.c=E2=
=80=99 in the name of the test script suffices.
> E.g. t/t0009-prio-queue.sh turns to t/unit-tests/t-prio-queue.c. The
> new C file must #include =E2=80=9Ctest-lib.h=E2=80=9D (to be able to use =
the unit
> testing framework) and other necessary headers files.
>
> =E2=80=A2  Move the code from the helper file: Since the helper files are=
 written
> in C, this step is mostly a =E2=80=98copy-paste then rename=E2=80=99 job.=
 Changes similar
> to the following also need to be made in the Makefile:
> -    TEST_BUILTINS_OBJS +=3D test-prio-queue.o
> +    UNIT_TEST_PROGRAMS +=3D t-prio-queue
>
> =E2=80=A2  Translate the shell script: The trickiest part of the plan, si=
nce
> different test scripts perform various functions, and a direct translatio=
n
> of the scripts to C is not always optimal. Continuing the prior example,
> t0009-prio-queue.sh used a single pattern for testing, write expected
> output to a temporary file (named =E2=80=98expect=E2=80=99) -> feed input=
 to the =E2=80=98prio-queue=E2=80=99
> helper tool -> dump its output to another temporary file (named =E2=80=98=
actual=E2=80=99)
> -> compare the two files (=E2=80=98actual=E2=80=99 vs =E2=80=98expect=E2=
=80=99).
>
> In the first iteration of my prio-queue patch, I worked out a
> straightforward translation of this pattern in C. I stored the input in
> a string buffer, passed that buffer to the test function and stored its
> output in another buffer, and then called memcmp() on these two buffers.
> While this did prove to be a working copy, this work was found to be inad=
equate
> on the mailing list. Through the next several iterations, I reworked the
> logic several times, like comparing the input and output on-the-go rather
> than using buffers and replacing strings with macro definitions.
>
> The test scripts similarly perform other functions like checking for
> prerequisites, creating commits, initializing repositories, changing or
> creating directories and so forth, and custom logic is required in most
> of the cases of translating these, as seen above.
>
> =E2=80=A2  Run the resulting test, correct any errors: It is rare for any=
 migrated
> test to work correctly on the first run. This step involves resolving any
> compile/runtime errors arising from the test and making sure that at the
> very minimum, all the test-cases of the original test are replicated in t=
he
> new work. Improvements upon the original can also be made, for example, t=
he
> original t0009-prio-queue.sh did not exercise the reverse stack
> functionality of prio-queue, which I improved upon in unit-tests/t-prio-q=
ueue.
>
> =E2=80=A2  Send the resulting patch to the mailing list, respond to the f=
eedback:
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
> =E2=80=A2 Reftable tests:
>
> If my current work from 'tests: Move t0032-reftable-unittest.sh to the un=
it
> testing framework' is found satisfactory, there are 7 tests left that nee=
d
> to be ported to the unit testing framework. Assuming it takes 2-3 days to
> port one test, I should be done with the first patch series for the refta=
ble
> tests in about 2-3 weeks. From there, it=E2=80=99s a matter of responding=
 to the
> feedback from the mailing list, which can deceptively take longer than ex=
pected.
> For instance, I had to continue polishing my t-prio-queue patch for about
> two weeks after the feedback on the first iteration.
>
> =E2=80=A2 Other tests:
>
> The time required to port these tests is highly variable and depends most=
ly
> upon the work required in translating the shell script. As mentioned
> previously, it took me 3-4 days to complete the first iteration of the
> test-prio-queue migration patch, and that was a short test with only abou=
t
> 50 or so lines of shell scripting and all the test cases following a sing=
le
> pattern. Considering all this, I believe it should be possible, on averag=
e,
> to migrate a new test in 5-8 days.
>
> Hence, it should be possible for me to migrate >=3D7 tests along with the
> reftable tests throughout the duration of this project.
>
> Availability
> ------------
>
> My summertime is reserved for GSoC, so I expect that I can work on a new
> test 5 days per week, 6-8 hours per day, that is 30-40 hours a week.
> On the weekends, I would like to solely work on the feedback from
> the mailing list and advance my [WIP] patches. Certainly, something
> unexpected may arise, but I will try my best to adhere to this time
> commitment and be always available through the community=E2=80=99s mailin=
g list.
>
> Post GSoC & Closing Remarks
> ---------------------------
>
> When I first started contributing to the Git project in October of 2023,
> I had no idea about programmes like GSoC. I was advised by a senior of
> mine to contribute to open-source projects and hence, my aim of contribut=
ion
> was to apply what I had learnt in college to solve real-world problems
> and learn from more experienced peers. However, most of what I have
> contributed to Git has been trivial owing to my lack of skills and
> inexperience with the project.
>
> Seeing how I need to do an internship in summer, with GSoC, I hope to be
> able to dedicate this internship time and effort to a cool project like
> Git while simultaneously learning skills to be able to make more useful
> contributions in the future. It=E2=80=99s two birds with one stone. I wou=
ld also
> like to keep working on this project to see it to completion post-GSoC
> and help mentor other newcomers get started with the Git project.


> -- After GSoC --
> ---------------------
>
> After GSoC I intend to be a part of the community and keep
> contributing to the git=E2=80=99s codebase. I eagerly want to learn a lot=
 from
> the git community and enhance my skills. I also see myself making
> important contributions to git in the future.
>
> When I first joined the community 2 months ago, the ancient way of
> collaborating through a mailing list by sending diff patches was
> really puzzling (GitHub was the only means that I knew about for
> open-source collaboration). After sending a patch I got a little
> comfortable with it and started loving it.
>
> -- Closing remarks --
> ----------------------------
>
> I am really enthusiastic to contribute to git. I really want to learn
> a lot from my mentors and the whole git community. Everyone
> contributes using git, why not contribute to git :).
>
> In the end I really want to thank the whole community, especially
> Christian and Junio, for their valuable time in reviewing my patches
> and guiding me with the problems I faced.

Thanks for your proposal. Please make sure you submit it soon as a pdf
file to the GSoC website. It can then be updated by uploading a new
pdf until the April 2 1800 UTC deadline.
