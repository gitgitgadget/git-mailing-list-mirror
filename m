From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 22:10:51 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806182202030.19665@iabervon.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
 <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org> <20080619000842.GA25117@sigill.intra.peff.net> <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806181726550.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 04:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K99dM-0003V6-O5
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 04:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYFSCKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 22:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYFSCKx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 22:10:53 -0400
Received: from iabervon.org ([66.92.72.58]:43474 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYFSCKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 22:10:53 -0400
Received: (qmail 10435 invoked by uid 1000); 19 Jun 2008 02:10:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 02:10:51 -0000
In-Reply-To: <alpine.LFD.1.10.0806181726550.2907@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85442>

On Wed, 18 Jun 2008, Linus Torvalds wrote:

> On Wed, 18 Jun 2008, Linus Torvalds wrote:
> > 
> > Nobody should ever use "git-config" normally. You should fire up your 
> > editor and just edit the damn file in place. But no, we don't have a 
> > man-page for that.
> 
> Btw, one reason people end up talking about git-config is that it's easier 
> to tell *other* people to "run this command" than it is to tell them to 
> "edit this file so it looks like <xyz>".

The other factor is that you sometimes want to tell somebody one option 
setting, and you're using a medium where there's a comprehension cost to 
newlines. So 'remote.origin.url blah' is more clear than '[remote 
"origin"]
	url = blah' in those contexts. And we don't seem to encourage 
'[remote origin] url = blah', even though it turns out to work fine (at 
least, I didn't know until I just now tried it that I could suggest it).

	-Daniel
*This .sig left intentionally blank*
