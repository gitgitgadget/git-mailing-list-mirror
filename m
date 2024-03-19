Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0F4F606
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888940; cv=none; b=dHJRGC+WLGxNb+5QI30gk6zFr3ZMKl8iaQ+WxQr/uEXNQ1+Xg0NkI8PGvGEA2hAogVbz6j+asntqRM0JJhduT52Fu8k8yjI5eaLobdzoCwMKqP/ijiDI06rUVqKVe8yL168mNGipk8Eu6/zgmOpydms/5fHu6jjREX8FZLwzU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888940; c=relaxed/simple;
	bh=vOzjz1jQQeF4Bm6uK5OH6xj34Bunz1GWX+QQfi/sw3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYHQwfQiHxkClFXlqDPWS3VPtk0VQMDmY0/TxJSxVVSrru2FQ7UEkpYP6nfqsq8cGTBslqt9zsechpFh/Mn1GwwAcgLBYFZ+tPBeTUZB8CHS/xaHKqJKfprj286jiubcTWmFxv6BTPFXnKErTcHfe4QJAgO8+UOvdG7c2PadGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfBubGwy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfBubGwy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd9568fc51so48222995ad.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710888938; x=1711493738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6avzcJvtOup9AXsKHsm+grSBhaEHDiys3Ez7q48zEDc=;
        b=AfBubGwyeuBVUVi8USe7C24MH1f+KxDsjCnH3pf8IvK4KmGiCffA1XCLR2hp9LtHw9
         leQ6DNX5iFP/ce+VKUsnodU+ztPU7zNo7ne9ZcbB7+II/QhB90d36zsmKVJjb5Ll7vek
         LENEDI9RMXl+r6FRRLdp7D3uJ954MTKUIF/kI70Lt2WwwxCElqEIyqFlxtFCryLQeEtM
         ECs3J2BXZ2cssa6SsEX0dbwWXmQkCTuh9pG5LfUUfK3WVQnw0mzFKzYR42XtJWZ84qdd
         NjBc0akFxW42iTBYDy31dEzTjlFOY36bfJBV/epL6en4jedgG1KhwK9iFzVAXsjcNvo3
         HaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710888938; x=1711493738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6avzcJvtOup9AXsKHsm+grSBhaEHDiys3Ez7q48zEDc=;
        b=wI+EBOF+bjV70hENYl51eyb1k0F6ioEkzMG/3/6S7TBKt1/r3BPISrz+72jIgJKgJW
         w1Z3WVnbF5j3vyik8aaFF3w76uF18qUoFhHR1uTnBIy5lgnZpragMwsOLaMfCZM3Qa/w
         Np5WOnJM6vyFNNLYfXs3QKC1xSdW5tZBdYfDYtmTRnqq5RqxUMBYM7oE4a/toD4JlK+3
         ktam6HspbdoCfyyw1RttF/fuXp2R4ZIrwDOt2/FMTJuI/1/EdizdVjwRlEWMe4YUalWR
         CQK9VnVI4ghRPXmCabCK5q+2Op+rUNrLWwF+UzoDdWMxqAPfwB+D79x3c7QZ9CKxI0+B
         eyMw==
X-Gm-Message-State: AOJu0Yzykeqc3hW23oNgVhRAZxpTOkNUsLNFbtjzHfqF+gMiyK+nuZrH
	f5P1Ji0Sric1NnQqVLAgi6gbDMObevuwNFN1OPMu/R5WMlJOjsV38pD3TcZQ3BFFWg==
X-Google-Smtp-Source: AGHT+IEf1v/4He2g90DwM1WisZjpxuQ6L2IFNy9XKoSlW+XPqg0VZ2RlOPZZBhOV0d9TMz3idTdOxg==
X-Received: by 2002:a17:902:e841:b0:1dc:fcc4:b3a5 with SMTP id t1-20020a170902e84100b001dcfcc4b3a5mr676832plg.35.1710888937507;
        Tue, 19 Mar 2024 15:55:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001db608107ecsm12269868pln.167.2024.03.19.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 15:55:37 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [GSoC][RFC][Proposal] Move existing tests to a unit testing framework
Date: Wed, 20 Mar 2024 04:24:26 +0530
Message-ID: <20240319225444.21574-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This is my proposal for the project "Move existing tests to a unit testing
framework" in Google Summer of Code 2024. The web version can be viewed at:
https://docs.google.com/document/d/1wmosedy-UKd_mhAAjccv1qETO1q00s-npYj2m6g-Hd0/edit?usp=sharing

I appreciate any feedback on this proposal.

Thanks.

-- >8 --
Move existing tests to a unit testing framework

Personal Information
--------------------

Name: Ghanshyam Thakkar
E-mail: shyamthakkar001@gmail.com
Ph. No.: +91 7990974044

Education: L.D. College of Engineering, Gujarat, India
Year: IV
Degree: Bachelors in Electronics and
        Communications Engineering

GitHub: https://github.com/spectre10
Time-zone: UTC +5:30 (IST)


Overview
--------

Initially Git used to only rely on shell scripts to test the functionality
usually deemed to be internal (e.g. libraries, functions etc.) This was achieved
through t/helper binaries which would take input via stdin and output through
stdout and the test scripts would consume those outputs. This translation is
costly due to the following reasons:

- Each test script creates a new git repository which is many times not needed.
  See here[1] for example.
- These scripts spawn processes every time they need a certain output. And 
  spawning processes are expensive (especially on windows).
- Difficult setups: sometimes the functions or the libraries we are testing need
  some special setup such as defining flags for custom behavior etc. which
  cannot be done through the shell scripts, hence we might forego testing those
  conditions.

Moving to the unit testing framework would give us many benefits such as
increased runtime performance, and therefore lower test duration and solves all
of the above points. The choice of framework and the rationale behind it is
thoroughly described in Documentation/technical/unit-tests.txt. Therefore, the
goal of this project is to move existing unit tests from t/helper/* and its
corresponding scripts to the new unit testing framework. And there has been work
going on to do this by Outreachy intern Achu Luma.

The expected project difficulty is medium and the expected project size would be
350 hours.


Pre-GSoC
--------
I initially got into Git’s codebase in December, 2023 and started my
contribution journey in January, 2024. I worked on mostly what I found
interesting and within my reach. Following is the list of contributions that I
have made, in chronological order:

- [PATCH v6 0/2] t7501: add tests for --include, --only, --signoff
    Status: merged into master
    Merge Commit: 2be9ccf23e0592b83b78e719574e580e79db0375
    Description:
    This patch series added missing tests for --include, --only and --signoff
    options of git-commit. While working on this patch I accidentally reproduced
    a bug where in an untracked path provided to the commit command with -i
    would not error out. This was noticed by Junio. Therefore, this patch also
    included a TODO comment describing this bug.
    Mailing list thread:
    https://lore.kernel.org/git/20240109060417.1144647-2-shyamthakkar001@gmail.com

- [PATCH v3 1/2] t0024: avoid losing exit status to pipes
    Status: merged into master
    Merge Commit: 40225ba8b494080d7f90dd5e129daa7b11c613d1
    Description:
    Although this was not my first contribution, it was done to fulfill the
    microproject criteria from the list of micro-projects on Git Developer
    Pages. The first patch replaces the pipe to the redirection operator to
    store the output to a temporary file to avoid losing exit status of the git
    commands. And the second patch of the series fixes the style violations to
    adhere to the current standard described in CodingGuidelines.
    Mailing list thread:
    https://lore.kernel.org/git/20240118215407.8609-1-shyamthakkar001@gmail.com/

- [PATCH v6 0/2] add-patch: classify '@' as a synonym for 'HEAD'
    Status: merged into master
    Merge Commit: 65462776c2963b377968e580ace1590238bf79c1
    Description:
    The first patch of this series removed the disparity of command line output
    of using ‘HEAD’ vs ‘@’ in ‘git reset/restore/checkout -p’. And the second
    patch removed the perl prerequisites in the test scripts which use the patch
    mode functionality.
    Mailing list thread:
    https://lore.kernel.org/git/20240128181202.986753-2-shyamthakkar001@gmail.com/

- [PATCH] restore: allow --staged on unborn branch
    Status: Discontinued
    Description:
    This patch added functionality to assume an empty tree when on an unborn
    branch to be able to use ‘restore –staged’. However, this was discontinued
    due to lack of community interest. In hindsight, I think that this would
    have been an acceptable patch, had I described it well.
    Mailing list thread:
    https://lore.kernel.org/git/20240206230357.1097505-2-shyamthakkar001@gmail.com/

- [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
    Status: on hold until GSoC
    Description:
    This was used as a practice patch to the current project proposal. This will
    be used as a reference in the proposal ahead.
    Mailing list thread:
    https://lore.kernel.org/git/20240223193257.9222-1-shyamthakkar001@gmail.com/
 
- [PATCH v2] setup: remove unnecessary variable
    Status: Merged to master
    Merge Commit: 272fd9125aae215ece1c465a4b7d336cf81c3e62
    Description:
    I initially proposed the TODO comment removed through this patch as a
    micro-project for my first patch. However, the TODO comment was a result of
    misunderstanding, therefore this patch did some minor code simplifications
    along with the removal of the TODO comment.
    Mailing list thread:
    https://lore.kernel.org/git/20240304151811.511780-1-shyamthakkar001@gmail.com/

- [PATCH 0/2] commit, add: error out when passing untracked path 
    Status: WIP
    Description:
    This patch series would fix the potential bug discovered in the first patch
    that I sent (--include tests).
	Mailing list thread:
    https://lore.kernel.org/git/20240318155219.494206-2-shyamthakkar001@gmail.com/

- Helped a fellow contributor by reviewing their patches
    Thread links:
    - https://lore.kernel.org/git/CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com/
    - https://lore.kernel.org/git/CZHJPF604DV9.X0A0VX1AB7P8@gmail.com/

Proposed Project
----------------

----What’s unit testing----

Unit testing is a method to test a specific unit of source code (i.e. a
function, a module etc.). This is very helpful in catching all of the corner
cases and possible scenarios.

----Steps to convert the existing unit tests to the new framework----

It can be thought of as a series of steps which are outlined below:
- Identify a suitable candidate from t/helper directory.
- Each t/helper unit test has a corresponding shell script which actually tests
  the output from the binary. Each test-case in that script would ideally become
  a separate function (and therefore a single test-case) in the migrated unit
  test.
- Convert the test logic from the shell script to C. This would involve
  understanding the underlying library/functionality which is being
  tested. Subsequently, make functions which would be ideally be a single
  testcase.
- These functions can be called via the TEST() macro in the cmd_main
  function which is the entry point to the test.
- Each of these functions contains a set of {check(), check_int() etc.} macro
  functions which check the condition provided to them and if it fails, prints
  a message to the stdout. If even a single check fails the whole test-case is
  considered a failure.
- Modify Makefile to add the reference of the new test to the UNIT_TEST_PROGRAMS
  variable.
- The skeleton of the new unit test would look something like this:

    #include "test-lib.h"

    static void testcase_1()
    {
	    ...
	    check(actual == expected);
	    ...
    }

    int cmd_main(int argc, const char **argv)
    {
	    TEST(testcase_1(), "test description");
	    return test_done();
    }

- After the migration remove the references of t/helper/{old-test-helper}.{c, o}
  from the Makefile and from the t/helper/test-tool.{c, h}. And subsequently
  remove the shell script which used to consume the old helper binary.

----Additional Notes along with a Reference Implementation----

These tests usually contain duplicate logic with variations in input and output.
In such cases, we can define macro functions to not duplicate such logic. I.e.
in t-ctype, we can see how a custom macro is defined to avoid duplication of
test logic, with variation only in the input being used. Also, some these
existing tests are not worth migrating. For example, test-tool binaries which
are also used outside of the corresponding shell script (i.e. used in other
tests for setup purposes) would be low on the priority list of possible
migrations.

I have made a reference implementation of t-oid-array.c which migrates
t/helper/test-oid-array.c and t/0064-oid-array.sh to the new framework, which
can be viewed here[2]. Note that the failing tests are not related to my
implementation and rather a known issue[3]. It may or may not to be good enough to
be merged into master, however it sufficiently showcases my abilities to
understand framework, the use of different macros and the ability to understand
different internal libraries and data-structures such oidarray itself.

This implementation was also reviewed by Christian Couder on the mailing list
and I have made some adjustments according to the feedback.

This implementation uses a macro to test the ordered enumeration of oidarray
with different inputs. And also tests the lookup capabilities of oidarray with
different queries and inputs with the help of a macro. There are also various
helper functions defined to help with printing debug output, generating
hexadecimal representations, etc.

----Previous Work----

TAP implementation along with t-basic and t-strbuf:
https://github.com/git/git/commit/e137fe3b

t-mempool: https://github.com/git/git/commit/6cbae640
t-ctype: https://github.com/git/git/commit/e875d451
t-prio-queue: https://github.com/git/git/commit/808b77e5

Achu Luma has been doing this migration as part of Outreachy internship. Their
branches can be seen here[4].

----Goal----

The end goal of this project would be to migrate as many unit tests as possible
according to the steps outlined above. In doing so, also enhance some of the
tests as needed to be extensible such as the ability to test different hash
algorithms on a single oidarray. This enhancement is not yet implemented in the
reference implementation due to the series which enables the use of different
hash algorithms on oidarray not yet merged into master (in next though).

Currently, there are 78 test-*.c files (not including test-tool.c) in t/helper/
directory according to the master branch. Of course, migrating all of them would
be a difficult task in 350 hours, therefore I plan to migrate around 1 unit test
per week during the Community Bonding and Coding Phase. This may fluctuate
depending on the type of test. Some of those tests are already being worked on
by Achu Luma.

----Timeline----

Pre-GSoC
(Until May 1)
- Continue to work on different things like solving the bug discovered in the
  first patch series that I sent. Be engaged in the community.

Community Bonding
(May 1 - May 26)
- Talk with mentors and identify the tests which are suitable for migration.
  Learn the libraries which are used for those tests and read up on the API.
  Look at Achu Luma’s branches to further familiarize myself with the migration
  process. Start the migration early with the mentors’ permission.
  
Phase I
(May 27 - July 11)
- Continue implementing the tests in the unit testing framework with the
  guidance of mentors and send out patches to the mailing list for community
  approval. Approximately 6-7 tests would be done/cooking for migration at
  the end of this Phase.

Phase II
(July 12 - Aug 18)
- Continue the migration and talk with the mentors about the pace, quality of
  patches and seek feedback. And enjoy the process. Another 5-6 tests would be
  done/cooking at the end of this Phase.
  
Final Week
(Aug 19 - Aug 26)
- Finish up any remaining tests.
- Fix any bugs and some final touches.
- Make a final report about the work accomplished and outline future work.

----Blogging----

I believe that writing about one’s work helps them track their progress from a
bird’s eye view. And also helps them realize if they are making mistakes from a
long term perspective. I plan to blog about the progress bi-weekly. Although I
have not setup the blog yet, it will be at:
                        https://spectre10.github.io
 
----Availability----

My current semester ends on 30th April and my exam/viva is tentatively on 7th
May. After that I have freed my summer for GSoC, therefore I will be able to
give a minimum of 35-40 hours per week.

Post-GSoC
---------

The Git Community has helped me very much and tolerated my beginner mistakes.
I have grown as a developer since I started contributing to Git. I learned the
importance of writing good commit messages, benefits of splitting up patches,
effective programming style and good communication etiquettes. Therefore, I plan
to be involved even after my GSoC journey ends. I am very much involved in the
Git ecosystem and also contribute to another project in the Git ecosystem called
gittuf[5]. Also post-gsoc, I am planning to help out in aggregating for Git Rev
News, which I personally enjoy reading.

My Appreciation
---------------

I would like extend my thanks to all of the folks on the mailing list and
Discord who have helped me in contributing to the Git Project including Junio,
Christian Couder, Phillip Wood, Elijah Newren and many others. And I have also
taken some references of Achu Luma’s work for this proposal, so thanks to
her, too.

Thanks & Regards,
Ghanshyam

References:
[1], [2]: https://github.com/spectre10/git/commit/9bfbb22ced3c4d15a215a84aa40043a30dc1bac0
[3]: https://lore.kernel.org/git/20240318090848.GC602575@coredump.intra.peff.net/T/#mc32405849ac4265ad36670480709d744f1d9e495
[4]: https://github.com/achluma/git/branches
[5]: https://github.com/gittuf/gittuf

