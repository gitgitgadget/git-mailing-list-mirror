From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/6] per branch options for git-merge
Date: Mon, 24 Sep 2007 00:51:39 +0200
Message-ID: <1190587905-700-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIz-0002CH-TG
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbXIWWv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXIWWv1
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:27 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42801 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972AbXIWWv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:26 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91L023085;
	Mon, 24 Sep 2007 00:51:09 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58997>

This patch-series implements support for per branch configuration of
git-merge, using entries (branch.<name>.mergeoptions) in .git/config.
Since this makes it possible to specify --no-commit and --squash as
default options for git-merge, the new options --commit and --no-squash
are added to enable users to override such defaults.

There is also a new option, --no-ff, which can be used to force git-merge
to create a merge commit even when the merge was a fast-forward (and a
matching --ff option to allow overrides).

Shortlog:
  Add test-script for git-merge porcelain
  git-merge: fix faulty SQUASH_MSG
  git-merge: refactor option parsing
  git-merge: add support for branch.<name>.mergeoptions
  git-merge: add support for --commit and --no-squash
  git-merge: add --ff and --no-ff options

Diffstat:
 Documentation/config.txt        |    6 +
 Documentation/git-merge.txt     |    4 +
 Documentation/merge-options.txt |   17 ++
 git-merge.sh                    |   65 +++++-
 t/t7600-merge.sh                |  440 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 521 insertions(+), 11 deletions(-)
