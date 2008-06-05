From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 0/2] git add --edit
Date: Fri, 6 Jun 2008 00:06:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806060005581.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4OZq-0007wJ-Sa
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbYFEXHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbYFEXHo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:07:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:44338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753497AbYFEXHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:07:43 -0400
Received: (qmail invoked by alias); 05 Jun 2008 23:07:41 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 06 Jun 2008 01:07:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MY+ZqgF4M/937xR76fsThrwsCuio3d9nMNZciz3
	DG1DzA5EC0Cp0r
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806052304300.21190@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83994>


Changes relative to v2:

- it works now not by chance, but by design,

- empty lines are interpreted as if they contained a single space,

- it works when adding lines to the beginning or end of a file, and

- the apply option has been renamed to --recount, as per Junio's request.

Johannes Schindelin (2):
  Allow git-apply to ignore the hunk headers (AKA recountdiff)
  git-add: introduce --edit (to edit the diff vs. the index)

 Documentation/git-add.txt   |   13 ++++-
 Documentation/git-apply.txt |    7 ++-
 builtin-add.c               |   55 ++++++++++++++++++-
 builtin-apply.c             |   64 ++++++++++++++++++++--
 t/t3702-add-edit.sh         |  126 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 257 insertions(+), 8 deletions(-)
 create mode 100755 t/t3702-add-edit.sh
