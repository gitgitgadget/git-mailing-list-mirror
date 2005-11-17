From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Fri, 18 Nov 2005 00:41:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180039270.18775@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
 <200511171644.48438.Josef.Weidendorfer@gmx.de> <7v7jb7uler.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511171131260.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 00:42:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EctNf-000344-08
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKQXlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKQXlX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:41:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4570 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932401AbVKQXlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:41:22 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8CA9913FDB2; Fri, 18 Nov 2005 00:41:21 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 729659F34A; Fri, 18 Nov 2005 00:41:21 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5E10598FA6; Fri, 18 Nov 2005 00:41:21 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4DEA013FDB2; Fri, 18 Nov 2005 00:41:21 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511171131260.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12178>

Hi,

On Thu, 17 Nov 2005, Linus Torvalds wrote:

> On Thu, 17 Nov 2005, Junio C Hamano wrote:
> > 
> >  - We want repository-format-version but that may be too
> >    long. Just saying version is a bit confusing.  Abbreviating
> >    it to repository-version makes it sound as if somebody took a
> >    snapshot (i.e. tar-tree $commit).  Whatever name we choose,
> >    let's pick a one not so confusing.
> 
> My one argument against this is that I don't see why we have to have a 
> separate file for this.
> 
> Why not just add a "core.version" flag to the config file? If no version 
> exists, assume it's version 1. And then, if we ever start using some other 
> version, make git-init-db always create the config file (the way we 
> already do for "core.filemode")

Note that git-sh-setup and setup_git_directory() should check for it and 
complain if it finds a value > 1. Else there is not much which prevents 
old tools (like current) to access future versions.

The actual number may come later. The check can't.

Ciao,
Dscho
