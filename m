From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 13:30:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706141328380.14121@woody.linux-foundation.org>
References: <18031.64456.948230.375333@lisa.zopyra.com>
 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
 <18033.14520.846510.640130@lisa.zopyra.com>
 <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
 <20070614202027.GA47039@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 22:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyvxv-0004Km-2t
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 22:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbXFNUao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbXFNUan
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 16:30:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47585 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752246AbXFNUam (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 16:30:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5EKUECc012473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 13:30:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5EKU8fX001748;
	Thu, 14 Jun 2007 13:30:09 -0700
In-Reply-To: <20070614202027.GA47039@dspnet.fr.eu.org>
X-Spam-Status: No, hits=-2.594 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50219>



On Thu, 14 Jun 2007, Olivier Galibert wrote:

> On Thu, Jun 14, 2007 at 08:46:27AM -0700, Linus Torvalds wrote:
> > So it might be easier to take a "git stash ; git pull ; git unstash" 
> > approach instead of making "git pull" handle working tree conflicts 
> > itseld.
> 
> Isn't that "git add .; git commit; git fetch; git rebase <something>;
> git reset ^HEAD"?  With the conflict resolution happening at rebase
> time.

No.

The two workflows happen to co-incide *if* the "git pull" is a 
fast-forward, but not if you actually had previous commits that you 
wanted the "git pull" to merge.

So if you want things to actually work as a "git pull with dirty state 
merge", you really do need to do "git stash + git pull + git unstash".

		Linus
