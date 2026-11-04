Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793802499;
	b=zf9fzZ6yvTm3KttfMOLqdQjPN+X50kuL7c6wdkpKFlQxFtvvzHnWpUnP5iTo4/3vxEzU
	 O8KFsueP5zyspvRcmEFpmPvK/HiihVi4Cx5MfQSaz6t1U75m1nYwIyb9BgKJode4YCVPN
	 GKOmobgK0wZkbZn7kh+EEDwi7H+cV13U5MWPrZ4pFr/6IJyK+McxnbBRByyP8ufsV0az1
	 qfs52OAs0zgcrXkPizlxyQNsU3S4AeL1ukbbSLTbOQK7S7nLghgEHYX3eqwauGgU8j47T
	 4F8StPkpPXzFa8GWeSy2FT3FzQi5VDQZtl5JdcFK8kY4ONpNGCfLlU6DIEuaVu8YGjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=3a4THTwEXtp2Ko2kKVR/CglXSOgumW0cLN+Z+wTswZw=;
	b=tlUd40PQg+CpI2SEj8HJzPTwv9BuhBAj1lkX5Ityy5iqv3PQdUXybruxDTDFJlYrv2nh
	 Qw7DPzsIyryu4wBovWKJZx9xyRiSfLIxg3wZS08AaepQJsPUTrB7bWbKR9RkSQ6qROcQ9
	 OvGWDxI7C7awCBqegWc0bafc78t338S2bVMcEU7ZWY8Hd9oYMn2bnia0J1NMWsP9aLNB+
	 zWpCfi+x2TvVUeeYFnyWEjKfWmEChKgZoiUrjvTu8q+iq0lm23LHEZKjxdPiAZpmN2/wx
	 KfwcX4XaNCG34NkhmYHwcKr797urD3756JaDh8FvI0vyzPi675pfI6fIby3gmjIL9Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTpxpMXV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF8606A33A
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6AF8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTpxpMXV
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c847584b8so8322746d6.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 06:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793802497; cv=none;
        d=google.com; s=arc-20260327;
        b=cazCbm5thKSYlXSaCBYnPp54fqMt7mhtreAXGGWLjUpRsmk/ya22rKYGR0iA6O3vxD
         HeWV+b4yYADbsBRjkeTpWl+9qO/InN2VKsMDOo7I4petLALC7uBjdK2MBDTAj62dLyTh
         gjIB4s94X+LV16jpcx0bT4IreJ7eUUCXLWzP+OfqyXv6NaF6WhbiCH13D6fz0rkY8c0A
         FgAxkNX9A4rmlkRNTZo/jXIoHVMqECpmznpCP5lvXlQOARcqZkXLa7GdXzdT8dAECFkl
         /ZHkjtqcZpaaqWJkkYlQwjsjD+m+Z/19P/GwoYDrMXMi2lo8UBjAY6kan+50/0EO9xkL
         MjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=3a4THTwEXtp2Ko2kKVR/CglXSOgumW0cLN+Z+wTswZw=;
        fh=yOlUArnz53wajRpYGY4P1mFE97N8oXnD5/lIrgQGEdM=;
        b=R0A9FXC/QFD3eqly2at3uQeGEyJxcaRIVTomPZlYKoFsu2KsxiVMHUCPAZdfajRmxc
         PHZsutbfhYy8T97QWctOzD/9+QKck5TcgDHk2Q/d2K1sS12tCoL1c3AEJDs9XvDQqQnP
         tcnQ8DUvUBL9w7R2/Pwr/7f/vWvFJIA93Q1OJq2emVEG7/x0oQu3EaLWwFQsckYEMlPJ
         6+G2fk4ujI4jxrp9HZgVY79ghkpwsLi/ohfZprJ3mq8FpgUJ5BmSgjnG3BQ7vJQOVNhU
         jncuFO1DORD/QgavK3OW58vY0ngUWwFy6oKT2uqiRg7UoptWhsj5EnAMN+n1PGTCXZbr
         so1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802497; x=1794407297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3a4THTwEXtp2Ko2kKVR/CglXSOgumW0cLN+Z+wTswZw=;
        b=ZTpxpMXV5emW8zdXonolqQf6z8t8ND8xZ+JZ8amHWZVddUCwBcX+cUT/DLtjZX7C2s
         9ujTHrrM9BYUL0QaWbQtuAHFnlGC2LKta1WEY8v2PtN1/tnwJgHkU9bzCxxLG3WKOU2A
         8GPz2e6MULQvMVyccy6s132P97TYN6Z2tFPjNuo1kWH0KaS7D1oeESZBh6HLSit/eY1h
         q/1WzSVnbQOGh6Ql3U9IbiJLg9nqdHnau3/a3sVh05ZYU6+hFeiknHysIw+/IZ3pHtRJ
         0U3SY1YlPcrq6aa/m29jYtxMWo26p1I1mQ8y5aGfb8XZ8VfpUe5YI3MRnZXD1+2zkSum
         nWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802497; x=1794407297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3a4THTwEXtp2Ko2kKVR/CglXSOgumW0cLN+Z+wTswZw=;
        b=KgAF4ykKnTce4KDaNF9/29GfRg3lfC6n4793Ht1cl51hK2VeHZntY+u0760Iw4S/3y
         t2a4w9/ChCGoOJZNbQepRO0cJAME5UB17YQb5vU8XQXP1BkFiF+zqoY1mairs2lhwfbN
         L0btufqcaV/wPqXyfv2K7FtEDOTL5pfPTUosrT2xvFS4vqj4YgD9UDE8An4vrfQf6swJ
         lvvZ2kwt9BfORQhW2MsZvskPG5eWjQdVnzCFiSO8KJ/sr91QLQ+u516mBN106Mhe07M/
         Qnk7AelDhODaIejVXrP1VDfcTrP5zVcpuktHrF1qnJJXwwYtv1py/DQSbyH4T0f9IqP5
         bAxA==
X-Gm-Message-State: APuU4Z8GPhj+l9N2XQCDac0WTdniKpcIa744fNJmYIuSNEWl7ns8pU7l
	sSY0Ol1AqXCNguZbwDqWfil/eh73IeRcIvtYqG6M5qtAh4IdOQMXJnm8KtLLR4sjX8pc8WQlwQs
	vHpZCHd+E2vjtzp2rmIqDxEN9ivluMI4Hk9Xb7uc=
X-Gm-Gg: AYBFou3vUClYYOlbTeS+AnLbhfTt8iElA79CE9+97OAoEovvelDkoSesk+B/zEix3XJ
	JBe0PrQCwzU8Vpo1Fo6/E3I2h0WZH4ynL1o4EK6fzUgGkXc8GIHPa0/pLLSLZtFWvTDT3tzQaTa
	t+5jKbcHsDD+JjBQlBC9WF1rQ6pA5EgnnPRKjSFXid5gz4ddBYirJkkU27RMsL1ihQecNJPMpcN
	6Un6cpwLh404ctOpJWcVFfTUnEqCKRO/J8aKLU5MUdHC8vIdOgRtasNFgjgaQ/iHg/Y2ema8Uxd
	00Ww3fwCsU/ok2YSKJKf1FOmZpJRcBIYv4OI+jqGB+MXdyAu2dZ5I18GatO3WkFRNmsciP1trOb
	Hy3BuvbHLWKF2vp9+O42H0VhEWAAVVDfFKHzwPcKwv2q/rgfXg7sA/tZwi09e6le+arDV3v+vab
	9W/9JYnmcSuyxz8/F0+4oCP+JrZL31iBmLo2jwbh4wrCL1E3u5F3NUR3U=
X-Received: by 2002:a05:6214:19cc:b0:919:5223:4b67 with SMTP id
 6a1803df08f44-91c904090c1mr314277226d6.1.1793802495889; Wed, 04 Nov 2026
 06:28:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 4 Nov 2026 19:58:02 +0530
X-Gm-Features: AclHuK8bJCvk7vkuV3JAOSk8dBAMuVSDOySpX68gq50Se9UZRn71td3QzsTiya4
Message-ID: <CABh_KWjfH6iXNwFkzskpM_sijj5rgDiFEnqs57HJ7jmumcYTfg@mail.gmail.com>
Subject: [Outreachy][Proposal]: Reduce Git's global state to enable Git's
 libification[Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

Thank you for the guidance on sharing the proposal.

I am resending my proposal inline so that reviewers can quote specific
sections and provide feedback more easily.

I would appreciate feedback on the technical scope, implementation
approach, regression-testing strategy and feasibility of the proposed
work.

Proposal: Reduce Git's global state to enable Git's libification

1. Introduction

As a BCA graduate, I have a good foundation of programming and have
worked with some programming languages. I have practical experience
developing software projects and contributing to open source projects.
While learning how to use Git and GitHub for version control and
managing changes in my projects I became interested in using different
publicly available open source repositories. This led me to become
curious about how Git works internally, How its source code is
structured, and how its developers keep such a huge project going.

This pushed me to look into the source code of Git. I learned about
the C concepts that are needed to understand the code such as
pointers, structures, functions and looking at how the different parts
code communicates with itself. I looked into the Git code related to
repositories and learned about concepts such as the_repository, struct
repository *repo, global state and explicit dependencies. This taught
me that when contributing to a well established open source project
there is more to it than just writing code. You need to understand the
existing functionality, look at past changes and ensure that the code
is tested properly.

I made some contributions while preparing for this project. I made
changes to test scripts, test-path and safe integer arithmetic in
diff-delta. I worked on a submodule-related change involving
repository-specific commit abbreviations and made an updated patch
series for review. I gained practical experience of looking at
existing code, creating patches, testing and getting my code reviewed.

When i got to know about this project is while watching videos on
YouTube about Git and contributing to open source projects I
discovered Outreachy. I submitted my initial application and looked
through the list of projects available. I found the Git project,
'Reduce Git's global state to enable Git's libification'. As I was
already interested in Git and GitHub and had begun learning about C
programming, I decided to choose this project as it fit my interests.
I began preparing for this project by completing the microproject,
looking at Git's source code, looking into past changes and
researching potential areas to contribute to for my main project.

I am interested to involved with this Outreachy internship project for
December 2026 as it will give me the opportunity to understand and
contribute to a key part of Git's internal design. I am interested in
understanding how to replace implicit dependencies on global state by
passing the required repository or index information explicitly. I
would like to learn how this can help make the code more testable,
maintainable and reusable.

I hope to boost my C programming and problem solving skills during
this internship. I hope to make useful and thoroughly tested changes
to Git. I am happy to look into the existing implementation, talk to
maintainers, learn from code reviews and improve my work using
technical feedback and collaboration with community.

2. Understanding the Project

2.1 What is Git's global state?

Global state is information stored in variables that can be accessed
by different parts of a program. A global variable is declared outside
a function, so more than one function can access it. In Git, global
variables are used to store and access information such as repository
details and environment settings.

One important example in Git is the_repository. It is a global pointer
that gives access to repository information through a struct
repository object. Different parts of Git can use this pointer to
retrieve information about the repository currently in use. For
example, the_repository->index accesses that repository's index.

The problem is that a function can access a global variable directly
instead of receiving the information it needs through its arguments.
This creates a hidden dependency because the function relies on
information that is not clear from its parameters. It can make the
function harder to understand and test with different repository
contexts, and harder to reuse independently. Reducing these hidden
dependencies is one reason Git is working to reduce its reliance on
global state.

2.2 What does libification mean?

A software library refers to a set of code that can be used by other
programs to complete specific tasks. This means that we don=E2=80=99t need =
to
fully implement something from scratch in our application.

Git was originally designed as a command line tool. This means that
different sections of code can access the same information using
global variables. Libification makes Git=E2=80=99s internal code more suita=
ble
to be used as a library by other applications. This can be an issue
when trying to use Git=E2=80=99s internal code in other applications as it =
can
cause issues due to relying on global variables.

To fix this we can pass the necessary information into the function
arguments. An example would be passing a struct repository pointer,
such as struct repository *repo, as an argument so that the function
can access a specific repository. Or passing a struct index_state
pointer, such as struct index_state *istate so that the function can
work with a specific index. This makes it clear what the function
relies on and gives more control to developers.

This helps make Git=E2=80=99s code easier to understand, test, maintain and
reuse in different scenarios. It can also help different sections of
Git to work with different repository contexts. However, this is just
one part of the libification process and more may be needed to make
Git=E2=80=99s internal code better suited to being a library.

2.3 What has already been done?

Git developers have been working to reduce global state. Two important
structures used to store repository-specific information are
repo_config_values and repo_settings.

An example I looked at was core.attributesFile. Previously this was
stored in a global variable called git_attributes_file. When multiple
repositories are used in the same process, one repository's
configuration could overwrite the value used for another repository.
This was refactored so that the value could be stored in the
attributes_file member of repo_config_values.

Another example I looked at was core.hooksPath. Previously this was
stored in a global variable called git_hooks_path. This could cause
problems when multiple repositories used different paths for their
hooks in the same process. This was then refactored to store the value
in struct repo_settings. A function called
repo_settings_get_hooks_path() was also introduced to load and cache
the value for the required repository. These examples helped me
understand how Git uses various repository specific structures to
reduce global state.

In Google Summer of Code 2026 there was a project called "Refactoring
in order to reduce Git's global state". This aimed to reduce global
dependencies by refactoring Git's environment handling and moving
selected values into appropriate repository-specific structures,
including repo_config_values. Some examples of these values include
protect_hfs, protect_ntfs, trust_executable_bit, ignore_case,
excludes_file and various program settings.
This work provides useful context for the current Outreachy project.
The earlier refactoring focused on reducing global state in Git's
environment and configuration handling. The current project takes the
broader goal further by looking at how parts of Git can become
suitable for use as a library. My proposed pathspec investigation is a
possible contribution to that ongoing effort, rather than a claim that
pathspec work was assigned or approved by the earlier GSoC mentors.

In the v2.56 release notes for Git there are several examples of
changes made to reduce global dependencies. These include functions in
copy.c being modified to take a repository argument, the use of
repository aware versions of the tempfile and lockfile APIs. Parts of
the refspec API were changed to remove their dependency on the global
the_repository by passing the hash algorithm explicitly. And
repository pointers are passed in ref and worktree related functions.

Overall from looking at these changes, it seems that reducing global
state is a continuous process. As developers need to understand what
each value is used for, and find the correct repository/structure to
store them in. Some of the information will need to be made explicit.
The December 2026 Outreachy project continues this larger effort by
making Git's internal code more suitable for libification while
maintaining its existing behaviour.

3. Previous Contributions and Preparation

3.1 Contributions to Git

While preparing for this project, I contributed to Git. I became
familiar with reading code, finding issues, and making and testing
changes based on feedback from maintainers.

Contribution: Avoid pipes in the `t0001-init.sh` test script
Pull Request and mailing-list discussion: [PR
#2260](https://github.com/gitgitgadget/git/pull/2260); [v2
mailing-list discussion](https://lore.kernel.org/git/pull.2260.v2.git.17926=
66211685.gitgitgadget@gmail.com)
Status as of 4 November 2026: Integrated into `next` (also labelled
`seen`). The GitHub PR remains open and is not marked as merged.

Contribution: Modernize test path checks in `t2030`
Pull Request and mailing-list discussion: [PR
#2256](https://github.com/gitgitgadget/git/pull/2256); [v3
mailing-list discussion](https://lore.kernel.org/git/pull.2256.v3.git.17922=
99943380.gitgitgadget@gmail.com)
Status as of 4 November 2026: Integrated into `seen`. The PR remains
open; the latest recorded status update available to me said it needed
review.

Contribution: Use safe integer arithmetic in `diff-delta`
Pull Request and mailing-list discussion: [PR
#2276](https://github.com/gitgitgadget/git/pull/2276); [v9
mailing-list discussion](https://lore.kernel.org/git/pull.2276.v9.git.17931=
20160248.gitgitgadget@gmail.com)
Status as of 4 November 2026: Integrated into `seen`. The PR remains
open; the latest recorded mailing-list status said it needed review.

Contribution: Use the submodule repository for commit abbreviations
Pull Request and mailing-list discussion: [PR
#2288](https://github.com/gitgitgadget/git/pull/2288); [v5
mailing-list discussion](https://lore.kernel.org/git/pull.2288.v5.git.17937=
63781129.gitgitgadget@gmail.com)
Status as of 4 November 2026: v5 was submitted to the Git mailing list
on 4 November 2026 and the PR is labelled `seen`. The GitHub PR
remains open. The focused `t4041-diff-submodule-option.sh` test was
reported as passing all 48 tests before the final squash.

These statuses distinguish integration into Git's review branches
(next or seen) from a PR being merged into master. The GitHub PRs
listed above remain open as of this check.

Overall, I became familiar with Git source code, the test suite,
repository handling, creating patches and the maintainer review
process.

3.2 Source-code preparation

I investigated various areas of the Git source code, including
repository.c, repository.h, environment.c, alias.c, alias.h and
builtin/help.c. I also read the Git v2.56.0 release notes to see what
had changed recently in the effort to reduce global state.

I investigated how the_repository is used as a global pointer to the
main repository structure. I also looked at how functions receive
repository pointers (struct repository *repo) as arguments to access
repository-specific information.

I looked at alias_lookup() in alias.c and examined how it uses
the_repository. This helped me understand that a function can receive
some information through its arguments while still relying on global
state for other information.

I also investigated is_bare_repository() and the changes made in
commit 7ff3a5895b. The change separated the initial --bare
command-line option from the repository-specific bare configuration.
This helped me understand why these different types of information
need to be stored separately.

I became more familiar with commands such as git grep, sed, git log,
git show and git diff. I used them to locate functions, follow the
flow of code and understand changes between commits. This made me more
comfortable investigating the codebase and understanding how global
dependencies can be reduced.

I also examined init_pathspec_item() in pathspec.c. This is a separate
area from the skip-worktree matching helper: it uses the_repository
for repository-dependent path-prefix handling and error reporting.
This showed me that there may be other repository dependencies in
pathspec processing, but they need to be assessed individually. I have
kept this as possible follow-up investigation rather than including it
in the initial implementation scope.

3.3 Understanding the project through case studies

I investigated two examples in Git to understand how global state has
been reduced.

For core.attributesFile, I found that the value was previously stored
in the global variable git_attributes_file. It was later moved into
the attributes_file member of struct repo_config_values.

For core.hooksPath, the value was previously stored in the global
variable git_hooks_path. It was moved into struct repo_settings. A
function called repo_settings_get_hooks_path() was also introduced to
load and cache the value for the relevant repository.

Looking at these changes helped me understand that reducing global
state involves deciding where information should be stored and how the
correct repository should access it.

I also looked at a more recent pathspec change, commit dd674df326
("pathspec: use match for sparse-index expansion checks"). This change
addressed a heap-buffer-overflow involving prefixed wildcard pathspecs
with a sparse index. It changed the checks to use item.match, which
includes the path prefix, consistently instead of using item.original.
This is relevant prior work because it shows that pathspec changes
involving prefixes and sparse indexes need careful compatibility and
memory-safety testing. My proposed helper investigation is separate
from that change, and I will check for overlap rather than assume the
work is related or already covered.

4. Problem Identification and Proposed Contribution

4.1 Why investigate pathspec?

A pathspec can be used by Git commands to determine which files or
paths to target. It can be used to find a specific file, directory or
group of files using patterns.

Pathspecs are used by several Git commands such as git add, git rm,
git grep and git diff.

While investigating how pathspecs are implemented in Git, I noticed
that some of the pathspec-processing functions use the global pointer
the_repository to get information about the current repository. This
creates an implicit dependency.

Pathspec processing seems like a useful area to investigate. Making
dependencies on specific repositories or indexes explicit can help
reduce global state and make the code more reusable in different
repository contexts.

4.2 Current technical observation

In my investigation on pathspec.c, I found that there is a function
called find_pathspecs_matching_skip_worktree() that checks which
pathspecs match index entries marked with the skip-worktree flag or
located outside the sparse-checkout area.

The function accesses the index via the_repository->index, but does
not accept it as a parameter. Instead, it uses the global pointer
the_repository. This has created an implicit dependency on the global
repository.

One possible improvement would be to pass a struct index_state *istate
argument to the function. This would make the required index explicit
and allow the function to use the index supplied by its caller.

I investigated the inline wrapper for this function in pathspec.h.
This function is called matches_skip_worktree(), and calls
find_pathspecs_matching_skip_worktree(). The wrapper also caches the
matching results so they can be reused on subsequent calls.

Any change to the helper will also require reviewing and updating the
wrapper and its callers.

4.3 Current call-site investigation

I looked through the source code and found four call sites for
matches_skip_worktree(): one in pathspec.c, two in builtin/add.c, and
one in builtin/rm.c.

Each of these callers will need to be considered when changing the
helper and wrapper interface. The caller must provide the appropriate
index state so that the function works with the intended repository.

Interestingly, in builtin/rm.c, the cmd_rm() function has a struct
repository *repo argument already. However, the variable is marked as
UNUSED. The surrounding code still refers to the_repository to get the
index. Therefore this caller will need further investigation to
determine how to pass the correct index.

The changes should only be made to the relevant helper, wrapper and
callers. We should not make any assumptions that by updating these
call sites it will mean that the git add or git rm command is now free
from global state.

4.4 Proposed project objective

I want to look into reducing a specific global repository/index
dependency in Git's pathspec code.

My initial investigation focuses on
find_pathspecs_matching_skip_worktree(), which currently obtains the
index through the_repository->index instead of receiving the index it
should use as an argument.

I will investigate two possible API approaches:

1. Keep the specialised helper and add an explicit struct index_state
*istate parameter. I would then review how this parameter should pass
through the inline matches_skip_worktree() wrapper and its callers.
2. Investigate whether the existing
find_pathspecs_matching_against_index() API could be extended with
another ps_skip_worktree_action option to support the required
matching behaviour.

I will compare these approaches by looking at the existing API design,
the effect on callers, whether the required matching behaviour can be
represented clearly, and the amount of change each approach
introduces. I will discuss the findings with mentors and maintainers
before selecting the implementation.

I will also review the four identified call sites and determine which
index state each one should use. If the selected design and Git's test
infrastructure allow it, I will add a targeted regression test to
check that the helper uses the index supplied by its caller and that
existing sparse-checkout behaviour is preserved.

After this initial investigation and focused change, I may look into
whether other pathspec functions could also receive repository or
index information explicitly. Any further work will depend on the
technical findings and feedback from Git maintainers.

The aim is to reduce the reliance of selected parts of Git's pathspec
code on global state while preserving existing behaviour.

4.5 Scope boundaries

I intend to keep my initial work focused on the identified global
index dependency in find_pathspecs_matching_skip_worktree() and the
API changes needed to address it.

**What I will do initially:**

- Investigate the helper's reliance on the_repository->index.
- Compare the two API approaches described in Section 4.4 before
selecting an implementation.
- Review the inline wrapper and the four identified call sites, and
determine the correct index state for each caller.
- Investigate and, if feasible, add a focused regression test for the
selected implementation.
- Test the changes to ensure existing skip-worktree and
sparse-checkout behaviour is preserved.

**What I may investigate as follow-up work:**

- Depending on the initial findings and feedback from Git maintainers,
investigate init_pathspec_item() and selected parsing functions.
- Look into other pathspec functions only where there is a clear
repository/index dependency and a technically justified benefit to
making it explicit.
- Discuss any wider changes with mentors and maintainers before
expanding the scope.

**What I will not promise as part of the initial contribution:**

- Rewrite the whole pathspec subsystem.
- Remove all global variables from Git.
- Guarantee that the_repository will be completely removed from
pathspec functions.
- Claim that Git will become fully thread-safe as a result of this change.
- Make unrelated changes outside the agreed pathspec scope.

I will aim to make a focused and well-tested contribution while
preserving existing functionality. Any follow-up work will depend on
technical justification and maintainer guidance.

5. Technical Implementation Plan

I will begin this contribution by focusing on the identified
dependency in the skip-worktree helper. The initial work will focus on
making the index dependency explicit in the helper and updating the
relevant callers accordingly. Once this initial change has been
completed, I will review the surrounding pathspec implementation to
identify whether any further work could help reduce dependencies on
global repository state.

Phase 1: Analyse the Current Implementation

- Review the relevant pathspec implementation in pathspec.c.
- Understand what find_pathspecs_matching_skip_worktree() currently
does and how it works.
- Understand how the repository index is represented using struct index_sta=
te.
- Examine how skip-worktree entries are stored and used within the helper.
- Understand how matches_skip_worktree() acts as a wrapper around the helpe=
r.
- Identify the existing callers and investigate how they obtain and
use their index state.

Phase 2: Compare the API Approaches and Select the Design

- Investigate adding an explicit struct index_state *istate parameter
to find_pathspecs_matching_skip_worktree().
- Investigate whether the existing
find_pathspecs_matching_against_index() API could be extended with
another ps_skip_worktree_action option to provide the required
behaviour.
- Compare both approaches in terms of API clarity, effect on existing
callers, maintainability and the size of the required change.
- Discuss the findings with mentors and maintainers before selecting
the implementation.
- For the selected approach, update the helper or API to use the
appropriate index state rather than implicitly accessing
the_repository->index.
- Ensure that the declaration, definition and inline wrapper are
consistent with the selected design.
- Keep the initial change focused on the identified skip-worktree
matching dependency.

Phase 3: Investigate and Update the Callers

- Investigate the identified callers of the helper and its wrapper.
- Review the callers in pathspec.c, builtin/add.c, and builtin/rm.c.
- Identify which index state each caller should provide.
- Pay particular attention to cmd_rm() and understand how it obtains
and uses its index state.
- Update the appropriate callers to pass the correct index state.
- Review the surrounding code to ensure that the changes do not
introduce assumptions about which index is being used.

Phase 4: Investigate Other Pathspec Dependencies

Once the initial helper change has been investigated, I will look into
other pathspec functions to determine whether they have similar
dependencies on global repository state.

- Investigate init_pathspec_item() and understand how it uses
repository-related information.
- Identify relevant dependencies involving repository context and
path-prefix handling.
- Examine selected pathspec parsing functions and identify their callers.
- Consider whether explicit repository context could be introduced
where there is a clear benefit.
- Investigate potential compatibility issues before proposing further chang=
es.
- Discuss any wider changes with mentors and maintainers before
expanding the scope.

This investigation will remain conditional. I will not assume that the
entire pathspec subsystem needs to be refactored.

Phase 5: Make the Changes Clear and Easy to Review

- Keep the initial implementation focused on the skip-worktree helper
and its relevant callers.
- Organise the changes into small, easy-to-understand patches where possibl=
e.
- Follow Git's coding conventions and API design patterns.
- Clearly explain why the changes are necessary.
- Prepare the implementation for the testing and validation process
described in Section 6.
- Refine the changes based on technical findings and feedback from maintain=
ers.

The main contribution will be the initial change to the helper and its
relevant callers. Any further pathspec changes will depend on whether
they are technically justified and accepted by the Git community.

The implementation will be developed incrementally, with testing and
compatibility checks carried out as described in **Section 6: Testing
and Validation Strategy**.

6. Testing and Validation Strategy

An important part of my contribution will be testing to ensure that
the changes made do not break existing Git functionality.

I will perform the following steps to test the changes:

1. Analyse Existing Functionality

- Analyse what find_pathspecs_matching_skip_worktree() does.
- Understand how it reads the_repository->index.
- See which functions call this helper and what behaviour they expect.
- Record the expected behaviour before making changes.

2. Add a Regression Test

- Investigate whether a regression test using two separate struct
index_state instances can be added within Git's existing test
infrastructure.
- If feasible, prepare two index states, with one containing a
relevant entry with CE_SKIP_WORKTREE set and the other without it.
- If the test setup allows it, run the same pathspec against both indexes.
- Also investigate paths located outside the sparse-checkout area,
since the helper checks these paths as well.
- Check that the result depends on which index is passed to the helper
rather than the default global index.
- Where possible, verify that the regression test detects the original
behaviour and passes after my changes are made.

I have researched this as a possible two-index test design, but have
not yet implemented or run this test. The next step is to confirm
whether Git's existing C unit-test infrastructure can construct and
use the required index states cleanly. If that is not practical, I
will discuss a suitable alternative regression test with maintainers.

3. Compile and Run the Test

- Make the agreed implementation changes.
- If the regression test is feasible, compile it and run it.
- Ensure that I follow Git's existing conventions for writing C unit
tests, including the appropriate test location, registration, and
setup and cleanup.
- Fix any issues caused by compilation errors or test failures.

4. Run Relevant Compatibility Tests

For the initial helper/API change, I will:

- Run relevant pathspec tests.
- Run the sparse-checkout tests, including
t3705-add-sparse-checkout.sh and t3602-rm-sparse-checkout.sh.
- Check relevant git add and git rm behaviour.
- Investigate compatibility with sparse-index and check for potential
regressions.

I will also check prefixed and wildcard pathspecs, particularly where
the selected change or its callers could affect those cases. If
follow-up changes to pathspec initialization or parsing are proposed,
I will extend the compatibility checks to cover the relevant cases,
such as PATHSPEC_NO_REPOSITORY, git diff --no-index, and path-prefix
handling. These follow-up checks will be selected according to the
actual scope of any additional change.

5. Test Changes After Review

- Once changes have been made based on feedback from maintainers,
re-run the relevant tests.
- Ensure that the implementation does not break existing functionality.
- Investigate any new errors and fix issues introduced by the changes.
- Keep a record of the tests performed, their results, and any
remaining limitations.

Depending on the final implementation design and guidance from my
mentors, I may adjust the testing approach. However, I want to ensure
that I have a relevant regression test and sufficient testing to
demonstrate that my changes work correctly without causing
regressions.

7. Thirteen-Week Work Plan

I will be contributing for a total of 13 weeks, between 7th December
2026 and 8th March 2027. I will be spending around 30 hours per week.

I will approach this problem in small, manageable chunks. First, I
will look into the dependency I found relating to pathspec during my
pre-investigation. I will then discuss what exactly I am going to
implement with my mentors, taking into account the technical details,
what work has already been done upstream, and what the community has
to say.

Weeks 1=E2=80=932: Confirm the scope and finalize the design

Discuss what the scope of my work will be. This will include:

- Reviewing the source-code investigation and technical details.
- Talking with mentors to confirm whether pathspec is a suitable area
for my contribution.
- Checking for upstream changes related to this area.
- Reviewing the implementation of
find_pathspecs_matching_skip_worktree() and the functions that use it.
- Comparing an explicit struct index_state *istate parameter for the
specialised helper with extending the existing
find_pathspecs_matching_against_index() API using another
ps_skip_worktree_action option.
- Reviewing the effect of each approach on callers and
maintainability, then discussing the options with mentors and
maintainers before selecting the design.
- Reviewing matches_skip_worktree() to understand how its return value is u=
sed.
- Carefully reviewing cmd_rm() to determine how the repository and
index should be retrieved.
- Discussing the minimal change and a feasible regression-testing
approach with mentors.

**Output:** A clear understanding of the agreed scope, the API design,
and how the change will be implemented and tested.

Weeks 3=E2=80=934: Implement the agreed API change

- Implement the API design selected after the initial investigation
and discussion with mentors and maintainers.
- Update the relevant function declaration, implementation and wrapper
if needed.
- Update call sites to ensure they use the correct index state.
- Ensure that the existing skip-worktree matching behaviour remains unchang=
ed.
- Ensure that the code is compatible with the rest of the pathspec
implementation.
- Build Git and perform initial checks.
- Create a focused patch.

**Output:** An initial implementation of the agreed API change, ready
to be tested.

Week 5: Add and validate the focused regression test

- Investigate whether the proposed two-index regression test can be
added within Git's existing test infrastructure.
- If feasible, create the test using two indexes and the same
pathspec, and check that the behaviour depends on the index passed to
the helper.
- Ensure that the cache entries and CE_SKIP_WORKTREE are being handled
correctly.
- Check the appropriate place for the unit test by looking at the
existing tests.
- Build and run the test.
- Where possible, ensure that the test detects the original behaviour
and passes once the behaviour has been fixed.

**Output:** A focused regression test, if the test setup is feasible,
that demonstrates the desired behaviour and helps prevent the hidden
dependency from being reintroduced.

Weeks 6=E2=80=937: Compatibility testing and community review

- Run pathspec and sparse-checkout tests.
- Ensure that the changes have not affected relevant git add or git rm
behaviour.
- Investigate compatibility with sparse-index.
- Get feedback from mentors and the Git community on the
implementation and test results.
- Make changes based on feedback.
- Submit updated patches.

**Output:** An initial change that has been reviewed and tested more
thoroughly, with any compatibility issues identified.

Week 8: Evaluate further pathspec dependencies

- Investigate any remaining repository dependencies.
- Look into init_pathspec_item(), which uses the_repository to resolve
path prefixes and report errors.
- Consider whether there are other functions that need to take a
repository parameter.
- If a larger change is desired, look into parse_pathspec() and
parse_pathspec_file() and their call sites and dependencies.
- Discuss possible next steps with mentors.

**Output:** A clear technical understanding of whether any further
pathspec changes are needed.

Weeks 9=E2=80=9310: Work on approved follow-up changes

- If mentors agree that more work is appropriate, choose a small
change based on the investigation.
- Look into the relevant call sites and decide how to pass repository
or index information.
- Ensure that behaviour remains the same for situations such as
PATHSPEC_NO_REPOSITORY, git diff --no-index and path prefixes.
- Implement the agreed change in small chunks.
- Add or extend regression tests.
- Build Git and run tests.
- Submit focused patches.
- If a larger parser change is not appropriate, use this time to
improve the initial contribution, address review feedback, or work on
another related task agreed with mentors.

**Output:** A technically justified follow-up contribution, or an
improved initial contribution.

Week 11: Review and refine the implementation

- Review all changes made.
- Ensure that the implementation follows the agreed design and that
relevant repository-specific dependencies are explicit.
- Check that the tests cover the intended behaviour and investigate edge ca=
ses.
- Address further feedback.
- Improve the organisation of patches, comments and documentation.
- Run the relevant tests.

**Output:** An improved patch series, with the technical reasoning,
relevant testing and any limitations documented clearly.

Weeks 12=E2=80=9313: Final testing, documentation and handover

- Run final focused test suites and any wider testing agreed with mentors.
- Ensure that the changes do not break existing behaviour.
- Address final feedback.
- Review the final implementation and test results.
- Document the design decisions, implementation and testing.
- Summarise what has been done, which patches have been submitted or
integrated, and any remaining limitations.
- Prepare a handover to Git maintainers, including potential future
improvements.

**Output:** A validated and documented contribution, together with a
summary of completed work and possible next steps.

Work-plan flexibility

The above plan is a suggested timeline. I may need to change it based
on technical issues, mentor guidance or feedback from the community.
The aim is to create a small, useful and well-tested change. Any
further changes to pathspec or the parser will only be made if there
is a technical reason and mentors agree.

The aim is not to remove all global dependencies in Git. The aim is to
make a meaningful contribution. The focus is on improving how
repository and index state are handled. If the initial pathspec change
overlaps with existing work or is not considered appropriate, I will
adjust the scope with mentors.

8. Risks and Mitigation

Risk 1: Existing global dependencies are more widespread than expected

The pathspec implementation may contain additional dependencies on
the_repository or other repository-related global variables beyond the
helper identified during the preliminary investigation.

**Mitigation:**
- I will review the relevant functions and their callers before making
API changes.
- I will check how repository and index state are accessed and used.
- I will make changes incrementally, starting with the selected
skip-worktree helper.
- I will investigate any further dependencies before increasing the
scope of the change.
- I will not assume that a focused change has removed all global dependenci=
es.

Risk 2: Existing Git behavior may change accidentally

Changes to how the helper accesses index state may cause unwanted
changes to current pathspec matching and skip-worktree behavior.

**Mitigation:**
- I will analyse the current behaviour and document it.
- I will investigate and, if feasible, write a focused regression test
using two separate index states.
- I will check that the outcome depends on the index passed to the
helper, rather than the default global index.
- I will run focused tests covering relevant pathspec, git add and git
rm operations.
- I will check that existing behaviour, compatibility and error
handling are preserved.

Risk 3: Sparse-checkout and sparse-index edge cases

The change may interact with current sparse-checkout behavior,
skip-worktree entries, or sparse-index behavior.

**Mitigation:**
- I will test relevant skip-worktree entries and check that they
behave as expected.
- I will test relevant pathspec forms, including prefixed and wildcard
pathspecs.
- I will run the relevant sparse-checkout tests.
- I will investigate sparse-index compatibility and look for possible
regressions.
- I will use sanitizers where appropriate.

Risk 4: API changes may affect multiple callers

The helper may require changes to multiple callers. Some callers may
access repository or index state in different ways.

**Mitigation:**
- I will identify and review all known callers.
- I will check which repository or index context each caller uses.
- I will pay particular attention to cmd_rm() and how its repository
context should be used.
- I will compare the API options and discuss the most suitable
approach with maintainers.
- I will keep the resulting changes focused.

Risk 5: Maintainer feedback or existing upstream work may change the
proposed scope

The pathspec change is still open for feedback. There may be other
changes by maintainers or contributors that affect its suitability or
scope.

**Mitigation:**
- Share the initial investigation and focused change early.
- Ask for feedback before making wider changes to pathspec.
- Check for upstream changes and possible overlap throughout the work.
- Adjust the implementation based on feedback from maintainers.
- If the scope is unsuitable or overlaps with existing work, discuss
an alternative contribution with my mentors.

Risk 6: The proposed regression-test approach may not fit Git's test
infrastructure

The two-index regression test may require a different setup or
location based on Git's existing C unit-test conventions.

**Mitigation:**
- I will look at the existing C unit tests in Git.
- I will study how index states, cache entries and CE_SKIP_WORKTREE are set=
 up.
- I will make sure the test is placed in the appropriate location,
registered and cleaned up correctly.
- I will discuss the testing approach with maintainers if necessary.
- I will build Git, compile the test and run it to verify the implementatio=
n.

9. Communication and Review Strategy

Throughout the internship, I will keep in communication with the Git commun=
ity.

My strategy will include:

- Using the public Git mailing list to communicate.
- Asking clear and specific technical questions.
- Submitting small, focused patches early to receive feedback.
- Carefully reviewing feedback from maintainers and contributors and
providing responses.
- Making necessary changes and resubmitting updated versions of the patches=
.
- Explaining the technical reasoning behind the implementation and API choi=
ces.
- Keeping patches concise, well-tested, and easy to review.
- Clearly stating test results, including any failures or limitations.
- Discussing any major changes to the proposal scope with my mentors.

During my initial research, I emailed the Git community on 2 November
2026 to ask whether my proposed pathspec contribution would be
suitable and to discuss the possible implementation approaches.

The discussion can be found here:

https://gitlist.dev/t/66745

I will use feedback from the Git community and my mentors to improve
my implementation approach. As the pathspec contribution has not yet
been approved, I will not consider it confirmed until I receive
guidance from maintainers.

10. Expected Outcomes and Deliverables

The expected deliverables from my contribution include:

- A clearer understanding of the chosen repository and index
dependency within the pathspec implementation.
- A comparison of the two API approaches: adding an explicit
index-state parameter to find_pathspecs_matching_skip_worktree(), or
extending find_pathspecs_matching_against_index() with another
ps_skip_worktree_action option.
- An initial patch implementing the API approach selected after
technical investigation and discussion with maintainers, so that the
required index state is explicit rather than obtained implicitly
through the_repository.
- Updating the relevant function declaration, definition, wrapper, and
callers to match the selected API.
- Investigating and, if feasible, writing a targeted regression test
to ensure that the helper uses the index provided, using two different
index states.
- Testing relevant pathspec, sparse-checkout, git add, and git rm
behavior to verify that existing behavior is preserved.
- Making additional repository-aware changes to the pathspec
functions, assuming they are technically justified and agreed upon
with my mentors.
- Preparing focused patches so that I can receive reviews and improve
them based on feedback from maintainers and contributors.
- Recording the decisions made, the tests performed, and any remaining
limitations.

The exact deliverables will depend on the results of the technical
investigation, the implementation approach, and feedback from the Git
community. The primary goal is to deliver a minimal, useful
contribution that is well-tested.

11. Relevant Experience and Skills

During preparation for this project, I have learned C programming
fundamentals, explored Git's source code, and gained practical
experience working on Git.

I have worked on the following:

- Learning C programming, including functions, structures, pointers,
function arguments, return values, and accessing structure members.
- Understanding global variables, global state, and explicit
dependencies, including how repository context can be passed to
functions.
- Exploring Git's source code, including repository.c, repository.h,
environment.c, alias.c, and pathspec.c.
- Understanding the_repository and struct repository *repo, as well as
investigating how repository-specific state is accessed.
- Studying previous refactoring work, including how
is_bare_repository_cfg was split into separate responsibilities.
- Exploring repository configuration and state management, including
core.attributesFile and core.hooksPath.
- Using commands such as git grep, git log, git show, git diff, and
sed to explore Git's source code, understand its history, and examine
changes.
- Contributing to Git through changes involving test scripts, path
checks, safe integer arithmetic, and repository-aware commit
abbreviations for submodules.
- Creating and revising patches, responding to review feedback, and
learning how contributions are discussed within the Git community.
- Exploring Git's testing framework and understanding how tests help
verify existing behavior.

This preparation has helped me understand the importance of repository
context, ownership of state, and careful refactoring in Git. Although
I am still developing my C programming and Git internals knowledge, I
have gained practical experience exploring Git's codebase and
contributing changes. I would like to build on this foundation by
making a focused contribution with appropriate testing during the
internship.

12. Availability and Commitment

I am available for this internship between 7 December 2026 and 8 March 2027=
.

I can dedicate around 30 hours per week to the internship.

During this period, I will:

- Consistently dedicate time to the project.
- Implement changes using an incremental approach.
- Take time to understand the existing codebase.
- Write tests and run them.
- Engage in discussions and communication with my mentors and the Git commu=
nity.
- Take feedback into account and improve patches where needed.
- Keep track of my progress and communicate any issues.

I understand that contributing to an open-source project requires
continuous learning, patience, and teamwork. I will work consistently
on my contributions, learn from feedback, and aim to make a useful
contribution to the Git project.

13. References / Useful Links

The following links provide additional information about the Git
project and how to get involved. They also include examples of work I
have done previously and research I have carried out into the
technical side of my proposed contribution.

Official Git Information

- Outreachy Project Selection for December 2026:
https://www.outreachy.org/apply/project-selection/
- Git Source Code: https://github.com/git/git
- Git Documentation: https://git-scm.com/docs
- Git Contribution Guidelines:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
- Git Coding Guidelines:
https://github.com/git/git/blob/master/Documentation/CodingGuidelines
- Git Mailing List: https://lore.kernel.org/git/
- Git General Application Information:
https://git.github.io/General-Application-Information/
- Git Microproject Information:
https://git.github.io/General-Microproject-Information/

Previous Contributions

These are examples of contributions I have made to the Git project,
including work involving source code, test files, and preparing and
revising patches based on review feedback.

- PR #2260 =E2=80=93 t0001: avoid pipes in test scripts:
https://github.com/gitgitgadget/git/pull/2260
- PR #2256 =E2=80=93 t2030: modernize test path checks:
https://github.com/gitgitgadget/git/pull/2256
- PR #2276 =E2=80=93 diff-delta: use safe integer arithmetic:
https://github.com/gitgitgadget/git/pull/2276
- PR #2288 =E2=80=93 t4041: use submodule repository for commit abbreviatio=
ns:
https://github.com/gitgitgadget/git/pull/2288

Mailing-list versions of these contributions:

- PR #2260 v2: https://lore.kernel.org/git/pull.2260.v2.git.1792666211685.g=
itgitgadget@gmail.com
- PR #2256 v3: https://lore.kernel.org/git/pull.2256.v3.git.1792299943380.g=
itgitgadget@gmail.com
- PR #2276 v9: https://lore.kernel.org/git/pull.2276.v9.git.1793120160248.g=
itgitgadget@gmail.com
- PR #2288 v5: https://lore.kernel.org/git/pull.2288.v5.git.1793763781129.g=
itgitgadget@gmail.com

Relevant Source Code and Tests

- pathspec.c: https://github.com/git/git/blob/master/pathspec.c
- pathspec.h: https://github.com/git/git/blob/master/pathspec.h
- builtin/add.c: https://github.com/git/git/blob/master/builtin/add.c
- builtin/rm.c: https://github.com/git/git/blob/master/builtin/rm.c
- Sparse-checkout tests for git add:
https://github.com/git/git/blob/master/t/t3705-add-sparse-checkout.sh
- Sparse-checkout tests for git rm:
https://github.com/git/git/blob/master/t/t3602-rm-sparse-checkout.sh

Research into the Project

Discussion about the scope of the proposed pathspec contribution,
including possible API approaches and whether related work is already
planned.

https://gitlist.dev/t/66745 (2 November 2026)

Background on previous changes involving repository state and global
dependencies.

- Git v2.56.0 release notes:
https://github.com/git/git/blob/master/Documentation/RelNotes/2.56.0.adoc
- Commit 7ff3a5895b, which split the concerns of
is_bare_repository_cfg: https://github.com/git/git/commit/7ff3a5895b
- Commit dd674df326, which uses item.match consistently for
sparse-index expansion checks and adds coverage for prefixed wildcard
pathspecs: https://github.com/git/git/commit/dd674df326
- Git's official 2026 GSoC ideas page, including the project
'Refactoring in order to reduce Git's global state':
https://git.github.io/SoC-2026-Ideas/

14. Conclusion

Reducing global state helps improve repository-specific information
management and makes dependencies clearer. It also supports Git's
longer-term goal of becoming libifiable.

In my preparation, I have explored Git's source code, investigated
previous refactoring efforts, and examined repository and index
dependencies within the pathspec implementation.

Based on my investigation, I would like to make a targeted improvement
to the skip-worktree matching API. I will compare adding an explicit
struct index_state *istate parameter to
find_pathspecs_matching_skip_worktree() with extending the existing
find_pathspecs_matching_against_index() API. I will discuss the
alternatives with maintainers and select the approach that provides
the clearest API and preserves existing behaviour.

I will investigate a targeted regression test using two separate index
states to check that the helper uses the index passed to it and that
existing pathspec and skip-worktree behavior is preserved. The final
test design will depend on the available test infrastructure and the
agreed implementation. Any further changes to pathspec will depend on
the technical findings and agreement with my mentors.

This work will require careful investigation, testing, and
communication with the Git community. I am willing to learn from
feedback from reviewers and change my approach where necessary. I will
also make progress step by step.

Overall, during my internship, I hope to improve my knowledge of Git
internals and C programming while contributing a focused and
well-tested improvement to the Git project.

Thank you for your time and guidance.

Regards,
Srujith
