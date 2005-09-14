From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 16:55:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141641290.23242@iabervon.org>
References: <20050914124206.GC24405@master.mivlgu.local>
 <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sergey Vlasov <vsu@altlinux.ru>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:54:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFeEK-00067Y-EO
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVINUvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVINUvm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:51:42 -0400
Received: from iabervon.org ([66.92.72.58]:6408 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932586AbVINUvl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:51:41 -0400
Received: (qmail 8304 invoked by uid 1000); 14 Sep 2005 16:55:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 16:55:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8564>

On Wed, 14 Sep 2005, Linus Torvalds wrote:

> On Wed, 14 Sep 2005, Junio C Hamano wrote:
> > 
> > Thanks for the patch.
> 
> This is wrong.
> 
> Any "fetch" logic that writes the refs before all the objects are gathered 
> is _buggy_. It's not about "recovery", it should never do that in the 
> first place.

It's not about the refs at all. The issue is that, when it reaches a 
commit that we already have, it assumes that we have everything that 
commit references and stops there. It really ought to not do that, but I 
think it might be too slow if it goes through everything all the time. We 
probably want to keep a cache listing some commits we have, and use that.

	-Daniel
*This .sig left intentionally blank*
