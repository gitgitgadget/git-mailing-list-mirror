From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.1
Date: Wed, 11 Mar 2015 00:17:53 -0400
Message-ID: <CAFuPQ1+D3QY8MxNRX87R6-nUR9eP3JRTq_yuWfRq1upQT7iC8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:18:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVY68-0004af-N7
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 05:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbbCKESP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 00:18:15 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34307 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbCKESO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 00:18:14 -0400
Received: by iecsl2 with SMTP id sl2so10204828iec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 21:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BvDYvAVhZaWCycj/b1LcLMw/hN42S01/R100FT3Jd/k=;
        b=vw4xksqiAzEkBKIYFqwixcrqFKlPYYatNUQBZJQuZEs3wHKc4faeapFZNijHScJSoj
         NZ1vEyZUw0oZ5cGfpc/0dZWbgE7yeR8PBSo4qwUdHhj8IYXvVPzIkv3PVkHrtnmh6EIH
         c/RbPkuxDBqdHgB2ew2NbYYxnlisKK5T1G9nGEvUKLMReyDkA/Tg3OuggpAGx5D/3j7C
         5l0k2maQvjQm6MP285+Q+fGbFCqp6obfQbJ4Wq/e7+kryhAugqYhzJS7KMPAkiv5ozXf
         AzF0Lg2BV0S8NtsGSvT3/X0W6ZdgD5U8q9pOHgkHji6ukT49vAdT739nVZ0meCEiUxYq
         zAlQ==
X-Received: by 10.50.131.196 with SMTP id oo4mr62538076igb.2.1426047493755;
 Tue, 10 Mar 2015 21:18:13 -0700 (PDT)
Received: by 10.64.240.141 with HTTP; Tue, 10 Mar 2015 21:17:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265298>

I just released version 2.1 of Tig which brings a lot of improvements to speed
up usage in large repositories such as the Linux kernel repo (see improvements
related to #310, #324, #350, and #368). Else this release brings minor
improvements across the board plus a fair amount of bug fixes. See below for
more details.

 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - Gitter: https://gitter.im/jonas/tig
 - Gitweb: http://repo.or.cz/w/tig.git
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvements:

 - Improve C99 compliance so Tig compiles with the native compilers on
   Solaris (SunStudio cc) and AIX (xlc). (GH #380)
 - Add move-half-page-up and move-half-page-down actions. (GH #323)
 - Preserve the cursor position when changing the diff context.
 - Show 'Unstaged changes' above 'Staged changes' in the main view. (GH #383)
 - Add `:exec <flags><args...>` prompt command to execute commands.
 - Add shorthand for changing the view settings of a single column,
   eg. `set main-view-author = short`. (GH #318)
 - Show better diff context info in the stage view.
 - Add `%(lineno)` state variable. (GH #304)
 - Use hash table to speed up refs lookup. (GH #350)
 - Show the file path in the blob view when available.
 - Use `set commit-order = default` to use Git's default commit order, even when
   the commit graph is enabled. The option will turn off automatic enabling of
   `--topo-order` when the graph is shown in the main view. (GH #310, #324)
 - Speed up the diff view in large repos by loading git-describe info after the
   diff content has been read. (GH #324)
 - Add the old graph rendering as an option. (GH #310, #324)
 - Add `main-options` setting for specifying default main view options.
   Example: `set main-options = --max-count=1000`. (GH #368)
 - See `contrib/large-repo.tigrc` for settings that will help to speed up Tig in
   large repos. (GH #368)
 - Add `:save-options <file>` prompt command to save config to file. (GH #315)

Bug fixes:

 - Update manual to reflect default keybinding changes. (GH #325)
 - Fix graph support for `--first-parent`. (GH #326)
 - Fix off-by-one error when opening editor from the grep view.
 - Fix status on-branch information.
 - Fix main view to handle the case when git-log doesn't find any commits.
 - Fix corner case when parsing diff chunk when lines information is missing.
 - Ensure main view changes commits are shown right before the current HEAD.
 - Fix rendering of boundary commits.
 - Fix compilation with GNU Make 3.80 by removing `$(abspath)`. (GH #362)
 - Fix config parsing to support shell-like quoting in user-defined command,
   e.g. `bind generic <Ctrl-f> :!git log -G"%(prompt Prompt: )"` (GH #371)
 - Make diff meta information colors more consistent with Git. (GH #375)
 - Fix segfault when updating changes in a maximized stage view opened via the
   main view. (GH #376)
 - Handle line number configs where the interval is not specified. (GH #378)
 - Fix display of error messages during startup. (GH #385)
 - Show untracked files outside the current directory like git-status. (GH #230)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 INSTALL.adoc                           |    8 +
 Makefile                               |   25 +-
 NEWS.adoc                              |   51 +-
 README.adoc                            |    3 +-
 contrib/config.make-CYGWIN_NT-6.1      |    5 +-
 contrib/config.make-Darwin             |   10 +-
 contrib/large-repo.tigrc               |   20 +
 doc/manual.adoc                        |   41 +-
 doc/tigrc.5.adoc                       |   77 +-
 include/tig/argv.h                     |   36 +-
 include/tig/blame.h                    |    2 +-
 include/tig/blob.h                     |    2 +-
 include/tig/diff.h                     |    9 +-
 include/tig/display.h                  |    5 +-
 include/tig/draw.h                     |    4 +-
 include/tig/git.h                      |   16 +-
 include/tig/graph.h                    |   87 +-
 include/tig/grep.h                     |    2 +-
 include/tig/help.h                     |    2 +-
 include/tig/io.h                       |    3 +-
 include/tig/keys.h                     |   21 +-
 include/tig/line.h                     |    7 +-
 include/tig/log.h                      |    2 +-
 include/tig/main.h                     |    8 +-
 include/tig/map.h                      |   63 ++
 include/tig/options.h                  |   47 +-
 include/tig/pager.h                    |    2 +-
 include/tig/parse.h                    |    2 +-
 include/tig/prompt.h                   |    3 +-
 include/tig/refdb.h                    |   28 +-
 include/tig/refs.h                     |    2 +-
 include/tig/repo.h                     |    4 +-
 include/tig/request.h                  |   10 +-
 include/tig/stage.h                    |    2 +-
 include/tig/stash.h                    |    2 +-
 include/tig/status.h                   |    2 +-
 include/tig/string.h                   |   10 +-
 include/tig/tig.h                      |    5 +-
 include/tig/tree.h                     |    2 +-
 include/tig/types.h                    |   21 +-
 include/tig/util.h                     |    4 +-
 include/tig/view.h                     |   13 +-
 include/tig/watch.h                    |    2 +-
 src/argv.c                             |  203 +++--
 src/blame.c                            |   16 +-
 src/blob.c                             |   28 +-
 src/diff.c                             |  111 ++-
 src/display.c                          |   40 +-
 src/draw.c                             |   73 +-
 src/graph-v1.c                         |  504 +++++++++++
 src/graph-v2.c                         | 1117 ++++++++++++++++++++++++
 src/graph.c                            |  989 +--------------------
 src/grep.c                             |    9 +-
 src/help.c                             |  121 +--
 src/io.c                               |   24 +-
 src/keys.c                             |  211 ++++-
 src/line.c                             |   17 +-
 src/log.c                              |    2 +-
 src/main.c                             |  162 ++--
 src/map.c                              |  122 +++
 src/options.c                          |  364 ++++++--
 src/pager.c                            |   42 +-
 src/parse.c                            |  112 +--
 src/prompt.c                           |  182 ++--
 src/refdb.c                            |  308 ++++---
 src/refs.c                             |   15 +-
 src/repo.c                             |   36 +-
 src/request.c                          |    2 +-
 src/stage.c                            |   39 +-
 src/stash.c                            |    2 +-
 src/status.c                           |   47 +-
 src/string.c                           |    2 +-
 src/tig.c                              |   61 +-
 src/tree.c                             |    2 +-
 src/types.c                            |   10 +-
 src/util.c                             |    2 +-
 src/view.c                             |  271 +++++-
 src/watch.c                            |    4 +-
 test/README.adoc                       |    7 +-
 test/blame/default-test                |   42 +-
 test/blame/start-on-line-test          |   50 ++
 test/diff/diff-context-test            |  213 +++++
 test/diff/editor-test                  |   61 ++
 test/diff/start-on-line-test           |   45 +
 test/grep/default-test                 |    8 +-
 test/grep/editor-test                  |   50 ++
 test/grep/start-on-line-test           |   50 ++
 test/help/all-keybindings-test         |  129 +++
 test/help/default-test                 |  117 +++
 test/log/pretty-format-test            |    3 +-
 test/log/start-on-line-test            |   44 +
 test/log/submodule-test                |    7 +-
 test/main/boundary-test                |   37 +
 test/main/commit-order-edge-case-test  |    1 -
 test/main/commit-title-overflow-test   |    5 +-
 test/main/default-test                 |    2 +-
 test/main/graph-argument-test          |   68 ++
 test/main/main-options-test            |   38 +
 test/main/no-matching-commmits-test    |   25 +
 test/main/refresh-test                 |   27 +-
 test/main/search-test                  |    1 -
 test/main/show-changes-test            |   45 +-
 test/main/start-on-line-test           |   48 +
 test/main/submodule-test               |    5 +-
 test/main/update-unstaged-changes-test |   42 +
 test/main/util.sh                      |    2 +-
 test/main/view-split-test              |   35 +-
 test/refs/branch-checkout-test         |   77 +-
 test/refs/default-test                 |   38 +-
 test/refs/refresh-test                 |  104 +++
 test/refs/replace-test                 |   80 ++
 test/refs/start-on-line-test           |   50 ++
 test/regressions/github-370-test       |   18 +
 test/script/default-test               |    4 +-
 test/stage/default-test                |  245 ++++++
 test/stash/start-on-line-test          |   57 ++
 test/status/file-name-test             |    3 +-
 test/status/on-branch-test             |  179 ++++
 test/status/refresh-test               |   29 +-
 test/status/start-on-line-test         |   45 +
 test/status/untracked-files-test       |   79 ++
 test/tigrc/builtin-error-test          |    2 +-
 test/tigrc/compat-error-test           |    2 +-
 test/tigrc/contrib-tigrc-test          |   26 +
 test/tigrc/env-vars-test               |    2 +-
 test/tigrc/parse-test                  |   16 +-
 test/tigrc/quote-test                  |   63 ++
 test/tigrc/save-option-test            |   29 +
 test/tigrc/tigrc-manpage-examples-test |    2 +-
 test/tigrc/view-column-test            |   64 ++
 test/tools/libgit.sh                   |    7 +-
 test/tools/libtest.sh                  |  200 ++++-
 test/tools/setup-conflict.sh           |   14 +-
 test/tools/test-graph.c                |   46 +-
 test/tree/default-test                 |    2 +-
 tigrc                                  |   22 +-
 tools/aspell.dict                      |   10 +-
 tools/doc-gen.c                        |    2 +-
 tools/header.h                         |    2 +-
 139 files changed, 6381 insertions(+), 2265 deletions(-)

     1 Aaron Lindsay
     6 Charles Bailey
     1 Islam Azab
     5 Jeff King
   108 Jonas Fonseca
     1 Peter Dave Hello
     1 The Gitter Badger
     1 Tom Greuter

-- 
Jonas Fonseca
