Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794201710;
	b=lUw3WspEtNoYTbbJb7uQPyJ2tw430NMTZOTmmoo5EqBfr0sKqN7pAExXgx7G/tSFQQ9t
	 D9or/D5rTLpd5Fh33OFd/L6jOs1+IlbGaMjF3yTomZ33tAnojUCitROt73avn7734D8py
	 c20/QJWN8dzWciOFek6j+vLeSJPhldj6B1H81qhjs6tgKBHIVXPUvbmWyyBdvW/7jcq8Z
	 k3ome+09xX3WqMnD8JStj/kEEKAy+gDMR0eWhhybEJ4QfJYv9Mm6apbsTAczq9eBcmW+l
	 Kc4lBSvMkS2hw0i0j3KKKa7xzR0utgtuHWvQiss5WU1mZbheC6FkRvxtA2ZbmWmj2zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k56AVH1usCNDPketO6zsuYNf/1YFxwBFPRFOP2T+Z18=;
	b=uYQDVk2CqJqwXtH7yj6gAQH1tGt3m8Q39281lYPbgJXwDctf/d7X7OhE5Py5XPEk1SbJ
	 Q/UQIBGDSl5hN6Ms12agTHlkQvUoyAWPEzyY1qAejQTlIDwIDBaLpjmoL6n5b/Opj3JCH
	 RDi8NlQIK9NnleGAv1EPrnR6wAm7Y/JjclnLE0HLsKwq77Ed3Mx89xvL8abnlp/7ynYWo
	 C0JOnlDBTVzbVJVBxWYuvuz3qL7x0JtDVHbHcC+nUBufOGBIb0OEFkg9DPn5a9zaV2poz
	 MEKg7TvmpHwx88KSWg2v4a1+e2I1j+c+1wd3Frm+2+IVXP51euTOF46dZ6/y9aYvMKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOZLwNgk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C1606A323
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 05:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83C1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOZLwNgk
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b3402105b9so2580747b3.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 21:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794201709; cv=none;
        d=google.com; s=arc-20260327;
        b=TvJ13IykCL85/+XV4d1/3hRZHKaPrWrAvu6mFXq6lPhvbe0+IddNoQccHnnWfg5F4g
         kifjkf9yue7UhtyC8hV16dyOAAvS+ukGpTv/FVXakd3mTOOUqLI6ViASMLvRYHKymzPe
         sryR90U2IzvtN43nos7VukUiREUlEGa1//HOJe1dZijVgTGfnrfXVmNOM5XEenA/6WQX
         NygZf4fXzYFQmS2S1inhxxgaxvRDBwRQ90hxzWbrLYv2mHYMpYifMk/vK0EkyDbWRC1l
         AbMbKeCGOZoUYStEenHBWPjWAGPwHKgFc65ir/Aki7pxiAyi/vawO0iK3afa+8wm6Hwy
         Uf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=k56AVH1usCNDPketO6zsuYNf/1YFxwBFPRFOP2T+Z18=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=qKQY/4dHt/w98ohbcNUQt1dS9QfR2BcHuodTOiQipZh3PHv2uvoOcZ3562QONGRhEQ
         TZjNYJwpPFIFJhfDZhINc3MB+lLR2HAeyJllJfFZDox0ve5bsOma7g7zVOZdu+jAwxH5
         W1B0FIOruKaj8IJGnSff0ISu4VdTsGDAYF6AmGIzi0KcZXmbILMoDqadgCdpaUKle6EQ
         3Cw10Ya3z4I506kcyr+b5CG0u6HE9rI3LwNDaTmCleCcKVPm4+J0nJGGmx7b+t7jDdbs
         uMiFRXR7F/7fjn95Kx7JOHJCWD7ad4yitNc01aS/IKrDrBRdlC4aazYOBE5sGzaeaKEV
         JRIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201709; x=1794806509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k56AVH1usCNDPketO6zsuYNf/1YFxwBFPRFOP2T+Z18=;
        b=kOZLwNgkcOgZMAZ4j/HkP4BrwomGXJJfd/DSG2zflW8FULWhEeR7WYfhPLWUwrJVrY
         BEQXYy0IhN4VWTjOeLR61KBJHbSPkAIBXaDfd6yi+dr0bE2c7g+TA/N0uCqv4xgEvQrb
         FhVXvQiVTHFzTDJ8rx0INO14pCoyBIq13xZAj16iU6ZN7T3HLs7ow7oEBGQMBwsu2NMz
         9oYc+87SQOOa84ew46eaw6P//Y/haeu5bdSCb5mw1RFjo5x8gu2maiVaWW/lABouelT0
         QsgX3a+HIU+Jkamd1Fa9UtrIokrpI2XqY07rtFTDr1elz1uroRooKngkaGG6C1+TymSL
         oGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201709; x=1794806509;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k56AVH1usCNDPketO6zsuYNf/1YFxwBFPRFOP2T+Z18=;
        b=gKPb7zeBAmOUScXQQIo/7e4FAAEexjW2CDUzrzn9OkESTqwJbj4TtmQvgTPFQ2+S/i
         ydz3ZXiBYCqaYAyR4Uxl0ak06r6m0VmB7EKPSL8SJ6DMS8c0/PDj9kQ51AK5Iw4SNFl3
         AiLHeb+bNaa3vIKYj8OYy8Y9HX0KLOKiGl9RTXPSHCGVmPnAXDsCzh/kPAicCGRuZqB9
         PDDajv8iXBToX7UfoqUaSkjTSS9LLIPQVyJQx45ajYofBNwZUSCiWoKl1k2Q7ok52+nB
         5iVCr1aKx5Au2ujb9BqUrhNlJdgxTDaFzdp5Sz0yO6quxX12vjsp79zBCz3q0AqEX/GJ
         muvQ==
X-Gm-Message-State: APuU4Z9n7DI1mrNzR0bbmMLpZCFDGPepXGLsNm9XbrIjj9aArlleCzU7
	+thU9wGN2NuWdDD9wo79NA1nwAAh4Ed09m8HEUXQy18lsaDSOgyKA9v0nZ6GR7j3yYRNpyOOobx
	k07vv69gEkkIa/e3n8fxg4JfDPBtHuOGb2PQ=
X-Gm-Gg: AYBFou1iPbEY58Dvl8zjBpNS9A99iKXyqhr9b+yL6iQ96WIcd3dzsA8x4qZ80yqVRwL
	pOaV9O8yDD+sCTv5bRs49mS+cwgGvtFwiHl/irf3Ec12LMi3aydLc8JuWSAATZbnaoXvJWM1UN7
	8OCbwVxu3pcRBMm2gDZpoIe6GYeu0QaVdJdUO3m4q+ipbtkmVKYkH6sDnrk5Bw/WrjOsLH8jz5R
	hg+DcgGqX7RdGNiHMNUb+gfPh19HAf1xoovxPwwHC6MIENaWgOAi3dLo2mslCS7k5M3eAKT5UfR
	Y895RgO+5Gp9qymVCu6+7qHXUK1xRk7m7aEn4TE5O9EmU1PSs0PoVStvQHo+6B6TXZ/UubXcVOg
	itMJQIQizHy44Cu6QtFvAMxOu3u4yM3X4zA==
X-Received: by 2002:a05:690c:f90:b0:8b3:25ea:62c9 with SMTP id
 00721157ae682-8b36cbcad03mr16055957b3.90.1794201708083; Sun, 08 Nov 2026
 21:21:48 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Fien Dora <fiendora5@gmail.com>
Date: Mon, 9 Nov 2026 06:21:36 +0100
X-Gm-Features: AclHuK9ySCjKquYVkEUOQgieXLTiPw91lcNAIJLpCBcQiq1VxbA0PWL6SOcehe4
Message-ID: <CACWAS-UqbkgfzsJ2283=OgoUHRs-FeRNYc0zkBR2y0XD4jTWsw@mail.gmail.com>
Subject: [Outreachy] Draft internship proposal: Improve how command arguments
 and options are scanned and parsed
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applicant: Fien Dora
Community: Git
Project: Improve how command arguments and options are scanned and parsed
Mentors: Christian Couder and Siddharth Asthana
Internship period: December 7, 2026 =E2=80=93 March 8, 2027
1. About Me
Hello everyone,
I'm Fien Dora, a Computer Engineer with an interest in C programming,
systems programming, and understanding how things work in the
background.
I've always enjoyed mathematics and solving problems. I=E2=80=99ve always b=
een
curious about compilers, and what happens when a command is sent. That
curiosity pushed me to start learning programming. In 2023, I joined
the ALX learning program, where I was introduced to C, shell
scripting, and systems programming. Of everything I was learning, C
caught my attention the most.
I liked that C helped me understand what was happening closer to the
computer itself like compilers, interpreters, memory, and how software
communicates with hardware.
I am still growing as a C programmer, especially when it comes to
understanding large codebases, but I enjoy taking time to understand a
problem and working through it until things become clearer.
That is one of the reasons I was drawn to Git's Outreachy project.
Availability: 30 hours per week from 7 December 2026 to 8 March 2027.
2. Why Git and Outreachy?
To me, Git is the reason behind successful software development. I
usually use Git mainly as a tool for tracking changes or versions,
working with branches, and collaborating with other developers.
The project on argument-parsing was particularly interesting to me
because It combines my interest in C and systems programming with the
opportunity to understand and improve software that many developers
depend on.
Another thing I have come to appreciate about Git is its community.
During this contribution period, it was very strange to me that the
git community was a mailing list but I discovered how much attention
Git contributors give to reviewing changes. Reviewers do not simply
tell you that something is wrong. They explain why it is a problem and
suggest a better way to approach it, which was very amazing.
I experienced this during my first contribution, when Junio reviewed
my patch and pointed out weaknesses in how I explained its purpose.
His feedback helped me understand that a patch should not only work;
it should also have a clear reason for existing.
I also learned Git's mailing-list conventions through that process.
I value this experience as I learn from experienced developers while
contributing to a real project, rather than learning programming
concepts only through exercises.
I have also been encouraged by previous Outreachy interns who have
contributed to Git's internal code and testing infrastructure. Their
experiences show that meaningful contributions can begin with small,
carefully understood changes.
I look forward to this internship to help me become more confident
working with C and participating in open-source development.
Most importantly, I want to continue contributing to open source after
Outreachy.
3. My Git Contributions and What I Have Learned
3.1 My first contribution: git check-ref-format
Patch: t1402: test --no-allow-onelevel option precedence
Discussion: https://lore.kernel.org/git/20261029121715.3845-1-fiendora5@gma=
il.com/
Commit: 0110f33aa8
Status: Queued by Junio and integrated into Git's next branch during
the contribution period.
For my microproject, I worked on the tests for git check-ref-format.
While reading its code, I learned that it uses a manually written loop
to handle some command-line options instead of the shared
parse_options() API.
I focused on two options: --allow-onelevel and --no-allow-onelevel.
These options determine whether Git accepts a refname containing only
one component. When both options are supplied, the last one determines
the result.
I added two tests to t/t1402-check-ref-format.sh to protect that
behavior in both argument orders.
The code change itself was small, but getting the patch ready for
review taught me a lot.
My first commit message explained what the tests did, but Junio
pointed out that it did not sufficiently explain why those tests were
useful.
He helped me see that check-ref-format was worth testing specifically
because it used a handcrafted parser and its behavior could matter
during future parsing changes.
In another review, he questioned a statement I made about a planned
conversion. I had described possible future work as though it had
already been decided.
That was an important lesson: I should distinguish between something
that already exists, something another contributor is doing, and
something I am only proposing.
I revised the patch explanation, and the contribution went through
three versions.
Junio eventually replied that the changes were well explained and
would be queued.
I also learned about Git's email conventions, including replying below
relevant quoted text and keeping quotes short enough for others to
follow a discussion.
Looking back, the most valuable part of this contribution was not just
having a patch accepted. It was learning how to explain my reasoning,
respond to feedback, and improve my work through review.
3. My Git Contribution Experience
3.1 First microproject: Testing option precedence in git check-ref-format
Patch: t1402: test --no-allow-onelevel option precedence
Mailing-list discussion:
https://lore.kernel.org/git/20261029121715.3845-1-fiendora5@gmail.com/
Commit: 0110f33aa8
My first contribution involved investigating the behavior of two
conflicting options in git check-ref-format:
=E2=80=A2 --allow-onelevel
=E2=80=A2 --no-allow-onelevel
These options control whether a refname with only one component is accepted=
.
I examined the existing implementation and test coverage and added two
regression tests to t/t1402-check-ref-format.sh.
The tests verify that when both options are supplied, the last one
determines the effective behavior, regardless of their order.
After building Git locally and running the relevant tests, I submitted
the signed-off patch to the Git mailing list.
The contribution went through three versions following feedback from
Junio C Hamano.
One of the most important things I learned was that a patch should
explain not only what a change does, but also why the change is
useful.
Junio's feedback helped me recognize weaknesses in my initial
explanation, particularly where I made assumptions about possible
future parser changes.
I revised the commit message to explain the reason for protecting the
existing behavior more accurately.
After reviewing the revised patch, Junio indicated that it was well
explained and would be queued. The contribution subsequently reached
Git's next integration branch.
The review process was especially valuable to me. It showed me how
much thought goes into even a small contribution and encouraged me to
become more careful with technical explanations, assumptions, and
tests.
3.2 Independent testing of another contributor's check-ref-format conversio=
n
After my first contribution, I intended for a follow up contribution
of git check-ref-format conversion and how it behaves when its manual
argument parsing were replaced with Git's shared parse_options() API.
I studied a conversion proposed by fellow contributor Hussain Sitamouwala.
I checked out the proposed changes locally, built Git, and ran the
relevant test suites.
In that testing environment:
=E2=80=A2 All 107 tests in t1402-check-ref-format.sh passed.
=E2=80=A2 All 96 tests in t0040-parse-options.sh passed.
I also manually tested cases involving option precedence, repeated
options, abbreviated names, unsupported option forms, and the --
separator.
I did not identify unexpected regressions in the cases tested.
This was an independent testing exercise, not a patch I authored or a
formal review submitted to the mailing list.
It helped me understand that changing a command's parser requires
examining more than its normal use cases. Even when existing
functionality continues working, a new parser may recognize additional
argument forms or produce different errors.
This reinforced the importance of understanding existing behavior
before implementing a conversion.
3.3 Studying early_scan_options() and git fast-import
I also studied Christian Couder's early_scan_options() series and
examined how the API is used in fast-import.
This helped me understand why certain commands need to inspect
particular options before normal argument parsing begins.
I learned about PARSE_OPT_EARLY and how early scanning can help
commands process options that influence configuration or
initialization.
Studying this implementation led me to investigate another possible
use of the API.
3.4 Investigating git column
While examining other built-in commands, I noticed that
builtin/column.c manually checks for --command=3D before invoking
parse_options().
I studied the implementation and tested several argument forms,
including attached values, separate values, abbreviated option names,
option ordering, and repeated options.
The investigation raised a compatibility question: should replacing
the manual check with early_scan_options() preserve the current
restrictions or accept additional forms recognized by the shared
parser?
I prepared a technical proposal explaining the findings and requesting feed=
back.
Discussion:
https://gitlist.dev/t/66794
I also became aware that another Outreachy applicant had identified
git column as a potential future conversion target.
Because Git development is collaborative, I believe coordinating
related work is important. I therefore consider this an investigated
candidate rather than an implementation task already assigned to me.
3.5 Investigating other Git commands
To understand the broader project, I searched Git's built-in C
commands for manual argument-processing code.
My initial searches identified several candidates, including git hook,
git ls-remote, git name-rev, git archive, git hash-object, and git
diff-index.
After examining their implementations, I learned that not every loop
over argv represents manual option parsing.
For example, git ls-remote already uses parse_options() and processes
ref patterns afterward. Similarly, git name-rev processes object
names, while git hash-object processes filenames after option parsing.
These investigations taught me to distinguish normal argument
processing from code that might genuinely benefit from a shared
parsing API.
A conversion should address a meaningful problem rather than simply
replace existing code.
This process eventually led me to git diff-index, which I would like
to explore as an initial internship candidate.
4. Understanding of the Internship Project
Git provides shared parsing APIs, including parse_options() and
early_scan_options().
However, some built-in commands still use manually written code to
recognize and process command-line options.
These implementations can sometimes duplicate functionality, create
inconsistent behavior, or make future maintenance more difficult.
I understand the goal of this project as identifying suitable
opportunities to replace manual parsing with shared APIs while
preserving the command's expected behavior.
A successful conversion involves more than replacing string comparisons.
It requires understanding the existing command, identifying why the
change would be useful, studying how other parsing mechanisms interact
with it, and establishing regression tests.
I would like to approach the work incrementally, beginning with an
investigated candidate and expanding to additional suitable tasks with
mentor guidance.
5. Proposed Technical Work
During the contribution period, I investigated how Git commands
process their arguments and identified two possible areas for further
work: git diff-index and git diff-tree.
Both commands use setup_revisions() to process common revision and
diff arguments before handling some command-specific options manually.
I would like to investigate whether these remaining options could be
handled through Git's shared parse_options() API, provided the change
improves maintainability without affecting existing behavior.
5.1 Primary candidate: git diff-index
File: builtin/diff-index.c
git diff-index uses setup_revisions() to process revision-related and
common diff arguments. It then manually handles three command-specific
options:
argc =3D setup_revisions(argc, argv, &rev, NULL);

for (i =3D 1; i < argc; i++) {
    const char *arg =3D argv[i];

    if (!strcmp(arg, "--cached"))
        option |=3D DIFF_INDEX_CACHED;
    else if (!strcmp(arg, "--merge-base"))
        option |=3D DIFF_INDEX_MERGE_BASE;
    else if (!strcmp(arg, "-m"))
        rev.match_missing =3D 1;
    else
        usage(diff_cache_usage);
}
The options are --cached, --merge-base, and -m.
I examined this loop and the relevant parts of setup_revisions() in
revision.c. I found that setup_revisions() processes shared arguments
while preserving certain unrecognized options for the calling command.
Another detail is that git diff-index calls
diff_merges_suppress_m_parsing() before setup_revisions(). This
prevents the common diff-merges parser from interpreting -m, allowing
diff-index to preserve its command-specific meaning.
Why investigate this code?
The command has a small manual parser that may benefit from Git's
shared parsing infrastructure. However, its interaction with
setup_revisions() means a conversion is not as simple as replacing the
string comparisons with a struct option array.
A useful conversion should reduce command-specific parsing code
without making the implementation more complicated or changing
established behavior.
Proposed approach
I would:
1. Document how the three options are preserved and handled after
setup_revisions().
2. Examine how diff_merges_suppress_m_parsing() protects the meaning of -m.
3. Establish the existing behavior of option ordering, repeated
options, invalid arguments, and pathspecs.
4. Compare this behavior with a possible parse_options() implementation.
5. Discuss compatibility concerns and the proposed design with my mentors.
6. Implement a focused conversion if the shared API provides a clear benefi=
t.
Testing
I have already examined relevant tests in:
=E2=80=A2 t/t4002-diff-basic.sh
=E2=80=A2 t/t4013-diff-various.sh
=E2=80=A2 t/t4068-diff-symmetric-merge-base.sh
One interesting finding was that t4068 runs several --merge-base tests
against both git diff and git diff-index using a shared test loop.
My initial search missed this coverage because the test script used a
variable instead of writing the command name directly.
I would use the existing tests as a baseline and add focused
regression tests only where they protect important behavior or address
identified gaps.
Expected deliverable
If the design is appropriate, I would prepare a small, tested patch
series improving the command-specific parsing in git diff-index and
submit it for upstream review.
If a conversion introduces unnecessary complexity, I would discuss an
alternative approach or another suitable candidate with my mentors.
5.2 Secondary candidate: git diff-tree
File: builtin/diff-tree.c
I also investigated git diff-tree, which uses setup_revisions() before
manually handling two command-specific options: --stdin and
--merge-base.
Its implementation contains the following loop:
while (--argc > 0) {
    const char *arg =3D *++argv;

    if (!strcmp(arg, "--stdin")) {
        read_stdin =3D 1;
        continue;
    }
    if (!strcmp(arg, "--merge-base")) {
        merge_base =3D 1;
        continue;
    }
    usage(diff_tree_usage);
}
While examining this code, I discovered that the manual parser is
deliberately connected to Git's revision-processing infrastructure.
Before calling setup_revisions(), git diff-tree sets disable_stdin =3D
1. I traced this into revision.c and found that it causes
setup_revisions() to preserve --stdin for the command instead of
processing it through the revision parser.
I also examined how handle_revision_opt() uses diff_opt_parse() and
overwrite_argv() to preserve unrecognized options. At the end of
setup_revisions(), Git returns the remaining argument count and
terminates the argument list with NULL.
This helped me understand how diff-tree receives its command-specific
options after revision processing.
Behavior verified during my investigation
I tested the command using my locally built Git executable and confirmed th=
at:
=E2=80=A2 --stdin and --merge-base cannot be used together.
=E2=80=A2 --merge-base requires exactly two commits.
=E2=80=A2 The abbreviated option --stdi is rejected rather than accepted as=
 --stdin.
These behaviors are important because a shared parser may recognize
argument forms that the current manual parser rejects.
Existing tests
I also investigated the regression tests and found that:
=E2=80=A2 t4002 tests normal diff-tree --stdin behavior.
=E2=80=A2 t4013 tests --stdin with log formatting and pathspecs.
=E2=80=A2 t4068 tests the failure of diff-tree --merge-base when only one
commit is supplied.
=E2=80=A2 Other test scripts exercise --stdin in different workflows.
My searches did not identify a direct diff-tree test for combining
--stdin and --merge-base, although I would verify the full coverage
before proposing a new test.
Why investigate this code?
The manual loop is small, but my investigation showed that it serves a
deliberate purpose.
The question is whether parse_options() can replace the final
recognition of --stdin and --merge-base while preserving their handoff
from setup_revisions() and the command's existing restrictions.
Proposed approach
I would:
1. Keep setup_revisions() responsible for common revision and diff argument=
s.
2. Evaluate whether parse_options() can safely process the remaining
command-specific arguments.
3. Compare the current behavior with possible shared-parser option
definitions and flags.
4. Preserve the existing restrictions involving --stdin, --merge-base,
revisions, and pathspecs.
5. Use existing tests and add regression coverage where a meaningful
gap is established.
6. Discuss whether the conversion improves maintainability before
implementing it.
If the conversion proves worthwhile, I would prepare a focused patch
series for review.
Otherwise, I would document the findings and consider a different candidate=
.
5.3 Additional parsing improvements
I understand that identifying suitable conversion targets is part of
the internship project.
From my earlier investigations of commands such as git hook, git
ls-remote, git name-rev, git archive, and git hash-object, I learned
that not every loop over argv represents unnecessary manual option
parsing.
I would therefore continue looking for candidates where using a shared
API could solve a genuine correctness, consistency, or maintainability
problem.
Before selecting a task, I would check whether the code actually
parses options, what behavior needs to be preserved, whether tests
already exist, and whether another contributor is working on the same
area.
I would discuss promising candidates with Christian and Siddharth
before beginning implementation.
6. How I Plan to Approach the Work
I plan to work in small, reviewable steps.
Understand the problem first. I would read the relevant source code,
documentation, tests, and previous discussions. Before changing a
parser, I want to understand what it currently does and why the change
would help.
Discuss the design. I would compare the existing implementation with
the appropriate shared API, consider alternative approaches, and raise
compatibility questions with my mentors before making substantial
changes.
Test what matters. I would reuse existing tests where possible and add
focused tests to protect important behavior. If fixing a demonstrated
bug, I would aim to write a test that fails before the fix and passes
afterward.
Implement the smallest useful change. I would avoid unrelated changes
and preserve command-specific checks that remain necessary even after
a parser conversion.
Work through review. I would build Git, run the relevant tests, submit
patches to the mailing list, and revise them based on feedback.
My first contribution taught me that a good commit message should
explain why a change is useful, not only what code was modified.
7. Risks and Alternative Approaches
The main technical risk is the interaction between setup_revisions()
and parse_options().
Both git diff-index and git diff-tree rely on revision-processing
infrastructure, so a conversion could unintentionally change how Git
interprets options, revisions, or pathspecs.
For diff-index, the command-specific meaning of -m must remain
protected. For diff-tree, the handling of --stdin and its restrictions
must be preserved.
Another risk is changing accepted command-line syntax. For example,
parse_options() may recognize abbreviated or negated options that the
existing manual parser rejects.
I would address these risks by establishing current behavior,
comparing alternative designs, and testing the proposed
implementation.
A manual parser may also be appropriate for its command. If using the
shared API creates more complexity than it removes, I would discuss
retaining the existing implementation or selecting another candidate.
I would also follow upstream discussions to avoid duplicating another
contributor's work.
Finally, I would leave enough time for reviews and revisions, since a
patch is not complete simply because it passes tests locally.
8. Proposed 13-Week Internship Timeline
This is my proposed timeline, which I expect to refine with Christian
and Siddharth based on project priorities and technical findings.
Week Proposed work and milestone
1 Review current parsing APIs and related upstream work. Confirm the
first implementation target and expected outcome with mentors.
2 Complete the design evaluation for diff-index, establish baseline
tests, and discuss compatibility concerns.
3 Begin implementing the first agreed improvement and add focused
regression tests where needed.
4 Validate the implementation and submit the first patch series for review.
5 Respond to feedback, refine the code and tests, and submit revisions.
6 Continue review and integration work while beginning research on
another suitable candidate.
7 Evaluate diff-tree or another mentor-approved target, including its
technical benefits and compatibility requirements.
8 Finalize the second task's design and establish relevant test coverage.
9 Implement and test the second agreed improvement, if appropriate.
10 Submit the next patch series and begin addressing reviewer feedback.
11 Continue revisions and investigate smaller follow-up improvements
where time permits.
12 Resolve outstanding feedback, verify relevant tests, and update
documentation where needed.
13 Complete the final technical summary, document remaining work, and
prepare the internship report.
These stages are flexible. Git's review process may require several
iterations, so implementation and review activities may overlap.
For example, while waiting for feedback on one patch, I could
investigate another candidate or improve relevant tests.
I would provide weekly progress updates and aim for clear technical
checkpoints at least every two weeks.
Minimum intended outcome: Complete at least one technically justified
parsing improvement through implementation, testing, and upstream
review, subject to mentor agreement.
Further goal: Contribute additional reviewed improvements if time and
technical findings permit.
9. Communication Plan
One thing I particularly appreciate about Git is its review culture.
My first contribution showed me that reviews are not only about
correcting mistakes. They also help contributors understand the
reasons behind technical decisions.
During the internship, I intend to communicate primarily through the
Git mailing list, where I would ask technical questions, submit
patches, and participate in review discussions.
I will provide weekly written progress updates, preferably through a
blog as Christian recommends, and maintain regular communication with
Siddharth.
My updates will explain what I completed, what is under review, any
difficulties I encountered, and what I intend to work on next.
When requesting help, I would describe the problem, explain what I
have investigated, and ask specific questions.
I would also like to continue reading and testing other contributors'
changes. My independent testing of Hussain's check-ref-format
conversion helped me appreciate this part of open-source development.
10. Availability
I will be available throughout the internship, from December 7, 2026,
to March 8, 2027.
I can dedicate at least 30 hours per week to the project and do not
anticipate commitments that would interfere with my internship work.
If my availability changes, I will communicate that promptly and
coordinate with my mentors.
11. What I Hope to Achieve
By the end of the internship, I hope to have contributed meaningful,
well-tested improvements to Git's command-line argument handling.
My expected outcomes include:
=E2=80=A2 At least one technically justified parsing improvement submitted =
for
upstream review.
=E2=80=A2 Additional parsing improvements where appropriate and agreed with=
 mentors.
=E2=80=A2 Regression tests that protect important command behavior.
=E2=80=A2 Clear patch submissions and constructive responses to reviews.
=E2=80=A2 Better understanding of Git's parsing APIs, revision infrastructu=
re,
and testing framework.
=E2=80=A2 Stronger C programming, debugging, and technical communication sk=
ills.
I also want to become more confident reading large codebases and
explaining not only what a change does, but why it is needed and what
risks it introduces.
I understand that the value of my work will depend more on the
usefulness and quality of the contributions than on the number of
commands converted.
12. Beyond Outreachy
I want this internship to be the beginning of my continued involvement
in open-source development.
Working with Git during the contribution period has shown me how much
there is to learn from even a small patch and how valuable
constructive feedback can be.
I hope to continue contributing to Git, follow technical discussions,
review changes where I can, and gradually take on more challenging
work.
As I gain experience, I would also like to help other newcomers become
more comfortable contributing to open-source projects, just as members
of the Git community have helped me.
13. References
My Git work
1. Microproject: t1402: test --no-allow-onelevel option precedence
https://lore.kernel.org/git/20261029121715.3845-1-fiendora5@gmail.com/
2. Integrated microproject: Commit 0110f33aa8
Integration merge commit: cc117c8364
3. git column technical investigation:
https://gitlist.dev/t/66794
Relevant project work and documentation
4. Christian Couder's early_scan_options() series:
https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.=
com/
5. Git General Application Information:
https://git.github.io/General-Application-Information/
6. Git General Microproject Information:
https://git.github.io/General-Microproject-Information/
7. Git documentation =E2=80=94 git diff-index:
https://git-scm.com/docs/git-diff-index
8. Git documentation =E2=80=94 git diff-tree:
https://git-scm.com/docs/git-diff-tree
9. Relevant source files:
o builtin/diff-index.c
o builtin/diff-tree.c
o revision.c
o parse-options.h
10. Relevant regression tests:
o t/t4002-diff-basic.sh
o t/t4013-diff-various.sh
o t/t4068-diff-symmetric-merge-base.sh
o t/t4017-diff-retval.sh
o t/t4035-diff-quiet.sh
I would appreciate feedback from the Git community on whether git
diff-index and git diff-tree are suitable candidates for using the
shared parsing API, whether the proposed approach is appropriate given
their interaction with setup_revisions(), and what additional work
would be useful to prioritize during the internship.
Thank you for the guidance I have received throughout the contribution peri=
od.
Best regards,
Fien Dora
