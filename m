From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/5] per branch options for git-merge incl. --no-ff
Date: Sat, 22 Sep 2007 02:33:01 +0200
Message-ID: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsvd-0000uq-EJ
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105AbXIVAcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXIVAcz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:32:55 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46806 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758155AbXIVAcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:32:54 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8M0WYsN018896;
	Sat, 22 Sep 2007 02:32:34 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58903>

This patch-series implements support for per branch configuration of
git-merge, using entries (branch.<name>.mergeoptions) in .git/config.

There is also a new option, --no-ff, which can be used to force git-merge
to create merge commits even when the merge was a fast-forward.

Finally, the new optiond --ff and --commit can be used to override
setting specified in .git/config.

Note: patch 1/5 is a resend of the testscript for git-merge, this time
with correct mode bits.

Shortlog:
     Add test-script for git-merge porcelain
     git-merge: refactor option parsing
     git-merge: add support for branch.<name>.mergeoptions
     git-merge: add support for --commit
     git-merge: add --ff and --no-ff options

Diffstat:
 Documentation/config.txt        |    6 +
 Documentation/git-merge.txt     |    4 +
 Documentation/merge-options.txt |   13 ++
 git-merge.sh                    |   56 +++++-
 t/t7600-merge.sh                |  414 +++++++++++++++++++++++++++++++++++++++

 5 files changed, 483 insertions(+), 10 deletions(-)
