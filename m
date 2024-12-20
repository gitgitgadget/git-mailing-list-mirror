Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EE21C191
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715202; cv=none; b=qrwDBv4WI8Za0sA/TF8w5ricCKfWWvf74vpSW2bRaAXAupluaZFDeqsP/JXjBuPLBuaaVrTxUu+aePWS43mM8cW0IZr/3WuvuS+48mjKR+y9DSwATBtcfwMkgRLyIvbt8EiM6cCjUrSRQT34ZlxHt30BjdAWJ38qyvxJhd1qz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715202; c=relaxed/simple;
	bh=S5ttsOKNvyvOU2ejOSgbs5RzqQZ+USkIrGCSNQQDLac=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VkV563X/gbO5WD/bvPVe0xbu9Lxb+piUv8Vs7KOhgQKcYQv0WlqO//J6D6zm+0ikC9+SU3PBsdzIHvyStM9wygwSMBQLGz95myjkq7mUXddsiv/hw9gGQT8u6qJYHopL+WgAu1X6+0nL/AV+ktmcDYl6qj1SEhwXqUBAgwvjHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU5o5koy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU5o5koy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3863703258fso2069807f8f.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715197; x=1735319997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaFDj4bFaCf/xRSBVFy55kNKfY3eM00TB/MUr+81b0U=;
        b=hU5o5koy522sYYki84XHi2jsaeyc3JU77Egr3XOtcXYlTAdpq0J+wTjIjrqAcJz0F2
         kY8QuOA9GIRuIQ31XcDk+RZjLcBVfL1AhyCEU7xLwsptUi3FhyxudfwbkYowo2S24Hlw
         eTwQbXUzbbQGImte/39x8B34LTjtI3afMhdCTSU5kBYnqDzFN2QbGBDLg22TPP0Q36ds
         n2S0epxasF+0oWPLeOsbkrTt4lKyh4UPzxSTZgCqdssQ4UfXfkvH/MNHpzOjxhN/RN8/
         0szy/axhnvVGgsauyM79PnqNZg+fZP9D3BpTXecFyno8tJaQl0Lp9zRIpbXRasQL2mmL
         4Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715197; x=1735319997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaFDj4bFaCf/xRSBVFy55kNKfY3eM00TB/MUr+81b0U=;
        b=FR37atNuxJBqj5F3BohE/Ax/Xjvb697ORUQjOMc5C9czDWiXAG0rej/JbHc7bHrXYn
         als2JFUevn6CZxBAn6mOm1VcP2+GRrjpidigWkJUY+asaFN27HhK68g1XjO9uZNOlEwT
         w1w9K2rES4wiEhOYoFNCWv2manNyVWtY+yZUpS2dPuXUfa5dZWvYLKNuwdgMmAS4g6mb
         h/t7zxINbVDdgDjISbkEOgGTowqDlpvgTAmhwQOKwnCGAgbevStEgPdB2vVFstjeR80W
         59NsA8FZxNCgcSJTRyuDEkSlboCPnHJqyZUQiB1hX5rJn+8T03nrKFuQZFkapKhKRNXL
         1sWg==
X-Gm-Message-State: AOJu0Yx0+Pj8/r7GnXnqDQX6CL4mFt/gzQkbSOf8xntgGW1qtESwa2Wx
	II0AeJxgr5MJm198nYhUQoDwMHaNzQ9qEacbpQs8rQ93nmAUL4iVAOt2WA==
X-Gm-Gg: ASbGncvtJIZ6D1VjhcRbH39g72ggelAUxnOOtwohg1miA3qT9Gv57uNqe7TuW0gei6f
	NiLFTt2cNsfzmGh1ExKVi/08IqdFBWi4212vIBQ2HJMyW1X0bnkM5izskWu/DpuJhaJxq+9gGog
	c41AKRp4bWIXY6mew7y06eqctQ1Kgu4JbY4MKnuwy/vwT+8lQ3aRouLy9JZPrULVw/LBIRlVjMc
	GXtPGEIaFLCRrxbEyOHEtSmwWsIciPMoca5Lk/zYw0VG2L1IamT35x2lQ==
X-Google-Smtp-Source: AGHT+IEdFEyekVW2P56/a901aU4len7JSms2/NKZpql/ddF08O7zmJrCFDVJaEJfzL0zqDGt83J9wg==
X-Received: by 2002:a05:6000:4021:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-38a1a274ba9mr7068826f8f.29.1734715196790;
        Fri, 20 Dec 2024 09:19:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847513sm4532354f8f.49.2024.12.20.09.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:19:56 -0800 (PST)
Message-Id: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:46 +0000
Subject: [PATCH v3 0/8] pack-objects: Create an alternative name hash algorithm (recreated)
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

This is a recreation of the topic in [1] that was closed. (I force-pushed my
branch and GitHub won't let me reopen the PR for GitGitGadget to create this
as v3.)

[1]
https://lore.kernel.org/git/pull.1785.v2.git.1726692381.gitgitgadget@gmail.com/

I've been focused recently on understanding and mitigating the growth of a
few internal repositories. Some of these are growing much larger than
expected for the number of contributors, and there are multiple aspects to
why this growth is so large.

This is part of the RFC I submitted [2] involving the path-walk API, though
this doesn't use the path-walk API directly. In full repack cases, it seems
that the --full-name-hash option gets nearly as good compression as the
--path-walk option introduced in that series. I continue to work on that
feature as well, so we can review it after this series is complete.

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

The main issue plaguing these repositories is that deltas are not being
computed against objects that appear at the same path. While the size of
these files at tip is one aspect of growth that would prevent this issue,
the changes to these files are reasonable and should result in good delta
compression. However, Git is not discovering the connections across
different versions of the same file.

One way to find some improvement in these repositories is to increase the
window size, which was an initial indicator that the delta compression could
be improved, but was not a clear indicator. After some digging (and
prototyping some analysis tools) the main discovery was that the current
name-hash algorithm only considers the last 16 characters in the path name
and has some naturally-occurring collisions within that scope.

This series creates a mechanism to select alternative name hashes using a
new --name-hash-version=<n> option. The versions are:

 1. Version 1 is the default name hash that already exists. This option
    focuses on the final bytes of the path to maximize locality for
    cross-path deltas.

 2. Version 2 is the new path-component hash function suggested by Jonathan
    Tan in the previous version (with some modifications). This hash
    function essentially computes the v1 name hash of each path component
    and then overlays those hashes with a shift to make the parent
    directories contribute less to the final hash, but enough to break many
    collisions that exist in v1.

 3. Version 3 is the hash function that I submitted under the
    --full-name-hash feature in the previous versions. This uses a
    pseudorandom hash procedure to minimize collisions but at the expense of
    losing on locality. This version is implemented in the final patch of
    the series mostly for comparison purposes, as it is unlikely to be
    selected as a valuable hash function over v2. The final patch could be
    omitted from the merged version.

See the patches themselves for detailed results in the p5313-pack-objects.sh
performance test and the p5314-name-hash.sh test that demonstrates how many
collisions occur with each hash function.

In general, the v2 name hash function gets very close to the compression
results of v3 in the full repack case, even in the repositories that feature
many name hash collisions. These benefits come as well without downsides to
other kinds of packfiles, including small pushed packs, larger incremental
fetch packs, and shallow clones.

I should point out that there is still a significant jump in compression
effectiveness between these name hash version options and the --path-walk
feature I suggested in my RFC [2] and has review underway in [3] (along with
changes to git pack-objects and git repack in [4]).

[3]
https://lore.kernel.org/git/pull.1818.v2.git.1731181272.gitgitgadget@gmail.com/

[4] https://github.com/gitgitgadget/git/pull/1819

To compare these options in a set of Javascript repositories that have
different levels of name hash collisions, see the following table that lists
the size of the packfile after git repack -adf
[--name-hash-version=<n>|--path-walk]:

| Repo     | V1 Size   | V2 Size | V3 Size | Path Walk Size |
|----------|-----------|---------|---------|----------------|
| fluentui |     440 M |   161 M |   170 M |          123 M |
| Repo B   |   6,248 M |   856 M |   840 M |          782 M |
| Repo C   |  37,278 M | 6,921 M | 6,755 M |        6,156 M |
| Repo D   | 131,204 M | 7,463 M | 7,124 M |        4,005 M |


As we can see, v2 nearly reaches the effectiveness of v3 (and outperforms it
once!) but there is still a significant change between the
--name-hash-version feature and the --path-walk feature.

The main reason we are considering this --name-hash-version feature is that
it has the least amount of stretch required in order for it to be integrated
with reachability bitmaps, required for server environments. In fact, the
change in this version to use a numerical version makes it more obvious how
to connect the version number to a value in the .bitmap file format. Tests
are added to guarantee that the hash functions preserve their behavior over
time, since data files depend on that.

Thanks, -Stolee


UPDATES SINCE V1
================

 * BIG CHANGE: --full-name-hash is replaced with --name-hash-version=<n>.

 * --name-hash-version=2 uses Jonathan Tan's hash function (with some
   adjustments). See the first patch for this implementation, credited to
   him.

 * --name-hash-version=3 uses the hash function I wrote for the previous
   version's --full-name-hash. This is left as the final patch so it could
   be easily removed from the series if not considered worth having since it
   has some pain points that are resolved from v2 without significant issues
   to overall repo size.

 * Commit messaes are updated with these changes, as well as a better
   attempt to indicate the benefit of cross-path delta pairs, such as
   renames or similar content based on file extension.

 * Performance numbers are regenerated for the same set of repositories.
   Size data is somewhat nondeterministic due to concurrent threads
   competing over delta computations.

 * The --name-hash-version option is not added to git repack until its own
   patch.

 * The patch that updates git repack's synopsis match its docs is squashed
   into the patch that adds the option to git repack.

 * Documentation is expanded for git pack-objects and reused for git repack.

 * GIT_TEST_FULL_NAME_HASH is now GIT_TEST_NAME_HASH_VERSION with similar
   caveats required for tests. It is removed from the linux-TEST-vars CI
   job.

 * The performance test p5313-pack-objects.sh is now organized via a loop
   over the different versions. This separates the scenarios, which makes
   things harder to compare directly, but makes it trivial to add new
   versions.

 * The patch that disabled --full-name-hash when performing a shallow clone
   is no longer present, as it is not necessary when using
   --name-hash-version=2. Perhaps it would be valuable for repo using v3, if
   that is kept in the series.

 * We force name hash version 1 when writing or reading bitmaps.

 * A small patch is added to cause a BUG() failure if the name hash version
   global changes between calls to pack_name_hash_fn(). This is solely
   defensive programming.

 * Several typos, style issues, or suggested comments are resolved.


UPDATES SINCE v2
================

 * For extra safety, the new name-hash algorithm uses unsigned characters.

 * A stray 'full_name_hash' variable is removed.

 * Commit messages are improved.

 * 'git repack' documentation now points to 'git pack-objects' docs for the
   --name-hash-version option.

 * The changes to t5616 are delayed until the introduction of version 3,
   since the v2 name hash does not demonstrate the behavior.

Derrick Stolee (7):
  pack-objects: add --name-hash-version option
  repack: add --name-hash-version option
  pack-objects: add GIT_TEST_NAME_HASH_VERSION
  p5313: add size comparison test
  test-tool: add helper for name-hash values
  pack-objects: prevent name hash version change
  pack-objects: add third name hash version

Jonathan Tan (1):
  pack-objects: create new name-hash function version

 Documentation/git-pack-objects.txt | 41 ++++++++++++++++-
 Documentation/git-repack.txt       |  9 +++-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 63 ++++++++++++++++++++++++---
 builtin/repack.c                   |  9 +++-
 pack-objects.h                     | 54 +++++++++++++++++++++++
 t/README                           |  4 ++
 t/helper/test-name-hash.c          | 24 ++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 70 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 31 +++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 t/t5300-pack-object.sh             | 34 +++++++++++++++
 t/t5310-pack-bitmaps.sh            | 35 ++++++++++++++-
 t/t5333-pseudo-merge-bitmaps.sh    |  4 ++
 t/t5510-fetch.sh                   |  7 ++-
 t/t5616-partial-clone.sh           | 26 ++++++++++-
 t/t6020-bundle-misc.sh             |  6 ++-
 t/t7406-submodule-update.sh        |  4 +-
 t/t7700-repack.sh                  | 16 ++++++-
 t/test-lib-functions.sh            | 26 +++++++++++
 22 files changed, 450 insertions(+), 17 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1823%2Fderrickstolee%2Ffull-name-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1823/derrickstolee/full-name-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1823

Range-diff vs v2:

 1:  454b070d5bb ! 1:  68b4127580e pack-objects: create new name-hash function version
     @@ pack-objects.h: static inline uint32_t pack_name_hash(const char *name)
       	return hash;
       }
       
     -+static inline uint32_t pack_name_hash_v2(const char *name)
     ++static inline uint32_t pack_name_hash_v2(const unsigned char *name)
      +{
      +	uint32_t hash = 0, base = 0, c;
      +
 2:  fb52ca509da ! 2:  d035e3e59f4 pack-objects: add --name-hash-version option
     @@ builtin/pack-objects.c: struct configured_exclusion {
      +		return pack_name_hash(name);
      +
      +	case 2:
     -+		return pack_name_hash_v2(name);
     ++		return pack_name_hash_v2((const unsigned char *)name);
      +
      +	default:
      +		BUG("invalid name-hash version: %d", name_hash_version);
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       		strvec_push(&rp, "--topo-order");
       
      
     - ## builtin/repack.c ##
     -@@ builtin/repack.c: struct pack_objects_args {
     - 	int no_reuse_object;
     - 	int quiet;
     - 	int local;
     -+	int full_name_hash;
     - 	struct list_objects_filter_options filter_options;
     - };
     - 
     -
       ## t/t5300-pack-object.sh ##
      @@ t/t5300-pack-object.sh: do
       	'
 3:  1947d1bf448 ! 3:  e2191244f6b repack: add --name-hash-version option
     @@ Commit message
          new method, test_subcommand_flex. Use it to check that the
          --name-hash-version option is passing through.
      
     +    Since we are modifying the 'git repack' command, let's bring its usage
     +    in line with the Documentation's synopsis. This removes it from the
     +    allow list in t0450 so it will remain in sync in the future.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-repack.txt ##
     @@ Documentation/git-repack.txt: linkgit:git-multi-pack-index[1]).
       	containing the non-redundant packs.
       
      +--name-hash-version=<n>::
     -+	While performing delta compression, Git groups objects that may be
     -+	similar based on heuristics using the path to that object. While
     -+	grouping objects by an exact path match is good for paths with
     -+	many versions, there are benefits for finding delta pairs across
     -+	different full paths. Git collects objects by type and then by a
     -+	"name hash" of the path and then by size, hoping to group objects
     -+	that will compress well together.
     -++
     -+The default name hash version is `1`, which prioritizes hash locality by
     -+considering the final bytes of the path as providing the maximum magnitude
     -+to the hash function. This version excels at distinguishing short paths
     -+and finding renames across directories. However, the hash function depends
     -+primarily on the final 16 bytes of the path. If there are many paths in
     -+the repo that have the same final 16 bytes and differ only by parent
     -+directory, then this name-hash may lead to too many collisions and cause
     -+poor results. At the moment, this version is required when writing
     -+reachability bitmap files with `--write-bitmap-index`.
     -++
     -+The name hash version `2` has similar locality features as version `1`,
     -+except it considers each path component separately and overlays the hashes
     -+with a shift. This still prioritizes the final bytes of the path, but also
     -+"salts" the lower bits of the hash using the parent directory names. This
     -+method allows for some of the locality benefits of version `1` while
     -+breaking most of the collisions from a similarly-named file appearing in
     -+many different directories. At the moment, this version is not allowed
     -+when writing reachability bitmap files with `--write-bitmap-index` and it
     -+will be automatically changed to version `1`.
     ++	Provide this argument to the underlying `git pack-objects` process.
     ++	See linkgit:git-pack-objects[1] for full details.
      +
      +
       CONFIGURATION
     @@ builtin/repack.c: struct pack_objects_args {
       	int no_reuse_object;
       	int quiet;
       	int local;
     --	int full_name_hash;
      +	int name_hash_version;
       	struct list_objects_filter_options filter_options;
       };
 4:  6a95708bf97 ! 4:  86ff0d0a15e pack-objects: add GIT_TEST_NAME_HASH_VERSION
     @@ Metadata
       ## Commit message ##
          pack-objects: add GIT_TEST_NAME_HASH_VERSION
      
     -    Add a new environment variable to opt-in to differen values of the
     +    Add a new environment variable to opt-in to different values of the
          --name-hash-version=<n> option in 'git pack-objects'. This allows for
          extra testing of the feature without repeating all of the test
          scenarios. Unlike many GIT_TEST_* variables, we are choosing to not add
     @@ Commit message
          which pulls the delta base into the new packfile. For these tests,
          disable the option as a decent long-term option.
      
     -    Second, there are two tests in t5616-partial-clone.sh that I believe are
     -    actually broken scenarios. While the client is set up to clone the
     -    'promisor-server' repo via a treeless partial clone filter (tree:0),
     -    that filter does not translate to the 'server' repo. Thus, fetching from
     -    these repos causes the server to think that the client has all reachable
     -    trees and blobs from the commits advertised as 'haves'. This leads the
     -    server to providing a thin pack assuming those objects as delta bases.
     -    Changing the name-hash algorithm presents new delta bases and thus
     -    breaks the expectations of these tests. An alternative could be to set
     -    up 'server' as a promisor server with the correct filter enabled. This
     -    may also point out more issues with partial clone being set up as a
     -    remote-based filtering mechanism and not a repository-wide setting. For
     -    now, do the minimal change to make the test work by disabling the test
     -    variable.
     -
     -    Third, there are some tests that compare the exact output of a 'git
     +    Second, there are some tests that compare the exact output of a 'git
          pack-objects' process when using bitmaps. The warning that ignores the
          --name-hash-version=2 and forces version 1 causes these tests to fail.
          Disable the environment variable to get around this issue.
     @@ t/t5510-fetch.sh: test_expect_success 'all boundary commits are excluded' '
       '
       
      
     - ## t/t5616-partial-clone.sh ##
     -@@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolve deltas' '
     - 	# Exercise to make sure it works. Git will not fetch anything from the
     - 	# promisor remote other than for the big tree (because it needs to
     - 	# resolve the delta).
     --	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
     -+	#
     -+	# TODO: the --full-name-hash option is disabled here, since this test
     -+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
     -+	# recognizes delta bases in a different way and then sends a _blob_ to
     -+	# the client with a delta base that the client does not have! This is
     -+	# because the client is cloned from "promisor-server" with tree:0 but
     -+	# is now fetching from "server" without any filter. This is violating the
     -+	# promise to the server that all reachable objects exist and could be
     -+	# used as delta bases!
     -+	GIT_TRACE_PACKET="$(pwd)/trace" \
     -+		GIT_TEST_NAME_HASH_VERSION=1 \
     -+		git -C client \
     - 		fetch "file://$(pwd)/server" main &&
     - 
     - 	# Verify the assumption that the client needed to fetch the delta base
     -@@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
     - 	# Exercise to make sure it works. Git will not fetch anything from the
     - 	# promisor remote other than for the big blob (because it needs to
     - 	# resolve the delta).
     --	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
     -+	#
     -+	# TODO: the --full-name-hash option is disabled here, since this test
     -+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
     -+	# recognizes delta bases in a different way and then sends a _blob_ to
     -+	# the client with a delta base that the client does not have! This is
     -+	# because the client is cloned from "promisor-server" with tree:0 but
     -+	# is now fetching from "server" without any filter. This is violating the
     -+	# promise to the server that all reachable objects exist and could be
     -+	# used as delta bases!
     -+	GIT_TRACE_PACKET="$(pwd)/trace" \
     -+		GIT_TEST_NAME_HASH_VERSION=1 \
     -+		git -C client \
     - 		fetch "file://$(pwd)/server" main &&
     - 
     - 	# Verify that protocol version 2 was used.
     -
       ## t/t6020-bundle-misc.sh ##
      @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle with --since option' '
       	EOF
 5:  3b5697467c9 = 5:  163aaab3e1b p5313: add size comparison test
 6:  36f2811e3d9 ! 6:  e9ce79fa6e7 test-tool: add helper for name-hash values
     @@ t/helper/test-name-hash.c (new)
      +
      +	while (!strbuf_getline(&line, stdin)) {
      +		printf("%10u ", pack_name_hash(line.buf));
     -+		printf("%10u ", pack_name_hash_v2(line.buf));
     ++		printf("%10u ", pack_name_hash_v2((unsigned const char *)line.buf));
      +		printf("%s\n", line.buf);
      +	}
      +
 7:  3885ef8a2f7 = 7:  18a41f2fe6f pack-objects: prevent name hash version change
 8:  64fd7b3ccad ! 8:  3d63954f318 pack-objects: add third name hash version
     @@ Commit message
          unless there are enough collisions even with v2 that the full repack
          scenario has larger improvements than these.
      
     +    When using GIT_TEST_NAME_HASH_VERSION=3, there are some necessary
     +    changes to t5616-partial-clone.sh since the server now picks different
     +    delta bases that the client does not have (and does not then fetch
     +    dynamically). These changes are a minimal patch and the functionality
     +    should be fixed in other changes.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-pack-objects.txt ##
     @@ Documentation/git-pack-objects.txt: breaking most of the collisions from a simil
       
       DELTA ISLANDS
      
     - ## Documentation/git-repack.txt ##
     -@@ Documentation/git-repack.txt: breaking most of the collisions from a similarly-named file appearing in
     - many different directories. At the moment, this version is not allowed
     - when writing reachability bitmap files with `--write-bitmap-index` and it
     - will be automatically changed to version `1`.
     -++
     -+The name hash version `3` abandons the locality features of versions `1`
     -+and `2` in favor of minimizing collisions. The goal here is to separate
     -+objects by their full path and abandon hope for cross-path delta
     -+compression. For this reason, this option is preferred for repacking large
     -+repositories with many versions and many name hash collisions when using
     -+the first two versions. At the moment, this version is not allowed when
     -+writing reachability bitmap files with `--write-bitmap-index` and it will
     -+be automatically changed to version `1`.
     - 
     - 
     - CONFIGURATION
     -
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: static int name_hash_version = -1;
       
     @@ builtin/pack-objects.c: static int name_hash_version = -1;
       
      @@ builtin/pack-objects.c: static inline uint32_t pack_name_hash_fn(const char *name)
       	case 2:
     - 		return pack_name_hash_v2(name);
     + 		return pack_name_hash_v2((const unsigned char *)name);
       
      +	case 3:
      +		return pack_name_hash_v3(name);
     @@ builtin/pack-objects.c: static inline uint32_t pack_name_hash_fn(const char *nam
       	}
      
       ## pack-objects.h ##
     -@@ pack-objects.h: static inline uint32_t pack_name_hash_v2(const char *name)
     +@@ pack-objects.h: static inline uint32_t pack_name_hash_v2(const unsigned char *name)
       	return (base >> 6) ^ hash;
       }
       
     @@ t/helper/test-name-hash.c
      @@ t/helper/test-name-hash.c: int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
       	while (!strbuf_getline(&line, stdin)) {
       		printf("%10u ", pack_name_hash(line.buf));
     - 		printf("%10u ", pack_name_hash_v2(line.buf));
     + 		printf("%10u ", pack_name_hash_v2((unsigned const char *)line.buf));
      +		printf("%10u ", pack_name_hash_v3(line.buf));
       		printf("%s\n", line.buf);
       	}
     @@ t/t5310-pack-bitmaps.sh: test_expect_success 'name-hash value stability' '
       	EOF
       
       	test_cmp expect out
     +
     + ## t/t5616-partial-clone.sh ##
     +@@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolve deltas' '
     + 	# Exercise to make sure it works. Git will not fetch anything from the
     + 	# promisor remote other than for the big tree (because it needs to
     + 	# resolve the delta).
     +-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
     ++	#
     ++	# TODO: the --name-hash-version option is disabled here, since this test
     ++	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=3, the server
     ++	# recognizes delta bases in a different way and then sends a _blob_ to
     ++	# the client with a delta base that the client does not have! This is
     ++	# because the client is cloned from "promisor-server" with tree:0 but
     ++	# is now fetching from "server" without any filter. This is violating the
     ++	# promise to the server that all reachable objects exist and could be
     ++	# used as delta bases!
     ++	GIT_TRACE_PACKET="$(pwd)/trace" \
     ++		GIT_TEST_NAME_HASH_VERSION=1 \
     ++		git -C client \
     + 		fetch "file://$(pwd)/server" main &&
     + 
     + 	# Verify the assumption that the client needed to fetch the delta base
     +@@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
     + 	# Exercise to make sure it works. Git will not fetch anything from the
     + 	# promisor remote other than for the big blob (because it needs to
     + 	# resolve the delta).
     +-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
     ++	#
     ++	# TODO: the --name-hash-verion option is disabled here, since this test
     ++	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=3, the server
     ++	# recognizes delta bases in a different way and then sends a _blob_ to
     ++	# the client with a delta base that the client does not have! This is
     ++	# because the client is cloned from "promisor-server" with tree:0 but
     ++	# is now fetching from "server" without any filter. This is violating the
     ++	# promise to the server that all reachable objects exist and could be
     ++	# used as delta bases!
     ++	GIT_TRACE_PACKET="$(pwd)/trace" \
     ++		GIT_TEST_NAME_HASH_VERSION=1 \
     ++		git -C client \
     + 		fetch "file://$(pwd)/server" main &&
     + 
     + 	# Verify that protocol version 2 was used.

-- 
gitgitgadget
