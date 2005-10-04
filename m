From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 12:41:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510041213460.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain>
 <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 18:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMpmS-0006QY-0R
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 18:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVJDQgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJDQgg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 12:36:36 -0400
Received: from iabervon.org ([66.92.72.58]:46344 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964812AbVJDQgg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 12:36:36 -0400
Received: (qmail 1870 invoked by uid 1000); 4 Oct 2005 12:41:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Oct 2005 12:41:18 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9683>

On Tue, 4 Oct 2005, Matthias Urlichs wrote:

> Hi, Daniel Barkalow wrote:
> 
> > I'd guess that UNIX sockets have a
> > similar capacity (although I'm not going to look it up tonight).
> 
> You can set TCP options to change the buffer sizes.
> 
> I would however assume that *nobody* sets both the send and receive
> buffers such that their cumulative size is <4k, so 99 object IDs
> at 41 bytes definitely should be OK.

I actually mean UNIX (a.k.a. PF_LOCAL) sockets; git-ssh-fetch is connected 
to ssh via sockets from "socketpair()". Looks like you can set the buffer 
size with a socket option here, too, but I doubt ssh will try setting 
socket options on standard in and out, and git-ssh-fetch leaves them at 
their defaults. I'm not clear where the defaults for these come from in 
general.

	-Daniel
*This .sig left intentionally blank*
