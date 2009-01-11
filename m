From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH 0/3] Enable in-process submodule traversal
Date: Mon, 12 Jan 2009 00:45:52 +0100
Message-ID: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 01:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMAQz-0004yj-3U
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZALAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbZALAMM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:12:12 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:39867 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbZALAML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 19:12:11 -0500
X-Greylist: delayed 1568 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Jan 2009 19:12:10 EST
Received: from localhost.localdomain (ti0025a380-2268.bb.online.no [80.213.203.224])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id n0BNjuv3029874;
	Mon, 12 Jan 2009 00:45:57 +0100 (MET)
X-Mailer: git-send-email 1.6.1.83.g408d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105258>

This patch series implements basic support for traversing the tree objects
in submodules when the linked commit object is reachable. Normally such
linked commit objects will not be reachable in the containing repository,
but adding local copies of submodule repositories as alternate object
databases for the containing repo solves this issue.

The first patch in the series does all the 'hard work' required for the
traversal to work, while the next two patches adds a '--submodules' flag
to git-archive and git-ls-tree as proof of concept.

Lars Hjemli (3):
  tree.c: add support for traversal of submodules
  archive.c: enable traversal of submodules
  builtin-ls-tree: enable traversal of submodules

 archive.c         |    2 ++
 builtin-ls-tree.c |   23 ++++++++---------------
 tree.c            |   20 +++++++++++++++++---
 tree.h            |    1 +
 4 files changed, 28 insertions(+), 18 deletions(-)
