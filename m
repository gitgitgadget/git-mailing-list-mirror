From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix issues found by gcc 4.6.0
Date: Tue, 22 Mar 2011 13:49:56 +0100 (CET)
Message-ID: <cover.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 13:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q212K-0007RZ-Vq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1CVMuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:50:07 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:38345 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753477Ab1CVMuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 08:50:06 -0400
Received: (qmail invoked by alias); 22 Mar 2011 12:50:02 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp012) with SMTP; 22 Mar 2011 13:50:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197SuEboVJ7dktVxscP9iyA+QdoIIZ673J5k7XsPg
	B9e4DbXIJK/kIk
X-X-Sender: gene099@bonsai2
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169728>

In general, our sources are quite clean. However, a few variables were
unused. Previous gcc version did not find them because they were assigned
values, but those values were never used nontheless.

The tricky question is whether 2/2 really fixes an issue or not.
Unfortunately, my time is too limited to go into detail, but I figured
it'd be better to raise the issue than to remain silent.

Johannes Schindelin (2):
  Remove unused variables
  Actually use retval

 builtin/fsck.c       |    3 +--
 builtin/remote-ext.c |    4 ----
 diff.c               |    3 +--
 merge-recursive.c    |    4 ----
 reachable.c          |    5 -----
 test-subprocess.c    |    3 +--
 transport-helper.c   |    3 +--
 tree-diff.c          |    2 +-
 8 files changed, 5 insertions(+), 22 deletions(-)

-- 
1.7.4.msysgit.0.167.ge91fd
