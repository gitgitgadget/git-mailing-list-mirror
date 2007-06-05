From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Improved git-gui blame viewer
Date: Tue, 5 Jun 2007 00:28:55 -0400
Message-ID: <20070605042855.GA9513@spearce.org>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org> <4664838C.8000109@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Melchior <mmelchior@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:29:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQfJ-00025l-Pt
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbXFEE3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXFEE3A
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:29:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55075 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbXFEE27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:28:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HvQfB-0004dQ-9x; Tue, 05 Jun 2007 00:28:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9275120FBAE; Tue,  5 Jun 2007 00:28:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4664838C.8000109@xs4all.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49157>

Matthijs Melchior <mmelchior@xs4all.nl> wrote:
> Shawn O. Pearce wrote:
> > I'm not sure I understand what you are looking for here.  Right now
> > git-gui should be inverting the foreground/background colors on
> > the file that is "selected" (shown in the lower diff view pane).
> > So the background should be black, and the foreground white.
> > Is this not happening?  Or are you looking for something else?
> > 
> 
> No, I am not looking for something else...., the inverting you describe
> does not happen on my machine....

I'm wrong.  Its not inverting.  Its bold if its selected, and normal
if its not selected.  Perhaps your font is already a bold weight
so you aren't seeing a difference between the selected item and
the non-selected items.
 
> I am now running Debian git-core 1.5.2.1-1 with 'make install' done
> in the origin/pu branch of git-gui.
> 'About git-gui' now says:
> 	git-gui version 0.7.2.58-gf9e9
> 	git version 1.5.2.1
> 	Tcl/Tk version 8.4.12
> 
> If you explain where this inverting is taking place, I can do some
> experiments to find out more [use gray background i.s.o. inverting...]
> Maybe it has something to do with Desktop themes, I use the standard
> Gnome theme.

Around line 1803 of git-gui.sh we setup the in_diff tag for the
$ui_index and $ui_workdir Tk widgets.  That tag is applied to the
file that is in the diff viewer.  Perhaps adding a background to
the tag would get you an improved interface?

-- 
Shawn.
