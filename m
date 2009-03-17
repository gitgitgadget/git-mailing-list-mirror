From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Tue, 17 Mar 2009 12:06:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903171121260.19665@iabervon.org>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>  <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>  <alpine.LNX.1.00.0903161204240.19665@iabervon.org> <76718490903161301qca2214cta87411bad1b0b8b5@mail.gmail.com> <49BEEAF4.40403@develer.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, bernie@codewiz.org,
	git@vger.kernel.org
To: Giovanni Bajo <rasky@develer.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbqS-00010g-LS
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbZCQQGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757700AbZCQQGp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:06:45 -0400
Received: from iabervon.org ([66.92.72.58]:47427 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756820AbZCQQGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:06:44 -0400
Received: (qmail 18133 invoked by uid 1000); 17 Mar 2009 16:06:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2009 16:06:42 -0000
In-Reply-To: <49BEEAF4.40403@develer.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113489>

On Tue, 17 Mar 2009, Giovanni Bajo wrote:

> On 3/16/2009 9:01 PM, Jay Soffian wrote:
> > On Mon, Mar 16, 2009 at 12:55 PM, Daniel Barkalow <barkalow@iabervon.org>
> > wrote:
> > > No default remote is configured for your current branch, and the default
> > > remote "origin" is not configured either.
> > 
> > The use of "default" twice is slightly confusing. Perhaps:
> > 
> > No remote is configured for the current branch, and the default
> > remote "origin" is not configured either.
> 
> I'm a total newbie with git. I must say that the above sentence means
> absolutely nothing to me (in either version) because of the confusing usage of
> the word "remote" (twice, one as a substantive, one as an adjective) and the
> word "origin" which is git jargon which I don't master yet.

Actually, it's not that complicated a sentence. In order to 
fetch/pull/push, you need to specify some attributes of the other side; at 
a minimum, this is the location, but you can also specify other things 
(HTTP gateways if you're using HTTP, for example). You can have multiple 
of these sets of configuration stored under different names; these are 
remotes.

When you run fetch, you can specify the remote on the command line. If you 
don't specify, there are two levels of defaults: the first is a setting in 
the configuration for whichever branch is current; the second is the 
constant "origin".

The message is trying to say that it fell back to looking for a configured 
remote named "origin", but there wasn't one configured.

> My suggestion is that you should at least add a sentence that points to a
> likely solution. Something like:
> 
>   (use "git remote add" to configure a remote URL)
> 
> Note that I don't have any clue if this sentece is correct and/or is the
> correct solution. The above is just an example of a helpful error message.

The problem is that there are a number of different sorts of configuration 
you might want, and we have no way of knowing which it is.

You might mean to explicitly specify URLs every time to fetch or push in 
this repository; you might mean to have a different URL for each branch 
you work on; or you might mean to have a general default. It's also 
possible that you actually meant "git svn fetch", which uses different 
configuration info.

So I think we can only give pointers to the various things it looked for, 
and leave it up to the documentation to explain which you want, if any, 
and how to get it.

	-Daniel
*This .sig left intentionally blank*
