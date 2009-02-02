From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: [PATCH v2 0/2] Introduce config variable "diff.primer"
Date: Mon, 2 Feb 2009 13:03:59 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902021302000.7881@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 22:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5zQ-0001Gd-Om
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZBBVEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbZBBVED
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:04:03 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:57180 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbZBBVEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:04:01 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n12L3xZH015033;
	Mon, 2 Feb 2009 13:03:59 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n12L3xvT015030;
	Mon, 2 Feb 2009 13:03:59 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108122>

The next two patches introduce a means by which to specify non-default options 
porcelain diff automatically obeys.  This version v2 fixes the problem with v1 
(violation of plumbing guarantee) by switching to opt_in rather than opt_out 
semantics.  v2 also corrects code style to mimic established convention.

At least one list poster expressed interest in implementing complimentary
functionality, i.e. "primer.*":
http://article.gmane.org/gmane.comp.version-control.git/107158
"primer.diff" compliments "diff.primer", the two styles in no way exclude each
other, and therefore "primer.*" is a good opportunity for future work.

Keith Cascio (2):
 Introduce config variable "diff.primer"
 Test functionality of new config variable "diff.primer"

 Documentation/config.txt       |   14 ++++
 Documentation/diff-options.txt |   10 +++
 builtin-diff.c                 |    2 +
 diff.c                         |   77 +++++++++++++++++++++---
 diff.h                         |   14 ++++-
 gitk-git/gitk                  |   16 +++---
 t/t4035-diff-primer.sh         |  129 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 242 insertions(+), 20 deletions(-)
