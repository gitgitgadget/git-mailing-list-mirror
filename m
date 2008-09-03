From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calling ssh from git-gui
Date: Wed, 3 Sep 2008 10:25:41 -0700
Message-ID: <20080903172541.GD28315@spearce.org>
References: <20080903165455.GU10544@machine.or.cz> <20080903171543.GC28315@spearce.org> <200809031922.07083.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaw80-0000xs-Mm
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYICRZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYICRZn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:25:43 -0400
Received: from george.spearce.org ([209.20.77.23]:42369 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbYICRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:25:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E24CD38375; Wed,  3 Sep 2008 17:25:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809031922.07083.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94821>

Thomas Rast <trast@student.ethz.ch> wrote:
> Shawn O. Pearce wrote:
> > Damn annoying for git-gui to be invoking a new terminal window, but
> > maybe that's what we have to do.  Be nice though if the window only
> > was opened because we couldn't do "git ls-remote url" but its hard
> > to tell "hanging because SSH needs the user" and "hanging because
> > the network is a 2400 baud modem".
> 
> You can set BatchMode (ssh_config(5)) to at least prevent it from
> hanging, can't you?

True, but this is OpenSSH specific, and has to be done on the
command line, which git-gui has no control over.

Maybe git fetch and push can check for a tty on fd 0 and enable
try to enable batch mode if fd 0 isn't a tty?

-- 
Shawn.
