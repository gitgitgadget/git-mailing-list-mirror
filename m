From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.2
Date: Sun, 1 Feb 2009 19:57:14 +0100
Message-ID: <8c5c35580902011057p76897120n66dc194e717240c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 19:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LThWj-0000YW-N5
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 19:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZBAS5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 13:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZBAS5Q
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 13:57:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:53694 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbZBAS5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 13:57:15 -0500
Received: by wa-out-1112.google.com with SMTP id v33so569554wah.21
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Rd/idXdfDAu90E00f/4/Ao5UBrSid8beKBo7w69Vrpc=;
        b=CHZEkzIV8t1QLulCbNtvXCM00pxaKQDwxwYE72hdIQkfqsoKOvJ1pD2WrUxHwtVYnU
         Dk2F9VJsoTU4FtbOr03GPnjN6xkhzBTEEgT18E//lRP4GNNCojJ853y72WvuFHfEQOIE
         dXy8WTnwNPsWa8Y7jcC1/fwq2R+L2Z8QZEJ04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UFSfvneWrosTqooCRFB/ls3pJ+rruxeTIvqi2qYxdBpoi0+HP+zEdspKsnuPGNZik8
         iyO92zEDX5taeWltECjvVmYMs+wL5cT60gitAiupGDYvMKU8ZXJL8j4jcXrY/TQcEH4r
         PkDhPtDEBh8XWDaaerZIhJqYKuEnl3hLOks/c=
Received: by 10.114.192.17 with SMTP id p17mr2335803waf.196.1233514634444; 
	Sun, 01 Feb 2009 10:57:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107988>

Feature-release 0.8.2 (+ bugfix release 0.8.1.1) of cgit, a fast
webinterface for git, is now available:

Clone:   git://hjemli.net/pub/git/cgit
Browse:  http://hjemli.net/git/cgit

The highlights:
* The repository list can now be sorted on any column
* The shortlog can be expanded to show full commit messages
* New stats-view shows simple time/author-related statistics
* Log- and commit-view are now decorated with refnames
* Binary files are properly handled in diff- and plain-views (aka `hexdump -C`)
* Working text-selection in plain-view
* Plenty of bugfixes

Big thanks to everyone who provided patches, ideas and feedback!

Bugfixes included in 0.8.1.1
============================
Karl Chen (1):
      Use mode 0644 for non-executable files

Lars Hjemli (13):
      Use GIT-1.6.0.3
      ui-repolist: handle empty agefiles
      ui-log: try to disambiguate ref names
      Makefile: allow cgit.conf to override platform-specific tweaks
      ui-repolist: avoid build warning for strcasestr(3)
      parsing.c: enable builds with NO_ICONV defined
      tests/t0010-validate-html.sh: skip tests if 'tidy' is not available
      tests/setup.sh: allow testsuite to fail properly with POSIX standard shell
      ui-tree.c: do not add blank line when displaying blobs
      Makefile: avoid libcurl when building git
      ui-tag: escape tagnames properly
      Avoid SEGFAULT on invalid requests
      CGIT 0.8.1.1

Ramsay Jones (3):
      Fix some warnings to allow -Werror
      Fix tests to work on Ubuntu (dash)
      Extra cygwin-specific changes

Todd Zullinger (3):
      Fix tar.bz2 snapshot example
      Makefile: add INSTALL var to set install command
      Makefile: install cgit.{css,png} in CGIT_DATA_PATH

Tomas Carnecky (1):
      ui-patch: whitespace changes in the patch generation code



Additional changes in 0.8.2
===========================
Benjamin Close (1):
      Add support for sorting by Age in the repolist

Justin Waters (2):
      Change toggle to more meaningful term
      Add decorations to commit pages

Lars Hjemli (33):
      ui-repolist: extract get_repo_modtime() from print_modtime()
      ui-repolist: add support for sorting any column
      ui-repolist: sort null values last
      ui-repolist: implement lazy caching of repo->mtime
      ui-log: add support for showing the full commit message
      ui-log: (ab)use extra columns for commit message when showmsg=1
      ui-log: use css to make full-log prettier
      ui-snapshot: improve extraction of revision from snapshot name
      ui-shared: exploit snapshot dwimmery in cgit_print_snapshot_links
      ui-refs.c: show download links for all tags referring to commit objects
      ui-shared: shorten the sha1 printed by cgit_object_link
      Add a 'stats' page to each repo
      ui-stats: enable path-filtered stats
      ui-stats: replace 'enable-stats' setting with 'max-stats'
      ui-shared: add and use cgit_stats_link()
      ui-tree: add link to stats page per path
      ui-shared: externalize add_hidden_formfields()
      ui-stats.c: reuse cgit_add_hidden_formfields()
      Untie logic for SCRIPT_NAME and PATH_INFO
      shared.c: future-proof usage of git diff-structures
      Use GIT-1.6.1
      ui-snapshot.c: change mime-type for tar.gz and tar.bz2
      tests/t0107-snapshot.sh: make testscript match updated snapshot behavior
      ui-log: show name-decorations in log output
      cgit.css: minor adjustment of commit decorations
      tests/t0105-commit.sh: expect commit decorations
      Add support for a custom header
      html.c: use correct escaping in html attributes
      Handle binary files in diffs
      ui-tree: show hexdump of binary blobs
      shared.c: avoid SEGFAULT when checking for binary buffers
      Use GIT-1.6.1.1
      CGIT 0.8.2

Natanael Copa (2):
      Set prefix in snapshots when using dwimmery
      return 404 if snapshot is not found

Onne Gorter (1):
      changed objects are outputted, allowing for selections of code only

Robin Redeker (2):
      ui-refs: avoid SEGFAULT on lightweight tags
      Make all tags viewable
