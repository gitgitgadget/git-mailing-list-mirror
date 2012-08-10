From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git svn: reset invalidates the memoized mergeinfo
 caches
Date: Fri, 10 Aug 2012 20:22:11 +0000
Message-ID: <20120810202211.GA16606@dcvr.yhbt.net>
References: <20120807200207.GA10899@m62s10.vlinux.de>
 <20120807204510.GA10453@dcvr.yhbt.net>
 <20120808054129.GB10899@m62s10.vlinux.de>
 <20120808225258.GA24956@dcvr.yhbt.net>
 <20120809064253.GC10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvjP-0000bw-N7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab2HJUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:22:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52900 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab2HJUWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:22:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D441F42C;
	Fri, 10 Aug 2012 20:22:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120809064253.GC10899@m62s10.vlinux.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203258>

Peter Baumann <waste.manager@gmx.de> wrote:
> First, let me thank you for your review and your detailed explanation.
> I really appreciate it.

You're welcome, Peter.  Thanks again for the patch.  I've signed-off and
pushed for Junio.

The following changes since commit 034161a94e827ef05790b1c7ce5a6e3e740c864e:

  Merge git://github.com/git-l10n/git-po (2012-08-09 10:51:46 -0700)

are available in the git repository at:


  git://bogomips.org/git-svn for-git-master

for you to fetch changes up to 61b472ed8b090a3e9240590c85041120a54dd268:

  git svn: reset invalidates the memoized mergeinfo caches (2012-08-10 19:53:18 +0000)

----------------------------------------------------------------
Peter Baumann (1):
      git svn: reset invalidates the memoized mergeinfo caches

Robert Luberda (1):
      git svn: handle errors and concurrent commits in dcommit

 git-svn.perl                           |  74 ++++++++---
 perl/Git/SVN.pm                        |  27 ++++-
 t/t9163-git-svn-reset-clears-caches.sh |  78 ++++++++++++
 t/t9164-git-svn-dcommit-concrrent.sh   | 216 +++++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+), 21 deletions(-)
 create mode 100755 t/t9163-git-svn-reset-clears-caches.sh
 create mode 100755 t/t9164-git-svn-dcommit-concrrent.sh
