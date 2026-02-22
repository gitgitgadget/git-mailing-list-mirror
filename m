Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889C1A0B15
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771747043; cv=pass; b=VQzhPZNyiHI44CSAQEPrMZcFPfwvJklUqPkqF2jxJKTZvh+Nq2kYxUfyrqBiQ7h6MqSYHpBrY3BBPFOOhdSDSky0217+s6J9c6Eu5/VywiMzXrL4Jig8//TQ6YQT/Px6B6JPAVDZRP8W4gyU++Et70eq0Rf7bEaz+sRTJW1/Y2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771747043; c=relaxed/simple;
	bh=FqlS3MjUFtyf3Dz86p+r0nMDQ096EY5hOlqe/ZxYqXI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M04ouz4uMphbMKNESuBkOpQ2ItykWCePlvlb6NgM5rjME1w3kcrgWdb9M+u7Bg1QgTF1pPNeHsZRmVs4SfQMONTaVgkbJrmRzbX+jDXRu+BFgt7TPSilcvBweXSLa7TkouTZnzAPBxC/u9iewKVui+ZOMQ7bXM+dH/w+M8t5870=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHho1Vi2; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHho1Vi2"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a747448dso28141061cf.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 23:57:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771747041; cv=none;
        d=google.com; s=arc-20240605;
        b=Qbg9T2FFRVj1WCXqc7nKk3djxHSMCDyEXtN0/Fnm35sgjjC7c/mGTKWpTmVRLgk6Bm
         RYtzrhkcAMTiA08JBgV59ySQQ7d8hAP3Wt1bw8aKzVPk7MwusARstv1ez2VkD6ueUsi0
         VDUzppd6Vno1Imb8Seq7Cx9mflgNFQGTa6KdEU3o0H0Bk1XC9JM7JVnkwqvsa18jVDLU
         StmPsC5hTvQB61jxOA4iZw/lOW4Q/FLal3jxhAF6SWwDKbxBtlyRkxrgu5L0/fCv5CyK
         5Ajz/2SMSLgyqPlx1JbGnlaSMf8jJnUxIb3dTfKGvqkTsr+xFucrilmm8RaqcboGy4Kf
         +a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=d+VkeM9OEHb8qiqVMGEgyCMrr2rCqUoUGFu/kR5isuU=;
        fh=1qnHtQLN+KO2D+8EF1ZuYpeZ5tmendMW1oWsGayNxdk=;
        b=egfWfwXwJCl/SprZhsDI6FX+c443+VWdcU2t/nXhMEnEMfHaaHj+tTzNmXT6/68t6K
         B7LsEOp2RUu7o71vgWGA3kGN+RTGBkbNx47qo1jPwWFKbMIxnLMIRtdi4ca2tkaJEBMb
         3YS6/S1yfR7YFAryXTdFhWvZ/nOYgzhvZVKB0IQKlZlSWjARlLTdClcEN+x1j7DcGtCK
         3Af3N2o9aDmjj8QziOWYxwwxJtMbl04gkeCPKeZf/AGshTtv1sWoRVJxr78zZJf3Mvux
         d40W4bAu/sstM3RuwlFxr5DKGYYgSICLKK/eaA3TcrlNS4bulxkyY0O8i5XFlLWo0iJY
         b1sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771747041; x=1772351841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+VkeM9OEHb8qiqVMGEgyCMrr2rCqUoUGFu/kR5isuU=;
        b=YHho1Vi2FYIFPYN4DbeUWofUzyox0NhHjqw6QbEukca1FpVn1CqbHPd/RIWl0vSk/g
         ubjcwSoUErUTKyEqjoAwXpPph9Sq7DEa0smgOrQJswdfNNONv78BE0Gk/MhPuI1mujxs
         S3QNw2+AG0CZhSMXg41X0miOMZlPigsQ9Etk8YlVfri/QHHs3gavx6VvQlZ6muL2oyEB
         ZM1r7tHMkOdbTSYtWkHX4xrDAmSUf/v3HLi7R7hoQga9hmuLpY6YFl5ncR7XAG1dvJ0+
         OymTj+IAn2QxpIzA+ApaX9CAFn4/uY9Q5sDZDWpLncC7sh2rI3c5ER21Q7zTlW2iM6qk
         pKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771747041; x=1772351841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+VkeM9OEHb8qiqVMGEgyCMrr2rCqUoUGFu/kR5isuU=;
        b=kQ2XxT0O/CM2Q4ER9qLJugCHM4Lhlku5vGznHlzTRGYMz/Nx7VOo12EydDV+eudYpT
         RGHIJ54DDCtR8DhNItoH5dcLWc1SWXm9hcOqgKSXQ1BuCs9RM8fedW5hQke2e7wdrpSX
         EhaBTHrgBr4jBxmDCINF3FnrmnAxG5ojQNtLyYN0HZ50eGK4SPFqlKTGCE3XqMvHCFGo
         vKa3wnhTD30P8M6+hXuAD6tu6nQy7ibx5fZ3eljRiczqYeXvLNaaN+ffdgLM8Ds/ZWW7
         bqVdA4loFH/1DWjKEkxpoaPjlO9W3xfmRoSQHRNV9+cKWQL7Oo8nWD65wyeK0cpV1Orc
         /VjA==
X-Gm-Message-State: AOJu0Yw90836CVDmsdgfbSrRdmP35U1T1oA/U83f1iGuKUhAKDHe7L6V
	aXsBrlYLYHcxK9lLEuMe9zhwM/DQt2RnUBeyrJKURDrl/yIeYXV+F+gorXsRPwD5woQIUqfTgFP
	OL0MOWBzSoDqfnwotPAAN3xcJbOpDkYJwnzIA/78=
X-Gm-Gg: AZuq6aIv6IhY7uYmB0ysg0NHUaDPSvbIMeI7GmZ05i2eup8slPO0AKjfvcSSPRqEFB0
	QqUgNg+ETRPTmLfF94RXB3dowtvojwyStDflFSgUwWnG0h4n0+lcL9GyoU3qf2IwtjMQFn9SSFX
	j9v/hxeod/wMIylEEGaww42Bg6eYaYGOeeXYLTFzpdX9Gxxticuk0Fc5QBxeSf8fMFRumtnB9+T
	ybNbFmGn6y/BxMNjYvQG+Bmo7oryAvv3QMGUNTOSPtB1+36ev2s0ZUE79iCFuN9Y/KcilI7whx1
	qxhG1jCzHqlFB9bBaTUJ1O/Kpw1YwDlU/JKD/ZUj
X-Received: by 2002:a05:622a:58b:b0:502:8fb7:77ff with SMTP id
 d75a77b69052e-5070bc68b1bmr67674491cf.47.1771747040624; Sat, 21 Feb 2026
 23:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 22 Feb 2026 13:27:09 +0530
X-Gm-Features: AaiRm51wZqkSejF3eC0XEYI8LfrEwaFG_WWPqT-Qn2Vz7dTg1dd0DNHCZ42II4M
Message-ID: <CA+rGoLdSR=NPoD7XEbYPoRTt0VS5M0QhzHcy-OmyuZMMVN-H5w@mail.gmail.com>
Subject: [proposal][RFC] Improve the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>
Cc: karthik nayak <karthik.188@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I am done with a rough draft of my proposal,
currently I am posting this in a text format but when I submit it officiall=
y
I am planning to make it a TeX pdf.

---

Improve the new git repo command
Jayatheerth Kulkarni
February 22, 2026

---

1. About Me
I am a junior at Geethanjali College of Engineering and Technology
pursuing a bachelor's degree, with a strong interest in open-source
projects and systems programming. My interest in the Git project
stems from a desire to understand the internals of version control
and contribute to a tool that is fundamental to the global software
development ecosystem.

1.1 Contact:
email: jayatheerthkulkarni2005@gmail.com
website: https://jayatheerth.com/
github: https://github.com/jayatheerthkulkarni
linkedin: https://linkedin.com/in/jayatheerth

1.2 Details related to projects:
Timezone: Indian Standard Time (IST) / UTC+05:30
My Tech Stack: C, Shell Scripting, Rust

---

2. Contribution History

2.1 Micro-Project (GSoC Requirement)
To familiarize myself with Git=E2=80=99s test suite and submission
guidelines, I completed the following micro-project:

Patch:
https://lore.kernel.org/git/20260109032027.68680-1-jayatheerthkulkarni2005@=
gmail.com/
[GSoC] t7101: modernize test path checks
Description: Replaced old-style test -[df] assertions with modern
test_path_is_* helpers in t7101-reset-empty-subdirs.sh. This
improves debuggability and aligns with modern Git coding standards.
I also addressed path reference inaccuracies in the test
descriptions.
Status: Merged into master.

2.1.1 A Micro-Patch to get started with repo.c codebase:

Patch:
https://lore.kernel.org/git/20260222004036.47744-1-jayatheerthkulkarni2005@=
gmail.com/T/#u
[GSoC] builtin/repo: remove unused hex.h header
Description: This is a micro-patch that simply removes an unused
header to demonstrate my familiarity with the repo.c codebase and
the mailing list submission process.

2.2 Taking part in the community
For many months, I have been a part of multiple discussions, one of
which even got featured in Git Rev-News edition 124.
https://git.github.io/rev_news/2025/06/30/edition-124/

A list of my past activities in Git:

July 2025
submodule: skip redundant active entries when pattern covers path
submodule: prevent overwriting .gitmodules on path reuse
Discussion link:
https://lore.kernel.org/git/CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi1=
1hMw@mail.gmail.com/T/#m1e53511686dccdccab4a1c484703472e5e739c6c
Status: Merged into master

June 2025
stash: fix incorrect branch name in stash message
Discussion Link:
https://lore.kernel.org/git/f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de/T/#=
m4b9a4c0da4f35519b3eb98bdc3d1fce84efa80aa
Status: Merged into master and featured in Git Rev-News
(Discussions section)

These discussions highlight my ability to engage constructively
with the community and iterate on feedback.

2.3 Experience with C:
Since Git is mainly written in C, I would have no issues, as I am
well-versed in the language. I have received a Cisco CLP - Advanced
C Programming certificate, which covered Unix and C in good detail.
I have also taken two full semesters of C programming; therefore,
I can confidently understand existing C code in Git.

---

3. Project Proposal

3.1 Why "Improve the new git repo command"?
This project is particularly compelling because I have closely
followed its development since its inception. Consistently reading
the weekly updates (https://lucasoshiro.github.io/gsoc-en/) and
following the mailing list patches for git repo info has deepened
my ongoing interest in this specific initiative since GSoC 2025.
This continuous engagement has provided a strong understanding of
why the command exists and exactly what needs to be done.

3.2 Introduction
Taken from the SoC 2026 ideas page
(https://git.github.io/SoC-2026-Ideas/), the new repo info command
has already started to be a really good replacement for parts of
rev-parse. As this command is still in its early stages, there is
significant opportunity to refine its architecture and expand its
feature set.

Architectural Changes:
- Removing the global dependency on the_repository. This was a
  project of its own in the past SoC 2025; now we implement this
  in repo info.
- Currently, we can access either all repository info or we can
  access info manually. Adding a feature where we can access things
  by category (e.g., git repo info paths returning git-dir,
  common-dir, and worktree, or git repo info core returning all
  core-related configurations) would be a good change to this
  command.

Feature Additions:
- Adding path-related values currently obtained through git
  rev-parse (such as git-dir, common-dir, toplevel, and
  superproject-working-tree).
- Adding more values currently obtained through git rev-parse
  --git-path (such as the grafts file, index file, objects
  directory, hooks directory, git-prefix, and other paths adjusted
  by update_common_dir()).

3.3 Proposed Solution and Objectives
The main objective of this project is to implement the changes and
additions discussed in the introduction to make git repo a complete,
modern replacement for parts of rev-parse. My proposed solutions are:

- Removing the global state: The builtin/repo.c file currently opts
  into using global state by declaring
  #define USE_THE_REPOSITORY_VARIABLE at the top of the file. My
  goal is to remove this macro entirely to align with Git's
  libification efforts. To achieve this, I will refactor functions
  that implicitly rely on this global state instead of the passed
  repository context. For example, in get_layout_bare(), the repo
  argument is currently marked as UNUSED because the function calls
  is_bare_repository() (which checks global state). I will update
  this and similar functions to evaluate the explicit repo struct
  instead.

- Implementing category keys: I will add a way to map specific
  categories to a group of values. For example, if a user types
  git repo info paths, the internal logic will look up the paths
  category and return git-dir, common-dir, and other related
  values all at once instead of requiring manual queries for each.

- Adding path values: I will integrate the missing path values
  currently obtained through git rev-parse (like toplevel and
  superproject-working-tree) and --git-path (like index and hooks).
  Since initial work on this has already started, my goal is to
  take over the effort, lead the necessary design choices on the
  mailing list, and complete the implementation.

- Enhancing repo structure: I will study the external git-sizer
  tool to figure out which of its repository analysis and
  statistics features can be natively implemented into the git
  repo structure sub-command.

---

4. Project Timeline
From observing past GSoC proposal reviews, I understand that mailing
list discussions and patch iterations take time. I have structured
this timeline to be as realistic as possible, front-loading design
decisions and extending the schedule to accommodate standard review
cycles.

4.1 Community Bonding Period (May)
- Attend the Git community GSoC sessions to introduce myself, the
  project, and establish a communication schedule with my mentors.
- Initiate the design discussion on the mailing list regarding the
  output format for path-related values (absolute vs. relative
  paths, or adding an --absolute-paths flag). Getting consensus
  early is critical so coding can begin in Week 2.
- Deep dive into path.c and setup.c to understand exactly how git
  rev-parse currently resolves git-dir, common-dir, and --git-path
  values.

4.2 Phase 1: Core Implementation (Weeks 2 - 6)
Weeks 2 and 3: Foundation and Extended Path Values
- Implement the core path values currently obtained via git
  rev-parse: git-dir, common-dir, toplevel, and
  superproject-working-tree.
- Implement the remaining values obtained via git rev-parse
  --git-path: grafts file, index file, objects directory, hooks
  directory, and git-prefix.
- Write initial tests in t/ to ensure path resolution works
  correctly across standard, bare, and worktree setups, then
  submit the first patch series.

Weeks 4 - 6: Removing Global State
- Focus entirely on libification. Remove
  #define USE_THE_REPOSITORY_VARIABLE from builtin/repo.c.
- Refactor functions like get_layout_bare() that currently have an
  UNUSED repo struct to evaluate the explicit repo parameter
  instead of relying on global state.
- Run the full test suite to ensure dropping the global state macro
  does not introduce regressions, and submit the patch series.

4.3 Mid-Term Evaluation Phase
- Ensure the path-related additions and the global state removal
  patches are either merged into master or queued in next.
- Review progress with mentors, adjust the Phase 2 timeline based
  on mailing list guidance, and submit the mid-term evaluation.

4.4 Phase 2: Categories and Structure Enhancements (Weeks 7 - 12)
Weeks 7 - 9: Category-Based Queries
- Implement the internal mapping structure to associate category
  keys (e.g., paths, layout) with their respective individual keys.
- Modify the parsing logic in print_fields() and cmd_repo_info()
  so that querying a category correctly loops through and outputs
  the grouped values.
- Add documentation and tests for the new category arguments.
  Submit patches for review.

Weeks 10 - 12: repo structure and git-sizer Integration
- Analyze the codebase of git-sizer and identify the most valuable,
  easily integrated metrics (e.g., maximum tree depth, massive blob
  detection) that fit natively into Git's C codebase.
- Implement these structural analysis additions into
  cmd_repo_structure().
- Ensure the new metrics correctly output in both the table format
  and the NUL-terminated/keyvalue formats.

4.5 Extended Period & Finalization (Weeks 13 - 14+)
Weeks 13 - 14: Buffer and Edge Cases
- This period acts as a realistic buffer for prolonged mailing list
  discussions, particularly for the git-sizer integrations which
  may require architectural feedback.
- Perform rigorous edge-case testing (e.g., running the new
  commands inside sparse checkouts, nested submodules, and heavily
  customized .git/config environments) and address final patch
  revisions.

Final Week: Documentation and Handoff
- Finalize the official Git documentation for all new additions to
  git repo info and git repo structure.
- Clean up the commit history, ensure all patches are finalized on
  the mailing list, and submit the final GSoC project report.

---

5. Availability and Blogging
This timeline aligns perfectly with my schedule. The project kicks
off in May, during which I will be on summer vacation and can
dedicate full-time hours. During June and July, I will transition
into my final year of university. My academic schedule during this
period is highly flexible, allowing me to maintain a strong,
consistent level of activity and commit to the required hours.

Blogging:
I have a domain setup via Github pages at "jayatheerth.com" where
I host my portfolio site. As weekly patches flow and the project
progresses, I will host a dedicated endpoint at "/blogs" to provide
comprehensive, weekly coverage of everything that is going on with
my project.

---

6. Post GSoC Commitment
I actively follow the mailing list and intend to continue
contributing bug fixes and enhancements. I have been a part of the
Git community since 2025 and hopefully will continue to be one for
a long time.




--- End of proposal ---


Regards
- Jayatheerth
