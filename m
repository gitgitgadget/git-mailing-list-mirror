Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5641E0E08
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308311; cv=none; b=oYKjxiE+8Qa9Qszxvozzfmen3adizG/AlS7Baz1gmI6K6cCFZLEl+XDZAegKt4ssYAikft93xQOOaImjIo1T4U4ybwg0g5a2cO73hVEEo1qiv1Yelv1/SGh1cuc3zOHs0RA2WpHk2N/vkU9MX8CGI3aI3RqRU6sACpywW5NyC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308311; c=relaxed/simple;
	bh=VDTLP3INK9Y37D4MlvzF2tJOGD70k7aXyRQsrrYHep0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBJmBQPDwk4AqyFkXv/eFUhQ9+SSGQjGyl3fucyq13pOAOGYDvsKaWFFCOtU1XVEnzKIJrmQ7+EYHcrVcJTR/WY/KXaa7M937CtghGjJQ/GyS+U9c1Itp/g5rZLvI/skMzaMI5KoTGmHgajR263lWGNFDjlTLddOIseDYER8Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSHbz070; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSHbz070"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso42809735e9.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308308; x=1756913108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/G4o8sAR7HenJhzceD4LGyuL+hMN5FbobfhVS0IY9qE=;
        b=XSHbz0704n92mRBIv0h8CUHP1Ep5qau00LrSWglF5IIjXgWPjpW847DClNznWd9Zsm
         anKrfrg5hiTGgIgZamkD+aBiqmNldbC3CJLX/d8qdCa/F2LEgwXDFHVwY45Np61vsEJ4
         wE6BpcHySM8ChOd159UYhDGbldOirvIwCtCBSVRX38u6/o/1aw0C4YdEMm31DElQuN5X
         ISF+dcMqIWH1bDkjiT/JNUm7wOa3EF360B7Kzmb0UV3S/2N9ybTieN7BBE11RXx1plXy
         AfxI7jHXr23AxuRi+7xkXCy52cAm71LDk+K0De1U1tEwn5LvlpaKYUAUYIfLp8zE+pbE
         Y5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308308; x=1756913108;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G4o8sAR7HenJhzceD4LGyuL+hMN5FbobfhVS0IY9qE=;
        b=MCKKjBGnTj8l4qylJ5D9J9BjDl6DSkpiux5OcfWXFI08JsYfj1lmoTllvamia9SEMU
         zPDfVe7FaR8K7m4Z5VEdC/vWI2VsePyxu21xkh7QVv1Qo/L+Un2rJVXAvcul+4xz+A/D
         iD2FcHsl3aPHXXWZFxDaJzVuACstBup7s0lxkKetrGfwJQXCcdd6FEmHFw2wLBvle2ju
         74S+yIQzEwzn+haCgEbs6GzJ3hC6fRbRE70aXx/rigpWkchBAJV9nWoXFe6N5IEpyO00
         uczrc2otQt/uiJSKqO5Cl57c2pb1NVWfoI5zt4LuOodNTrZfiBMUWreUDmtuoQ61oQOO
         kb0Q==
X-Gm-Message-State: AOJu0Yw462dXg+ZiEYidrfK+gJ8nwAouSHzSpn8nl1xpZRwdh9LE7JOD
	8v2jz5+0G7oxa4mZ9d/yOk5p6f3rbeqebyS34C+gjRVCtmddE+qxhpInZQLpxA==
X-Gm-Gg: ASbGncs0yxrbWoWDaKzfGoE5laYbhvwi6Wo5/+TSMfMPkLDDhgBRmWeqMySiwSu4a1Q
	0sywRZRJU/jw39Y8s6ecH598q1ZCViCVvrQOKxYloirhXNhiMGtre2BLXftg5HDR+ct5Y5AtNUc
	51Qx/WDf0q8yUG9m5Z9N2mkP1JwiHmcm1Pu9H7IspGx0d4V1Gloy4+C9UAvyG483pa/Sph8YZth
	RzMGAxQR6rNb+kbIB3YdiTYxYLAiNQsKqgxsZbRdyaBhMcEbIR2pc0cMq4vP89glQwJGChP0XQ0
	CiXIgshdNB3uSjPp8smVOmqnoX1XmMhB/q+PdU2aycXpw8JLIUYscpU19lYgdzzq5odpnlQNQON
	UdWnRGrYASpececdQ5pFEIdhIkXABzJuQ3xAQJtHBCTWEIA==
X-Google-Smtp-Source: AGHT+IGarCjZ+dagaonPRpivticPuB+rX3heaEt9of5lvSbYGZDtrp9jtIHH+07RaCW9Ag8bS1D1kA==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45b517c2f63mr169173045e9.24.1756308307469;
        Wed, 27 Aug 2025 08:25:07 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:06 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: [PATCH 0/6] breaking changes: switch default initial branch name to "main"
Date: Wed, 27 Aug 2025 16:24:44 +0100
Message-ID: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series switches the default branch name from "master" to "main"
when WITH_BREAKING_CHANGES is enabled. We have been warning that the
default name will change since 675704c74dd (init: provide useful advice
about init.defaultBranch, 2020-12-11) and the major git forges have all
switched their default branch name to "main", so I think it makes sense
to change the default branch name in git to match the wider ecosystem.

The first five patches update tests that currently require a default
branch name different to "main". The sixth patch then changes the
default branch "main" and removes GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
when WITH_BREAKING_CHANGES is enabled. Patch 2 is quite large but
is mechanically generated so it should be possible to review it by
checking that the changes can be reproduced.

This is an alternative to changing the branch name now as suggested in
https://lore.kernel.org<pull.1961.git.1756183921623.gitgitgadget@gmail.com

Base-Commit: f814da676ae46aac5be0a98b99373a76dee6cedb
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Finitial-branch-is-main%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/f814da676...487d1a331
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/initial-branch-is-main/v1


Phillip Wood (6):
  t0018: switch default branch name to main
  t4013: switch default branch name to main
  t9902: switch default branch name to main
  t0613: stop setting default initial branch
  t1403: remove dependency on GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
  breaking-changes: switch default branch to main

 Documentation/BreakingChanges.adoc            |   5 +
 Documentation/git-init.adoc                   |  12 +-
 advice.c                                      |   2 +
 advice.h                                      |   2 +
 ci/run-build-and-tests.sh                     |   1 -
 refs.c                                        |  16 +-
 t/t0001-init.sh                               |   9 +-
 t/t0018-advice.sh                             |   8 +-
 t/t0613-reftable-write-options.sh             |  18 +-
 t/t1403-show-ref.sh                           |   6 +-
 t/t4013-diff-various.sh                       | 228 +++++++++---------
 ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
 ...r => diff.diff-tree_--cc_--shortstat_main} |   2 +-
 ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
 ...master => diff.diff-tree_--cc_--stat_main} |   2 +-
 ...e_--cc_master => diff.diff-tree_--cc_main} |   2 +-
 ...master => diff.diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
 ...t_master => diff.diff-tree_-c_--stat_main} |   2 +-
 ...-tree_-c_master => diff.diff-tree_-c_main} |   2 +-
 ...-tree_-m_master => diff.diff-tree_-m_main} |   2 +-
 ...-p_-m_master => diff.diff-tree_-p_-m_main} |   2 +-
 t/t4013/diff.diff-tree_-p_main                |   2 +
 t/t4013/diff.diff-tree_-p_master              |   2 -
 t/t4013/diff.diff-tree_main                   |   2 +
 t/t4013/diff.diff-tree_master                 |   2 -
 t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
 .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
 t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
 ...ff.diff_--line-prefix=abc_main_main^_side} |   2 +-
 ...master^_side => diff.diff_main_main^_side} |   2 +-
 ...mat-patch_--attach_--stdout_initial..main} |   2 +-
 ...at-patch_--attach_--stdout_initial..main^} |   2 +-
 ...e_--stdout_--numbered-files_initial..main} |   2 +-
 ...t_--subject-prefix=TESTCASE_initial..main} |   2 +-
 ...mat-patch_--inline_--stdout_initial..main} |   2 +-
 ...at-patch_--inline_--stdout_initial..main^} |   2 +-
 ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
 ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
 ...atch_--stdout_--no-numbered_initial..main} |   2 +-
 ...t-patch_--stdout_--numbered_initial..main} |   2 +-
 ... diff.format-patch_--stdout_initial..main} |   2 +-
 ...diff.format-patch_--stdout_initial..main^} |   2 +-
 ..._-m_-p_master => diff.log_--cc_-m_-p_main} |   2 +-
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 ..._--decorate=full_--clear-decorations_--all |   2 +-
 ...f.log_--decorate=full_--decorate-all_--all |   2 +-
 t/t4013/diff.log_--decorate_--all             |   2 +-
 ...f.log_--decorate_--clear-decorations_--all |   2 +-
 .../diff.log_--decorate_--decorate-all_--all  |   2 +-
 ... diff.log_--diff-merges=first-parent_main} |   2 +-
 ..._--diff-merges=off_-p_--first-parent_main} |   2 +-
 ..._--first-parent_--diff-merges=off_-p_main} |   2 +-
 ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...master => diff.log_--patch-with-stat_main} |   2 +-
 ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...g_--root_--patch-with-stat_--summary_main} |   2 +-
 ...=> diff.log_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...root_-p_master => diff.log_--root_-p_main} |   2 +-
 ...log_--root_master => diff.log_--root_main} |   2 +-
 ...ter => diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
 ...log_-GF_-p_master => diff.log_-GF_-p_main} |   2 +-
 ...{diff.log_-SF_master => diff.log_-GF_main} |   2 +-
 ...aster => diff.log_-IA_-IB_-I1_-I2_-p_main} |   2 +-
 ...log_-SF_-p_master => diff.log_-SF_-p_main} |   2 +-
 ...{diff.log_-GF_master => diff.log_-SF_main} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=0       |   2 +
 ...ount=2 => diff.log_-SF_main_--max-count=1} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=2       |   7 +
 t/t4013/diff.log_-SF_master_--max-count=0     |   2 -
 t/t4013/diff.log_-SF_master_--max-count=1     |   7 -
 ...iff.log_-S_F_master => diff.log_-S_F_main} |   2 +-
 ...cc_-m_-p_master => diff.log_-c_-m_-p_main} |   2 +-
 ...-m_--raw_master => diff.log_-m_--raw_main} |   2 +-
 ..._--stat_master => diff.log_-m_--stat_main} |   2 +-
 ...ter => diff.log_-m_-p_--first-parent_main} |   2 +-
 ...f.log_-m_-p_master => diff.log_-m_-p_main} |   2 +-
 ...ff.log_-p_--diff-merges=first-parent_main} |   2 +-
 ...master => diff.log_-p_--first-parent_main} |   2 +-
 .../{diff.log_-p_master => diff.log_-p_main}  |   2 +-
 t/t4013/{diff.log_master => diff.log_main}    |   2 +-
 ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.noellipses-whatchanged_--root_main} |   2 +-
 ...r => diff.noellipses-whatchanged_-SF_main} |   2 +-
 ...aster => diff.noellipses-whatchanged_main} |   2 +-
 ...t_master => diff.show_--first-parent_main} |   2 +-
 ...{diff.show_-c_master => diff.show_-c_main} |   2 +-
 ...{diff.show_-m_master => diff.show_-m_main} |   2 +-
 t/t4013/{diff.show_master => diff.show_main}  |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
 ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...d_--root_--patch-with-stat_--summary_main} |   2 +-
 ...whatchanged_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...master => diff.whatchanged_--root_-p_main} |   2 +-
 ...ot_master => diff.whatchanged_--root_main} |   2 +-
 ...-p_master => diff.whatchanged_-SF_-p_main} |   2 +-
 ...d_-SF_master => diff.whatchanged_-SF_main} |   2 +-
 ...ged_-p_master => diff.whatchanged_-p_main} |   2 +-
 ...atchanged_master => diff.whatchanged_main} |   2 +-
 t/t9902-completion.sh                         |   6 +-
 t/test-lib.sh                                 |  15 +-
 109 files changed, 281 insertions(+), 253 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master => diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master => diff.diff-tree_--cc_--patch-with-stat_main} (89%)
 rename t/t4013/{diff.diff-tree_--cc_--shortstat_master => diff.diff-tree_--cc_--shortstat_main} (65%)
 rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master => diff.diff-tree_--cc_--stat_--summary_main} (71%)
 rename t/t4013/{diff.diff-tree_-c_--stat_master => diff.diff-tree_--cc_--stat_main} (76%)
 rename t/t4013/{diff.diff-tree_--cc_master => diff.diff-tree_--cc_main} (91%)
 rename t/t4013/{diff.diff-tree_-c_--abbrev_master => diff.diff-tree_-c_--abbrev_main} (83%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master => diff.diff-tree_-c_--stat_--summary_main} (70%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_master => diff.diff-tree_-c_--stat_main} (75%)
 rename t/t4013/{diff.diff-tree_-c_master => diff.diff-tree_-c_main} (93%)
 rename t/t4013/{diff.diff-tree_-m_master => diff.diff-tree_-m_main} (96%)
 rename t/t4013/{diff.diff-tree_-p_-m_master => diff.diff-tree_-p_-m_main} (97%)
 create mode 100644 t/t4013/diff.diff-tree_-p_main
 delete mode 100644 t/t4013/diff.diff-tree_-p_master
 create mode 100644 t/t4013/diff.diff-tree_main
 delete mode 100644 t/t4013/diff.diff-tree_master
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
 delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
 create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
 delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 rename t/t4013/{diff.diff_--line-prefix=abc_master_master^_side => diff.diff_--line-prefix=abc_main_main^_side} (87%)
 rename t/t4013/{diff.diff_master_master^_side => diff.diff_main_main^_side} (89%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master => diff.format-patch_--attach_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ => diff.format-patch_--attach_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_initial..master => diff.format-patch_--inline_--stdout_--numbered-files_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master => diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master => diff.format-patch_--inline_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ => diff.format-patch_--inline_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ => diff.format-patch_--inline_--stdout_initial..main^^} (95%)
 rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..master^ => diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (96%)
 rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..master => diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master => diff.format-patch_--stdout_--numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master => diff.format-patch_--stdout_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master^ => diff.format-patch_--stdout_initial..main^} (96%)
 rename t/t4013/{diff.log_-c_-m_-p_master => diff.log_--cc_-m_-p_main} (99%)
 rename t/t4013/{diff.log_--diff-merges=first-parent_master => diff.log_--diff-merges=first-parent_main} (95%)
 rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master => diff.log_--diff-merges=off_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--first-parent_--diff-merges=off_-p_master => diff.log_--first-parent_--diff-merges=off_-p_main} (95%)
 rename t/t4013/{diff.log_--diff-merges=off_-p_--first-parent_master => diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ => diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--patch-with-stat_master => diff.log_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ => diff.log_--patch-with-stat_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master => diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master => diff.log_--root_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_master => diff.log_--root_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master => diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_-p_master => diff.log_--root_-p_main} (98%)
 rename t/t4013/{diff.log_--root_master => diff.log_--root_main} (96%)
 rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master => diff.log_-GF_-p_--pickaxe-all_main} (90%)
 rename t/t4013/{diff.log_-GF_-p_master => diff.log_-GF_-p_main} (91%)
 rename t/t4013/{diff.log_-SF_master => diff.log_-GF_main} (86%)
 rename t/t4013/{diff.log_-IA_-IB_-I1_-I2_-p_master => diff.log_-IA_-IB_-I1_-I2_-p_main} (97%)
 rename t/t4013/{diff.log_-SF_-p_master => diff.log_-SF_-p_main} (91%)
 rename t/t4013/{diff.log_-GF_master => diff.log_-SF_main} (86%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=0
 rename t/t4013/{diff.log_-SF_master_--max-count=2 => diff.log_-SF_main_--max-count=1} (79%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=2
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=0
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=1
 rename t/t4013/{diff.log_-S_F_master => diff.log_-S_F_main} (86%)
 rename t/t4013/{diff.log_--cc_-m_-p_master => diff.log_-c_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-m_--raw_master => diff.log_-m_--raw_main} (98%)
 rename t/t4013/{diff.log_-m_--stat_master => diff.log_-m_--stat_main} (98%)
 rename t/t4013/{diff.log_-m_-p_--first-parent_master => diff.log_-m_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-m_-p_master => diff.log_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-p_--diff-merges=first-parent_master => diff.log_-p_--diff-merges=first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_--first-parent_master => diff.log_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_master => diff.log_-p_main} (98%)
 rename t/t4013/{diff.log_master => diff.log_main} (97%)
 rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master => diff.noellipses-diff-tree_-c_--abbrev_main} (81%)
 rename t/t4013/{diff.noellipses-whatchanged_--root_master => diff.noellipses-whatchanged_--root_main} (96%)
 rename t/t4013/{diff.noellipses-whatchanged_-SF_master => diff.noellipses-whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.noellipses-whatchanged_master => diff.noellipses-whatchanged_main} (96%)
 rename t/t4013/{diff.show_--first-parent_master => diff.show_--first-parent_main} (92%)
 rename t/t4013/{diff.show_-c_master => diff.show_-c_main} (95%)
 rename t/t4013/{diff.show_-m_master => diff.show_-m_main} (98%)
 rename t/t4013/{diff.show_master => diff.show_main} (96%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ => diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master => diff.whatchanged_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ => diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master => diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_master => diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master => diff.whatchanged_--root_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_master => diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-p_master => diff.whatchanged_--root_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_--root_master => diff.whatchanged_--root_main} (97%)
 rename t/t4013/{diff.whatchanged_-SF_-p_master => diff.whatchanged_-SF_-p_main} (89%)
 rename t/t4013/{diff.whatchanged_-SF_master => diff.whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.whatchanged_-p_master => diff.whatchanged_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_master => diff.whatchanged_main} (97%)

-- 
2.49.0.897.gfad3eb7d210

