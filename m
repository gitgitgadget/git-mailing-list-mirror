From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
	the git configuration
Date: Tue, 3 Feb 2009 17:01:16 -0800
Message-ID: <20090204010116.GB23383@spearce.org>
References: <1233695594.8042.6.camel@localhost> <20090203231357.GZ26880@spearce.org> <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de> <200902040155.15206.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 02:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUWAP-0001FY-Oa
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 02:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZBDBBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbZBDBBS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 20:01:18 -0500
Received: from george.spearce.org ([209.20.77.23]:34397 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZBDBBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 20:01:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 59E9B38210; Wed,  4 Feb 2009 01:01:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902040155.15206.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108283>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 04 februari 2009 00:20:03 skrev Johannes Schindelin:
> > According to
> > 
> > http://java.sun.com/j2se/1.4.2/docs/api/java/lang/System.html#getenv(java.lang.String)
> > 
> > getenv() is deprecated.  However, in later editions (Java5 and later, to 
> > be precise), that deprecation seems to be lifted...
> 
> It was worse, it wasn't even implemented. You got a runtime exception back then (1.3 or 1.4).
> So now it's fine.

FWIW, it worked in 1.3 and returned correct data on platforms that
had a notion of "environment" (POSIX, Windows, not Mac OS 9).  It
was only 1.4 that threw a RuntimeException.

That was a HUGE mistake on the Sun developer's part.  IMHO,
1.4 should have always returned NULL instead of throwing
RuntimeException.  Most applications had ways to work around
not getting a particular value from the environment, e.g. if the
end-user didn't set something.  But they weren't prepared to handle
a new class of RuntimeException coming out of a method in System.

-- 
Shawn.
