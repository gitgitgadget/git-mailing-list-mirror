Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808682018E
	for <e@80x24.org>; Thu, 11 Aug 2016 03:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbcHKDYa (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 23:24:30 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36850 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbcHKDY2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 23:24:28 -0400
Received: by mail-it0-f47.google.com with SMTP id x130so2716547ite.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 20:24:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZqnvEKYREMsfSD8dHqOs/EgWlXNfz1xsOzfk3MPA3k0=;
        b=ggmJJ5LnJ8sAXrwg46mLR6/cuXh8g0lp1GpC7Z3yOSZUxTRo85B8Rsy92mSZuOVoIi
         TsRSIvH7r37+PFhU+HBwqnE53qTorIMum+noLC+lK20ypgur2y7otxg8o7qTq9+0L3g2
         fp09ZZHyx1d5zJDq8GSa4X+V2NdtmHmAZb2v7WPxvwd1a7XC7mTbq8/u5XMKkyZ9t2Pr
         YgpBCtfBluI0Qtr1RtS4SQpW0n7JkRT/oznuLDaAyHkYRIAsvtOYGaS8PdeuX0kQVwUe
         4qmDxCzS04w2b1gEzHAari4VEcjAXASmZZabiwx9Ya5p2CgRl5jrFL8zO307zFsfnqml
         6nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZqnvEKYREMsfSD8dHqOs/EgWlXNfz1xsOzfk3MPA3k0=;
        b=gGq5lk+FQ3ajH8BTtiVS/px0Y3M0+hcFFw6AUWvOgShO7/1cCyFGsCARzUgZl8GkZG
         dY0EQstPIZx5xG2zK458BzdXPi4N+S5soj1k1joo0mUx7aaXdpCaEn7TR95yBJMVA8Sv
         a+OeTcZ0adIfTklc42ZWD5eTS8HeJlzuqVH0EYJpkGRaguBrBmZLj9/2SXeq0EqZFXkz
         PS6AhEmS2iEhIa0IqrtJ+i8ji1++KxR1IpApvUCyWU4JPHZL8gmgtf62uIrHHoK0jW+P
         At0UjFEnQIfneO4eZ9La0fTXpj5YqUNE/atwtjAKidSPKbelZSeEQQmQn6tScku0tBaJ
         AGxQ==
X-Gm-Message-State: AEkoousPkTFR7HD5WUBONxkA9W8KlthRFkQ7eQVVTL2PEn9IJ0KpPf7Sx6wcDV4MI9FM1Z1vgFphpceP4bFF9w==
X-Received: by 10.36.242.68 with SMTP id j65mr6906346ith.25.1470885857301;
 Wed, 10 Aug 2016 20:24:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.217.135 with HTTP; Wed, 10 Aug 2016 20:23:56 -0700 (PDT)
From:	Jonas Fonseca <jonas.fonseca@gmail.com>
Date:	Wed, 10 Aug 2016 23:23:56 -0400
Message-ID: <CAFuPQ1+i6BFRH=6HUWzDgM7J+hL_3hUNv5-4mjjGm=h-YWVuzg@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.2
To:	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I've just released the 35th release of Tig. It brings several search
improvements such as highlighting and wrap around, and machinery for future
support of typeahead search. This release also gives more choice over how the
user configuration file is loaded either at built-time or at runtime through
support of the XDG basedir spec. Among fixes several segfaults and invalid
reads have been addressed and the tests are now run with Valgrind and
AddressSanitizer by Travis on each push. There are several breaking changes so
ensure you read the section on incompatibilities in the release notes before
upgrading.

It's crazy to think that Tig has happily browsed Git repos for more than 10
years! Thanks to everybody who contributed and made that possible. Looking
forward to the next 10 years ...

 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - Gitter: https://gitter.im/jonas/tig
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Incompatibilities:

 - Note that all user-defined commands are now executed at the repository root
   instead of whatever subdirectory Tig was started in. (GH #412)
 - Remove `cmdline-args` option to avoid problems where setting it in `~/.tigrc`
   potentially breaks other views due to its "context-sensitive" nature, where
   a `git-log` option maybe cause `git-grep` to fail. (GH #431)

Improvements:

 - Use .mailmap to show canonical name and email addresses, off by default.
   Add `set mailmap = yes` to `~/.tigrc` to enable. (GH #411)
 - Highlight search results, configurable via `search-result` color. (GH #493)
 - Wrap around when searching, configurable via `wrap-search` setting.
 - Populate `%(file)` with file names from diff stat. (GH #404)
 - `tig --merge` implies `--boundary` similar to gitk.
 - Expose repository variables to external commands, e.g.
`%(repo:head)` gives the
   branch name of the current HEAD and `%(repo:cdup)` for the repo root path.
 - Add `make uninstall`. (GH #417)
 - Add ZSH completion file (based on Bash completion) (GH #433)
 - Expose the text of the currently selected line as the %(text) (GH #457)
 - Allow users to specify rev arguments to blame (GH #439)
 - Update OSX make config to find brew installed ncurses
 - Add sample git-flow keybinding (GH #421)
 - Add chocolate theme (GH #432)
 - Show stash diffs. (GH #328)
 - Make user tigrc location configurable. (GH #479)
 - Compact relative date display mode. (GH #331)
 - Add date column option controlling whether to show local date.
 - Move to parent commit in the main view. (GH #388)
 - Add `:goto <rev>` prompt command to go to a `git-rev-parse`d revision, e.g.
   `:goto some/branch` or `:goto %(commit)^2`.
 - Respect the XDG standard for configuration files. (GH #513)
 - Resolve diff paths when `diff.noprefix` is true. (GH #487, #488)
 - Support for custom `strftime(3)` date formats, e.g.:

        set main-view-date = custom
        set main-view-date-format = "%Y-%m-%d"

Bug fixes:

 - Prevent staged rename from displaying unstaged changes (GH #472, #491)
 - Fix corrupt chunk header during staging of single lines. (GH #410)
 - Fix out of bounds read in graph-v2 module. (GH #402)
 - Add currently checked out branch to `%(branch)`. (GH #416)
 - Size diff stats correctly for split views.
 - Fix `git-worktree` support by using `git-show-ref`. (GH #437)
 - Add currently checked out branch to `%(branch)` (GH #416)
 - Fix segfault when hitting return in empty file search (GH #464)
 - Remove separator on horizontal split when switching from vertical split
 - Do not expand `--all` when parsing `%(revargs)` (GH #442, #462)
 - Fix exit when the main view is reloaded due to option toggling. (GH #470)
 - Expand all whitespace and control characters to spaces. (GH #485)
 - Restore ability to unbind a default keybinding with `none`. (GH #483)
 - Fix blob view to honor the `wrap-lines` setting.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .mailmap                                      |   3 +
 .travis.yml                                   |  36 +-
 INSTALL.adoc                                  |  15 +
 Makefile                                      |  29 +-
 NEWS.adoc                                     |  65 ++-
 autogen.sh                                    |   4 +-
 contrib/chocolate.theme.tigrc                 |  16 +
 contrib/config.make-Darwin                    |  15 +-
 contrib/git-flow.tigrc                        |  49 +++
 contrib/tig-completion.zsh                    |  21 +
 contrib/tig.spec.in                           |   2 +-
 contrib/vim.tigrc                             |   3 +
 doc/manual.adoc                               |  29 +-
 doc/tig.1.adoc                                |   9 +-
 doc/tigrc.5.adoc                              |  40 +-
 include/tig/argv.h                            |   3 +-
 include/tig/display.h                         |   6 +
 include/tig/git.h                             |   4 -
 include/tig/io.h                              |  14 +-
 include/tig/keys.h                            |   2 +-
 include/tig/line.h                            |   4 +-
 include/tig/main.h                            |   2 +-
 include/tig/options.h                         |  20 +-
 include/tig/pager.h                           |   2 +-
 include/tig/prompt.h                          |   3 +-
 include/tig/refdb.h                           |   6 +-
 include/tig/repo.h                            |  27 +-
 include/tig/search.h                          |  25 ++
 include/tig/string.h                          |   7 +-
 include/tig/tig.h                             |   7 +
 include/tig/types.h                           |   4 +-
 include/tig/util.h                            |  29 +-
 include/tig/view.h                            |  60 ++-
 src/argv.c                                    | 102 +++--
 src/blame.c                                   |  80 ++--
 src/blob.c                                    |  12 +-
 src/diff.c                                    | 208 ++++++++--
 src/display.c                                 | 171 ++++----
 src/draw.c                                    | 243 ++++++-----
 src/graph-v1.c                                |  28 +-
 src/graph-v2.c                                |  42 +-
 src/grep.c                                    |  26 +-
 src/help.c                                    |  49 +--
 src/io.c                                      |  76 ++--
 src/keys.c                                    | 108 +++--
 src/line.c                                    |   4 +-
 src/log.c                                     |  28 +-
 src/main.c                                    | 107 ++---
 src/options.c                                 | 185 ++++++---
 src/pager.c                                   |  34 +-
 src/parse.c                                   |  39 +-
 src/prompt.c                                  |  77 ++--
 src/refdb.c                                   |  67 +--
 src/refs.c                                    |  38 +-
 src/repo.c                                    |  27 +-
 src/request.c                                 |   6 +-
 src/search.c                                  | 189 +++++++++
 src/stage.c                                   | 126 +++---
 src/stash.c                                   |  43 +-
 src/status.c                                  | 153 +++++--
 src/string.c                                  |  32 +-
 src/tig.c                                     |  96 +++--
 src/tree.c                                    |  40 +-
 src/types.c                                   |   6 +-
 src/ui.c                                      |  22 +-
 src/util.c                                    | 156 +++++--
 src/view.c                                    | 392 +++++++++---------
 src/watch.c                                   |  10 +-
 test/README.adoc                              |   6 +-
 test/blame/revargs-test                       |  82 ++++
 test/blob/wrap-lines-test                     |  54 +++
 test/diff/diff-stat-test                      |  51 +++
 test/diff/editor-test                         | 199 ++++++++-
 test/diff/wrap-lines-test                     |  51 +++
 test/files/refs-repo.tgz                      | Bin 0 -> 8013 bytes
 test/files/repo-one.tgz                       | Bin 0 -> 6722 bytes
 test/files/repo-two.tgz                       | Bin 0 -> 10985 bytes
 test/graph/gh-490-heap-buffer-overflow-test   |  18 +
 .../graph/gh-490-heap-buffer-overflow-test.gz | Bin 0 -> 336885 bytes
 test/help/user-command-test                   |  59 +++
 test/log/diff-stat-test                       |  86 ++++
 test/log/pretty-format-test                   |   3 +-
 test/log/submodule-test                       |  18 +-
 test/main/all-arg-test                        |  63 +++
 test/main/boundary-test                       |   2 -
 test/main/branch-var-test                     |  54 +++
 test/main/date-test                           | 207 +++++++++
 test/main/date-test.in                        | 201 +++++++++
 test/main/escape-control-characters-test      |  33 ++
 test/main/escape-control-characters-test.in   | Bin 0 -> 1725 bytes
 test/main/goto-test                           | 103 +++++
 test/main/mailmap-test                        |  65 +++
 test/main/merge-test                          |  33 ++
 test/main/refresh-test                        |   2 -
 test/main/show-changes-after-rename-test      |  32 ++
 test/main/show-changes-test                   |  26 +-
 test/main/submodule-test                      |  28 +-
 test/main/unbind-default-quit-key-test        |  31 ++
 test/main/update-unstaged-changes-test        |   2 -
 test/main/util.sh                             |  17 +-
 test/refs/branch-var-test                     |  59 +++
 test/refs/default-test                        |  53 +--
 test/refs/refresh-test                        |  56 +--
 test/refs/replace-test                        |   1 -
 test/refs/util.sh                             |  13 -
 test/refs/worktree-test                       |  33 ++
 test/regressions/github-434-test              | 123 ++++++
 test/stage/default-test                       |   4 +-
 test/stage/gh-410-test                        |  73 ++++
 test/stage/split-chunk-test                   |  96 +++++
 test/status/file-name-test                    |   8 +-
 test/status/file-var-test                     |  59 +++
 test/status/on-branch-test                    |  32 +-
 test/status/on-branch-tracking-info-test      | 105 +++++
 test/status/refresh-test                      |  22 +-
 test/status/repo-var-test                     |  21 +
 test/status/start-on-line-test                |   2 +-
 test/status/untracked-files-test              |   4 +-
 test/status/worktree-test                     |  32 ++
 test/tigrc/compat-error-test                  |  16 +-
 test/tigrc/view-column-test                   |   7 +-
 test/tigrc/xdg-config-home-test               |  31 ++
 test/tools/libgit.sh                          | 149 +------
 test/tools/libtest.sh                         | 198 +++++++--
 test/tools/show-results.sh                    |  10 +-
 test/tools/test-graph.c                       |   4 +-
 tigrc                                         |   9 +-
 tools/aspell.dict                             |  14 +-
 tools/doc-gen.c                               |  12 +-
 tools/uninstall.sh                            |  35 ++
 130 files changed, 4781 insertions(+), 1609 deletions(-)

     2 Adam Strzelecki
     1 Alexander Campbell
     1 Bostjan Skufca
     1 Daniel Hahler
     1 Edgar HIPP
     3 Eric Sunshine
     1 Harish Lall
     1 Jeff King
     3 Jeremy Cowgar
    84 Jonas Fonseca
     1 Kentaro Wada
     1 Laurent Arnoud
     1 Mantas Mikulėnas
     2 Michael J Gruber
     1 Murilo Opsfelder Araujo
     1 Olof-Joachim Frahm
     1 Reuben D'Netto
     2 Richard Burke
     2 Sven Wegener
     4 Vivien Didelot
     1 Wolfgang Reissnegger
     1 ideal
     1 samiraguiar

-- 
Jonas Fonseca
