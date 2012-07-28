From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Extract remaining classes from git-svn
Date: Sat, 28 Jul 2012 00:40:26 +0000
Message-ID: <20120728004026.GA5363@dcvr.yhbt.net>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suv5i-00058n-88
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 02:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2G1Ak1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 20:40:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34368 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab2G1Ak1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 20:40:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407011F5B6;
	Sat, 28 Jul 2012 00:40:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202396>

"Michael G. Schwern" <schwern@pobox.com> wrote:
> This series of patches extracts the remaining classes from git-svn.  They're
> all simple extractions and functionally have no change.

I've also pushed this to the "extract-remaining" series which
also includes everything that's currently in my master.

I squashed Michael's 8/8 trivial change into 3/8 to avoid introducing
a needless commit.  (I don't feel strongly about indentation for
alignment purposes in use() statements much, but since he submitted
the change...)


The following changes since commit cdd159b2f56c9e69e37bbb8f5af301abd93e5407:

  Merge branch 'jc/test-lib-source-build-options-early' (2012-07-25 15:47:08 -0700)

are available in the git repository at:


  git://bogomips.org/git-svn extract-remaining

for you to fetch changes up to 3d9be15fc2b8c8198253ae1c4dcaa343b74c3b8d:

  Extract Git::SVN::GlobSpec from git-svn. (2012-07-27 22:36:19 +0000)

----------------------------------------------------------------
Junio C Hamano (1):
      perl: detect new files in MakeMaker builds

Michael G. Schwern (14):
      Quiet warning if Makefile.PL is run with -w and no --localedir
      Don't lose Error.pm if $@ gets clobbered.
      The Makefile.PL will now find .pm files itself.
      Extract some utilities from git-svn to allow extracting Git::SVN.
      Prepare Git::SVN for extraction into its own file.
      Extract Git::SVN from git-svn into its own .pm file.
      Move initialization of Git::SVN variables into Git::SVN.
      Prepare Git::SVN::Log for extraction from git-svn.
      Extract Git::SVN::Log from git-svn.
      Prepare Git::SVN::Migration for extraction from git-svn.
      Extract Git::SVN::Migration from git-svn.
      Load all the modules in one place and before running code.
      Move Git::IndexInfo into its own file.
      Extract Git::SVN::GlobSpec from git-svn.

 Makefile                       |    7 +
 git-svn.perl                   | 3119 +---------------------------------------
 perl/.gitignore                |    1 +
 perl/Git/IndexInfo.pm          |   33 +
 perl/Git/SVN.pm                | 2326 ++++++++++++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm        |    1 +
 perl/Git/SVN/GlobSpec.pm       |   59 +
 perl/Git/SVN/Log.pm            |  395 +++++
 perl/Git/SVN/Migration.pm      |  258 ++++
 perl/Git/SVN/Utils.pm          |   59 +
 perl/Makefile                  |    9 +
 perl/Makefile.PL               |   35 +-
 t/Git-SVN/00compile.t          |   14 +
 t/Git-SVN/Utils/can_compress.t |   11 +
 t/Git-SVN/Utils/fatal.t        |   34 +
 15 files changed, 3272 insertions(+), 3089 deletions(-)
 create mode 100644 perl/Git/IndexInfo.pm
 create mode 100644 perl/Git/SVN.pm
 create mode 100644 perl/Git/SVN/GlobSpec.pm
 create mode 100644 perl/Git/SVN/Log.pm
 create mode 100644 perl/Git/SVN/Migration.pm
 create mode 100644 perl/Git/SVN/Utils.pm
 create mode 100644 t/Git-SVN/00compile.t
 create mode 100644 t/Git-SVN/Utils/can_compress.t
 create mode 100644 t/Git-SVN/Utils/fatal.t
