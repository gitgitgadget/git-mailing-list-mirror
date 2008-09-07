From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Patch for git-svn.perl
Date: Sat, 6 Sep 2008 19:03:16 -0700
Message-ID: <20080907020307.GA12234@untitled>
References: <257934.40788.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: brad.king@kitware.com, git@vger.kernel.org,
	Paul Talacko <gnuruandstuff@yahoo.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc9fL-0000he-9i
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYIGCDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 22:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYIGCDS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:03:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42000 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbYIGCDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 22:03:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A8FB82DC01B;
	Sat,  6 Sep 2008 19:03:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <257934.40788.qm@web27803.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95101>

Paul Talacko <gnuruandstuff@yahoo.co.uk> wrote:
> Hello,
> 
> There's an issue in git-svn as autoprops are not applied to renamed
> files, only to added files.
> 
> This patch fixes the bug.

Thanks Paul.  I've also added a test case as well.

Junio,

I've rebased against 80d12c2 and repushed out to
git://git.bogomips.org/git-svn.git along with the following changes:

Eric Wong (2):
      git-svn: check error code of send_txstream
      t9124: clean up chdir usage

Florian Weimer (3):
      git-svn: extract base blob in generate_diff
      git-svn: Introduce SVN::Git::Editor::_chg_file_get_blob
      git-svn: Send deltas during commits

Paul Talacko (1):
      git-svn: set auto_props when renaming files

Thomas Rast (9):
      git svn: catch lack of upstream info for dcommit earlier
      git svn info: tests: let 'init' test run with SVN 1.5
      git svn info: tests: do not use set -e
      git svn info: tests: use test_cmp instead of git-diff
      git svn info: tests: fix ptouch argument order in setup
      git svn info: make info relative to the current directory
      git svn info: always quote URLs in 'info' output
      git-svn: match SVN 1.5 behaviour of info' on unknown item
      git-svn: fix 'info' tests for unknown items

-- 
Eric Wong
