From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: quieter installs
Date: Sun, 3 Jun 2007 02:00:58 -0400
Message-ID: <20070603060058.GC4507@spearce.org>
References: <20070603010044.GA4507@spearce.org> <7vfy59oa71.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 08:01:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huj9L-0004BU-Jf
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 08:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbXFCGBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 02:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbXFCGBG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 02:01:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36642 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbXFCGBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 02:01:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Huj9A-0004jw-00; Sun, 03 Jun 2007 02:01:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2937A20FBAE; Sun,  3 Jun 2007 02:00:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vfy59oa71.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48976>

Junio C Hamano <junkio@cox.net> wrote:
> Good job.  I actually almost like it.

Heh.  Thanks.  I almost like it to.  I like what it does for the
non-V=1 formatting, as I think its easier to read the installation
process.  But I really don't like that install target.  The problem
of course is there's no $@ that I can depend on in the install rules,
and the rules for the builtins (rm -f && ln) is very very messy.
 
> Without V=1, I get this from 'pu' that merged your 'pu'.
> 
>     ...
>     make -C git-gui install
>     make[1]: Entering directory `/git/git.git/git-gui'
>       DEST /home/junio/git-pu/bin
>         INSTALL 755 git-gui
>         LINK        git-citool -> git-gui
>       DEST /home/junio/git-pu/share//git-gui/lib
>         INSTALL 644 tclIndex
>         INSTALL 644 blame.tcl
>         INSTALL 644 branch.tcl
>         INSTALL 644 branch_rename.tcl
>         INSTALL 644 browser.tcl
>     ...

Right.  I wanted to try and keep the lines very simple, like we
have with our CC/GEN/BUILTIN lines.  But I also wanted to be clear
about which directories we are dropping stuff into.

> And with V=1, what I see seem very readable.

Right.  My target there was that the V=1 case was *exactly*
what I had before.  Because a simple installation with no pretty
formatting should be exactly that; a simple installation with no
pretty formatting.

-- 
Shawn.
