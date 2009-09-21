From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 0/8] Extend git gui for better "centralized" workflow integration
Date: Mon, 21 Sep 2009 15:06:47 +0200
Message-ID: <cover.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicD-0002uk-04
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbZIUNG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbZIUNG4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:06:56 -0400
Received: from darksea.de ([83.133.111.250]:35686 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756020AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28809 invoked from network); 21 Sep 2009 15:06:56 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:56 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128877>

This series is adding some more support for a centralized workflow with
code review based on feature branches. Most of it is plugging existing
functionality together so the most typical steps can be done at once.

In our team at $dayjob we use a workflow were each developer creates
feature branches and once he is satified with his change he sends out a
review request to another developer (the reviewer) which is most
familiar with the code parts involved in the change. If the reviewer
likes the change he merges it into the upstream branch (master). He then
publishes the new master and deletes the feature branch. Thats a quick
description of the workflow I am trying to add more support for with
this series.

There are still some TODO markers in there and if someone can help me
with those I would be very glad. This is the first time I am doing some
more extensive programming in tcl/tk and git gui so I hope you do not
tear everything apart ;)

The last patch is not really about the same topic but since it currently
relies on the changes of this series I included it nevertheless.

cheers Heiko


Heiko Voigt (8):
  git gui: add a "compose review email" checkbox to push dialog
  git gui: teach delete dialog to open with a default remote
  git gui: add checkbox to launch remote branch delete after push
  git gui: teach fetch operation to close dialog on successful
    completion
  git gui: do fetch from a default remote on startup
  git gui: add "review topic" menuitem which supports feature branch
    workflow
  Add documentation for git gui variables for email and delete after
    push
  git gui: make gc hint and fetch on startup sequential

 Documentation/config.txt             |   30 ++++++++++
 git-gui/git-gui.sh                   |   29 ++++++++-
 git-gui/lib/console.tcl              |    6 ++
 git-gui/lib/merge.tcl                |   83 ++++++++++++++++++++++++--
 git-gui/lib/option.tcl               |    5 ++
 git-gui/lib/remote_branch_delete.tcl |    6 +-
 git-gui/lib/transport.tcl            |  107 ++++++++++++++++++++++++++++++++-
 7 files changed, 250 insertions(+), 16 deletions(-)
