Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2E85644
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963343; cv=none; b=SjAoiDrK+zTIoru/7u0dQfj60NlqKR5otRt9MCgyWFnclgjRqYEgw5rIwcf1HWnU/SUsxF0vVWkcPhczZz/+ESlieJnTnTdAMvAqKMMCqN7jQftCE+4YvX5hwDL93xMlw9dg1VbNfgDHO/X+qtlkgrhfnG3eV4qzKnbylokMkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963343; c=relaxed/simple;
	bh=5hmYPsNbDMvOOXOT5Bzy2ewALpxXzvLze2rs8AxBHWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri33KnDeFfyZ3rhzdkdMnK3s2R/Qc+pRC05N+QTU+kTqMz12vqH6KAzISPbV7VJyvMPBnmCSwU9VySdZ1QYy4BFrk+YfVdvnI+zjMoC/sEurH+srhNKrVAA2Xw/nntFLEm464hCYrAYxUhP2TmaILChIh2Uf/K7pyNTCYJXut0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqAgBabF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqAgBabF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29de2dd22d8so216816a91.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963340; x=1711568140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4sBpl94hZaFaefxgk4ChiLifByglkt9Bm1PvRiG2aU=;
        b=cqAgBabFe9UzX+YfY4rMtW4OHz4CDz9wPV560SId27pPjUeNxCW06fIJvQuhwXxl+F
         fj457AdWvs/EvBS+4866vDxSq9wwgQh59nKXyeeA2BHnsLjqPuCL4PUsJc97Kyx9D3Zz
         XCEKjF+Wp5p7sE4J1qrQP+8WfYH7CA/fMWpRgfkUyVrhC+nuYGFcA5m/iT8hIGRUg6WM
         OYJppBJ5TkGyqp19iy27HENeJeodZfbma2NaZeaNeaJHkSijw7fGQlUOO2+ldc5flzGL
         A78KxZUmsYuLSg/Q42CIv0RBEhPrM2VRLtrBTSKxGeS8JUfiSBX7E32WmmydC8XdmMj9
         8WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963340; x=1711568140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4sBpl94hZaFaefxgk4ChiLifByglkt9Bm1PvRiG2aU=;
        b=afIZBBviRkIaF4BzdNrA7fHxO7jTYHdpJ4kpEDhu/rKKafdGHVTEZT1F5QkewauRBr
         5BRFRaYH7yUvJLdD9tCTssxkrE48O0tIuGGiC4nnkLPgLxu7QdSJ+Hf1YvSXGYOdmB4k
         ULRleQGlEvCKQ3zvFV2BqEpJVcm/ngMRdq4WsTMTwiKr4KWdRM9G+YyIWunlNlg0ZyQG
         Ovb2U+KuT5fZwGwlOiFbhzCrBIuGMwGxJHoNCoVX9rwZLgV+wqIdN6x62MR1hW3Aky3d
         ekUMV4IKYTXd1X3f56CMc8wifW8BotzGOWPrJxOEt9LDlzuHWcRfw/x4L0NISGCDk0sg
         X4uw==
X-Gm-Message-State: AOJu0YyVjXFrrEAr4Xs33CHE6Myps4otn/dfUP64pLDcWYdScmKgJ6bE
	vLeYk1Mxw+u+Fs3zrD/CXrT5TdRZTm73RHCp7648kVlHhztf7yNk
X-Google-Smtp-Source: AGHT+IFWA1wT0V6qqoWUUNGxxHh/rwgXNNOOfeZrCbPXTUm6NNFhS+NBr35sYE2r7eFTFrNDT2A7Ow==
X-Received: by 2002:a17:90a:d18e:b0:29c:289b:1eb3 with SMTP id fu14-20020a17090ad18e00b0029c289b1eb3mr17390495pjb.6.1710963339918;
        Wed, 20 Mar 2024 12:35:39 -0700 (PDT)
Received: from [10.0.2.15] ([117.239.210.99])
        by smtp.gmail.com with ESMTPSA id gv15-20020a17090b11cf00b0029bb1631819sm2576751pjb.0.2024.03.20.12.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:35:39 -0700 (PDT)
Message-ID: <2a95b2bc-596a-41bf-b53c-ed9fb39f09ca@gmail.com>
Date: Thu, 21 Mar 2024 01:05:28 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][GSoC] Proposal: Move reftable and other tests to the unit
 testing framework
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ps@pks.im,
 kaartic.sivaraam@gmail.com
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
 <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
Content-Language: en-US
From: Chandra Pratap <chandrapratap3519@gmail.com>
In-Reply-To: <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/24 18:47, Christian Couder wrote:
> On Tue, Mar 19, 2024 at 6:11 PM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
>>
>> This is my project proposal for the Google Summer of Code 2024 program.
>> The document version of this proposal can be accessed through this link:
>> https://shorturl.at/ijrTU
>>
>> ---------<8----------<8----------<8----------<8----------<8----------<8
>>
>> Personal Info
>> -------------
>>
>> Full name: Chandra Pratap
>> Preferred name: Chand
>>
>> E-mail: chandrapratap3519@gmail.com
>> Phone: (+91)77618-24030
>>
>> Education: SV National Institute of Technology, Surat, India
>> Year: Sophomore (2nd)
>> Major: Mathematics
>>
>> GitHub: https://github.com/Chand-ra
>>
>> Before GSoC
>> -----------
>>
>> -----Synopsis-----
>>
>> A new unit testing framework was introduced to the Git mailing list last
>> year with the aim of simplifying testing and improving maintainability.
>> The idea was accepted and merged into master on 09/11/2023. This project
>> aims to extend that work by moving more tests from the current setup to
>> the new unit testing framework.
>>
>> The SoC 2024 Ideas page (link: https://git.github.io/SoC-2019-Ideas/)
>> mentions reftable unit tests migration as a separate project from the
>> general unit test migration project, however, I propose migrating other
>> tests alongside the reftable unit tests as a part of this proposal.
> 
> It means that if we select your proposal, we cannot select someone
> else to work on either the "Move existing tests to a unit testing
> framework" project or the "Convert reftable unit tests to use the unit
> testing framework" project.
> 
> I am not sure but I think that, after migrating all the reftable unit
> tests, I would prefer you working on other reftable related tasks
> rather than on more unit test migrations.
>

So, should I choose one between the reftable tests migration project and
the general unit tests migration project?  Say I decide to go with the
reftable tests migration project, what kind of "other reftable related
tasks" can I expect to work on? Would it be similar to the day-to-day
reftable tasks perfomed by contributors or one of the reftable projects
mentioned on 'SoC 2024 Ideas' page? Would I need to explain these tasks
in my GSoC proposal?
 
>> The reasoning behind this is explained further down.
>> The difficulty for the project should be medium and it should take
>> somewhat between 175 to 350 hours.
>>
>> -----Contributions-----
>>
>> • apply.c: make git apply respect core.fileMode settings
>> -> Status: merged into master
>> -> link: https://public-inbox.org/git/20231226233218.472054-1-gitster@pobox.com/
> 
> A link to (or the hash of) the commit that merged your patch into the
> master branch would be nice.
> 
Any pointers on how I go about finding this commit/hash?

>> -> Description: When applying a patch that adds an executable file, git
>> apply ignores the core.fileMode setting (core.fileMode specifies whether
>> the executable bit on files in the working tree are to be honored or not)
>> resulting in false warnings. Fix this by inferring the correct file mode
>> from the existing index entry when core.filemode is set to false. Add a
>> test case that verifies the change and prevents future regression.
>>
>> -> Remarks: This was the first patch I worked on as a contributor to Git.
>> Served me as an essential intro lesson to the community’s working flow and
>> general practices.
>>
>> • tests: Move t0009-prio-queue.sh to the unit testing framework
>> -> Status: merged into master
>> -> link: https://public-inbox.org/git/pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com/
> 
> I don't think it's a good idea to submit patches related to a project
> we propose before the GSoC actually starts. We might have been able to
> detect this earlier if you added [GSoC] to the patch titles.
> 
As I mentioned in the 'Closing Remarks' section, this work was done well
before I decided to take part in this year's GSoC (or even before this topic
was proposed as a project for this year's GSoC), so I don't think I could
have made it a [GSoC] patch.

> Also a link to (or the hash of) the commit that merged your patch into
> the master branch would be nice.
> 

Noted.

>> -> Description: t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c
>> unit test Git's implementation of a priority queue. Migrate the test
>> over to the new unit testing framework to simplify debugging and reduce
>> test run-time.
>>
>> -> Remarks: Perhaps the most relevant patch of all the ones mentioned
>> here, this patch helped me understand the expectations and workflow for
>> the work to be performed in this project.
>>
>> • write-or-die: make GIT_FLUSH a Boolean environment variable
>> -> Status: merged into master
>> -> link: https://public-inbox.org/git/pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com/
> 
> Also a link to (or the hash of) the commit that merged your patch into
> the master branch would be nice.
> 
>> -> Description: Among Git's environment variable, the ones marked as
> 
> s/variable/variables/
> 
>> "Boolean" accept values like Boolean configuration variables, i.e.
>> values like 'yes', 'on', 'true' and positive numbers are taken as "on"
>> and  values like 'no', 'off','false' are taken as "off". Make GIT_FLUSH
>> accept more values besides '0' and '1' by turning it into a Boolean
>> environment variable & update the related documentation.
>>
>> • sideband.c: remoye redundant NEEDSWORK tag
> 
> s/remoye/remove/
> 
>> -> Status: merged into master
>> -> link: https://public-inbox.org/git/pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com/
> 
> Also a link to (or the hash of) the commit that merged your patch into
> the master branch would be nice.
> 
>> -> Description: Replace a misleading NEEDSWORK tag in sideband.c that
>> reads ‘replace int with size_t’ with another comment explaining why it
>> is fine to use ‘int’ and the replacement isn’t necessary.
>>
>> • make tig callable from PowerShell/Command Prompt
>> -> Status: merged into main
>> -> link: https://github.com/git-for-windows/MINGW-packages/pull/104
>>
>> -> Description: Tig is a text mode interface for Git that ships with the
>> standard Git for Windows package but isn’t callable from PowerShell/
>> Command Prompt by default. Fix this by updating the relevant Makefiles
>> and resource scripts.
>>
>> • fix broken link on Git for Windows’ GitHub wiki
>> -> Status: merged
>> -> link: https://github.com/git-for-windows/git/wiki/Home/_history
>>
>> -> Remarks: A simple fix for a broken link that I stumbled upon while
>> browsing Git for Windows’ wiki looking for some help with the patch
>> mentioned just before this one.
>>
>> • t4129: prevent loss of exit codes due to the use of pipes
>> -> Status: merged into master
>> -> link: https://lore.kernel.org/git/20220311132141.1817-1-shaoxuan.yuan02@gmail.com/
> 
> The link shows a patch from 2022 by Shaoxuan Yuan. Are you sure this
> is the right link?

That seems to be an error. I will make sure to correct it in the next draft.

> 
>> -> Description: Piping the output of git commands like git-ls-files to
>> another command (grep in this case) in t4129 hides the exit code returned
>> by these commands. Prevent this by storing the output of git-ls-files to
>> a temporary file and then "grep-ping" from that file. Replace grep with
>> test_grep as the latter is more verbose when it fails.
>>
>> • t9146: replace test -d/-f with appropriate test_path_is_* function
>> -> Status: merged into master
>> -> link: https://public-inbox.org/git/pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com/
> 
> Also a link to (or the hash of) the commit that merged your patch into
> the master branch would be nice.
> 
>> -> Description: The helper functions test_path_is_* provide better debugging
>> information than test -d/-e/-f.
>> Replace tests -d/-e/-f with their respective ‘test_path_is_foo’ calls.
>>
>> • regex: update relevant files in compat/regex
>> -> Status: WIP
>> -> link: https://github.com/gitgitgadget/git/pull/1641
> 
> This is a GitGitGadget patch. Please mention that. Same thing for some
> other contributions above that are not part of Git.
> 

Sure thing.

>> -> Description: The RegEx code in compat/regex has been vendored from
>> gawk and was last updated in 2010. This may lead to performance issues
>> like high CPU usage. Fix this by synchronizing the relevant files in
>> compat/regex with the latest version from GNULib and then replaying any
>> changes we made to gawk’s version on top of the new files.
>>
>> -> Remarks: When I started working on this patch, I thought it was an
>> easy fix but the work turned out to be more involved than I anticipated.
>> I had to seek help from the other community members, and we have made
>> some good progress, but there is still a lot of cleaning and changes that
>> need to be done. I haven’t found enough time to commit to this again,
>> but it’s surely something that I want to get done soon.
>>
>> • tests: Move t0032-reftable-unittest.sh to the unit testing framework
>> -> Status: WIP
>> -> link: https://github.com/gitgitgadget/git/pull/1698
>>
>> -> Description: t/t0032-reftable-unittest.sh along with t/helper/test-reftable.c
>> unit test Git’s reftable framework. Migrate the test over to the new
>> unit testing framework to simplify debugging and reduce test run-time.
>>
>> -> Remarks: An infant version as of now, I tinkered with this after
>> seeing the project list on 'Git SoC 2024 Ideas' page to get an idea of
>> the kind of work that will be involved in this project.
> 
> It's Ok to tinker and to mention this. I hope it helped you write this proposal.
> 
>> -----Related Work-----
>>
>> Prior works about the idea have been performed by other community members
>> and previous interns which form a good guiding path for my own approach.
>> Some previous example work:
>>
>> i) Port helper/test-ctype.c to unit-tests/t-ctype.c
>> -> link: https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmail.com/
>>
>> ii) Port test-sha256.c and test-sha1.c to unit-tests/t-hash.c
>> -> link: https://lore.kernel.org/git/20240229054004.3807-2-ach.lumap@gmail.com/
>>
>> iii) Port helper/test-date.c to unit-tests/t-date.c
>> -> link: https://lore.kernel.org/git/20240205162506.1835-2-ach.lumap@gmail.com/
>>
>> iv) Port test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
>> -> link: https://lore.kernel.org/git/20240310144819.4379-1-ach.lumap@gmail.com/
>>
>> v) Integrate a simple strbuf unit test with Git's Makefiles
>> -> link: https://lore.kernel.org/git/20230517-unit-tests-v2-v2-4-21b5b60f4b32@google.com/
>>
>> vi) t0080: turn t-basic unit test into a helper
>> -> link: https://lore.kernel.org/git/a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com/
> 
> Thanks for mentioning these.
> 

:)

>> In GSoC
>> -------
>>
>> -----Plan-----
>>
>> -> Reftable tests:
>>
>> The reftable tests are different from other tests in the test directory
>> because they perform unit testing with the help of a custom test framework
>> rather than the usual ‘helper file + shell script’ combination.
>> Reftable tests do have a helper file and a shell script invoking the
>> helper file, but rather than performing the tests, this combination is
>> used to invoke tests defined in the reftable directory.
>>     The reftable directory consists of nine tests:
>>
>> •  basics test
>> •  record test
>> •  block test
>> •  tree test
>> •  pq test
>> •  stack test
>> •  merged test
>> •  refname test
>> •  read-write test
>>
>> Each of these tests is written in C using a custom reftable testing
>> framework defined by reftable/test_framework (also written in C). The
>> framework has four major features utilized in performing the tests:
>>
>> •  EXPECT_ERR(c): A function-like macro that takes as input an integer
>> ‘c’ (generally the return value of a function call), compares it against
>> 0 and spits an error message if equality doesn’t hold. The error message
>> itself contains information about the file where this macro was used,
>> the line in this file where the macro was called and the error code ‘c’
>> causing the error.
>>
>> •  EXPECT_STREQ(a, b): A function-like macro that takes as input two
>> strings ‘a’ and ‘b’, compares them for equality via strcmp() and throws an
>> error if equality doesn’t hold. The error message thrown contains information
>> regarding the file where this macro was invoked, the line in this
>> file where the macro was called and the mismatched strings ‘a’ and ‘b’.
>>
>> •  EXPECT(c): A function-like macro that takes as input an integer ‘c’
>> (generally the result of a Boolean expression like a == b) and throws an
>> error message if c == 0. The error message is similar to EXPECT_ERR(c).
>>
>> •  RUN_TEST(f): A function-like macro that takes as input the name of a
>> function ‘f’ (a test function that exercises a part of reftable’s code),
>> prints to stdout the message ‘running f’ and then calls the function with f().
>>
>> Other than these, the framework consists of two additional functions,
>> set_test_hash() and strbuf_add_void() which are used  exclusively in the
>> stack tests and refname tests respectively.
>>
>> Since the reftable test framework is written in C like the unit testing
>> framework, we can create a direct translation of the features mentioned
>> above using the existing tools in the unit testing framework with the
>> following plan:
>>
>> •  EXPECT_ERR(c): Can be replaced by check(!c) or check_int(c, “==”, 0).
>>
>> •  EXPECT_STREQ(a, b): Can be replaced by check_str(a, b).
>>
>> •  EXPECT(c): Can be replaced by check_int(), similar to EXPECT_ERR.
>>    E.g. expect(a >= b) --> check_int(a, “>=”, b)
>>
>> •  RUN_TEST(f): Can be replaced by TEST(f(), “message explaining the test”).
>>
>> The information contained in the diagnostic messages of these macros is
>> replicated in the unit testing framework by default. Any additional
>> information can be displayed using the test_msg() functionality in the
>> framework. The additional functions set_test_hash() and strbuf_add_void()
>> may be moved to the source files for stack and refname respectively.
> 
> You mean "reftable/stack.c" and "reftable/refname.c"?
> 

Yes, I will re-write this to make it clearer.

> 
>> The plan itself is basic and might need some modifications, but using
>> the above plan, I have already created a working albeit primitive copy for
>> two out of the nine tests (basics test and tree test) as can be seen here:
>> (link: https://github.com/gitgitgadget/git/pull/1698)
>>
>> -> Other tests:
>>
>> As is already mentioned, the rest of the tests in the test directory use the
>> combination of a helper file (written in C) and a shell script that invokes
>> the said helper file. I will use my work from the patch
>> ‘tests: Move t0009-prio-queue.sh to the unit testing framework’
>> (link: https://public-inbox.org/git/pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com/)
>> to explain the steps involved in the porting of such tests:
>>
>> • Search for a suitable test to port: As Christian Couder mentioned in this
>> mail (link: https://public-inbox.org/git/CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com/),
>> there exists a subset of t/helper worth porting and we need some sort of
>> classification to discern these.
>>
>> All helper files contain a cmd__foo() function which acts as the entry
>> point for that helper tool. For example, the helper/test-prio-queue.c
>> file contained cmd__prio_queue() which served as the entry point for the
>> prio-queue tool. This function is then mapped to a different name by
>> helper/test-tool.c which is used by the ‘*.sh’ files to perform tests.
>> Continuing the prior example, cmd__prio_queue() had been mapped to
>> “prio-queue” by test-tool.c and t0009-prio-queue.sh invoked it like
>> “prio-queue 1 2 get 3 dump”.
>>
>> To classify what among t/helper should be targeted first in this project
>> we can use something like ‘git grep foo’ (where foo is the alias for cmd__foo())
>> to look at the instances where the helper tool is invoked. The ones appearing
>> lesser in different test scripts are the ones most likely to be used solely
>> for unit testing and should probably be targeted first.
>> Utilising this strategy, I discovered that the ‘prio-queue’ tool was only
>> used in t0009-prio-queue.sh and hence, was a good candidate for the unit
>> testing framework.
>>
>> Note that this strategy is not full-proof and further investigation is
>> absolutely required on a per-test basis, it is only meant to give an
>> initial idea of what’s worth investigating.
>>
>> •  Create a new C test file in t/unit-tests: After finding a test appropriate
>> for the migration efforts, we create a new ‘*.c’ file in t/unit-tests.
>> The test file must be named appropriately to reflect the nature of the
>> tests it is supposed to perform. Most of the times, replacing ‘tXXXX’
>> with ‘t-‘ and ‘*.sh’ with ‘.c’ in the name of the test script suffices.
>> E.g. t/t0009-prio-queue.sh turns to t/unit-tests/t-prio-queue.c. The
>> new C file must #include “test-lib.h” (to be able to use the unit
>> testing framework) and other necessary headers files.
>>
>> •  Move the code from the helper file: Since the helper files are written
>> in C, this step is mostly a ‘copy-paste then rename’ job. Changes similar
>> to the following also need to be made in the Makefile:
>> -    TEST_BUILTINS_OBJS += test-prio-queue.o
>> +    UNIT_TEST_PROGRAMS += t-prio-queue
>>
>> •  Translate the shell script: The trickiest part of the plan, since
>> different test scripts perform various functions, and a direct translation
>> of the scripts to C is not always optimal. Continuing the prior example,
>> t0009-prio-queue.sh used a single pattern for testing, write expected
>> output to a temporary file (named ‘expect’) -> feed input to the ‘prio-queue’
>> helper tool -> dump its output to another temporary file (named ‘actual’)
>> -> compare the two files (‘actual’ vs ‘expect’).
>>
>> In the first iteration of my prio-queue patch, I worked out a
>> straightforward translation of this pattern in C. I stored the input in
>> a string buffer, passed that buffer to the test function and stored its
>> output in another buffer, and then called memcmp() on these two buffers.
>> While this did prove to be a working copy, this work was found to be inadequate
>> on the mailing list. Through the next several iterations, I reworked the
>> logic several times, like comparing the input and output on-the-go rather
>> than using buffers and replacing strings with macro definitions.
>>
>> The test scripts similarly perform other functions like checking for
>> prerequisites, creating commits, initializing repositories, changing or
>> creating directories and so forth, and custom logic is required in most
>> of the cases of translating these, as seen above.
>>
>> •  Run the resulting test, correct any errors: It is rare for any migrated
>> test to work correctly on the first run. This step involves resolving any
>> compile/runtime errors arising from the test and making sure that at the
>> very minimum, all the test-cases of the original test are replicated in the
>> new work. Improvements upon the original can also be made, for example, the
>> original t0009-prio-queue.sh did not exercise the reverse stack
>> functionality of prio-queue, which I improved upon in unit-tests/t-prio-queue.
>>
>> •  Send the resulting patch to the mailing list, respond to the feedback:
>> This step involves writing a meaningful commit message explaining each patch
>> in the series. From my experience contributing to the Git project, I find it
>> to be rare for any patch series to be accepted in the very first iteration.
>> Feedback from the community is vital for the refinement of any patch and
>> must be addressed by performing the suggested changes and sending the work
>> back to the mailing list. This must be repeated until the work is merged
>> into ‘seen’, ‘next’ and further down, ‘master’.
>>
>>
>> Timeline
>> --------
>>
>> I’m confident that I can start the project as early as the start of the
>> Community Bonding Period (May 1 - 26). This is because I have read
>> the related documentation and already have some experience with the idea.
>> I believe I’ll be ready to get up to speed to work on the project by then.
>> The exact time arrangement for each test is variable and hard to determine,
>> but judging from the fact that it took me 3-4 days to complete the first
>> iteration of the t-prio-queue work, here is a proposed migration schedule:
>>
>> • Reftable tests:
>>
>> If my current work from 'tests: Move t0032-reftable-unittest.sh to the unit
>> testing framework' is found satisfactory, there are 7 tests left that need
>> to be ported to the unit testing framework. Assuming it takes 2-3 days to
>> port one test, I should be done with the first patch series for the reftable
>> tests in about 2-3 weeks. From there, it’s a matter of responding to the
>> feedback from the mailing list, which can deceptively take longer than expected.
>> For instance, I had to continue polishing my t-prio-queue patch for about
>> two weeks after the feedback on the first iteration.
>>
>> • Other tests:
>>
>> The time required to port these tests is highly variable and depends mostly
>> upon the work required in translating the shell script. As mentioned
>> previously, it took me 3-4 days to complete the first iteration of the
>> test-prio-queue migration patch, and that was a short test with only about
>> 50 or so lines of shell scripting and all the test cases following a single
>> pattern. Considering all this, I believe it should be possible, on average,
>> to migrate a new test in 5-8 days.
>>
>> Hence, it should be possible for me to migrate >=7 tests along with the
>> reftable tests throughout the duration of this project.
>>
>> Availability
>> ------------
>>
>> My summertime is reserved for GSoC, so I expect that I can work on a new
>> test 5 days per week, 6-8 hours per day, that is 30-40 hours a week.
>> On the weekends, I would like to solely work on the feedback from
>> the mailing list and advance my [WIP] patches. Certainly, something
>> unexpected may arise, but I will try my best to adhere to this time
>> commitment and be always available through the community’s mailing list.
>>
>> Post GSoC & Closing Remarks
>> ---------------------------
>>
>> When I first started contributing to the Git project in October of 2023,
>> I had no idea about programmes like GSoC. I was advised by a senior of
>> mine to contribute to open-source projects and hence, my aim of contribution
>> was to apply what I had learnt in college to solve real-world problems
>> and learn from more experienced peers. However, most of what I have
>> contributed to Git has been trivial owing to my lack of skills and
>> inexperience with the project.
>>
>> Seeing how I need to do an internship in summer, with GSoC, I hope to be
>> able to dedicate this internship time and effort to a cool project like
>> Git while simultaneously learning skills to be able to make more useful
>> contributions in the future. It’s two birds with one stone. I would also
>> like to keep working on this project to see it to completion post-GSoC
>> and help mentor other newcomers get started with the Git project.
> 
> 
>> -- After GSoC --
>> ---------------------
>>
>> After GSoC I intend to be a part of the community and keep
>> contributing to the git’s codebase. I eagerly want to learn a lot from
>> the git community and enhance my skills. I also see myself making
>> important contributions to git in the future.
>>
>> When I first joined the community 2 months ago, the ancient way of
>> collaborating through a mailing list by sending diff patches was
>> really puzzling (GitHub was the only means that I knew about for
>> open-source collaboration). After sending a patch I got a little
>> comfortable with it and started loving it.
>>
>> -- Closing remarks --
>> ----------------------------
>>
>> I am really enthusiastic to contribute to git. I really want to learn
>> a lot from my mentors and the whole git community. Everyone
>> contributes using git, why not contribute to git :).
>>
>> In the end I really want to thank the whole community, especially
>> Christian and Junio, for their valuable time in reviewing my patches
>> and guiding me with the problems I faced.
> 
> Thanks for your proposal. Please make sure you submit it soon as a pdf
> file to the GSoC website. It can then be updated by uploading a new
> pdf until the April 2 1800 UTC deadline.

Thanks for the feedback, I will.
