From: David Fries <david@fries.net>
Subject: Re: [PATCH] gitk: improve dark background support
Date: Wed, 10 Nov 2010 22:59:18 -0600
Message-ID: <20101111045918.GA7572@spacedout.fries.net>
References: <20101104003524.GI7835@spacedout.fries.net>
 <20101108131412.GE22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 05:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGPG2-0001r3-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 05:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0KKE72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 23:59:28 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:34466 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab0KKE72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 23:59:28 -0500
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAB4xJCt006924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Nov 2010 22:59:19 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAB4xIED006923;
	Wed, 10 Nov 2010 22:59:18 -0600
Content-Disposition: inline
In-Reply-To: <20101108131412.GE22067@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 10 Nov 2010 22:59:19 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161207>

On Mon, Nov 08, 2010 at 02:14:12PM +0100, Matthijs Kooijman wrote:
> Hi David,
> 
> I've been using gitk with a gray-on-black color-scheme for a while now,
> so I've given your patch a test drive. It seems to work as expected and
> indeed makes gitk a bit more pleasant to use with a dark color scheme.
> 
> I've reviewed the code a bit and it looks ok as well (though I'm hardly
> familiar with git internals, and not at all in this area).
> 
> I did encounter one minor issue, though: If you change the foreground
> color, the current view is not updated until you restart or switch views
> (or otherwise trigger a redraw, I guess). A quick look at the code shows
> that the "setfg" function contains some code that updates all canvases
> and all contexts in $fglist with the new fg color. I guess that
> something similar should be done for these tag colors to get them
> updated right away (though perhaps that should be a second patch)?

After much work and document searching I now know more about tk/tcl
than ever before and have figured out how to make the colors
dynamically update when the preferences change.  Have a look if you
will, and if it looks good I'll post it to the maintainer for
inclusion.  I'm also posting a new patch series to the list.

branch gitk_colors
git://gitorious.org/~dfries/git/dfriess-git-mainline.git

and the more disorganized work in progress branch is gitk_colors_PreSquash



> A final note: There are still some other problems with working with
> grey-on-black color scheme. In case your interested in working on those,
> I've listed them at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=568470

Anything left in that list worth going over?  In terms of the .gitk
config colors what are you using and what isn't working?

my relevant .gitk config file settings,
set mainfont {Helvetica 8}
set textfont {Courier 8}
set uifont {Helvetica 9 bold}
set uicolor grey85
set bgcolor black
set fgcolor white
set colors {green red blue magenta darkgrey brown orange}
set diffcolors {red green cyan}
set markbgcolor #404060
set selectbgcolor gray50

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)
