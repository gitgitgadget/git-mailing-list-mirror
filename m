Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F514F102
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267668; cv=none; b=LyXtuLJqet+xqFICEqphOW4zcw4V2O9pjvugXgiZ7wiEg1RMiue0TgcafPo/MbaH1Kbge+zm7QVOWNfwEicYOd8+oRblXJbOU4FO1mPyjYQZZxNOwsA1n7yf7C0JZ7yk59Ith2xkboEjFjORkaiAlYpjAwOaZVHVd8QaoraRcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267668; c=relaxed/simple;
	bh=lWK+30aivDJ6Y/DUpUJPs7ugTJlDFqferJ/UAotke4U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=b5blUvHB87oHC03/SIE/jWfrwOeUOdk5Xi8sjL2MPgjLKyRxuspTGx8Ucn0W0jvGStdQ17i5z7Ueo9I/hUs63ydEp/n8H6EkAoq1LuqkgfwKeD4XIJ7ghD0X8UnF8B07mHBAlljsNz4YPcuIOeTuvd9Se2XYajvXkd7cpjB4phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=LAbOh508; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="LAbOh508"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 49F3A84130F
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 21:00:12 +0100 (CET)
Received: from [IPV6:2a01:e0a:ecb:c5f0:4838:9472:ea18:c785] (unknown [IPv6:2a01:e0a:ecb:c5f0:4838:9472:ea18:c785])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4670E5FFC0;
	Thu, 30 Jan 2025 21:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1738267205;
	bh=lWK+30aivDJ6Y/DUpUJPs7ugTJlDFqferJ/UAotke4U=;
	h=Date:From:Subject:To:From;
	b=LAbOh508fnOYpie+DEYSSAmtL4rvazBfb6xdwIkQLFR4iho4/uP2KS6zrwi03dVc/
	 ccggUsp3tcDyKVj8mLlGF4YfIF/shKArS+pPkksoWI2p+K+6wpEsa5E0zKSBtXkibT
	 t6VvMEIVHtQ9iVP89aSZQOX6DxbX+aKoHeT96JQleFIBPA9rXiWSReJ2XnF+YZ3HLc
	 0qIUR2iQ/EteEXvTRcC0j80NGclYiQbrlhKOaCWPosXO5sz1DfCTCk0Zon/418lIoV
	 SOPYp32m9hVH7zoLjbP9cRgDwpvt1Tw33wABW3IgNNiAdvsziPkcVFAGHrNkHKSmEx
	 M/RLpnI3MmH/w==
Message-ID: <bc4dd9c0-336f-40db-aeb7-e2c13063fe3e@online.fr>
Date: Thu, 30 Jan 2025 21:00:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.5.11
To: git@vger.kernel.org
Content-Language: en-GB, et, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am pleased to announce Tig version 2.5.11 which brings some improvements
and bugfixes. See the release notes below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

- Homepage:https://jonas.github.io/tig/
- Manual:https://jonas.github.io/tig/doc/manual.html
- Tarballs:https://github.com/jonas/tig/releases
- Gitter:https://gitter.im/jonas/tig
- Q&A:https://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Incompatibilities:

  - Update remote repo variables. (#1358)

Bug fixes:

  - Fix various issues with `diff.noprefix` and `--no-prefix`.
  - Fix `Ctrl-C` behavior within the Readline prompt. (#1342)
  - Fix message upon edit from diffstat without patch.
  - Fix missing dates in the refs view.
  - Don't report an error when diff-highlight is killed intentionally.
  - Fix parsing of reflog designator in timestamp format.

Improvements:

  - Open the blob corresponding to the diff line. (#1334)
  - Keep cursor position in the main view when toggling
    file-filter and rev-filter.
  - Make errors visible in views showing Git output. (#1346)
  - Allow different colors for all references types.
  - Enable search in sections titles. (#1043)
  - Show committer date by default in the date column. (#294)
  - Update utf8proc to v2.10.0, supporting Unicode 16.
  - Only show stash, notes and prefetch in the refs view when
    invoked with `tig refs --all`. (#1359)

Change summary
--------------
The diffstat and log summary for changes made in this release.

  INSTALL.adoc                    |     4 +-
  Makefile                        |     7 +-
  NEWS.adoc                       |    28 +
  compat/compat.h                 |     2 +-
  compat/utf8proc.c               |    53 +-
  compat/utf8proc.h               |   104 +-
  compat/utf8proc_data.c          | 30816 +++++++++++++++---------------
  compat/wordexp.c                |     2 +-
  contrib/tig-completion.bash     |     2 +-
  doc/asciidoc.conf               |     3 +
  doc/manual.adoc                 |    14 +-
  doc/tig.1.adoc                  |     2 +-
  doc/tigrc.5.adoc                |    13 +-
  include/tig/apps.h              |     2 +-
  include/tig/argv.h              |     2 +-
  include/tig/blame.h             |     2 +-
  include/tig/blob.h              |     2 +-
  include/tig/diff.h              |     2 +-
  include/tig/display.h           |     2 +-
  include/tig/draw.h              |     2 +-
  include/tig/git.h               |    14 +-
  include/tig/graph.h             |     2 +-
  include/tig/grep.h              |     2 +-
  include/tig/help.h              |     2 +-
  include/tig/io.h                |     2 +-
  include/tig/keys.h              |     2 +-
  include/tig/line.h              |     6 +-
  include/tig/log.h               |     2 +-
  include/tig/main.h              |     2 +-
  include/tig/map.h               |     2 +-
  include/tig/options.h           |     8 +-
  include/tig/pager.h             |     2 +-
  include/tig/parse.h             |     4 +-
  include/tig/prompt.h            |     2 +-
  include/tig/refdb.h             |     2 +-
  include/tig/reflog.h            |     2 +-
  include/tig/refs.h              |     2 +-
  include/tig/repo.h              |     3 +-
  include/tig/request.h           |     2 +-
  include/tig/search.h            |     2 +-
  include/tig/stage.h             |     2 +-
  include/tig/stash.h             |     2 +-
  include/tig/status.h            |     2 +-
  include/tig/string.h            |     2 +-
  include/tig/tig.h               |     2 +-
  include/tig/tree.h              |     2 +-
  include/tig/types.h             |     9 +-
  include/tig/ui.h                |     2 +-
  include/tig/util.h              |     2 +-
  include/tig/view.h              |     2 +-
  include/tig/watch.h             |     2 +-
  src/apps.c                      |     2 +-
  src/argv.c                      |     2 +-
  src/blame.c                     |     9 +-
  src/blob.c                      |     2 +-
  src/diff.c                      |    31 +-
  src/display.c                   |     2 +-
  src/draw.c                      |     2 +-
  src/graph-v1.c                  |     2 +-
  src/graph-v2.c                  |     2 +-
  src/graph.c                     |     2 +-
  src/grep.c                      |     2 +-
  src/help.c                      |     2 +-
  src/io.c                        |     2 +-
  src/keys.c                      |     2 +-
  src/line.c                      |    10 +-
  src/log.c                       |     4 +-
  src/main.c                      |    27 +-
  src/map.c                       |     2 +-
  src/options.c                   |    47 +-
  src/pager.c                     |     5 +-
  src/parse.c                     |    11 +-
  src/prompt.c                    |    13 +-
  src/refdb.c                     |    25 +-
  src/reflog.c                    |     4 +-
  src/refs.c                      |    36 +-
  src/repo.c                      |    10 +-
  src/request.c                   |     2 +-
  src/search.c                    |     2 +-
  src/stage.c                     |    23 +-
  src/stash.c                     |     4 +-
  src/status.c                    |     6 +-
  src/string.c                    |     2 +-
  src/tig.c                       |     2 +-
  src/tree.c                      |    12 +-
  src/types.c                     |     2 +-
  src/ui.c                        |     2 +-
  src/util.c                      |     2 +-
  src/view.c                      |    11 +-
  src/watch.c                     |     2 +-
  test/blame/default-test         |     1 +
  test/blame/start-on-line-test   |    48 +-
  test/diff/diff-stat-split-test  |     1 +
  test/diff/editor-test           |     4 +-
  test/diff/submodule-editor-test |     4 +-
  test/diff/worktree-editor-test  |     4 +-
  test/main/date-test             |     1 +
  test/main/filter-args-test      |     4 +
  test/main/graph-argument-test   |     2 +-
  test/main/jump-ends-test        |     4 +
  test/main/no-merges-test        |     4 +
  test/main/start-on-line-test    |    12 +-
  test/refs/filter-test           |     4 +-
  test/refs/start-on-line-test    |     6 +-
  test/status/repo-var-test       |     5 +-
  test/tigrc/width-test           |     1 +
  test/tools/libgit.sh            |     2 +-
  test/tools/libtest.sh           |     2 +-
  test/tools/show-results.sh      |     2 +-
  test/tools/test-graph.c         |     2 +-
  test/tree/chdir-test            |     2 +-
  test/tree/default-test          |     1 +
  tigrc                           |    15 +-
  tools/announcement.sh           |     2 +-
  tools/doc-gen.c                 |     2 +-
  tools/header.h                  |     2 +-
  tools/install.sh                |     2 +-
  tools/make-builtin-config.sh    |     2 +-
  tools/release.sh                |     2 +-
  tools/uninstall.sh              |     2 +-
  120 files changed, 16004 insertions(+), 15629 deletions(-)

Ivan Shapovalov (1):
       Fix `Ctrl-C` behavior within the Readline prompt (#1342)

Thomas Koutcher (22):
       Open the blob corresponding to the diff line
       Keep cursor position when toggling file-filter in the main view
       Fix parsing of `--no-prefix` argument
       Fix staging with `diff.noprefix` and `--no-prefix`
       Keep cursor position in the main view when toggling file-filter 
from split diff view
       Make errors visible in views showing Git output
       Allow different colors for all references types
       Fix message upon edit from diffstat without patch
       Enable search in sections titles
       Show committer date by default in the date column
       Fix missing dates in the refs view
       Keep cursor position in the main view when toggling rev-filter
       Don't report an error when diff-highlight is killed intentionally
       Parse committer date in --pretty=raw output
       Refresh the view when toggling date-use-author
       Update remote repo variables
       Fix parsing of reflog designator in timestamp format
       Update utf8proc to v2.10.0
       Show stash, notes and prefetch in refs view with `tig refs --all`
       Bump copyright year to 2025
       Change the date in generated documentation
       tig-2.5.11

--
Thomas Koutcher


