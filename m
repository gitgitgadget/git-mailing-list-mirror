From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 17:24:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141722500.23242@iabervon.org>
References: <20050914124206.GC24405@master.mivlgu.local>
 <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509141641290.23242@iabervon.org> <Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sergey Vlasov <vsu@altlinux.ru>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 23:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFeft-0005NE-5c
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 23:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbVINVUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 17:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVINVUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 17:20:09 -0400
Received: from iabervon.org ([66.92.72.58]:28947 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932770AbVINVUH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 17:20:07 -0400
Received: (qmail 8492 invoked by uid 1000); 14 Sep 2005 17:24:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 17:24:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8567>

On Wed, 14 Sep 2005, Linus Torvalds wrote:

> On Wed, 14 Sep 2005, Daniel Barkalow wrote:
> > 
> > It's not about the refs at all. The issue is that, when it reaches a 
> > commit that we already have, it assumes that we have everything that 
> > commit references and stops there. It really ought to not do that, but I 
> > think it might be too slow if it goes through everything all the time.
> 
> No, you don't need to go through everything all the time.
> 
> Do what the pack-sending stuff does: it assumes that it has everything
> that is reachable from the _old_ refs. It doesn't walk all the way to the 
> root, it "just" walks far enough that it can ignore anything that was 
> reachable from the old refs.

Oh, right. Yeah, that's the obvious solution. I'll do that tonight.

	-Daniel
*This .sig left intentionally blank*
