From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.1.1
Date: Wed, 8 Apr 2015 20:34:35 -0400
Message-ID: <CAFuPQ1+5Cpb5VYPdF3E0i3Fp++MRs6DwPnkJZ171MHNzrq5hTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 02:35:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg0Qw-0000EJ-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 02:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbbDIAe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 20:34:58 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34734 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbDIAe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 20:34:56 -0400
Received: by iedfl3 with SMTP id fl3so99986177ied.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=K6aCJvJ8dovBhOD1KfMVde6HHvcr/JPCD99HZMrGVwY=;
        b=PzaGq8XJbvJtIiUXAW3JgP5lQGT8N5+AZYdCoEX/hgxgNpyjMAUw+AMFFiaGHZlnzV
         uLK9GL4W70c5RhEpBNqMm5UI+FMzReinrXq23NLFrcHqxL/s8aP4c+NCRHYfGHbp44HA
         QmcVDbAgimqXWpOTUTCxRqxSDgqQQ5Xz3WkcFCF6SEeW//KQIMZYLnck5TaHZOWpz5LR
         U4ALBfLkfmEYl2EDaNZwf7yYN8XpJvQIm7KNHLfY1+/9QioruxyHvlfm807u4NqoL69N
         Wyo1lnI/6ku3OaY9WtbwtagOk6hyclXnBG80RCcSLeRI6O4iULTl9mzYftzAZgrjhIHD
         3x4g==
X-Received: by 10.50.131.196 with SMTP id oo4mr16270904igb.2.1428539696003;
 Wed, 08 Apr 2015 17:34:56 -0700 (PDT)
Received: by 10.64.250.6 with HTTP; Wed, 8 Apr 2015 17:34:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266979>

Hi,

This release fixes a couple of regressions that broke rendering of references
in the main view and usage of the stage view. It also adds support for key
combos which was originally planed for 2.1 (see contrib/vim.tigrc for an
example). Finally, files (or blobs) can now be searched using the new
GitHub-inspired file finder (press 'f' to launch it).

 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - Gitter: https://gitter.im/jonas/tig
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvements:

 - Add support for key combos. (GH #67)
 - See `contrib/vim.tigrc` for Vim-like keybindings. (GH #273, #351)
 - Add GitHub inspired file finder to search for and open any file. (GH #342)
 - Add `search` keymap for navigation file finder search results.

Bug fixes:

 - Fix display of multiple references per commit. (GH #390, #391)
 - Sync the prompt's cursor position with readline's internal position. (#396)
 - Keep unstaged changes view open after an staging command. (#399)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                       |   3 +
 COPYING                          |  39 ++--
 Makefile                         |  45 ++++-
 NEWS.adoc                        |  16 ++
 README.adoc                      |   2 +-
 config.make.in                   |   5 +-
 configure.ac                     |   5 +
 contrib/vim.tigrc                |  73 ++++++++
 doc/tigrc.5.adoc                 |   3 +-
 include/tig/blob.h               |   7 +-
 include/tig/display.h            |   2 +-
 include/tig/keys.h               |  10 +-
 include/tig/main.h               |   2 +
 include/tig/prompt.h             |   1 +
 include/tig/ui.h                 |  20 ++
 src/blob.c                       |  29 ++-
 src/display.c                    |  19 +-
 src/keys.c                       |  56 ++++--
 src/main.c                       |  20 ++
 src/options.c                    |   2 +-
 src/prompt.c                     |  25 +--
 src/refdb.c                      |  21 ++-
 src/stage.c                      |  22 +--
 src/status.c                     |   2 +
 src/tig.c                        |  58 ++++--
 src/ui.c                         | 304 +++++++++++++++++++++++++++++++
 test/help/all-keybindings-test   |  10 +-
 test/help/default-test           |  14 +-
 test/main/graph-argument-test    |  28 +--
 test/main/show-changes-test      |  24 +++
 test/main/start-on-line-test     |  42 ++---
 test/main/view-split-test        |  18 +-
 test/regressions/github-390-test |  41 +++++
 test/status/file-name-test       |   8 +-
 test/tigrc/compat-error-test     |   2 -
 test/tigrc/parse-test            |   4 +-
 tigrc                            |   7 +
 tools/aspell.dict                |  12 +-
 tools/gcov.m4                    |  94 ++++++++++
 39 files changed, 912 insertions(+), 183 deletions(-)

Alexander Sulfrian (1):
      Fix insertion/ordering of refs in refs_by_id map.

Andreas Stieger (1):
      Update FSF address in COPYING

Jonas Fonseca (12):
      Remove Gitweb link in favour of Gitter
      Integrate coverage reporting for the test suite
      Experimental support for key combos
      Fix user-action prompt display regression
      Add key_to_value helper to extract the ncurses key value
      Add GitHub inspired file finder to search for and open any file
      Fix regression test to exec git-tag in background
      Fix display saving to account for variable length UTF-8 characters
      When redrawing the readline prompt also update the cursor position
      Keep unstaged changes view open after an staging command
      Add search keymap with keys for navigating search results
      tig-2.1.1

Ramsay Jones (1):
      Fix segmentation Fault on 32-bit

Vivien Didelot (1):
      contrib: complete Vim-like bindings

-- 
Jonas Fonseca
