From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Thu, 15 Sep 2005 15:02:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509151458240.23242@iabervon.org>
References: <20050914124206.GC24405@master.mivlgu.local>
 <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509141641290.23242@iabervon.org> <Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509141722500.23242@iabervon.org> <7vk6hjfh9u.fsf@assigned-by-dhcp.cox.net>
 <pan.2005.09.15.10.34.59.363606@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 21:01:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFywe-00058Z-UF
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVIOS6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 14:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVIOS6u
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:58:50 -0400
Received: from iabervon.org ([66.92.72.58]:14097 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932217AbVIOS6u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 14:58:50 -0400
Received: (qmail 14829 invoked by uid 1000); 15 Sep 2005 15:02:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Sep 2005 15:02:59 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.15.10.34.59.363606@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8625>

On Thu, 15 Sep 2005, Matthias Urlichs wrote:

> Hi, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >> Oh, right. Yeah, that's the obvious solution. I'll do that tonight.
> > 
> > Thanks.  In the meantime I have Sergey's patch in the "pu"
> > branch but we can replace it with your fix.
> 
> Personally I'd rather combine the two. The point being, broken
> repositories do happen -- for instance, when the file system is
> inconsistent after a crash, or when the referent of an info/alternates
> directory vanishes. :-/
> 
> I'd rather have a simple repair flag than do a "download everything again
> and then throw most of it away" job when something like that happens.

Agreed; but we want a new patch for --recover, because with the new code, 
the easy way is to skip the for_each_ref call, at which point it will just 
not assume you have anything.

	-Daniel
*This .sig left intentionally blank*
