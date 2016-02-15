From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] svn pathnameencoding for git svn dcommit
Date: Mon, 15 Feb 2016 00:52:10 +0000
Message-ID: <20160215005210.GA31141@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.crezoff@gmail.com,
	Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 01:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV7Oj-0006b9-70
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 01:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbcBOAwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 19:52:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53869 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbcBOAwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 19:52:12 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC13120276;
	Mon, 15 Feb 2016 00:52:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160208225806.GA3487@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286166>

I've amended tests to both commits, but the URL encoding one
requires an HTTP server to test effectively.

I couldn't find a test prereq for httpd, but perhaps it's good
to test by default regardless in case a future SVN changes
file:// behavior.  I've only tested this with SVN 1.6.17 under
Debian wheezy.

The following changes since commit 6faf27b4ff26804a07363078b238b5cfd3dfa976:

  Merge branch 'tb/conversion' into next (2016-02-12 10:20:20 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git ks/svn-pathnameencoding

for you to fetch changes up to dfee0cf8123e7f63268f05a02731ce82db136188:

  git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-15 00:31:21 +0000)

----------------------------------------------------------------
Kazutoshi Satoda (2):
      git-svn: enable "svn.pathnameencoding" on dcommit
      git-svn: apply "svn.pathnameencoding" before URL encoding

 perl/Git/SVN/Editor.pm                   |  4 +++-
 t/t9115-git-svn-dcommit-funky-renames.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)
