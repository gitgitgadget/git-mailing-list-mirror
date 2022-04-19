Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F73C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 00:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiDSANd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbiDSANc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 20:13:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AEC6151
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 17:10:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w1so3263443lfa.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sXZiQVMZMniyGUrNM3Kp8ouvkza2U2qMfUHBsH6J1i0=;
        b=j0V5rn0Rg6rElyvqr3Yv+mF9QN9vQwOEbU35IYt33Lu5kIgeJDCv1HTQsQc4643wZy
         KkWeBCqlj4Xw1xBwlaJXDj/h6nmWeeEZochOVD3X8LxXBll8DS2K/up1zg2sE6Sbj0Z7
         j2bxtXJrnOmbGa4wWJVnBOYnLY8s1NXH5a+GTHuRzxp7PIptrLH+1euFrw6H5MXS1nce
         dbD7nmnEbByxKvHHDkEfK6Gbtnk49gPbLZXj0SEGKOgRoyuFUWkTsBz4KSc9Pb+HM5n8
         zr0B/iFAd+vxXzPs46gRSFnoohjBQJeoY/P5QNShReI9IE+UMw0e5bR17qxYzx+QyeMm
         Cugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sXZiQVMZMniyGUrNM3Kp8ouvkza2U2qMfUHBsH6J1i0=;
        b=CHx/dzcpqzaDGVUGRCXVg/FqXQno6Z+QtsXhrnhyLgiHnMgap0CjBQzoBMl5AJMaRb
         9S+WrH1KkM9LSkX4ESR+bgGUTzAGnwoPt0YGHIJlrM+15uWYxAGqwRgePL6v4suJClym
         2uW6hHVH1EOcvUmQ253IGKijW/EsENEfLpOUuDujEdM8Yo+8MAifzyGzgrUAhWeUBsqS
         6cQNuPGXR9z3vzYVt87eCDXdNGbfeWUVtCs93vqeZdTxLbNSzWD92w/05XjDhUFT7Vaj
         BeHTTwQBEI2jV2yldET8WrN9oObwmJd4xXo/SANwjMRhI0PHXOxdSC9tWoHs2eLiwk0u
         OWBA==
X-Gm-Message-State: AOAM530CTeMNg6NqPaghYZYLwBFUQISQtf1LVNDcu4u1XG7E17rzSk4b
        DieAPJyXfszon0QaOUSR5BewAQ31E1GpcgWMgF0WQBPVUJc=
X-Google-Smtp-Source: ABdhPJzjcpu4U7kMxFLydNJt8R2tMdh+vinZYmi/xgwj9O1KKtkPTBD9+qxme+mhULkh1on/kjAnZxHQXnfWJlDRDdM=
X-Received: by 2002:ac2:4250:0:b0:44a:ff88:3795 with SMTP id
 m16-20020ac24250000000b0044aff883795mr9673034lfl.384.1650327048362; Mon, 18
 Apr 2022 17:10:48 -0700 (PDT)
MIME-Version: 1.0
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Tue, 19 Apr 2022 03:10:22 +0300
Message-ID: <CAO2gv81YQRTAvJOW4J9ROK5bi0xizhveLoyVbdXniRZ8N+ic0A@mail.gmail.com>
Subject: [GSoC][RFC][Proposal] Reachability bitmap improvements
To:     git <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I completed my proposal and I'm sharing it with you. Even thought it's
close to the deadline I hope it gets reviewed. I'm looking for more
related material like mailing list conversations to include in my
proposal and learn more.
How can I further improve it? Have I missed something?

I know I didn't include any links here. The PDF version I submitted has lin=
ks.

Thanks in advance, I'm sorry for the late submission,
Plato

~~~~~~~~~~

# Contact info [...]

# About me

Final year undergrad @ University of Athens, majoring Computer Science
and minoring Mathematics. Throughout my studies I was selected to help
conduct uni lab lectures voluntarily for courses: data structures in C
(4 years), oop in C++ (2 years). GPA: 8.4/10.

I was a founding member of my university department=E2=80=99s ACM student
chapter, with the goal to grow and bond our uni community by
organizing lectures and workshops by students, academic researchers
and professionals. Mostly I was active in open source channels where I
directed, along with others, conversations about how to get involved
and contribute to open source projects. We even launched our own dummy
project to help provide aided exposure with PRs, reviews and related
procedures, which was accompanied by a talk I conducted (pt. 1, pt. 2)
regarding the workflow with Git & Github. Covid outbreak hindered the
development of the ACM student chapter.

My computing world volunteerism does not stop there as I helped
construct the website & autograder for the cryptography course in =E2=80=98=
15
for NTUA ECE, a different university from the one I=E2=80=99m enrolled in. =
I
also gave a talk for first-year undergrads on how to switch from
Windows to Linux and why, including its advantages and disadvantages.

In late 2019 I was recommended by a prof. to work in my uni department
to develop systems for academic and educational purposes. I focused on
setting up and synchronizing LDAP databases, SCIM identity management,
LSC and maintenance of our GitLab instance.

# Benefits to Community

I plan to become a long term Git contributor, help develop and
influence its design and attract new contributors. I plan to give a
talk to my fellow undergrad and graduate classmates about my
experience in GSoC with Git. How they can become involved, the GSoC
program, Git=E2=80=99s codebase structure and how things are done within th=
e
Git organization.

I will invite them to participate in GSoC =E2=80=9823 with Git where,
hopefully, I will mentor the selected candidates. My participation
with GSoC this year will lay the foundations for me to learn and
accumulate the necessary experience and understanding so I can give
back to GSoC, Git, my university and fellow classmates.

Throughout my GSoC journey, and after it, I=E2=80=99ll publish digests abou=
t
my bitmap work and related knowledge under kioplato.github.io, similar
to the ones in Git Rev News. I=E2=80=99ll also PR related parts to Git Rev
News. This way my work will be transparent and accessible to anyone
who=E2=80=99s interested. It will also serve as reference throughout my GSo=
C
journey and towards future GSoC candidates interested in participating
with Git organization.

Improving Git will benefit open source projects and their communities
as well, increasing productivity due to reduction in wait times as the
proposed project will, hopefully, yield non-trivial speed-up over
network operations. Git is a widely used technology throughout the
industry and further developing it will benefit everyone who=E2=80=99s tryi=
ng
to improve our lives through technology.

# Microproject & Git related work

  =E2=80=93  In 2019, I planned to participate in GSoC =E2=80=9820. To fami=
liarize
myself with Git and get involved early, I picked up this microproject
from GSoC =E2=80=9819 and submitted a patch converting remove_subtree()
function from entry.c to use dir-iterator API instead of opendir,
readdir, closedir API. This function is required to iterate directory
paths after their contents, rendering my patch invalid, as pointed out
by Matheus, since dir-iterator didn=E2=80=99t and still doesn=E2=80=99t off=
er such
functionality. I didn=E2=80=99t follow up with a dir-iterator API patch to
implement the required functionality nor did I attempt to participate
in GSoC =E2=80=9820 due to having limited time.

  =E2=80=93  My dream to participate in GSoC continues and I plan to
participate in GSoC =E2=80=9822. I picked up from where I left off and
introduced the first set of changes requested by this thread to
dir-iterator and submitted RFC v1. The first set of changes refer to
dir-iterator iterating directories before and/or after their contents.
My goal is to considerably improve dir-iterator, guided by the needs
of its possible customers like read_directory_recursive(), resulting
in a simpler, more maintainable codebase. Getting selected for GSoC
will put this goal on hold.

  =E2=80=93  While reading through the SoC documentation in git.github.com =
I
noticed the CI section of the General Microproject Information webpage
wasn=E2=80=99t updated after the switch from Travis-ci to Github actions. T=
he
CI instructions were out of date, pointing to Travis-ci. I builded the
site, updated the section and opened a PR to git.github.com repo,
which was merged.

# Proposal Abstract

Pre Git v2.0.0, network operations like fetches and clones were
hindered by the counting objects phase. In this phase, Git needed to
calculate which objects are required to be sent. However, Git only
knows the tips of all branches, so its only option was to walk down
the graph. To deal with this, Git adopted JGit=E2=80=99s reachability bitma=
ps
in EWAH format. This method led to a significant speed-up over the
network operations, as it indexed which objects are reachable from
salient commits.

While EWAH bitmaps eliminate a performance bottleneck by indexing
which commits are reachable from a given commit, there are possible
improvements to be made. There is a sense that EWAH bitmap compression
is slow in some cases. Are Roaring bitmaps better in Git=E2=80=99s case? Th=
ere
is strong evidence they will be. Are Roaring bitmaps faster to access
specific parts of the bitmap due to its random-access feature and how
can we use this? Is the current bitmap format sufficient to
incorporate a lookup table which specifies the commits which have a
bitmap? How can we improve it? This project attempts to answer these
questions.

The proposed project would entail a) Designing & implementing a suite
of performance tests benchmarking EWAH to validate our assumption that
the performance of bitmap decompression is worth pursuing. Compare the
two bitmap compressions and perform any necessary changes to the
.bitmap format to accommodate the new compression scheme. Speeding-up
read, write bitmap operations or reducing used memory will convince us
to switch to Roaring bitmaps. b) Further explore the idea of
introducing a small =E2=80=9Ctable of contents=E2=80=9D, indexing which com=
mits have a
bitmap and where to find them in the .bitmap file. In this case we
will need to implement a new .bitmap format to add a variable-width
table of contents.

# Proposal Timeline

The proposed project is challenging and in combination with its
experimental nature requires diligence and careful planning. I need to
be realistic. I will need time to familiarize myself and be confident
in my understanding regarding Git=E2=80=99s implementation related to bitma=
ps,
packing objects and related material, before proceeding with the
actual changes to .bitmap format and performance testing. These
require time and effort, therefore I=E2=80=99ll reserve sufficient time to =
get
them right: I=E2=80=99ll dedicate 35-40 hours/week. I will reserve more if =
the
project requires it and I=E2=80=99m open to extending the duration of the
program in case the proposed goals are not achieved.

## Overview

The plan is to first validate the need for an alternate bitmap
compression algorithm. This will be verified from the performance test
suite. =E2=86=92 If there is indeed a need, we will attempt to adopt Roarin=
g
bitmaps instead of EWAH, and compare the two implementations.
Hopefully Roaring bitmaps will speed-up bitmap operations and convince
us to adopt. =E2=86=92 Regardless of the necessity of an alternate bitmap
compression algorithm, the idea of introducing a =E2=80=9Ctable of contents=
=E2=80=9D
to the bitmap format will be explored, even post GSoC. If the
performance tests prove that EWAH is good enough, then the =E2=80=9Ctable o=
f
contents=E2=80=9D along with a new .bitmap format will become my primary
focus.

1. Spend time understanding bitmap data structure, EWAH, Git=E2=80=99s bitm=
ap
format, codebase and respective implementations. Self code and tinker
with codebase. Don=E2=80=99t be afraid to ask questions and make sure it=E2=
=80=99s
clear to me what=E2=80=99s expected.
Material: Bitmap EWAH Bitmap format Bitmaps & inverted lists Git: 1 2 3 4 5
2. Design & implement a suite of performance tests. Validate our
assumption that the performance of bitmap decompression is worth
pursuing.
Material: Git performance tests Taylor=E2=80=99s .bitmap format: mail-list =
fork
3. Implement Roaring bitmap with run containers. Think about the
architecture & design. Compare it against the existing implementation.
Adopt if bitmap operations are faster.
Material: Roaring paper Roaring spec Bitmap format Git: 1 2 3 4 5
4. (alternative) Dedicate some time to investigate and sketch out a
new .bitmap format for the =E2=80=9Ctable of contents=E2=80=9D sub-project.=
 Current
bitmap format comes with limitations.
Material: Bitmap format Taylor=E2=80=99s .bitmap format: mail-list fork
Stolee=E2=80=99s chunk-format API
5. (alternative) Implement a new bitmap format to incorporate the
variable-width =E2=80=9Ctable of contents=E2=80=9D metadata. Implement and =
run related
tests to verify speed-up.
Material: Bitmap format Taylor=E2=80=99s .bitmap format: mail-list fork
Stolee=E2=80=99s chunk-format API

## Timeline

- April 19: GSoC contributor application deadline
- April 20 - May 08 (~3 weeks, 19 days, 120h): Understand codebase
Tinker with and understand Bitmap, EWAH, Git=E2=80=99s EWAH, Bitmap format.
Local testing and self code. Gather a good understanding of Git=E2=80=99s
codebase related to bitmaps in general 1 2 3 4 5. Explore related Git
commands like git gc, pack-objects, unpack-objects, repack, bundle and
other related commands. See which code paths trigger and understand
what=E2=80=99s happening. Ask questions to mentors Taylor & Sivaraam and wi=
der
audience. Read documentation.
- May 09 - May 13 (~1 week, 5 days, 40h): Understand performance tests libr=
ary
Understand the architecture of Git=E2=80=99s performance tests & existing
bitmap performance tests. Investigate which code paths trigger in the
codebase. Consult Taylor=E2=80=99s performance test parts: mail-list to aid
with understanding of how the performance tests work.
- May 20: Accepted GSoC contributor projects announced & Community
bonding period begins
- May 14 - June 03 (3 weeks, 21 days, 120+h): Compression perf tests &
validate assumptions
Design and implement a suite of performance tests. Consult existing
tests, README, conversations, Taylor=E2=80=99s previous work on .bitmap
format: mail-list fork. Validate our assumption that the performance
of bitmap decompression is worth pursuing. Discuss possible new
.bitmap format. Tie up loose ends.
- June 13: Coding officially begins
- June 04  - July 03 (4 weeks, 30 days, 160h): Implement Roaring &
compare to EWAH
Implement Roaring bitmaps with run containers. Understand Roaring
specification and other compressions. Self code and local testing to
understand Roaring format. Read Roaring paper. Minimally implement
Roaring bitmaps and compare against existing compression. Adopt if
bitmap operations are faster. Discuss possible new .bitmap format. Tie
up loose ends.
- July 04 - July 24 (3 weeks, 21 days, 120h): Bitmap perf tests &
further discuss bitmap format
Consult Taylor=E2=80=99s previous work on .bitmap format with commit lookup
table: mail-list fork. Implement more tests to identify & discuss
possible improvements to be made to the current .bitmap format.
Investigate how we can incorporate a variable-width table of contents
to a new .bitmap format. How does the way we read hash-cache extension
limit the current .bitmap format? Can we make it compatible with
Stolee=E2=80=99s chunk-format API? Further understand current .bitmap forma=
t.
Understand pack objects, deltas, related operations & code paths. Self
code and tinker.
- July 29: Phase 1 Evaluation deadline: Submit code
- July 25 - July 29 (5 days): Submit phase 1 evaluation
- July 30 - Aug 21 (4 weeks, 160h): Implement new .bitmap format ideas
& run perf tests
Experiment with new .bitmap format ideas and document possible
speed-up. Continue discussions related to .bitmap formats. Consult
previous conversations. Hopefully arrive at a satisfying new .bitmap
format. Think about its architecture & design.
- Aug 22 - Sep 04 (2 weeks, 80h): Unallocated time in case of delays &
bad time management
- Sep 05 - Sep 12 (1 week): Submit final work product & mentor evaluation.

The above timeline serves mostly as a guideline. The overall pace and
progress of the project depends on intermediate steps like
=E2=80=9CCompression perf tests & validate assumptions=E2=80=9D. There is a=
 plethora
of work to be done and possible improvements to be discussed in this
area. That=E2=80=99s the purpose behind the multiple subprojects of the
proposed project i.e. additional flexibility.

As a possible GSoC candidate, I want to successfully complete GSoC and
get this project right. I want to explore bitmaps, their compressions
and offer as much as I can. For this reason I=E2=80=99ll take advantage and
start preparing from 20 April as the proposal timeline suggests. This
will give me additional flexibility, given the nature of the project
(e.g. in case EWAH compression is good enough), and confidence since
I=E2=80=99ll have more time to work and understand underlying implementatio=
ns.
Even if I=E2=80=99m not selected, these conversations and my exposure to
bitmaps will help the selected candidate. Additionally, I will try to
participate in the process and help the selected candidate.

# Related Work

There is strong evidence that Roaring bitmaps, usually, perform better
than its alternatives:
 =E2=80=93  Guzun et al compared Concise, WAH, EWAH, Roaring (without run
containers) with a hybrid system combining EWAH and uncompressed
bitsets. In many of their tests, but not all, Roaring was superior to
Concise, WAH and EWAH.
 =E2=80=93  Wang et al compared a wide range of bitmap compression techniqu=
es.
They conclude their comparison by a strong recommendation in favor of
Roaring: =E2=80=9CUse Roaring for bitmap compression whenever possible. Do =
not
use other bitmap compression methods such as BBC, WAH, EWAH, PLWAH,
CONCISE, VALWAH, and SBH.=E2=80=9D
 =E2=80=93  Lemire et al reviewed and evaluated the CRoaring library. They
compared BitMagic, EWAH (code from this library is part of the Git
version-control tool), uncompressed bitset, WAH & Concise, C++
std::vector and std::unordered_set for hash-set performance. In their
tests Roaring performance was superior. They concluded by saying =E2=80=9CN=
o
single approach can be best in all cases, but Roaring offers good
all-around performance=E2=80=9D.
 =E2=80=93  CRoaring is an implementation of the Roaring bitmaps in C and C=
++.
Will be used as reference while adopting Roaring bitmaps in Git.
 =E2=80=93  Bitmap implementation in C. Excellent for getting introduced in=
to
the bitmap data structure. Will be used as reference.
 =E2=80=93  Roaring format specification thoroughly describes the compresse=
d
bitmap format.
Will be consulted throughout the project=E2=80=99s duration.
 =E2=80=93  EWAH implementation in C. Excellent for getting introduced into
how things are currently implemented. Git=E2=80=99s EWAH implementation wil=
l
complement that.
 =E2=80=93  Roaring bitmaps publication: Consistently faster and smaller
compressed bitmaps with Roaring. Will be used as reference.
 =E2=80=93  Comparison between bitmap compressions: An Experimental Study o=
f
Bitmap Compression vs. Inverted List Compression. Will be used for
additional context since it provides a brief explanation of all bitmap
compressions.
 =E2=80=93  Taylor=E2=80=99s previous work on .bitmap table of contents: ma=
il-list fork
Taylor found that we could get a significant speed-up in some cases,
but that the speed-up was
basically obliterated whenever we had to do any follow-on traversal if
the bitmap coverage wasn't completely up-to-date.

Previous work that introduced EWAH bitmaps could be used for possible
additional context, exposure, related conversations, code paths and
reference.
 =E2=80=93  Initial patch series, designed by Shawn Pearce for JGit,
implemented by Vicent Marti
 =E2=80=93  Initial patch improvements by Jeff v1, v2, v3, v4.
 =E2=80=93  Merged initial patch: compressed bitmaps, use bitmaps when pack=
ing objects

Related Github blog posts: Counting objects, Scaling monorepo maintenance

# Biographical Information

 =E2=80=93  Me and Git
I have been using Git since 2015, in my work and to collaborate on uni
and fun projects. Throughout these years I=E2=80=99ve read the entire pro G=
it
book while following most parts through my terminal, reproducing the
behavior, in order to make me a better software engineer. The workshop
I conducted (pt. 1, pt. 2) regarding the workflow with Git & Github
was heavily influenced by pro Git book which is apparent in the
workshop=E2=80=99s pdf. I=E2=80=99ve also read material like hacking Git, g=
ithub.blog
posts, Git Rev News and similar technical documents.

 =E2=80=93  Me, C and Shell
C is my native programming language. I have written 80.000+ LOC and
I=E2=80=99ve implemented various systems. Most notably: B+ Tree, LSH for KN=
N &
clustering, simple search engine, graph editor, MPI & OpenMP parallel
system, threaded server, multiprocess systems with workers, archiver,
many algorithms & data structures (kd-trees, red-black, AVL, splay
tree, linked-lists, skip lists, hashtable, etc), many of which I=E2=80=99ve
converted to be thread-safe. In my uni we=E2=80=99re C/C++ oriented.
I=E2=80=99ve been using Arch Linux exclusively for 4+ years to learn and
tinker with my setup. I run dwm, st, self compiled Linux kernel,
various shell scripts, btrfs, full disk encryption, lvm to configure
my computer just how I like it. I=E2=80=99m confident in my C & shell skill=
s.

 =E2=80=93 Professional Experience
Jan 2020 - June 2021 (1.5 year) GUnet
Worked on setting up and synchronizing LDAP databases, SCIM identity
management, LSC and maintenance of our GitLab instance.

 =E2=80=93  Teaching
2019: Workshop regarding the workflow of Git & Github. (pt. 1, pt. 2)
2017: Workshop for first-year undergrads on how to switch from Windows
to Linux and why, including its advantages & disadvantages and related
utilities like IDEs, compilers, packages.
2016 - 2020: Lab assistant courses data structures in C (4 years), oop
course in C++ (2 years).
