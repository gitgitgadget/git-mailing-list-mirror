From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 00/14] git notes
Date: Sat, 12 Sep 2009 18:08:34 +0200
Message-ID: <1252771728-27206-1-git-send-email-johan@herland.net>
References: <200909121752.07523.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 18:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVA1-0008G8-15
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbZILQJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZILQJD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:09:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44056 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753169AbZILQJB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:09:01 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003GS8V3ZG20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:03 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0048W8V0EM30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:03 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.155718
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <200909121752.07523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128256>

The sixth iteration of the 'git notes' feature. Rebased on top of current
'next', otherwise unchanged from v5.


Have fun! :)

...Johan


Johan Herland (9):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"
  fast-import: Add support for importing commit notes
  t3302-notes-index-expensive: Speed up create_repo()
  Add flags to get_commit_notes() to control the format of the note string
  Teach notes code to free its internal data structures on request.
  Teach the notes lookup code to parse notes trees with various fanout schemes
  Selftests verifying semantics when loading notes trees with various fanouts
  Allow flexible organization of notes trees, using both commit date and SHA1
  Add test cases for various date-based fanouts

Johannes Schindelin (5):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes
  Add '%N'-format for pretty-printing commit notes

 .gitignore                        |    1 +
 Documentation/config.txt          |   13 +
 Documentation/git-fast-import.txt |   45 +++-
 Documentation/git-notes.txt       |   60 ++++
 Documentation/pretty-formats.txt  |    1 +
 Makefile                          |    3 +
 cache.h                           |    4 +
 command-list.txt                  |    1 +
 commit.c                          |    1 +
 config.c                          |    5 +
 environment.c                     |    1 +
 fast-import.c                     |   88 +++++-
 git-notes.sh                      |  121 +++++++
 notes.c                           |  673 +++++++++++++++++++++++++++++++++++++
 notes.h                           |   12 +
 pretty.c                          |   10 +
 t/t3301-notes.sh                  |  150 ++++++++
 t/t3302-notes-index-expensive.sh  |  118 +++++++
 t/t3303-notes-subtrees.sh         |  201 +++++++++++
 t/t9300-fast-import.sh            |  166 +++++++++
 20 files changed, 1664 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
 create mode 100755 t/t3303-notes-subtrees.sh
