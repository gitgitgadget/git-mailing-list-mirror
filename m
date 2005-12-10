From: freku045@student.liu.se
Subject: [PATCH 0/25] Usage message clean-up
Date: Sat, 10 Dec 2005 20:37:56 +0100
Message-ID: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: freku045@student.liu.se
X-From: git-owner@vger.kernel.org Sat Dec 10 20:41:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYc-0002PO-SR
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVLJTiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVLJTiQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:16 -0500
Received: from [85.8.31.11] ([85.8.31.11]:19661 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161033AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D6D4D40FD; Sat, 10 Dec 2005 20:48:13 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXc-0006yY-00; Sat, 10 Dec 2005 20:37:56 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13472>

This patch series is supposed to clean-up usage strings in *.sh and
*.perl. I have gone through most of the scripts, but have left the
following programs for various reasons.

No obvious fix:
  git-log.sh
  git-parse-remote.sh
  git-rebase.sh

Still todo:
  git-archimport.perl
  git-cvsexportcommit.perl
  git-cvsimport.perl
  git-svnimport.perl
  git-applymbox.sh
  git-applypatch.sh
  git-fmt-merge-msg.perl
  cmd-rename.sh
  git-ls-remote.sh
  git-merge-octopus.sh
  git-merge-one-file.sh
  git-merge-ours.sh
  git-merge-resolve.sh
  git-merge-stupid.sh
  git-octopus.sh
  git-parse-remote.sh



I have tried to follow the following rules:

* Any unrecognised options should make the script die with the usage
  message.
* -h and --help makes the script die with the usage message.
* The message is printed to stderr.
* The message is of the form "usage: $0 options"

I am not convinced that the last bullet point is the best way to do
things. Using "$0" is probably best for Git developers but using "git
program-name" is probably least confusing for users, especially if we
are going to move the git-* binaries away from /usr/bin. Another
option is "basename $0". What do you think?

--

 Documentation/git-revert.txt |    2 +
 git-bisect.sh                |    2 +
 git-branch.sh                |    2 +
 git-checkout.sh              |    2 +
 git-cherry.sh                |   18 ++++++++++--
 git-clone.sh                 |    2 +
 git-commit.sh                |    2 +
 git-count-objects.sh         |   11 +++++++
 git-fetch.sh                 |    8 +++++
 git-format-patch.sh          |    3 +-
 git-grep.sh                  |   11 ++++++-
 git-lost-found.sh            |   12 +++++++-
 git-merge.sh                 |    2 +
 git-mv.perl                  |   10 ++++++-
 git-prune.sh                 |    2 +
 git-pull.sh                  |    3 +-
 git-push.sh                  |    2 +
 git-relink.perl              |   10 +++----
 git-repack.sh                |    7 ++++-
 git-request-pull.sh          |    6 ++--
 git-reset.sh                 |    2 +
 git-revert.sh                |    4 +--
 git-send-email.perl          |   62 +++++++++++++++++++++++-------------------
 git-status.sh                |   12 +++++++-
 git-tag.sh                   |   10 +------
 git-verify-tag.sh            |   10 +++----
 26 files changed, 142 insertions(+), 75 deletions(-)

- Fredrik
