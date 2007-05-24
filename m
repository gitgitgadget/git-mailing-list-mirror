From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:55:20 +0200
Message-ID: <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 24 19:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHX4-0007PR-2E
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXEXRzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbXEXRzX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:55:23 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:59756 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbXEXRzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:55:22 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIK00BHO4G8L6@smtp13.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 19:55:21 +0200 (CEST)
Received: (qmail 6445 invoked by uid 500); Thu, 24 May 2007 17:55:20 +0000
In-reply-to: <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48283>

On Thu, May 24, 2007 at 10:40:52AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 24 May 2007, Junio C Hamano wrote:
> > 
> > Why does this have to be out-of-tree and unversioned to begin
> > with?
> 
> I _really_ think that the right approach is to
> 
>  - have the submodules information under version control (and I'd 
>    personally call it the ".gitmodules" file, but whatever)
> 
>    This gives you the defaults, and the ability to change them. Remember: 
>    if you get some "config" information at "git clone" time, you're 
>    *screwed* if the thing ever changes!

If you allow an override, then I don't see how having the initial
information in the tree is any better.
When new information gets in from the tree, you're going to ignore it anyway.

What happens if the URL changes?
You have to modify .gitmodules in _every_ branch you have?

What if someone is working on his own branch of the superproject
that needs some changes in his own subproject?
He needs to modify .gitmodules, but when the changes go upstream,
this .gitmodules changes get merged as well.
Now imagine several developers doing this.
You end up continually having to modify .gitmodules.

skimo
