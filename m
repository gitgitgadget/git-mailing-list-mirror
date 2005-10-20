From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Errors from http-fetch
Date: Thu, 20 Oct 2005 16:02:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510201558231.25300@iabervon.org>
References: <Pine.LNX.4.64.0510191536350.25300@iabervon.org>
 <20051019212644.GB6160@reactrix.com> <Pine.LNX.4.64.0510191755280.25300@iabervon.org>
 <20051019223708.GC6160@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 22:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESgd5-0005Gl-VR
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 22:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVJTUDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVJTUDI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 16:03:08 -0400
Received: from iabervon.org ([66.92.72.58]:49936 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932518AbVJTUDH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 16:03:07 -0400
Received: (qmail 14798 invoked by uid 1000); 20 Oct 2005 16:02:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Oct 2005 16:02:23 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051019223708.GC6160@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10376>

On Wed, 19 Oct 2005, Nick Hengeveld wrote:

> > Another thing I noticed was that it was in the middle of downloading the 
> > pack when it suddenly exitted due to not being able to find the object; it 
> > would probably be worth having a call to finish up the active transfers 
> > after giving up on completing the whole thing, since we probably do 
> > actually want to finish downloading a big pack if we've started.
> 
> I'm not sure how that could happen - once a pack download request
> starts, it has to finish before any fetch() calls can fail.  However,
> there could certainly be other object requests in process when one
> fails, and it would be polite to let them finish.

Hmm; it definitely cut off a pack download in progress. When I ran it 
again, it resumed that download, which contained the missing object. Last 
night, I didn't see any problems, though. I'd certainly believe that 
server disagreement could be a factor, though.

	-Daniel
*This .sig left intentionally blank*
