From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Sat, 23 Jun 2007 19:56:12 +0200
Message-ID: <00e001c7b5bf$ca04ed50$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Steven Grimm'" <koreth@midwinter.com>,
	"'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jun 23 20:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2AND-0002Xi-0v
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXFWSaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 14:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbXFWSaL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 14:30:11 -0400
Received: from csmtp.b-one.net ([195.47.247.21]:46742 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbXFWSaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 14:30:10 -0400
X-Greylist: delayed 2030 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jun 2007 14:30:09 EDT
Received: from Jocke (84-217-10-122.tn.glocalnet.net [84.217.10.122])
	by csmtp1.b-one.net (Postfix) with ESMTP id 8E5E61911AF29;
	Sat, 23 Jun 2007 19:56:17 +0200 (CEST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AceuTY6CGj8csMBVQ8yWNUXXI3DLfwGdcLSwAD8A/sA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50744>

> > $ echo post-merge trunk change >> trunk/testfile1
> > $ svn commit -m "trunk change after merge"
> > $ echo post-merge conflicting change >> trunk/testfile2
> > $ svn commit -m "trunk change with conflict"
> > $ cd ../gitclone
> > $ git-svn fetch
> > $ git merge -m "change with conflict" trunk
> > 
> > Conflict, as expected
> > 
> > $ vi testfile2
> > $ git add testfile2
> > $ git commit
> > $ git-svn dcommit
> > Transaction is out of date: Out of date: '/trunk/testfile1' in 
> > transaction '9-1' at /Users/koreth/git/git-svn line 398
> 
> Maybe this can help?
> http://svn.haxx.se/subusers/archive-2005-02/0096.shtml
> http://subclipse.tigris.org/faq.html#out-of-date

Could this be related to do_update vs. do_switch?
Latest subversion appears to have a working
do_switch function.   


Jocke
