From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/9] add --gpg-sign to rebase and pull
Date: Fri, 24 Jan 2014 00:50:57 +0000
Message-ID: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Uzi-0001jP-RW
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbaAXAvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:20 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51324 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103AbaAXAvS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:18 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D5B8B28074;
	Fri, 24 Jan 2014 00:51:15 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240987>

This series was posted to the list some time back, but it fell through
the cracks.  This is a re-send of Nicolas Vigier's work with an
additional patch that adds --gpg-sign to pull as well.  I added my
sign-off to his patches because SubmittingPatches (section (c)) seems to
imply that I should, although I can rebase it out if it's a problem.

I've been running with this patch set for some time now, and haven't
found any issues, although I wouldn't recommend doing large rebases
without a gpg-agent running.

I'm happy to fix any issues that come up in order to move this series as
expeditiously as possible, but seeing as I'm in San Francisco at the
moment, re-rolls might be delayed through the next few days.

Nicolas Vigier (8):
  cherry-pick, revert: add the --gpg-sign option
  git-sh-setup.sh: add variable to use the stuck-long mode
  am: parse options in stuck-long mode
  am: add the --gpg-sign option
  rebase: remove useless arguments check
  rebase: don't try to match -M option
  rebase: parse options in stuck-long mode
  rebase: add the --gpg-sign option

brian m. carlson (1):
  pull: add the --gpg-sign option.

 Documentation/git-am.txt          |  6 +++-
 Documentation/git-cherry-pick.txt |  7 ++++-
 Documentation/git-rebase.txt      |  4 +++
 Documentation/git-revert.txt      |  6 +++-
 builtin/revert.c                  |  2 ++
 contrib/examples/git-checkout.sh  |  1 +
 contrib/examples/git-clean.sh     |  1 +
 contrib/examples/git-clone.sh     |  1 +
 contrib/examples/git-merge.sh     |  1 +
 contrib/examples/git-repack.sh    |  1 +
 contrib/git-resurrect.sh          |  1 +
 git-am.sh                         | 26 ++++++++++------
 git-instaweb.sh                   |  1 +
 git-pull.sh                       | 13 +++++++-
 git-quiltimport.sh                |  1 +
 git-rebase--am.sh                 |  8 +++--
 git-rebase--interactive.sh        | 32 ++++++++++++--------
 git-rebase--merge.sh              |  2 +-
 git-rebase.sh                     | 62 +++++++++++++++++++++------------------
 git-request-pull.sh               |  1 +
 git-sh-setup.sh                   |  2 ++
 sequencer.c                       | 11 +++++++
 sequencer.h                       |  2 ++
 23 files changed, 134 insertions(+), 58 deletions(-)

-- 
1.9.rc0.1002.gd081c64.dirty
