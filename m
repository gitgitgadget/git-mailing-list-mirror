Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4A383C7A
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546863; cv=none; b=BpifbI3kfAeVQUzSuHAvVZ7uP1Mi1g5U0N/GsyC1+NmKZiC8kxsI1Ryhoj8yKoABAyOyxc2zOytShaDZT6fc0ZtCCKDY7yGJUo4shEZrTNI1Kn3EDXGmcMUguz1pS1dXeZhqFy8FS1gmNjxvc3CFV7vIo8vcsof2L95EVfLaR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546863; c=relaxed/simple;
	bh=JnkPqSoOYBwcMHDEuMXgIqFwXqI3hGFZ0PtnvP1SGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8qKH9rST33QtSRKOFcLwbXUG83aKaIRw+fUjtj85Nu04OWXB/ZyAPrs3D0Zoa9mg9f/lfD2sTIjknJg0E7RG1fTis5Fh+sDmW/X40bc0I+jxsKMx82ZiTn9flCMCVhB0fhKXR97aXIn4+BIp8/goqygti7rSf3UMkU1HIIoL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+iwDyT+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+iwDyT+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad4d639db3so26320155ad.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546861; x=1773151661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbFi/Nls+spV3hVPjUGoP3KspHhgulTNjlnZjy6LeFE=;
        b=b+iwDyT+N2YXOQAi1nk2Qsj78kZLu0yecvzL/6XI9SC6thZK3Z/u+EV09RSu+9lOSm
         YCusLPyi06rxpR2B0nOFRn6BGNocLKlbdrlru48uTVv+eGzndrYrqecVDF0/sUpj4vVu
         RJ4nseMwBSLZTWured4g6YmslPWAMu+sNdwl5yLNXfhXIFvEmMzS/HZxWD43xmSpyq/L
         n73VO5VQId0HRxm9VPBCnY0vaqUgLgI32uOBkwcg3xCw85DoUJdRS4vqc5STU/JRxGj7
         o28/YzPXp+rWMczPz7QhDkeD+69PLnDuiikfGgw4JQvXalWc+W6gn/s5QpIAx/AIZ8z6
         Hltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546861; x=1773151661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbFi/Nls+spV3hVPjUGoP3KspHhgulTNjlnZjy6LeFE=;
        b=qY9FvD7Aaj6vSPW1dLSOT7Cb6c2bdE+ZNjRjLEZ4+/FMkjRuHyxxnhorUumNfQCFlk
         tTG1NApwFEGEbfi1nuEAYE/Rl/DP4sn/oB0tAQYvGkcjX2BCTtBvN/auSxSxzxVFjk9V
         4XwX2mtGfK+dWsqsdmWCv1l1sNN5obSH6mgZc/xWyloFip1qOEFqh2LsQsgdqOKkRtoX
         /Uoq9SpWle4PB/Q/8CMTcPJEvz/u/wPjDTe3xuW1aKBWiGOC3ZPLGViYKJ8Q+JlpUewT
         jGDXinWFdiF3NPLo9Q/sCK6M5FNq5oMur06TiIsKL/npqJcoQzES3AZOHV7BxDdVhvzB
         JuAg==
X-Gm-Message-State: AOJu0Yy1DA24R4uoNgRgApak3Dq8woKwlsJPvZ6gsItlKgNJr9HgFlFG
	AvFgZNnhuea0mml+qLNZwzIu2vNoIAqJZ3gzVHgHTM26wxzsP5eCdstxDXtVIQ68dHU=
X-Gm-Gg: ATEYQzwcwb++iNPJkcigGfo8q64B8fSF0Yx6veVkKr81M/dvN9mqnndMrh9srHkzlE9
	hBwT5+yjT35WIkXLwVyS7IdfwmtR9f5h8pXaFMcGKtanw69sT6ICw5puYQM2VdKsM+WKeHISMah
	KCwEU26be5Jy/kjs2J7VCIG3g7YCLLZxCm4JE03SKgWdOenRuKyHGHedvD4STjhpKXKvtwgdVzU
	2n826xXn494vLJcOsfO9eXvzYsgtZxnWiWln5qASwuXIqAM7mjg+C+D/aFdHAw5agBYQuWZRnPb
	ZBcSVuPldVwMUBiRnVmDnGcmZ0a123j3JvNu1kZUNoOSXdaO7jVc+HteLSrbc3mYoacQV91jXS3
	2ewkLLFzCN3rGlbqERG30hlgGxa4svex8B9QeCgM7QTusQSeDCYd/3t7mQZtO9cqRlIGKkwAY8R
	Nx9CyM7NzEMgXUgjEmXBCj8O6ueXgGt2+ZtJtAFkJxOWw+7scDSrD8q7c=
X-Received: by 2002:a17:903:2351:b0:2ae:4ebc:71d5 with SMTP id d9443c01a7336-2ae4ebc7353mr66142755ad.52.1772546860982;
        Tue, 03 Mar 2026 06:07:40 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4cd40e4dsm72673375ad.92.2026.03.03.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:07:39 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	ayu.chandekar@gmail.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [RFC][GSoC 2026] Proposal: Improve the new git repo command
Date: Tue,  3 Mar 2026 14:07:32 +0000
Message-ID: <20260303140732.16886-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,=0D
I would like to share my proposal for "Improve the new git repo command" un=
der GSoC 2026.=0D
=0D
The Doc version:=0D
https://docs.google.com/document/d/1HM1HNQqUrGdqFdUppc02BTmPuwXC2ozCw9mLrba=
VUHc/edit?usp=3Dsharing=0D
=0D
I'd appreciate any feedback on this.=0D
=0D
Thanks,=0D
Pushkar=0D
---------8<----------8<----------8<----------8<----------8<----------8<----=
------8<----------8<=0D
=0D
GSoC 2026 @ Git | Pushkar Singh=0D
Improve the new git repo command=0D
---------------------------------------------------=0D
=0D
=0D
Personal Information:=0D
---------------------=0D
Name: Pushkar Singh=0D
E-mail: pushkarkumarsingh1970@gmail.com=0D
=0D
Education: XIM University, Bhubaneswar, Odisha, India=0D
Year: II/III=0D
Degree: Bachelors in Computer Engineering=0D
=0D
Time-Zone: UTC + 5:30 (IST)=0D
=0D
Personal page: https://pushkarscripts.com/=0D
Blog: https://medium.com/@pushkarscripts/=0D
GitHub: https://github.com/pushkarscripts/=0D
=0D
=0D
Pre-GSOC:=0D
---------=0D
=0D
I began exploring Git=E2=80=99s codebase by studying its documentation, =0D
reviewing prior mailing list  discussions, and building Git =0D
from source. =0D
=0D
I focused on understanding the test framework, patch submission=0D
workflow using git send-email, versioned patch iteration, and =0D
the review culture on the mailing list.=0D
=0D
After becoming familiar with the contribution process, I started=0D
submitting patches.=0D
=0D
=0D
Contributions to Git (Chronological Order):=0D
-------------------------------------------=0D
=0D
* [PATCH v4] t1300: use test helpers instead of test builtins=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260104194812.15134-1-pushkarkumar=
singh1970@gmail.com/t/#u=0D
This patch is my first contribution to fulfill microproject =0D
criteria. It replaces legacy test -f and test -h checks with=0D
test_path_is_file and test_path_is_symlink in the test suite.=0D
=0D
* [PATCH v2] t1410: use test helpers in reflog rewind test=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260111191525.17087-1-pushkarkumar=
singh1970@gmail.com/t/#u=0D
Replaced raw file existence checks in the reflog rewind test=0D
with test_path_is_file and test_path_is_missing. The subject=0D
and commit message were refined in v2 following review feedback.=0D
=0D
* [PATCH] Documentation/config: fix replacement for --get-urlmatch=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260115110832.15315-1-pushkarkumar=
singh1970@gmail.com/T/#u=0D
    Related Bug Report: https://lore.kernel.org/git/CAGJzqs=3D0Zr2iqsTUZdjd=
wpbtaS7kuBOf=3DE_XT=3DvbdfyNTKkjNQ@mail.gmail.com/t/#u=0D
Corrected documentation that incorrectly suggested combining =0D
--url with --all for --get-urlmatch. Verified the behavior =0D
against the implementation and updated the documentation =0D
accordingly.=0D
=0D
* [PATCH v4] subtree: validate --prefix against commit in split=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260203164815.68258-2-pushkarkumar=
singh1970@gmail.com/T/#u=0D
    Related Bug Report: https://lore.kernel.org/git/CAFePT4xDGegpEFuFemCXsH=
890E2WXnG3JzUZeiLi9KW8D8beOg@mail.gmail.com/T/#u=0D
Updated git subtree split to validate --prefix against the =0D
specified commit rather than the working tree. The change =0D
addresses a mailing list report where --prefix was incorrectly =0D
validated against the current working directory instead of the=0D
given revision. Added regression tests and revised the patch =0D
across four versions following review and CI feedback before =0D
integration into next.=0D
=0D
* [RFC] git repo info: expose repository paths=0D
    Status: Under discussion=0D
    Thread: https://lore.kernel.org/git/20260218183511.17195-1-pushkarkumar=
singh1970@gmail.com/t/#mdd8548b634142f4916e2911f7025e736a4789a07=0D
Proposed extending git repo info to expose additional repository=0D
path-related values currently accessible via git rev-parse. =0D
Initiated design discussion regarding path handling and output =0D
format, incorporating feedback during iteration.=0D
=0D
* [PATCH v3] path: refactor normalize_path_copy_len for clarity=0D
    Status: Merged into next=0D
    Thread: https://lore.kernel.org/git/20260221110511.1592-2-pushkarkumars=
ingh1970@gmail.com/t/#u=0D
Proposed a refactor of normalize_path_copy_len to improve =0D
clarity while preserving existing control flow. The discussion=0D
focused on maintaining readability and minimizing structural =0D
changes.=0D
=0D
Additional Participation:=0D
=0D
In addition to submitting patches, I have:=0D
* Reviewed patches from other contributors=0D
    (1) https://lore.kernel.org/git/20260202134657.15320-1-pushkarkumarsing=
h1970@gmail.com/T/#u=0D
    (2) https://lore.kernel.org/git/CALE2CrQFZngj6_NDuf0S=3D_-nDrrf6b6r=3DC=
9jMyEVjwMqvh6J2w@mail.gmail.com/=0D
    (3) https://lore.kernel.org/git/CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6y=
cBYvFpWMEEtA@mail.gmail.com/T/#u=0D
    (4) https://lore.kernel.org/git/CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfb=
XCHrAQSEyDoA@mail.gmail.com/T/#u=0D
    (5) https://lore.kernel.org/git/CALE2CrQTvHeu21yLXtRg=3DA6ak9AB_vvwPirQ=
NFDjZ2AmhoTzTQ@mail.gmail.com/T/#u=0D
    (6) https://lore.kernel.org/git/CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ=
3i+OGqbxwPcg@mail.gmail.com/T/#u=0D
* Assisted in resolving a git rebase issue on the mailing list=0D
    (1) https://lore.kernel.org/git/CALE2CrQ415Ewm_F-DLZu=3DJY2BTWofmGgorEO=
a0D=3DUSr5d510SQ@mail.gmail.com/T/#madfc34c4334a7d62baa18b18e3c8fa83600f845=
5=0D
* Studied the original discussions on git repo=0D
    (1) https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshir=
o@gmail.com/t/#u=0D
    (2) https://lore.kernel.org/git/20251207190532.67107-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (3) https://lore.kernel.org/git/20260218211845.96009-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (4) https://lore.kernel.org/git/20260203221758.1164434-1-jltobler@gmail=
.com/T/#u=0D
* Examined the implementation in builtin/repo.c=0D
=0D
=0D
The Plan=0D
--------=0D
=0D
I plan to approach this project incrementally, following Git=E2=80=99s=0D
review-driven workflow. I will introduce changes in small, =0D
logically isolated patches to keep review manageable and avoid=0D
unintended side effects.=0D
=0D
Extensions to git repo will be introduced incrementally and=0D
only after review consensus on preceding changes.=0D
=0D
I will begin by focusing on foundational repository path keys,=0D
as they provide immediate structural value and align closely=0D
with existing rev-parse functionality.=0D
=0D
For each proposed key or enhancement, I will:=0D
=0D
  - Confirm exact behavioral parity with existing helpers.=0D
  - Clarify semantics (absolute vs relative paths, edge cases)=0D
    through mailing list discussion before finalizing behavior.=0D
  - Introduce one key (or one tightly related group) per patch.=0D
  - Add targeted tests covering:=0D
        * bare repositories=0D
        * linked worktrees=0D
        * submodules=0D
        * shallow clones=0D
  - Update documentation accordingly.=0D
=0D
Bulk additions will be avoided. The goal is steady maturation,=0D
not rapid feature expansion.=0D
=0D
=0D
Path Key Expansion=0D
------------------=0D
=0D
I will incrementally expose selected repository path values=0D
currently accessible via:=0D
=0D
  - git rev-parse=0D
  - git rev-parse --git-path=0D
=0D
The initial focus will be on a small set of foundational keys,=0D
selected in coordination with maintainers, beginning with =0D
path.git-dir and path.common-dir. Additional keys will only be=0D
introduced after review consensus.=0D
=0D
Each key will be evaluated individually to ensure clarity,=0D
necessity, and consistent semantics.=0D
=0D
=0D
Optional: Category-Based Queries (If Aligned)=0D
--------------------------------------------=0D
=0D
If maintainers consider it useful, I may introduce explicit,=0D
deterministic grouped queries such as:=0D
=0D
  git repo info paths=0D
=0D
This will only be attempted after core path parity stabilizes,=0D
and only if consensus exists. No implicit behavior will be added.=0D
=0D
=0D
Architectural Considerations=0D
----------------------------=0D
=0D
Since git repo info is intended as a plumbing command,=0D
predictability and explicitness will be prioritized over=0D
convenience defaults. The command should return only what=0D
is explicitly requested, avoiding implicit behavior that=0D
may affect scripts.=0D
=0D
Where appropriate, I will:=0D
=0D
  - Prefer explicit repository context over global state.=0D
  - Avoid duplicating logic already implemented in rev-parse. =0D
    Where possible, I'll reuse existing helper functions rather =0D
    than reimplement path resolution logic.=0D
  - Maintain stable and predictable output for users and tooling.=0D
=0D
Structural refactoring will only be undertaken when directly=0D
relevant to git repo and supported through review discussion.=0D
=0D
=0D
Timeline=0D
--------=0D
=0D
The timeline below reflects Git=E2=80=99s iterative, review-driven workflow=
.=0D
Foundational improvements are prioritized to ensure meaningful=0D
deliverables even if review cycles extend.=0D
=0D
=0D
Pre-Coding Preparation (Before Official Start)=0D
=0D
- Continue participating in git repo discussions.=0D
- Refine and narrow scope of path key expansion.=0D
- Confirm semantics for absolute vs relative path handling.=0D
- Define patch ordering to keep submissions small=0D
  and logically independent.=0D
=0D
=0D
Community Bonding Period (May)=0D
=0D
Primary objective: finalize scope and ordering.=0D
=0D
- Confirm priority list of path keys.=0D
- Align on output stability expectations.=0D
- Clarify whether category-based queries are desirable=0D
  in this cycle or deferred.=0D
- Identify architectural considerations relevant=0D
  to builtin/repo.c.=0D
=0D
Implementation will follow once semantics are reasonably =0D
aligned through mailing list discussion.=0D
=0D
=0D
Phase 1 (Weeks 1=E2=80=934): Foundational Path Keys=0D
=0D
Objective: establish core path parity in git repo info=0D
with essential rev-parse values.=0D
=0D
* Weeks 1=E2=80=932:=0D
  - Submit path.git-dir=0D
  - Submit path.common-dir=0D
=0D
  These foundational keys will be introduced early to=0D
  validate semantics and stabilize output expectations.=0D
=0D
* Week 3:=0D
  - Submit path.toplevel=0D
  - Submit path.superproject-working-tree=0D
=0D
  These additions will extend coverage to working-tree=0D
  and submodule-aware contexts.=0D
=0D
* Week 4:=0D
  - Submit selected stable --git-path equivalents=0D
    (e.g., path.index-file, path.objects-dir),=0D
    introduced incrementally, one per patch.=0D
=0D
Each key will be submitted independently. Subsequent =0D
patches will be sent after consensus on earlier changes=0D
is reasonably established, enabling overlap between =0D
submission and iteration.=0D
=0D
Midpoint Goal:=0D
 Deliver foundational path keys that are either merged or=0D
 in next, with consensus on semantics.=0D
=0D
=0D
Phase 2 (Weeks 5=E2=80=938): Additional Path Keys & Refinement=0D
=0D
- Complete remaining agreed-upon --git-path parity keys.=0D
- Address review-driven adjustments from Phase 1.=0D
- Stabilize behaviour across edge-case environments.=0D
=0D
This phase intentionally allows time for review-driven=0D
iteration without expanding scope.=0D
=0D
=0D
Phase 3 (Weeks 9=E2=80=9310): Refinement and Stability=0D
=0D
- Improve tests for edge cases discovered during review.=0D
- Revisit earlier patches if requested.=0D
=0D
=0D
Final Weeks (Weeks 11=E2=80=9312): Consolidation=0D
=0D
- Finalize remaining review iterations.=0D
- Refine or restructure patches if requested.=0D
- Finalize documentation.=0D
- Ensure CI stability and cross-platform behavior.=0D
=0D
No new features will be introduced during this period.=0D
=0D
=0D
Prioritization Under Constraints=0D
--------------------------------=0D
=0D
Given Git=E2=80=99s iterative review process, I have structured the=0D
project so that foundational improvements are delivered first.=0D
=0D
If review cycles extend longer than anticipated, priority will be:=0D
=0D
1. Core path parity (path.git-dir, path.common-dir,=0D
   path.toplevel, path.superproject-working-tree)=0D
2. Additional agreed --git-path equivalents=0D
3. Category-based queries=0D
=0D
This ordering ensures that the most architecturally meaningful=0D
enhancements are completed even if optional improvements=0D
must be deferred.=0D
=0D
=0D
Post-GSoC Continuation=0D
----------------------=0D
=0D
My involvement in Git is not limited to the GSoC period.=0D
=0D
After the coding phase, I intend to:=0D
- Continue refining git repo through incremental improvements.=0D
- Address follow-up review feedback or deferred enhancements.=0D
- Participate in reviewing related patches where appropriate.=0D
- Contribute to ongoing efforts around repository introspection=0D
  and gradual libification.=0D
=0D
Over time, I hope to contribute not only through patches,=0D
but also by helping new contributors navigate the mailing=0D
list workflow and patch iteration process.=0D
=0D
If given the opportunity in the future, I would be glad to=0D
support mentoring efforts and help the community grow further.=0D
=0D
=0D
Availability=0D
------------=0D
=0D
My end-semester examinations conclude on March 28.=0D
Following this, I will not have academic obligations=0D
during the GSoC coding period.=0D
=0D
The project is expected to fall within the 175=E2=80=93350 hour=0D
range. I am prepared to commit at the higher end of this=0D
range.=0D
=0D
During the official coding phase (approximately 12 weeks),=0D
I will be available for 30=E2=80=9335 hours per week. This allows=0D
for approximately 360=E2=80=93420 hours of focused development time,=0D
comfortably covering the expected project scope.=0D
=0D
I will also remain active on the mailing list during the=0D
community bonding period and will use that time to refine=0D
design decisions and prepare patch sequencing.=0D
=0D
I do not anticipate any internships, travel, or major=0D
commitments that would interfere with this schedule.=0D
=0D
=0D
Blogging:=0D
---------=0D
=0D
I have been writing technical articles on Medium for over a =0D
year, primarily focused on Git workflows, developer tooling,=0D
and lessons from working with real codebases.=0D
=0D
During the GSoC period, I plan to publish bi-weekly updates=0D
documenting progress and mailing list discussions to maintain=0D
transparency and assist future contributors.=0D
=0D
Medium: https://medium.com/@pushkarscripts=0D
=0D
=0D
Risk Assessment and Mitigation=0D
------------------------------=0D
=0D
1. Review Cycle Duration=0D
=0D
Given Git=E2=80=99s iterative mailing list workflow,=0D
patches may require multiple revisions before acceptance.=0D
=0D
To mitigate this, I have structured the project so that =0D
foundational path keys are delivered first.=0D
=0D
To reduce review friction, patches will be small, logically=0D
isolated, and submitted only after validating behavior against=0D
existing helpers.=0D
=0D
2. Scope Creep=0D
=0D
Expanding beyond agreed path parity work may =0D
introduce unintended scope growth.=0D
=0D
Mitigation:=0D
  Optional enhancements (categories and additional=0D
  metrics) are explicitly deferred until foundational=0D
  work stabilizes.=0D
=0D
3. Semantic Ambiguity=0D
=0D
Path-related behavior (absolute vs relative,=0D
worktree interactions, submodules) may require=0D
careful alignment.=0D
=0D
Mitigation:=0D
  Semantics will be clarified during the bonding=0D
  period and validated against existing helpers=0D
  before implementation.=0D
=0D
---=0D
=0D
Thank you for your time and for reviewing this proposal.=0D
I look forward to contributing further to the project =0D
and continuing to learn through the review process.=0D
=0D
Regards,  =0D
Pushkar Singh=0D
