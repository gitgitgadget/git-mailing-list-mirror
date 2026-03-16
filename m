Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA84204E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666281; cv=none; b=gk1bkOSIifVFLJ8AOuejq9lEDgDw33FgVmyDAymC/IzyauclBR692wHZ92N9CRYa7AbjHTH5PdYJgYAGSZL6pyYr5qf9kYh4ageNB4xjkRjSZ1Q7iVtJ494+8TeKtTFJCW//5mpicr4FEAxer3T4YzS2WTbXw28dYGAErWr0TTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666281; c=relaxed/simple;
	bh=VVm/gSsF1MFsuSySkaNKyrtj+HK2LLgGvdzMqXY7jAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlUL0bxvO11g3KgHYmtbV+Bg2ktbvJUEiGzRCCH7QqnIoHvuz/r4WgODNY6kkIlwqKfIMEnkpYJnlZMhb55nHfITrs3vc0fLdKPb8Z8LcpbDcVdsdu1AmdwUapmPsMx0ZS69RDc/bjzL7KbU3oavY5uKtu/maNaldryqAg0hkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re3MMcaA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re3MMcaA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b04d051664so13726755ad.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773666279; x=1774271079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENPkajLcXHbSd3uC6miOHHHm2nr5UeSEOUlu2DC2ZW4=;
        b=Re3MMcaAvZ3QHg0YCyDX5C19YmkP1ikHf7uNPYp6ld+iozK37NBzsYjYpw9dUGE9BM
         sSSUyUhu7d8KTgM/R1poPilw19NYG1prCsQiG2dfNWXAum3C4lS9WtrjJ+CajUWlqyOJ
         5y8jyEojdcrq5Wc7aJo6ijtbU86D3HgPVxIGlMAr5Zt6oY1iVB3iF9xQs14LX6HSCe7i
         mgIYxZEdIoYEh0TNHIteZq7GYtnA0qWQfByQpYNIa95nnqK3TTB7PZ6Wxf8g7iBoT5uR
         Peit9k8RNttKrJdrQwg+jJVKhM9HYLMps2BqLI3jj3fvzZJOOBI4T9lwXvClYRXVYDNI
         AWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773666279; x=1774271079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENPkajLcXHbSd3uC6miOHHHm2nr5UeSEOUlu2DC2ZW4=;
        b=YK6mXElxCF1SdynVOmz1j3xtF5usMYZA6Q24QKU5AW1gV6UBVusGr40N1HvdPNmCFp
         NWHgSN+Iz9ikNinHVa0qDYnTW0KB+botTEFQFCxm9Q1KWUm6z413zGRbhO3j6GpWJxdr
         z6kVgAoM8MMU8MOmBaMIlNfkpOhp3IvbIuxUprHqj5cWrQ1la1Evq4Qvba9AzcXwHA+D
         V0w4chHLM4HkoZkbEdppn/UOAAcxQ6WRyxoHdpAUVv9p8YONbi/nrmsiJDFPc5TX8aIh
         JAvhIzUx/72hT6ShQ7AImkP1wgDRYUqM6NxRrDTfB3b+kA5zD6otKt+CcXSW6zCgSpUC
         I1bg==
X-Gm-Message-State: AOJu0Yxl15xj5PazJYM0FjmlWf9dGS/NZ2fx1YP75PUQZi1n++Y/H58A
	+Resu47E8ymSFz7A1QsR8vT+ieIegHG5eqXtujjECYLWUp5UE8NufJZnDHNGPjtl
X-Gm-Gg: ATEYQzzcu3xiSewbhvTQVjHycgpBw1aVc9XA0AJQJpID9xfJk2tG+S+jlyPc93klQow
	XrdZLumd6W2Q4MrDzKO1P33Atfd5eSVzByhTwIpqd4kmfgvmblKdT2HIxrU39COWQOFVGSsupgg
	Iet+U5kKgY1Ez0EO9T6UR+3gj7KiilZCisRUHMGbvhryoaVo6NtIc2dboBsWtQtGy5KGq+DjxvV
	a0qGbm5uLlyjXOb10D3zpW0YZiQYTF2uYQLav6ZKVwE6luqD7eRku0CKtXDJDQO3wWWKu3W4gML
	VsExHwRcpBLrq8OD548CSOSorhqvnivKINLsrKdkD9FzushtQVBNNcmG/kgOQMRVXbeiAqgZ2ba
	wTRUfP3oKRIGH8aFvWGg/vImuHThNIR9uXjtZXYX3+372sKgjfPDJ9GqXVGNEgCCIINN1k32Uut
	K1A5DzCW+73Az8jSMCGZK5zkRSZLohLy84xc9epZHH8nUT
X-Received: by 2002:a17:903:f84:b0:2ae:b9cd:d2ce with SMTP id d9443c01a7336-2aecaaad664mr116524595ad.27.1773666278385;
        Mon, 16 Mar 2026 06:04:38 -0700 (PDT)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0542909d8sm54959385ad.31.2026.03.16.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:04:37 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [GSoC][RFC v2] Proposal: Improve the new git repo command
Date: Mon, 16 Mar 2026 13:04:31 +0000
Message-ID: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,=0D
This is the second version of my proposal for "Improve the new git repo com=
mand" in Google Summer of Code 2026. =0D
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
Degree: Bachelors in Computer Science & Engineering=0D
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
reviewing prior mailing list discussions, and building Git from =0D
source. =0D
I focused on understanding the test framework, patch submission =0D
workflow using git send-email, versioned patch iteration, and =0D
the review culture on the mailing list.=0D
=0D
After becoming familiar with the contribution process, I started =0D
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
criteria. It replaces legacy test -f and test -h checks with =0D
test_path_is_file and test_path_is_symlink in the test suite.=0D
=0D
* [PATCH v2] t1410: use test helpers in reflog rewind test=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260111191525.17087-1-pushkarkumar=
singh1970@gmail.com/t/#u=0D
Replaced raw file existence checks in the reflog rewind test =0D
with test_path_is_file and test_path_is_missing. The subject =0D
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
* [PATCH v3] path: refactor normalize_path_copy_len for clarity=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260221110511.1592-2-pushkarkumars=
ingh1970@gmail.com/t/#u=0D
Proposed a refactor of normalize_path_copy_len to improve =0D
clarity while preserving existing control flow. The discussion=0D
focused on maintaining readability and minimizing structural =0D
changes.=0D
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
validated against the current working directory instead of the =0D
given revision. Added regression tests and revised the patch =0D
across four versions following review and CI feedback before =0D
integration into next.=0D
=0D
* [RFC] git repo info: expose repository paths=0D
    Status: WIP, Under discussion=0D
    Thread: https://lore.kernel.org/git/20260218183511.17195-1-pushkarkumar=
singh1970@gmail.com/t/#mdd8548b634142f4916e2911f7025e736a4789a07=0D
Proposed extending git repo info to expose additional repository=0D
path-related values currently accessible via git rev-parse.=0D
Initiated design discussion regarding path handling and output=0D
format, incorporating feedback during iteration.=0D
=0D
Additional Participation:=0D
=0D
In addition to submitting patches, I have:=0D
*  Reviewed patches from other contributors=0D
    (1) https://lore.kernel.org/git/CALE2CrTzYbMam_fi5HszSUFVZADE1haLtpBqhU=
md1ki9biM2hA@mail.gmail.com/T/#u=0D
    (2) https://lore.kernel.org/git/20260202134657.15320-1-pushkarkumarsing=
h1970@gmail.com/T/#u=0D
    (3) https://lore.kernel.org/git/CALE2CrQFZngj6_NDuf0S=3D_-nDrrf6b6r=3DC=
9jMyEVjwMqvh6J2w@mail.gmail.com/=0D
    (4) https://lore.kernel.org/git/CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6y=
cBYvFpWMEEtA@mail.gmail.com/T/#u=0D
    (5) https://lore.kernel.org/git/CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfb=
XCHrAQSEyDoA@mail.gmail.com/T/#u=0D
    (6) https://lore.kernel.org/git/CALE2CrQTvHeu21yLXtRg=3DA6ak9AB_vvwPirQ=
NFDjZ2AmhoTzTQ@mail.gmail.com/T/#u=0D
    (7) https://lore.kernel.org/git/CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ=
3i+OGqbxwPcg@mail.gmail.com/T/#u=0D
*  Assisted in resolving a git rebase issue on the mailing list=0D
    (1) https://lore.kernel.org/git/CALE2CrQ415Ewm_F-DLZu=3DJY2BTWofmGgorEO=
a0D=3DUSr5d510SQ@mail.gmail.com/T/#madfc34c4334a7d62baa18b18e3c8fa83600f845=
5=0D
*  Studied the original discussions on git repo=0D
    (1) https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshir=
o@gmail.com/t/#u=0D
    (2) https://lore.kernel.org/git/20251207190532.67107-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (3) https://lore.kernel.org/git/20260218211845.96009-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (4) https://lore.kernel.org/git/20260203221758.1164434-1-jltobler@gmail=
.com/T/#u=0D
*  Examined the implementation in builtin/repo.c=0D
=0D
=0D
The Plan=0D
--------=0D
=0D
I will be iterating on this project in blocks and with the=0D
review-driven approach. By introducing every changes in small,=0D
logically isolated patches, I'll ensure clarity, ease-of-review,=0D
and architectural stability.=0D
=0D
First I want to cover foundational repository path keys,=0D
because they create instant structural value and more closely fit=0D
with existing functionalities of rev-parse.=0D
=0D
For every key proposed or enhancement made, I will:=0D
=0D
  - Ensure behavior matches with existing helpers.=0D
  - Clarify semantics(absolute vs relative paths, edge cases) by=0D
    discussing on the mailing list before finalizing the behavior.=0D
  - Add one key (or one closely tied family of keys) per patch.=0D
  - Add targeted tests covering:=0D
        * bare repositories=0D
        * linked worktrees=0D
        * submodules=0D
        * shallow clones=0D
  - Update documentation accordingly.=0D
=0D
I will avoid large changes and focus on small, reviewable patches,=0D
instead of rapidly expanding features.=0D
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
My initial focus will be on foundational keys such as:=0D
=0D
  path.git-dir=0D
  path.common-dir=0D
  path.toplevel=0D
  path.superproject-working-tree=0D
=0D
Subsequent patches may introduce additional --git-path=0D
equivalents such as:=0D
=0D
  path.index-file=0D
  path.objects-dir=0D
  path.config-file=0D
=0D
Each key will be evaluated individually to ensure clarity,=0D
necessity, and consistent semantics.=0D
=0D
=0D
Optional: Category-Based Queries (If Aligned)=0D
--------------------------------------------=0D
=0D
If agreed upon through mailing list discussion, I will introduce=0D
explicit grouped queries, such as:=0D
=0D
  git repo info paths=0D
=0D
The expansion will still be deterministic and predefined.=0D
I'll not be introducing any implicit or dynamic grouping behavior.=0D
=0D
=0D
repo structure Enhancements=0D
---------------------------=0D
=0D
If maintainers deem it appropriate maybe I will tackle some =0D
carefully scoped improvements to git repo structure.=0D
=0D
Potential areas include:=0D
  - Distribution-oriented metrics, only if aligned with the=0D
    tool=E2=80=99s long-term direction.=0D
  - Low-friction structural metrics (e.g., path depth),=0D
    as long as they do not add excessive traversal cost.=0D
=0D
Any such enhancement will be introduced in small,=0D
standalone patches, taking performance, maintainability, =0D
and output stability into account. If scope or review=0D
timelines demand, this stage will be delayed.=0D
=0D
=0D
Architectural Considerations=0D
----------------------------=0D
=0D
Where appropriate, I will:=0D
=0D
  - Prefer explicit repository context over global state.=0D
  - Avoid duplicating logic already implemented in rev-parse. =0D
    Where possible, I'll reuse existing helper functions rather =0D
    than reimplementing path resolution logic.=0D
  - Preserve conservative output stability.=0D
=0D
Structural refactoring will only be undertaken when directly=0D
relevant to git repo and supported through review discussion.=0D
=0D
=0D
Timeline=0D
--------=0D
=0D
Keeping Git's iterative and review-driven workflow in mind, I've =0D
designed the timeline to focus on core enhancements in order to =0D
ensure that I can produce meaningful deliverables even if review =0D
cycles extend.=0D
=0D
=0D
Pre-Coding Preparation (Before Official Start)=0D
=0D
- Continue participating in git repo discussions.=0D
- Improve and restrict scope of path key expansion.=0D
- Confirm semantics for absolute vs relative path handling.=0D
- Define patch ordering to keep the submissions small=0D
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
I will get to implementation once the semantics feel reasonably=0D
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
  I'll present these foundational keys early on to keep =0D
  semantics consistent, and stabilize output expectations.=0D
=0D
* Week 3:=0D
  - Submit path.toplevel=0D
  - Submit path.superproject-working-tree=0D
=0D
  These will provide working-tree inspection coverage to=0D
  and submodule-aware contexts.=0D
=0D
* Week 4:=0D
  - Submit selected stable --git-path equivalents=0D
    (e.g., path.index-file, path.objects-dir),=0D
    introduced incrementally, one per patch.=0D
=0D
I'll submit each key independently. When semantics are =0D
already aligned, I'll send consecutive patches while=0D
older ones will remain pending, which allows a significant =0D
overlap between submission and iteration.=0D
=0D
Midpoint Goal:=0D
 Deliver foundational path keys that are either merged or=0D
 in next, with consensus on semantics.=0D
=0D
=0D
Phase 2 (Weeks 5=E2=80=938): Additional Path Keys & Refinement=0D
=0D
- Finish the remaining agreed --git-path parity keys.=0D
- Address changes from review cycles of Phase 1.=0D
- Stabilize behaviour across edge-case environments.=0D
=0D
This phase purposely leaves time for review-guided=0D
iteration without expanding scope.=0D
=0D
=0D
Phase 3 (Weeks 9=E2=80=9310): Optional Enhancements=0D
=0D
Only if Phase 1 and 2 stabilize earlier than expected,=0D
I'll begin:=0D
- Introducing the grouped category queries(e.g., info paths),=0D
  subject to prior agreement.=0D
- Carefully extending repo structure with one metric =0D
  at a time.=0D
=0D
I=E2=80=99m not going to attempt any bulk metric expansion here.=0D
=0D
=0D
Final Weeks (Weeks 11=E2=80=9312): Consolidation=0D
=0D
Over the last weeks of this program, I will:=0D
- Address remaining review feedback.=0D
- Adjust patches if requested or rework them.=0D
- Finalize documentation.=0D
- Ensure CI stability and cross-platform behavior.=0D
=0D
During this time no new features will be introduced.=0D
=0D
=0D
Prioritization Under Constraints=0D
--------------------------------=0D
=0D
Considering Git=E2=80=99s iterative review process, I have structured the=0D
project so that foundational improvements are delivered first.=0D
=0D
If review cycles extend longer than anticipated, my priority will be:=0D
=0D
1. Core path parity (path.git-dir, path.common-dir,=0D
   path.toplevel, path.superproject-working-tree)=0D
2. Additional agreed --git-path equivalents=0D
3. Category-based queries=0D
4. repo structure metric extensions=0D
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
For the past one year I have been writing technical articles =0D
on Medium, mostly related to Git workflows, developer tooling, =0D
and lessons from working with real codebases.=0D
=0D
I will be sharing weekly updates for the GSoC period to document =0D
progress and the discussions on these mailing lists for =0D
transparency, and more importantly, to help future contributors.=0D
=0D
Medium: https://medium.com/@pushkarscripts=0D
=0D
=0D
Risk Assessment and Mitigation=0D
------------------------------=0D
=0D
1. Review Cycle Duration=0D
=0D
Considering Git=E2=80=99s iterative mailing list workflow, existing =0D
patches might go through several updates before being =0D
accepted.=0D
=0D
Mitigation:=0D
  The project is structured so that foundational path=0D
  keys are delivered first. Independent patches allow=0D
  parallel review and refinement.=0D
=0D
2. Scope Creep=0D
=0D
Expanding both path keys and structure metrics=0D
may introduce unintended scope growth.=0D
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
Thank you for your time and consideration. I look forward=0D
to contributing further to the project and continuing to=0D
learn through the review process.=0D
=0D
Regards, =0D
Pushkar Singh=0D
=0D
---------8<----------8<----------8<----------8<----------8<----------8<----=
------8<----------8<=0D
=0D
Changes in v2:=0D
- Updated status of my recent patch activities.=0D
- Added recent patch reviews I made in Mailing List.=0D
- Improved clarity and readability across sections.=20=
