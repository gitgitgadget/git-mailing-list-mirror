Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AD1F419A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055302; cv=none; b=iY3xM70oT7+0AtDj0jlEyYo91bNVBZwFLfqeO6mTDm4b9ktRA+7Y11qrDfhH8mxeeQ0crOYhEmIrN0Cd7gWqR7DYLUtYB3bPePjMRoYNy8do5FA5k5/KiqFp/37RKB/mp9b5bX0aPGO0yM6/wT3orfXL6Do80HrqleNQgjQ0WrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055302; c=relaxed/simple;
	bh=wX3gbG/Yc0DfDrlzTJvKgtitBrWiKSbPKc63NKGgza0=;
	h=Message-ID:Date:MIME-Version:Subject:From:References:To:
	 In-Reply-To:Content-Type; b=fFLqKyWvg3ZGByAG/nyir7IEOgw/ZugJJZsxZ3Q4f5LGMm5tZS3RmmdH+CfWA/cgdCuyzHjfsfCnAlbYR4NXhWWA+3wx5H4WcDIhUX4xa50XrgQvr/cqwDZUSN0j309PUCQ2SzEtKwbuhDKSc4Y/g26HdeLrRfdMIDBfrK6v/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=AvFygiXG; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="AvFygiXG"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 63799DF82CC
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:32:38 +0200 (CEST)
Received: from [IPV6:2a01:e0a:ecb:c5f0:99e8:65c1:1fb6:9b73] (unknown [IPv6:2a01:e0a:ecb:c5f0:99e8:65c1:1fb6:9b73])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 5825360134;
	Tue, 16 Sep 2025 22:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1758054751;
	bh=wX3gbG/Yc0DfDrlzTJvKgtitBrWiKSbPKc63NKGgza0=;
	h=Date:Subject:From:References:To:In-Reply-To:From;
	b=AvFygiXG2hCC0ennPjpJcQTjlQcUhUcy7RKiutyP9jbRyWh4bc2EVAZoTY0A+Nliv
	 bzfLAJCZXdwFrEHe5kqFS/a23/wx5wpm9LduETw5hz/IwrTGzzEiK/CY0PTo2dAvvm
	 BWi8ih7NaACY4R6qtAwjSA/z7Lmr33rkS9EvsvtLrcyUexLIZg0WhpH93SfPytQ8Tz
	 LgmPzEiOrRw+l2IaE4ZKn46kxG7RMWl7DBfS6ho+y/fcaQ9y6Sy+aGPtIAV0r3u87c
	 YxQoHBUUO544mx40OIjo2o7WrS1bI6c4TvUmkeVwDaKQ7/kzzHKnVkamiwKR6iotgE
	 gwTxkXEcnCHBw==
Message-ID: <89836f92-980a-4a69-aa0a-34cca91f6663@online.fr>
Date: Tue, 16 Sep 2025 22:32:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [ANNOUNCE] tig-2.6.0
From: Thomas Koutcher <thomas.koutcher@online.fr>
References: <466060ab-ea6c-4c13-93f7-2de7a380429d@online.fr>
Content-Language: en-GB, et, fr
To: git@vger.kernel.org
In-Reply-To: <466060ab-ea6c-4c13-93f7-2de7a380429d@online.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am pleased to announce Tig version 2.6.0 which brings some improvements
and bugfixes. See the release notes below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

  - Homepage:    https://github.com/jonas/tig
  - Manual: https://github.com/jonas/tig/blob/master/doc/manual.adoc
  - Tarballs:    https://github.com/jonas/tig/releases
  - Git URL:     https://github.com/jonas/tig.git
  - Gitter:      https://gitter.im/jonas/tig
  - Q&A:         https://stackoverflow.com/questions/tagged/tig

Release notes
-------------

Bug fixes:

  - Initialise %(head) from command line arguments. (#1366)
  - Make `$GIT_EDITOR` value interpreted by the shell. (#1367)
  - Use correct line from recursively blamed commit. (#1369, #1370)
  - Use correct line when using `:parent` in blame view. (#1372)
  - Fix the incorrect line shift after stage file. (#1371)
  - Update display after setting column option. (#1384)
  - Fix file mode diff header handling.
  - Fix crash caused by too many diff cells. (#1389)
  - Fix issue with blame when using absolute file paths. (#1391)

Improvements:

  - Add color for cursor in backgrounded view. (#1374)
  - Blame view now works without a working tree.
  - Open diff view from blame at the correct line. (#1375)
  - Document how to get a `<` within TIG_SCRIPT. (#1357)
  - Allow to hide +/- signs in the diff view. (#855, #901)
  - Add toggle options to help. (#1381)
  - Add expand/collapse all options to help. (#1382)
  - Expand relevant sections only when opening the help view. (#782, #886)
  - Introduce committer column.
  - Open the blame and blob views from diffstat.
  - Update utf8proc to v2.11.0, supporting Unicode 17.

Note: Users should update the settings for the blame, main, reflog, and
refs views in their ~/.tigrc file to include the committer column.

Change summary
--------------

The diffstat and log summary for changes made in this release.

  .github/workflows/linux.yml                 |     2 +-
  INSTALL.adoc                                |     4 +-
  Makefile                                    |     2 +-
  NEWS.adoc                                   |    32 +
  README.adoc                                 |    19 +-
  appveyor.yml                                |     1 +
  compat/utf8proc.c                           |     6 +-
  compat/utf8proc.h                           |    11 +-
  compat/utf8proc_data.c                      | 14261 +++++++++---------
  contrib/tig.spec.in                         |     2 +-
  doc/manual.adoc                             |    10 +-
  doc/tig.1.adoc                              |    14 +-
  doc/tigrc.5.adoc                            |    40 +-
  include/tig/argv.h                          |     1 +
  include/tig/diff.h                          |     2 +
  include/tig/help.h                          |     2 +
  include/tig/keys.h                          |     1 +
  include/tig/line.h                          |     9 +-
  include/tig/main.h                          |     4 +-
  include/tig/options.h                       |     6 +-
  include/tig/parse.h                         |    10 +-
  include/tig/types.h                         |     1 +
  include/tig/view.h                          |     1 +
  src/blame.c                                 |    34 +-
  src/diff.c                                  |    45 +-
  src/display.c                               |    21 +-
  src/draw.c                                  |    21 +-
  src/help.c                                  |   107 +-
  src/keys.c                                  |    20 +-
  src/main.c                                  |    32 +-
  src/options.c                               |    12 +-
  src/parse.c                                 |    29 +-
  src/prompt.c                                |    56 +-
  src/reflog.c                                |     4 +-
  src/refs.c                                  |    42 +-
  src/stage.c                                 |     9 +-
  src/status.c                                |     2 +-
  src/tig.c                                   |    37 +-
  src/tree.c                                  |    27 +-
  src/view.c                                  |    16 +
  test/blame/blob-blame-test                  |    55 +
  test/blame/default-test                     |    56 +-
  test/blame/navigation-parent-test           |    58 +
  test/diff/editor-test                       |     2 +
  test/help/all-keybindings-test              |     7 +-
  test/help/all-keybindings-test.expected     |    32 +-
  test/help/default-test                      |    64 +-
  test/help/user-command-test                 |     8 +-
  test/main/escape-control-characters-test.in |   Bin 1725 -> 2201 bytes
  test/main/filter-args-test                  |     2 +-
  test/tigrc/env-vars-test                    |     5 +-
  test/tigrc/parse-test                       |    18 +-
  test/tigrc/source-test                      |    25 +-
  test/tigrc/view-column-test                 |    39 +-
  test/tigrc/width-test                       |     9 +-
  test/tree/default-test                      |     2 +
  tigrc                                       |    23 +-
  57 files changed, 7932 insertions(+), 7428 deletions(-)

Ilya Grigoriev (2):
       Use correct line when using `:parent` in blame view  (#1372)
       Open diff view from blame at the correct line (#1375)

Johannes Altmanninger (1):
       Use correct line from recursively blamed commit (#1370)

Paul WK (3):
       Add toggle options to help (#1381)
       Add expand/collapse all options to help (#1382)
       Update display after setting column option (#1384)

Thomas Koutcher (19):
       Update home page links
       Initialise %(head) from command line arguments
       Make $GIT_EDITOR value interpreted by the shell
       Fix AppVeyor build
       fix the incorrect line shift after stage file (#1371)
       Add color for cursor in backgrounded view
       Update Linux CI
       Blame view now works without a working tree
       Document how to get a `<` within TIG_SCRIPT
       Allow to hide +/- signs in the diff view
       Expand relevant sections only when opening the help view
       Fix file mode diff header handling
       Fix crash caused by too many diff cells
       Introduce committer column
       Fix issue with blame when using absolute file paths
       Open the blame and blob views from diffstat
       Update utf8proc to v2.11.0
       Update NEWS
       tig-2.6.0

--
Thomas Koutcher
