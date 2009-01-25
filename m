From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH v1 0/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 09:30:54 -0800
Message-ID: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 18:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR92H-0006Ap-Dn
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 18:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZAYRnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbZAYRnN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 12:43:13 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:34037 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbZAYRnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 12:43:13 -0500
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jan 2009 12:43:13 EST
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n0PHUwjM031869;
	Sun, 25 Jan 2009 09:30:58 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n0PHUvWM031868;
	Sun, 25 Jan 2009 09:30:57 -0800
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107069>

The next three patches introduce a way to specify diff options
git always obeys. Then use the new feature to
enhance git-gui with white space ignore settings.  The fastest
way to see this patch in action is: apply all three patches,
fire up git-gui, modify a file, then right-click on the diff
panel and look for the new "White Space" sub-menu.

Future work: Extend the gitattributes mechanism so it supports
all [diff] config variables, including e.g. diff.mnemonicprefix
and diff.primer.

Keith Cascio (3):
 Introduce config variable "diff.primer"
 Test functionality of new config variable "diff.primer"
 git-gui hooks for new config variable "diff.primer"

 Documentation/config.txt       |   14 +++++
 Documentation/diff-options.txt |   13 +++++
 Makefile                       |    2 +
 builtin-log.c                  |    1 +
 diff.c                         |   83 ++++++++++++++++++++++++++----
 diff.h                         |   15 ++++-
 git-gui/git-gui.sh             |   51 ++++++++++++++++++
 git-gui/lib/diff.tcl           |    8 ++-
 git-gui/lib/option.tcl         |   57 +++++++++++++++++++--
 gitk-git/gitk                  |   16 +++---
 t/t4033-diff-primer.sh         |  111 ++++++++++++++++++++++++++++++++++++++++
 11 files changed, 343 insertions(+), 28 deletions(-)
 create mode 100755 t/t4033-diff-primer.sh
