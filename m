From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 02:34:41 -0500
Message-ID: <20061228073441.GB17304@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpn1-0000sg-1l
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWL1Heq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWL1Heq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:34:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45787 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964953AbWL1Heq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:34:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzpmL-0007vO-6o; Thu, 28 Dec 2006 02:34:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DA38D20FB65; Thu, 28 Dec 2006 02:34:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35524>

This series of patches is a group of minor interface and performance
improvements for am/pull/rebase.

  1 Use GIT_REFLOG_ACTION environment variable instead.
  2 Honor GIT_REFLOG_ACTION in git-rebase.

    These two replace my prior 2 patch series in the same area.

  3 Use branch names in 'git-rebase -m' conflict hunks.

    This is a UI improvement to show better conflicts out of rebase.

  4 Ensure `git-pull` fails if `git-merge` fails.

    Trivial fix to make git-pull more friendly to other scripts.

  5 Honor pull.{twohead,octopus} in git-merge.
  6 Allow git-merge to select the default strategy.

    This moves the default merge strategy selection into git-merge,
    making it part of that tool rather than git-pull.  This makes
    it possible to get the same behavior from `git merge foo` as
    you already get from `git pull . foo`.

  7 Avoid git-fetch in `git-pull .` when possible.

    This is a performance improvement for pull, and offers some
    other nice benefits (see patch).

  8 Move better_branch_name above get_ref in merge-recursive.
  9 Allow merging bare trees in merge-recursive.
 10 Use merge-recursive in git-am -3.

    These three switch to merge-recursive in git-am, see patch 10's
    message for the benefits.

 11 Improve merge performance by avoiding in-index merges.

    This is a general performance improvement for all two-headed
    merges which might use merge-recursive.


I'd like to see these appear in v1.5.0, but we're getting close to
the release so I can understand if they get delayed.

-- 
Shawn.
