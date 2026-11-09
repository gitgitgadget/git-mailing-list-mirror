Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794243207;
	b=2b9EBEh2uinFG8rIV6/v9FQxBSiu7etNONW7RLiXfru4r5M7uUZ6+T4H8SegYAh04R4P
	 /gKw+H221oGhf7XXQ5QSZsYos138Qtm6DN2FIeljOgL92sWgGodPv/im7p4JyJuqTGM76
	 qu9amO38QErxVDZE3zN2KJS9EqcTAbNHt3KUoU6e9bIUCygR/+I+ef8O9colsct5bb5Mv
	 ntK9+0S+5mVSjzPOyMmCVxSNxURAKfvR90n54JVh9e1q8j2zyFu9/1/ng/E6IqwacCgnm
	 NBAD78Y0324PkhRBSUgv+Ih180UDrI3T4IRjRyUJHMh+Tl1OGMdEfmhvnE6ReeGNU3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PiFHI9sbs90EaOflLMCIoqlv2grDX5IFBwqfv1JVSrc=;
	b=SJu9TL7ZyuyXj+Wte83lYGcBZLvNzWbXXRs7ElzOURC4OUVDBcwBOpzsxmGIhdbjJ7sI
	 KNn+jAREdXsNcEspShQDNlN0o1kpQt2fqw3z4cMGAQQNKy26YDQ9Z6Hu/DHtqc6zvZW7Z
	 iJD5BvNX+ZcU57v3lRrk979gjgFBOW2CqqO9wXDXmT36oUIP4YXckALKPbU5H/DJoXPYP
	 f230ehq3prWacYoCHPC98XdqCcL1nl2/8owQ46ay1cyuaah0NHB7AXCDD8uBEcWedQM3C
	 6d15uCrq6sHWsDB+IJ2pKinAlcGQesZ7DurhzjrV8WwmbXOgqEYy9Tf9nQGFFm3TT8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHXhI14p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C3606EEA0
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649C3606EEA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHXhI14p
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-714d57774d8so652773eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 08:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794243205; cv=none;
        d=google.com; s=arc-20260327;
        b=ZV7totP4GIXDieqk76j0kg7Y2bOSYfJsKZCrEo62C7xDMjaSPIxwDHhfoKtYVlgnrw
         HgBr1ckzFrfE3D2BKL9YgDxk07FEyMD/M7Cr0ERAoeCTeAYfxyNtSJB6Za2QS3Bv/FZh
         Smj5zOqZopgM+FYEbkhL8D/iE9UfriOKsy4M6QUmFSmhoU7lvHuXeT3+GTZ7GUjgjzIJ
         fOHrxwdyse59IEIUfIHVqgCYsHSUFRVwF185IO4oN81VGBKFItWVTO8Yqe2SoFyJfNci
         U1sQ340YCAJdakfW6bPqRm4wJ2/YMLNhBhmdfGoC3eKAUG4rECFU7VjA7qiFrsYgFj1K
         Rrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=PiFHI9sbs90EaOflLMCIoqlv2grDX5IFBwqfv1JVSrc=;
        fh=pRIvharEkNeMx3IRsF9Tu2o2dMDVueWQIanFM70Xk00=;
        b=oBLeUrqe3XQE09f4MXHCgIvEvsrFqKlKmHkE5mD9PYnyVsnr5bavKriSUWSRKtHWwH
         tbF0+iZFWWGmYoP5dY+VO97UFuAKkD6QHx9R20HPE+hoPdc9jLaqVV84SYJ1NNADFXwr
         15xkVOO/WcyE9RvkkJaErs7kBdDzetxEEd9UKc/B03cGxty/I4vPSbs3mp16mqZb074C
         lCQF8W4CHjpQxLijWBzdMnK87Ep2in1uUi9FynMSB7Sz0+VJeeuTK0TLr4dgX7jgMuWx
         A6UUZKsI7dlSsNNVRXz682qsPy4rFmQ03mAb8cSL34Y53EmJ+KwGaLXbY/cy7Cfc8W7x
         /f9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243205; x=1794848005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiFHI9sbs90EaOflLMCIoqlv2grDX5IFBwqfv1JVSrc=;
        b=RHXhI14pbisZhjXSLqYkuRqIc3iSkzfpZRWqxm7edw/ET4XUowR0qtypvxkDihldM1
         LbENVH6DHXfYErLqmZJH61Ys+0CUGLJgb7UeFof6upiHJ268FbHR008wMB1wz0hwnP/u
         fU40Jw18WoFgGlIZYYF0dTdisyWeWHzRVyNXPXJNxXhL4ZnZ156IlrjknitWqPlltuWX
         tZcytZPHaI4d86fc9Nqd32MxTXjLsq3co08/UvIXim5bjPPfjHLZQh9G+/t18abKeQMA
         V2jBuik1f8CDfinWOAUBeXYDIdNw/XjdrS/0P+5w2H8LgjdGKW4VOhBXNd3muvWznn9X
         99DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243205; x=1794848005;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiFHI9sbs90EaOflLMCIoqlv2grDX5IFBwqfv1JVSrc=;
        b=qB1Vfg5oiAG9AoDKsX/Sysvyq3BaZ4ODqZjJHiWfUjwH3tN4nP7BPZo78ruispC+OQ
         Ye9pEuIIvb9QjdFo9ZvcZQojK1sHf9Go9OwnswVYYgmnYEZsK6Z5f6zmOzQdGBTLrlpF
         OjIMzI/XtoNADEQAXle6kQzWW9goKb+UcZ3yxG4qlFohb9/xi8uTUhjw5iEjLeh5Ib6y
         QyQkGJPrNi++mgsoG+thjoc6Roe/iWvac19mDDqADkqmfse1jrXcE9mF+uxHYMQ5j1lj
         7mPVTeQPQEBBbxXNgDjvRzykYVkog9yJIo258PyN9TYW+46csfCIHnUscWUjRZhe/WCQ
         icPQ==
X-Forwarded-Encrypted: i=1; AL+hErGzXi0ge2aDR3GE9R9VyMdjwGt3ObxMaglRD5ocJNpqRUGVXnYfPi+bseT1ExaOrbBicaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fFEEcT0j07MZ0YrehwrEpXc4CIqtjBwxycoNo3rfzStBOn+H3
	4RpqKSFGuwJUG28W9MLxq8R21ATM283xdmAwYCwwMuORtDoUF4l1ZFPJKyGwqP8GG0v4Gc/UXS4
	ZO6GHJL781PFHn62G/ra4KaXAzYLnhOs=
X-Gm-Gg: AYBFou3jTboj09JE8aNTz6f7MDiH65aNBhpXOwKDKP/5vVeGqLy0TFr+kGqAMI5IDhx
	bypnWwKm8TisoXidKRUnOmWa1f9c19PJFeimxio6tLh4Uo4yfZF0UxRPBX8uXTKiwIVP8qVhc1h
	Ciwq3whkibsmwrj/IBgfdFuPVruCinInxuitNLHwqCYIx8xN7HIsiW239dR4+eUlFpaps+UYi7p
	Xy6KsI6rshykw15Yp+vaPJER2Nu6o/MNz/XkrCC/d8uDdpRfNe7EeL4jTnoJrnSVZjsiQRqN/Cd
	OwgEUmBbin2Lk8XjffzGdGlNVOAuMqk4NBpz5jGsX85jrkjwXv7+tAUADqOfzj9vw9jqxgV+rCX
	BoycgfP0HRj081DpPtsv8GiyBMIGAwf/MxYoCln+AWJjISatIbBNGgbQyTSCH2iS/2bFOG/zhfr
	Q/DY+4
X-Received: by 2002:a05:6820:c3c7:b0:70b:980f:94cb with SMTP id
 006d021491bc7-7170f2b14demr1569860eaf.27.1794243205115; Mon, 09 Nov 2026
 08:53:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Joie Joie <soniqjjj@gmail.com>
Date: Mon, 9 Nov 2026 17:52:36 +0100
X-Gm-Features: AclHuK_W9l-Byoy2Eca7za7uZ2JEoK_jRXOrJxUZur_1zQx4e1UU7uZLwRV3GbQ
Message-ID: <CAH=d44ffiqADJH-kAsfrehutNny1ex+de_yJ=nJXbqrGwZ=kQw@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D_Internship_Proposal=3A_Reduce_Git=E2=80=99s_Glob?=
	=?UTF-8?Q?al_State_to_Enable_Its_Libification?=
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	Patrick Steinhardt <ps@pks.im>, Tanga Joris <tangajoris@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applicant:: Joy Gundu
Community: Git
Project: Reduce Git=E2=80=99s global state to enable its libification
Mentors: Usman Akinyemi and Christian Couder
Internship period: December 2026
Email:   soniqjjj@gmail.com
GitHub: https://github.com/Joiejoie1
Blog:https://joyg454090.substack.com/publish/post/224165227


1.  About Me
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hello everyone,

I'm Joy Gundu, a software Engineer and an ALX Software Engineering
alumnus. My academic background is in Mass Communications, but I
developed an interest in software development and gradually worked
towards building a career in technology.

Through my training and practical experience, I've worked with
different programming languages, development tools, and collaborative
workflows. I've also learned that writing code is only one part of
software development. Understanding how existing systems work, testing
changes, and making code easier to maintain are just as important.

I joined Git's Outreachy contribution period because I wanted to
challenge myself by working on a large C codebase and learn more about
how software works behind the scenes.

Since then, I've spent time reading Git's source code, tracing how
different parts of the project work together, investigating existing
implementations, and preparing patches. I'm still learning, especially
when it comes to systems programming, but I enjoy working through
unfamiliar problems and understanding them before making changes.

I hope to use this internship to become more confident working with C,
understand software architecture better, and contribute more
meaningfully to Git.

2.  Past Experience with Git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I've used Git throughout my software development journey, mostly for
tracking changes, managing branches, and collaborating with other
developers. Contributing to the project has given me a much better
appreciation of what happens behind those everyday commands.

The project to reduce Git's global state caught my attention because
it addresses an important part of software design: making a large
codebase easier to understand, maintain, and eventually reuse as a
library.

I'm interested in understanding how shared global data affects
different parts of a project and how moving suitable state into
structures with clearer ownership can make the code more modular.

I've also come to appreciate Git's community and its approach to
reviewing contributions. The mailing-list workflow was unfamiliar to
me at first, but I've learned a lot from seeing how contributors
discuss ideas, question implementations, and explain why one approach
might be better than another.

Some of the feedback I've received has changed how I approach
problems. I've learned that a patch needs more than working code. It
should have a clear reason for existing, preserve expected behavior,
and fit the project's broader direction.

That's what makes this experience valuable to me. I'm not just
learning how to make changes to Git; I'm learning how to think through
those changes and contribute responsibly to a mature open-source
project.

3. My Git Contributions and What I Have Learned
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

During the contribution period, I worked on several areas of Git's
codebase. My work included preparing patches, investigating existing
implementations, running tests, examining CI failures, and discussing
possible improvements with other contributors.

3.1 Working on pack-size configuration

One of my contributions involved the pack-size configuration area.

I looked into how the existing configuration was represented and how
it could be handled as part of the wider effort to reduce global
state. I prepared a patch series and spent time understanding the
relevant initialization and configuration tests.

As part of the work, I:

Examined how pack-size configuration values were defined and used.

Traced how the values were initialized.

Worked on the changes as a patch series.

Built Git and ran the relevant tests.

I tested the changes using:

t1300-config.sh =E2=80=94 518 tests passed.

t5300-pack-object.sh =E2=80=94 63 tests passed, with 2 skipped.

This work helped me understand why it's important to follow a
configuration value through the codebase instead of looking only at
where it is declared.

I also gained more experience preparing patch series, testing changes,
and working with Git's development workflow.

3.2 Zero-initializing repository configuration values

Another contribution I worked on was repo_config_values_init() in environme=
nt.c.

While reading the function, I noticed that several configuration
fields were being assigned zero or NULL individually. I thought the
initialization could be simplified by using memset() to initialize the
structure at once, while keeping the non-zero defaults separate.

My proposed change was:

memset(cfg, 0, sizeof(*cfg));

I submitted it as PR #2298 =E2=80=94 repo: zero-initialize configuration va=
lues.

I built Git using:

make -j2 NO_RUST=3DYesPlease NO_ICONV=3DYesPlease

I also ran the configuration test suite:

make NO_RUST=3DYesPlease NO_ICONV=3DYesPlease test T=3Dt1300-config.sh

All 531 tests passed, and the patch passed git diff --check and git
show --check.

The review process was particularly useful. Patrick Steinhardt
considered the patch correct and a good improvement. Junio C Hamano
then suggested that a C99 compound literal might be a better way to
initialize the structure.

That feedback made me think more carefully about the implementation. I
had focused on simplifying the existing assignments, but the
discussion helped me consider how the entire structure is overwritten
and whether the proposed approach follows the project's preferred
style.

It reminded me that passing tests is important, but so is choosing an
implementation that fits the codebase.

At the time of writing, the patch was still under review.

3.3 Learning from existing repository configuration migrations

I also spent time studying earlier changes that moved configuration
values into repo_config_values.

One example that helped me was the migration of askpass_program into
repository-specific configuration.

By following that change, I began to understand that moving a global
variable involves more than adding a new structure member. It's also
necessary to update every place that reads or modifies the value and
understand how it is initialized and cleaned up.

I looked at:

Where the original global variable was declared.

How the corresponding structure member was introduced.

Which parts of Git needed to be updated.

How the value was initialized.

How its lifetime and cleanup were handled.

This gave me a better understanding of why ownership matters when
reducing global state. Before moving a value, it's important to know
which repository or component should own it and how long that value
needs to exist.

3.4 Exploring Git's test infrastructure

I also spent time learning more about Git's test framework.

I experimented with a small example command and its tests in
t9999-psuh.sh. The test passed locally.

Although this was exploratory work rather than a merged contribution,
it helped me become more comfortable writing and running Git tests and
understanding how command behavior is verified.

It also reinforced the importance of testing changes rather than
relying only on whether the code builds.

3.5 Investigating CI and build-related issues

Another area I explored was Git's CI setup.

I investigated an issue involving the replacement of the dirname
symlink in Git's dependency installation script. The proposed change
was to use sudo when replacing the symlink:

sudo ln -sfT /usr/bin/gnudirname /usr/bin/dirname

This gave me some experience looking into how permissions and
differences between CI environments can affect builds and tests.

I also became more comfortable reading CI logs and checking whether a
failure was related to my changes or to something happening in the
testing environment.

3.6 Studying the object database refactoring

As I became more familiar with Git's internal structure, I started
looking into the object database refactoring, particularly the changes
around odb/source-files and fast-import.

While reading builtin/fast-import.c, I noticed that store_object() and
stream_blob() still traverse the files backend directly when checking
whether an object already exists in a pack.

I wondered whether the existing repo_for_each_pack() helper could be
used instead. Before making any changes, I discussed the idea with
Patrick Steinhardt.

His response helped me understand why that would not be the right
solution. Although the helper hides the directory traversal, it still
assumes that the object database backend uses packfiles. The
longer-term direction for fast-import is to use transactions, which
would avoid that dependency. Patrick also mentioned that Karthik had
already started looking into this work.

I decided not to pursue the iterator replacement.

This was a useful learning experience because it showed me that a
change can make code look cleaner without actually solving the
underlying architectural problem. It also taught me to check the
project's direction and coordinate with other contributors before
taking on related work.

4. My Understanding of the Internship Project
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

From my experience so far, I understand that the goal of this project
is to reduce Git's reliance on global state and make its internal
components more modular so that Git can eventually be used as a
library.

Git has grown over many years, and some parts of its implementation
rely on global variables and shared state. This can make it difficult
to isolate repository-specific behavior and reuse individual
components independently.

The ongoing work involves moving suitable state into structures with
clearer ownership, particularly repository-specific structures.

I've learned that this isn't simply a matter of replacing global
variables with structure members. Before making such a change, it's
important to understand:

Who owns the value.

Whether it belongs to a particular repository.

Where it is initialized and accessed.

Which other parts of Git depend on it.

How its lifetime and cleanup are managed.

Whether existing behavior will remain unchanged.

My work on repository configuration initialization and my
investigation of existing migrations have helped me appreciate these
challenges.

I'd like to build on that experience by taking on more of this work
and learning how to identify changes that genuinely improve Git's
architecture.

5. Proposed Technical Work
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

During the internship, I would like to continue investigating suitable
areas where global state can be reduced safely.

I don't want to move variables simply because they are global. I'd
first like to understand what each value does, which parts of Git
depend on it, and whether moving it would make the code easier to
maintain.

5.1 Follow through on repository configuration initialization

My first priority would be to address the feedback on PR #2298.

In particular, I would investigate Junio's suggestion to use a C99
compound literal:

*cfg =3D (struct repo_config_values) {
    /* non-zero defaults */
};

I would compare this with the existing implementation, make sure all
fields receive the intended values, and check that the existing
defaults and behavior are preserved.

I would then work through the review comments and submit any necessary
revisions.

5.2 Investigate other opportunities to reduce global state

After that, I'd like to identify other suitable candidates for migration.

For each one, I would:

Find where the variable is declared and used.

Trace where its value is initialized and modified.

Identify which parts of Git depend on it.

Determine whether it belongs in a repository-specific structure or
another appropriate owner.

Study similar migrations that have already been completed.

Discuss the proposed approach with my mentors before implementing it.

I would focus on changes that offer a real improvement without making
the code unnecessarily complicated.

5.3 Pay attention to testing

Testing would be part of each change, not something I leave until the end.

I'd start by understanding the existing test coverage, run the
relevant tests, and add focused regression tests where necessary.

I'd particularly want to check that moving state does not introduce
unexpected behavior between repositories or create problems with
initialization and cleanup.

5.4 Coordinate with related refactoring work

I also want to keep learning about the other changes happening around
Git's architecture, especially the object database work.

My investigation of fast-import showed me that different parts of the
refactoring can be closely connected. Before working on an area that
overlaps with another contributor's work, I'd check the relevant
discussions and coordinate with them.

If an idea doesn't fit the direction of the project, I'd rather
understand why and look for a more useful task.

6. How I Plan to Approach the Work
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
I want to work in small steps and make sure I understand each change
before submitting it.

First, understand the existing code.

I'll read the relevant source files, trace references, look at
existing tests, and review previous changes. I want to know why
something works the way it does before deciding how it should change.

Discuss the approach.

If I'm unsure about ownership, initialization, or the wider impact of
a change, I'll explain what I've found and ask for feedback before
going too far with the implementation.

Keep changes focused.

I'll avoid unrelated modifications and try to make each patch address
one clear problem.

Build and test.

I'll build Git, run the relevant test suites, check the diff, and add
regression tests where needed.

Learn from review.

I'll submit patches through the mailing list, respond to comments, and
make revisions based on feedback.

My experience with PR #2298 has shown me that review can improve not
only the code but also how I explain the reason behind a change. I
want to keep developing that skill throughout the internship.

7. Risks and Alternative Approaches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

One challenge I expect is determining where a particular piece of
state should belong.

A variable might look repository-specific at first, but other parts of
Git may use it before a repository is initialized or in situations
involving multiple repositories.

Moving it without understanding those dependencies could cause regressions.

Initialization and cleanup are also important. A migration needs to
preserve the correct defaults and make sure resources are managed
properly.

Another thing I've learned is that removing a global variable doesn't
automatically make the code better. Sometimes the existing approach
may be appropriate, or a broader architectural change may be needed.

I'd handle these situations by tracing dependencies, studying existing
implementations, discussing my ideas with my mentors, and making
changes gradually.

If a proposed change doesn't provide a clear benefit, I'd be willing
to reconsider it and investigate another area.

8. Proposed 13-Week Internship Timeline
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is an initial plan. I'd be happy to adjust it with my mentors
based on the project's priorities and how the work progresses.

Period

Proposed work

Weeks 1=E2=80=932

Review the current refactoring work, revisit repository configuration
changes, and agree on the first task with my mentors.

Weeks 3=E2=80=934

Address the review feedback on PR #2298 and investigate another
suitable candidate for migration.

Weeks 5=E2=80=936

Trace the selected candidate's dependencies, ownership,
initialization, and cleanup requirements. Discuss the design and begin
implementation.

Weeks 7=E2=80=938

Complete the first agreed change, run the relevant tests, add
regression coverage where necessary, and submit the patch for review.

Weeks 9=E2=80=9310

Work through review feedback and investigate another suitable area
while the first patch is being reviewed.

Weeks 11=E2=80=9312

Continue with another agreed improvement where appropriate, run tests,
and address outstanding review comments.

Week 13

Complete final revisions, document the work and any remaining issues,
and prepare the internship report.

I understand that upstream review can take time and that some changes
may need several revisions. I'll remain flexible and use time between
reviews to investigate other areas or improve my understanding of the
codebase.

My main goal is to complete at least one meaningful improvement that
is well tested and submitted for upstream review. If there is time for
additional work, I'll be happy to take that on as well.

9. Communication Plan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

One thing I've come to appreciate about Git is how much the community
values technical discussion and review.

During the internship, I'll continue using the Git mailing list to
discuss ideas, submit patches, and respond to reviews. I'll also
maintain regular communication with my mentors.

I'd like to provide weekly progress updates covering:

What I've worked on.

What I've completed.

Which patches are waiting for review.

Any problems or questions I've encountered.

What I plan to work on next.

When I need help, I'll explain what I've already investigated and ask
specific questions so that discussions can be more productive.

I'll also continue reading other contributors' patches and testing
changes where I can be useful.

I've learned that contributing to open source involves more than
writing code. Listening, asking questions, explaining decisions, and
learning from other people's work are all part of being a good
contributor.

10. Availability
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I expect to be available throughout the official internship period.

Weekly availability: [Insert your confirmed number of hours per week.]

If anything changes, I'll communicate it early and work with my
mentors to adjust my plans.

11. What I Hope to Achieve
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

By the end of the internship, I hope to have made useful contributions
to Git's effort to reduce global state.

I'd like to:

Follow through on the review and revisions of my repository configuration p=
atch.

Contribute at least one additional improvement agreed upon with my mentors.

Add or improve tests where necessary to protect existing behavior.

Understand repository-specific state, ownership, initialization, and
cleanup more deeply.

Become more confident navigating Git's C codebase and investigating
dependencies between components.

Improve how I prepare patches, explain technical decisions, and
respond to review feedback.

I know that the number of variables moved or patches submitted isn't
the most important measure of success. What matters is whether the
changes are useful, well understood, and consistent with the project's
direction.

I'd rather make a small change that solves a real problem than a
larger change that introduces unnecessary complexity.

12. Beyond Outreachy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

I don't want my involvement with Git to end when Outreachy does.

Working on the project has shown me how much there is to learn from
contributing to a mature open-source codebase. I've also come to
appreciate how much contributors can learn from thoughtful reviews and
technical discussions.

I'd like to keep following Git's development, contribute to suitable
issues, submit patches, and gradually take on more challenging work as
I gain experience.

As I become more confident, I'd also like to help other newcomers who
may find the contribution process unfamiliar, just as members of the
Git community have helped me.

For me, this experience is more than an opportunity to complete an
internship. It's a chance to become a better developer and build a
lasting place in the open-source community.

13. References
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My Git work

PR #2298 =E2=80=94 repo: zero-initialize configuration values
https://github.com/gitgitgadget/git/pull/2298

PR #2298 mailing-list discussion
https://lore.kernel.org/git/pull.2298.git.1793966368860.gitgitgadget@gmail.=
com/

Pack-size configuration patch series =E2=80=94 PR #2271
https://github.com/gitgitgadget/git/pull/2271

CI change =E2=80=94 ci: use sudo when replacing dirname symlink
Commit: 2ea93d3163

Exploratory test work =E2=80=94 psuh example command
Commit: 1ce5f1055f

Relevant Git resources

Git source code:
https://github.com/git/git

Git General Application Information:
https://git.github.io/General-Application-Information/

Git mailing-list discussions:
https://lore.kernel.org/git/

Relevant source files:

environment.c

environment.h

Repository configuration structures

builtin/fast-import.c

Object database implementation files

I would appreciate feedback from the Git community on the proposed
direction, possible areas to investigate, and where I could make the
most useful contribution during the internship.

Thank you for the guidance and feedback I've received throughout the
contribution period.

Best regards,
Joy Gundu
