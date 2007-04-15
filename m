From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 16:33:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
 <7vfy712uva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEEy-0004eB-6C
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXDOXdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbXDOXdx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:33:53 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39190 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbXDOXdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:33:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FNXlIs029684
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 16:33:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FNXkfm022526;
	Sun, 15 Apr 2007 16:33:47 -0700
In-Reply-To: <7vfy712uva.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44546>



On Sun, 15 Apr 2007, Junio C Hamano wrote:
> >
> > But no, I wasn't following that series, so I probably totally 
> > misunderstood what you were going after..
> 
> Could be.
> 
> The issue in short was about:
> 
> 	$ git checkout $branch
> 
> At this point you think your HEAD is at $branch head, and you
> are working towards building a commit that has that commit as
> one of the parents.
> 
> Then a gremlin updates the commit HEAD points at.

Ahh, ok. I was kind of expecting that you'd actually do something at 
"receive-pack" time instead, not at the next commit. That would also solve 
it - just have an option saying "update the working tree when receiving". 

And since I thought that was what you were aiming at, I didn't see why you 
wanted to hide the previous commit in the index..

All clear now. My confusion.

		Linus
