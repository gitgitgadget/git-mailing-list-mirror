From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Make --decorate more useful
Date: Wed, 11 Jul 2007 02:28:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110220340.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 11 03:36:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8R7m-00028x-RO
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbXGKBgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbXGKBgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:36:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754443AbXGKBgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:36:08 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:36:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 11 Jul 2007 03:36:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tf+EV0hRtS0LwT74fh/+nDS8L26x3ji0ARYp4Rt
	ovOlBL9fQmONtU
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52123>


This series is meant to (partially) replace the patch I posted in

http://article.gmane.org/gmane.comp.version-control.git/24383

Often it is useful to find out what feature came in when, to quickly
find out if some version of the software is sufficient, or if the
other person has to upgrade.

With this series applied, you can say

	git log --decorate=tag -S<some keyword> <file>

to find out what that version was, indeed you even get a human readable
name for that commit, in addition to the commit name.

Johannes Schindelin (4):
      Move add_name_decoration() and add_ref_decoration() to commit.[ch]
      Move the --decorate option from builtin-log.c to revision.c.
      --decorate now decorates ancestors, too
      --decorate: prefer shorter names

 Documentation/git-log.txt        |    3 -
 Documentation/pretty-options.txt |   15 ++++++
 builtin-log.c                    |   39 +-------------
 commit.c                         |  104 ++++++++++++++++++++++++++++++++++++++
 commit.h                         |    5 ++
 log-tree.c                       |    4 ++
 revision.c                       |   47 +++++++++++++++++
 revision.h                       |    9 +++
 8 files changed, 186 insertions(+), 40 deletions(-)
