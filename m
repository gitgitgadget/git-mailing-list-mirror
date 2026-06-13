Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4942F39C2
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373767; cv=none; b=HOBtytjd1HHNcFMV0pHnVRiL6Qp6ZuJDr50vwQIiMR/ZBZGtJI50ER/xyowyiOOUzE2Unr2sOyMpemf1jD2TpayUyh9AN/nzodOdftFpGq0uA3hA0IbuDcZI7rPsM+V8gkHiBruo5c5NiJb5nn9Qe8VOoRMs0wgAiKPHcAw7/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373767; c=relaxed/simple;
	bh=gNQ9KqT9Jz8rYAK936N04rSSxKFMgQGmCLZOb36CDJI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fb9aM6VpJNWQMoVyAucWP3ZgOWN1oJFx/Mwswl2shrHMjh4gpOj76sXWl6i0SJIbexfDc1+yCC27VPztwLhez974kNg4EMk614TXNJdZx2eqqsm+XC+6HJrOU0WlyILQOldjmZz478vrLIhBrdoedre8lMU5vbFC2wyJB1GhY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=HBmQs2k9; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="HBmQs2k9"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 802A34D135
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 20:02:34 +0200 (CEST)
Received: from [IPV6:2a01:e0a:ecb:c5f0:ccd1:30f1:b7d9:b95f] (unknown [IPv6:2a01:e0a:ecb:c5f0:ccd1:30f1:b7d9:b95f])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4D5285FFA3;
	Sat, 13 Jun 2026 20:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1781373747;
	bh=gNQ9KqT9Jz8rYAK936N04rSSxKFMgQGmCLZOb36CDJI=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=HBmQs2k9bZdJqlJdn2HQ/rFA8YnMSbyW2dwm36hDU9z/mR1S/eZ/Qn5nt6Ras2KXG
	 ZvgMa9hRw3jTM/e6bAsGp5pVBtEKMYGOUPBK264ecHADTnD/E9Biy7OQ5sSpMYzSgt
	 i0w2dlU9egqgQ48AJ1lpLayadyvYRftbLMN2wu1vQkdU54j2QCAbdMd3cJqwjOBhB9
	 8YvrgpAWVv1o6Lc1Z1LbIM4wjsHUFYm645zcSLTRD+9hr9c5goDzl5XQRY7eHyFAku
	 jBb5uhUPuX98aZ586R5QbQ9rbVMElsPeoF1ZbRZmPIddHgDSdioOsXumt6w2+3Y81K
	 uE5RfMZp+dHTg==
Message-ID: <1bdcbdb9-4198-41aa-a621-0676e9a20876@online.fr>
Date: Sat, 13 Jun 2026 20:02:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.6.1
To: git@vger.kernel.org
References: <466060ab-ea6c-4c13-93f7-2de7a380429d@online.fr>
Content-Language: en-GB, et, fr
In-Reply-To: <466060ab-ea6c-4c13-93f7-2de7a380429d@online.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am pleased to announce Tig version 2.6.1 which brings a security fix as
well as some improvements and bugfixes. See the release notes below for a
detailed list of changes. Thanks to everyone who contributed.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

  - Homepage:	https://github.com/jonas/tig
  - Manual:	https://www.mankier.com/7/tigmanual
  - Tarballs:	https://github.com/jonas/tig/releases
  - Q&A:		https://stackoverflow.com/questions/tagged/tig

Release notes
-------------

Security fixes:

  - Fix editor command injection vulnerability (only affects
    version 2.6.0). (#1432)

Bug fixes:

  - Fix notes handling in the main view. (#1394)
  - Honor init_size in string_map_put_to().
  - Reset view->parent both when switching and closing view.
  - Fix grep with revision argument. (#1398)
  - Minor tweaks to the blame view.
  - Fix repo info in bare repository with no HEAD.
  - Document `%(status)`. (#1406)
  - Update Cygwin build.
  - Fix "DU" conflicts showing as 'Staged changes' in the main view. (#471)
  - Ensure consistent blame view access from the blob view.
  - Fix compiler warning with glibc-2.43.
  - contrib: chocolate-theme: Fix cursor color in backgrounded view. (#1419)
  - Fix date for 'Not Committed Yet' changes. (#1423)
  - Fix slow tig status when given a subdirectory path. (#1424)
  - Handle pure file rename in the diff view. (#1426)

Improvements:

  - Handle the NO_COLOR environment variable. (#1402)
  - Run tests against system's tig when SYSTEM_TIG=1. (#1400)
  - Support option append. (#1413)
  - Add an option to make the tree view recursive.
  - Enable direct blob edits in clean HEAD state. (#1415, #1416)

Change summary
--------------

The diffstat and log summary for changes made in this release.

  .gitignore                                    |   1 +
  INSTALL.adoc                                  |  50 ++-----
  Makefile                                      |  36 +++--
  NEWS.adoc                                     |  38 ++++-
  README.adoc                                   |   5 +-
  appveyor.yml                                  |   2 +-
  compat/ansidecl.h                             | 137 +++++++++++------
  compat/compat.h                               |   2 +-
  compat/hashtab.c                              | 141 +++++++++---------
  compat/hashtab.h                              |  24 ++-
  compat/wordexp.c                              |   2 +-
  contrib/chocolate.theme.tigrc                 |   2 +
  ...ke-CYGWIN_NT-6.1 => config.make-CYGWIN_NT} |  17 +++
  contrib/tig-completion.bash                   |   2 +-
  contrib/tig.cygport.in                        |  30 ++++
  doc/manual.adoc                               |   2 +-
  doc/tig.1.adoc                                |   2 +-
  doc/tigrc.5.adoc                              |  17 ++-
  include/tig/apps.h                            |   2 +-
  include/tig/argv.h                            |   2 +-
  include/tig/blame.h                           |   2 +-
  include/tig/blob.h                            |   2 +-
  include/tig/diff.h                            |   2 +-
  include/tig/display.h                         |   2 +-
  include/tig/draw.h                            |   2 +-
  include/tig/git.h                             |   6 +-
  include/tig/graph.h                           |   2 +-
  include/tig/grep.h                            |   2 +-
  include/tig/help.h                            |   2 +-
  include/tig/io.h                              |   2 +-
  include/tig/keys.h                            |   2 +-
  include/tig/line.h                            |   4 +-
  include/tig/log.h                             |   2 +-
  include/tig/main.h                            |   3 +-
  include/tig/map.h                             |   2 +-
  include/tig/options.h                         |  14 +-
  include/tig/pager.h                           |   2 +-
  include/tig/parse.h                           |   2 +-
  include/tig/prompt.h                          |   2 +-
  include/tig/refdb.h                           |   2 +-
  include/tig/reflog.h                          |   2 +-
  include/tig/refs.h                            |   2 +-
  include/tig/repo.h                            |   2 +-
  include/tig/request.h                         |   2 +-
  include/tig/search.h                          |   2 +-
  include/tig/stage.h                           |   2 +-
  include/tig/stash.h                           |   2 +-
  include/tig/status.h                          |   2 +-
  include/tig/string.h                          |   2 +-
  include/tig/tig.h                             |   2 +-
  include/tig/tree.h                            |   2 +-
  include/tig/types.h                           |   2 +-
  include/tig/ui.h                              |   2 +-
  include/tig/util.h                            |   2 +-
  include/tig/view.h                            |   6 +-
  include/tig/watch.h                           |   2 +-
  src/apps.c                                    |   2 +-
  src/argv.c                                    |   2 +-
  src/blame.c                                   |  18 ++-
  src/blob.c                                    |  38 +++--
  src/diff.c                                    |  47 +++---
  src/display.c                                 |  35 ++++-
  src/draw.c                                    |   2 +-
  src/graph-v1.c                                |   2 +-
  src/graph-v2.c                                |   2 +-
  src/graph.c                                   |   2 +-
  src/grep.c                                    |  31 +++-
  src/help.c                                    |   2 +-
  src/io.c                                      |   2 +-
  src/keys.c                                    |   2 +-
  src/line.c                                    |   5 +-
  src/log.c                                     |   4 +-
  src/main.c                                    |  14 +-
  src/map.c                                     |   4 +-
  src/options.c                                 |  45 ++++--
  src/pager.c                                   |   2 +-
  src/parse.c                                   |   2 +-
  src/prompt.c                                  |   2 +-
  src/refdb.c                                   |   2 +-
  src/reflog.c                                  |   2 +-
  src/refs.c                                    |   2 +-
  src/repo.c                                    |  10 +-
  src/request.c                                 |   2 +-
  src/search.c                                  |   2 +-
  src/stage.c                                   |   2 +-
  src/stash.c                                   |   2 +-
  src/status.c                                  |  23 +--
  src/string.c                                  |   2 +-
  src/tig.c                                     |   3 +-
  src/tree.c                                    |  10 +-
  src/types.c                                   |   2 +-
  src/ui.c                                      |   2 +-
  src/util.c                                    |  16 +-
  src/view.c                                    |   2 +-
  src/watch.c                                   |   2 +-
  test/blame/blob-blame-test                    |   2 +-
  test/blame/default-test                       |   8 +-
  test/blame/initial-diff-test                  |   2 +-
  test/blame/navigation-parent-test             |   2 +-
  test/blame/revargs-test                       |   4 +-
  test/blame/start-on-line-test                 |   2 +-
  test/blame/stash-test                         |   4 +-
  test/grep/refspec-test                        |  59 ++++++++
  test/main/filter-args-test                    |   2 +-
  test/status/file-filter-test                  |  80 ++++++++++
  test/tigrc/append-option-test                 |  33 ++++
  test/tools/libgit.sh                          |   2 +-
  test/tools/libtest.sh                         |   2 +-
  test/tools/show-results.sh                    |   2 +-
  test/tools/test-graph.c                       |   2 +-
  test/tree/recurse-test                        |  64 ++++++++
  tigrc                                         |   4 +
  tools/announcement.sh                         |   2 +-
  tools/doc-gen.c                               |   2 +-
  tools/header.h                                |   2 +-
  tools/install.sh                              |   2 +-
  tools/make-builtin-config.sh                  |   2 +-
  tools/release.sh                              |   2 +-
  tools/uninstall.sh                            |   2 +-
  119 files changed, 873 insertions(+), 375 deletions(-)

Karl Liang (1):
       support option append (#1413)

Lee Garrett (1):
       Run tests against system's tig when SYSTEM_TIG=1

Marcel Holtmann (1):
       Fix compiler warning with glibc-2.43

Siddh Raman Pant (1):
       contrib: chocolate-theme: Fix cursor color in backgrounded view (#1419)

Thomas Koutcher (23):
       Update manual link to point to mankier.com and remove link to Gitter
       Fix notes handling in the main view
       Update compat/hashtab.c with latest libiberty version
       Honor init_size in string_map_put_to()
       Reset view->parent both when switching and closing view
       Fix grep with revision argument
       Minor tweaks to the blame view
       Handle the NO_COLOR environment variable
       Bump copyright year to 2026
       Fix repo info in bare repository with no HEAD
       Document %(status)
       Update Cygwin build
       Add an option to make the tree view recursive
       Fix "DU" conflicts showing as 'Staged changes' in the main view
       Use compat/wordexp with Cygwin
       Ensure consistent blame view access from the blob view
       Skip generating manual.pdf when running make doc
       Fix date for 'Not Committed Yet' changes
       Add new AI related trailers to default tigrc
       Handle pure file rename in the diff view
       Fix editor command injection vulnerability
       Update NEWS
       tig-2.6.1

phpmac (1):
       Enable direct blob edits in clean HEAD state (#1416)

apawn (1):
       Fix slow tig status when given a subdirectory path (#1424)

--
Thomas Koutcher

