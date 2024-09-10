Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77D6A332
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935343; cv=none; b=RHfyNXJC7bk90fpxQflr3B/6BGojEpuwI8/gto7cVNr9i67xTeEQ5QQCJK8QGQQTwmG8PL7DN61UfEL53MFEcBOerW89k7fjU/FlDbQmB8LOPlvSmZ/pvtIfI3mPZSRfUgvO3cnGSqhbQ/m9asSo9BCxvcnMba+gdwwrqDROmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935343; c=relaxed/simple;
	bh=ux5pftW7yYqnUATMKcKvVQwVmU2x2kt0Zp9ZX2PnDwc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bbGjJAJS0mRqH9hbYR1VxdqxSISLNT9qFxWfgg9XLxXDE91msJUBzgE3Sxk3+OLHjzxhMoWsmw4dTEyJD3jqGudS7h6WhyeZv/3008ZEn+zh+3R35yLk3GkLxPzp7wS+uk1treFP4BI9F27aJGB5R15LdDB9DwU8tbGCFsl3FXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+PaXAik; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+PaXAik"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so4688282a12.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935338; x=1726540138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qBykSlfu7wSvMXBPjQWWlIuwIJU4rc06DXAqax713Gs=;
        b=a+PaXAikbAZYqtw3cNV0Mx2Con8E5zKgjrpnh5CVNSdXibJhZwrDCzzDhDZz5Hr5ZL
         NTmd4wOgMi2Y4rHCqyN9uWYlFzBcH1CD7mfUcav+OV1cAv8XXNpUiFHRlW6gDVLifKf7
         984VyS8/w1aOacpbVoUyOQIoEbtpo3miJfGFGQg/gg82WzftX9/LpeBX8YUBhbtvj3U0
         /7uCDzCZa53uVebvAin9E0t1E6dDiJWdJcGb7cc/McO6ckjTJtsPXyaguEi6MtCDKnX3
         GwCQp2M7s9wWsVf5AoTJ3CpQxrBh3oeeqpHxDq4OnGn6AzNA/hqQhBLEczz8fmt68dVq
         3C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935338; x=1726540138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBykSlfu7wSvMXBPjQWWlIuwIJU4rc06DXAqax713Gs=;
        b=ouG0jpj8U53QHcNw89fCJPfNCdioh763FOtuWfGSgM8KA1kiI2OzuvCKTz8QhCYRPj
         NSLjiQbsrr4zT2idEdqrg0LvCJSDDd330q6REJVQOTBEO81qDShgOS5jhd3k2V2/I3bF
         pgsPdU+/In+IT5vKi7wUKanxGWXnypMr2Xfnw+k5cRwiDvjC93fOypDiqarQksGvgznZ
         0mqFv0K85+kAXNKXUsYPguecZ7J4rSRyy3+xCAUEmZV+R/glEC61N710f7FezmLcTsr6
         3Qtd+FDc2IhJlXoXgaMtXsB/tINnaGxlyiXLiQKev2UHVgvrbePrIOu/eF9SqyG5SAI6
         k3vw==
X-Gm-Message-State: AOJu0YwXlkAQtATNEiZjF+qTgl4+n4kwmxVaC4fP5K2IFrvlkwbsLX8x
	UgGGNZIg6lFsvoo+5Wa6HFeO2bpMby0mdt4xAK7jo6x3FFsvfPx2e6rDbA==
X-Google-Smtp-Source: AGHT+IHw0wxrUHvslJAy8e4h6sRIPKp9iMm24PvPa5N8O6Y3AjzLaOPUdA0jAs8BK3dF7SZK4lg1ZQ==
X-Received: by 2002:a05:6402:13d5:b0:5c2:4dcc:b911 with SMTP id 4fb4d7f45d1cf-5c3eac20d9emr6785745a12.26.1725935336938;
        Mon, 09 Sep 2024 19:28:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd52071sm3705478a12.44.2024.09.09.19.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:28:56 -0700 (PDT)
Message-Id: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:25 +0000
Subject: [PATCH 00/30] [RFC] Path-walk API and applications
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

This RFC is ultimately about introducing a new way to walk objects, called
the "path-walk API" in the new path-walk.[ch] files. Before digging into the
details of the API, let's discuss the applications which will hint at the
API's design.


APPLICATIONS OF THE PATH-WALK API
=================================

The applications of this API were discovered in the following order, though
I recommend reversing the order for the priority of their actual
implementation in future patch series:

 * git backfill: a builtin to download missing blobs in a blobless partial
   clone, done in batches and grouped by the path they appear in to maximize
   delta compression in each batch. Allows focusing on the paths of the
   sparse-checkout to only get the blobs necessary for history queries in
   the current focus.

 * git survey: Jeff Hostetler built this feature [1] as a way to get
   functionality similar to git-sizer [2], but using the internals of Git to
   do it faster. It also displays information not available to git-sizer,
   like the on-disk size of objects. This RFC presents a simplified version
   of the builtin focused on listing the paths that contribute the most to
   the on-disk size of trees and blobs.

 * git pack-objects --path-walk: In order to find a way to compute deltas
   among objects of the same path, I applied the path-walk API to 'git
   pack-objects' behind an optional flag. There are overlaps with the
   '--sparse' option [3], [4] that can be used here. This provides perfect
   partitioning by path name, without any possible collisions from the
   name-hash algorithm. It also allows using the name-hash values to find
   cross-path delta chains in a second pass.

 * git repack --full-name-hash: If we are worried about name-hsah
   collisions, an easier thing to implement is a different name-hash
   algorithm that is less likely to have collisions. This feature was
   already sent to the mailing list as a fully-reviewable series [5]. It is
   included here because this series allows testing the --path-walk option
   against the --full-name-hash.

[1] https://github.com/microsoft/git/pull/667 [2]
https://github.com/github/git-sizer [3]
https://github.com/git/git/compare/5d826e972970a784bd7a7bdf587512510097b8c7...99dbbfa8ddbba2b620965d026d4ec199b8837a6f
[4]
https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/
[5]
https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com


TIMELINE FOR CREATING THESE APPLICATIONS IN THIS ORDER
======================================================

Here's the story about how these applications came about: I was tasked with
understanding why certain internal repositories were growing larger than
expected. (Feel free to skip. Otherwise, thank you for indulging me.)

I first prototyped 'git backfill' as a way to download some of the largest
repositories without being blocked on a full clone. This batched download
mechanism allowed me to essentially have a retryable clone, since the client
could restart the process from scratch and skip any objects that were
already on disk. It was natural to batch based on the path of the blobs in
order to theoretically save time and network bandwidth due to better delta
calculations.

While investigating these repositories, I had some data hinting at the total
size of the objects by type. But I was most interested in learning what
exactly was causing this growth. I did have a hint that the "release"
branches were taking up much more space than the default branch, since
cloning with --single-branch resulted in ~55GB of data but then fetching the
release branches led to an additional ~125GB of data. Using "git diff" it
was clear that these branches stored some CHANGELOG.json and CHANGELOG.md
files, but the diffs were relatively small (but multiple such changes were
batched together into a single new commit). I needed to see why exactly
these paths were taking up so much space.

To this, I turned to Jeff Hostetler's new "git survey" command. This told me
information about the total size of trees and blobs and told me the path
name for the individual blobs that were the largest in the repository. These
paths were typically binary files that appeared only once or twice and did
not account for the scale issues. I modified 'git survey' to use the same
path-batching logic as in 'git backfill' to then consider each batch of
objects and their size. Thus, the "path-walk API" was born. (This RFC
contains a version that looks like it was created before 'git backfill'.)

The repository I was looking at had a clear pattern in its top 100 file
paths by on-disk size: 99 of them were CHANGELOG.json and CHANGELOG.md
files. The .md files surprised me, since they were always simple appends of
the previous .md file at the same path. The .json files were capped in how
many versions were being listed (at least in recent versions) but the data
it stored was harder to compress. So I went looking into how 'git push' was
calculating these delta bases. Adding some debug information to 'git
pack-objects' demonstrated that the previous file versions were not being
matched as delta bases. Instead, other new blobs in the push were being used
as delta bases.

This meant that what should have been a trivial set of deltas bloated to
20-60 MB. (We will see later that it is possible for these to be 100-500
KB.)

Here is where I went on a little bit of a detour. (Come with me, it's
important.) I knew that 'git pack-objects' used a name-hash to group objects
by path, so I assumed that the reason these delta bases were not found was
because the UNINTERESTING objects were not being added to the packing list.
I have since discovered that this is incorrect, but I might have gotten
stuck if I didn't think this.

This seemed like a natural reason to extend the path-walk API to allow
walking commits and tags as part of 'git pack-objects' behind a new
'--path-walk' option. The idea here is to compute deltas among the objects
that share a common path and then later go through the (type, name-hash,
size) sorting system to find other delta bases across path boundaries. After
a lot of testing, failing, and testing again, the implementation in this RFC
finally works to achieve the goal. It's not pretty (especially with how it
handles tags) but it gets the job done.

In hindsight, I realized that the UNINTERESTING objects were being
considered, but due to collisions in the name-hash algorithm these objects
were being sorted outside of the delta computation window. For this reason,
I thought to create a new name-hash algorithm. Thus, the --full-name-hash
option for 'git pack-objects' and 'git repack' was born. This feature was
split out and sent to the mailing list independently from this RFC.


RFC GOALS
=========

The goals of this RFC are:

 1. To demonstrate potential applications of the path-walk API to motivate
    its generality as these features are sent in full-quality patch series,
    but in a different order.

 2. To communicate the discoveries found during the --path-walk and
    --full-name-hash features in 'git pack-objects' and 'git repack'. This
    includes comparing and contrasting the effectiveness of these features.

 3. To demonstrate the value of the path-based batching in the 'git survey'
    feature, and to inspire others to think about what other statistics
    would be valuable in that feature. (I anticipate that once a base is
    established, multiple contributors will help expand its functionality
    long into the future.)


RFC OUTLINE
===========

The patches are grouped roughly by the application, in order of discovery:


PART I: 'git backfill'
======================

These patches introduce the 'git backfill' builtin including its
'--batch-size' and '--sparse' options. While this is the first and simplest
application, it is also the lowest priority in terms of user need.

 * path-walk: introduce an object walk by path
 * backfill: add builtin boilerplate
 * backfill: basic functionality and tests
 * backfill: add --batch-size= option
 * backfill: add --sparse option
 * backfill: assume --sparse when sparse-checkout is enabled


PART II: 'git survey'
=====================

These patches reimplement a subset of the functionality of 'git survey' as
well as generalize some of the data structures that Jeff's implementation
made. The flexibility hopefully comes through to show the potential for
future extensions. These patches are quite rough and will need more
attention before they can be sent for full review.

 * path-walk: allow consumer to specify object types
 * path-walk: allow visiting tags
 * survey: stub in new experimental git-survey command
 * survey: add command line opts to select references
 * survey: collect the set of requested refs
 * survey: start pretty printing data in table form
 * survey: add object count summary
 * survey: summarize total sizes by object type
 * survey: show progress during object walk
 * survey: add ability to track prioritized lists
 * survey: add report of "largest" paths


PART III: 'git pack-objects --path-walk'
========================================

Here is where I think the meat of the RFC really lies. There are still some
rough edges, but the data will show that 'git pack-objects --path-walk' has
the potential to be an extremely effective way to pack objects. (Caveats
will come later in the analysis section.)

 * revision: create mark_trees_uninteresting_dense()
 * path-walk: add prune_all_uninteresting option
 * pack-objects: add --path-walk option
 * pack-objects: extract should_attempt_deltas()
 * pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 * p5313: add size comparison test
 * repack: add --path-walk option
 * pack-objects: enable --path-walk via config
 * scalar: enable path-walk during push via config

One obvious issue with this current implementation is that it inlines much
of the delta calculation into the "Enumerate objects" phase, and thus makes
it single-threaded. This should be fixed before being considered for full
review, but even without threading this version can out-perform the standard
packing strategy in terms of end-to-end packing time!


PART IV: 'git repack --full-name-hash'
======================================

This is a simplified version of the patch series that was split out by
itself earlier for full review. This was split out on its own partly because
it doesn't actually use the path-walk API. This has benefits and drawbacks,
but it seems like a quick win for many scenarios.

 * pack-objects: add --full-name-hash option
 * test-name-hash: add helper to compute name-hash functions
 * p5314: add a size test for name-hash collisions
 * pack-objects: output debug info about deltas

This last patch is an add-on of the debugging information that I used to
discover issues with delta bases during 'git push'.


DISCUSSION OF NAME HASH
=======================

One thing to talk about before digging into --path-walk and --full-name-hash
features is the existing name-hash algorithm. This hash algorithm creates a
uint32_t based on the final 16 characters of the path name, weighing the
last characters more. There are multiple benefits to this:

 1. Files of common types (.c, .txt, ...) may be grouped together.

 2. Files that are renamed across directories may be grouped together.

(Thanks, Junio, for making this second benefit clear.)

The issue here is that some common patterns arise in repositories that use
common path names across directories, and those files are creating name-hash
collisions and making the sort less effective. One thing that can counteract
these collisions is to increase the --window setting, but this significantly
slows the delta computations.

Thus, the --path-walk and --full-name-hash features both attempt to combat
these name-hash collisions in very different ways. The --path-walk mechanism
uses the path-walk API to consider batches of objects that all share the
same path. This avoids storing every possible path names in memory while
doing the object walk, but still gives nice boundaries for delta compression
possibilities. After the path-walk is complete, the full packing list is
still sorted via name-hash and this allows for cross-path deltas. This is
critical!

The --full-name-hash feature does the simpler choice of replacing the
name-hash method with one that has fewer collisions, but loses the benefits
of "nearby" paths having close hash values.

This naturally leads to these two main differences in the two approaches:

 1. The --full-name-hash feature is not good for 'git push' or similarly
    small pack-files. Since it limits the delta chains to objects with the
    same full path and loses the benefit of "nearby" paths, this feature
    should be used for larger repacks. In my testing, 'git push' simulations
    almost always have poor packing but 'git repack -adf' simulations have
    packing rivaling the --path-walk option.

 2. The --path-walk option changes the object ordering significantly,
    meaning it may not ever be appropriate to combine with advanced
    repacking features such as delta islands or even reachability bitmaps.
    While my testing has shown that the --path-walk repacks are the most
    efficient of all options, this limitation makes me hesitate to recommend
    it wider than client repositories.

One natural question to consider is to think about storing both the
name-hash and the full-name-hash and doing two delta passes, each one
sorting the objects by a different hash function. The first issue is that we
don't want to store two hash values per object, as that will significantly
increase the memory pressure during repacking. This could be side-stepped by
storing the full-name-hash in the packing list and then a second mapping
from full-name-hash to name-hash. However, that still leads to the two
passes taking extra time. The --path-walk approach is faster than even a
single pass. And in the right scenarios, the --full-name-hash option is very
close to the --path-walk results.


ANALYSIS OF PACKING STRATEGIES
==============================

Since I was focused on an internal monorepo that stored a large collection
of Javascript packages, it should be no surprise that I eventually found
other Javascript repositories that used similar tooling and thus had similar
issues with unexplained scale problems. I'll use these four repositories as
examples repeatedly, but one is actually public: microsoft/fluentui [6].
I'll use Repo B, C, and D for the others, in increasing size.

[6] https://github.com/microsoft/fluentui

In each of these repositories, doing a full repack ('git repack -adf') right
after cloning presents a sizeable reduction in space. This is expected for
servers not being optimized for exactly the reachable set I'm cloning. So,
I'll focus on how much the default repacking parameters compare to using the
--full-name-hash or --path-walk options:

| Repo     | Standard Repack | With --full-name-hash | With --path-walk |
|----------|-----------------|-----------------------|------------------|
| fluentui |         438 MB  |               168 MB  |          148 MB  |
| Repo B   |       6,255 MB  |               829 MB  |          778 MB  |
| Repo C   |      37,737 MB  |             7,125 MB  |        6,158 MB  |
| Repo D   |     130,049 MB  |             6,190 MB  |        4,432 MB  |


Hopefully these reductions show how much these name-hash collisions are
causing issues in these repositories.

For the fluentui repo, I'm also able to share highlights from the 'git
survey' output immediately after cloning and after repacking with the
--path-walk option.

First, we can consider the total reachable objects in each scenario:

TOTAL OBJECT SIZES BY TYPE
================================================
Object Type |  Count | Disk Size | Inflated Size
------------+--------+-----------+--------------
    Commits |  20579 |  10443669 |      15092790
      Trees | 276503 |  40212070 |     244429615
      Blobs | 294500 | 635365661 |   10791187920


TOTAL OBJECT SIZES BY TYPE
================================================
Object Type |  Count | Disk Size | Inflated Size
------------+--------+-----------+--------------
    Commits |  20579 |  10450605 |      15092790
      Trees | 276503 |  31136263 |     244429615
      Blobs | 294500 |  94442401 |   10791187920


Now, we can consider the top 10 file paths before and after repacking with
the --path-walk feature:

TOP FILES BY DISK SIZE
===================================================================
                           Path | Count | Disk Size | Inflated Size
--------------------------------+-------+-----------+--------------
                      yarn.lock |   802 |  58060531 |     889120488
 ...-experiments/CHANGELOG.json |   505 |  28439452 |     252723999
 ...fabric-react/CHANGELOG.json |  1270 |  25556510 |     902756623
 ...t-components/CHANGELOG.json |   176 |  20366365 |     244936649
 ...act-charting/CHANGELOG.json |   590 |  20106422 |     208224460
 ...e-components/CHANGELOG.json |   559 |  15761271 |     189061764
 ...act-examples/CHANGELOG.json |   577 |  13615569 |     234949961
 ...react-charting/CHANGELOG.md |   564 |  11205840 |     104337986
 .../experiments/CHANGELOG.json |   569 |  10596377 |     123662770
 ...i-fabric-react/CHANGELOG.md |  1263 |   8154248 |     261494258


TOP FILES BY DISK SIZE
===================================================================
                           Path | Count | Disk Size | Inflated Size
--------------------------------+-------+-----------+--------------
                      yarn.lock |   802 |   9909326 |     889120488
 ...iceBrandGuide_16Sep2016.pdf |     1 |   2106334 |       2186005
 ...out/src/images/download.jpg |     1 |   1845249 |       1846117
 ...fluent-ui-logo-inverted.png |     3 |   1370372 |       1447493
          .yarn/releases/cli.js |     1 |   1335657 |       6741614
 ...c/images/fluent-ui-logo.png |     3 |   1272902 |       1341139
 ...ages/fluent-ui-logo-dev.png |     3 |   1130989 |       1186897
 ...nents/public/SegoeUI-VF.ttf |     1 |   1074046 |       1844524
 ...ig/rush/npm-shrinkwrap.json |   138 |   1058531 |      89326567
 ...Accessibility_29Sep2016.pdf |     1 |    856621 |        927268


As we can see from this example, before the repack we are mainly seeing the
disk space be dominated by objects that appear at paths with CHANGELOG.json
or CHANGELOG.md, which are frequently hitting collisions with the default
name-hash. After the repack with the --path-walk feature, we see the largest
paths are what we expect: checked in binaries, frequently-edited yarn files,
and other hard-to- compress data.

The nice thing about this result is that we can point to files that are
taking up space because there is no other way around it, not that the naming
convention for the files is causing confusion during packing.


WHAT TO DO NOW?
===============

Thank you for reading this far. I hope that this has added context on the
patch series for the --full-name-hash option, but also provided the right
context for when I come back in a week or so with a review-ready version of
the --path-walk option.

These patches are rough and I want to make sure everyone knows that.
Reviewing them for style or even basic organization may lead to some wasted
time. I know that at least one of the patches got mangled and its diff does
not match its description (I'm thinking specifically about "pack-objects:
extract should_attempt_deltas()" but this could apply elsewhere).

But I think that interested parties could take my branch, build it, and give
these features a try on their favorite repos. I'd love to hear feedback on
the usability and effectiveness, especially if someone finds a case where
the --path-walk option is less effective at packing data.

There are two things going on since I started working on this series that
could cause issues with applying this series on top of current 'master' or
with topics in 'seen':

 * The most obvious one is the collision with the --full-name-hash feature
   under review. The in-review series takes precedent.

 * The unused parameter warnings are now errors! I'm glad that got in, but I
   wasn't careful about it in these RFC patches.

 * John Cai is proposing to change the builtin interface to have builtin
   methods take a repository pointer. I approve of this effort, but it
   collides with the two new builtins introduced here. As discussed above,
   the 'git survey' and 'git backfill' builtins are the lowest priority
   items for getting merged, in my opinion, so they can wait until that
   change has been made.

I look forward to any and all comments.

Thanks! -Stolee

Derrick Stolee (27):
  path-walk: introduce an object walk by path
  backfill: add builtin boilerplate
  backfill: basic functionality and tests
  backfill: add --batch-size=<n> option
  backfill: add --sparse option
  backfill: assume --sparse when sparse-checkout is enabled
  path-walk: allow consumer to specify object types
  path-walk: allow visiting tags
  survey: start pretty printing data in table form
  survey: add object count summary
  survey: summarize total sizes by object type
  survey: show progress during object walk
  survey: add ability to track prioritized lists
  survey: add report of "largest" paths
  revision: create mark_trees_uninteresting_dense()
  path-walk: add prune_all_uninteresting option
  pack-objects: add --path-walk option
  pack-objects: extract should_attempt_deltas()
  pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  p5313: add size comparison test
  repack: add --path-walk option
  pack-objects: enable --path-walk via config
  scalar: enable path-walk during push via config
  pack-objects: add --full-name-hash option
  test-name-hash: add helper to compute name-hash functions
  p5314: add a size test for name-hash collisions
  pack-objects: output debug info about deltas

Jeff Hostetler (3):
  survey: stub in new experimental `git-survey` command
  survey: add command line opts to select references
  survey: collect the set of requested refs

 .gitignore                     |   2 +
 Documentation/config/pack.txt  |   8 +
 Documentation/git-backfill.txt |  60 ++
 Documentation/git-survey.txt   |  70 +++
 Makefile                       |   4 +
 builtin.h                      |   2 +
 builtin/backfill.c             | 141 +++++
 builtin/pack-objects.c         | 298 ++++++++--
 builtin/repack.c               |  10 +
 builtin/survey.c               | 965 +++++++++++++++++++++++++++++++++
 command-list.txt               |   2 +
 git.c                          |   2 +
 pack-objects.h                 |  20 +
 path-walk.c                    | 401 ++++++++++++++
 path-walk.h                    |  73 +++
 repo-settings.c                |   3 +
 repository.h                   |   1 +
 revision.c                     |  15 +
 revision.h                     |   1 +
 scalar.c                       |   1 +
 t/README                       |   4 +
 t/helper/test-name-hash.c      |  23 +
 t/helper/test-tool.c           |   1 +
 t/helper/test-tool.h           |   1 +
 t/perf/p5313-pack-objects.sh   | 101 ++++
 t/perf/p5314-name-hash.sh      |  41 ++
 t/t5620-backfill.sh            | 181 +++++++
 t/t8100-git-survey.sh          |  76 +++
 28 files changed, 2469 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 Documentation/git-survey.txt
 create mode 100644 builtin/backfill.c
 create mode 100644 builtin/survey.c
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh
 create mode 100755 t/t5620-backfill.sh
 create mode 100755 t/t8100-git-survey.sh


base-commit: 17d4b10aea6bda2027047a0e3548a6f8ad667dde
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1786%2Fderrickstolee%2Fpath-walk-rfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1786/derrickstolee/path-walk-rfc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1786
-- 
gitgitgadget
