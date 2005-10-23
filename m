From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: git and gitweb inconsistencies
Date: Sun, 23 Oct 2005 20:28:01 +0200
Message-ID: <20051023182800.GH8383MdfPADPa@greensroom.kotnet.org>
References: <20051023001412.GA22679@pe.Belkin>
 <20051023115939.GG8383MdfPADPa@greensroom.kotnet.org>
 <20051023173055.GA3019@pe.Belkin>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Sun Oct 23 20:28:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETkZt-00016E-Hn
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVJWS2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 14:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJWS2F
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 14:28:05 -0400
Received: from smtp14.wxs.nl ([195.121.6.28]:14268 "EHLO smtp14.wxs.nl")
	by vger.kernel.org with ESMTP id S1750794AbVJWS2E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 14:28:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IOT00550SMPL0@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 23 Oct 2005 20:28:01 +0200 (CEST)
Received: (qmail 23829 invoked by uid 500); Sun, 23 Oct 2005 18:28:01 +0000
In-reply-to: <20051023173055.GA3019@pe.Belkin>
To: Chris Shoemaker <c.shoemaker@cox.net>
Mail-followup-to: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
 Matthias Urlichs <smurf@smurf.noris.de>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10495>

On Sun, Oct 23, 2005 at 01:30:55PM -0400, Chris Shoemaker wrote:
> I foolishly assumed that the second time I ran git-cvsimport, with -C
> /pub/scm/project/ it would be able to detect that I was using the
> stand-alone GIT-DIR.  But, it obviously didn't.  I guess the solution
> is use specify GIT_DIR everytime I run git-cvstimport.

Since many of the core git tools try to detect the actual git dir,
it might not be a bad idea for cvsimport to do this as well.
It probably also shouldn't create a new git repository if the -i
option has been specified.

> So, it seems that git-web.cgi detects and prefers the stand-alone
> directory structure, because I specify it in the projects_list file,
> while git-cat-file, and git-update-ref default to using .git.

gitweb just sets GIT_DIR and then the core git tools won't guess.

skimo
