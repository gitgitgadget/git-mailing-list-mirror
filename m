From: Nicolas Pitre <nico@cam.org>
Subject: Re: bug with gitweb on kernel.org
Date: Sun, 22 Apr 2007 21:16:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704222112040.28339@xanadu.home>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
 <1177286943.24896.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 03:16:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfnAg-00060L-OB
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 03:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbXDWBQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 21:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbXDWBQr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 21:16:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63689 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342AbXDWBQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 21:16:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGX00HC4FJXE570@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Apr 2007 21:16:46 -0400 (EDT)
In-reply-to: <1177286943.24896.14.camel@localhost.localdomain>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45295>

On Sun, 22 Apr 2007, J.H. wrote:

> On Thu, 2007-04-19 at 23:02 -0400, Nicolas Pitre wrote:
> > Almost 2 months ago we discussed about gitweb not properly detecting the 
> > client's ability to deal with application/xhtml+xml, something to do 
> > with the caching of a previous request from a client which did support 
> > it and serving the same content to a subsequent client which does not.
> 
> I apparently missed that entire conversation, my apologies.
> 
> > 
> > Right now www.kernel.org/git is unusable for me with lynx as it keeps 
> > prompting:
> > 
> > 	application/xhtml+xml  D)ownload, or C)ancel
> > 
> > Is there any plan to have that fixed?
> > 
> 
> Well there are a couple of quick thoughts, so far (in my quick testing)
> lynx and IE are the only two browsers that have issues with this
> particular bit of code.  Links, konqueror, safari, firefox, mozilla, etc
> all seem to handle the pages without issue.

No.  You also missed that links, elinks, and the emacs one (w3m or the 
like) were also reported to fail.  And sometimes lynx even works.

>  Taking a quick glance at the code it seems IE claims to be xhtml+xml 
> compliant but apparently isn't really (any real surprise?) and lynx 
> just doesn't seem to support that mime type.

Lynx and many others.  It is just a question of luch whether the served 
page is acceptable or not.

> The simplest fix would be to eliminate the distinction between
> applicatoin/xhtml+xml and application/html in the gitweb code (or at
> least in the caching gitweb code) and have everything claim a mimetype
> of application/html and let the browser sort out if it's using xhtml or
> html from the doctype.  This would solve both the problem your seeing on
> lynx and would make the caching gitweb usable by more IE users.

Great.


Nicolas
