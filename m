From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Gitweb and submodules
Date: Sun, 29 Jul 2007 18:37:47 +0200
Message-ID: <20070729163747.GJ31114MdfPADPa@greensroom.kotnet.org>
References: <200707271322.50114.jnareb@gmail.com>
 <200707281229.17351.jnareb@gmail.com>
 <20070728104054.GI31114MdfPADPa@greensroom.kotnet.org>
 <200707282239.29340.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 18:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFBmF-0000im-5t
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 18:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763122AbXG2Qht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 12:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763385AbXG2Qht
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 12:37:49 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:34990 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762561AbXG2Qhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 12:37:48 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLY00LTM8UZAO@psmtp12.wxs.nl> for git@vger.kernel.org; Sun,
 29 Jul 2007 18:37:47 +0200 (MEST)
Received: (qmail 9477 invoked by uid 500); Sun, 29 Jul 2007 16:37:47 +0000
In-reply-to: <200707282239.29340.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54122>

On Sat, Jul 28, 2007 at 10:39:28PM +0200, Jakub Narebski wrote:
> On Sat, 28 July 2007, Sven Verdoolaege wrote:
> > On Sat, Jul 28, 2007 at 12:29:16PM +0200, Jakub Narebski wrote:
> >> It has to be configuration variable because the 
> >> location of repository which has submodule objects doesn't change when 
> >> checking out (or rewinding) to different commit in supermodule.
> > 
> > Let's hope Pasky provides a way to set this information...
> 
> Why Pasky?

I was thinking about projects on repo.or.cz.
We'd want to have a way to specify the locations of submodules.

> I am thinking about the following sequence to search for submodule
> objects:
> 
> From $GIT_DIR/config:
>   submodule.$name.objects (absolute or relative to gitdir of superproject)
>   submodule.$name.gitdir  (absolute or relative to gitdir of superproject)

Do we really need both of these?

>   submodule.$name.url     (to find GIT_DIR, if it is local filesystem URL)
> 
> If there is working directory, from .gitmodules file in top level
> of working directory:
>   submodule.$name.path/.git (relative to toplevel of working directory)

Having a relative path for the URL in .gitmodules in a public repo
doesn't seem very useful to me.  I know it's only meant as a default
value, but if it is a relative path, then it won't work for
anyone cloning the superproject.

skimo
