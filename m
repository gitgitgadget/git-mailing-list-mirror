From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sun, 29 Apr 2007 02:01:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2TW-0005MU-Q9
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 08:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbXD2GBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 02:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbXD2GBM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 02:01:12 -0400
Received: from iabervon.org ([66.92.72.58]:1109 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223AbXD2GBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 02:01:11 -0400
Received: (qmail 14852 invoked by uid 1000); 29 Apr 2007 06:01:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2007 06:01:10 -0000
In-Reply-To: <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45814>

On Sat, 28 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > With the --remote option, send-pack will look at the remote
> > configuration for the specified remote (which must match the
> > destination URL), and update the local tracking refs to match changes
> > it causes in the remote heads they track.
> >
> > The previous values of local tracking heads are ignored.
> 
> I didn't actually look at the code of this patch, as I am
> rejecting the initial round of [PATCH 2/5] this depends on, but
> this is one thing Cogito did that we don't, and I think it makes
> sort of sense.  We pretend as if we fetched back immediately
> after we pushed without giving anybody a chance to further
> update the refs we updated at the remote.  I generally do not
> like "pretend that we did something" when talking about reliable
> operations (and SCM _is_ all about reliable operation), and this
> behaviour is exactly it, but I think this one is excusable.

I'll redo the series soon, but I wanted to respond to the commentary on 
the general concept.

We're not pretending anything; remote has confirmed that the head that the 
ref tracks has a particular new value (which we provided), so we should be 
able to update the tracking ref to that value. I don't think it's 
particularly important that we came by this information in the course of 
an exchange that wasn't a fetch.

	-Daniel
*This .sig left intentionally blank*
