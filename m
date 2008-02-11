From: Seth Falcon <seth@userprimary.net>
Subject: Re: Trouble with gitk and ActiveState tcltk on OS X
Date: Mon, 11 Feb 2008 07:51:35 -0800
Message-ID: <m2zlu71ofs.fsf@userprimary.net>
References: <m2ve4wh5sx.fsf@ziti.evri.corp>
	<20080211044941.GX24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 16:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOaxx-0000Tt-Uh
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYBKPwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 10:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYBKPwb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:52:31 -0500
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:48068 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893AbYBKPwa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 10:52:30 -0500
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id oELo1Y06J0QkzPwAA03800; Mon, 11 Feb 2008 15:51:54 +0000
Received: from ziti ([24.19.171.108])
	by OMTA02.emeryville.ca.mail.comcast.net with comcast
	id oFsQ1Y0052LgWns8N00000; Mon, 11 Feb 2008 15:52:25 +0000
X-Authority-Analysis: v=1.0 c=1 a=XayAI9YopGsA:10 a=Z4mJgif-AAAA:8
 a=XJjlb5ID-9CXZkCH3JEA:9 a=BrH0L-wRwK9wTzwgEbsA:7
 a=km4OYawVLkxbAJMlcbmaXU5NXv4A:4 a=R0wQ3QzoQ0IA:10 a=F-J2dRE9H3gA:10
 a=shE9WCRXG_MA:10
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.90 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73542>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> For what its worth I use the native Tcl/Tk that ships with Mac OS X,
> /usr/bin/wish, which is really in /Library/Frameworks/Tk.framework.
> I've never used the ActiveState Tcl/Tk package on Mac OS X.
>
> git-gui builds against the Tk.framework I mentioned above when on
> Mac OS X.  In particular the git-gui Makefile seems to ignore the
> setting of TCLTK_PATH when it sees the above mentioned Tk.framework
> is available in your filesystem.
>
> The reason why you get nice icons for git-gui is because we use a
> feature of the Aqua port Tcl/Tk framework that allows us to create a
> full Mac OS X app by copying a tiny executable from the framework,
> and supplying our own resource bundle.  The bundle configures
> the icon.  Its the only way to get a custom icon on Mac OS X.
>
> Launching gitk from within git-gui (Repository -> Visualize History)
> uses the same app and bundle, so gitk inherits the icon too.
> I'd also bet gitk works this way, because it isn't launching through
> the ActiveState Tcl/Tk port.
>
> In short, why not just use the native Aqua Tcl/Tk that Apple ships?
> Why go through X11 and MacPorts?

Hmm.  I don't doubt that I've inadvertently made things harder than
they need to be, but...

I've just tried uninstalling the ActiveState stuff and removing the
MacPorts stuff.

Indeed git gui runs, but I no longer get the nice icon (instead a
default Tcl/Tk icon with a feather).  Launching gitk from the git gui
menu results in the same behavior for me: it launches and its menu
appears, but no window.  It is quite odd because I can open the
preference window for gitk via the menu and _that_ mini window does
appear.  Same thing if I launch gitk from the command line.

If I try to open the "Git Gui.app" I get:
ziti:git-gui seth$ open Git\ Gui.app/
LSOpenFromURLSpec() failed with error -10810 for the file /Users/seth/src/git-MASTER/git-gui/Git Gui.app.

I've recently upgraded my system to Leopard, so I wouldn't be
surprised if that is related to some of these issues.

Is there a big difference between how git gui uses Tcl/Tk and gitk?
It seems really odd to me that one works and the other not so much :-\

Any other things to try or suggestions of where to look for root
causes?

Thanks again,

+ seth


-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
