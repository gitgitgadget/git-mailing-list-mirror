Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075042A82
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107654; cv=none; b=FIRvdjIPMv3BHDQdTvUolVGdEsmZCeiCR7h+a5jkFDW79Xna9uBcKthodf5Q2apOX9OW3MKJVFQtFsvT4fc8BVEIQ8TppEw7X+In4aMjhotNKHTtze2MA5dZw1namkhZhwxZJzCVHFsrve/k9O8TBerYMbdgcEzu5v97ct+yIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107654; c=relaxed/simple;
	bh=4aU5AuJjhEQ8O5Pkuqo+FaazxaCLLDClhfugrpjA/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s77trB25r8o26ngj1+PzZfvTiw57bToqvNLqfPFX89k9JdPh39wspGTHFmblv/BcdlNBUgacmgej3WbPHxd7H+ZHMfrDCbX1I8roCKuSJR6Mn4+3kLl533KC2JmiVIujT9Fmuo0BPRI83wpWQa1AJrJkzj20X8m7R8RnfJhHF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdlkdPxv; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdlkdPxv"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d2e71de18so1220108e0c.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730107645; x=1730712445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dR2mUNHpcXLon+dkk1e561/yEN3UenrUwaAnOgQUjA=;
        b=MdlkdPxvmGwDo3h4ViKapGZpV6a+30YeE2+LxjEMG0Khi3E7xop/spvVOLrzYcm1R3
         1fd7noZHTzYFHXmD7/y7cNiprl4QQFUFsG9vtNb8wmFpel75SOa3NrsTATgCWbhdUutq
         oaaXr0QH4o/vK96XV6H2iClkve/YqfSNGMFUejlRRyH+jhIr5BK6mskK4WQIHDwfyuEj
         4slPsqmtY5Met0gD2jN/jRLa0huZMicEu8mNEww7EAwCONW4MezoI5gOmlN5KWynara2
         ZC9FxuTZNRYmFFMXQ8jTtTgu99NHPBY+u2wdM+OE3jnJhURciD3CbW/9aZKq/zSuqDXY
         RARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107645; x=1730712445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dR2mUNHpcXLon+dkk1e561/yEN3UenrUwaAnOgQUjA=;
        b=KoE8aN21nfPSi9VJll1cjtL85ON9lXwUxhu0SIJYTfOR8xjVoj+5Ltq9Ix/bQZ9FYO
         yNK3qiXOPWtEUJmYGs56AxXe97W5IlknZeZtPoleEFBp1Pr/2V6MSA6VRQzbJ4379Z2T
         p5hQoNfiqYZCUHnyuUy3RC9nyDuSWBChXqD+u5ChoZdBdJL0tJC9KBRrmFfFT1iRad76
         h3o1cJ6mtLUajE8ytWvpcIj1A8AMjiFIcXnADG2a4aDCwQi85vontQloxC3oTq5Q6Y14
         clSWBxklKQBQxfN5eyoX4gkbmDXGZVndwdszbgnlL/IfVbrCrbMNhyt2kDHKbPDmfb7B
         sS9w==
X-Gm-Message-State: AOJu0YxGzSItuDjQtWmxuPVTyrnYbC03dz4Z/bUH3cK5uOhO1rlH4LCt
	rnlbNSnJagvDURa0301wPHmLArkO7DaBILe51pCNVfb4rbelqZ8DbawZP92fUkAbdxnYZYCSwqO
	IFns3MogRQiWS5+YpYTN5QJlaGGUr54CUNv5cxg==
X-Google-Smtp-Source: AGHT+IGV7NpsqodiitcNfESx9fOB8xSbxB8G9Iq2zhFo2rJ0lDfZD1qMwA8Z0Q1IQy31x1F/GAbRpJQ86HHXj+yw+1I=
X-Received: by 2002:a05:6122:1da0:b0:50d:53ab:3d0c with SMTP id
 71dfb90a1353d-51014ff8a1bmr4422195e0c.2.1730107644926; Mon, 28 Oct 2024
 02:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAP8UFD2pLppDC9b-JV-uQa8x8xmpeTSJ4szHOEPz1OfqzrOMPw@mail.gmail.com> <CAPSxiM8NgFUK8R0TrE1nPctOYSD6M8cCe7=xJuniXWO2g-C6Nw@mail.gmail.com>
In-Reply-To: <CAPSxiM8NgFUK8R0TrE1nPctOYSD6M8cCe7=xJuniXWO2g-C6Nw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 28 Oct 2024 09:27:13 +0000
Message-ID: <CAPSxiM-EorSBsStHCFAm845q2H+YNDtAvCkwON8cV4AyYvGz_w@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability to
 Git protocol v2
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
This is my updated version of my "Finish adding a 'os-version'
capability to Git protocol v2" proposal based on the comment provided
by Christian
Thank you.

---------<8----------<8----------<8----------<8----------<8----------<8

Personal Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Full Name: Usman Akinyemi
Email: usmanakinyemi202@gmail.com
Personal Blog: https://uniqueusman.hashnode.dev/
Personal Website: https://uniqueusman.tech
GitHub: https://github.com/Unique-Usman
Degree: Bachelor of Technology (B.Tech) in Computer Science and
Artificial Intelligence


About Me
=3D=3D=3D=3D=3D=3D=3D=3D

I am Usman Akinyemi, I often like to refer to myself as a nomadic
computer programmer as I love the ability to work on interesting
projects without being restricted to a physical location. I love the
Linux Operating System and most people already alias my name to Linux
as I also preach it to everyone everyday. I learnt programming in
multiple places, in college,  ALX Software Engineering program and
also personal studying. I have decent experience in contributing to
OpenSource projects. I have contributed to systemd, Cpython
documentation, Canonical website,  pep8speaks and Open Science
Initiative for Perfusion Imaging (OSIPI). Being someone who is a
product of the community, I value community development so much. I
have always tried my best to contribute to the community in my own
way. One case is when I organized a month-long program(structured
webinar) aimed at exposing young Nigerians to opportunities in tech.
The program focuses on topics such as OpenSource contributions,
securing internships, career development, freelancing, datascience,
and introduction to Github and Linux([ Youtube Recording
]https://www.youtube.com/watch?v=3DOrAThr-84t8&list=3DPLBW_HlYT-kP1tUqbzavM=
Aq-ZZQRhMkZH2&ab_channel=3DUsmanAkinyemi
). I have also volunteered for different communities one of which is
DesignIT where we train Nigerian youth on technology.


Past Experience with Git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have been a Git user for about three years now. I mainly use git for
personal projects, Group projects and OpenSource contributions. I have
also had the opportunity to introduce and teach people to Git. I am
really excited to be here in the Git community.
During the contribution stage, I have got more familiar with the
community and how to send patches to Git with the help of the Git
community. I have also learnt a couple of things, one of which is Git
contributor best practices.


Contributions to the Git Community
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

I joined the Git community after I got selected for Outreachy
Contribution Phase and I have been able to send some patches to the
Git codebase with the help of the Git community while also learning.
Below is the list of my contributions:

MICROPROJECT
------------------------
- Link: https://public-inbox.org/git/pull.1805.git.git.1728192814.gitgitgad=
get@gmail.com/T/#u
- Branch Name: ua/t3404-cleanup
- Status: merged into next/jch

+ [PATCH v7 1/2] t3404: avoid losing exit status with focus on `git
show` and `git cat-file`
- Description: In the Git t3404 test script, I improved error
detection by restructuring command chains to ensure accurate exit
status handling, preventing missed errors from piped commands.
The exit code of the preceding command in a pipe is disregarded. So if
that preceding command is a Git command that fails, the test would not
fail. Instead, by saving the output of that Git command to a file, and
removing the pipe, we make sure the test will fail if that Git
command fails. This particular patch focuses on all `git show` and
some instances of `git cat-file`.

+ [PATCH v7 2/2] t3404: replace test with test_line_count()
- Description: Refactor t3404 to replace instances of `test` with
`test_line_count()` for checking line counts. This improves
readability and aligns with Git's current test practices.

- Remarks: Through this process, I deepened my understanding of shell
scripting and command chaining, focusing on how exit statuses affect
testing accuracy. My mentors suggested keeping commands readable and
consistent with Git's scripting standards, emphasizing simplicity and
future maintainability. The result is a more robust, reliable test
script that better aligns with Git=E2=80=99s best practices, improving over=
all
test suite integrity. Also, through this patch, I was able to
understand the workflow involved in submitting a patch to Git which is
quite different from many other projects which I have worked on. This
is really an interesting learning experience.
I also learnt about the importance of following Git=E2=80=99s best practice=
s
and also how to submit patches with multiple commits.

LeftOverbits
-----------------
- Link: https://public-inbox.org/git/pull.1810.v3.git.git.1729574624.gitgit=
gadget@gmail.com/T/#t
- Branch: ua/atoi
- Status: merged into next/jch

After completing the microproject, I wanted to gain a deeper
understanding of Git=E2=80=99s codebase and workflow. I began looking throu=
gh
leftoverbits to work on and found a suitable one. Through this, I
learned how to add tests for my code additions, which helped me
understand the process of integrating and validating changes in the
codebase.

- General Description: In this series of patches, I replaced `atoi()`
with `strtoul_ui()` and `strtol_i()` across the daemon, merge, and
IMAP components to address the issue of inadequate error handling and
input validation. The use of `atoi()` could lead to undefined behavior
when parsing invalid inputs, such as letters, which might result in
incorrect program behavior. Now, invalid inputs trigger clear error
messages, ensuring safer parsing and preventing malformed responses. I
updated tests for the daemon and merged components to verify these
improvements, while IMAP changes didn't include tests since none
existed for `git-imap-send`. Overall, this update significantly
strengthens input validation and code reliability.

+ [PATCH v6 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.

+ [PATCH v6 2/3] merge: replace atoi() with strtol_i() for marker size
validation
Replace atoi() with strtol_i() for parsing conflict-marker-size to
improve error handling. Invalid values, such as those containing
letters now trigger a clear error message.

+ [PATCH v6 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
and UIDNEXT
Replace unsafe uses of atoi() with strtol_i() to improve error handling
when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
Invalid values, such as those with letters, now trigger error messages
and prevent malformed status responses.

- Remarks: In this patch series, I learnt a lot of things. The
importance of splitting large changes into Smaller changes for easy
review. I also learnt about how to submit multiple patches which are
not related by creating a new branch from origin/master. Also, I
learnt how to write better commit messages. And lastly, the importance
of asking for help and integrating suggestions from the community.

I also had the opportunity to review a patch and also answer doubt
from other Outreachy applicant mate
https://public-inbox.org/git/CAEqABkKvbpo-8-gDpFtfNcpmiC8A5mJMkcDXfhcdNrpwM=
vBsDA@mail.gmail.com/T/#u
https://public-inbox.org/git/CAPSxiM8SjJwb6x2bhCd4xsYLiNk+KhWYna7-rZhdNGpYN=
V1tLg@mail.gmail.com/


Past experience with other communities
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Systemd
------------

- I Developed a new unit test framework with assertion macros which
enhanced debugging by providing detailed error reports with file
names, line numbers, and expression values upon failure, improving
issue identification and resolution
- I Updated approximately 22 existing unit test files by modifying 403
lines of code to incorporate the new assertion macros, resulting in
improved logging details and enhanced overall test coverage and
debugging efficiency.
- I Implemented the --json option for the bootctl status command and
updated the integration tests, enabling machine-readable JSON output
for comprehensive bootloader status information

PR Link:
https://github.com/systemd/systemd/pull/31873
https://github.com/systemd/systemd/pull/31853
https://github.com/systemd/systemd/pull/31819
https://github.com/systemd/systemd/pull/31700
https://github.com/systemd/systemd/pull/31678
https://github.com/systemd/systemd/pull/31669
https://github.com/systemd/systemd/pull/31666
https://github.com/systemd/systemd/pull/32035

Python Official Documentation
-----------------------------------------
- I have contributed to improving Python's official documentation,
enhancing my Python knowledge, technical writing, and collaboration
skills in open-source.

PR Link:
https://github.com/python/cpython/pull/109696
https://github.com/python/cpython/pull/111574
https://github.com/python/docs-community/pull/96
https://github.com/python/cpython/pull/113209
https://github.com/python/docs-community/pull/97

OSIPI (Open Science Initiative for Perfusion Imaging organization)
---------------------------------------------------------------------------=
------------------------
- Added a command-line interface to the existing 4D IVIM phantoms
generator, with detailed documentation for usage.
- Created a Python script for efficient reading and writing of NIfTI
images, improving data processing workflows.
- Dockerized the TF2.4_IVIM-MRI_CodeCollection project and implemented
a GitHub Action for automated Docker image building and testing,
ensuring consistent deployment and a streamlined CI/CD pipeline.

PR Link:
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/92a80d61cfca3=
22da49d126dcd598996fca92668
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/163a187c5eaad=
33b55a0af0487bd9e19ca520828
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/56ee7173c91c7=
a1dd64412d3884a3167c7514665
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/e6a47211410ed=
57705e2ec32adb397ac6663d061
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/60
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/74

Canonical Docs Website
---------------------------------
I developed a solution to integrate GitHub contributor information
into Sphinx documentation templates using the GitHub API, enhancing
documentation with contributor insights.

PR Link:
https://github.com/canonical/sphinx-docs-starter-pack/pull/203#issuecomment=
-2018521984

LLVM
--------
I fixed a bug in Clang's Extract API for Objective-C JSON generation
and optimized the test suite within the LLVM Compiler Infrastructure.
https://github.com/Unique-Usman/llvm-project/commit/32b53cf9d0c8c0e01ce5b0e=
7d5c717202a98cdf5


Experience as a user of OpenSource Software
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As an avid user of open-source software, my experience has been
primarily with Linux distributions, particularly Arch, which serves as
my primary operating system. My past usage of Ubuntu has also
contributed to my understanding of different Linux environments.
In addition, I have extensively utilized various free software such as
MySQL for database management, LibreOffice for office productivity,
GCC and G++ for C and C++ programming, Python for scripting and
application development, React for web development, Clang for C/C++
compilation, Git for version control and many others. These
experiences have not only enriched my software knowledge but have also
deepened my understanding of the principles and benefits of
open-source development.


=E2=80=94---------------- Project Overview ---------------------------

In June 2024, a patch series was submitted to the Git mailing list
aimed at adding a new 'os-version' capability to the Git protocol v2.
This capability is designed to allow Git clients and servers to
exchange information about the Operating System (OS) they are using,
which can aid in diagnosing issues and collecting statistical data.
Following the patch submission, discussions arose regarding the
necessary improvements and issues, particularly with Windows
compatibility.
The objective of this internship is to address these outstanding
issues, implement the required improvements, and ensure the successful
integration of the 'os-version' capability into the Git protocol.

=E2=80=94------- Internship objectives and plans  =E2=80=94-------
The goal of this internship is to finalize the implementation of the
'os-version' capability in Git protocol v2, as proposed in the patch
series sent to the Git mailing list in June 2024. This enhancement
will allow Git clients and servers to advertise their operating
systems (OS), aiding in diagnostics and data collection.

Detailed Tasks and Steps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Review the Current Patch Series
--------------------------------------------
1. Examine the Patch: Thoroughly analyze the existing patch series
submitted to the Git mailing list. Understand its design and
functionality, focusing on:
   -  How the OS information is gathered and transmitted.
   -  Current configurations and their implications on data transmission.
2. Feedback Analysis: Collect feedback from the Git mailing list
discussion regarding the patch. Identify key concerns, especially
related to:
    - Privacy issues.
    - Default behavior expectations.
    - Cross-platform compatibility.
3. Consider User-Agent Integration: Investigate the suggestion to
integrate the 'os-version' data into the existing user-agent string
rather than creating a new capability. Evaluate:
    - The implications of combining this data with the user-agent.
    - How this approach might address concerns about telemetry and user pri=
vacy.

Implement Default Behavior for 'os-version'
----------------------------------------------------------
1. Modify Default Configuration: Adjust the implementation so that by
default, only the OS name (e.g., "Linux" or "Windows") is sent during
communications.
2. Impact Assessment: Evaluate how this change impacts existing users
and any potential performance implications.

Introduce a Configuration Variable
---------------------------------------------
1. Define Configuration Options
    - Disable Option: Allow users to disable the 'os-version'
capability entirely via configuration.
    - Verbose Option: Enable a verbose mode that sends detailed OS
information (e.g., the output of the uname -srvm command).
    - Custom Option: Allows users to specify components independently,
using variables such as $OS_NAME for OS, $DISTRO for Linux
distribution, and $ARCH for architecture.
For example:
    i. "OS: $OS_NAME, Distro: $DISTRO, Arch: $ARCH" might output "OS:
Linux, Distro: Fedora, Arch: x86_64".
    ii.  "Distro: $DISTRO Version, OS: $OS_NAME" could yield "Distro:
Ubuntu 22.04, OS: Linux"

2. Documentation: Improve the documentation outlining how to enable,
disable, and configure the 'os-version' capability. Include examples
for:
    - Basic usage (default OS name).
    - Detailed usage (full OS version information).
3. Implementation: Code the configuration settings and ensure they are
recognized by the Git system.

Fix Cross-Platform Tests
---------------------------------

1. Identify Issues and added tests for changes/addition: Investigate
existing test failures, particularly those occurring on Windows and .
     - Review the test logs and identify the root causes of failures.
     - Analyze differences in OS behaviors and how they affect the tests.
     - Cross-platform tests to validate the functionality on Linux,
Windows, and macOS environments.
2. Implement Fixes:
      - Modify tests to ensure they run correctly on Windows,
addressing any compatibility issues with the test framework or Git
commands.
      - Ensure all tests reflect the changes made to the OS reporting
capabilities.

Testing and Validation
------------------------------
Ensure comprehensive test coverage=E2=80=94including default behavior,
configuration options, and edge cases=E2=80=94integrate tests into the Git =
CI
pipeline for automatic execution, and share results with the community
for feedback on robustness and additional scenarios.

Documentation Updates
---------------------------------

1. User Documentation: Update the Git documentation to include:
    - Instructions on how to configure the feature, with practical examples=
.
    - Best practices regarding data privacy when using the capability.
2 Developer Documentation: Include comments in the code for
maintainability and understanding of how the 'os-version' capability
works internally.

 Prepare for Merging
----------------------------
1. Final Review: Conduct a thorough review of all code, tests, and
documentation. Ensure everything aligns with Git=E2=80=99s contribution
standards.
2. Engagement with Community: Present the finalized patch to the Git
mailing list, addressing any additional concerns raised during the
discussions.
3. Merge Process: Coordinate with the maintainers for merging the
patch into the main branch, ensuring all feedback has been
incorporated.


=E2=80=94------------------------- Timeline =E2=80=94----------------------=
---------------

Community Feedback and Finalization
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Dates: November 26 - December 8
Engage with the Git community to gather input, especially on privacy
concerns and minimal data sharing. Determine default behavior (sharing
only OS name) and finalize whether to use "user-agent" or another
identifier in the protocol(os-version).

Minimal Default Implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: December 9 - December 20
Implement the core feature to share only the OS name by default,
keeping data minimal as per feedback.
Send Patches for review from the Git community

Configurable Options for OS Version
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Dates: December 21 - December 30
Develop settings to allow users to disable OS data sharing or choose
verbose mode (e.g., uname -srvm output).
Send Patches for review from the Git community

Cross-Platform Testing (Focus on Windows)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Dates: December 31 - January 13
Conduct robust testing across platforms, addressing prior Windows
compatibility issues.
Send Patches for review from the Git community

Beta Testing and Community Feedback
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Dates: January 14 - January 27
Release for beta testing, integrate feedback, and refine functionality
based on real-world use.

Documentation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: January 28 - February 10
Document feature usage, configuration options, and setup instructions
for smooth adoption.
Send Patches for review from the Git community

Final Review and Merge
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: February 11 - March 6
The final review phase will include presenting the completed work to
the Git community for a thorough final assessment. Any remaining
concerns or suggestions will be addressed before the patch is prepared
for merge. This stage will allow for further feedback, particularly
from stakeholders and maintainers who raised the initial questions,
ensuring the solution is acceptable to the broad Git community. Once
consensus is achieved, the patch will be merged into the Git mainline
codebase, concluding the project.


Availability
=3D=3D=3D=3D=3D=3D=3D=3D
I will be available to work for the required minimum of 40hours per week
during the internship period and will be happy to extend if required.

Blogging
=3D=3D=3D=3D=3D=3D=3D
I also plan to keep writing blogs after two weeks, to track my
progress,  give updates about what I am currently working on and also
as a documentation for future contributors.

Post Outreachy Internship
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
One of my dreams is to be an active member of an open-source community
which I can proudly support and contribute to. Continuing my
contributions after the internship is a big part of making that dream
a reality. I=E2=80=99m committed to contributing to Git long-term, helping =
to
improve the project and supporting new contributors along the way.

Appreciation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I really appreciate the support and guidance I got from the Git
community. I also appreciate all the effort from the outreachy mentor.
Thanks for your time.

Thank you.
Usman Akinyemi.

On Mon, Oct 28, 2024 at 9:09=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Mon, Oct 28, 2024 at 8:26=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi Usman,
> >
> > On Sun, Oct 27, 2024 at 3:54=E2=80=AFPM Usman Akinyemi
> > <usmanakinyemi202@gmail.com> wrote:
> > >
> > > Hello Git Community,
> > >
> > > I hope this mail finds you well.
> > >
> > > This is my proposal for the project "Finish adding a 'os-version'
> > > capability to Git protocol v2" for Outreachy internship program 2024.
> > >
> > > I appreciate any feedback on this proposal.
> >
> > Thanks for this proposal! You will find my feedback below.
> >
> > > ---------<8----------<8----------<8----------<8----------<8----------=
<8
> > >
> > > Personal Information
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Full Name: Usman Akinyemi
> > > Email: usmanakinyemi202@gmail.com
> > > Personal Blog: https://uniqueusman.hashnode.dev/
> > > Personal Website: https://uniqueusman.tech
> > > GitHub: https://github.com/Unique-Usman
> > > Degree: Bachelor of Technology (B.Tech) in Computer Science and
> > > Artificial Intelligence
> > >
> > >
> > > About Me
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > I am Usman Akinyemi, I often like to refer to myself as a nomadic
> > > computer programmer as I love the ability to work on interesting
> > > projects without being restricted to a physical location. I love the
> > > Linux Operating System and most people already alias my name to Linux
> > > as I also preach it to everyone everyday. I learnt programming in
> > > multiple places, in college,  ALX Software Engineering program and
> > > also personal studying. I have decent experience in contributing to
> > > OpenSource projects. I have contributed to systemd, Cpython
> > > documentation, Canonical website,  pep8speaks and Open Science
> > > Initiative for Perfusion Imaging (OSIPI). Being someone who is a
> > > product of the community, I value community development so much. I
> > > have always tried my best to contribute to the community in my own
> > > way. One case is when I organized a month-long program(structured
> > > webinar) aimed at exposing young Nigerians to opportunities in tech.
> > > The program focuses on topics such as OpenSource contributions,
> > > securing internships, career development, freelancing, datascience,
> > > and introduction to Github and Linux([ Youtube Recording
> > > ]https://www.youtube.com/watch?v=3DOrAThr-84t8&list=3DPLBW_HlYT-kP1tU=
qbzavMAq-ZZQRhMkZH2&ab_channel=3DUsmanAkinyemi
> > > ). I have also volunteered for different communities one of which is
> > > DesignIT where we train Nigerian youth on technology.
> > >
> > >
> > > Past Experience with Git
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > I have been a Git user for about three years now. I mainly use git fo=
r
> > > personal projects, Group projects and OpenSource contributions. I hav=
e
> > > also had the opportunity to introduce and teach people to Git. I am
> > > really excited to be here in the Git community.
> > > During the contribution stage, I have got more familiar with the
> > > community and how to send patches to Git with the help of the Git
> > > community. I have also learnt a couple of things, one of which is Git
> > > contributor best practices.
> > >
> > >
> > > Contributions to the Git Community
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > > I joined the Git community after I got selected for Outreachy
> > > Contribution Phase and I have been able to send some patches to the
> > > Git codebase with the help of the Git community while also learning.
> > > Below is the list of my contributions:
> > >
> > > MICROPROJECT
> > > ------------------------
> > > - Link: https://public-inbox.org/git/pull.1805.git.git.1728192814.git=
gitgadget@gmail.com/T/#u
> > > - Merge Commit: 6487b2b
> >
> > The commit is now 26b7b76329e03252c2738d7af90b5c18db3e98e1. As 'next'
> > and 'seen' are rebuilt on top of 'master', the commit id changes so it
> > might be better to just give the branch name, here "ua/t3404-cleanup"
> > for branches that are not yet merged into 'master'.
> >
> > > - Status: merged into next/jch
> >
> > > + [PATCH v7 1/2] t3404: avoid losing exit status with focus on `git
> > > show` and `git cat-file`
> > > - Description: In the Git t3404 test script, I improved error
> > > detection by restructuring command chains to ensure accurate exit
> > > status handling, preventing missed errors from piped commands.
> > > The exit code of the preceding command in a pipe is disregarded. So i=
f
> > > that preceding command is a Git command that fails, the test would no=
t
> > > fail. Instead, by saving the output of that Git command to a file, an=
d
> > > removing the pipe, we make sure the test will fail if that Git
> > > command fails. This particular patch focuses on all `git show` and
> > > some instances of `git cat-file`.
> > >
> > > + [PATCH v7 2/2] t3404: replace test with test_line_count()
> > > - Description: Refactor t3404 to replace instances of `test` with
> > > `test_line_count()` for checking line counts. This improves
> > > readability and aligns with Git's current test practices.
> > >
> > > - Remarks: Through this process, I deepened my understanding of shell
> > > scripting and command chaining, focusing on how exit statuses affect
> > > testing accuracy. My mentors suggested keeping commands readable and
> > > consistent with Git's scripting standards, emphasizing simplicity and
> > > future maintainability. The result is a more robust, reliable test
> > > script that better aligns with Git=E2=80=99s best practices, improvin=
g overall
> > > test suite integrity. Also, through this patch, I was able to
> > > understand the workflow involved in submitting a patch to git which i=
s
> >
> > Nit: s/git/Git/
> >
> > > quite different from many other projects which I have worked on. This
> > > is really an interesting learning experience.
> > > I also learnt about the importance of following Git=E2=80=99s best pr=
actices
> > > and also How  to submit patches with multiple commits.
> >
> > Nit: s/How  to/how to/
> >
> > > LeftOverbits
> > > -----------------
> > > - Link: https://public-inbox.org/git/pull.1810.v3.git.git.1729574624.=
gitgitgadget@gmail.com/T/#t
> > > - Merge Commit: cfd82c9
> >
> > Here also the merge commit is now
> > ecd980f7eb8f24fa6ca85e35288d02909b1ba64a, so better just give the
> > 'ua/atoi' branch name.
> >
> > > - Status: merged into next/jch
> > >
> > > After completing the microproject, I wanted to gain a deeper
> > > understanding of Git=E2=80=99s codebase and workflow. I began looking=
 through
> > > leftoverbits to work on and found a suitable one. Through this, I
> > > learned how to add tests for my code additions, which helped me
> > > understand the process of integrating and validating changes in the
> > > codebase.
> > >
> > > - General Description: In this series of patches, I replaced `atoi()`
> > > with `strtoul_ui()` and `strtol_i()` across the daemon, merge, and
> > > IMAP components to address the issue of inadequate error handling and
> > > input validation. The use of `atoi()` could lead to undefined behavio=
r
> > > when parsing invalid inputs, such as letters, which might result in
> > > incorrect program behavior. Now, invalid inputs trigger clear error
> > > messages, ensuring safer parsing and preventing malformed responses. =
I
> > > updated tests for the daemon and merged components to verify these
> > > improvements, while IMAP changes didn't include tests since none
> > > existed for `git-imap-send`. Overall, this update significantly
> > > strengthens input validation and code reliability.
> > >
> > > + [PATCH v6 1/3] daemon: replace atoi() with strtoul_ui() and strtol_=
i()
> > > Replace atoi() with strtoul_ui() for --timeout and --init-timeout
> > > (non-negative integers) and with strtol_i() for --max-connections
> > > (signed integers). This improves error handling and input validation
> > > by detecting invalid values and providing clear error messages.
> > >
> > > + [PATCH v6 2/3] merge: replace atoi() with strtol_i() for marker siz=
e
> > > validation
> > > Replace atoi() with strtol_i() for parsing conflict-marker-size to
> > > improve error handling. Invalid values, such as those containing
> > > letters now trigger a clear error message.
> > >
> > > + [PATCH v6 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
> > > and UIDNEXT
> > > Replace unsafe uses of atoi() with strtol_i() to improve error handli=
ng
> > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > > Invalid values, such as those with letters, now trigger error message=
s
> > > and prevent malformed status responses.
> > >
> > > - Remarks: In this patch series, I learnt a lot of things. The
> > > importance of splitting large changes into Smaller changes for easy
> > > review. I also learnt about how to submit multiple patches which are
> > > not related by creating a new branch from origin/master. Also, I
> > > learnt how to write better commit messages. And lastly, the importanc=
e
> > > of asking for help and integrating suggestions from the community.
> > >
> > > I also had the opportunity to review a patch and also answer doubt
> > > from other outreachy applicant mate
> >
> > Nit: s/outreachy/Outreachy/
> >
> > > https://public-inbox.org/git/CAEqABkKvbpo-8-gDpFtfNcpmiC8A5mJMkcDXfhc=
dNrpwMvBsDA@mail.gmail.com/T/#u
> > > https://public-inbox.org/git/CAPSxiM8SjJwb6x2bhCd4xsYLiNk+KhWYna7-rZh=
dNGpYNV1tLg@mail.gmail.com/
> > >
> > >
> > > Past experience with other communities
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Systemd
> > > ------------
> > >
> > > - I Developed a new unit test framework with assertion macros which
> > > enhanced debugging by providing detailed error reports with file
> > > names, line numbers, and expression values upon failure, improving
> > > issue identification and resolution
> > > - I Updated approximately 22 existing unit test files by modifying 40=
3
> > > lines of code to incorporate the new assertion macros, resulting in
> > > improved logging details and enhanced overall test coverage and
> > > debugging efficiency.
> > > - I Implemented the --json option for the bootctl status command and
> > > updated the integration tests, enabling machine-readable JSON output
> > > for comprehensive bootloader status information
> > >
> > > PR Link:
> > > https://github.com/systemd/systemd/pull/31873
> > > https://github.com/systemd/systemd/pull/31853
> > > https://github.com/systemd/systemd/pull/31819
> > > https://github.com/systemd/systemd/pull/31700
> > > https://github.com/systemd/systemd/pull/31678
> > > https://github.com/systemd/systemd/pull/31669
> > > https://github.com/systemd/systemd/pull/31666
> > > https://github.com/systemd/systemd/pull/32035
> > >
> > > Python Official Documentation
> > > -----------------------------------------
> > > - I have contributed to improving Python's official documentation,
> > > enhancing my Python knowledge, technical writing, and collaboration
> > > skills in open-source.
> > >
> > > PR Link:
> > > https://github.com/python/cpython/pull/109696
> > > https://github.com/python/cpython/pull/111574
> > > https://github.com/python/docs-community/pull/96
> > > https://github.com/python/cpython/pull/113209
> > > https://github.com/python/docs-community/pull/97
> > >
> > > OSIPI (Open Science Initiative for Perfusion Imaging(OSIPI) organizat=
ion)
> >
> > Nit: s/(OSIPI)//
> >
> > > ---------------------------------------------------------------------=
------------------------------
> > > - Added a command-line interface to the existing 4D IVIM phantoms
> > > generator, with detailed documentation for usage.
> > > - Created a Python script for efficient reading and writing of NIfTI
> > > images, improving data processing workflows.
> > > - Dockerized the TF2.4_IVIM-MRI_CodeCollection project and implemente=
d
> > > a GitHub Action for automated Docker image building and testing,
> > > ensuring consistent deployment and a streamlined CI/CD pipeline.
> > >
> > > PR Link:
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/92a80d6=
1cfca322da49d126dcd598996fca92668
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/163a187=
c5eaad33b55a0af0487bd9e19ca520828
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/56ee717=
3c91c7a1dd64412d3884a3167c7514665
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/e6a4721=
1410ed57705e2ec32adb397ac6663d061
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/60
> > > https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/74
> > >
> > > Canonical Docs Website
> > > ---------------------------------
> > > I developed a solution to integrate GitHub contributor information
> > > into Sphinx documentation templates using the GitHub API, enhancing
> > > documentation with contributor insights.
> > >
> > > PR Link:
> > > https://github.com/canonical/sphinx-docs-starter-pack/pull/203#issuec=
omment-2018521984
> > >
> > > LLVM
> > > --------
> > > I fixed a bug in Clang's Extract API for Objective-C JSON generation
> > > and optimized the test suite within the LLVM Compiler Infrastructure.
> > > https://github.com/Unique-Usman/llvm-project/commit/32b53cf9d0c8c0e01=
ce5b0e7d5c717202a98cdf5
> > >
> > >
> > > Experience As a user of OpenSource Software
> >
> > Nit: s/As/as/
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > As an avid user of open-source software, my experience has been
> > > primarily with Linux distributions, particularly Arch, which serves a=
s
> > > my primary operating system. My past usage of Ubuntu has also
> > > contributed to my understanding of different Linux environments.
> > > In addition, I have extensively utilized various free software such a=
s
> > > MySQL for database management, LibreOffice for office productivity,
> > > GCC and G++ for C and C++ programming, Python for scripting and
> > > application development, React for web development, Clang for C/C++
> > > compilation, Git for version control and many others. These
> > > experiences have not only enriched my software knowledge but have als=
o
> > > deepened my understanding of the principles and benefits of
> > > open-source development.
> > >
> > >
> > > =E2=80=94--------------------------------- Project Overview
> > > =E2=80=94--=E2=80=94--------------------------------
> > > In June 2024, a patch series was submitted to the Git mailing list
> > > aimed at adding a new 'os-version' capability to the Git protocol v2.
> > > This capability is designed to allow Git clients and servers to
> > > exchange information about the Operating System (OS) they are using,
> > > which can aid in diagnosing issues and collecting statistical data.
> > > Following the patch submission, discussions arose regarding the
> > > necessary improvements and issues, particularly with Windows
> > > compatibility.
> > > The objective of this internship is to address these outstanding
> > > issues, implement the required improvements, and ensure the successfu=
l
> > > integration of the 'os-version' capability into the Git protocol.
> > >
> > > =E2=80=94------- Internship objectives and plans  =E2=80=94-------
> > > The goal of this internship is to finalize the implementation of the
> > > 'os-version' capability in Git protocol v2, as proposed in the patch
> > > series sent to the Git mailing list in June 2024. This enhancement
> > > will allow Git clients and servers to advertise their operating
> > > systems (OS), aiding in diagnostics and data collection.
> > >
> > > Detailed Tasks and Steps
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Review the Current Patch Series
> > > --------------------------------------------
> > > 1. Examine the Patch: Thoroughly analyze the existing patch series
> > > submitted to the Git mailing list. Understand its design and
> > > functionality, focusing on:
> > >    -  How the OS information is gathered and transmitted.
> > >    -  Current configurations and their implications on data transmiss=
ion.
> > > 2. Feedback Analysis: Collect feedback from the Git mailing list
> > > discussion regarding the patch. Identify key concerns, especially
> > > related to:
> > >     - Privacy issues.
> > >     - Default behavior expectations.
> > >     - Cross-platform compatibility.
> > > 3. Consider User-Agent Integration: Investigate the suggestion to
> > > integrate the 'os-version' data into the existing user-agent string
> > > rather than creating a new capability. Evaluate:
> > >     - The implications of combining this data with the user-agent.
> > >     - How this approach might address concerns about telemetry and us=
er privacy.
> > >
> > > Implement Default Behavior for 'os-version'
> > > ----------------------------------------------------------
> > > 1. Modify Default Configuration: Adjust the implementation so that by
> > > default, only the OS name (e.g., "Linux" or "Windows") is sent during
> > > communications.
> > > 2. Impact Assessment: Evaluate how this change impacts existing users
> > > and any potential performance implications.
> > >
> > > Introduce a Configuration Variable
> > > ---------------------------------------------
> > > 1. Define Configuration Options
> > >     - Disable Option: Allow users to disable the 'os-version'
> > > capability entirely via configuration.
> > >     - Verbose Option: Enable a verbose mode that sends detailed OS
> > > information (e.g., the output of the uname -srvm command).
> >
> > Shouldn't there be a config option corresponding to the default
> > behavior (which would be to show only the OS Name like "Linux",
> > "Windows", etc.) ?
> >
> > Also what if users want something more customized, like perhaps "OS:
> > Linux, Arch: x86_64"?
> Hello Christian,
> thank you very much for the review.
> This is true, I will add it in the next iteration.
> >
> > > 2. Documentation: Improve the documentation outlining how to enable,
> > > disable, and configure the 'os-version' capability. Include examples
> > > for:
> > >     - Basic usage (default OS name).
> > >     - Detailed usage (full OS version information).
> > > 3. Implementation: Code the configuration settings and ensure they ar=
e
> > > recognized by the Git system.
> > >
> > > Fix Cross-Platform Tests
> > > ---------------------------------
> > >
> > > 1. Identify Issues and added tests for changes/addition: Investigate
> > > existing test failures, particularly those occurring on Windows and .
> > >      - Review the test logs and identify the root causes of failures.
> > >      - Analyze differences in OS behaviors and how they affect the te=
sts.
> > >      - Cross-platform tests to validate the functionality on Linux,
> > > Windows, and macOS environments.
> > > 2. Implement Fixes:
> > >       - Modify tests to ensure they run correctly on Windows,
> > > addressing any compatibility issues with the test framework or Git
> > > commands.
> > >       - Ensure all tests reflect the changes made to the OS reporting
> > > capabilities.
> > >
> > > Testing and Validation
> > > ------------------------------
> > > Ensure comprehensive test coverage=E2=80=94including default behavior=
,
> > > configuration options, and edge cases=E2=80=94integrate tests into th=
e Git CI
> > > pipeline for automatic execution, and share results with the communit=
y
> > > for feedback on robustness and additional scenarios.
> > >
> > > Documentation Updates
> > > ---------------------------------
> > >
> > > 1. User Documentation: Update the Git documentation to include:
> > >     - Instructions on how to configure the feature, with practical ex=
amples.
> > >     - Best practices regarding data privacy when using the capability=
.
> > > 2 Developer Documentation: Include comments in the code for
> > > maintainability and understanding of how the 'os-version' capability
> > > works internally.
> > >
> > >  Prepare for Merging
> > > ----------------------------
> > > 1. Final Review: Conduct a thorough review of all code, tests, and
> > > documentation. Ensure everything aligns with Git=E2=80=99s contributi=
on
> > > standards.
> > > 2. Engagement with Community: Present the finalized patch to the Git
> > > mailing list, addressing any additional concerns raised during the
> > > discussions.
> > > 3. Merge Process: Coordinate with the maintainers for merging the
> > > patch into the main branch, ensuring all feedback has been
> > > incorporated.
> > >
> > >
> > > =E2=80=94------------------------- Timeline =E2=80=94----------------=
---------------------
> > >
> > > Community Feedback and Finalization
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > Dates: November 26 - December 8
> > > Engage with the Git community to gather input, especially on privacy
> > > concerns and minimal data sharing. Determine default behavior (sharin=
g
> > > only OS name) and finalize whether to use "user-agent" or another
> > > identifier in the protocol(os-version).
> > >
> > > Minimal Default Implementation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > Dates: December 9 - December 20
> > > Implement the core feature to share only the OS name by default,
> > > keeping data minimal as per feedback.
> > >
> > > Configurable Options for OS Version
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > > Dates: December 21 - December 30
> > > Develop settings to allow users to disable OS data sharing or choose
> > > verbose mode (e.g., uname -srvm output).
> > >
> > > Cross-Platform Testing (Focus on Windows)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Dates: December 31 - January 13
> > > Conduct robust testing across platforms, addressing prior Windows
> > > compatibility issues.
> > >
> > > Beta Testing and Community Feedback
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > Dates: January 14 - January 27
> > > Release for beta testing, integrate feedback, and refine functionalit=
y
> > > based on real-world use.
> > >
> > > Documentation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Dates: January 28 - February 10
> > > Document feature usage, configuration options, and setup instructions
> > > for smooth adoption.
> > >
> > > Final Review and Merge
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Dates: February 11 - March 6
> > > The final review phase will include presenting the completed work to
> > > the Git community for a thorough final assessment. Any remaining
> > > concerns or suggestions will be addressed before the patch is prepare=
d
> > > for merge. This stage will allow for further feedback, particularly
> > > from stakeholders and maintainers who raised the initial questions,
> > > ensuring the solution is acceptable to the broad Git community. Once
> > > consensus is achieved, the patch will be merged into the Git mainline
> > > codebase, concluding the project.
> > >
> > >
> > > Availability
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > I will be available to work for the required minimum of 30 hours
> > > during the internship period and will be happy to extend if required.
> >
> > Do you mean 30 hours total or 30 hours per week?
> Hello Christian,
>
> Thanks for your review. I really appreciate it. I meant 30hours per
> week. I am able to give 40hours per week also, but, I wrote this in
> regards to a comment from Patrick.
> I will send an update proposal with the changes you mentioned.
> Usman Akinyemi.
> >
> > > Blogging
> > > =3D=3D=3D=3D=3D=3D=3D
> > > I also plan to keep writing blogs after two weeks, to track my
> > > progress,  give updates about what I am currently working on and also
> > > as a documentation for future contributors.
> > >
> > > Post Outreachy Internship
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > One of my dreams is to be an active member of an open-source communit=
y
> > > which I can proudly support and contribute to. Continuing my
> > > contributions after the internship is a big part of making that dream
> > > a reality. I=E2=80=99m committed to contributing to Git long-term, he=
lping to
> > > improve the project and supporting new contributors along the way.
> > >
> > > Appreciation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > I really appreciate the support and guidance I got from the git
> >
> > Nit: s/git/Git/
> >
> > > community. I also appreciate all the effort from the outreachy mentor=
.
> > > Thanks for your time.
> >
> > Thanks,
> > Christian.
