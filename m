From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 21:20:35 +0200
Message-ID: <20070415192035.GA21934@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org> <20070415190119.GA21786@uranus.ravnborg.org> <Pine.LNX.4.64.0704151204320.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdAGN-0006dg-7Q
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbXDOTTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbXDOTTr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:19:47 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:45769 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377AbXDOTTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:19:46 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 7C58EE30871;
	Sun, 15 Apr 2007 21:19:45 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 58E8F580D2; Sun, 15 Apr 2007 21:20:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704151204320.5473@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44506>

On Sun, Apr 15, 2007 at 12:05:44PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 15 Apr 2007, Sam Ravnborg wrote:
> 
> > >  
> > > +static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
> > > +{
> > > +	int len;
> > > +	char *data = xmalloc(100);
> > > +	len = snprintf(data, 100,
> > > +		"Subproject commit %s\n", sha1_to_hex(s->sha1));
> > 
> > In userland I would use a local variable for an array of the size of 100.
> > I would normally only allocate when we are say 5x bigger.
> 
> We're _returning_ the pointer to the caller, so no, we cannot use an 
> automatic array.
Do not know how I missed that...
Thanks,
	Sam
