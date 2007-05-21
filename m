From: Petr Baudis <pasky@suse.cz>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 14:09:20 +0200
Message-ID: <20070521120920.GF4489@pasky.or.cz>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <46502EF7.6000708@lsrfire.ath.cx> <20070521060231.GI3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 14:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq6hZ-0008Bf-FZ
	for gcvg-git@gmane.org; Mon, 21 May 2007 14:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbXEUMJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 08:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbXEUMJX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 08:09:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43615 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888AbXEUMJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 08:09:22 -0400
Received: (qmail 5841 invoked by uid 2001); 21 May 2007 14:09:20 +0200
Content-Disposition: inline
In-Reply-To: <20070521060231.GI3141@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48013>

On Mon, May 21, 2007 at 08:02:32AM CEST, Shawn O. Pearce wrote:
> Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> > Shawn O. Pearce schrieb:
> > > 
> > > git-describe is more human-friendly than a SHA-1...
> > 
> > Yes, and the Makefile does even more than that: it adds a version file,
> > a spec file and another version file for git-gui.
> > 
> > The first two are probably useful for most projects that actually do
> > versioned releases.  We could have a simple parser that reads a
> > template, replaces @@VERSION@@ with a git-describe output string and
> > adds the result as a synthetic file to the archive.  It's not exactly
> > trivial -- e.g., how to specify git-describe options, template file and
> > synthetic name, all in one command line parameter? -- but it's doable.
> 
> Maybe something just as simple as allowing the user to specify a
> shell script in-tree that we unpack and run for them?  That script
> prints to stdout the content of the file to include.

Specify how? At the point of git-archive execution? At that point you
usually can append the file to the archive as well.

And if you make it somehow a "project default", that becomes a huge
security risk, since anyone who clones the project and runs git-archive
will execute aribtrary code on his account.

Besides, the original motivation for this were snapshots from gitweb.
Gitweb frequently does not run with the uid of the project owner, so
this becomes a security problem as well.

Maybe some kind of format-string in .git/config...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
