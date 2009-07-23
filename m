From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Make git-gc more robust with regard to grafts
Date: Thu, 23 Jul 2009 17:33:06 +0200 (CEST)
Message-ID: <cover.1248362827u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-939079865-1248363006=:8306"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 17:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU0IL-0004ba-0G
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 17:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbZGWPdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZGWPdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 11:33:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:44550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752792AbZGWPdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 11:33:08 -0400
Received: (qmail invoked by alias); 23 Jul 2009 15:33:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 23 Jul 2009 17:33:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/N8+9fuUfN0/UR0tcqB6JxrNRSMkQ1f1IJXoe7yP
	P6xWpUFS4xwGKL
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0907231733050.8306@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123872>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-939079865-1248363006=:8306
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0907231733051.8306@pacific.mpi-cbg.de>

More and more Git newbies are taught the wonders of Git grafts.  But that 
is dangerous if the exercise is not to use filter-branch right away.

So let's make git-repack (and thereby, git-gc) aware of grafts and avoid 
culling the parent commits hidden by grafts.

Björn Steinbrink (1):
  Add a test showing that 'git repack' throws away grafted-away parents

Johannes Schindelin (1):
  git repack: keep commits hidden by a graft

 Documentation/git-pack-objects.txt |    7 ++++++-
 builtin-pack-objects.c             |    4 ++++
 cache.h                            |    2 ++
 commit.c                           |    2 +-
 environment.c                      |    1 +
 git-repack.sh                      |    2 +-
 t/t7700-repack.sh                  |   12 ++++++++++++
 7 files changed, 27 insertions(+), 3 deletions(-)
--8323328-939079865-1248363006=:8306--
