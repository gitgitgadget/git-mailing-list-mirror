From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] prune-packed: new option --min-age=N
Date: Thu, 18 Jan 2007 18:42:44 +0100
Message-ID: <20070118174244.GA14287@moooo.ath.cx>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 18 18:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7bHr-0005Se-Kb
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 18:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXARRmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 12:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbXARRmx
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 12:42:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:42413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752081AbXARRmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 12:42:52 -0500
Received: (qmail invoked by alias); 18 Jan 2007 17:42:49 -0000
Received: from pD9EBA48D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.164.141]
  by mail.gmx.net (mp044) with SMTP; 18 Jan 2007 18:42:49 +0100
X-Authenticated: #5358227
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070118172408.GG15428@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37127>

Shawn O. Pearce <spearce@spearce.org> wrote:
> Matthias Lederhofer <matled@gmx.net> wrote:
> > This option allows to remove the unpacked version of an object only if
> > it has been packed for a minimum time.  It is intended to work around
> > the problem of freshly packed objects which should not be deleted
> > because someone might still try to open the unpacked version.
> 
> Are we not rescanning for new packs if we fail to find an
> object in the object directory?  I thought we were doing this in
> read_sha1_file.  *looks at code* Indeed, we are...
> 
> Is this somehow not working?
I just remembered people were warning about automatic prune-packed
(e.g. cron), so this patch does not make much sense anymore.

Any comments about adding such an option to git prune for unpacked
objects?  This would allow to run git prune automatically on
repositories while new objects are created.
