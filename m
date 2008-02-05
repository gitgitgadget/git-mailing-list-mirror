From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Bug?] uncommited changes cross branches
Date: Tue, 5 Feb 2008 15:07:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051502360.8543@racer.site>
References: <CB070331-8CA6-42CD-9CAD-20371F16DCD8@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPPc-0001CD-Dy
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbYBEPHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYBEPHy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:07:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:58646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750917AbYBEPHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:07:53 -0500
Received: (qmail invoked by alias); 05 Feb 2008 15:07:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 05 Feb 2008 16:07:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180aNE1ks80/OJ3JTErd6JX/2t8sholKbLnAYiNuQ
	FXyV19PgDkSKXN
X-X-Sender: gene099@racer.site
In-Reply-To: <CB070331-8CA6-42CD-9CAD-20371F16DCD8@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72666>

Hi,

On Tue, 5 Feb 2008, Rhodes, Kate wrote:

> If you have a file that exists in two branches in the same repo, make a 
> change to it without committing, then switch branches the changes carry 
> over, but if you make changes to a file that exists in only one of the 
> repos and try and switch branches Git complains that the file isn't 
> uptodate.  The latter behavior seems correct to me.

It is slightly different: if you change a file without committing _-and- 
the switch to another branch does not touch the file, git does not 
complain.

The rationale: git should refuse to switch branches _only_ if uncommitted 
changes would be lost.

However, if you change a file whose content is different in the other 
branch (and "not existing" qualifies), the uncommitted changes would be 
lost, and git should complain.

Ciao,
Dscho
