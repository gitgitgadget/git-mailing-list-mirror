From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL v2] git-svn updates for 2.2
Date: Fri, 31 Oct 2014 10:53:48 +0000
Message-ID: <20141031105348.GA28822@dcvr.yhbt.net>
References: <20141031012906.GA23354@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>,
	Hin-Tak Leung <htl10@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 11:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk9q5-0001UO-Li
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 11:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668AbaJaKxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 06:53:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44410 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757637AbaJaKxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 06:53:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118111F838;
	Fri, 31 Oct 2014 10:53:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141031012906.GA23354@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> Hi Junio, I haven't heard back from Hin-Tak about the last one
> ("git-svn: coerce check_path and get_log args to int")[1],
> but I think it's a harmless defensive patch in case you
> want to tag 2.2-rc0 soon.

OK, that coercion patch was pointless and I worked around the problem
differently with "git-svn: use SVN::Ra::get_dir2 when possible"

So here's another try which I feel better about (except it's way past
my bedtime right now...):

The following changes since commit fbecd99861ea5795aeba46faf2ac7a8c1b70d485:

  Update draft release notes to 2.2 (2014-10-24 15:02:17 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git for-junio

for you to fetch changes up to 7ffa35b0479dac547659f06b8a6ea7d31c57cc05:

  git-svn: use SVN::Ra::get_dir2 when possible (2014-10-31 10:34:54 +0000)

----------------------------------------------------------------
Eric Wong (12):
      git-svn: reduce check_cherry_pick cache overhead
      git-svn: cache only mergeinfo revisions
      git-svn: remove mergeinfo rev caching
      git-svn: reload RA every log-window-size
      git-svn: remove unnecessary DESTROY override
      git-svn: save a little memory as fetch progresses
      git-svn: disable _rev_list memoization
      Git.pm: add specified name to tempfile template
      git-svn: prepare SVN::Ra config pieces once
      git-svn: (cleanup) remove editor param passing
      git-svn: add space after "W:" prefix in warning
      git-svn: use SVN::Ra::get_dir2 when possible

Jakob Stoklund Olesen (2):
      git-svn: only look at the new parts of svn:mergeinfo
      git-svn: only look at the root path for svn:mergeinfo

Sveinung Kvilhaugsvik (1):
      git-svn.txt: advertise pushurl with dcommit

 Documentation/git-svn.txt |   4 ++
 perl/Git.pm               |   5 +-
 perl/Git/SVN.pm           | 125 ++++++++++++++++++++++++++++------------------
 perl/Git/SVN/Ra.pm        | 102 ++++++++++++++++++++++---------------
 4 files changed, 145 insertions(+), 91 deletions(-)
-- 
EW
