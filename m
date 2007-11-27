From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:20:13 -0500
Message-ID: <20071127012013.GG14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwp7u-0007dw-94
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbXK0BUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbXK0BUT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:20:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42099 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbXK0BUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:20:17 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iwp7N-0007HN-3g; Mon, 26 Nov 2007 20:20:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1B1A20FBAE; Mon, 26 Nov 2007 20:20:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66151>

Marco Costalba <mcostalba@gmail.com> wrote:
> On Nov 26, 2007 5:46 PM, Andy Parkins <andyparkins@gmail.com> wrote:
> > Jakub Narebski wrote:
> >
> > > If you would write git from scratch now, from the beginning, without
> > > concerns for backwards compatibility, what would you change, or what
> > > would you want to have changed?
> >
> >  - "git-gui" would be written in Qt (ducks)
> 
> But...wait...Qt would require...(I'm scared to say!)... that awful,
> painful, hopeless thing called C++. Probably you didn't mean what you
> said ;-)

Heh.

I'll never port git-gui to Qt.  Because of that awful, painful
thing called C++ that it uses.  I despise C++.  No, please don't
start a C++ language war again on the list.  :-)


I recently considered porting git-gui to XUL, as nobody has ever
said "Firefox isn't native enough on my OS!".  It also (maybe) has
the benefit of having a large developer base (everyone and their
dog has coded in HTML and Javascript before, except maybe Linus).

But XUL doesn't support launching a process and connecting pipes
to its stdin and stdout.  I started to try and create an XPCOM
extension to provide that functionality from NSPR and started to
run into major problems compiling the XPCOM plugin, getting the
necessary interfaces implemented, etc.

In the end I was able to recreate the bulk of the main git-gui UI in
XUL in just an hour or so, but spent days trying to just do a basic
thing like "git diff-index --cached -z HEAD" and consume the result.
I never even got that to work so I just gave up on the idea.


So git-gui is in Tcl/Tk for the long-term.  However I'm going
to try and port git-gui over to the Tcl/Tk 8.5 "tiles" extension
(if it is available on your system) so we can get better looking
native widgets.  I'll still fall back to the old style widgets for
Tcl/Tk 8.4 so existing users aren't forced to upgrade to 8.5 just
to use the latest git-gui.  (But really, 8.5 isn't that hard to
build and install...)

-- 
Shawn.
