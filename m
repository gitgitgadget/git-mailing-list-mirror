From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 14:15:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711201401090.32410@iabervon.org>
References: <20071120155922.GA6271@pvv.org> <Pine.LNX.4.64.0711201226320.32410@iabervon.org>
 <1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com> <87ir3wzqzj.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYai-0005gV-Cz
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 20:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762314AbXKTTPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761382AbXKTTPq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 14:15:46 -0500
Received: from iabervon.org ([66.92.72.58]:60978 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762305AbXKTTPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 14:15:45 -0500
Received: (qmail 11775 invoked by uid 1000); 20 Nov 2007 19:15:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 19:15:43 -0000
In-Reply-To: <87ir3wzqzj.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65569>

On Tue, 20 Nov 2007, Sergei Organov wrote:

> I got the same impression, and then I wonder if the next logical thing
> the OP will need is, say, support for content moves between
> submodules. Somehow I doubt git will ever support that.

I don't see why not. If you tell the diff engine to look for content 
moves, and you tell it to descend into submodules that you have, and you 
have both ends of the content move, and you're looking at a supermodule 
commit where such a content move happened, it should show it.

If any of these aren't true (and I don't think we have a "descend into 
available submodules" option currently), you won't see it as a content 
move, but you wouldn't expect to; you don't want to get a diff that says: 
"move from (path you don't have) to (path you have)", with the diff 
showing changes in the process, when you didn't have the original.

	-Daniel
*This .sig left intentionally blank*
