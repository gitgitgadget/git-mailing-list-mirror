From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Tue, 17 Jul 2007 23:23:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707172302560.14596@iabervon.org>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
 <Pine.LNX.4.64.0707172216420.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 05:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB094-0006jg-TO
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 05:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbXGRDX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 23:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933368AbXGRDX5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 23:23:57 -0400
Received: from iabervon.org ([66.92.72.58]:2347 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762935AbXGRDXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 23:23:50 -0400
Received: (qmail 17666 invoked by uid 1000); 18 Jul 2007 03:23:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2007 03:23:49 -0000
In-Reply-To: <Pine.LNX.4.64.0707172216420.14596@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52825>

On Tue, 17 Jul 2007, Daniel Barkalow wrote:

> On Tue, 17 Jul 2007, Johannes Schindelin wrote:
> 
> > The transport specific stuff was moved into libgit.a, and the
> > bundle specific stuff will not be left behind.
> > 
> > This is a big code move, with one exception: the function
> > unbundle() no longer outputs the list of refs.  You have to call
> > list_bundle_refs() yourself for that.
> 
> You should use -C on this sort of thing, so that the interesting aspects 
> of the patch are easier to see. (It actually comes out longer in this 
> case, but it's far easier to tell that the code in the new file is the 
> same as the old code.) Can you tell I've been rearranging a lot of code 
> lately and trying to make the patches not look really scary?

Actually, I ended up touching this up a tiny bit, too: I ordered the 
functions in bundle.c the way they were in builtin-bundle.c (so that the 
patch is more trivial) and removed the blank lines at the end of the file. 
This makes the "git diff -C" output really obvious. 

(Someday, I'd like to have a diff that can show that a substantial block 
of '+' lines matches a block of lines from somewhere in the "before" 
content, so reviewers can verify that the patch reorders code but doesn't 
change it, or changes it in certain ways. But, of course, that's both hard 
to generate and hard to display usefully.)

	-Daniel
*This .sig left intentionally blank*
