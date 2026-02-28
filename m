Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3A3101A5
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297416; cv=pass; b=JebbwCyve8qLinUV07L5MeXE3zdyXkDSC+bRNbEmCbA0PevFXyGfJ/VqtcmqNYC49ZPulxLfOgKKUcr4ok1/FHUEyeSA6rySyS0KAKGF+YDe0qqm07MGJoMcNWYGo7PJhCSQ3zRQiFDf/5UvzhVjP5VFOoxyhOB/HK3645Gjh4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297416; c=relaxed/simple;
	bh=e0gPr2l+gXw+pmUCvg9ddz14RuiB4qsCf45rIPxwM/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ca7QV7WNXImnRXLDWJkehqcK1ys4LQ7PPzstzfcbthOOAXc3nVI8PfXMqxByypEyc+yHjwNSsri9FKg2Db2yAVFVwfptJZ8DjxSr2cuwe1HRXAXN73m5ZlXkZ/85pO38BmCjAxnniF136MFRzA91YdOoTAAOEIGVfrYyTYtFaEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jryg6Z67; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jryg6Z67"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3871a08189aso46066561fa.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772297411; cv=none;
        d=google.com; s=arc-20240605;
        b=HtAG8/FKl+C+UyFFoSybZmonAEsGtU3mB9Gz6lIZOuo/OcaWuI4cHAEK0Rg5srRkMl
         WpGNLdOdOqidXUiRYbO3fckNGcHs99Bx17rR26rGPc+xCB/ZfX0vBIHlxs97KdeedA1W
         haFXJsQJBB7Xs6FQCB4/zYrKaqX9jnN0IQffK7a+1glMfufrMtkXjf8QiuIlkvratbuF
         5aazJ91tsQDGi6XHNiI806Att2ouW7crIWPX0hWi6D+NOSQEs9TUxWw+zT25VBYENKFk
         IXsaCPGRdo7S8hEoAu13xHplUfO2dtqLSQs6ux07jS+ks9JgFuWqgQIvxncHNHYNVExl
         bQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RoiNgXfe4rl2wfZDoybziG8oepScYlKxQpMaS22dDJ4=;
        fh=868c3Ow8llJ3xowd1SxWbRLD8pwZ2GYlVWJMkzfrkuQ=;
        b=YudqCiLoqa9E4yHyp81qPe3hHT996JWJMYhFTddnZPlOFJW9XH7h0a5FJd5/U8EhJK
         tEuZjEoAIxktCRrdc71oHg5KGt3Q4tq01SAktqpgLzm07LyfIPncVDJ2kwv8V0DGfDtH
         MhcG3WkYZhV+x/fYlCN5AHRWRFKNALsrIv9R2s9sOPsvw/sWxPKwmKpSj1LywUv9OGKA
         d7Mhti6N+C376wd3DrETVFnPUnV+yG0GVaPQeB++jOKZERaqhppopLY/GyuXlbRmpJSW
         d5/oX0ctkO1cW2MKDpXZAxrLk/wl1UmOkbzk7AtAkl15tHwU+cCGqdaRLTFAvcPwGl7l
         mRAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772297411; x=1772902211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RoiNgXfe4rl2wfZDoybziG8oepScYlKxQpMaS22dDJ4=;
        b=jryg6Z67pM0cWh/n5ps9RDX9D0NBtJavi+Ag+ojGHS9et4GueGbNIKDsUE4GttLD5R
         1OcBNgtV1i0QMrzewrMgS5q9MHCU0isUTNiEtWQYAL36/1qYmm/IiyStsVVpY+o+Xs1A
         qhn5r9EMx0/bTqglCJwHW+LfgzmD/5AuQrlcuY9hGWP67lCZz5x0RXcXPMBwdK072bcp
         Q5txAr3T1oQvl5MkmwfrSGyNyZmQ02WBapQCn4cZW+XQBYEirQpzHfrojs4QXoCsxPYM
         laiRYFqraCY03GKWonk0ZhGflxaYICjQrTBGqmNshGKJWOvqvrzc3uaWEqRmk0tcHUQS
         uR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772297411; x=1772902211;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoiNgXfe4rl2wfZDoybziG8oepScYlKxQpMaS22dDJ4=;
        b=b6KlTir2EI9DKFpvD/UXK/g0/U6gmdlwtb3S/n/dlD1k9G+tcKXRM47lDuKanmNsfe
         Wn/5BTu/WPA07depH1r9y+UyPAAc2lS3jn+f/tILGqRyxS+tJfXMGwn0zQHw9ucSehiy
         5L1zdPfvbpAKDMULw/AEJU4mEK1HFYFFXRBjmE7e1JaNsQ0054MSuhTBCiOQlV9HUVjf
         KpsAxw7/gAAa2bKoz6ipBdgvvdvYojc1HWo8VHoSp5aFEBZZDUmYUyUaTakDI6NVEJEG
         PcM8nOOeHODH+wFJDjHbe2r4jsdE8l4mBryYaWymHmGpx7EEbQL9riGWj6JYQzcF5K2E
         IGhg==
X-Gm-Message-State: AOJu0YwcIcOYqGE3YU2dSztzE3Mo7To30LVZIJt741/60h8rOXxNJiiJ
	AlOJB8r+Ty8cEb/N5wvM6q5tccxDuL4paLXAPgNfwTSg7NX323k/GzeTw9JjQ7J96VdCd1KmmTZ
	X9MeuNG+ruaMnHz0FWivhgmSadBxWcDAnB8nBBG0=
X-Gm-Gg: ATEYQzy5kv6S3kD9+0eil/a/wT1mTqfd+nxLLxk/o3CoiBbZQDo6if5YN8l+tU5PE6F
	7O6/i+V8vgAH+00eroBK5G++sEcdB33V+tnvPfSo5Y1NNgH8Vp9WJrKYF2BCdKlxWpfavJtnuV+
	PqIGb/IsgH2tPRMZMT49bK1u30eC1EXW4DJqfyo/Fdb+2wx6+889vkstUEZ1EVU/GJ2E2jL1xop
	tHJu/tOlnsslVUdkWnWOw9QvBmqsAdxuHAulpjofTVEi2tR6QQ/XAw20UV1pQu6vxIsMF9XFn8w
	/KkhACW3Qg==
X-Received: by 2002:a05:651c:330:b0:389:f95d:cd85 with SMTP id
 38308e7fff4ca-389ff13bb5cmr31817961fa.18.1772297410295; Sat, 28 Feb 2026
 08:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Sat, 28 Feb 2026 22:19:59 +0530
X-Gm-Features: AaiRm53s2byO3lT8Frt_-CR7StNfEIoMMpRbmuY3H0M_zl5_VZf4od645jFJUzE
Message-ID: <CAFNBzOc=tuph7ecqt9TAY-aCWUkPyQ84DYjwMp3QS4-0J-wF_Q@mail.gmail.com>
Subject: [GSoC][PROPOSAL] Improving and Extending the git repo command
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Ayush Kumar Jha, a 4th-year student at SVNIT, India. I've been
contributing to Git for the last couple of months, mostly focusing on
reducing global state dependencies. I've really enjoyed the process of
getting to know the codebase and the community, and I'm very
interested in participating in GSoC 2026.

I've put together a draft proposal for the "Improve the new git repo
command" project. Based on my recent work trying to libify parts of
the configuration state, I feel this project aligns well with what
I've been trying to learn about Git's architecture.

I would be incredibly grateful for any feedback you might have. In
particular, I'd love to know if my planned milestones seem realistic,
or if there are specific path metadata keys or git-sizer stats that
the community feels are more important to prioritize.

Thanks in advance for your time!

Best regards,
Ayush

----------------------------------------------------------------------

GSoC 2026 Proposal: Improving and Extending the git repo command

1. Personal Information
Name: Ayush Kumar Jha
Email: kumarayushjha123@gmail.com
GitHub: https://github.com/ayush-jha123
Education: SVNIT, India (4th Year B.Tech in ECE)
Timezone: IST (UTC+5:30)

----------------------------------------------------------------------
2. Project Abstract
Git's traditional reliance on global state (like the_repository) makes
it difficult to use as a library or manage multiple repositories in a
single process. The git repo command, introduced recently, is an
excellent step toward a clean, programmatic interface for repository
metadata.

However, as an initial implementation, it still relies on some global
state under the hood and is missing a lot of path-related data that
users currently have to scrape from `git rev-parse`. Also, the
`structure` subcommand currently counts objects but has room for much
deeper health analytics.

My goal for the summer is to:
* Finish decoupling builtin/repo.c from the_repository.
* Consolidate scattered path information (git-dir, hooks, objects,
etc.) into `git repo info`.
* Port helpful repository health metrics (like tree depth and large
object detection from tools like git-sizer) into `git repo structure`
using the new path-walk API.

----------------------------------------------------------------------
3. Current Contributions
My recent contributions have been centered around the libification
effort, which helped me get familiar with the areas of the codebase
this project touches:

* [RFC GSoC PATCH v3 1/2] repo-settings: add repo_settings_get_is_bare
  Link: https://lore.kernel.org/git/20260208075905.1807-1-kumarayushjha123@gmail.com/
  Status: Superseded (Proof of Concept for libification)
  Description: The existing is_bare_repository() helper relies on the
global the_repository variable. I introduced a lazily evaluated
is_bare field inside struct repository_settings and exposed it through
a new accessor function. This allows call sites to determine bareness
using an explicit repository context.

* [RFC GSoC PATCH v3 2/2] attr: use local repository state in read_attr
  Link: https://lore.kernel.org/git/20260208075905.1807-1-kumarayushjha123@gmail.com/T/#t
  Status: Superseded (Explored safe modification of core structures)
  Description: I refactored read_attr() to determine bareness using
the repository associated with istate->repo instead of the global
helper.
  Remarks: This series went through three iterations (v1-v3) based on
great feedback from the community. Though it was ultimately superseded
by a concurrent, broader architectural redesign by other contributors,
the exercise gave me deep familiarity with Git's configuration flow
and how to safely modify core structures.

* [RFC GSoC PATCH] environment: move trust_ctime to repo_settings
  Link: https://lore.kernel.org/git/CAFNBzOdqOLKFbDFCp99GvXYWs_Af3PdeXQMjE92y+s92j78GYA@mail.gmail.com/T/#t
  Status: Dropped (Yielded to ongoing concurrent series)
  Description: Proposed moving core.trustctime to a
repository-specific structure. During review, maintainers noted
overlap with an active series migrating configuration handling to
repo_config_values. I dropped the patch to avoid duplicating effort
and to respect the ongoing work.

* doc: fix typo in tree-walk.h comment
  Link: https://lore.kernel.org/git/20260205080853.2034-1-kumarayushjha123@gmail.com/
  Status: Under Review
  Description: Corrected a duplicate word in tree-walk.h.
  Remarks: This was my first patch to get comfortable with the Git
mailing list workflow.

----------------------------------------------------------------------
4. Technical Plan

A. Decoupling from Global State
Currently, builtin/repo.c uses USE_THE_REPOSITORY_VARIABLE. For
example, get_layout_bare() calls the global is_bare_repository().
I plan to refactor builtin/repo.c to strictly use the struct
repository *repo argument passed down from git.c, replacing global
helpers with repository-scoped equivalents.
I am aware that related architectural improvements in this area are
being discussed and developed by other contributors. I will ensure my
work aligns with the direction agreed upon by maintainers and will be
happy to build on or adapt to those changes as needed.

B. Enhancing git repo info
I want to eliminate the need for users to scrape `git rev-parse` flags
to find paths. Building upon the foundational ideas discussed on the
mailing list and in branches like Lucas Oshiro's `repo-info-path`
(https://github.com/lucasoshiro/git/compare/master...repo-info-path/),
I will implement category-based querying (e.g., `git repo info
layout`).
New keys to implement:
* path.git-dir
* path.common-dir
* path.hooks
* path.objects
* path.toplevel
Note to reviewers: I'd like to hear your thoughts on whether these
paths should default to relative or absolute. My initial thought is
relative by default with an `--absolute` flag, as that seems to match
user expectations for CLI tools like `git rev-parse`.

C. Enhancing git repo structure
I want to add metrics inspired by `github/git-sizer` to help users
assess repository health:
* Maximum tree depth.
* Identification of exceptionally large blobs (with a configurable
byte threshold).
I plan to implement this using the new path-walk API for fast,
efficient traversal instead of slower rev-list approaches.

----------------------------------------------------------------------
5. Timeline

* Community Bonding (May 1 - May 26)
  Discuss the path schema (e.g., paths.* vs layout.paths.*) and
relative/absolute defaults on the list. Finalize the exact git-sizer
metrics we want to port over.

* Phase 1: Libification & Metadata (May 27 - July 11)
  Weeks 1-2: Remove the_repository from builtin/repo.c. Standardize
the use of the `repo` argument.
  Weeks 3-4: Implement category-based key filtering.
  Weeks 5-7: Implement path-related keys (git-dir, common-dir,
toplevel, hooks, objects) and write tests in t/.

* Phase 2: Advanced Structure Analysis (July 12 - Aug 18)
  Weeks 8-9: Integrate the path-walk API into cmd_repo_structure.
  Weeks 10-11: Implement tree depth counters and large object detection.
  Week 12: Buffer for fixing OS-specific path normalization issues and
fine-tuning performance.

* Wrap up (Aug 19 - Aug 26)
  Final documentation cleanup, polishing, and submitting the final report.

----------------------------------------------------------------------
6. Risks & Mitigations

* Path Normalization: Reporting paths correctly across Windows and
Linux can be tricky. I will rely on normalize_path_copy() and ensure
the test suite adequately covers edge cases on Windows environments.
* Performance: Adding heavy checks to `structure` could slow it down.
Utilizing path-walk mitigates this greatly, but I will also ensure
these checks are fast enough on large repos (like linux.git) or place
the deepest analytics behind an `--expensive` flag if necessary.

----------------------------------------------------------------------
7. Availability
I can commit 35-40 hours a week to this project over the summer. I
plan to be highly active on the mailing list and IRC for reviews and
discussions.

----------------------------------------------------------------------
8. Resources & References
To ensure my proposal aligns with the community's vision, I have been
studying the following resources:
* Original discussion on `git repo info`:
  https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshiro@gmail.com/t/#u
* Lucas Oshiro's exploratory branch for path metadata:
  https://github.com/lucasoshiro/git/compare/master...repo-info-path/
* The `github/git-sizer` repository for identifying ideal health metrics.
* Official documentation for `git-repo(1)` and `git-rev-parse(1)`.
