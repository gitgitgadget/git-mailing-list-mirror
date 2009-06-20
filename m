From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/6] Add remote.name.timeout to configure an IO
	timeout
Date: Sat, 20 Jun 2009 15:54:04 -0700
Message-ID: <20090620225404.GT11191@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org> <1245446875-31102-2-git-send-email-spearce@spearce.org> <1245446875-31102-3-git-send-email-spearce@spearce.org> <200906210028.48954.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 00:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI9Rv-0006ss-Uf
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 00:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZFTWyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbZFTWyC
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 18:54:02 -0400
Received: from george.spearce.org ([209.20.77.23]:36822 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbZFTWyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 18:54:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8066E381FD; Sat, 20 Jun 2009 22:54:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906210028.48954.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121957>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> fredag 19 juni 2009 23:27:51 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > An IO timeout can be useful if the remote peer stops responding,
> > and the user wants the application to abort rather than block
> > indefinitely waiting for more input.
> > 
> > This is a JGit specific extension to the standard remote format.
> 
> Can we we assume C Git won't implement the same thing with a different 
> parameter name, or worse, the same name, but a different unit?

No, we can't assume anything.

I probably should add this to C Git too.  I think its the logical
name and units, e.g `git daemon --timeout=` already exists and
takes seconds as the unit.

I wrote this series because I have a case where the remote server
is sometimes not sending packets out... and the client just blocks.
git fetch has the same issue.  Doing git fetch or jgit fetch from
a cron against this server causes the fetch processes to just pile
up indefiniately.  :-(

-- 
Shawn.
