From: Greg KH <greg@kroah.com>
Subject: Re: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 20:57:26 -0700
Message-ID: <20070414035726.GA6488@kroah.com>
References: <20070413203837.GA27660@kroah.com> <Pine.LNX.4.64.0704131431040.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 06:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcZd1-0006N8-HH
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 06:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbXDNEMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 00:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbXDNEMl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 00:12:41 -0400
Received: from canuck.infradead.org ([209.217.80.40]:57498 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbXDNEMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 00:12:40 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HcZcs-0002Hw-QR; Sat, 14 Apr 2007 00:12:39 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704131431040.28042@woody.linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44442>

On Fri, Apr 13, 2007 at 02:34:18PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 13 Apr 2007, Greg KH wrote:
> >
> > In git 1.5.1 the quiltimport function started complaining in a new way:
> > 
> > 	libata-clear-tf-before-doing-request-sense.patch
> > 	Patch is empty.  Was is split wrong?
> > 	/usr/bin/git-quiltimport: line 78: stop_here: command not found
> 
> This is an *old* bug. It got fixed once already. Did it get re-introduced?
> 
> Ahh - somebody copied the bug from git-applymbox
> 
> > Any hints?  Or is it time to start bisecting?
> 
> This should fix it.
> 
> There were two bugs: "stop_here" doesn't exist, but the bug that causes 
> this code to trigger in the *first* place is the wrong use of "$dotest". 
> It should be ".dotest"

Thanks, that seems to do the trick for me.

greg k-h
