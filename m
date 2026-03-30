Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEC3D3491
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876495; cv=pass; b=oEBvVf5JYzul7yiABh5wpriCy3hGRwIWf0kimkbmlbT8vIfWv0JzoSHSUFJ+Gr4AWKNPx+f78hqfK6ykKdMRbsT68FH7TfQ4KmUb0UA7PEPngYV5sNA9SpBkiNTQad9MKUnB4QeRQArUeLW3CeFoF0nPwpIOxd+hPnBF9kpNwKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876495; c=relaxed/simple;
	bh=1s54gLtQCZMgJpQytaKetM9qBF1FmT7fT98Jl8ecHWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=egOwSUWMRWqSplGsBqrzZ1B07U1Y31NIYqyEbz4v0XxdZvk9nHXK9jFQou5qbluXCI7M9CgAzBVz0kWR3XkNUWPDkYVKJ7C+X7uNjDWtyJNTdrSTO6B6wn5mmbTWB/+lfFKkFIKJOJiZLjSKta7nR8F8xVechcWhbun3x8pnzW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9sB3ARh; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9sB3ARh"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso5051445e0c.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 06:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774876491; cv=none;
        d=google.com; s=arc-20240605;
        b=NhNPitICa2hDRdZUHZZ40JaY/l2xitaR9jMR8XEPgvaLFsp9NM5P48eHqTc4eEc62q
         9lpxm8Yz9a8lQ6bqrLvsRCaCKnoIFv4nDlpnaCC7/g8QUy/NWj7gZxydRo2gaJexeG0U
         8+9cmRNq2X+rIwJ5Pa+BwM19wxHzJbysyjcWcgdvqoP2v7an0mJDa1ZTuxs+DkTeKIBH
         BBWWuk+H8FDP7ZDuv3jh4d/3RMX1VjVRLk56NUTt4Mu9sEDLGQrRFOw/7aJ9z8D5cX7j
         7o9n+l2MRr5c6UT+08O3+A6z5tIaoAl6FoPDuE8BYDvU8RS7bq70c72R6ipXsrWHXXc+
         ZlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qAnQqvHtZ1s5f3r1Rd8Lw00Mnp/0A1SRnaI/SikE14g=;
        fh=uB4PIGORGh52mXQ0K8PFMo6KahhyuvNjFoSc5vo3eNQ=;
        b=DbFvc5JSvT50Qj8Dt1aHySnDUpIvv4rurwLAtkiW6rZcBqKHjGKsD63KWk/97eMYQY
         QuUh1jGbir2wzkVWwgB2UoglKgp6m8H5dPpGuVF4ILJdY4AJZEldLPlsoB3m4qT9Rx9u
         utbzBC7+V/MbGOUbatkYN2u/VPqoi3OzrPZ7q1WJ7qdHnGzVz3nLPCPRp2xkE+mU21e+
         5R3QppLk0+W6EFG86uDJTjJ4mRYEzc4LMC8iWVcq0gzN0zDfOyCt32mZ/+wiqw2NVXSm
         DCxtQt+A45PFkJkTwsg1CJvgzoIXoiIPgIKEPHSA9VzXC5gpfbqtDVrpZFWzYZVFCu1w
         xyqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876491; x=1775481291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAnQqvHtZ1s5f3r1Rd8Lw00Mnp/0A1SRnaI/SikE14g=;
        b=O9sB3ARhwPg1bo/UxrHibTMFWpsB0CsNImDwc46EWzWm+v2pDFzzVjyUMb0H5Xfsem
         hdvtYtErr+TtsxxdRa6Kcp41wAC2rJac+bgq0TiRopVpfLlFVkd6C0KfZCM6OGy8GlTT
         sSwawtxaiuareLd/yKIEAAxDAFDBQy4lItn/DOHPeMQrnj0kEZTl6dqR+HTKSafoYkm8
         u/U7OVaFGirBn4QjrkGWd4QMcTCn6t2yP24IUROPRriIsq33j/nnVJkFZNjc5VuFeq8/
         Ugz+byOCF/w6IZn6WcRJC2YwZnxy74nPY+jwTVtw2wYjPzsVql1AHo6Pk2sQsTmNuP/B
         G+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876491; x=1775481291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAnQqvHtZ1s5f3r1Rd8Lw00Mnp/0A1SRnaI/SikE14g=;
        b=XBZetl2Z+lQyo2ImOuCb3/FVxVLLFfB1xLDX8jrcdgrQXZcir860LnoO9TevFfFHIw
         nPK2ynRNmlNZfhkgMncYXcvbhi5i5vmtsCeyvpw6vME9tZqyGvPji5Com32fBuom40NH
         6tgr10MNc52e+j7uEEe2bz5OtWOLv2KWzozFqduKQ1097Ai7YmRM6HmSRTSSObGShBp3
         4+XgVn9RV0JtUEA11t9642JZsbr/ksRyjjvC3dbF3OgC1e4CVCHCTxZ8Nz/nqDwgB/jj
         OXieqPkCe9B7bm/DWiQbjosubV21gcl1piSCafrtHoHwfnzPOtRZXaTi/cxoOYzVZUOg
         QOZQ==
X-Gm-Message-State: AOJu0YzxpjC9dOdkSKx3EtsOy4tw8DpzYM2sKrCGlEvxLN0R7/kycviF
	9ycz1sLrUFwXiHdW7MzkbKZMQd5MXjkFhyNYU5N0enLTqpxz/yXqjuAhhtgzFpWlKuGUdUlrfqP
	WAge0awqPtEio1a5Vf7UMx9oMRmCPmGWAZhonYJwlsxEo
X-Gm-Gg: ATEYQzyQ083xA6scBh/cGsZK990sUCXfKBjL8UH9H4K2mUFChOA3YVMKqt2kYyxZ6fk
	K4OMaX2FoSNmu94oFo+QpZaFP2goviSTGKLLrM5GN1uZ9Nuo63bxyvctISAZ5R3htSqdVcBJ02B
	kxqVPtL28Q89j9tMjrC5aIOg3NTB4hddWgYk3ot4s+3EPouw/aqqs8Pl3EDr/IBqLLyPX8ZlUQS
	LqBNOnRj1oDFgvYw6sWYSCDm+1Qn5MfUsRbSt4SSdfiVCYzmH8D2Aw4/k4aPv/09rVpAgySukFx
	08FFHZ0=
X-Received: by 2002:a05:6102:4a91:b0:604:f640:301d with SMTP id
 ada2fe7eead31-604f8fd6f67mr5115782137.7.1774876491263; Mon, 30 Mar 2026
 06:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahmoud Samy <mahmoudsamymahmoud01@gmail.com>
Date: Mon, 30 Mar 2026 15:14:40 +0200
X-Gm-Features: AQROBzD0TbgAK6RuxnpohkwxkQu9oHCYrhZIc98rKhNGYZLlHiaGyuOSSxnQJtw
Message-ID: <CAC5WPUdUqAkjmO+rw9hGZ9O1d3y1+HvbA87sYmKw=Q7YFpxkmg@mail.gmail.com>
Subject: [GSoC] Draft Proposal: Enhancing the 'git repo' command
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, christian.couder@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,
I am Mahmoud Samy, a fourth-year computer science student. I am
writing to share a draft of my proposal for GSoC 2026 for "Improve the
new git repo command". I would really appreciate any feedback,
corrections, enhancements from the community and mentors to refine my
plan.

Below you will find my implementation plan, testing plan, and
timeline. I am particularly interested in hearing your thoughts about:
1. Using lower-bound binary search for optimal category-based prefix lookup=
s.
2. Defaulting to absolute paths for new path.* keys while offering a
--path-format=3D(absolute|relative) toggle.
3. Adding a --assess flag to `git repo structure` to display git-sizer
style concern markers.

Thank you for your time and guidance. I look forward to hearing from you.

As well I have finished the microproject that I have previously sent
to you "Fix Improper Pluralization to Use ngettext()" in `add-patch.c`
and just waiting for the confirmation to open a PR.

# **Git Repo Info Improvement**

# **Personal Information**

**Name**: Mahmoud Samy
**University**: Cairo University, Faculty of Computers and Artificial
Intelligence
**Email**: mahmoudsamymahmoud01@gmail.com
**Phone Number**: \+20 01157196641
**GitHub**: https://github.com/mahmoudsamyhamed
**LinkedIn**: https://linkedin.com/in/mahmoud-samy-133355258
**Country of Residence**: Egypt
**Timezone**: EET (GMT+2)

My name is Mahmoud Samy, and I am a fourth-year Computer Science
student at Cairo University. I am deeply interested in version control
systems and software architecture. I am eager to contribute to Git
through the Google Summer of Code program by working on the **"git
repo info improvement"** project. My goal is to enhance the diagnostic
capabilities and structural modularity of Git=E2=80=99s repository reportin=
g
tools while actively engaging with the community's design.

# **Project Motivation**

The current implementation of `git repo info` serves as a foundation
for inspecting repository state, but there is significant room for
modernization. By migrating features currently residing in `git
rev-parse` and integrating advanced statistics similar to `git-sizer`,
we can provide users and automated tools with a more comprehensive,
centralized interface for repository metadata. Furthermore, this
project presents an opportunity to contribute to the ongoing effort of
refactoring Git's codebase to be more library-like by reducing
reliance on global state.

# **Implementation Plan**

# **Enhancing git repo**

This implementation plan outlines the technical approach to expanding
the capabilities of the git repo command. The project is divided into
five core phases: addressing technical debt, improving query
ergonomics, expanding metadata retrieval, establishing path formatting
standards, and integrating deep repository analytics.

## **Phase 1: Removing Global State Dependency (the\_repository)**

**Objective:** Eliminate the reliance on the global `the_repository`
variable within `builtin/repo.c` to align with Git's ongoing effort to
remove global state.
**Implementation Details:**

1. **Refactor get\_layout\_bare():** Currently, this relies on the
global `is_bare_repository()`. I will update this to use the passed
`struct repository *repo` parameter by checking
`repo_get_work_tree(repo)`. If it returns NULL, the repository is
bare.
2. **Update Callback Data Structures:** The `count_objects()` callback
currently falls back to `the_repository` when parsing object buffers
because it lacks context. I will add a `struct repository *repo`
pointer to `struct count_objects_data`.
3. **Inject Repository Context:** In `structure_count_objects()`, I
will initialize the new `data.repo` field with the current repository
instance.
4. **Update the Parsing Call:** I will modify the
`parse_object_buffer()` call at the site of `count_objects()` to use
`data->repo` instead of `the_repository`.
5. **Remove the Macro:** Finally, I will delete `#define
USE_THE_REPOSITORY_VARIABLE` from the top of the file, ensuring the
compiler catches any future regressions.

## **Phase 2: Category-Based Key Lookups**

**Objective:** Allow users to query an entire category of metadata
(e.g., git repo info layout) rather than fetching keys one by one,
while maintaining optimal lookup performance.
**Implementation Details:**
**Retain O(log N) Efficiency:** Because the repo\_info\_field registry
is maintained as a sorted array, falling back to an O(N) linear scan
is unnecessary. We will utilize binary search to locate prefixes
efficiently.
 **Implement a Lower-Bound Binary Search:** Standard C library
bsearch() is insufficient for category lookups because, when multiple
matching prefixes exist (e.g., layout.bare and layout.shallow), it
does not guarantee returning the *first* occurrence. I will implement
a custom lower-bound binary search to pinpoint the exact starting
index of the first matching prefix.
**Forward Scanning & Boundary Checks:** Starting from the discovered
lower-bound index, the loop will scan forward. For each key, it will
use strncmp() to ensure the prefix matches. To prevent erroneous
partial matches (e.g., a query for layout.b matching layout.bare), the
code will verify that the character immediately following the matched
prefix length is either \\0 (an exact match) or . (a valid category
prefix).
 **Early Termination:** The forward scan will efficiently break the
moment it encounters a key that no longer matches the requested
prefix, ensuring we only evaluate the relevant slice of the array.

## **Phase 3: Expanding Repository Metadata (Path-Related Values)**

**Objective:** Port critical path-querying functionality from `git
rev-parse` into the structured `git repo info` command.
**Implementation Details:**
I will add new entries to the `repo_info_field` registry, ensuring
lexicographical order is maintained.

1. **Core Directory Paths:**
   * `path.git-dir`: Implemented using `repo_get_git_dir(repo)`.
   * `path.common-dir`: Implemented using `repo_get_common_dir(repo)`
(crucial for linked worktrees).
   * `path.toplevel`: Implemented using `repo_get_work_tree(repo)`,
returning an error if run in a bare repository.
   * `path.superproject-working-tree`: Implemented using
`get_superproject_working_tree()`.
2. **git-path Derived Values:**
   * `path.graft-file`: Implemented using `repo_get_graft_file(repo)`.
   * `path.index-file`: Implemented using `repo_get_index_file(repo)`.
   * `path.objects-dir`: Implemented using `repo_get_object_directory(repo)=
`.
   * `path.hooks-dir`: Implemented by checking
`repo_settings_get_hooks_path(repo)`, falling back to the default
hooks path if unconfigured.
   * `path.prefix`: Implemented by reading `startup_info->prefix` to
get the subdirectory path relative to the working tree root.
3. **Paths Adjusted by update\_common\_dir():** Add keys like
`path.shallow-file` and `path.config-file` utilizing the internal
cached paths of the repository struct.

## **Phase 4: Path Formatting Architecture**

**Objective:** Resolve the design decision between absolute and
relative paths, ensuring robustness for script consumption (especially
with `--format=3Dnul`).
**Implementation Details:**

1. **Canonical Absolute Defaults:** All internal `get_path_*`
functions will return absolute paths by default. This is critical for
NUL-delimited script consumers to prevent silent path-resolution bugs
when changing directories.
2. **CLI Option Integration:** I will introduce a
`--path-format=3D(absolute|relative)` argument to the `git repo info`
command, defaulting to absolute.
3. **Output-Layer Formatting:** Rather than complicating the
`get_value_fn` signatures, formatting will be applied at the output
layer (e.g., inside `print_field`).
4. **Relative Conversion:** If the user specifies
`--path-format=3Drelative`, the program will pass the retrieved absolute
path through `relative_path()` (using the current working directory
prefix) just before printing.

## **Phase 5: Deep Analytics (git-sizer Functionality)**

**Objective:** Bring high-value repository health metrics natively
into `git repo structure` without requiring external Go binaries.
**Implementation Details:**

1. **History Depth Calculation:** I will tap into the `commit-graph`
optimization. During the `count_objects` walk, when encountering
`OBJ_COMMIT`, I will check `commit_graph_generation(commit)`. If a
commit graph exists, the maximum generation number effectively yields
the history depth in O(1) time per commit. If no graph exists, it will
gracefully fallback or skip to avoid expensive traversals.
2. **Path Depth and Length Tracking:** The `count_objects()` callback
already receives a path parameter for trees. I will implement
lightweight trackers:
   * *Max Path Depth:* Count the number of `/` characters in the path strin=
g.
   * *Max Path Length:* Track the maximum `strlen(path)`.
3. **Total Disk Size Approximation:** Instead of shelling out to `du`,
I will sum the already-calculated `disk_size` values across all four
object types (Commits, Trees, Blobs, Tags) to provide a highly
accurate total disk footprint.
4. **Community Discussion (Concern Levels):** As part of the community
interaction requirement, I will draft a discussion for the mailing
list regarding an optional `--assess` flag. This flag would apply
git-sizer-style heuristics to flag concerning metrics (e.g., \>500k
commits) directly in the output table.

# **Testing Plan**

Testing will be heavily integrated into `t1900-repo-info.sh` and
`t1901-repo-structure.sh`. The focus is on logical validation, edge
cases, and ensuring strict parity with rev-parse.

* **Regression Tracking (the\_repository removal)**
  * Verify compilation succeeds with 0 errors after macro removal.
Ensure the entire existing `t1900` and `t1901` test suites pass
completely unchanged.
* **Path Keys Output**
  * Validate expected path strings for normal repos, bare repos, and
linked worktrees. Ensure `path.toplevel` accurately tracks the working
tree root from deeply nested subdirectories.
* **Category Prefix Lookups**
  * Test that querying a category (e.g., `layout`) successfully
returns all child keys. Verify that invalid categories or partial
strings (e.g., `layout.b`) correctly return a "not found" error.
* **Path Formatting Flag**
  * Assert that all paths default to absolute. Test
`--path-format=3Drelative` from various subdirectory depths to ensure
accurate path calculation back to the Git directory.
* **Layout and Object Keys**
  * Assert that `layout.inside-git-dir` and `layout.inside-work-tree`
output the correct boolean depending on where the command is executed.
* **rev-parse Consistency**
  * Programmatically compare the outputs of `git repo info <key>`
directly against their `git rev-parse` counterparts to guarantee
identical behavior.
* **Structure Metrics (git-sizer)**
  * Validate history depth calculations on both linear and highly
branched/merged histories. Assert that max path length/depth correctly
identifies deeply nested mock directories.
* **Output Formats**
  * Verify all new keys format correctly across `--format=3Dlines`,
`--format=3Dnul`, and `-z`.
* **Edge Cases**
  * Validate safe error handling for missing commit-graphs, duplicate
key queries, and setups using `sha256` or `reftable` formats.

# **Deliverables**

The key deliverables for this project align with the core objectives:

* Implementation of repo info logic without dependency on the
`the_repository` global variable.
* A new category-based key system for improved output readability and parsi=
ng.
* Consolidated access to path-related values from `git rev-parse`
within `git repo info`.
* Integration of `git-sizer`\-inspired deep analysis and structural statist=
ics.

# **3\. Project Timeline (12 Weeks)**

* **Community Bonding Period (May 1 \- May 31):**
  * Engage with the mailing list to finalize the design decision
regarding `--path-format`.
  * Draft a discussion on adding `--assess` risk thresholds (git-sizer
heuristics) to gather community consensus.
* **Week 1-2 (June 1 \- June 14):**
  * Remove `the_repository` global dependency.
  * Implement category-based prefix lookups.
  * Write and submit Category 1 and 3 test suites.
* **Week 3-5 (June 15 \- July 5):**
  * Implement all new `path.*`, `layout.*`, and `object.*` keys.
  * Write and submit Category 2 and 5 test suites.
* **Week 6-7 (July 6 \- July 19):**
  * Implement the `--path-format=3D(absolute|relative)` option and
output-layer relative conversion logic.
  * Write and submit Category 4 and 6 tests.
  * **Midterm Evaluation.**
* **Week 8-10 (July 20 \- August 9):**
  *  Implement git-sizer structure metrics (history depth, path depth,
path length, total disk size).
  * Write and submit Category 7 test suite.
* **Week 11-12 (August 10 \- August 23):**
  * Address final mailing list feedback and code reviews.
  * Ensure Category 8 and 9 edge-case test coverage is complete.
  * Finalize documentation and submit the final GSoC report.

Best regards,
Mahmoud Samy
Github: @mahmoudsamyhamed | https://github.com/mahmoudsamyhamed
