From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.0.2
Date: Thu, 8 May 2014 22:20:25 -0400
Message-ID: <CAFuPQ1+WgH9xAUzPaO_4Cv9VE_-+SL+XEa57EPNPjG=wuhdxsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 04:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaQf-0001MA-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbaEICUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:20:48 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35364 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbaEICUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:20:46 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so4143042obc.0
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=08IMe6YGyayouVWw43l5/VAbYf99ZB75R/UFpRQxbUk=;
        b=FrBEf3OQ6wXSieEm/Zzhd/M9ptMz5EXAOcXE97HfTfpDwxgOV7rB6jWbLb+ymFhL3A
         8HdKZRamrpem8CPSfWlI8tdfjGoeS6OQSNJrlxYgyqmj/ifamrOI2k0A/+FUhInYf3+S
         +cXPT1BPjOr3/NkVCEPb2aduPclWSPaJtH9NuCpigOlQuMPFL0+sQUa49WKeejz7gKdA
         TEmP8x8Dp9i7m5zhL2aHenTx/GhZutlepa+m196Ikr/8dxE2G7u37sPY6ncuw9/t243L
         d/6Rijb3r4dx6IKAn3VJSL/sYWkzw220tltiP4leRF3Flyf5OClmF45pF9tjKZpPWa+a
         Cxrw==
X-Received: by 10.60.132.12 with SMTP id oq12mr9671272oeb.42.1399602045608;
 Thu, 08 May 2014 19:20:45 -0700 (PDT)
Received: by 10.76.8.8 with HTTP; Thu, 8 May 2014 19:20:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248503>

Here's another bug fix release that addresses an issue with loading the refs,
main and grep views when gui.encoding was set, a build failure on OS X 10.6 as
well as a few other bugs reported since 2.0.1.

What is Tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

Resources
---------
 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - Gitweb: http://repo.or.cz/w/tig.git
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvements:

 - Use git-status for diffing the index.
 - Group toggle options together in the help view.

Bug fixes:

 - Fix refs, main and grep loading when 'gui.encoding' is set. (GH #287)
 - Ignore 'gui.encoding' and 'i18n.commitencoding' when set to 'UTF-8'.
 - Add work-around for missing strndup() on Mac OS X v10.6. (GH #286)
 - Fix spurious abbreviation of author names. (GH #288)
 - Don't show empty action groups in the help view.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 Makefile            |  7 ++++-
 NEWS.adoc           | 16 ++++++++++
 compat/compat.h     |  6 ++++
 compat/strndup.c    | 54 +++++++++++++++++++++++++++++++++
 config.make.in      |  1 +
 configure.ac        |  1 +
 doc/tigrc.5.adoc    | 67 +++++++++++++++++++++-------------------
 include/tig/io.h    | 11 +++++--
 include/tig/main.h  |  2 +-
 include/tig/pager.h |  2 +-
 include/tig/repo.h  |  9 ++++--
 include/tig/view.h  |  2 +-
 src/argv.c          |  8 ++---
 src/blame.c         | 27 +++++++++--------
 src/blob.c          |  6 ++--
 src/diff.c          | 14 ++++-----
 src/draw.c          |  4 +--
 src/grep.c          | 12 ++++----
 src/help.c          | 20 ++++++++----
 src/io.c            | 74 +++++++++++++++++++++++++--------------------
 src/keys.c          | 33 ++++++++++++--------
 src/log.c           |  6 ++--
 src/main.c          | 18 ++++++-----
 src/options.c       |  4 ++-
 src/pager.c         |  6 ++--
 src/prompt.c        |  4 ++-
 src/refs.c          | 12 ++++----
 src/repo.c          | 46 +++++++++++++++++-----------
 src/stage.c         | 10 +++---
 src/status.c        | 16 +++++-----
 src/tree.c          | 22 +++++++-------
 src/view.c          | 17 ++++++-----
 src/watch.c         |  7 +++--
 test/test-graph.c   |  6 ++--
 tools/aspell.dict   | 12 ++++----
 tools/release.sh    |  2 +-
 36 files changed, 354 insertions(+), 210 deletions(-)

Jonas Fonseca (16):
      Fix auto-abbreviation of author names
      Improve display of commas and spaces in the help view
      Rewrite index diffing to use git-status
      Group option toggle bindings together in the help view
      Never show any actions for a hidden keymap
      Fix infinite loop when parsing view columns
      Use buffer when reading data using io_get()
      Use buffer for reading view data
      Ignore 'gui.encoding' and 'i18n.commitencoding' when set to 'UTF-8'
      Only use the delimiter character for trimmed and unscrollable text
      Improve warning for obsolete view UI options
      Improve documentation of view settings in tigrc(5)
      Move cursor to the first line when :0 is entered
      Fix documentation of author width option
      Fix release script to work for patch versions
      tig-2.0.2

Vivien Didelot (2):
      compat: add proper work-around for missing strndup
      argv: revert part of a3079e2

-- 
Jonas Fonseca
